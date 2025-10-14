import os
from datetime import date
from typing import Optional
from io import BytesIO

from reportlab.lib.pagesizes import A4
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch
from reportlab.lib import colors

from fastapi import FastAPI, Request, Depends, Form, HTTPException, Query
from fastapi.staticfiles import StaticFiles
from fastapi.responses import RedirectResponse, JSONResponse, Response, StreamingResponse
from fastapi.templating import Jinja2Templates
from starlette.middleware.sessions import SessionMiddleware
from sqlalchemy.orm import Session

from .database import Base, engine, get_db
from .models import Report
from .schemas import ReportCreate, ReportUpdate
from .i18n import t
from .auth import router as auth_router, get_current_user, User, clean_owner_name
from .unified_customers import (
    load_unified_csv_into_db, search_customers, get_customer_number_suggestions,
    get_customer_name_suggestions, get_place_suggestions, find_matching_customers,
    get_customer_data
)

app = FastAPI(title="Vertriebsberichte App")

# Health check endpoint for production monitoring
@app.get('/health')
def health_check():
    return {'status': 'healthy', 'app': 'vertriebsberichte', 'version': '1.0'}

app.include_router(auth_router)

SECRET_KEY = os.environ.get('SESSION_SECRET', 'change-me')

app.add_middleware(SessionMiddleware, secret_key=SECRET_KEY, same_site='lax')

app.mount('/static', StaticFiles(directory=os.path.join(os.path.dirname(__file__), 'static')), name='static')
templates = Jinja2Templates(directory=os.path.join(os.path.dirname(__file__), 'templates'))

# Create tables on startup
Base.metadata.create_all(bind=engine)

# Load unified CSV initially
@app.on_event("startup")
def startup_load_csv():
    with next(get_db()) as db:
        try:
            customers_loaded = load_unified_csv_into_db(db)
            print(f"[INFO] Loaded {customers_loaded} customers from unified CSV")
        except Exception as e:
            print("[WARN] Could not load unified CSV:", e)

def get_locale(request: Request) -> str:
    # Check in this order: 1. Session, 2. Cookie, 3. Default
    locale = request.session.get('locale')
    if not locale:
        locale = request.cookies.get('locale')
        if locale and locale in ['de', 'en']:
            # Store in session for this request
            request.session['locale'] = locale
        else:
            locale = os.environ.get('DEFAULT_LOCALE', 'de')
    return locale

@app.get('/set-locale')
def set_locale(request: Request, lang: str = 'de'):
    # Validate language
    locale = 'de' if lang == 'de' else 'en'
    
    # Set in session for immediate use
    request.session['locale'] = locale
    
    # Create response with persistent cookie (1 year)
    referer = request.headers.get('referer') or '/'
    response = RedirectResponse(url=referer)
    
    # Set persistent cookie (expires in 1 year)
    response.set_cookie(
        key='locale',
        value=locale,
        max_age=365 * 24 * 60 * 60,  # 1 year in seconds
        httponly=False,  # Allow JavaScript access for localStorage sync
        secure=False,    # Set to True in production with HTTPS
        samesite='lax'
    )
    
    return response

@app.get('/')
def root(request: Request):
    user = get_current_user(request)
    print(f"[DEBUG] Root route - user: {user}")
    if user:
        print(f"[DEBUG] User found, redirecting to /reports")
        return RedirectResponse('/reports')
    # Not signed in -> landing with sign-in link
    print(f"[DEBUG] No user, showing landing page")
    locale = get_locale(request)
    return templates.TemplateResponse('index.html', {
        'request': request,
        't': lambda k: t(k, locale),
        'locale': locale,
        'user': None
    })

@app.get('/reports')
def list_reports(request: Request, db: Session = Depends(get_db), sort: str = Query('date'), order: str = Query('desc'), search: str = Query('')):
    user = get_current_user(request)
    if not user:
        return RedirectResponse('/login')
    locale = get_locale(request)
    
    # Build query with filtering
    query = db.query(Report).filter(Report.owner_oid == user.oid)
    
    # Apply search filter if provided
    if search.strip():
        search_term = f"%{search.strip()}%"
        query = query.filter(
            (Report.customer_name.ilike(search_term)) |
            (Report.customer_no.ilike(search_term)) |
            (Report.contact_person.ilike(search_term)) |
            (Report.place.ilike(search_term)) |
            (Report.short_report.ilike(search_term)) |
            (Report.next_steps.ilike(search_term)) |
            (Report.next_steps_field.ilike(search_term)) |
            (Report.next_steps_office.ilike(search_term)) |
            (Report.classification.ilike(search_term))
        )
    
    # Apply sorting
    if sort == 'date':
        if order == 'asc':
            query = query.order_by(Report.date.asc())
        else:
            query = query.order_by(Report.date.desc())
    elif sort == 'customer':
        if order == 'asc':
            query = query.order_by(Report.customer_name.asc())
        else:
            query = query.order_by(Report.customer_name.desc())
    else:  # default to date desc
        query = query.order_by(Report.date.desc())
    
    rows = query.all()
    return templates.TemplateResponse('reports_list.html', {
        'request': request,
        't': lambda k: t(k, locale),
        'locale': locale,
        'user': user,
        'reports': rows,
        'current_sort': sort,
        'current_order': order,
        'current_search': search
    })

@app.get('/reports/new')
def new_report(request: Request):
    user = get_current_user(request)
    if not user:
        return RedirectResponse('/login')
    locale = get_locale(request)
    response = templates.TemplateResponse('report_form.html', {
        'request': request,
        't': lambda k: t(k, locale),
        'locale': locale,
        'user': user,
        'action': '/reports/new',
        'report': None,
        'today': date.today().isoformat()
    })
    # Prevent browser caching to ensure fresh JavaScript loads
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "0"
    return response

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
    next_steps: Optional[str] = Form(None),  # Legacy field - optional
    next_steps_field: Optional[str] = Form(None),  # To-dos Außendienst
    next_steps_office: Optional[str] = Form(None), # To-dos Innendienst
    classification: str = Form(...),   # Pflicht-Flag hier ändern -> Form(None)
    order_value_eur: float = Form(0.0),
    offer_value_eur: float = Form(0.0),
    next_visit_weeks: int = Form(...), # Pflicht-Flag hier ändern -> Form(None)
    is_new_account: str = Form(...),   # 'yes'/'no'
    overnight: str = Form(...),        # 'yes'/'no'
    customer_active: str = Form(...),  # 'yes'/'no'
    day_status_ui: str = Form(...),    # 'MOBILE'/'OFFICE'/'PREVENTED'/'FAIR'/'SETUP' (UI mapped)
    # Neue Felder
    presented_new_products: Optional[str] = Form(None),
    presented_diamond: Optional[str] = Form(None),
    presented_coated_abrasives: Optional[str] = Form(None),
    presented_cutting_discs: Optional[str] = Form(None),
    presented_current_promotion: Optional[str] = Form(None),
    offer_submitted: Optional[str] = Form(None),
    offer_amount_eur: Optional[float] = Form(None)
):
    user = get_current_user(request)
    if not user:
        return RedirectResponse('/login')
    locale = get_locale(request)
    
    # Collect validation errors
    errors = []
    
    # Validate
    if classification not in ('A','B','C'):
        errors.append('Ungültige Klassifikation')
    if day_status_ui not in ('MOBILE','OFFICE','PREVENTED','FAIR','SETUP'):
        errors.append('Ungültiger Tagesstatus')
    
    # Date validation - no future dates allowed
    try:
        report_date = date.fromisoformat(date_val)
        if report_date > date.today():
            errors.append('Datum darf nicht in der Zukunft liegen')
    except ValueError:
        errors.append('Ungültiges Datumsformat')

    # Basic validation - just check not empty after strip
    if not short_report.strip():
        errors.append('Kurzbericht darf nicht leer sein')

    # Angebot validation - if offer submitted = yes, amount is required
    if offer_submitted == 'yes':
        if not offer_amount_eur or offer_amount_eur <= 0:
            errors.append('Angebotswert ist erforderlich wenn ein Angebot abgegeben wurde')

    # If there are errors, re-render the form with error messages
    if errors:
        return templates.TemplateResponse('report_form.html', {
            'request': request,
            't': lambda k: t(k, locale),
            'locale': locale,
            'user': user,
            'action': '/reports/new',
            'report': None,
            'today': date.today().isoformat(),
            'errors': errors,
            'form_data': {
                'customer_no': customer_no,
                'customer_name': customer_name,
                'contact_person': contact_person,
                'place': place,
                'date': date_val,
                'short_report': short_report,
                'next_steps': next_steps,
                'classification': classification,
                'order_value_eur': order_value_eur,
                'offer_value_eur': offer_value_eur,
                'next_visit_weeks': next_visit_weeks,
                'is_new_account': is_new_account,
                'overnight': overnight,
                'customer_active': customer_active,
                'day_status': day_status_ui,
                'presented_new_products': presented_new_products,
                'presented_diamond': presented_diamond,
                'presented_coated_abrasives': presented_coated_abrasives,
                'presented_cutting_discs': presented_cutting_discs,
                'presented_current_promotion': presented_current_promotion,
                'offer_submitted': offer_submitted,
                'offer_amount_eur': offer_amount_eur
            }
        })
    r = Report(
        owner_oid=user.oid, owner_email=user.email, owner_name=clean_owner_name(user.name),
        customer_no=customer_no.strip(),
        customer_name=customer_name.strip(),
        contact_person=contact_person.strip(),
        place=place.strip(),
        date=report_date,
        short_report=short_report.strip(),
        next_steps=next_steps.strip() if next_steps else None,
        next_steps_field=next_steps_field.strip() if next_steps_field else None,
        next_steps_office=next_steps_office.strip() if next_steps_office else None,
        classification=classification,
        order_value_eur=order_value_eur,
        offer_value_eur=offer_value_eur,
        next_visit_weeks=next_visit_weeks,
        is_new_account=(is_new_account == 'yes'),
        overnight=(overnight == 'yes'),
        customer_active=(customer_active == 'yes'),
        day_status=day_status_ui,
        # Neue Felder
        presented_new_products=(presented_new_products == 'true') if presented_new_products else None,
        presented_diamond=(presented_diamond == 'true') if presented_diamond else None,
        presented_coated_abrasives=(presented_coated_abrasives == 'true') if presented_coated_abrasives else None,
        presented_cutting_discs=(presented_cutting_discs == 'true') if presented_cutting_discs else None,
        presented_current_promotion=(presented_current_promotion == 'true') if presented_current_promotion else None,
        offer_submitted=(offer_submitted == 'yes') if offer_submitted else None,
        offer_amount_eur=offer_amount_eur if offer_amount_eur else None
    )
    db.add(r)
    db.commit()
    return RedirectResponse('/reports?saved=true', status_code=303)

@app.get('/reports/{report_id}/edit')
def edit_report(report_id: int, request: Request, db: Session = Depends(get_db)):
    user = get_current_user(request)
    if not user:
        return RedirectResponse('/login')
    r = db.get(Report, report_id)
    if not r or r.owner_oid != user.oid:
        raise HTTPException(status_code=404)
    locale = get_locale(request)
    response = templates.TemplateResponse('report_form.html', {
        'request': request,
        't': lambda k: t(k, locale),
        'locale': locale,
        'user': user,
        'action': f'/reports/{report_id}/edit',
        'report': r,
        'today': date.today().isoformat()
    })
    # Prevent browser caching to ensure fresh JavaScript loads
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "0"
    return response

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
    next_steps: Optional[str] = Form(None),  # Legacy field - optional
    next_steps_field: Optional[str] = Form(None),  # To-dos Außendienst
    next_steps_office: Optional[str] = Form(None), # To-dos Innendienst
    classification: str = Form(...),   # Pflicht-Flag hier ändern -> Form(None)
    order_value_eur: float = Form(0.0),
    offer_value_eur: float = Form(0.0),
    next_visit_weeks: int = Form(...), # Pflicht-Flag hier ändern -> Form(None)
    is_new_account: str = Form(...),
    overnight: str = Form(...),
    customer_active: str = Form(...),
    day_status_ui: str = Form(...),
    # Neue Felder
    presented_new_products: Optional[str] = Form(None),
    presented_diamond: Optional[str] = Form(None),
    presented_coated_abrasives: Optional[str] = Form(None),
    presented_cutting_discs: Optional[str] = Form(None),
    presented_current_promotion: Optional[str] = Form(None),
    offer_submitted: Optional[str] = Form(None),
    offer_amount_eur: Optional[float] = Form(None)
):
    user = get_current_user(request)
    if not user:
        return RedirectResponse('/login')
    r = db.get(Report, report_id)
    if not r or r.owner_oid != user.oid:
        raise HTTPException(status_code=404)
    
    locale = get_locale(request)
    errors = []
    
    if classification not in ('A','B','C'):
        errors.append('Ungültige Klassifikation')
    if day_status_ui not in ('MOBILE','OFFICE','PREVENTED','FAIR','SETUP'):
        errors.append('Ungültiger Tagesstatus')
    
    # Date validation - no future dates allowed
    try:
        report_date = date.fromisoformat(date_val)
        if report_date > date.today():
            errors.append('Datum darf nicht in der Zukunft liegen')
    except ValueError:
        errors.append('Ungültiges Datumsformat')

    # Basic validation - just check not empty after strip
    if not short_report.strip():
        errors.append('Kurzbericht darf nicht leer sein')

    # Angebot validation - if offer submitted = yes, amount is required
    if offer_submitted == 'yes':
        if not offer_amount_eur or offer_amount_eur <= 0:
            errors.append('Angebotswert ist erforderlich wenn ein Angebot abgegeben wurde')

    # If there are errors, re-render the form with error messages
    if errors:
        return templates.TemplateResponse('report_form.html', {
            'request': request,
            't': lambda k: t(k, locale),
            'locale': locale,
            'user': user,
            'action': f'/reports/{report_id}/edit',
            'report': r,
            'today': date.today().isoformat(),
            'errors': errors
        })

    r.customer_no = customer_no.strip()
    r.customer_name = customer_name.strip()
    r.contact_person = contact_person.strip()
    r.place = place.strip()
    r.date = report_date
    r.short_report = short_report.strip()
    r.next_steps = next_steps.strip() if next_steps else None
    r.next_steps_field = next_steps_field.strip() if next_steps_field else None
    r.next_steps_office = next_steps_office.strip() if next_steps_office else None
    r.classification = classification
    r.order_value_eur = order_value_eur
    r.offer_value_eur = offer_value_eur
    r.next_visit_weeks = next_visit_weeks
    r.is_new_account = (is_new_account == 'yes')
    r.overnight = (overnight == 'yes')
    r.customer_active = (customer_active == 'yes')
    r.day_status = day_status_ui
    # Neue Felder
    r.presented_new_products = (presented_new_products == 'true') if presented_new_products else None
    r.presented_diamond = (presented_diamond == 'true') if presented_diamond else None
    r.presented_coated_abrasives = (presented_coated_abrasives == 'true') if presented_coated_abrasives else None
    r.presented_cutting_discs = (presented_cutting_discs == 'true') if presented_cutting_discs else None
    r.presented_current_promotion = (presented_current_promotion == 'true') if presented_current_promotion else None
    r.offer_submitted = (offer_submitted == 'yes') if offer_submitted else None
    r.offer_amount_eur = offer_amount_eur if offer_amount_eur else None
    db.commit()
    return RedirectResponse('/reports?saved=true', status_code=303)

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
        # Force reload by resetting the cache
        from app import unified_customers
        unified_customers._last_loaded_mtime = None
        customers_loaded = load_unified_csv_into_db(db)
    except Exception as e:
        return JSONResponse({'ok': False, 'error': str(e)})
    return JSONResponse({'ok': True, 'customers_loaded': customers_loaded})

# New individual suggestion endpoints for enhanced autocomplete
@app.get('/api/suggestions/customer-no')
def suggest_customer_numbers(q: str = "", db: Session = Depends(get_db)):
    """Get customer number suggestions for autocomplete"""
    suggestions = get_customer_number_suggestions(db, q, limit=10)
    return {'suggestions': suggestions}

@app.get('/api/suggestions/customer-name')  
def suggest_customer_names(q: str = "", db: Session = Depends(get_db)):
    """Get customer name suggestions with multi-word support"""
    suggestions = get_customer_name_suggestions(db, q, limit=10)
    return {'suggestions': suggestions}

@app.get('/api/suggestions/place')
def suggest_places(q: str = "", db: Session = Depends(get_db)):
    """Get place suggestions for autocomplete"""
    suggestions = get_place_suggestions(db, q, limit=10)
    return {'suggestions': suggestions}

@app.get('/api/customers/find-by-field')
def find_customers_by_field(field: str, value: str, db: Session = Depends(get_db)):
    """Find customers by specific field for multi-match selection"""
    if field not in ['customer_no', 'customer_name', 'place']:
        raise HTTPException(status_code=400, detail='Invalid field')
    matches = find_matching_customers(db, field, value, limit=25)
    # Data already enriched in find_matching_customers from unified table
    return {'matches': matches}

@app.get('/api/customers/abc-data')
def get_customer_abc_data(customer_no: str, db: Session = Depends(get_db)):
    """Get ABC classification and new customer status for a customer number"""
    if not customer_no:
        return {'abc_classification': 'C', 'is_new_customer': False, 'is_default_classification': True}
    customer_data = get_customer_data(db, customer_no)
    if customer_data:
        return {
            'abc_classification': customer_data['abc_classification'],
            'is_new_customer': customer_data['is_new_customer'],
            'is_default_classification': customer_data['is_default_classification']
        }
    return {'abc_classification': 'C', 'is_new_customer': False, 'is_default_classification': True}

def generate_report_pdf(report, locale='de'):
    """Generate a PDF for a report"""
    buffer = BytesIO()

    # Create the PDF document
    doc = SimpleDocTemplate(buffer, pagesize=A4,
                          leftMargin=0.75*inch, rightMargin=0.75*inch,
                          topMargin=1*inch, bottomMargin=1*inch)

    # Get styles
    styles = getSampleStyleSheet()
    title_style = ParagraphStyle(
        'CustomTitle',
        parent=styles['Heading1'],
        fontSize=18,
        textColor=colors.darkblue,
        spaceAfter=20,
        alignment=1  # Center alignment
    )

    heading_style = ParagraphStyle(
        'CustomHeading',
        parent=styles['Heading2'],
        fontSize=14,
        textColor=colors.darkblue,
        spaceBefore=15,
        spaceAfter=10
    )

    content = []

    # Title
    content.append(Paragraph(t('pdf_title', locale), title_style))
    content.append(Spacer(1, 20))

    # Basic Data Table
    yes_no = lambda val: t('yes', locale) if val else t('no', locale)

    grunddaten_data = [
        [t('pdf_date', locale), str(report.date)],
        [t('pdf_customer_no', locale), report.customer_no],
        [t('pdf_customer_name', locale), report.customer_name],
        [t('pdf_contact_person', locale), report.contact_person],
        [t('pdf_place', locale), report.place],
        [t('pdf_classification', locale), report.classification],
        [t('pdf_day_status', locale), t(report.day_status.lower(), locale) if report.day_status else ''],
        [t('pdf_new_account', locale), yes_no(report.is_new_account)],
        [t('pdf_overnight', locale), yes_no(report.overnight)],
        [t('pdf_customer_active', locale), yes_no(report.customer_active)]
    ]

    content.append(Paragraph(t('pdf_basic_data', locale), heading_style))
    grunddaten_table = Table(grunddaten_data, colWidths=[2*inch, 4*inch])
    grunddaten_table.setStyle(TableStyle([
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (0, -1), 'Helvetica-Bold'),
        ('FONTNAME', (1, 0), (1, -1), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, -1), 10),
        ('ROWBACKGROUNDS', (0, 0), (-1, -1), [colors.lightgrey, colors.white]),
        ('GRID', (0, 0), (-1, -1), 1, colors.black)
    ]))
    content.append(grunddaten_table)
    content.append(Spacer(1, 20))

    # Values Table
    content.append(Paragraph(t('pdf_values', locale), heading_style))
    werte_data = [
        [t('pdf_order_value', locale), f"{float(report.order_value_eur):.2f}" if report.order_value_eur else "0.00"],
        [t('pdf_next_visit', locale), str(report.next_visit_weeks)]
    ]

    # Only show offer fields if an offer was actually submitted
    if report.offer_submitted is not None:
        werte_data.append([t('pdf_offer_submitted', locale), yes_no(report.offer_submitted)])
        if report.offer_submitted and report.offer_amount_eur:
            werte_data.append([t('pdf_offer_amount', locale), f"{float(report.offer_amount_eur):.2f}"])

    werte_table = Table(werte_data, colWidths=[2*inch, 4*inch])
    werte_table.setStyle(TableStyle([
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (0, -1), 'Helvetica-Bold'),
        ('FONTNAME', (1, 0), (1, -1), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, -1), 10),
        ('ROWBACKGROUNDS', (0, 0), (-1, -1), [colors.lightgrey, colors.white]),
        ('GRID', (0, 0), (-1, -1), 1, colors.black)
    ]))
    content.append(werte_table)
    content.append(Spacer(1, 20))

    # Presented Products
    if any([report.presented_new_products, report.presented_diamond,
            report.presented_coated_abrasives, report.presented_cutting_discs,
            report.presented_current_promotion]):
        content.append(Paragraph(t('pdf_presented_products', locale), heading_style))
        produkte_data = []
        if report.presented_new_products: produkte_data.append([t('pdf_new_products', locale), t('yes', locale)])
        if report.presented_diamond: produkte_data.append([t('pdf_diamond', locale), t('yes', locale)])
        if report.presented_coated_abrasives: produkte_data.append([t('pdf_coated_abrasives', locale), t('yes', locale)])
        if report.presented_cutting_discs: produkte_data.append([t('pdf_cutting_discs', locale), t('yes', locale)])
        if report.presented_current_promotion: produkte_data.append([t('pdf_current_promotion', locale), t('yes', locale)])

        produkte_table = Table(produkte_data, colWidths=[2*inch, 4*inch])
        produkte_table.setStyle(TableStyle([
            ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
            ('FONTNAME', (0, 0), (0, -1), 'Helvetica-Bold'),
            ('FONTNAME', (1, 0), (1, -1), 'Helvetica'),
            ('FONTSIZE', (0, 0), (-1, -1), 10),
            ('ROWBACKGROUNDS', (0, 0), (-1, -1), [colors.lightgrey, colors.white]),
            ('GRID', (0, 0), (-1, -1), 1, colors.black)
        ]))
        content.append(produkte_table)
        content.append(Spacer(1, 20))

    # Short Report
    content.append(Paragraph(t('pdf_short_report', locale), heading_style))
    content.append(Paragraph(report.short_report, styles['Normal']))
    content.append(Spacer(1, 15))

    # Next Steps - Field Service
    next_steps_field_title = 'To-dos/Nächste Schritte Außendienst' if locale == 'de' else 'To-dos/Next steps field service'
    content.append(Paragraph(next_steps_field_title, heading_style))
    next_steps_field_text = report.next_steps_field if report.next_steps_field else (report.next_steps if report.next_steps else '')
    if next_steps_field_text:
        content.append(Paragraph(next_steps_field_text, styles['Normal']))
    content.append(Spacer(1, 15))

    # Next Steps - Office
    next_steps_office_title = 'To-dos/Nächste Schritte Innendienst' if locale == 'de' else 'To-dos/Next steps office'
    content.append(Paragraph(next_steps_office_title, heading_style))
    next_steps_office_text = report.next_steps_office if report.next_steps_office else ''
    if next_steps_office_text:
        content.append(Paragraph(next_steps_office_text, styles['Normal']))
    content.append(Spacer(1, 20))

    # Created by
    content.append(Paragraph(f"{t('pdf_created_by', locale)}: {report.owner_name or report.owner_email}", styles['Normal']))
    if report.created_at:
        date_format = '%d.%m.%Y %H:%M' if locale == 'de' else '%m/%d/%Y %H:%M'
        content.append(Paragraph(f"{t('pdf_created_at', locale)}: {report.created_at.strftime(date_format)}", styles['Normal']))
    else:
        unknown_text = 'Unbekannt' if locale == 'de' else 'Unknown'
        content.append(Paragraph(f"{t('pdf_created_at', locale)}: {unknown_text}", styles['Normal']))

    # Build PDF
    doc.build(content)
    buffer.seek(0)
    return buffer

@app.get('/reports/{report_id}/pdf')
def download_report_pdf(report_id: int, request: Request, db: Session = Depends(get_db)):
    """Generate and download PDF for a report"""
    user = get_current_user(request)
    if not user:
        return RedirectResponse('/login')

    # Get the report
    report = db.get(Report, report_id)
    if not report or report.owner_oid != user.oid:
        raise HTTPException(status_code=404, detail="Report not found")

    locale = get_locale(request)

    # Generate PDF
    pdf_buffer = generate_report_pdf(report, locale)

    # Create filename
    file_prefix = "vertriebsbericht" if locale == 'de' else "sales_report"
    filename = f"{file_prefix}_{report.customer_no}_{report.date}.pdf"

    # Return as streaming response for download
    return StreamingResponse(
        BytesIO(pdf_buffer.read()),
        media_type="application/pdf",
        headers={"Content-Disposition": f"attachment; filename={filename}"}
    )

