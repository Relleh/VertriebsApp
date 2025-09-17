#!/bin/bash

echo "🔄 Datenbank-Synchronisation Master → Slave"
echo "==========================================="

# Prüfen ob beide Container laufen
if ! docker ps | grep -q postgres-master; then
    echo "❌ Master-Container läuft nicht"
    exit 1
fi

if ! docker ps | grep -q postgres-slave; then
    echo "❌ Slave-Container läuft nicht"
    exit 1
fi

echo "📊 Status vor Sync:"
echo -n "   Master: "
docker exec postgres-master psql -U vertrieb -d vertrieb -t -c "SELECT COUNT(*) FROM reports;" | tr -d ' '
echo -n "   Slave:  "
docker exec postgres-slave psql -U vertrieb -d vertrieb -t -c "SELECT COUNT(*) FROM reports;" 2>/dev/null | tr -d ' ' || echo "0"

echo ""
echo "🔄 Synchronisiere Daten..."

# Backup vom Master erstellen
docker exec postgres-master pg_dump -U vertrieb vertrieb > /tmp/sync-backup.sql

# Slave-Datenbank leeren und neu laden
docker exec postgres-slave psql -U vertrieb -d vertrieb -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;" >/dev/null 2>&1

# Daten in Slave importieren
cat /tmp/sync-backup.sql | docker exec -i postgres-slave psql -U vertrieb -d vertrieb >/dev/null 2>&1

# Cleanup
rm -f /tmp/sync-backup.sql

echo "📊 Status nach Sync:"
echo -n "   Master: "
docker exec postgres-master psql -U vertrieb -d vertrieb -t -c "SELECT COUNT(*) FROM reports;" | tr -d ' '
echo -n "   Slave:  "
docker exec postgres-slave psql -U vertrieb -d vertrieb -t -c "SELECT COUNT(*) FROM reports;" | tr -d ' '

echo ""
echo "✅ Synchronisation abgeschlossen"