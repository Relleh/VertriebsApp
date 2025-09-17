import os
import csv
import time
from typing import List, Dict, Optional
from sqlalchemy.orm import Session
from sqlalchemy import or_
from .models import Customer

CSV_PATH = os.environ.get('CUSTOMERS_CSV_PATH', '/app/data/customers.csv')
_last_loaded_mtime: float | None = None

EXPECTED_HEADERS = {'Kundennummer','Kundennumer','Kunde','Ansprechpartner','Ort'}

def _normalize_row(row: Dict[str, str]) -> Dict[str, str]:
    # Accept both 'Kundennummer' and the common misspelling 'Kundennumer'
    customer_no = row.get('Kundennummer') or row.get('Kundennumer') or ''
    return {
        'customer_no': customer_no.strip(),
        'customer_name': (row.get('Kunde') or '').strip(),
        'contact_person': (row.get('Ansprechpartner') or '').strip(),
        'place': (row.get('Ort') or '').strip(),
    }

def load_csv_into_db(db: Session) -> int:
    global _last_loaded_mtime
    if not os.path.exists(CSV_PATH):
        return 0
    mtime = os.path.getmtime(CSV_PATH)
    inserted = 0
    if _last_loaded_mtime is not None and mtime <= _last_loaded_mtime:
        return 0  # no change
    # recreate table contents
    db.query(Customer).delete()
    with open(CSV_PATH, newline='', encoding='utf-8-sig') as f:
        reader = csv.DictReader(f)
        headers = set(reader.fieldnames or [])
        missing = EXPECTED_HEADERS - headers
        if {'Kundennummer','Kundennumer'}.isdisjoint(headers):
            raise RuntimeError("CSV braucht Spalte 'Kundennummer' (alternativ 'Kundennumer'). Gefunden: %s" % headers)
        for row in reader:
            rec = _normalize_row(row)
            if not rec['customer_no'] and not rec['customer_name']:
                continue
            db.add(Customer(**rec))
            inserted += 1
    db.commit()
    _last_loaded_mtime = mtime
    return inserted

def search_customers(db: Session,
                     customer_no: Optional[str]=None,
                     customer_name: Optional[str]=None,
                     contact_person: Optional[str]=None,
                     place: Optional[str]=None,
                     limit: int = 25) -> List[Dict]:
    q = db.query(Customer)
    if customer_no:
        q = q.filter(Customer.customer_no.ilike(f"%{customer_no.strip()}%"))
    if customer_name:
        q = q.filter(Customer.customer_name.ilike(f"%{customer_name.strip()}%"))
    if contact_person:
        q = q.filter(Customer.contact_person.ilike(f"%{contact_person.strip()}%"))
    if place:
        q = q.filter(Customer.place.ilike(f"%{place.strip()}%"))
    q = q.limit(limit)
    rows = q.all()
    return [{
        'customer_no': r.customer_no,
        'customer_name': r.customer_name,
        'contact_person': r.contact_person or '',
        'place': r.place or ''
    } for r in rows]
