#!/bin/bash

# Datenbank-Wiederherstellung aus Backup

if [ -z "$1" ]; then
    echo "❌ Fehler: Backup-Datei angeben!"
    echo "Verwendung: ./restore-db.sh backup-db-YYYYMMDD_HHMMSS.sql"
    echo ""
    echo "Verfügbare Backups:"
    ls -la backup-db-*.sql 2>/dev/null || echo "  Keine Backups gefunden"
    exit 1
fi

BACKUP_FILE="$1"

if [ ! -f "$BACKUP_FILE" ]; then
    echo "❌ Backup-Datei '$BACKUP_FILE' nicht gefunden!"
    exit 1
fi

echo "🔄 Datenbank-Wiederherstellung gestartet..."
echo "📁 Backup-Datei: $BACKUP_FILE"

# Datenbank leeren und Backup einspielen
echo "🗑️ Lösche alte Datenbank-Daten..."
docker exec vertriebsberichte-app-original_db_1 psql -U vertrieb -d vertrieb -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"

echo "📥 Spiele Backup ein..."
docker exec -i vertriebsberichte-app-original_db_1 psql -U vertrieb -d vertrieb < "$BACKUP_FILE"

echo "✅ Datenbank erfolgreich wiederhergestellt!"
echo "🔗 App erreichbar unter: https://reportapp.hellertools.com"