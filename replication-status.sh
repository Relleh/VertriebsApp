#!/bin/bash

echo "🎯 Master-Slave Replikation Status"
echo "=================================="
echo ""

# Master Status prüfen
echo "🔹 Master Database (postgres-master):"
if docker ps | grep -q postgres-master; then
    echo "   ✅ Container läuft"
    echo "   📊 DB Status:"
    docker exec postgres-master psql -U vertrieb -d vertrieb -c "SELECT pg_is_in_recovery(), current_database();" 2>/dev/null || echo "   ❌ DB nicht erreichbar"
else
    echo "   ❌ Container ist gestoppt"
fi

echo ""

# App Status prüfen  
echo "🔹 Application (app):"
if docker ps | grep -q " app "; then
    echo "   ✅ Container läuft"
    echo "   🌐 Test: https://reportapp.hellertools.com"
else
    echo "   ❌ Container ist gestoppt"
fi

echo ""

# Nginx Status prüfen
echo "🔹 Nginx (nginx_clean):"
if docker ps | grep -q nginx_clean; then
    echo "   ✅ Container läuft"
else
    echo "   ❌ Container ist gestoppt"
fi

echo ""

# Volumes prüfen
echo "🔹 Datenbank-Volumes:"
docker volume ls | grep -E "(master|slave)" | while read driver name; do
    echo "   📦 $name"
done

echo ""

# Netzwerk prüfen
echo "🔹 Docker Network:"
docker network inspect vertriebsberichte-app-original_default --format='{{range .Containers}}{{.Name}} {{end}}' 2>/dev/null || echo "   ❌ Network nicht gefunden"

echo ""

# Backup Status
echo "🔹 Letzte Backups:"
ls -la backups/ | grep -E "\.(sql|tar\.gz)$" | tail -3