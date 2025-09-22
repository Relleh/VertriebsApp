import os
import csv
import time
from typing import Dict, Optional
from sqlalchemy.orm import Session
from .models import ABCCustomer

ABC_CSV_PATH = os.environ.get('ABC_CSV_PATH', '/app/data/abc_customers.csv')
_last_loaded_mtime: float | None = None

def load_abc_csv_into_db(db: Session) -> int:
    global _last_loaded_mtime
    if not os.path.exists(ABC_CSV_PATH):
        return 0
    
    mtime = os.path.getmtime(ABC_CSV_PATH)
    inserted = 0
    
    if _last_loaded_mtime is not None and mtime <= _last_loaded_mtime:
        return 0  # no change
    
    # recreate table contents
    db.query(ABCCustomer).delete()
    
    # Try different encodings to handle various CSV formats
    encodings = ['cp1252', 'utf-8-sig', 'utf-8', 'latin-1', 'iso-8859-1']
    f = None
    
    for encoding in encodings:
        try:
            f = open(ABC_CSV_PATH, newline='', encoding=encoding)
            # Test if we can read the first line
            f.readline()
            f.seek(0)
            break
        except (UnicodeDecodeError, UnicodeError):
            if f:
                f.close()
            continue
    
    if f is None:
        raise RuntimeError(f"Could not decode ABC CSV file with any of these encodings: {encodings}")
    
    with f:
        # Auto-detect delimiter (comma or semicolon)
        sample = f.read(1024)
        f.seek(0)
        delimiter = ';' if sample.count(';') > sample.count(',') else ','
        
        reader = csv.DictReader(f, delimiter=delimiter)
        
        for row in reader:
            customer_no = row.get('Kundennummer', '').strip()
            if not customer_no:
                continue
            
            abc_class = row.get('ABC_Klasse', '').strip()
            # Convert '-' to None for database
            if abc_class == '-':
                abc_class = None
            
            is_new = row.get('Kennzeichen_Neukunde', '').strip().lower() == 'ja'
            
            db.add(ABCCustomer(
                customer_no=customer_no,
                abc_classification=abc_class,
                is_new_customer=is_new
            ))
            inserted += 1
    
    db.commit()
    _last_loaded_mtime = mtime
    return inserted

def get_abc_data(db: Session, customer_no: str) -> Optional[Dict]:
    """Get ABC classification and new customer status for a given customer number"""
    if not customer_no:
        return None
    
    customer = db.query(ABCCustomer).filter(
        ABCCustomer.customer_no == customer_no.strip()
    ).first()
    
    if not customer:
        return None
    
    # Check if classification is empty/null (meaning it will use default)
    is_default = not customer.abc_classification
    
    return {
        'abc_classification': customer.abc_classification or 'C',
        'is_new_customer': customer.is_new_customer,
        'is_default_classification': is_default
    }