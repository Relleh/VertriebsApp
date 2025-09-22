import os
import csv
from typing import List, Dict, Optional
from decimal import Decimal
from sqlalchemy.orm import Session
from sqlalchemy import or_
from .models import Customer, ABCCustomer

CSV_PATH = os.environ.get('UNIFIED_CSV_PATH', '/app/data/kundenstamm_komplett.csv')
_last_loaded_mtime: float | None = None

def parse_german_decimal(value: str) -> Optional[Decimal]:
    """Convert German decimal format (1.234,56) to Decimal"""
    if not value or value.strip() == '':
        return None
    try:
        # Replace German decimal separator and remove thousand separators
        clean_value = value.strip().replace('.', '').replace(',', '.')
        return Decimal(clean_value)
    except:
        return None

def load_unified_csv_into_db(db: Session) -> tuple[int, int]:
    """Load unified customer CSV into both customers and abc_customers tables
    Returns: (customers_inserted, abc_records_inserted)"""
    global _last_loaded_mtime
    if not os.path.exists(CSV_PATH):
        print(f"[WARN] Unified CSV not found at {CSV_PATH}")
        return (0, 0)

    mtime = os.path.getmtime(CSV_PATH)
    if _last_loaded_mtime is not None and mtime <= _last_loaded_mtime:
        return (0, 0)  # no change

    # Clear both tables
    db.query(Customer).delete()
    db.query(ABCCustomer).delete()

    # Try different encodings
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
        raise RuntimeError(f"Could not decode unified CSV file with any of these encodings: {encodings}")

    customers_inserted = 0
    abc_inserted = 0

    with f:
        # Auto-detect delimiter
        sample = f.read(1024)
        f.seek(0)
        delimiter = ';' if sample.count(';') > sample.count(',') else ','

        reader = csv.DictReader(f, delimiter=delimiter)

        for row in reader:
            # Clean up field names (remove spaces)
            row = {k.strip(): v.strip() for k, v in row.items()}

            customer_no = row.get('Kundennummer', '').strip()
            if not customer_no:
                continue

            customer_name = row.get('Kundenname', '').strip()
            contact_person = row.get('Ansprechpartner', '').strip()
            place = row.get('Ort', '').strip()

            # ABC data
            abc_class = row.get('ABC_Klasse', '').strip()
            if abc_class == '-':
                abc_class = None

            # New customer flag - now "yes"/"no" instead of "Ja"/"Nein"
            is_new_str = row.get('Kennzeichen_Neukunde', '').strip().lower()
            is_new = is_new_str in ['yes', 'ja', '1', 'true']

            # Revenue data (German decimal format)
            revenue_last = parse_german_decimal(row.get('UmsatzVorjahr', ''))
            revenue_current = parse_german_decimal(row.get('UmsatzAktJAhr', ''))

            # Insert into customers table
            db.add(Customer(
                customer_no=customer_no,
                customer_name=customer_name,
                contact_person=contact_person,
                place=place,
                abc_classification=abc_class,
                is_new_customer=is_new,
                revenue_last_year=revenue_last,
                revenue_current_year=revenue_current
            ))
            customers_inserted += 1

            # Also maintain abc_customers table for backward compatibility
            # (can be removed later if not needed)
            db.add(ABCCustomer(
                customer_no=customer_no,
                abc_classification=abc_class,
                is_new_customer=is_new
            ))
            abc_inserted += 1

    db.commit()
    _last_loaded_mtime = mtime
    print(f"[INFO] Loaded {customers_inserted} customers from unified CSV")
    return (customers_inserted, abc_inserted)

def get_customer_data(db: Session, customer_no: str) -> Optional[Dict]:
    """Get all customer data including ABC and revenue info"""
    if not customer_no:
        return None

    customer = db.query(Customer).filter(
        Customer.customer_no == customer_no.strip()
    ).first()

    if not customer:
        return None

    # Check if classification is empty/null
    is_default = not customer.abc_classification

    return {
        'customer_no': customer.customer_no,
        'customer_name': customer.customer_name,
        'contact_person': customer.contact_person or '',
        'place': customer.place or '',
        'abc_classification': customer.abc_classification or 'C',
        'is_new_customer': customer.is_new_customer,
        'is_default_classification': is_default,
        'revenue_last_year': float(customer.revenue_last_year) if customer.revenue_last_year else 0,
        'revenue_current_year': float(customer.revenue_current_year) if customer.revenue_current_year else 0
    }

def search_customers(db: Session,
                     customer_no: Optional[str]=None,
                     customer_name: Optional[str]=None,
                     contact_person: Optional[str]=None,
                     place: Optional[str]=None,
                     limit: int = 25) -> List[Dict]:
    """Search customers with all fields from unified table"""
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
        'place': r.place or '',
        'abc_classification': r.abc_classification or 'C',
        'is_new_customer': r.is_new_customer,
        'revenue_last_year': float(r.revenue_last_year) if r.revenue_last_year else 0,
        'revenue_current_year': float(r.revenue_current_year) if r.revenue_current_year else 0
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
        'place': r.place or '',
        'abc_classification': r.abc_classification or 'C',
        'is_new_customer': r.is_new_customer,
        'is_default_classification': not r.abc_classification,
        'revenue_last_year': float(r.revenue_last_year) if r.revenue_last_year else 0,
        'revenue_current_year': float(r.revenue_current_year) if r.revenue_current_year else 0
    } for r in rows]