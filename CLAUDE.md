# CLAUDE ARBEITSREGELN - VERTRIEBSBERICHTE APP

## 🚨 KRITISCHE DOCKER/CONTAINER SICHERHEITSREGELN:

### REGEL 1: NIEMALS PAUSCHALE DOCKER-BEFEHLE IN MULTI-APP UMGEBUNG
❌ **ABSOLUT VERBOTEN:**
```bash
docker rm -f $(docker ps -aq)  # LÖSCHT ALLE CONTAINER ALLER APPS!!!
docker stop $(docker ps -q)    # STOPPT ALLE APPS AUF DEM SERVER!!!
docker system prune -a         # ZERSTÖRT ALLE ANDEREN APPS!!!
```

### 🛡️ PRODUCTION ENVIRONMENT SCHUTZ
Dieser Server läuft **3 PRODUKTIONS-APPS gleichzeitig:**
- schichtaufschreibung.hellertools.com (Container: schicht-app-uhrzeit_*)
- reportapp.hellertools.com (Container: vertriebsberichte-app-original_*)
- projekttool.hellertools.com (Container: vikunja)

✅ **SICHERE VORGEHENSWEISE:**
```bash
# 1. IMMER zuerst Überblick verschaffen
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# 2. NUR spezifische Container dieser App beeinflussen
docker-compose restart app
docker-compose -f docker-compose.production.yml restart nginx

# 3. NIEMALS globale Docker-Befehle ohne Filterung
```

### REGEL 2: NGINX REVERSE PROXY KRITISCH
- **nginx-domains.conf** = korrekte Multi-App Konfiguration 
- **nginx-ssl.conf** = falsche Single-App Konfiguration
- **IMMER** prüfen welche Config aktiv: `docker exec nginx_container head -20 /etc/nginx/nginx.conf`

### REGEL 3: VERIFIKATION NACH ÄNDERUNGEN PFLICHT
```bash
# IMMER alle drei Apps testen nach nginx-Änderungen:
curl -I https://schichtaufschreibung.hellertools.com
curl -I https://reportapp.hellertools.com  
curl -I https://projekttool.hellertools.com
```

### 🚨 NOTFALL-RECOVERY (falls andere Apps versehentlich gestoppt):
```bash
# Schicht-App wiederherstellen
cd /home/user/schicht-app-uhrzeit && docker-compose up -d

# Vikunja wiederherstellen  
docker start vikunja

# Diese App mit korrekter nginx-Konfiguration
docker-compose -f docker-compose.production.yml up -d
```

---

## ABC-KUNDEN FEATURE IMPLEMENTATION:

### Neue Features in dieser App:
- **ABC-Klassifikation** wird automatisch gefüllt basierend auf Kundennummer
- **Neukunde-Status** wird automatisch gesetzt
- Datenquelle: `/app/data/abc_customers.csv` (ABC-Kunden.csv gemountet)

### API Endpoints:
- `GET /api/customers/abc-data?customer_no={nummer}` - ABC-Daten für Kundennummer
- `GET /api/customers/find-by-field` - Erweitert um ABC-Daten

### Wichtige Files:
- `app/abc_customers.py` - ABC-Daten Loader
- `app/models.py` - ABCCustomer Model  
- Frontend: Auto-fill in `report_form.html`

---

## 📝 GIT WORKFLOW REGELN:

### REGEL 4: AUTOMATISCHES COMMITTEN & PUSHEN
**NACH JEDER CODE-ÄNDERUNG AUTOMATISCH:**
```bash
# 1. Änderungen hinzufügen
git add .

# 2. Commit mit aussagekräftiger Nachricht
git commit -m "beschreibung der änderung"

# 3. Zu GitHub pushen
git push origin master
```

**COMMIT-MESSAGE RICHTLINIEN:**
- `feat: neue funktion hinzugefügt`
- `fix: bug behoben`
- `update: feature erweitert`
- `refactor: code umstrukturiert`
- `docs: dokumentation aktualisiert`

### Git Historie Verhalten:
✅ **Normale Pushes** = Historie wird **ERWEITERT** (Commits hinzugefügt)

**NIEMALS Force Push verwenden - Historie muss immer erhalten bleiben!**

**IMMER nach Code-Änderungen automatisch pushen - User wünscht vollständige GitHub-Synchronisation!**

---

## ⚡ EFFIZIENTER CODE-UPDATE WORKFLOW:

### PROBLEM: Warum bisher immer Full Rebuild?
❌ **docker-compose.production.yml** hat **KEINE Volume Mounts** für app-Code
❌ Code wird nur beim **Build-Time** ins Image kopiert
❌ Änderungen sind **nicht automatisch** im Container sichtbar
❌ Deshalb bisher: `docker-compose up -d --build` (langsam!)

### ✅ LÖSUNG 1: FAST SYNC SCRIPT (EMPFOHLEN für Production)
```bash
# NACH Code-Änderungen (Templates, Python, etc.):
./sync-code.sh

# Das Script macht:
# 1. docker cp ./app/. container:/app/app/
# 2. docker-compose restart app (KEIN rebuild!)
# 3. Fertig in 5-10 Sekunden statt 2+ Minuten!
```

### ✅ LÖSUNG 2: DEVELOPMENT MODE (für intensive Entwicklung)
```bash
# Starte Development Container mit Volume Mounts:
docker-compose -f docker-compose.production.yml down
docker-compose -f docker-compose.dev.yml up -d

# Jetzt sind Änderungen SOFORT sichtbar (auto-reload)
# Zurück zu Production:
docker-compose -f docker-compose.dev.yml down
docker-compose -f docker-compose.production.yml up -d
```

### ⚠️ WANN Full Rebuild nötig:
- **Neue Dependencies** in requirements.txt
- **Dockerfile-Änderungen**
- **Systempackete** hinzugefügt
- **Erste Installation**

### 🚀 NEUE STANDARD-WORKFLOW:
1. **Code ändern** (Templates, Python, etc.)
2. **`./sync-code.sh`** ausführen (5-10 Sek)
3. **Git push** (automatisch)
4. **Fertig!** ✅

**NIEMALS mehr `--build` außer bei Dependencies/Dockerfile-Änderungen!**

---

## ✅ SELBST-CHECK VOR JEDER DOCKER-AKTION:

**KRITISCHE FRAGEN:**
1. Betrifft mein Befehl NUR diese App?
2. Laufen andere Production-Services die ich nicht beeinträchtigen darf?
3. Habe ich `docker ps` zur Übersicht ausgeführt?
4. Verwende ich spezifische Container-Namen statt globale Befehle?

**WENN EINE ANTWORT "NEIN" ODER UNSICHER → STOPPEN UND USER FRAGEN!**

---

**ERINNERUNG**: Diese Regeln haben OBERSTE PRIORITÄT. Niemals "Shortcuts" bei Production-Services. Andere Teams arbeiten mit anderen Apps auf diesem Server!