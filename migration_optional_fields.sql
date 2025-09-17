-- Migration: Make order_value_eur and offer_value_eur optional
-- Date: 2025-08-27

-- Make the columns nullable and set default values
ALTER TABLE reports 
    ALTER COLUMN order_value_eur DROP NOT NULL,
    ALTER COLUMN order_value_eur SET DEFAULT 0,
    ALTER COLUMN offer_value_eur DROP NOT NULL,
    ALTER COLUMN offer_value_eur SET DEFAULT 0;

-- Update any existing NULL values to 0
UPDATE reports 
SET order_value_eur = 0 
WHERE order_value_eur IS NULL;

UPDATE reports 
SET offer_value_eur = 0 
WHERE offer_value_eur IS NULL;