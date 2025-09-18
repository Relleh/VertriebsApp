from pydantic import BaseModel
from decimal import Decimal
from datetime import date
from typing import Optional

class ReportBase(BaseModel):
    customer_no: str
    customer_name: str
    contact_person: str
    place: str
    date: date
    short_report: str
    next_steps: str
    classification: str
    order_value_eur: Optional[Decimal] = Decimal('0.00')
    offer_value_eur: Optional[Decimal] = Decimal('0.00')
    next_visit_weeks: int
    is_new_account: bool
    overnight: bool
    day_status: str
    # Neue Felder für vorgestellte Produkte
    presented_new_products: Optional[bool] = None
    presented_diamond: Optional[bool] = None
    presented_coated_abrasives: Optional[bool] = None
    presented_cutting_discs: Optional[bool] = None
    presented_current_promotion: Optional[bool] = None
    # Angebot abgegeben und Angebotswert
    offer_submitted: Optional[bool] = None
    offer_amount_eur: Optional[Decimal] = None

class ReportCreate(ReportBase):
    pass

class ReportUpdate(ReportBase):
    pass
