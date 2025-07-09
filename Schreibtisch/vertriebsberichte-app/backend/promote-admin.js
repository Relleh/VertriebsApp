const Database = require('better-sqlite3');
const path = require('path');

const dbPath = path.resolve('./database.sqlite');
const db = new Database(dbPath);

const email = process.argv[2] || 'admin@test.com';

try {
  // Update user to admin role
  const result = db.prepare(`
    UPDATE users 
    SET role_id = (SELECT id FROM user_roles WHERE name = 'admin') 
    WHERE email = ?
  `).run(email);
  
  console.log('Admin promotion result:', result);
  
  // Verify the update
  const user = db.prepare(`
    SELECT u.*, ur.name as role_name 
    FROM users u 
    LEFT JOIN user_roles ur ON u.role_id = ur.id 
    WHERE u.email = ?
  `).get(email);
  
  console.log('Updated user:', user);
  
} catch (error) {
  console.error('Error:', error);
} finally {
  db.close();
}