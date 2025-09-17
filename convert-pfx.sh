#!/bin/bash

echo "🔐 PFX zu PEM Konvertierung für SSL"
echo "==================================="

# Passwort für PFX abfragen
echo -n "Bitte PFX-Passwort eingeben: "
read -s PFX_PASSWORD
echo ""

# Backup der alten Zertifikate
echo "📦 Erstelle Backup der alten Zertifikate..."
mkdir -p ssl/backup-$(date +%Y%m%d_%H%M%S)
cp ssl/* ssl/backup-$(date +%Y%m%d_%H%M%S)/ 2>/dev/null || true

# Private Key extrahieren (ohne Passwort)
echo "🔑 Extrahiere Private Key..."
openssl pkcs12 -in /home/user/Downloads/bundle.pfx -nocerts -nodes -out ssl/private.key -passin pass:"$PFX_PASSWORD"

# Zertifikat extrahieren
echo "📜 Extrahiere Zertifikat..."
openssl pkcs12 -in /home/user/Downloads/bundle.pfx -clcerts -nokeys -out ssl/cert.pem -passin pass:"$PFX_PASSWORD"

# CA-Chain extrahieren (falls vorhanden)
echo "🔗 Extrahiere CA-Chain..."
openssl pkcs12 -in /home/user/Downloads/bundle.pfx -cacerts -nokeys -out ssl/chain.pem -passin pass:"$PFX_PASSWORD" 2>/dev/null || true

# Kombiniertes Zertifikat erstellen (cert + chain)
if [ -f ssl/chain.pem ]; then
    echo "📋 Erstelle kombiniertes Zertifikat..."
    cat ssl/cert.pem ssl/chain.pem > ssl/fullchain.pem
else
    cp ssl/cert.pem ssl/fullchain.pem
fi

# Berechtigungen setzen
chmod 600 ssl/private.key
chmod 644 ssl/cert.pem ssl/fullchain.pem

# Zertifikat-Info anzeigen
echo ""
echo "📊 Zertifikat-Informationen:"
openssl x509 -in ssl/cert.pem -noout -subject -issuer -dates

echo ""
echo "✅ Konvertierung abgeschlossen!"
echo ""
echo "🚀 Nächste Schritte:"
echo "1. nginx neu starten: docker restart nginx_clean"
echo "2. Browser-Cache leeren und https://reportapp.hellertools.com testen"