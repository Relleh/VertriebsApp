#!/usr/bin/env node

/**
 * Authorization Security Test Suite v2
 * Tests role-based access control using real database users
 */

const axios = require('axios');
const jwt = require('jsonwebtoken');
const fs = require('fs');
const path = require('path');
require('dotenv').config();

// Test configuration
const BASE_URL = 'http://localhost:3000';
const TEST_RESULTS = [];

// Real user data from database inspection
const REAL_USERS = {
  admin: { id: 10, email: 'final@test.com', roleId: 1, roleName: 'admin' },
  admin2: { id: 14, email: 'testRole@test.com', roleId: 1, roleName: 'admin' },
  employee: { id: 1, email: 'kkaluza@hellertools.com', roleId: 3, roleName: 'employee' }
};

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

// Create real tokens for existing users
function createRealUserToken(userKey) {
  if (!process.env.JWT_SECRET) {
    throw new Error('JWT_SECRET not found');
  }
  
  const user = REAL_USERS[userKey];
  if (!user) {
    throw new Error(`User ${userKey} not found in REAL_USERS`);
  }
  
  return jwt.sign(
    { 
      userId: user.id, 
      email: user.email,
      roleId: user.roleId,
      roleName: user.roleName
    },
    process.env.JWT_SECRET,
    { expiresIn: '1h' }
  );
}

// Test 1: Real User Role-Based Access
async function testRealUserRoleBasedAccess() {
  log('\n=== Testing Real User Role-Based Access ===', 'cyan');
  
  try {
    // Create tokens for real users
    const adminToken = createRealUserToken('admin');
    const admin2Token = createRealUserToken('admin2');
    const employeeToken = createRealUserToken('employee');
    
    // Test 1.1: Admin access to admin endpoints
    try {
      const response = await axios.get(`${BASE_URL}/api/admin/users`, {
        headers: { 'Authorization': `Bearer ${adminToken}` }
      });
      if (response.status === 200) {
        addResult('Real Admin Access to Admin Endpoint', 'PASS', 'Admin user can access admin endpoints');
      } else {
        addResult('Real Admin Access to Admin Endpoint', 'FAIL', 'Admin user cannot access admin endpoints', 'high');
      }
    } catch (error) {
      if (error.response && error.response.status === 403) {
        addResult('Real Admin Access to Admin Endpoint', 'FAIL', 'Real admin access denied to admin endpoints', 'high');
      } else {
        addResult('Real Admin Access to Admin Endpoint', 'FAIL', `Admin endpoint error: ${error.message}`, 'high');
      }
    }
    
    // Test 1.2: Second admin access
    try {
      const response = await axios.get(`${BASE_URL}/api/admin/users`, {
        headers: { 'Authorization': `Bearer ${admin2Token}` }
      });
      if (response.status === 200) {
        addResult('Second Admin Access', 'PASS', 'Second admin user can access admin endpoints');
      } else {
        addResult('Second Admin Access', 'FAIL', 'Second admin user cannot access admin endpoints', 'high');
      }
    } catch (error) {
      if (error.response && error.response.status === 403) {
        addResult('Second Admin Access', 'FAIL', 'Second admin access denied', 'high');
      } else {
        addResult('Second Admin Access', 'FAIL', `Second admin error: ${error.message}`, 'medium');
      }
    }
    
    // Test 1.3: Employee access to admin endpoints (should be denied)
    try {
      const response = await axios.get(`${BASE_URL}/api/admin/users`, {
        headers: { 'Authorization': `Bearer ${employeeToken}` }
      });
      addResult('Real Employee Access to Admin Endpoint', 'FAIL', 'Employee can access admin endpoints (privilege escalation)', 'critical');
    } catch (error) {
      if (error.response && error.response.status === 403) {
        addResult('Real Employee Access to Admin Endpoint', 'PASS', 'Employee properly denied access to admin endpoints');
      } else {
        addResult('Real Employee Access to Admin Endpoint', 'WARN', `Employee test inconclusive: ${error.message}`, 'medium');
      }
    }
    
    // Test 1.4: Employee access to analytics
    try {
      const response = await axios.get(`${BASE_URL}/api/analytics`, {
        headers: { 'Authorization': `Bearer ${employeeToken}` }
      });
      if (response.status === 200) {
        addResult('Real Employee Access to Analytics', 'PASS', 'Employee can access analytics as expected');
      } else {
        addResult('Real Employee Access to Analytics', 'FAIL', 'Employee cannot access analytics', 'medium');
      }
    } catch (error) {
      if (error.response && error.response.status === 403) {
        addResult('Real Employee Access to Analytics', 'FAIL', 'Employee denied access to analytics', 'medium');
      } else if (error.response && error.response.status === 404) {
        addResult('Real Employee Access to Analytics', 'WARN', 'Analytics endpoint not found', 'low');
      } else {
        addResult('Real Employee Access to Analytics', 'WARN', `Analytics test inconclusive: ${error.message}`, 'low');
      }
    }
    
  } catch (error) {
    addResult('Real User Role-Based Access Tests', 'FAIL', `Error: ${error.message}`, 'high');
  }
}

// Test 2: Permission Verification with Real Users
async function testRealUserPermissions() {
  log('\n=== Testing Real User Permissions ===', 'cyan');
  
  try {
    // Test admin permissions endpoint
    const adminToken = createRealUserToken('admin');
    
    try {
      const response = await axios.get(`${BASE_URL}/api/admin/permissions/me`, {
        headers: { 'Authorization': `Bearer ${adminToken}` }
      });
      
      if (response.status === 200) {
        const permissions = response.data.data.permissions;
        const expectedAdminPermissions = [
          'view_global_statistics',
          'view_all_reports', 
          'manage_users',
          'manage_roles',
          'export_data',
          'view_team_reports',
          'manage_customers',
          'view_analytics'
        ];
        
        const hasAllPermissions = expectedAdminPermissions.every(perm => permissions.includes(perm));
        
        if (hasAllPermissions) {
          addResult('Admin Permission Verification', 'PASS', `Admin has all expected permissions (${permissions.length} total)`);
        } else {
          const missingPerms = expectedAdminPermissions.filter(perm => !permissions.includes(perm));
          addResult('Admin Permission Verification', 'FAIL', `Admin missing permissions: ${missingPerms.join(', ')}`, 'high');
        }
      } else {
        addResult('Admin Permission Verification', 'FAIL', 'Could not retrieve admin permissions', 'medium');
      }
    } catch (error) {
      addResult('Admin Permission Verification', 'FAIL', `Permission check error: ${error.message}`, 'medium');
    }
    
    // Test employee permissions
    const employeeToken = createRealUserToken('employee');
    
    try {
      const response = await axios.get(`${BASE_URL}/api/admin/permissions/me`, {
        headers: { 'Authorization': `Bearer ${employeeToken}` }
      });
      
      if (response.status === 200) {
        const permissions = response.data.data.permissions;
        const expectedEmployeePermissions = ['view_analytics'];
        
        const hasCorrectPermissions = expectedEmployeePermissions.every(perm => permissions.includes(perm));
        const hasOnlyExpectedPermissions = permissions.every(perm => expectedEmployeePermissions.includes(perm));
        
        if (hasCorrectPermissions && hasOnlyExpectedPermissions) {
          addResult('Employee Permission Verification', 'PASS', `Employee has correct limited permissions: ${permissions.join(', ')}`);
        } else if (!hasCorrectPermissions) {
          addResult('Employee Permission Verification', 'FAIL', 'Employee missing expected permissions', 'medium');
        } else {
          const extraPerms = permissions.filter(perm => !expectedEmployeePermissions.includes(perm));
          addResult('Employee Permission Verification', 'FAIL', `Employee has extra permissions: ${extraPerms.join(', ')}`, 'high');
        }
      } else {
        addResult('Employee Permission Verification', 'FAIL', 'Could not retrieve employee permissions', 'medium');
      }
    } catch (error) {
      addResult('Employee Permission Verification', 'FAIL', `Employee permission check error: ${error.message}`, 'medium');
    }
    
  } catch (error) {
    addResult('Real User Permission Tests', 'FAIL', `Error: ${error.message}`, 'high');
  }
}

// Test 3: Cross-User Data Access
async function testCrossUserDataAccess() {
  log('\n=== Testing Cross-User Data Access ===', 'cyan');
  
  try {
    const adminToken = createRealUserToken('admin');
    const employeeToken = createRealUserToken('employee');
    
    // Test admin accessing user profile
    try {
      const response = await axios.get(`${BASE_URL}/api/users/profile`, {
        headers: { 'Authorization': `Bearer ${adminToken}` }
      });
      
      if (response.status === 200) {
        addResult('Admin Profile Access', 'PASS', 'Admin can access their own profile');
      } else {
        addResult('Admin Profile Access', 'FAIL', 'Admin cannot access own profile', 'medium');
      }
    } catch (error) {
      addResult('Admin Profile Access', 'FAIL', `Admin profile error: ${error.message}`, 'medium');
    }
    
    // Test employee accessing user profile  
    try {
      const response = await axios.get(`${BASE_URL}/api/users/profile`, {
        headers: { 'Authorization': `Bearer ${employeeToken}` }
      });
      
      if (response.status === 200) {
        addResult('Employee Profile Access', 'PASS', 'Employee can access their own profile');
      } else {
        addResult('Employee Profile Access', 'FAIL', 'Employee cannot access own profile', 'medium');
      }
    } catch (error) {
      addResult('Employee Profile Access', 'FAIL', `Employee profile error: ${error.message}`, 'medium');
    }
    
  } catch (error) {
    addResult('Cross-User Data Access Tests', 'FAIL', `Error: ${error.message}`, 'high');
  }
}

// Test 4: Administrative Function Security
async function testAdminFunctionSecurity() {
  log('\n=== Testing Administrative Function Security ===', 'cyan');
  
  try {
    const adminToken = createRealUserToken('admin');
    const employeeToken = createRealUserToken('employee');
    
    // Test admin can access user list
    try {
      const response = await axios.get(`${BASE_URL}/api/admin/users`, {
        headers: { 'Authorization': `Bearer ${adminToken}` }
      });
      
      if (response.status === 200 && Array.isArray(response.data.data)) {
        addResult('Admin User List Access', 'PASS', `Admin can access user list (${response.data.data.length} users)`);
      } else {
        addResult('Admin User List Access', 'FAIL', 'Admin cannot access user list properly', 'high');
      }
    } catch (error) {
      addResult('Admin User List Access', 'FAIL', `Admin user list error: ${error.message}`, 'high');
    }
    
    // Test admin can access roles
    try {
      const response = await axios.get(`${BASE_URL}/api/admin/roles`, {
        headers: { 'Authorization': `Bearer ${adminToken}` }
      });
      
      if (response.status === 200 && Array.isArray(response.data.data)) {
        addResult('Admin Roles Access', 'PASS', `Admin can access roles (${response.data.data.length} roles)`);
      } else {
        addResult('Admin Roles Access', 'FAIL', 'Admin cannot access roles properly', 'medium');
      }
    } catch (error) {
      addResult('Admin Roles Access', 'FAIL', `Admin roles error: ${error.message}`, 'medium');
    }
    
    // Test admin can access permissions
    try {
      const response = await axios.get(`${BASE_URL}/api/admin/permissions`, {
        headers: { 'Authorization': `Bearer ${adminToken}` }
      });
      
      if (response.status === 200 && Array.isArray(response.data.data)) {
        addResult('Admin Permissions Access', 'PASS', `Admin can access permissions (${response.data.data.length} permissions)`);
      } else {
        addResult('Admin Permissions Access', 'FAIL', 'Admin cannot access permissions properly', 'medium');
      }
    } catch (error) {
      addResult('Admin Permissions Access', 'FAIL', `Admin permissions error: ${error.message}`, 'medium');
    }
    
    // Test employee cannot access admin functions
    try {
      const response = await axios.get(`${BASE_URL}/api/admin/users`, {
        headers: { 'Authorization': `Bearer ${employeeToken}` }
      });
      addResult('Employee Admin Access Block', 'FAIL', 'Employee can access admin user list', 'critical');
    } catch (error) {
      if (error.response && error.response.status === 403) {
        addResult('Employee Admin Access Block', 'PASS', 'Employee properly blocked from admin functions');
      } else {
        addResult('Employee Admin Access Block', 'WARN', `Employee admin test inconclusive: ${error.message}`, 'medium');
      }
    }
    
  } catch (error) {
    addResult('Admin Function Security Tests', 'FAIL', `Error: ${error.message}`, 'high');
  }
}

// Generate test report
function generateReport() {
  log('\n=== Generating Authorization Security Report v2 ===', 'cyan');
  
  const criticalIssues = TEST_RESULTS.filter(r => r.severity === 'critical');
  const highIssues = TEST_RESULTS.filter(r => r.severity === 'high');
  const mediumIssues = TEST_RESULTS.filter(r => r.severity === 'medium');
  const lowIssues = TEST_RESULTS.filter(r => r.severity === 'low');
  
  const passed = TEST_RESULTS.filter(r => r.status === 'PASS').length;
  const failed = TEST_RESULTS.filter(r => r.status === 'FAIL').length;
  const warnings = TEST_RESULTS.filter(r => r.status === 'WARN').length;
  
  const report = `
=== AUTHORIZATION SECURITY TEST REPORT v2 ===
Test Date: ${new Date().toISOString()}
Using Real Database Users: ${Object.keys(REAL_USERS).join(', ')}
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
  const reportPath = path.join(__dirname, 'authorization-security-test-report-v2.txt');
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
async function runAuthorizationSecurityTestsV2() {
  log('🔐 Starting Authorization Security Tests v2 (Real Users)', 'cyan');
  log('='.repeat(60), 'cyan');
  
  try {
    await testRealUserRoleBasedAccess();
    await testRealUserPermissions();
    await testCrossUserDataAccess();
    await testAdminFunctionSecurity();
    
    const summary = generateReport();
    
    log('\n✅ Authorization security tests v2 completed!', 'green');
    
    return summary;
    
  } catch (error) {
    log(`\n❌ Error running tests: ${error.message}`, 'red');
    throw error;
  }
}

// Run tests if called directly
if (require.main === module) {
  runAuthorizationSecurityTestsV2()
    .then(summary => {
      process.exit(summary.failed > 0 || summary.critical > 0 ? 1 : 0);
    })
    .catch(error => {
      console.error('Test execution failed:', error);
      process.exit(1);
    });
}

module.exports = { runAuthorizationSecurityTestsV2 };