#!/usr/bin/env python3
"""Test the new modal translations"""

import sys
sys.path.insert(0, '/home/user/vertriebsberichte-app-original')

from app.i18n import t

def test_modal_translations():
    print("🧪 Testing Modal Translations\n")

    # Test German translations
    print("🇩🇪 German (de):")
    print(f"  multiple_matches_found: '{t('multiple_matches_found', 'de')}'")
    print(f"  select_customer: '{t('select_customer', 'de')}'")
    print()

    # Test English translations
    print("🇺🇸 English (en):")
    print(f"  multiple_matches_found: '{t('multiple_matches_found', 'en')}'")
    print(f"  select_customer: '{t('select_customer', 'en')}'")
    print()

    # Test existing translations still work
    print("🔍 Testing existing translations:")
    print(f"  DE - customer_data: '{t('customer_data', 'de')}'")
    print(f"  EN - customer_data: '{t('customer_data', 'en')}'")
    print()

    # Test non-existent key (should return key itself)
    print("❓ Testing non-existent key:")
    print(f"  non_existent_key: '{t('non_existent_key', 'de')}'")

    print("\n✅ Translation test completed!")

if __name__ == "__main__":
    test_modal_translations()