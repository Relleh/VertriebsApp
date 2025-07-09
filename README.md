# Vertriebsberichte WebApp

Eine moderne WebApp für Vertriebsmitarbeiter zur Verwaltung und Auswertung von Kundenbesuchsberichten.

## Features

- 🔐 Benutzerauthentifizierung mit JWT
- 📝 Erstellen und Bearbeiten von Besuchsberichten
- 📊 Dashboard mit persönlichen Statistiken
- 🌍 Regionale Auswertungen
- 🔍 Filter- und Suchfunktionen
- 📱 Responsive Design

## Technologie-Stack

- **Frontend**: React, TypeScript, Tailwind CSS, React Router
- **Backend**: Node.js, Express, TypeScript
- **Datenbank**: PostgreSQL
- **Authentifizierung**: JWT mit bcrypt
- **Containerisierung**: Docker & Docker Compose

## Schnellstart

### Voraussetzungen
- Docker und Docker Compose
- Git

### Installation

1. Repository klonen:
```bash
git clone <repository-url>
cd vertriebsberichte-app
```

2. Umgebungsvariablen konfigurieren:
```bash
cp .env.example .env
# .env Datei anpassen
```

3. Anwendung starten:
```bash
docker-compose up -d
```

4. Datenbank initialisieren:
```bash
docker-compose exec backend npm run db:migrate
```

Die Anwendung ist nun verfügbar unter:
- Frontend: http://localhost:5000
- Backend API: http://localhost:3000

## Entwicklung

### Lokale Entwicklung

1. Dependencies installieren:
```bash
npm run install:all
```

2. Datenbank starten:
```bash
docker-compose up -d postgres
```

3. Entwicklungsserver starten:
```bash
npm run dev
```

### API-Endpunkte

#### Authentifizierung
- `POST /api/auth/register` - Benutzer registrieren
- `POST /api/auth/login` - Benutzer anmelden

#### Berichte
- `GET /api/reports` - Berichte auflisten
- `POST /api/reports` - Neuen Bericht erstellen
- `GET /api/reports/:id` - Bericht anzeigen
- `PUT /api/reports/:id` - Bericht bearbeiten
- `DELETE /api/reports/:id` - Bericht löschen
- `GET /api/reports/statistics` - Regionale Statistiken

#### Benutzer
- `GET /api/users/profile` - Benutzerprofil
- `GET /api/users/statistics` - Benutzerstatistiken

## Datenbank-Schema

### Tabellen
- `regions` - Verkaufsregionen
- `users` - Benutzer/Vertriebsmitarbeiter
- `customers` - Kunden
- `reports` - Besuchsberichte

## Umgebungsvariablen

```env
# Database
DB_HOST=localhost
DB_PORT=5432
DB_USER=vertrieb_user
DB_PASSWORD=your_secure_password
DB_NAME=vertriebsberichte

# Backend
JWT_SECRET=your_jwt_secret_key_here
PORT=3000

# Frontend
VITE_API_URL=http://localhost:3000/api
```

## Deployment

### Docker Compose (empfohlen)

1. `.env` Datei konfigurieren
2. `docker-compose up -d` ausführen
3. Datenbank migrieren mit `docker-compose exec backend npm run db:migrate`

### Manuelles Deployment

1. PostgreSQL-Server aufsetzen
2. Backend builden und deployen
3. Frontend builden und auf Webserver deployen
4. Nginx als Reverse Proxy konfigurieren

## Beitragen

1. Fork erstellen
2. Feature Branch erstellen (`git checkout -b feature/amazing-feature`)
3. Commits hinzufügen (`git commit -m 'Add amazing feature'`)
4. Push zum Branch (`git push origin feature/amazing-feature`)
5. Pull Request erstellen

## Lizenz

Dieses Projekt ist unter der MIT-Lizenz lizenziert.
