from sqlalchemy import Column, Integer, String, Boolean, Date, Text, Numeric, DateTime, CheckConstraint, Index, func
from .database import Base

class Report(Base):
    __tablename__ = "reports"
    id = Column(Integer, primary_key=True, index=True)
    owner_oid = Column(String, index=True, nullable=False)
    owner_email = Column(String, nullable=True)
    owner_name = Column(String, nullable=True)

    customer_no = Column(String, nullable=False)
    customer_name = Column(String, nullable=False)
    contact_person = Column(String, nullable=False)
    place = Column(String, nullable=False)

    date = Column(Date, nullable=False)
    short_report = Column(Text, nullable=False)
    next_steps = Column(Text, nullable=False)

    classification = Column(String, nullable=False)  # allowed: 'A','B','C'
    order_value_eur = Column(Numeric(12, 2), nullable=True, default=0)
    offer_value_eur = Column(Numeric(12, 2), nullable=True, default=0)
    next_visit_weeks = Column(Integer, nullable=False)

    is_new_account = Column(Boolean, nullable=False)
    overnight = Column(Boolean, nullable=False)

    # Store normalized day status: MOBILE/OFFICE/PREVENTED
    day_status = Column(String, nullable=False)  # allowed: 'MOBILE','OFFICE','PREVENTED'

    # Neue Felder für vorgestellte Produkte
    presented_new_products = Column(Boolean, nullable=True)
    presented_diamond = Column(Boolean, nullable=True)
    presented_abrasive_backing = Column(Boolean, nullable=True)
    presented_cutting_discs = Column(Boolean, nullable=True)
    presented_current_promotion = Column(Boolean, nullable=True)

    # Angebot abgegeben und Angebotswert
    offer_submitted = Column(Boolean, nullable=True)  # No default value as requested
    offer_amount_eur = Column(Numeric(12, 2), nullable=True)

    created_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())

    __table_args__ = (
        CheckConstraint("classification IN ('A','B','C')", name='check_classification'),
        CheckConstraint("day_status IN ('MOBILE','OFFICE','PREVENTED')", name='check_day_status'),
        Index("ix_reports_owner_date", "owner_oid", "date"),
    )


class Customer(Base):
    __tablename__ = "customers"
    id = Column(Integer, primary_key=True, index=True)
    customer_no = Column(String, index=True, nullable=False)
    customer_name = Column(String, index=True, nullable=False)
    contact_person = Column(String, index=True, nullable=True)
    place = Column(String, index=True, nullable=True)


class ABCCustomer(Base):
    __tablename__ = "abc_customers"
    id = Column(Integer, primary_key=True, index=True)
    customer_no = Column(String, index=True, nullable=False, unique=True)
    abc_classification = Column(String, nullable=True)  # 'A', 'B', 'C' or '-' for none
    is_new_customer = Column(Boolean, default=False, nullable=False)
