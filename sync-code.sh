#!/bin/bash
# FAST CODE SYNC - Copy changed files to running production container
# Usage: ./sync-code.sh

set -e

CONTAINER_NAME="vertriebsberichte-app-original_app_1"

echo "🔄 Fast Code Sync - Copying changed files to container..."

# Check if container is running
if ! docker ps --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
    echo "❌ Container ${CONTAINER_NAME} is not running!"
    echo "Start it first with: docker-compose -f docker-compose.production.yml up -d"
    exit 1
fi

# Copy app directory to container
echo "📁 Copying app/ directory to container..."
docker cp ./app/. ${CONTAINER_NAME}:/app/app/

# Restart the app container (NOT rebuild)
echo "🔄 Restarting app container..."
docker-compose -f docker-compose.production.yml restart app

# Wait for container to be healthy
echo "⏳ Waiting for container to be healthy..."
sleep 3

# Check health
if docker ps --format "{{.Names}} {{.Status}}" | grep "${CONTAINER_NAME}" | grep -q "healthy"; then
    echo "✅ Fast sync completed! Changes are now live."
    echo "💡 No browser cache clear needed with this method."
else
    echo "⚠️  Container restarted but health check pending..."
    echo "✅ Changes should be live in a few seconds."
fi

echo ""
echo "📊 Container status:"
docker ps --format "table {{.Names}}\t{{.Status}}" | head -1
docker ps --format "table {{.Names}}\t{{.Status}}" | grep vertriebsberichte