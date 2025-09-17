# Produktions-Setup für öffentliche URL

## 1. Umgebungsvariablen konfigurieren

Kopieren Sie `.env.production` nach `.env` und passen Sie folgende Werte an:

```bash
# Sicherheitsschlüssel (WICHTIG!)
SESSION_SECRET=ihr-sicherer-zufälliger-schlüssel-hier

# Azure Entra ID (Microsoft OAuth)
ENTRA_TENANT_ID=ihre-azure-tenant-id
ENTRA_CLIENT_ID=ihre-azure-client-id  
ENTRA_CLIENT_SECRET=ihr-azure-client-secret
OAUTH_REDIRECT_URI=https://ihre-domain.com/auth/callback
```

## 2. Azure Entra ID App Registration

1. Gehen Sie zum Azure Portal → Azure Active Directory → App registrations
2. Erstellen Sie eine neue App Registration oder verwenden Sie eine bestehende
3. Setzen Sie die Redirect URI auf: `https://ihre-domain.com/auth/callback`
4. Notieren Sie sich:
   - Tenant ID (Directory ID)
   - Application (client) ID
   - Client Secret (erstellen Sie einen neuen wenn nötig)

## 3. Reverse Proxy Konfiguration

Ihr Firmen-Reverse-Proxy sollte auf folgende URL weiterleiten:
- **Ziel**: `http://192.168.62.114:8000`
- **Öffentliche URL**: `https://ihre-domain.com`

## 4. Container neu starten

Nach der Konfiguration:
```bash
docker-compose down
docker-compose up -d
```

## 5. Test

1. Besuchen Sie `https://ihre-domain.com`
2. Klicken Sie auf "Login" 
3. Sie sollten zur Microsoft-Anmeldung weitergeleitet werden
4. Nach erfolgreicher Anmeldung zurück zur App

## Wichtige Hinweise

- ⚠️ **SESSION_SECRET**: Verwenden Sie einen sicheren, zufälligen String!
- ⚠️ **HTTPS erforderlich**: OAuth funktioniert nur mit HTTPS
- ⚠️ **Redirect URI**: Muss exakt mit der Azure-Konfiguration übereinstimmen