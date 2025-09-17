import os
from dataclasses import dataclass
from fastapi import APIRouter, Request
from fastapi.responses import RedirectResponse
from authlib.integrations.starlette_client import OAuth
from starlette.config import Config

TENANT_ID = os.environ.get("ENTRA_TENANT_ID", "common")
CLIENT_ID = os.environ.get("ENTRA_CLIENT_ID", "")
CLIENT_SECRET = os.environ.get("ENTRA_CLIENT_SECRET", "")

router = APIRouter()
oauth = OAuth(Config(environ=os.environ))
oauth.register(
    name='entra',
    server_metadata_url=f'https://login.microsoftonline.com/{TENANT_ID}/v2.0/.well-known/openid-configuration',
    client_id=CLIENT_ID,
    client_secret=CLIENT_SECRET,
    client_kwargs={'scope': 'openid profile email'}
)

@dataclass
class User:
    oid: str
    name: str | None = None
    email: str | None = None
    tid: str | None = None

@router.get('/login')
async def login(request: Request):
    redirect_uri = os.environ.get("OAUTH_REDIRECT_URI") or str(request.url_for('auth_callback'))
    return await oauth.entra.authorize_redirect(request, redirect_uri)

@router.get('/auth/callback')
async def auth_callback(request: Request):
    token = await oauth.entra.authorize_access_token(request)
    # Parse ID token (verifies signature using provider metadata / jwks)
    id_claims = await oauth.entra.parse_id_token(request, token)
    user = User(
        oid=id_claims.get('oid') or id_claims.get('sub'),
        name=id_claims.get('name'),
        email=id_claims.get('preferred_username') or id_claims.get('email'),
        tid=id_claims.get('tid')
    )
    request.session['user'] = user.__dict__
    # Default locale if not set already
    if 'locale' not in request.session:
        request.session['locale'] = os.environ.get('DEFAULT_LOCALE', 'de')
    return RedirectResponse(url='/reports')

@router.get('/logout')
async def logout(request: Request):
    request.session.clear()
    return RedirectResponse(url='/')

def get_current_user(request: Request) -> User | None:
    data = request.session.get('user')
    if not data:
        return None
    return User(**data)


def get_current_user(request: Request) -> User | None:
    # Temporär deaktiviert für Testing
    return User(oid="test123", email="test@example.com", name="Test User")
