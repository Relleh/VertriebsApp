#!/usr/bin/env python3
import pandas as pd

def analyze_excel():
    excel_file = "/data/Import Liste.xlsx"
    
    # Excel laden
    df = pd.read_excel(excel_file)
    print(f"📊 Analyse der Excel-Datei: {len(df)} Zeilen")
    print("\n🏷️  Spaltennamen:")
    for i, col in enumerate(df.columns):
        print(f"{i+1:2d}. '{col}'")
    
    print(f"\n📋 Erste 5 Zeilen (nur wichtige Spalten):")
    key_cols = [col for col in df.columns if any(word in col.lower() for word in ['kunde', 'customer', 'datum', 'date', 'bericht', 'report'])][:5]
    if key_cols:
        print(df[key_cols].head().to_string())
    
    print(f"\n📊 Datentypes:")
    print(df.dtypes)

if __name__ == "__main__":
    analyze_excel()