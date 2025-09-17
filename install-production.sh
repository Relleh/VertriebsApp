#!/bin/bash

SERVICE_NAME="vertriebsberichte"
PROJECT_DIR=$(pwd)
USER=$(whoami)

echo "🚀 Installing ${SERVICE_NAME} as systemd service..."
echo "📁 Project directory: ${PROJECT_DIR}"
echo "👤 User: ${USER}"

# Berechtigungen setzen
echo "Setting permissions..."
chmod +x start-app.sh stop-app.sh wait-for-postgres.sh

# Log directory erstellen
mkdir -p logs/nginx

# Service installieren
echo "Installing systemd service..."
sudo cp ${SERVICE_NAME}.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable ${SERVICE_NAME}

echo "Starting service..."
sudo systemctl start ${SERVICE_NAME}

echo "✅ Installation complete!"
echo ""
echo "📊 Service status:"
sudo systemctl status ${SERVICE_NAME} --no-pager

echo ""
echo "🔧 Management Commands:"
echo "  sudo systemctl status ${SERVICE_NAME}     - Check status"
echo "  sudo systemctl restart ${SERVICE_NAME}    - Restart app"
echo "  sudo systemctl stop ${SERVICE_NAME}       - Stop app"
echo "  sudo journalctl -u ${SERVICE_NAME} -f     - View logs"
echo ""
echo "🌐 App URLs:"
echo "  Local:  https://192.168.62.114:8000"
echo "  Public: https://reportapp.hellertools.com"
echo "  Health: https://192.168.62.114:8000/health"

# Health check
echo ""
echo "🏥 Health check..."
sleep 5
curl -f https://192.168.62.114:8000/health -k 2>/dev/null && echo "✅ App is healthy!" || echo "⚠️  App not yet ready"