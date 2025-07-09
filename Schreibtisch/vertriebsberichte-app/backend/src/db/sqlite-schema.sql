-- Regionen Tabelle
CREATE TABLE IF NOT EXISTS regions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  code VARCHAR(20) UNIQUE NOT NULL,
  name VARCHAR(100) NOT NULL
);

-- Benutzer Rollen Tabelle
CREATE TABLE IF NOT EXISTS user_roles (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(50) NOT NULL UNIQUE,
  description TEXT,
  created_at DATETIME DEFAULT (datetime('now'))
);

-- Berechtigungen Tabelle
CREATE TABLE IF NOT EXISTS permissions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(100) NOT NULL UNIQUE,
  description TEXT,
  resource VARCHAR(50) NOT NULL,
  action VARCHAR(50) NOT NULL,
  created_at DATETIME DEFAULT (datetime('now'))
);

-- Benutzer Berechtigungen Tabelle (Many-to-Many)
CREATE TABLE IF NOT EXISTS user_permissions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  permission_id INTEGER NOT NULL,
  granted_at DATETIME DEFAULT (datetime('now')),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE,
  UNIQUE(user_id, permission_id)
);

-- Benutzer Tabelle
CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  region_id INTEGER REFERENCES regions(id),
  role_id INTEGER REFERENCES user_roles(id),
  created_at DATETIME DEFAULT (datetime('now')),
  updated_at DATETIME DEFAULT (datetime('now'))
);

-- Kunden Tabelle
CREATE TABLE IF NOT EXISTS customers (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  kunde_nr VARCHAR(50) UNIQUE NOT NULL,
  name VARCHAR(255) NOT NULL,
  region_id INTEGER REFERENCES regions(id),
  klassifizierung CHAR(1) CHECK (klassifizierung IN ('A', 'B', 'C')),
  is_neukunde BOOLEAN DEFAULT 0,
  created_at DATETIME DEFAULT (datetime('now')),
  updated_at DATETIME DEFAULT (datetime('now'))
);

-- Berichte Tabelle
CREATE TABLE IF NOT EXISTS reports (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
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
  neukunde BOOLEAN DEFAULT 0,
  uebernachtung BOOLEAN DEFAULT 0,
  status CHAR(1) CHECK (status IN ('B', 'U', 'K', 'O', 'V', 'I')),
  created_at DATETIME DEFAULT (datetime('now')),
  updated_at DATETIME DEFAULT (datetime('now'))
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_reports_user_id ON reports(user_id);
CREATE INDEX IF NOT EXISTS idx_reports_customer_id ON reports(customer_id);
CREATE INDEX IF NOT EXISTS idx_reports_datum ON reports(datum);
CREATE INDEX IF NOT EXISTS idx_customers_region_id ON customers(region_id);
CREATE INDEX IF NOT EXISTS idx_users_region_id ON users(region_id);
CREATE INDEX IF NOT EXISTS idx_users_role_id ON users(role_id);
CREATE INDEX IF NOT EXISTS idx_user_permissions_user_id ON user_permissions(user_id);
CREATE INDEX IF NOT EXISTS idx_user_permissions_permission_id ON user_permissions(permission_id);

-- Initial Regions
INSERT OR IGNORE INTO regions (code, name) VALUES 
('BENE', 'Benelux'),
('DACHL', 'DACH & Länder'),
('EUEAST', 'EU East'),
('EUSOUTH', 'EU South'),
('IBERIA', 'Iberia'),
('ROW', 'Rest of World'),
('TCG', 'TCG'),
('UK', 'United Kingdom');

-- Initial User Roles
INSERT OR IGNORE INTO user_roles (name, description) VALUES 
('admin', 'Administrator mit vollständigen Systemrechten'),
('manager', 'Manager mit erweiterten Auswertungsrechten'),
('employee', 'Mitarbeiter mit Basis-Funktionen');

-- Initial Permissions
INSERT OR IGNORE INTO permissions (name, description, resource, action) VALUES 
('view_global_statistics', 'Globale Statistiken und Auswertungen anzeigen', 'statistics', 'view'),
('view_all_reports', 'Alle Berichte aller Mitarbeiter anzeigen', 'reports', 'view_all'),
('manage_users', 'Benutzer verwalten und Rollen zuweisen', 'users', 'manage'),
('manage_roles', 'Rollen und Berechtigungen verwalten', 'roles', 'manage'),
('export_data', 'Daten exportieren (PDF, Excel, etc.)', 'data', 'export'),
('view_team_reports', 'Team-Berichte der eigenen Region anzeigen', 'reports', 'view_team'),
('manage_customers', 'Kundendaten verwalten', 'customers', 'manage'),
('view_analytics', 'Erweiterte Analysen und Trends anzeigen', 'analytics', 'view');

-- Default permissions for each role
-- Admin permissions (all permissions)
INSERT OR IGNORE INTO user_permissions (user_id, permission_id) 
SELECT u.id, p.id FROM users u, permissions p 
WHERE u.role_id = (SELECT id FROM user_roles WHERE name = 'admin');

-- Manager permissions (selected permissions)
INSERT OR IGNORE INTO user_permissions (user_id, permission_id) 
SELECT u.id, p.id FROM users u, permissions p 
WHERE u.role_id = (SELECT id FROM user_roles WHERE name = 'manager') 
AND p.name IN ('view_global_statistics', 'view_team_reports', 'export_data', 'view_analytics');

-- Employee permissions (basic permissions)
INSERT OR IGNORE INTO user_permissions (user_id, permission_id) 
SELECT u.id, p.id FROM users u, permissions p 
WHERE u.role_id = (SELECT id FROM user_roles WHERE name = 'employee') 
AND p.name IN ('view_analytics');