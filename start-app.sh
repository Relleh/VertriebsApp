#!/bin/bash

PROJECT_DIR="/home/user/vertriebsberichte-app-original"
cd $PROJECT_DIR

echo "Starting Vertriebsberichte App..."
/usr/bin/docker-compose -f docker-compose.production.yml down 2>/dev/null
/usr/bin/docker-compose -f docker-compose.production.yml up -d --build

echo "Waiting for services to be healthy..."
sleep 10

# Check if services are running
if /usr/bin/docker-compose -f docker-compose.production.yml ps | grep -q "Up"; then
    echo "✅ App started successfully"
    echo "🌐 Available at: https://192.168.62.114:8000"
    echo "🔗 Public URL: https://reportapp.hellertools.com"
else
    echo "❌ Failed to start app"
    /usr/bin/docker-compose -f docker-compose.production.yml logs
    exit 1
fi

exit 0