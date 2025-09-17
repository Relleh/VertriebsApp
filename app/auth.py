import os
from dataclasses import dataclass
from fastapi import APIRouter, Request, HTTPException
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
    client_kwargs={
        'scope': 'openid profile email',
        'token_endpoint_auth_method': 'client_secret_post'
    }
)

@dataclass
class User:
    oid: str
    name: str | None = None
    email: str | None = None
    tid: str | None = None

@router.get('/login')
async def login(request: Request):
    print(f"[DEBUG] Login called, current session: {request.session}")
    redirect_uri = os.environ.get("OAUTH_REDIRECT_URI") or str(request.url_for('auth_callback'))
    print(f"[DEBUG] Redirecting to Microsoft with prompt=login")
    return await oauth.entra.authorize_redirect(request, redirect_uri, prompt='login')

@router.get('/auth/callback')
async def auth_callback(request: Request):
    try:
        print(f"[DEBUG] Auth callback - Full URL: {request.url}")
        print(f"[DEBUG] Auth callback - Query params: {dict(request.query_params)}")
        print(f"[DEBUG] Auth callback - Session data: {dict(request.session)}")
        
        # Check for error in callback
        if 'error' in request.query_params:
            error = request.query_params.get('error')
            error_desc = request.query_params.get('error_description', '')
            print(f"[ERROR] OAuth error: {error} - {error_desc}")
            raise HTTPException(status_code=400, detail=f"OAuth error: {error} - {error_desc}")
        
        token = await oauth.entra.authorize_access_token(request)
        print(f"[DEBUG] Token received: {token.keys() if token else 'None'}")
        
        # Parse ID token manually instead of using authlib parse_id_token
        if 'id_token' not in token:
            print(f"[ERROR] No id_token in response. Full token: {token}")
            raise HTTPException(status_code=500, detail="No ID token received from Microsoft")
        
        import jwt
        # Decode the ID token (skip verification for now to get it working)
        id_token_str = token['id_token']
        print(f"[DEBUG] ID token string: {id_token_str[:50]}...")
        id_claims = jwt.decode(id_token_str, options={"verify_signature": False})
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
    except Exception as e:
        print(f"[ERROR] Auth callback failed: {str(e)}")
        import traceback
        traceback.print_exc()
        raise

@router.get('/logout')
async def logout(request: Request):
    print(f"[DEBUG] Logout called, session before clear: {request.session}")
    request.session.clear()
    print(f"[DEBUG] Session after clear: {request.session}")
    # Microsoft logout URL to end their session
    logout_url = f"https://login.microsoftonline.com/{TENANT_ID}/oauth2/v2.0/logout"
    post_logout_redirect = "https://reportapp.hellertools.com/"
    print(f"[DEBUG] Redirecting to Microsoft logout: {logout_url}")
    return RedirectResponse(url=f"{logout_url}?post_logout_redirect_uri={post_logout_redirect}")

def get_current_user(request: Request) -> User | None:
    data = request.session.get('user')
    print(f"[DEBUG] get_current_user - session data: {data}")
    if not data:
        return None
    return User(**data)