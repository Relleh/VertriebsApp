#!/usr/bin/env python3
import pandas as pd
import psycopg2
from datetime import datetime
import sys
import os

# Datenbank-Verbindung
DB_CONFIG = {
    'host': 'postgres-master',
    'port': 5432,
    'database': 'vertrieb',
    'user': 'vertrieb',
    'password': 'vertrieb'
}

def load_excel_data(excel_file):
    """Excel-Datei laden und strukturieren"""
    print(f"📊 Lade Excel-Datei: {excel_file}")
    
    try:
        df = pd.read_excel(excel_file)
        print(f"✅ {len(df)} Zeilen gefunden")
        
        # Spalten-Mapping (Excel → Datenbank) - mit Zeilenumbrüchen!
        column_mapping = {
            'Kd. Nr.\nCustomer No.': 'customer_no',
            'Kunde\nCustomer': 'customer_name', 
            'Ansprechpartner\nContact Person': 'contact_person',
            'Ort\nPlace': 'place',
            'Datum\nDate': 'date',
            'Kurzbericht\nshort Report': 'short_report',
            'to-dos / Next Steps': 'next_steps',
            'Kunden-klassifizierung A-B-C\nclassification A-B-C': 'classification',
            'Auftrags-wert ca. €\nOrder Value EUR': 'order_value_eur',
            'Angebot über ca. X€\nOffer Value EUR': 'offer_value_eur',
            'Nächster Besuch in x-Wochen\nnext Visit in x-Weeks': 'next_visit_weeks',
            'Neukunde (Ja/Nein)\nNew account (Yes/No)': 'is_new_account',
            'Über-Nachtung (Ja/Nein)\nOvernight (Yes/No)': 'overnight',
            'Bürotag = B; Urlaub = U; Krank = K\nOffice Day = O; Vacation = V; Illness = I': 'day_status',
            'Vor- & Nachname\nFirst- & Surname': 'owner_name'
        }
        
        # Spalten umbenennen
        df = df.rename(columns=column_mapping)
        
        # Ersten paar Zeilen anzeigen
        print("📋 Erste 3 Zeilen:")
        print(df.head(3).to_string())
        
        return df
        
    except Exception as e:
        print(f"❌ Fehler beim Laden: {e}")
        return None

def clean_data(df):
    """Daten bereinigen und validieren"""
    print("🧹 Bereinige Daten...")
    
    # Leere Zeilen entfernen (nur Zeilen mit Kundennummer behalten)
    df = df.dropna(subset=['customer_no'])
    df = df[df['customer_no'].notna()]
    
    # Datentypen konvertieren
    df['customer_no'] = df['customer_no'].astype(str)
    
    # Datum konvertieren (deutsche Formate → ISO)
    df['date'] = pd.to_datetime(df['date'], format='%d.%m.%Y', errors='coerce')
    df['date'] = df['date'].fillna(pd.to_datetime('2025-01-01'))  # Fallback für ungültige Daten
    
    # Boolean-Felder konvertieren (Ja/Yes → True, Nein/No → False)
    for col in ['is_new_account', 'overnight']:
        df[col] = df[col].str.upper().str.contains('JA|YES', na=False)
    
    # Day Status normalisieren
    day_status_mapping = {
        'B': 'OFFICE',
        'U': 'VACATION', 
        'K': 'ILLNESS',
        'O': 'OFFICE',
        'V': 'VACATION',
        'I': 'ILLNESS'
    }
    df['day_status'] = df['day_status'].map(day_status_mapping).fillna('OFFICE')
    
    # Classification validieren (nur A, B, C erlaubt)
    df['classification'] = df['classification'].str.upper()
    df['classification'] = df['classification'].apply(lambda x: x if x in ['A', 'B', 'C'] else 'B')
    
    # Numerische Werte bereinigen - KEINE Standardwerte erfinden!
    for col in ['order_value_eur', 'offer_value_eur']:
        df[col] = pd.to_numeric(df[col], errors='coerce')  # NaN bleibt NaN
    
    df['next_visit_weeks'] = pd.to_numeric(df['next_visit_weeks'], errors='coerce')  # NaN bleibt NaN
    
    # System-Felder für Import (diese müssen gesetzt werden)
    df['owner_oid'] = 'excel-import-user'
    df['owner_email'] = 'import@system.com'
    
    print(f"✅ {len(df)} bereinigte Zeilen bereit für Import")
    return df

def insert_to_database(df):
    """Daten in PostgreSQL einfügen"""
    print("💾 Verbinde mit Datenbank...")
    
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        cursor = conn.cursor()
        
        success_count = 0
        error_count = 0
        
        for index, row in df.iterrows():
            try:
                insert_query = """
                INSERT INTO reports (
                    owner_oid, owner_email, owner_name,
                    customer_no, customer_name, contact_person, place,
                    date, short_report, next_steps,
                    classification, order_value_eur, offer_value_eur, next_visit_weeks,
                    is_new_account, overnight, day_status,
                    created_at, updated_at
                ) VALUES (
                    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 
                    %s, %s, %s, %s, %s, %s, %s, NOW(), NOW()
                )
                """
                
                # Nur Zeilen mit allen Pflichtfeldern importieren
                if pd.isna(row['customer_no']) or pd.isna(row['customer_name']) or pd.isna(row['date']):
                    print(f"⚠️  Zeile {index+1} übersprungen: Pflichtfelder fehlen")
                    continue
                
                cursor.execute(insert_query, (
                    row['owner_oid'], 
                    row['owner_email'], 
                    row['owner_name'] if pd.notna(row['owner_name']) else None,
                    row['customer_no'], 
                    row['customer_name'],
                    row['contact_person'] if pd.notna(row['contact_person']) else None,
                    row['place'] if pd.notna(row['place']) else None,
                    row['date'].date() if pd.notna(row['date']) else None,
                    row['short_report'] if pd.notna(row['short_report']) else None,
                    row['next_steps'] if pd.notna(row['next_steps']) else None,
                    row['classification'] if pd.notna(row['classification']) else None,
                    float(row['order_value_eur']) if pd.notna(row['order_value_eur']) else None,
                    float(row['offer_value_eur']) if pd.notna(row['offer_value_eur']) else None,
                    int(row['next_visit_weeks']) if pd.notna(row['next_visit_weeks']) else None,
                    bool(row['is_new_account']) if pd.notna(row['is_new_account']) else None,
                    bool(row['overnight']) if pd.notna(row['overnight']) else None,
                    row['day_status'] if pd.notna(row['day_status']) else None
                ))
                success_count += 1
                
            except Exception as e:
                print(f"⚠️  Zeile {index+1} Fehler: {e}")
                error_count += 1
                continue
        
        conn.commit()
        cursor.close()
        conn.close()
        
        print(f"✅ Import abgeschlossen: {success_count} erfolgreich, {error_count} Fehler")
        
    except Exception as e:
        print(f"❌ Datenbankfehler: {e}")

def main():
    excel_file = "/data/Import Liste.xlsx"
    
    if not os.path.exists(excel_file):
        print(f"❌ Datei nicht gefunden: {excel_file}")
        return
    
    # 1. Excel laden
    df = load_excel_data(excel_file)
    if df is None:
        return
    
    # 2. Daten bereinigen
    df = clean_data(df)
    
    # 3. In Datenbank importieren
    insert_to_database(df)
    
    print("🎯 Excel-Import abgeschlossen!")

if __name__ == "__main__":
    main()