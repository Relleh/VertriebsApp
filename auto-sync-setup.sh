#!/bin/bash

echo "⚙️  Automatische Sync einrichten"
echo "==============================="

# Crontab-Eintrag für alle 2 Minuten Synchronisation
SYNC_COMMAND="*/2 * * * * cd /home/user/vertriebsberichte-app-original && ./sync-databases.sh >> /var/log/db-sync.log 2>&1"

# Prüfen ob bereits vorhanden
if crontab -l 2>/dev/null | grep -q "sync-databases.sh"; then
    echo "⚠️  Auto-Sync bereits eingerichtet"
    crontab -l | grep sync-databases
else
    # Backup der aktuellen Crontab
    crontab -l > /tmp/current-crontab 2>/dev/null || touch /tmp/current-crontab
    
    # Neue Zeile hinzufügen
    echo "$SYNC_COMMAND" >> /tmp/current-crontab
    
    # Neue Crontab installieren
    crontab /tmp/current-crontab
    
    echo "✅ Auto-Synchronisation alle 2 Minuten eingerichtet"
    echo "📝 Log-Datei: /var/log/db-sync.log"
fi

echo ""
echo "🕐 Aktuelle Crontab:"
crontab -l | grep -v "^#"