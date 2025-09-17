#!/bin/sh

# Wait for PostgreSQL to be ready
DB_HOST=${DB_HOST:-db}
DB_PORT=${DB_PORT:-5432}

echo "Waiting for PostgreSQL at ${DB_HOST}:${DB_PORT}..."

for i in $(seq 1 30); do
  if nc -z $DB_HOST $DB_PORT 2>/dev/null; then
    echo "PostgreSQL is ready!"
    exec "$@"
  fi
  echo "Waiting... ($i/30)"
  sleep 2
done

echo "PostgreSQL did not become ready in time"
exit 1