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
    order_value_eur = Column(Numeric(12, 2), nullable=False)
    offer_value_eur = Column(Numeric(12, 2), nullable=False)
    next_visit_weeks = Column(Integer, nullable=False)

    is_new_account = Column(Boolean, nullable=False)
    overnight = Column(Boolean, nullable=False)

    # Store normalized day status; UI maps to B/U/K (DE) or O/V/I (EN)
    day_status = Column(String, nullable=False)  # allowed: 'OFFICE','VACATION','ILLNESS'

    created_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())

    __table_args__ = (
        CheckConstraint("classification IN ('A','B','C')", name='check_classification'),
        CheckConstraint("day_status IN ('OFFICE','VACATION','ILLNESS')", name='check_day_status'),
        Index("ix_reports_owner_date", "owner_oid", "date"),
    )


class Customer(Base):
    __tablename__ = "customers"
    id = Column(Integer, primary_key=True, index=True)
    customer_no = Column(String, index=True, nullable=False)
    customer_name = Column(String, index=True, nullable=False)
    contact_person = Column(String, index=True, nullable=True)
    place = Column(String, index=True, nullable=True)
