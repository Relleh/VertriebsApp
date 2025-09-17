import os
import csv
import time
from typing import List, Dict, Optional
from sqlalchemy.orm import Session
from sqlalchemy import or_
from .models import Customer

CSV_PATH = os.environ.get('CUSTOMERS_CSV_PATH', '/app/data/customers.csv')
_last_loaded_mtime: float | None = None

EXPECTED_HEADERS = {'Kundennummer','Kundennumer','Kunde','Kundenname','Ansprechpartner','Ort'}

def _normalize_row(row: Dict[str, str]) -> Dict[str, str]:
    # Accept both 'Kundennummer' and the common misspelling 'Kundennumer'
    customer_no = row.get('Kundennummer') or row.get('Kundennumer') or ''
    # Accept both 'Kunde' and 'Kundenname' for customer name
    customer_name = row.get('Kundenname') or row.get('Kunde') or ''
    return {
        'customer_no': customer_no.strip(),
        'customer_name': customer_name.strip(),
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
    # Try different encodings to handle various CSV formats (cp1252 first for Windows CSVs)
    encodings = ['cp1252', 'utf-8-sig', 'utf-8', 'latin-1', 'iso-8859-1']
    f = None
    for encoding in encodings:
        try:
            f = open(CSV_PATH, newline='', encoding=encoding)
            # Test if we can read the first line
            f.readline()
            f.seek(0)
            break
        except (UnicodeDecodeError, UnicodeError):
            if f:
                f.close()
            continue
    
    if f is None:
        raise RuntimeError(f"Could not decode CSV file with any of these encodings: {encodings}")
    
    with f:
        # Auto-detect delimiter (comma or semicolon)
        sample = f.read(1024)
        f.seek(0)
        delimiter = ';' if sample.count(';') > sample.count(',') else ','
        reader = csv.DictReader(f, delimiter=delimiter)
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

def get_customer_number_suggestions(db: Session, query: str, limit: int = 10) -> List[str]:
    """Get customer number suggestions for autocomplete"""
    if not query.strip():
        return []
    q = db.query(Customer.customer_no).filter(
        Customer.customer_no.ilike(f"{query.strip()}%")
    ).distinct().limit(limit)
    return [r.customer_no for r in q.all() if r.customer_no]

def get_customer_name_suggestions(db: Session, query: str, limit: int = 10) -> List[str]:
    """Get customer name suggestions with multi-word support"""
    if not query.strip():
        return []
    
    query_words = query.strip().split()
    q = db.query(Customer.customer_name).distinct()
    
    # Build query for partial word matching
    for word in query_words:
        q = q.filter(Customer.customer_name.ilike(f"%{word}%"))
    
    q = q.limit(limit)
    return [r.customer_name for r in q.all() if r.customer_name]

def get_place_suggestions(db: Session, query: str, limit: int = 10) -> List[str]:
    """Get place suggestions for autocomplete"""
    if not query.strip():
        return []
    q = db.query(Customer.place).filter(
        Customer.place.ilike(f"%{query.strip()}%")
    ).distinct().limit(limit)
    return [r.place for r in q.all() if r.place]

def find_matching_customers(db: Session, field: str, value: str, limit: int = 25) -> List[Dict]:
    """Find customers by a specific field with enhanced matching"""
    if not value.strip():
        return []
    
    q = db.query(Customer)
    
    if field == 'customer_no':
        q = q.filter(Customer.customer_no.ilike(f"%{value.strip()}%"))
    elif field == 'customer_name':
        # Multi-word search for customer names
        words = value.strip().split()
        for word in words:
            q = q.filter(Customer.customer_name.ilike(f"%{word}%"))
    elif field == 'place':
        q = q.filter(Customer.place.ilike(f"%{value.strip()}%"))
    
    q = q.limit(limit)
    rows = q.all()
    
    return [{
        'customer_no': r.customer_no,
        'customer_name': r.customer_name,
        'contact_person': r.contact_person or '',
        'place': r.place or ''
    } for r in rows]
