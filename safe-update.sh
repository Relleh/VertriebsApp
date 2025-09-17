#!/bin/bash

# Sicheres Update-Skript für die Vertriebsberichte App
# Erhält Datenbank-Daten bei Container-Updates

echo "🔄 Sichere App-Update gestartet..."

# 1. Datenbank-Backup erstellen
echo "📦 Erstelle Datenbank-Backup..."
docker exec vertriebsberichte-app-original_db_1 pg_dump -U vertrieb vertrieb > "backup-db-$(date +%Y%m%d_%H%M%S).sql"

# 2. Nur App-Container neu bauen (NICHT die Datenbank!)
echo "🔨 Baue App-Container neu..."
docker stop vertriebsberichte-app-original_app_1 2>/dev/null || true
docker rm vertriebsberichte-app-original_app_1 2>/dev/null || true
docker-compose build --no-cache app

# 3. App-Container starten (DB läuft weiter)
echo "🚀 Starte App-Container..."
docker run -d --name vertriebsberichte-app-original_app_1 \
  --network vertriebsberichte-app-original_default \
  -p 8000:8000 \
  --env-file .env \
  vertriebsberichte-app-original_app:latest \
  uvicorn app.main:app --host 0.0.0.0 --port 8000

echo "✅ Update abgeschlossen! Datenbank-Daten bleiben erhalten."
echo "🔗 App erreichbar unter: https://reportapp.hellertools.com"