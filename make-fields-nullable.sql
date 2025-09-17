-- Make fields nullable that can be empty in the Excel import
ALTER TABLE reports 
  ALTER COLUMN contact_person DROP NOT NULL,
  ALTER COLUMN place DROP NOT NULL,
  ALTER COLUMN short_report DROP NOT NULL,
  ALTER COLUMN next_steps DROP NOT NULL,
  ALTER COLUMN classification DROP NOT NULL,
  ALTER COLUMN order_value_eur DROP NOT NULL,
  ALTER COLUMN offer_value_eur DROP NOT NULL,
  ALTER COLUMN next_visit_weeks DROP NOT NULL,
  ALTER COLUMN day_status DROP NOT NULL;