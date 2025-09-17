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
