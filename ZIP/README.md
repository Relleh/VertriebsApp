# Vertriebs Berichte App (Dockerized, Entra ID Login)

Diese Beispiel-App erfüllt Ihre Anforderungen:
- **Docker**-bereit, inkl. **PostgreSQL**-Datenbank (via `docker-compose`).
- **Microsoft Entra ID (Azure AD) Login** per OIDC (Authorization Code Flow).
- **Jede:r Benutzer:in sieht nur die eigenen Berichte**.
- **DE/EN**-UI mit Umschalter.
- **CSV-Autofill** (Kundennummer/Kunde/Ansprechpartner/Ort): Eintrag in eines der Felder schlägt automatisch die übrigen Werte vor; bei Mehrfachtreffern erscheint ein Dropdown.
- **Alle Felder zunächst Pflicht** – im Code ist kommentiert, **wo** Sie das je Feld ändern können.
- **Auswertung**: Extern über die SQL-Datenbank möglich (z. B. BI-Tool).

## 1) Vorbereitung

1. Kopieren Sie `.env.example` nach `.env` und tragen Sie Ihre Entra-ID-Daten ein.
2. Legen Sie die CSV unter `./data/customers.csv` ab. Kopfzeile erwartet (Deutsch):  
   `Kundennummer,Kunde,Ansprechpartner,Ort`  
   _(Toleriert: "Kundennumer" als Schreibvariante.)_
3. Optional: Passen Sie `DEFAULT_LOCALE` in `.env` an (`de`/`en`).

## 2) Azure/Entra ID einrichten (Kurzfassung)

- **App Registration** erstellen (Single-Tenant empfohlen).
- **Platform**: *Web* hinzufügen, Redirect-URI `http://localhost:8000/auth/callback` (für Test).
- **Allow Public Client Flows** nicht notwendig (Server-Side Auth Code Flow).
- **ID tokens** müssen aktiviert sein.
- Client ID/Secret/Tenant ID in `.env` eintragen.

> **Prod-Hinweis:** Stellen Sie in Produktion `OAUTH_REDIRECT_URI` auf Ihre echte URL, z. B. `https://vertrieb.firma.tld/auth/callback` und terminieren Sie TLS vorm Container (Traefik/Nginx).

## 3) Start

```bash
docker compose up --build
# danach: http://localhost:8000
```

## 4) CSV aktualisieren

Ersetzen Sie `./data/customers.csv` auf dem Host. Die Datei ist als Volume eingebunden.
Die App lädt die Datei beim Start; senden Sie optional einen GET-Request an `/admin/reload-customers` (lokal erreichbar), um das CSV ohne Neustart neu zu laden.

## 5) DB-Anbindung für Auswertungen

Die Daten liegen in PostgreSQL im Container `db` (Port 5432 gemappt). Credentials siehe `docker-compose.yml` / `.env`.  
Tabelle: `reports` (Berichte) und `customers` (Stammdaten aus CSV).

## 6) URL / Produktion

- DNS Ihrer gekauften Domain auf den Server zeigen lassen.
- Reverse Proxy (Traefik/Nginx/Caddy) vor den App-Container setzen und `/` an `app:8000` weiterleiten.
- In Azure App Registration die **Redirect-URL** aktualisieren.
- In `.env`: `OAUTH_REDIRECT_URI` auf die produktive URL setzen.

Viel Erfolg! :)
