#!/usr/bin/env python3
import pandas as pd
import psycopg2
from datetime import datetime
import sys
import os

# Datenbank-Verbindung - angepasst für aktuelles Setup
DB_CONFIG = {
    'host': 'localhost',  # Geändert von postgres-master
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
    # WICHTIG: Keine Fallback-Daten erfinden! Leere Daten bleiben leer
    
    # Boolean-Felder konvertieren (Ja/Yes → True, Nein/No → False)
    for col in ['is_new_account', 'overnight']:
        if col in df.columns:
            df[col] = df[col].str.upper().str.contains('JA|YES', na=False)
    
    # Day Status normalisieren - an neue Werte anpassen!
    day_status_mapping = {
        'B': 'OFFICE',      # Alt: Bürotag
        'U': 'PREVENTED',   # Alt: Urlaub → Verhindert
        'K': 'PREVENTED',   # Alt: Krank → Verhindert
        'O': 'OFFICE',      # Englisch: Office
        'V': 'PREVENTED',   # Englisch: Vacation → Verhindert
        'I': 'PREVENTED'    # Englisch: Illness → Verhindert
    }
    if 'day_status' in df.columns:
        df['day_status'] = df['day_status'].map(day_status_mapping)
        # Kein Fallback! Leere Werte bleiben leer
    
    # Classification validieren (nur A, B, C erlaubt)
    if 'classification' in df.columns:
        df['classification'] = df['classification'].str.upper()
        # Nur valide Werte behalten, keine erfundenen Defaults!
        df.loc[~df['classification'].isin(['A', 'B', 'C']), 'classification'] = None
    
    # Numerische Werte bereinigen - KEINE Standardwerte erfinden!
    for col in ['order_value_eur', 'offer_value_eur']:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors='coerce')  # NaN bleibt NaN
    
    if 'next_visit_weeks' in df.columns:
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
        conn.autocommit = True  # Jede Zeile einzeln committen
        cursor = conn.cursor()
        
        success_count = 0
        error_count = 0
        skip_count = 0
        
        for index, row in df.iterrows():
            try:
                # Nur Zeilen mit allen Pflichtfeldern importieren
                if pd.isna(row.get('customer_no')) or pd.isna(row.get('customer_name')):
                    skip_count += 1
                    continue
                
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
                
                cursor.execute(insert_query, (
                    row['owner_oid'], 
                    row['owner_email'], 
                    row.get('owner_name') if pd.notna(row.get('owner_name')) else None,
                    str(row['customer_no']), 
                    row['customer_name'],
                    row.get('contact_person') if pd.notna(row.get('contact_person')) else None,
                    row.get('place') if pd.notna(row.get('place')) else None,
                    row['date'].date() if pd.notna(row.get('date')) else None,
                    row.get('short_report') if pd.notna(row.get('short_report')) else None,
                    row.get('next_steps') if pd.notna(row.get('next_steps')) else None,
                    row.get('classification') if pd.notna(row.get('classification')) else None,
                    float(row['order_value_eur']) if pd.notna(row.get('order_value_eur')) else None,
                    float(row['offer_value_eur']) if pd.notna(row.get('offer_value_eur')) else None,
                    int(row['next_visit_weeks']) if pd.notna(row.get('next_visit_weeks')) else None,
                    bool(row['is_new_account']) if pd.notna(row.get('is_new_account')) else False,
                    bool(row['overnight']) if pd.notna(row.get('overnight')) else False,
                    row.get('day_status') if pd.notna(row.get('day_status')) else None
                ))
                success_count += 1
                if success_count % 100 == 0:
                    print(f"    ✓ {success_count} Berichte importiert...")
                
            except Exception as e:
                error_count += 1
                # Nur die ersten paar Fehler anzeigen
                if error_count <= 10:
                    print(f"⚠️  Zeile {index+1} Fehler: {str(e)[:100]}")
                continue
        
        cursor.close()
        conn.close()
        
        print(f"\n✅ Import abgeschlossen:")
        print(f"   - {success_count} Berichte erfolgreich importiert")
        print(f"   - {error_count} Fehler")
        print(f"   - {skip_count} übersprungen (fehlende Pflichtfelder)")
        
    except Exception as e:
        print(f"❌ Datenbankfehler: {e}")

def main():
    # Korrekter Pfad zur Excel-Datei
    excel_file = "/home/user/Downloads/Import Liste.xlsx"
    
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