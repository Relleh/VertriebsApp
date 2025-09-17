#!/bin/bash

# Cloud Backup Script für maximale Datensicherheit
# Unterstützt: Hetzner Storage Box, AWS S3, Google Drive

BACKUP_DIR="./backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="full-backup-$DATE.sql"

echo "☁️ Cloud Backup gestartet..."

# 1. Lokales Backup erstellen
echo "📦 Erstelle lokales Datenbank-Backup..."
docker exec vertriebsberichte-app-original_db_1 pg_dump -U vertrieb vertrieb > "$BACKUP_DIR/$BACKUP_FILE"

# 2. App-Code backup
echo "📁 Erstelle Code-Backup..."
tar -czf "$BACKUP_DIR/app-backup-$DATE.tar.gz" --exclude='backups' --exclude='*.tar.gz' app/ docker-compose*.yml Dockerfile requirements.txt .env

# 3. Cloud Upload (verschiedene Optionen)

# Option A: Hetzner Storage Box (via rsync/scp)
if [ -n "$HETZNER_STORAGE_HOST" ]; then
    echo "📤 Upload zu Hetzner Storage Box..."
    rsync -avz "$BACKUP_DIR/" "$HETZNER_STORAGE_USER@$HETZNER_STORAGE_HOST:backups/vertriebsberichte/"
fi

# Option B: AWS S3
if [ -n "$AWS_S3_BUCKET" ]; then
    echo "📤 Upload zu AWS S3..."
    aws s3 cp "$BACKUP_DIR/$BACKUP_FILE" "s3://$AWS_S3_BUCKET/database-backups/"
    aws s3 cp "$BACKUP_DIR/app-backup-$DATE.tar.gz" "s3://$AWS_S3_BUCKET/app-backups/"
fi

# Option C: Google Cloud Storage
if [ -n "$GCS_BUCKET" ]; then
    echo "📤 Upload zu Google Cloud Storage..."
    gsutil cp "$BACKUP_DIR/$BACKUP_FILE" "gs://$GCS_BUCKET/database-backups/"
    gsutil cp "$BACKUP_DIR/app-backup-$DATE.tar.gz" "gs://$GCS_BUCKET/app-backups/"
fi

# Option D: Hetzner Cloud Volume (lokales Mount)
if [ -d "/mnt/hetzner-volume" ]; then
    echo "📤 Copy zu Hetzner Volume..."
    cp "$BACKUP_DIR/$BACKUP_FILE" "/mnt/hetzner-volume/vertriebsberichte/"
    cp "$BACKUP_DIR/app-backup-$DATE.tar.gz" "/mnt/hetzner-volume/vertriebsberichte/"
fi

# 4. Alte lokale Backups bereinigen (behalte letzten 7 Tage)
echo "🧹 Bereinige alte Backups..."
find "$BACKUP_DIR" -name "*.sql" -mtime +7 -delete
find "$BACKUP_DIR" -name "*.tar.gz" -mtime +7 -delete

# 5. Backup-Log erstellen
echo "$(date): Backup $BACKUP_FILE created and uploaded" >> "$BACKUP_DIR/backup.log"

echo "✅ Cloud Backup abgeschlossen!"
echo "📊 Backup-Info:"
echo "  - Datenbank: $BACKUP_FILE ($(du -h $BACKUP_DIR/$BACKUP_FILE | cut -f1))"
echo "  - App-Code: app-backup-$DATE.tar.gz"
echo "  - Log: $BACKUP_DIR/backup.log"