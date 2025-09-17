# WORKING BACKUP - Mo 18. Aug 12:24:32 UTC 2025

Diese Version funktioniert vollständig:
- Microsoft OAuth Login mit prompt=login Parameter
- JWT Token Parsing Fix
- HTTPS über nginx mit SSL-Zertifikaten
- Funktionierender Logout mit Microsoft Session-Clearing

## Dateien
- **backup-working-20250818_122113.tar.gz** - Vollständiges Code-Backup
- **backup-db-20250818_122842.sql** - Datenbank-Backup
- **safe-update.sh** - Sicheres Update ohne Datenverlust
- **restore-db.sh** - Datenbank-Wiederherstellung

## Sichere Updates (DATEN BLEIBEN ERHALTEN)
```bash
./safe-update.sh
```

## Datenbank wiederherstellen
```bash
./restore-db.sh backup-db-20250818_122842.sql
```

## WICHTIG: Diese Befehle NIEMALS verwenden
```bash
docker system prune --volumes  # ❌ Löscht ALLE Datenbank-Daten!
docker-compose down -v         # ❌ Löscht Projekt-Datenbank!
```

## Vollständige Wiederherstellung bei Problemen
```bash
# 1. Code wiederherstellen
tar -xzf backup-working-20250818_122113.tar.gz

# 2. Container bauen und starten
docker-compose build --no-cache
docker-compose up -d

# 3. Datenbank wiederherstellen
./restore-db.sh backup-db-20250818_122842.sql
```