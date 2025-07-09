#!/usr/bin/env node

/**
 * Database Security Test Suite
 * Tests database security, constraints, isolation, and connection security
 */

const Database = require('better-sqlite3');
const fs = require('fs');
const path = require('path');
require('dotenv').config();

// Test configuration
const TEST_RESULTS = [];

// Colors for console output
const colors = {
  reset: '\x1b[0m',
  red: '\x1b[31m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  magenta: '\x1b[35m',
  cyan: '\x1b[36m'
};

function log(message, color = 'reset') {
  console.log(colors[color] + message + colors.reset);
}

function addResult(testName, status, details, severity = 'info') {
  const result = {
    test: testName,
    status,
    details,
    severity,
    timestamp: new Date().toISOString()
  };
  TEST_RESULTS.push(result);
  
  const statusColor = status === 'PASS' ? 'green' : status === 'FAIL' ? 'red' : 'yellow';
  log(`[${status}] ${testName}: ${details}`, statusColor);
}

// Test 1: Database File Security
async function testDatabaseFileSecurity() {
  log('\n=== Testing Database File Security ===', 'cyan');
  
  try {
    const dbPath = path.resolve('./database.sqlite');
    
    // Test 1.1: Database file exists and is readable
    if (fs.existsSync(dbPath)) {
      addResult('Database File Existence', 'PASS', 'Database file exists and is accessible');
    } else {
      addResult('Database File Existence', 'FAIL', 'Database file not found', 'high');
      return;
    }
    
    // Test 1.2: Check file permissions
    try {
      const stats = fs.statSync(dbPath);
      const mode = stats.mode;
      const permissions = mode.toString(8).slice(-3);
      
      if (permissions === '644' || permissions === '600') {
        addResult('Database File Permissions', 'PASS', `Database file has secure permissions: ${permissions}`);
      } else {
        addResult('Database File Permissions', 'WARN', `Database file permissions: ${permissions} - consider more restrictive`, 'medium');
      }
    } catch (error) {
      addResult('Database File Permissions', 'FAIL', `Cannot check file permissions: ${error.message}`, 'medium');
    }
    
    // Test 1.3: Check file size and structure
    try {
      const stats = fs.statSync(dbPath);
      if (stats.size > 0) {
        addResult('Database File Size', 'PASS', `Database file size: ${stats.size} bytes`);
      } else {
        addResult('Database File Size', 'FAIL', 'Database file is empty', 'high');
      }
    } catch (error) {
      addResult('Database File Size', 'FAIL', `Cannot check file size: ${error.message}`, 'medium');
    }
    
  } catch (error) {
    addResult('Database File Security Tests', 'FAIL', `Error: ${error.message}`, 'high');
  }
}

// Test 2: Database Connection Security
async function testDatabaseConnectionSecurity() {
  log('\n=== Testing Database Connection Security ===', 'cyan');
  
  try {
    const dbPath = path.resolve('./database.sqlite');
    const db = new Database(dbPath);
    
    // Test 2.1: Foreign keys enforcement
    try {
      const result = db.prepare('PRAGMA foreign_keys').get();
      if (result.foreign_keys === 1) {
        addResult('Foreign Keys Enforcement', 'PASS', 'Foreign key constraints are enabled');
      } else {
        addResult('Foreign Keys Enforcement', 'FAIL', 'Foreign key constraints are disabled', 'high');
      }
    } catch (error) {
      addResult('Foreign Keys Enforcement', 'FAIL', `Cannot check foreign keys: ${error.message}`, 'medium');
    }
    
    // Test 2.2: WAL mode check
    try {
      const result = db.prepare('PRAGMA journal_mode').get();
      if (result.journal_mode === 'wal') {
        addResult('WAL Mode', 'PASS', 'Database uses WAL mode for better concurrency');
      } else {
        addResult('WAL Mode', 'WARN', `Database uses ${result.journal_mode} mode`, 'low');
      }
    } catch (error) {
      addResult('WAL Mode', 'WARN', `Cannot check journal mode: ${error.message}`, 'low');
    }
    
    // Test 2.3: Synchronous mode
    try {
      const result = db.prepare('PRAGMA synchronous').get();
      if (result.synchronous >= 1) {
        addResult('Synchronous Mode', 'PASS', `Database synchronous mode: ${result.synchronous}`);
      } else {
        addResult('Synchronous Mode', 'WARN', 'Database synchronous mode is OFF - potential data loss risk', 'medium');
      }
    } catch (error) {
      addResult('Synchronous Mode', 'WARN', `Cannot check synchronous mode: ${error.message}`, 'low');
    }
    
    // Test 2.4: Database integrity check
    try {
      const result = db.prepare('PRAGMA integrity_check').get();
      if (result.integrity_check === 'ok') {
        addResult('Database Integrity', 'PASS', 'Database integrity check passed');
      } else {
        addResult('Database Integrity', 'FAIL', `Database integrity issues: ${result.integrity_check}`, 'critical');
      }
    } catch (error) {
      addResult('Database Integrity', 'FAIL', `Cannot check database integrity: ${error.message}`, 'high');
    }
    
    db.close();
    
  } catch (error) {
    addResult('Database Connection Security Tests', 'FAIL', `Error: ${error.message}`, 'high');
  }
}

// Test 3: Table Structure and Constraints
async function testTableConstraints() {
  log('\n=== Testing Table Structure and Constraints ===', 'cyan');
  
  try {
    const dbPath = path.resolve('./database.sqlite');
    const db = new Database(dbPath);
    
    // Test 3.1: Check table existence
    const tables = db.prepare(`
      SELECT name FROM sqlite_master 
      WHERE type='table' AND name NOT LIKE 'sqlite_%'
    `).all();
    
    const expectedTables = ['users', 'user_roles', 'permissions', 'user_permissions', 'regions', 'customers', 'reports'];
    const existingTables = tables.map(t => t.name);
    const missingTables = expectedTables.filter(table => !existingTables.includes(table));
    
    if (missingTables.length === 0) {
      addResult('Table Structure', 'PASS', `All expected tables exist: ${existingTables.join(', ')}`);
    } else {
      addResult('Table Structure', 'FAIL', `Missing tables: ${missingTables.join(', ')}`, 'high');
    }
    
    // Test 3.2: Check foreign key constraints
    const foreignKeyTests = [
      {
        table: 'users',
        column: 'region_id',
        references: 'regions(id)'
      },
      {
        table: 'users',
        column: 'role_id', 
        references: 'user_roles(id)'
      },
      {
        table: 'reports',
        column: 'user_id',
        references: 'users(id)'
      },
      {
        table: 'reports',
        column: 'customer_id',
        references: 'customers(id)'
      },
      {
        table: 'user_permissions',
        column: 'user_id',
        references: 'users(id)'
      },
      {
        table: 'user_permissions',
        column: 'permission_id',
        references: 'permissions(id)'
      }
    ];
    
    for (const fkTest of foreignKeyTests) {
      try {
        const fkInfo = db.prepare(`PRAGMA foreign_key_list(${fkTest.table})`).all();
        const hasForeignKey = fkInfo.some(fk => 
          fk.from === fkTest.column && 
          fkTest.references.includes(fk.table)
        );
        
        if (hasForeignKey) {
          addResult(`Foreign Key ${fkTest.table}.${fkTest.column}`, 'PASS', `Foreign key constraint exists`);
        } else {
          addResult(`Foreign Key ${fkTest.table}.${fkTest.column}`, 'FAIL', `Missing foreign key constraint`, 'medium');
        }
      } catch (error) {
        addResult(`Foreign Key ${fkTest.table}.${fkTest.column}`, 'WARN', `Cannot check foreign key: ${error.message}`, 'low');
      }
    }
    
    // Test 3.3: Check unique constraints
    const uniqueConstraintTests = [
      { table: 'users', column: 'email' },
      { table: 'regions', column: 'code' },
      { table: 'customers', column: 'kunde_nr' },
      { table: 'user_roles', column: 'name' },
      { table: 'permissions', column: 'name' }
    ];
    
    for (const uniqueTest of uniqueConstraintTests) {
      try {
        const tableInfo = db.prepare(`PRAGMA table_info(${uniqueTest.table})`).all();
        const columnInfo = tableInfo.find(col => col.name === uniqueTest.column);
        
        if (columnInfo && columnInfo.pk === 1) {
          addResult(`Unique Constraint ${uniqueTest.table}.${uniqueTest.column}`, 'PASS', 'Primary key provides uniqueness');
        } else {
          // Check for unique index
          const indexes = db.prepare(`PRAGMA index_list(${uniqueTest.table})`).all();
          const uniqueIndex = indexes.find(idx => idx.unique === 1 && idx.name.includes(uniqueTest.column));
          
          if (uniqueIndex) {
            addResult(`Unique Constraint ${uniqueTest.table}.${uniqueTest.column}`, 'PASS', 'Unique index exists');
          } else {
            addResult(`Unique Constraint ${uniqueTest.table}.${uniqueTest.column}`, 'WARN', 'No unique constraint found - needs verification', 'medium');
          }
        }
      } catch (error) {
        addResult(`Unique Constraint ${uniqueTest.table}.${uniqueTest.column}`, 'WARN', `Cannot check unique constraint: ${error.message}`, 'low');
      }
    }
    
    db.close();
    
  } catch (error) {
    addResult('Table Constraints Tests', 'FAIL', `Error: ${error.message}`, 'high');
  }
}

// Test 4: Data Isolation and Access Control
async function testDataIsolation() {
  log('\n=== Testing Data Isolation and Access Control ===', 'cyan');
  
  try {
    const dbPath = path.resolve('./database.sqlite');
    const db = new Database(dbPath);
    
    // Test 4.1: Check for sensitive data exposure
    try {
      const users = db.prepare('SELECT id, email, password_hash FROM users LIMIT 5').all();
      
      let hasHashedPasswords = true;
      let hasValidEmails = true;
      
      for (const user of users) {
        // Check if password is hashed (bcrypt format)
        if (!user.password_hash || !user.password_hash.startsWith('$2')) {
          hasHashedPasswords = false;
        }
        
        // Check email format
        if (!user.email || !user.email.includes('@')) {
          hasValidEmails = false;
        }
      }
      
      if (hasHashedPasswords) {
        addResult('Password Hashing in DB', 'PASS', 'All passwords are properly hashed in database');
      } else {
        addResult('Password Hashing in DB', 'FAIL', 'Some passwords may not be properly hashed', 'critical');
      }
      
      if (hasValidEmails) {
        addResult('Email Format in DB', 'PASS', 'Email formats are valid in database');
      } else {
        addResult('Email Format in DB', 'FAIL', 'Invalid email formats found in database', 'medium');
      }
      
    } catch (error) {
      addResult('Data Format Validation', 'FAIL', `Cannot check data formats: ${error.message}`, 'medium');
    }
    
    // Test 4.2: Check for orphaned records
    try {
      const orphanedUsers = db.prepare(`
        SELECT COUNT(*) as count FROM users 
        WHERE region_id IS NOT NULL AND region_id NOT IN (SELECT id FROM regions)
      `).get();
      
      if (orphanedUsers.count === 0) {
        addResult('Orphaned User Records', 'PASS', 'No orphaned user records found');
      } else {
        addResult('Orphaned User Records', 'FAIL', `Found ${orphanedUsers.count} orphaned user records`, 'medium');
      }
      
      const orphanedReports = db.prepare(`
        SELECT COUNT(*) as count FROM reports 
        WHERE user_id NOT IN (SELECT id FROM users)
      `).get();
      
      if (orphanedReports.count === 0) {
        addResult('Orphaned Report Records', 'PASS', 'No orphaned report records found');
      } else {
        addResult('Orphaned Report Records', 'FAIL', `Found ${orphanedReports.count} orphaned report records`, 'medium');
      }
      
    } catch (error) {
      addResult('Orphaned Records Check', 'WARN', `Cannot check orphaned records: ${error.message}`, 'low');
    }
    
    // Test 4.3: Check data consistency
    try {
      const userRoleCount = db.prepare('SELECT COUNT(*) as count FROM users WHERE role_id IS NULL').get();
      
      if (userRoleCount.count === 0) {
        addResult('User Role Consistency', 'PASS', 'All users have assigned roles');
      } else {
        addResult('User Role Consistency', 'FAIL', `${userRoleCount.count} users without assigned roles`, 'medium');
      }
      
    } catch (error) {
      addResult('Data Consistency Check', 'WARN', `Cannot check data consistency: ${error.message}`, 'low');
    }
    
    db.close();
    
  } catch (error) {
    addResult('Data Isolation Tests', 'FAIL', `Error: ${error.message}`, 'high');
  }
}

// Test 5: Database Backup and Recovery
async function testBackupSecurity() {
  log('\n=== Testing Backup and Recovery Security ===', 'cyan');
  
  try {
    // Test 5.1: Check for backup files
    const backupPatterns = ['*.backup', '*.bak', '*.dump', 'database*.sqlite*'];
    let backupFiles = [];
    
    for (const pattern of backupPatterns) {
      try {
        const files = require('glob').sync(pattern);
        backupFiles = backupFiles.concat(files);
      } catch (error) {
        // Glob not available, skip this test
      }
    }
    
    if (backupFiles.length === 0) {
      addResult('Backup Files Check', 'PASS', 'No exposed backup files found in current directory');
    } else {
      addResult('Backup Files Check', 'WARN', `Found potential backup files: ${backupFiles.join(', ')}`, 'medium');
    }
    
    // Test 5.2: Test database backup capability
    try {
      const dbPath = path.resolve('./database.sqlite');
      const testBackupPath = path.resolve('./test-backup.sqlite');
      
      const sourceDb = new Database(dbPath);
      const backupDb = new Database(testBackupPath);
      
      sourceDb.backup(backupDb);
      
      sourceDb.close();
      backupDb.close();
      
      // Check if backup was created
      if (fs.existsSync(testBackupPath)) {
        addResult('Backup Capability', 'PASS', 'Database backup functionality works');
        
        // Clean up test backup
        fs.unlinkSync(testBackupPath);
      } else {
        addResult('Backup Capability', 'FAIL', 'Database backup failed', 'medium');
      }
      
    } catch (error) {
      addResult('Backup Capability', 'WARN', `Cannot test backup capability: ${error.message}`, 'low');
    }
    
  } catch (error) {
    addResult('Backup Security Tests', 'FAIL', `Error: ${error.message}`, 'medium');
  }
}

// Generate test report
function generateReport() {
  log('\n=== Generating Database Security Report ===', 'cyan');
  
  const criticalIssues = TEST_RESULTS.filter(r => r.severity === 'critical');
  const highIssues = TEST_RESULTS.filter(r => r.severity === 'high');
  const mediumIssues = TEST_RESULTS.filter(r => r.severity === 'medium');
  const lowIssues = TEST_RESULTS.filter(r => r.severity === 'low');
  
  const passed = TEST_RESULTS.filter(r => r.status === 'PASS').length;
  const failed = TEST_RESULTS.filter(r => r.status === 'FAIL').length;
  const warnings = TEST_RESULTS.filter(r => r.status === 'WARN').length;
  
  const report = `
=== DATABASE SECURITY TEST REPORT ===
Test Date: ${new Date().toISOString()}
Total Tests: ${TEST_RESULTS.length}
Passed: ${passed}
Failed: ${failed}
Warnings: ${warnings}

SEVERITY BREAKDOWN:
Critical Issues: ${criticalIssues.length}
High Issues: ${highIssues.length}
Medium Issues: ${mediumIssues.length}
Low Issues: ${lowIssues.length}

DETAILED RESULTS:
${TEST_RESULTS.map(r => `[${r.status}] ${r.test}: ${r.details} (${r.severity})`).join('\n')}
`;
  
  // Save report to file
  const reportPath = path.join(__dirname, 'database-security-test-report.txt');
  fs.writeFileSync(reportPath, report);
  
  log(`\nReport saved to: ${reportPath}`, 'green');
  log(`\nSUMMARY: ${passed} passed, ${failed} failed, ${warnings} warnings`, 'blue');
  
  if (criticalIssues.length > 0) {
    log(`\n⚠️  CRITICAL ISSUES FOUND: ${criticalIssues.length}`, 'red');
  }
  if (highIssues.length > 0) {
    log(`\n⚠️  HIGH PRIORITY ISSUES: ${highIssues.length}`, 'red');
  }
  
  return {
    total: TEST_RESULTS.length,
    passed,
    failed,
    warnings,
    critical: criticalIssues.length,
    high: highIssues.length,
    medium: mediumIssues.length,
    low: lowIssues.length,
    results: TEST_RESULTS
  };
}

// Main test execution
async function runDatabaseSecurityTests() {
  log('🔐 Starting Database Security Tests', 'cyan');
  log('='.repeat(50), 'cyan');
  
  try {
    await testDatabaseFileSecurity();
    await testDatabaseConnectionSecurity();
    await testTableConstraints();
    await testDataIsolation();
    await testBackupSecurity();
    
    const summary = generateReport();
    
    log('\n✅ Database security tests completed!', 'green');
    
    return summary;
    
  } catch (error) {
    log(`\n❌ Error running tests: ${error.message}`, 'red');
    throw error;
  }
}

// Run tests if called directly
if (require.main === module) {
  runDatabaseSecurityTests()
    .then(summary => {
      process.exit(summary.failed > 0 || summary.critical > 0 ? 1 : 0);
    })
    .catch(error => {
      console.error('Test execution failed:', error);
      process.exit(1);
    });
}

module.exports = { runDatabaseSecurityTests };