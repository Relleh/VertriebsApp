-- Migration: Add product presentation and offer fields
-- Date: 2025-01-17
-- Description: Adds fields for tracking presented products and offer submissions

-- Add product presentation checkboxes
ALTER TABLE reports ADD COLUMN IF NOT EXISTS presented_new_products BOOLEAN;
ALTER TABLE reports ADD COLUMN IF NOT EXISTS presented_diamond BOOLEAN;
ALTER TABLE reports ADD COLUMN IF NOT EXISTS presented_abrasive_backing BOOLEAN;
ALTER TABLE reports ADD COLUMN IF NOT EXISTS presented_cutting_discs BOOLEAN;
ALTER TABLE reports ADD COLUMN IF NOT EXISTS presented_current_promotion BOOLEAN;

-- Add offer submission fields
ALTER TABLE reports ADD COLUMN IF NOT EXISTS offer_submitted BOOLEAN;
ALTER TABLE reports ADD COLUMN IF NOT EXISTS offer_amount_eur NUMERIC(12, 2);

-- No default values as requested - all fields are nullable for existing records