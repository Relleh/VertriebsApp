#!/usr/bin/env node

const Database = require('better-sqlite3');
const path = require('path');

const dbPath = path.resolve('./database.sqlite');
const db = new Database(dbPath);

console.log('=== DATABASE INSPECTION ===\n');

try {
  // Check users table
  console.log('1. USERS TABLE:');
  const users = db.prepare(`
    SELECT u.id, u.name, u.email, ur.name as role_name 
    FROM users u 
    LEFT JOIN user_roles ur ON u.role_id = ur.id
  `).all();
  console.log(JSON.stringify(users, null, 2));
  
  // Check roles table  
  console.log('\n2. ROLES TABLE:');
  const roles = db.prepare('SELECT * FROM user_roles').all();
  console.log(JSON.stringify(roles, null, 2));
  
  // Check permissions table
  console.log('\n3. PERMISSIONS TABLE:');
  const permissions = db.prepare('SELECT * FROM permissions').all();
  console.log(JSON.stringify(permissions, null, 2));
  
  // Check user permissions
  console.log('\n4. USER PERMISSIONS:');
  const userPermissions = db.prepare(`
    SELECT u.name, u.email, p.name as permission 
    FROM users u
    JOIN user_permissions up ON u.id = up.user_id
    JOIN permissions p ON up.permission_id = p.id
    ORDER BY u.name
  `).all();
  console.log(JSON.stringify(userPermissions, null, 2));
  
} catch (error) {
  console.error('Error:', error.message);
} finally {
  db.close();
}

console.log('\n=== INSPECTION COMPLETE ===');