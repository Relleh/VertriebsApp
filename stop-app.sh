#!/bin/bash

PROJECT_DIR="/home/user/vertriebsberichte-app-original"
cd $PROJECT_DIR

echo "Stopping Vertriebsberichte App..."
/usr/bin/docker-compose -f docker-compose.production.yml down

echo "✅ App stopped successfully"
exit 0