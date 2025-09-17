# Datenbank-Redundanz Optionen für Produktionsumgebung

## Option 1: PostgreSQL Master-Slave Replikation (Empfohlen)

### Setup mit docker-compose
```yaml
version: "3.9"
services:
  db-master:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: vertrieb
      POSTGRES_USER: vertrieb
      POSTGRES_PASSWORD: vertrieb
      POSTGRES_REPLICATION_USER: replicator
      POSTGRES_REPLICATION_PASSWORD: replicator123
    volumes:
      - db_master_data:/var/lib/postgresql/data
      - ./postgres-master.conf:/etc/postgresql/postgresql.conf
    command: postgres -c config_file=/etc/postgresql/postgresql.conf
    
  db-slave:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: vertrieb
      POSTGRES_USER: vertrieb
      POSTGRES_PASSWORD: vertrieb
      PGUSER: postgres
    volumes:
      - db_slave_data:/var/lib/postgresql/data
    depends_on:
      - db-master
    command: |
      bash -c "
      until pg_basebackup -h db-master -D /var/lib/postgresql/data -U replicator -v -P -W; do
        echo 'Waiting for master to be ready...'
        sleep 1s
      done
      echo 'standby_mode = on' >> /var/lib/postgresql/data/recovery.conf
      echo 'primary_conninfo = ''host=db-master port=5432 user=replicator''' >> /var/lib/postgresql/data/recovery.conf
      postgres
      "

volumes:
  db_master_data:
  db_slave_data:
```

### Vorteile:
- ✅ Automatische Echtzeit-Synchronisation
- ✅ Failover bei Master-Ausfall
- ✅ Read-Queries können auf Slave verteilt werden
- ✅ Lokale Kontrolle

## Option 2: Externe Managed Database (Cloud)

### PostgreSQL als Service
```bash
# Hetzner Cloud PostgreSQL
# DigitalOcean Managed Databases
# AWS RDS
# Google Cloud SQL
```

### docker-compose Update:
```yaml
services:
  # Entferne db service komplett
  app:
    # ...
    environment:
      DATABASE_URL: postgresql+psycopg2://user:pass@external-db-host:5432/vertrieb
```

### Vorteile:
- ✅ Professionelle Backups
- ✅ Automatische Updates
- ✅ 99.9% Uptime SLA
- ✅ Point-in-Time Recovery
- ❌ Monatliche Kosten (ca. 10-50€)

## Option 3: Multi-Location Backup (Hybrid)

### Lokale DB + Externe Backups
```yaml
services:
  db:
    # Bestehende Konfiguration
    volumes:
      - db_data:/var/lib/postgresql/data
      - /mnt/external-drive/db-backup:/backup  # Externes Medium
      
  backup-service:
    image: postgres:16-alpine
    depends_on:
      - db
    volumes:
      - /mnt/external-drive/db-backup:/backup
    environment:
      PGPASSWORD: vertrieb
    command: |
      sh -c "
      while true; do
        sleep 3600  # Jede Stunde
        pg_dump -h db -U vertrieb vertrieb > /backup/backup-$(date +%Y%m%d_%H%M%S).sql
        # Alte Backups löschen (älter als 7 Tage)
        find /backup -name '*.sql' -mtime +7 -delete
        # Upload zu Cloud Storage
        rclone copy /backup remote:database-backups/
      done
      "
```

## Option 4: Database Clustering (High Availability)

### PostgreSQL mit Patroni
```yaml
services:
  etcd:
    image: quay.io/coreos/etcd:v3.5.0
    # Cluster coordination
    
  postgres-1:
    image: patroni/patroni:latest
    # Primary node
    
  postgres-2:
    image: patroni/patroni:latest
    # Secondary node
    
  haproxy:
    image: haproxy:2.4
    # Load balancer für DB connections
```

### Vorteile:
- ✅ Automatisches Failover
- ✅ Zero-Downtime Updates
- ✅ Load Balancing
- ❌ Komplexe Konfiguration