-- Regionen Tabelle
CREATE TABLE regions (
  id SERIAL PRIMARY KEY,
  code VARCHAR(20) UNIQUE NOT NULL,
  name VARCHAR(100) NOT NULL
);

-- Benutzer Tabelle
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  region_id INTEGER REFERENCES regions(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Kunden Tabelle
CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  kunde_nr VARCHAR(50) UNIQUE NOT NULL,
  name VARCHAR(255) NOT NULL,
  region_id INTEGER REFERENCES regions(id),
  klassifizierung CHAR(1) CHECK (klassifizierung IN ('A', 'B', 'C')),
  is_neukunde BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Berichte Tabelle
CREATE TABLE reports (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  customer_id INTEGER REFERENCES customers(id),
  ansprechpartner VARCHAR(255) NOT NULL,
  ort VARCHAR(255) NOT NULL,
  datum DATE NOT NULL,
  kurzbericht TEXT NOT NULL,
  todos TEXT,
  klassifizierung CHAR(1) CHECK (klassifizierung IN ('A', 'B', 'C')),
  auftragswert DECIMAL(10, 2),
  angebotswert DECIMAL(10, 2),
  naechster_besuch_wochen INTEGER,
  neukunde BOOLEAN DEFAULT false,
  uebernachtung BOOLEAN DEFAULT false,
  status CHAR(1) CHECK (status IN ('B', 'U', 'K', 'O', 'V', 'I')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX idx_reports_user_id ON reports(user_id);
CREATE INDEX idx_reports_customer_id ON reports(customer_id);
CREATE INDEX idx_reports_datum ON reports(datum);
CREATE INDEX idx_customers_region_id ON customers(region_id);
CREATE INDEX idx_users_region_id ON users(region_id);

-- Initial Regions
INSERT INTO regions (code, name) VALUES 
('BENE', 'Benelux'),
('DACHL', 'DACH & Länder'),
('EUEAST', 'EU East'),
('EUSOUTH', 'EU South'),
('IBERIA', 'Iberia'),
('ROW', 'Rest of World'),
('TCG', 'TCG'),
('UK', 'United Kingdom');