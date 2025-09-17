from pydantic import BaseModel
from decimal import Decimal
from datetime import date

class ReportBase(BaseModel):
    customer_no: str
    customer_name: str
    contact_person: str
    place: str
    date: date
    short_report: str
    next_steps: str
    classification: str
    order_value_eur: Decimal
    offer_value_eur: Decimal
    next_visit_weeks: int
    is_new_account: bool
    overnight: bool
    day_status: str

class ReportCreate(ReportBase):
    pass

class ReportUpdate(ReportBase):
    pass
