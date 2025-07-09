#!/usr/bin/env node

/**
 * Database Inspection Script
 * Inspects the current state of the database for security audit
 */

require('dotenv').config();
const { query } = require('./src/config/database');

async function inspectDatabase() {
  console.log('=== DATABASE INSPECTION ===\n');
  
  try {
    // Check users table
    console.log('1. USERS TABLE:');
    const users = query('SELECT u.id, u.name, u.email, ur.name as role_name FROM users u LEFT JOIN user_roles ur ON u.role_id = ur.id');
    console.log(JSON.stringify(users.rows, null, 2));
    
    // Check roles table
    console.log('\n2. ROLES TABLE:');
    const roles = query('SELECT * FROM user_roles');
    console.log(JSON.stringify(roles.rows, null, 2));
    
    // Check permissions table
    console.log('\n3. PERMISSIONS TABLE:');
    const permissions = query('SELECT * FROM permissions');
    console.log(JSON.stringify(permissions.rows, null, 2));
    
    // Check user permissions
    console.log('\n4. USER PERMISSIONS:');
    const userPermissions = query(`
      SELECT u.name, u.email, p.name as permission 
      FROM users u
      JOIN user_permissions up ON u.id = up.user_id
      JOIN permissions p ON up.permission_id = p.id
      ORDER BY u.name
    `);
    console.log(JSON.stringify(userPermissions.rows, null, 2));
    
    console.log('\n=== INSPECTION COMPLETE ===');
    
  } catch (error) {
    console.error('Error inspecting database:', error.message);
    console.error('Stack:', error.stack);
  }
}

inspectDatabase();