#!/bin/bash

# PostgreSQL Master-Slave Replikation Setup
# Für maximale Datenbank-Sicherheit

echo "🔄 PostgreSQL Replikation Setup gestartet..."

# 1. Master Konfiguration erstellen
cat > postgres-master.conf << 'EOF'
# PostgreSQL Master Configuration
listen_addresses = '*'
wal_level = replica
max_wal_senders = 3
wal_keep_size = '64MB'
archive_mode = on
archive_command = 'cp %p /var/lib/postgresql/data/archive/%f'
EOF

# 2. Erweiterte docker-compose.yml erstellen
cat > docker-compose-replication.yml << 'EOF'
version: "3.9"

services:
  db-master:
    image: postgres:16-alpine
    container_name: postgres-master
    environment:
      POSTGRES_DB: vertrieb
      POSTGRES_USER: vertrieb
      POSTGRES_PASSWORD: vertrieb
      POSTGRES_REPLICATION_USER: replicator
      POSTGRES_REPLICATION_PASSWORD: replicator123
    volumes:
      - db_master_data:/var/lib/postgresql/data
      - ./postgres-master.conf:/etc/postgresql/postgresql.conf:ro
      - ./init-replication.sql:/docker-entrypoint-initdb.d/init-replication.sql:ro
    ports:
      - "5432:5432"
    command: postgres -c config_file=/etc/postgresql/postgresql.conf
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U vertrieb -d vertrieb"]
      interval: 5s
      timeout: 5s
      retries: 10

  db-slave:
    image: postgres:16-alpine
    container_name: postgres-slave
    environment:
      POSTGRES_DB: vertrieb
      POSTGRES_USER: vertrieb
      POSTGRES_PASSWORD: vertrieb
      PGUSER: postgres
    volumes:
      - db_slave_data:/var/lib/postgresql/data
    ports:
      - "5433:5432"  # Anderer Port für Slave
    depends_on:
      db-master:
        condition: service_healthy
    command: |
      bash -c "
      echo 'Setting up PostgreSQL slave...'
      
      # Warte bis Master verfügbar
      until pg_isready -h db-master -p 5432; do
        echo 'Waiting for master...'
        sleep 2
      done
      
      # Base backup vom Master
      rm -rf /var/lib/postgresql/data/*
      PGPASSWORD=replicator123 pg_basebackup -h db-master -D /var/lib/postgresql/data -U replicator -v -P -W
      
      # Standby Konfiguration
      echo 'standby_mode = on' >> /var/lib/postgresql/data/recovery.conf
      echo 'primary_conninfo = ''host=db-master port=5432 user=replicator password=replicator123''' >> /var/lib/postgresql/data/recovery.conf
      echo 'trigger_file = ''/tmp/postgresql.trigger.5432''' >> /var/lib/postgresql/data/recovery.conf
      
      # PostgreSQL starten
      postgres
      "

  app:
    build: .
    depends_on:
      db-master:
        condition: service_healthy
    environment:
      ENTRA_TENANT_ID: ${ENTRA_TENANT_ID}
      ENTRA_CLIENT_ID: ${ENTRA_CLIENT_ID}
      ENTRA_CLIENT_SECRET: ${ENTRA_CLIENT_SECRET}
      OAUTH_REDIRECT_URI: ${OAUTH_REDIRECT_URI}
      SESSION_SECRET: ${SESSION_SECRET}
      # Master DB für Write-Operations
      DATABASE_URL: postgresql+psycopg2://vertrieb:vertrieb@db-master:5432/vertrieb
      # Slave DB für Read-Operations (optional)
      DATABASE_READ_URL: postgresql+psycopg2://vertrieb:vertrieb@db-slave:5432/vertrieb
      CUSTOMERS_CSV_PATH: ${CUSTOMERS_CSV_PATH}
      DEFAULT_LOCALE: ${DEFAULT_LOCALE}
    ports:
      - "8000:8000"
    volumes:
      - ./data:/app/data
    command: ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--proxy-headers"]

  # Backup Service für zusätzliche Sicherheit
  backup-service:
    image: postgres:16-alpine
    container_name: postgres-backup
    depends_on:
      - db-master
    volumes:
      - ./backups:/backups
      - /mnt/external-backup:/external-backup  # Mount external drive
    environment:
      PGPASSWORD: vertrieb
    command: |
      sh -c "
      while true; do
        sleep 3600  # Jede Stunde
        echo 'Creating hourly backup...'
        pg_dump -h db-master -U vertrieb vertrieb > /backups/hourly-backup-$(date +%Y%m%d_%H%M%S).sql
        
        # Copy to external drive if available
        if [ -d '/external-backup' ]; then
          cp /backups/hourly-backup-$(date +%Y%m%d_%H%M%S).sql /external-backup/
        fi
        
        # Cleanup old backups (keep last 24 hours)
        find /backups -name 'hourly-backup-*.sql' -mtime +1 -delete
      done
      "

volumes:
  db_master_data:
  db_slave_data:
EOF

# 3. Replikations-User Setup SQL
cat > init-replication.sql << 'EOF'
-- Create replication user
CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'replicator123';

-- Grant necessary permissions
GRANT CONNECT ON DATABASE vertrieb TO replicator;
EOF

# 4. Failover-Skript erstellen
cat > failover-to-slave.sh << 'EOF'
#!/bin/bash

echo "🚨 FAILOVER: Switching to slave database..."

# Promote slave to master
docker exec postgres-slave touch /tmp/postgresql.trigger.5432

# Update app configuration
sed -i 's/db-master:5432/db-slave:5432/g' docker-compose-replication.yml

# Restart app with new DB
docker-compose -f docker-compose-replication.yml restart app

echo "✅ Failover complete. App now uses slave as primary database."
echo "⚠️  Remember to fix original master and set up new slave!"
EOF

chmod +x failover-to-slave.sh

# 5. Status-Check Skript
cat > check-replication-status.sh << 'EOF'
#!/bin/bash

echo "📊 PostgreSQL Replication Status"
echo "================================="

echo ""
echo "🔹 Master Status:"
docker exec postgres-master psql -U vertrieb -d vertrieb -c "SELECT client_addr, state, sync_state FROM pg_stat_replication;"

echo ""
echo "🔹 Slave Status:"
docker exec postgres-slave psql -U vertrieb -d vertrieb -c "SELECT now() - pg_last_xact_replay_timestamp() AS replication_delay;"

echo ""
echo "🔹 Container Health:"
docker ps --filter "name=postgres" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
EOF

chmod +x check-replication-status.sh

echo "✅ Replikations-Setup erstellt!"
echo ""
echo "📁 Erstellte Dateien:"
echo "  - docker-compose-replication.yml   (Haupt-Konfiguration)"
echo "  - postgres-master.conf              (Master DB Config)"
echo "  - init-replication.sql              (Replikations-User)"
echo "  - failover-to-slave.sh              (Notfall-Failover)"
echo "  - check-replication-status.sh       (Status prüfen)"
echo ""
echo "🚀 Starten mit:"
echo "  docker-compose -f docker-compose-replication.yml up -d"
echo ""
echo "📊 Status prüfen:"
echo "  ./check-replication-status.sh"
echo ""
echo "🚨 Bei Master-Ausfall:"
echo "  ./failover-to-slave.sh"