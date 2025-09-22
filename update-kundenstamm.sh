#!/bin/bash

# Script zum sicheren Update der Kundenstammdaten mit automatischem Backup
# Verwendung: ./update-kundenstamm.sh /pfad/zur/neuen/datei.csv

set -e  # Exit bei Fehlern

# Konfiguration
TARGET_DIR="/home/user/vertriebsberichte-app-original/Importdaten"
TARGET_FILE="kundenstamm_komplett.csv"
BACKUP_FILE="kundenstamm_komplett.csv.backup"
ARCHIVE_DIR="$TARGET_DIR/archive"

# Prüfe ob Argument übergeben wurde
if [ $# -eq 0 ]; then
    echo "❌ Fehler: Bitte Pfad zur neuen CSV-Datei angeben!"
    echo "Verwendung: $0 /pfad/zur/neuen/datei.csv"
    exit 1
fi

SOURCE_FILE="$1"

# Prüfe ob Quelldatei existiert
if [ ! -f "$SOURCE_FILE" ]; then
    echo "❌ Fehler: Datei $SOURCE_FILE nicht gefunden!"
    exit 1
fi

# Erstelle Archive-Verzeichnis falls nicht vorhanden
mkdir -p "$ARCHIVE_DIR"

# Backup der aktuellen Datei (falls vorhanden)
if [ -f "$TARGET_DIR/$TARGET_FILE" ]; then
    echo "📦 Erstelle Backup der aktuellen Datei..."
    cp "$TARGET_DIR/$TARGET_FILE" "$TARGET_DIR/$BACKUP_FILE"

    # Monatliches Archiv (optional - am Monatsende)
    DAY=$(date +%d)
    if [ "$DAY" -eq "01" ]; then
        ARCHIVE_NAME="kundenstamm_komplett_$(date -d 'yesterday' +%Y-%m).csv"
        echo "📅 Erstelle Monatsarchiv: $ARCHIVE_NAME"
        cp "$TARGET_DIR/$BACKUP_FILE" "$ARCHIVE_DIR/$ARCHIVE_NAME"
    fi
else
    echo "ℹ️  Keine vorhandene Datei zum Backup gefunden."
fi

# Kopiere neue Datei
echo "📥 Kopiere neue Kundendaten..."
cp "$SOURCE_FILE" "$TARGET_DIR/$TARGET_FILE"

# Setze Berechtigungen
chmod 644 "$TARGET_DIR/$TARGET_FILE"

# Prüfe ob App läuft und trigger Reload
if docker ps | grep -q vertriebsberichte-app-original_app; then
    echo "🔄 Triggere App-Reload..."
    curl -s https://reportapp.hellertools.com/admin/reload-customers > /dev/null

    if [ $? -eq 0 ]; then
        echo "✅ Kundendaten erfolgreich aktualisiert!"
    else
        echo "⚠️  Datei aktualisiert, aber App-Reload fehlgeschlagen. Wird beim nächsten App-Start geladen."
    fi
else
    echo "✅ Datei aktualisiert. Wird beim nächsten App-Start geladen."
fi

# Zeige Dateigrößen
echo ""
echo "📊 Dateigrößen:"
ls -lh "$TARGET_DIR/$TARGET_FILE" "$TARGET_DIR/$BACKUP_FILE" 2>/dev/null | awk '{print $9 ": " $5}'

# Lösche alte Archive (älter als 6 Monate)
echo "🧹 Lösche Archive älter als 6 Monate..."
find "$ARCHIVE_DIR" -name "kundenstamm_komplett_*.csv" -mtime +180 -delete

echo ""
echo "✨ Update abgeschlossen!"