#!/usr/bin/env python3
import pandas as pd
import sys

def analyze_excel(file_path):
    """Analyze Excel file structure and content"""
    try:
        # Read Excel file
        print(f"📊 Analyzing Excel file: {file_path}")
        df = pd.read_excel(file_path)

        # Show structure
        print(f"\n🔍 Structure:")
        print(f"Rows: {len(df)}")
        print(f"Columns: {list(df.columns)}")

        # Show first few rows
        print(f"\n📋 First 10 rows:")
        print(df.head(10).to_string())

        # Show data types
        print(f"\n📝 Data types:")
        print(df.dtypes)

        # Check for unique values in key columns
        for col in df.columns:
            if 'neukunde' in col.lower() or 'abc' in col.lower():
                unique_vals = df[col].unique()
                print(f"\n🎯 Unique values in '{col}': {unique_vals}")
                print(f"   Count: {df[col].value_counts()}")

        # Check for missing values
        print(f"\n❓ Missing values:")
        print(df.isnull().sum())

        return df

    except Exception as e:
        print(f"❌ Error: {e}")
        return None

def convert_to_csv(df, output_path):
    """Convert DataFrame to CSV with correct format"""
    try:
        # Expected format: Kundennummer,ABC_Klasse,Kennzeichen_Neukunde

        # Map column names (try different variations)
        column_mapping = {}
        for col in df.columns:
            col_lower = col.lower()
            if 'kunde' in col_lower and 'nummer' in col_lower:
                column_mapping['Kundennummer'] = col
            elif 'abc' in col_lower:
                column_mapping['ABC_Klasse'] = col
            elif 'neukunde' in col_lower:
                column_mapping['Kennzeichen_Neukunde'] = col

        print(f"\n🔄 Column mapping: {column_mapping}")

        # Create new DataFrame with correct column names
        new_df = pd.DataFrame()
        for new_col, old_col in column_mapping.items():
            new_df[new_col] = df[old_col]

        # Convert Neukunde values to Ja/Nein if needed
        if 'Kennzeichen_Neukunde' in new_df.columns:
            neukunde_col = new_df['Kennzeichen_Neukunde']
            # Handle different formats
            new_df['Kennzeichen_Neukunde'] = neukunde_col.apply(lambda x:
                'Ja' if str(x).lower() in ['ja', 'yes', 'true', '1', 'y']
                else 'Nein' if str(x).lower() in ['nein', 'no', 'false', '0', 'n']
                else str(x)
            )

        # Replace empty ABC values with '-'
        if 'ABC_Klasse' in new_df.columns:
            new_df['ABC_Klasse'] = new_df['ABC_Klasse'].fillna('-')
            new_df['ABC_Klasse'] = new_df['ABC_Klasse'].replace('', '-')

        # Save to CSV
        new_df.to_csv(output_path, index=False)
        print(f"✅ Saved to: {output_path}")
        print(f"📊 Total rows: {len(new_df)}")

        # Show sample of converted data
        print(f"\n📋 Converted data sample:")
        print(new_df.head(10).to_string())

        return new_df

    except Exception as e:
        print(f"❌ Conversion error: {e}")
        return None

if __name__ == "__main__":
    excel_file = "/home/user/Downloads/Kunde_ABC_Neukunde.xlsx"
    csv_output = "/tmp/converted_customers.csv"

    # Analyze
    df = analyze_excel(excel_file)

    if df is not None:
        # Convert
        converted_df = convert_to_csv(df, csv_output)

        if converted_df is not None:
            print(f"\n🎉 Success! Check {csv_output}")

            # Show statistics
            print(f"\n📈 Statistics:")
            if 'Kennzeichen_Neukunde' in converted_df.columns:
                neukunde_counts = converted_df['Kennzeichen_Neukunde'].value_counts()
                print(f"Neukunde distribution: {neukunde_counts}")

            if 'ABC_Klasse' in converted_df.columns:
                abc_counts = converted_df['ABC_Klasse'].value_counts()
                print(f"ABC distribution: {abc_counts}")