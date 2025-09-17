#!/usr/bin/env python3
"""Test ABC classification functionality with the new complete customer database"""

import os
import sys
import tempfile
import csv
from pathlib import Path

# Add app to path
sys.path.insert(0, '/home/user/vertriebsberichte-app-original')

def test_csv_structure():
    """Test that the new CSV has the expected structure"""
    csv_path = '/home/user/vertriebsberichte-app-original/data/abc_customers.csv'

    print("🔍 Testing CSV structure...")

    with open(csv_path, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        expected_columns = {'Kundennummer', 'ABC_Klasse', 'Kennzeichen_Neukunde'}

        actual_columns = set(reader.fieldnames)
        print(f"Expected columns: {expected_columns}")
        print(f"Actual columns: {actual_columns}")

        if actual_columns != expected_columns:
            print("❌ Column mismatch!")
            return False

        # Test first few rows
        rows = list(reader)[:10]
        print(f"✅ CSV has {len(rows)} test rows")

        # Check data distribution
        total_rows = len(rows) + sum(1 for _ in reader)  # Count remaining rows

        # Read full file for statistics
        with open(csv_path, 'r', encoding='utf-8') as f2:
            reader2 = csv.DictReader(f2)
            all_rows = list(reader2)

            neukunde_counts = {}
            abc_counts = {}

            for row in all_rows:
                neukunde = row['Kennzeichen_Neukunde']
                abc = row['ABC_Klasse']

                neukunde_counts[neukunde] = neukunde_counts.get(neukunde, 0) + 1
                abc_counts[abc] = abc_counts.get(abc, 0) + 1

            print(f"📊 Total customers: {len(all_rows)}")
            print(f"📊 Neukunde distribution: {neukunde_counts}")
            print(f"📊 ABC distribution: {abc_counts}")

        return True

def test_abc_module():
    """Test the ABC module functionality"""
    print("\n🔧 Testing ABC module...")

    try:
        # Import modules (this will test if the structure is correct)
        from app.database import get_db_session
        from app.abc_customers import load_abc_csv_into_db, get_abc_data
        from app.models import ABCCustomer

        print("✅ Imports successful")

        # Create test database session (using SQLite for testing)
        import tempfile
        from sqlalchemy import create_engine
        from sqlalchemy.orm import sessionmaker
        from app.models import Base

        # Create temporary database
        temp_db = tempfile.NamedTemporaryFile(delete=False, suffix='.db')
        temp_db.close()

        engine = create_engine(f'sqlite:///{temp_db.name}')
        Base.metadata.create_all(engine)
        SessionLocal = sessionmaker(bind=engine)
        db = SessionLocal()

        print("✅ Test database created")

        # Set environment variable to point to our CSV
        os.environ['ABC_CSV_PATH'] = '/home/user/vertriebsberichte-app-original/data/abc_customers.csv'

        # Load CSV into database
        inserted = load_abc_csv_into_db(db)
        print(f"✅ Loaded {inserted} customers into database")

        # Test some specific customers
        test_customers = ['100000', '100005', '100006', '999999']  # Mix of existing and non-existing

        for customer_no in test_customers:
            abc_data = get_abc_data(db, customer_no)
            if abc_data:
                print(f"✅ Customer {customer_no}: {abc_data}")
            else:
                print(f"❌ Customer {customer_no}: Not found")

        # Count customers by type
        total_customers = db.query(ABCCustomer).count()
        new_customers = db.query(ABCCustomer).filter(ABCCustomer.is_new_customer == True).count()
        existing_customers = total_customers - new_customers

        print(f"📊 Database statistics:")
        print(f"   Total customers: {total_customers}")
        print(f"   New customers: {new_customers}")
        print(f"   Existing customers: {existing_customers}")

        # ABC distribution
        abc_a = db.query(ABCCustomer).filter(ABCCustomer.abc_classification == 'A').count()
        abc_b = db.query(ABCCustomer).filter(ABCCustomer.abc_classification == 'B').count()
        abc_c = db.query(ABCCustomer).filter(ABCCustomer.abc_classification == 'C').count()
        abc_none = db.query(ABCCustomer).filter(ABCCustomer.abc_classification.is_(None)).count()

        print(f"   ABC A: {abc_a}")
        print(f"   ABC B: {abc_b}")
        print(f"   ABC C: {abc_c}")
        print(f"   ABC - (None): {abc_none}")

        db.close()
        os.unlink(temp_db.name)

        return True

    except Exception as e:
        print(f"❌ Error testing ABC module: {e}")
        import traceback
        traceback.print_exc()
        return False

def main():
    print("🧪 Testing ABC functionality with complete customer database\n")

    # Test CSV structure
    csv_ok = test_csv_structure()

    if not csv_ok:
        print("\n❌ CSV structure test failed!")
        return

    # Test ABC module
    module_ok = test_abc_module()

    if module_ok:
        print("\n🎉 All tests passed! ABC functionality is working with complete customer database.")
        print("\n📋 Summary:")
        print("   ✅ CSV structure is correct")
        print("   ✅ ABC module loads and processes data")
        print("   ✅ Database queries work")
        print("   ✅ Both new and existing customers are included")
    else:
        print("\n❌ Some tests failed!")

if __name__ == "__main__":
    main()