const Database = require('better-sqlite3');
const path = require('path');

const dbPath = path.resolve('./database.sqlite');
const db = new Database(dbPath);

console.log('=== Database Schema Migration ===');

try {
  // Begin transaction
  db.exec('BEGIN TRANSACTION');
  
  // 1. Add role field to users table
  console.log('Adding role field to users table...');
  db.exec(`ALTER TABLE users ADD COLUMN role VARCHAR(20) DEFAULT 'employee'`);
  
  // Set first user as admin if exists
  const firstUser = db.prepare('SELECT id FROM users ORDER BY id ASC LIMIT 1').get();
  if (firstUser) {
    db.prepare('UPDATE users SET role = ? WHERE id = ?').run('admin', firstUser.id);
    console.log(`Set user ${firstUser.id} as admin`);
  }
  
  // 2. Create permissions table
  console.log('Creating permissions table...');
  db.exec(`
    CREATE TABLE IF NOT EXISTS permissions (
      id INTEGER PRIMARY KEY,
      role VARCHAR(20) NOT NULL,
      resource VARCHAR(50) NOT NULL,
      action VARCHAR(50) NOT NULL,
      created_at DATETIME DEFAULT datetime('now')
    )
  `);
  
  // 3. Insert default permissions
  console.log('Inserting default permissions...');
  const permissions = [
    // Admin permissions
    ['admin', 'statistics', 'view_global'],
    ['admin', 'statistics', 'view_detailed'],
    ['admin', 'statistics', 'export'],
    ['admin', 'users', 'manage'],
    ['admin', 'reports', 'view_all'],
    ['admin', 'reports', 'manage_all'],
    
    // Manager permissions
    ['manager', 'statistics', 'view_regional'],
    ['manager', 'statistics', 'view_detailed'],
    ['manager', 'statistics', 'export'],
    ['manager', 'reports', 'view_regional'],
    ['manager', 'reports', 'manage_regional'],
    
    // Employee permissions
    ['employee', 'statistics', 'view_own'],
    ['employee', 'reports', 'view_own'],
    ['employee', 'reports', 'manage_own']
  ];
  
  const insertPermission = db.prepare('INSERT OR IGNORE INTO permissions (role, resource, action) VALUES (?, ?, ?)');
  permissions.forEach(([role, resource, action]) => {
    insertPermission.run(role, resource, action);
  });
  
  // 4. Create audit log table
  console.log('Creating audit log table...');
  db.exec(`
    CREATE TABLE IF NOT EXISTS audit_logs (
      id INTEGER PRIMARY KEY,
      user_id INTEGER,
      action VARCHAR(100) NOT NULL,
      resource VARCHAR(50) NOT NULL,
      resource_id INTEGER,
      details TEXT,
      ip_address VARCHAR(45),
      user_agent TEXT,
      created_at DATETIME DEFAULT datetime('now'),
      FOREIGN KEY (user_id) REFERENCES users(id)
    )
  `);
  
  // 5. Create indexes for better performance
  console.log('Creating indexes...');
  db.exec(`
    CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);
    CREATE INDEX IF NOT EXISTS idx_users_region_role ON users(region_id, role);
    CREATE INDEX IF NOT EXISTS idx_audit_logs_user ON audit_logs(user_id);
    CREATE INDEX IF NOT EXISTS idx_audit_logs_created ON audit_logs(created_at);
    CREATE INDEX IF NOT EXISTS idx_reports_user_created ON reports(user_id, created_at);
  `);
  
  // Commit transaction
  db.exec('COMMIT');
  
  console.log('✅ Migration completed successfully!');
  
  // Show updated schema
  console.log('\n=== Updated Schema ===');
  const updatedSchema = db.prepare("PRAGMA table_info(users)").all();
  console.log('Users table columns:');
  updatedSchema.forEach(column => {
    console.log(`  ${column.name}: ${column.type} ${column.notnull ? 'NOT NULL' : ''} ${column.dflt_value ? `DEFAULT ${column.dflt_value}` : ''}`);
  });
  
  // Show permissions
  console.log('\n=== Permissions ===');
  const allPermissions = db.prepare('SELECT * FROM permissions ORDER BY role, resource, action').all();
  allPermissions.forEach(perm => {
    console.log(`  ${perm.role}: ${perm.resource}.${perm.action}`);
  });
  
} catch (error) {
  console.error('❌ Migration failed:', error);
  db.exec('ROLLBACK');
} finally {
  db.close();
}