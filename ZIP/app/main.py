import os
from datetime import date
from typing import Optional

from fastapi import FastAPI, Request, Depends, Form, HTTPException
from fastapi.staticfiles import StaticFiles
from fastapi.responses import RedirectResponse, JSONResponse
from fastapi.templating import Jinja2Templates
from starlette.middleware.sessions import SessionMiddleware
from sqlalchemy.orm import Session

from .database import Base, engine, get_db
from .models import Report
from .schemas import ReportCreate, ReportUpdate
from .i18n import t
from .auth import router as auth_router, get_current_user, User
from .customers import load_csv_into_db, search_customers

app = FastAPI(title="Vertriebsberichte App")
app.include_router(auth_router)

SECRET_KEY = os.environ.get('SESSION_SECRET', 'change-me')
app.add_middleware(SessionMiddleware, secret_key=SECRET_KEY, same_site='lax')

app.mount('/static', StaticFiles(directory=os.path.join(os.path.dirname(__file__), 'static')), name='static')
templates = Jinja2Templates(directory=os.path.join(os.path.dirname(__file__), 'templates'))

# Create tables on startup
Base.metadata.create_all(bind=engine)

# Load CSV initially
@app.on_event("startup")
def startup_load_csv():
    with next(get_db()) as db:
        try:
            load_csv_into_db(db)
        except Exception as e:
            print("[WARN] Konnte CSV nicht laden:", e)

def get_locale(request: Request) -> str:
    return request.session.get('locale') or os.environ.get('DEFAULT_LOCALE', 'de')

@app.get('/set-locale')
def set_locale(request: Request, lang: str = 'de'):
    request.session['locale'] = 'de' if lang == 'de' else 'en'
    referer = request.headers.get('referer') or '/'
    return RedirectResponse(url=referer)

@app.get('/')
def root(request: Request):
    if get_current_user(request):
        return RedirectResponse('/reports')
    # Not signed in -> landing with sign-in link
    locale = get_locale(request)
    return templates.TemplateResponse('index.html', {
        'request': request,
        't': lambda k: t(k, locale),
        'locale': locale,
        'user': None
    })

@app.get('/reports')
def list_reports(request: Request, db: Session = Depends(get_db)):
    user = get_current_user(request)
    if not user:
        return RedirectResponse('/login')
    locale = get_locale(request)
    rows = db.query(Report).filter(Report.owner_oid == user.oid).order_by(Report.date.desc()).all()
    return templates.TemplateResponse('reports_list.html', {
        'request': request,
        't': lambda k: t(k, locale),
        'locale': locale,
        'user': user,
        'reports': rows
    })

@app.get('/reports/new')
def new_report(request: Request):
    user = get_current_user(request)
    if not user:
        return RedirectResponse('/login')
    locale = get_locale(request)
    return templates.TemplateResponse('report_form.html', {
        'request': request,
        't': lambda k: t(k, locale),
        'locale': locale,
        'user': user,
        'action': '/reports/new',
        'report': None
    })

@app.post('/reports/new')
def create_report(
    request: Request,
    db: Session = Depends(get_db),
    # === Form Felder: alle als Pflicht; um optional zu machen, setzen Sie default=None (Form(None)) ===
    customer_no: str = Form(...),      # Pflicht-Flag hier ändern -> Form(None)
    customer_name: str = Form(...),    # Pflicht-Flag hier ändern -> Form(None)
    contact_person: str = Form(...),   # Pflicht-Flag hier ändern -> Form(None)
    place: str = Form(...),            # Pflicht-Flag hier ändern -> Form(None)
    date_val: str = Form(...),         # Pflicht-Flag hier ändern -> Form(None)
    short_report: str = Form(...),     # Pflicht-Flag hier ändern -> Form(None)
    next_steps: str = Form(...),       # Pflicht-Flag hier ändern -> Form(None)
    classification: str = Form(...),   # Pflicht-Flag hier ändern -> Form(None)
    order_value_eur: float = Form(...),# Pflicht-Flag hier ändern -> Form(None)
    offer_value_eur: float = Form(...),# Pflicht-Flag hier ändern -> Form(None)
    next_visit_weeks: int = Form(...), # Pflicht-Flag hier ändern -> Form(None)
    is_new_account: str = Form(...),   # 'yes'/'no'
    overnight: str = Form(...),        # 'yes'/'no'
    day_status_ui: str = Form(...),    # 'OFFICE'/'VACATION'/'ILLNESS' (UI mapped)
):
    user = get_current_user(request)
    if not user:
        return RedirectResponse('/login')
    locale = get_locale(request)
    # Validate
    if classification not in ('A','B','C'):
        raise HTTPException(status_code=400, detail='Invalid classification')
    if day_status_ui not in ('OFFICE','VACATION','ILLNESS'):
        raise HTTPException(status_code=400, detail='Invalid day status')
    r = Report(
        owner_oid=user.oid, owner_email=user.email, owner_name=user.name,
        customer_no=customer_no.strip(),
        customer_name=customer_name.strip(),
        contact_person=contact_person.strip(),
        place=place.strip(),
        date=date.fromisoformat(date_val),
        short_report=short_report.strip(),
        next_steps=next_steps.strip(),
        classification=classification,
        order_value_eur=order_value_eur,
        offer_value_eur=offer_value_eur,
        next_visit_weeks=next_visit_weeks,
        is_new_account=(is_new_account == 'yes'),
        overnight=(overnight == 'yes'),
        day_status=day_status_ui
    )
    db.add(r)
    db.commit()
    return RedirectResponse('/reports', status_code=303)

@app.get('/reports/{report_id}/edit')
def edit_report(report_id: int, request: Request, db: Session = Depends(get_db)):
    user = get_current_user(request)
    if not user:
        return RedirectResponse('/login')
    r = db.get(Report, report_id)
    if not r or r.owner_oid != user.oid:
        raise HTTPException(status_code=404)
    locale = get_locale(request)
    return templates.TemplateResponse('report_form.html', {
        'request': request,
        't': lambda k: t(k, locale),
        'locale': locale,
        'user': user,
        'action': f'/reports/{report_id}/edit',
        'report': r
    })

@app.post('/reports/{report_id}/edit')
def update_report(
    report_id: int,
    request: Request,
    db: Session = Depends(get_db),
    customer_no: str = Form(...),      # Pflicht-Flag hier ändern -> Form(None)
    customer_name: str = Form(...),    # Pflicht-Flag hier ändern -> Form(None)
    contact_person: str = Form(...),   # Pflicht-Flag hier ändern -> Form(None)
    place: str = Form(...),            # Pflicht-Flag hier ändern -> Form(None)
    date_val: str = Form(...),         # Pflicht-Flag hier ändern -> Form(None)
    short_report: str = Form(...),     # Pflicht-Flag hier ändern -> Form(None)
    next_steps: str = Form(...),       # Pflicht-Flag hier ändern -> Form(None)
    classification: str = Form(...),   # Pflicht-Flag hier ändern -> Form(None)
    order_value_eur: float = Form(...),# Pflicht-Flag hier ändern -> Form(None)
    offer_value_eur: float = Form(...),# Pflicht-Flag hier ändern -> Form(None)
    next_visit_weeks: int = Form(...), # Pflicht-Flag hier ändern -> Form(None)
    is_new_account: str = Form(...),
    overnight: str = Form(...),
    day_status_ui: str = Form(...),
):
    user = get_current_user(request)
    if not user:
        return RedirectResponse('/login')
    r = db.get(Report, report_id)
    if not r or r.owner_oid != user.oid:
        raise HTTPException(status_code=404)
    if classification not in ('A','B','C'):
        raise HTTPException(status_code=400, detail='Invalid classification')
    if day_status_ui not in ('OFFICE','VACATION','ILLNESS'):
        raise HTTPException(status_code=400, detail='Invalid day status')

    r.customer_no = customer_no.strip()
    r.customer_name = customer_name.strip()
    r.contact_person = contact_person.strip()
    r.place = place.strip()
    r.date = date.fromisoformat(date_val)
    r.short_report = short_report.strip()
    r.next_steps = next_steps.strip()
    r.classification = classification
    r.order_value_eur = order_value_eur
    r.offer_value_eur = offer_value_eur
    r.next_visit_weeks = next_visit_weeks
    r.is_new_account = (is_new_account == 'yes')
    r.overnight = (overnight == 'yes')
    r.day_status = day_status_ui
    db.commit()
    return RedirectResponse('/reports', status_code=303)

@app.get('/api/customers/suggest')
def api_customers_suggest(
    request: Request,
    db: Session = Depends(get_db),
    customer_no: Optional[str] = None,
    customer_name: Optional[str] = None,
    contact_person: Optional[str] = None,
    place: Optional[str] = None
):
    user = get_current_user(request)
    if not user:
        return JSONResponse(status_code=401, content={'error': 'unauthorized'})
    matches = search_customers(db, customer_no, customer_name, contact_person, place, limit=25)
    return {'matches': matches}

@app.get('/admin/reload-customers')
def reload_customers(request: Request, db: Session = Depends(get_db)):
    # Simple endpoint to reload CSV without restarting the container (local admin use).
    # Protect minimally: require login.
    user = get_current_user(request)
    if not user:
        return RedirectResponse('/login')
    try:
        inserted = load_csv_into_db(db)
    except Exception as e:
        return JSONResponse({'ok': False, 'error': str(e)})
    return JSONResponse({'ok': True, 'inserted': inserted})
