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
