# 🚀 Produktions-Deployment Checkliste

## ✅ Vor Deployment

### 1. Environment Setup
- [ ] `.env.production-template` nach `.env` kopiert
- [ ] `SESSION_SECRET` mit sicherem Schlüssel geändert
- [ ] `DB_PASSWORD` mit sicherem Passwort geändert
- [ ] `OAUTH_REDIRECT_URI` auf korrekte Domain gesetzt

### 2. Azure Entra ID
- [ ] Beide Redirect URIs in Azure registriert:
  - `https://192.168.62.114/auth/callback` (lokal)
  - `https://reportapp.hellertools.com/auth/callback` (öffentlich)

### 3. SSL/HTTPS
- [ ] SSL-Zertifikat im `/ssl` Ordner vorhanden
- [ ] `nginx-ssl.conf` auf korrekte Domain konfiguriert

## 🔧 Installation

### 1. Service Installation
```bash
chmod +x install-production.sh
./install-production.sh
```

### 2. Systemd Management Commands
```bash
# Status prüfen
sudo systemctl status vertriebsberichte

# App neustarten  
sudo systemctl restart vertriebsberichte

# App stoppen
sudo systemctl stop vertriebsberichte

# Logs anzeigen
sudo journalctl -u vertriebsberichte -f
```

### 3. Docker Management Commands
```bash
# Container Status
docker-compose -f docker-compose.production.yml ps

# Logs anzeigen
docker-compose -f docker-compose.production.yml logs -f

# App neustarten
docker-compose -f docker-compose.production.yml restart app

# Komplett neu bauen
docker-compose -f docker-compose.production.yml down
docker-compose -f docker-compose.production.yml up -d --build
```

## 🏥 Monitoring & Health Checks

### 1. Verfügbarkeit testen
```bash
# Health Check
curl https://192.168.62.114:8000/health -k
curl https://reportapp.hellertools.com/health

# App-Zugriff
curl https://192.168.62.114:8000 -k
```

### 2. Service Status
```bash
# Systemd Service
sudo systemctl is-active vertriebsberichte

# Docker Container
docker-compose -f docker-compose.production.yml ps

# Database Connection
docker-compose -f docker-compose.production.yml exec db psql -U vertrieb -d vertrieb -c "SELECT 1;"
```

## 🔐 Sicherheits-Checkliste

- [ ] `SESSION_SECRET` ist ein starker, zufälliger Schlüssel
- [ ] Database-Passwort ist sicher
- [ ] SSL-Zertifikate sind gültig
- [ ] Nur benötigte Ports sind öffentlich zugänglich
- [ ] `.env` ist nicht in Git committed
- [ ] Backup-Strategie für Datenbank implementiert

## 📊 URLs & Endpoints

- **Lokal HTTPS**: https://192.168.62.114:8000
- **Öffentlich**: https://reportapp.hellertools.com  
- **Health Check**: `/health`
- **Login**: `/login`
- **Reports**: `/reports`

## 🚨 Troubleshooting

### App startet nicht
```bash
# Logs prüfen
sudo journalctl -u vertriebsberichte -n 50

# Docker Logs
docker-compose -f docker-compose.production.yml logs

# Container Status
docker-compose -f docker-compose.production.yml ps
```

### SSL-Fehler
```bash
# Zertifikat prüfen
openssl x509 -in ssl/cert.pem -text -noout

# Nginx Config testen
docker-compose -f docker-compose.production.yml exec nginx nginx -t
```

### Database-Probleme
```bash
# PostgreSQL Logs
docker-compose -f docker-compose.production.yml logs db

# Connection Test
docker-compose -f docker-compose.production.yml exec app nc -z db 5432
```

## 🔄 Updates & Wartung

### App-Update
```bash
# Code aktualisieren
git pull

# Container neu bauen
sudo systemctl restart vertriebsberichte
```

### SSL-Zertifikat erneuern
1. Neue Zertifikate in `/ssl` Ordner
2. `sudo systemctl restart vertriebsberichte`

### Database-Backup
```bash
docker-compose -f docker-compose.production.yml exec db pg_dump -U vertrieb vertrieb > backup_$(date +%Y%m%d).sql
```