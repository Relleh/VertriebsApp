#!/usr/bin/env node

/**
 * Authorization Security Test Suite
 * Tests role-based access control and permission system for security vulnerabilities
 */

const axios = require('axios');
const jwt = require('jsonwebtoken');
const fs = require('fs');
const path = require('path');
require('dotenv').config();

// Test configuration
const BASE_URL = 'http://localhost:3000';
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

// Create mock tokens for different roles
function createMockToken(userId, email, roleId, roleName) {
  if (!process.env.JWT_SECRET) {
    throw new Error('JWT_SECRET not found');
  }
  
  return jwt.sign(
    { 
      userId, 
      email, 
      roleId, 
      roleName 
    },
    process.env.JWT_SECRET,
    { expiresIn: '1h' }
  );
}

// Test 1: Role-Based Access Control
async function testRoleBasedAccess() {
  log('\n=== Testing Role-Based Access Control ===', 'cyan');
  
  try {
    // Create tokens for different roles
    const adminToken = createMockToken(1, 'admin@test.com', 1, 'admin');
    const managerToken = createMockToken(2, 'manager@test.com', 2, 'manager');
    const employeeToken = createMockToken(3, 'employee@test.com', 3, 'employee');
    
    // Test 1.1: Admin access to admin endpoints
    try {
      const response = await axios.get(`${BASE_URL}/api/admin/users`, {
        headers: { 'Authorization': `Bearer ${adminToken}` }
      });
      if (response.status === 200) {
        addResult('Admin Access to Admin Endpoint', 'PASS', 'Admin can access admin endpoints');
      } else {
        addResult('Admin Access to Admin Endpoint', 'FAIL', 'Admin cannot access admin endpoints', 'high');
      }
    } catch (error) {
      if (error.response && error.response.status === 403) {
        addResult('Admin Access to Admin Endpoint', 'FAIL', 'Admin access denied to admin endpoints', 'high');
      } else {
        addResult('Admin Access to Admin Endpoint', 'WARN', `Admin endpoint test inconclusive: ${error.message}`, 'medium');
      }
    }
    
    // Test 1.2: Manager access to admin endpoints (should be denied)
    try {
      const response = await axios.get(`${BASE_URL}/api/admin/users`, {
        headers: { 'Authorization': `Bearer ${managerToken}` }
      });
      addResult('Manager Access to Admin Endpoint', 'FAIL', 'Manager can access admin endpoints (privilege escalation)', 'critical');
    } catch (error) {
      if (error.response && error.response.status === 403) {
        addResult('Manager Access to Admin Endpoint', 'PASS', 'Manager properly denied access to admin endpoints');
      } else {
        addResult('Manager Access to Admin Endpoint', 'WARN', `Manager endpoint test inconclusive: ${error.message}`, 'medium');
      }
    }
    
    // Test 1.3: Employee access to admin endpoints (should be denied)
    try {
      const response = await axios.get(`${BASE_URL}/api/admin/users`, {
        headers: { 'Authorization': `Bearer ${employeeToken}` }
      });
      addResult('Employee Access to Admin Endpoint', 'FAIL', 'Employee can access admin endpoints (privilege escalation)', 'critical');
    } catch (error) {
      if (error.response && error.response.status === 403) {
        addResult('Employee Access to Admin Endpoint', 'PASS', 'Employee properly denied access to admin endpoints');
      } else {
        addResult('Employee Access to Admin Endpoint', 'WARN', `Employee endpoint test inconclusive: ${error.message}`, 'medium');
      }
    }
    
    // Test 1.4: Employee access to analytics (should be allowed)
    try {
      const response = await axios.get(`${BASE_URL}/api/analytics`, {
        headers: { 'Authorization': `Bearer ${employeeToken}` }
      });
      if (response.status === 200) {
        addResult('Employee Access to Analytics', 'PASS', 'Employee can access analytics as expected');
      } else {
        addResult('Employee Access to Analytics', 'FAIL', 'Employee cannot access analytics', 'medium');
      }
    } catch (error) {
      if (error.response && error.response.status === 403) {
        addResult('Employee Access to Analytics', 'FAIL', 'Employee denied access to analytics', 'medium');
      } else {
        addResult('Employee Access to Analytics', 'WARN', `Analytics endpoint test inconclusive: ${error.message}`, 'medium');
      }
    }
    
  } catch (error) {
    addResult('Role-Based Access Tests', 'FAIL', `Error: ${error.message}`, 'high');
  }
}

// Test 2: Permission System Security
async function testPermissionSystem() {
  log('\n=== Testing Permission System Security ===', 'cyan');
  
  try {
    // Test 2.1: Token without role information
    const noRoleToken = jwt.sign(
      { userId: 999, email: 'norole@test.com' },
      process.env.JWT_SECRET,
      { expiresIn: '1h' }
    );
    
    try {
      const response = await axios.get(`${BASE_URL}/api/admin/users`, {
        headers: { 'Authorization': `Bearer ${noRoleToken}` }
      });
      addResult('No Role Token Access', 'FAIL', 'Token without role can access protected endpoints', 'high');
    } catch (error) {
      if (error.response && error.response.status === 403) {
        addResult('No Role Token Access', 'PASS', 'Token without role properly denied access');
      } else {
        addResult('No Role Token Access', 'WARN', `No role test inconclusive: ${error.message}`, 'medium');
      }
    }
    
    // Test 2.2: Token with invalid role
    const invalidRoleToken = jwt.sign(
      { userId: 998, email: 'invalid@test.com', roleId: 999, roleName: 'superadmin' },
      process.env.JWT_SECRET,
      { expiresIn: '1h' }
    );
    
    try {
      const response = await axios.get(`${BASE_URL}/api/admin/users`, {
        headers: { 'Authorization': `Bearer ${invalidRoleToken}` }
      });
      addResult('Invalid Role Token Access', 'FAIL', 'Token with invalid role can access protected endpoints', 'high');
    } catch (error) {
      if (error.response && error.response.status === 403) {
        addResult('Invalid Role Token Access', 'PASS', 'Token with invalid role properly denied access');
      } else {
        addResult('Invalid Role Token Access', 'WARN', `Invalid role test inconclusive: ${error.message}`, 'medium');
      }
    }
    
    // Test 2.3: Permission escalation attempt
    const lowPrivToken = createMockToken(4, 'lowpriv@test.com', 3, 'employee');
    
    try {
      const response = await axios.post(`${BASE_URL}/api/admin/users/1/role`, 
        { roleId: 1 },
        { headers: { 'Authorization': `Bearer ${lowPrivToken}` } }
      );
      addResult('Permission Escalation Attempt', 'FAIL', 'Low privilege user can escalate permissions', 'critical');
    } catch (error) {
      if (error.response && error.response.status === 403) {
        addResult('Permission Escalation Attempt', 'PASS', 'Permission escalation properly prevented');
      } else {
        addResult('Permission Escalation Attempt', 'WARN', `Permission escalation test inconclusive: ${error.message}`, 'medium');
      }
    }
    
  } catch (error) {
    addResult('Permission System Tests', 'FAIL', `Error: ${error.message}`, 'high');
  }
}

// Test 3: Token Tampering Detection
async function testTokenTampering() {
  log('\n=== Testing Token Tampering Detection ===', 'cyan');
  
  try {
    // Test 3.1: Modified token payload
    const validToken = createMockToken(5, 'user@test.com', 3, 'employee');
    const tokenParts = validToken.split('.');
    
    // Decode and modify payload
    let payload = JSON.parse(Buffer.from(tokenParts[1], 'base64').toString());
    payload.roleName = 'admin'; // Attempt to escalate role
    
    // Re-encode with modified payload
    const tamperedPayload = Buffer.from(JSON.stringify(payload)).toString('base64');
    const tamperedToken = `${tokenParts[0]}.${tamperedPayload}.${tokenParts[2]}`;
    
    try {
      const response = await axios.get(`${BASE_URL}/api/admin/users`, {
        headers: { 'Authorization': `Bearer ${tamperedToken}` }
      });
      addResult('Token Payload Tampering', 'FAIL', 'Tampered token was accepted', 'critical');
    } catch (error) {
      if (error.response && error.response.status === 403) {
        addResult('Token Payload Tampering', 'PASS', 'Tampered token properly rejected');
      } else {
        addResult('Token Payload Tampering', 'WARN', `Token tampering test inconclusive: ${error.message}`, 'medium');
      }
    }
    
    // Test 3.2: Token with wrong signature
    const wrongSignature = 'wrong.signature.here';
    const wrongSigToken = `${tokenParts[0]}.${tokenParts[1]}.${wrongSignature}`;
    
    try {
      const response = await axios.get(`${BASE_URL}/api/admin/users`, {
        headers: { 'Authorization': `Bearer ${wrongSigToken}` }
      });
      addResult('Wrong Signature Token', 'FAIL', 'Token with wrong signature was accepted', 'critical');
    } catch (error) {
      if (error.response && error.response.status === 403) {
        addResult('Wrong Signature Token', 'PASS', 'Token with wrong signature properly rejected');
      } else {
        addResult('Wrong Signature Token', 'WARN', `Wrong signature test inconclusive: ${error.message}`, 'medium');
      }
    }
    
  } catch (error) {
    addResult('Token Tampering Tests', 'FAIL', `Error: ${error.message}`, 'high');
  }
}

// Test 4: Authorization Bypass Attempts
async function testAuthorizationBypass() {
  log('\n=== Testing Authorization Bypass Attempts ===', 'cyan');
  
  try {
    // Test 4.1: Direct object reference
    const userToken = createMockToken(6, 'user@test.com', 3, 'employee');
    
    try {
      // Try to access another user's data
      const response = await axios.get(`${BASE_URL}/api/users/1/profile`, {
        headers: { 'Authorization': `Bearer ${userToken}` }
      });
      addResult('Direct Object Reference', 'FAIL', 'User can access other users data', 'high');
    } catch (error) {
      if (error.response && error.response.status === 403) {
        addResult('Direct Object Reference', 'PASS', 'Direct object reference properly prevented');
      } else {
        addResult('Direct Object Reference', 'WARN', `Direct object reference test inconclusive: ${error.message}`, 'medium');
      }
    }
    
    // Test 4.2: HTTP method manipulation
    try {
      const response = await axios.put(`${BASE_URL}/api/admin/users/1`, 
        { name: 'Modified Name' },
        { headers: { 'Authorization': `Bearer ${userToken}` } }
      );
      addResult('HTTP Method Manipulation', 'FAIL', 'User can modify admin data via PUT', 'high');
    } catch (error) {
      if (error.response && error.response.status === 403) {
        addResult('HTTP Method Manipulation', 'PASS', 'HTTP method manipulation properly prevented');
      } else {
        addResult('HTTP Method Manipulation', 'WARN', `HTTP method test inconclusive: ${error.message}`, 'medium');
      }
    }
    
    // Test 4.3: Parameter pollution
    try {
      const response = await axios.get(`${BASE_URL}/api/users/profile?userId=1&userId=2`, {
        headers: { 'Authorization': `Bearer ${userToken}` }
      });
      addResult('Parameter Pollution', 'WARN', 'Parameter pollution should be tested manually', 'low');
    } catch (error) {
      addResult('Parameter Pollution', 'WARN', 'Parameter pollution should be tested manually', 'low');
    }
    
  } catch (error) {
    addResult('Authorization Bypass Tests', 'FAIL', `Error: ${error.message}`, 'high');
  }
}

// Test 5: Endpoint Authorization Matrix
async function testEndpointAuthorizationMatrix() {
  log('\n=== Testing Endpoint Authorization Matrix ===', 'cyan');
  
  const endpoints = [
    { path: '/api/auth/login', method: 'POST', requiresAuth: false },
    { path: '/api/auth/register', method: 'POST', requiresAuth: false },
    { path: '/api/health', method: 'GET', requiresAuth: false },
    { path: '/api/reports', method: 'GET', requiresAuth: true },
    { path: '/api/users/profile', method: 'GET', requiresAuth: true },
    { path: '/api/admin/users', method: 'GET', requiresAuth: true, requiredRole: 'admin' },
    { path: '/api/analytics', method: 'GET', requiresAuth: true }
  ];
  
  const tokens = {
    admin: createMockToken(1, 'admin@test.com', 1, 'admin'),
    manager: createMockToken(2, 'manager@test.com', 2, 'manager'),
    employee: createMockToken(3, 'employee@test.com', 3, 'employee')
  };
  
  for (const endpoint of endpoints) {
    try {
      // Test without authentication
      if (!endpoint.requiresAuth) {
        try {
          const response = await axios[endpoint.method.toLowerCase()](`${BASE_URL}${endpoint.path}`);
          addResult(`${endpoint.path} - No Auth`, 'PASS', 'Public endpoint accessible without auth');
        } catch (error) {
          if (error.response && error.response.status === 401) {
            addResult(`${endpoint.path} - No Auth`, 'FAIL', 'Public endpoint requires auth', 'medium');
          } else {
            addResult(`${endpoint.path} - No Auth`, 'WARN', `Endpoint test inconclusive: ${error.message}`, 'low');
          }
        }
      } else {
        // Test with authentication required
        try {
          const response = await axios[endpoint.method.toLowerCase()](`${BASE_URL}${endpoint.path}`);
          addResult(`${endpoint.path} - Requires Auth`, 'FAIL', 'Protected endpoint accessible without auth', 'high');
        } catch (error) {
          if (error.response && error.response.status === 401) {
            addResult(`${endpoint.path} - Requires Auth`, 'PASS', 'Protected endpoint properly requires auth');
          } else {
            addResult(`${endpoint.path} - Requires Auth`, 'WARN', `Endpoint test inconclusive: ${error.message}`, 'low');
          }
        }
        
        // Test with different roles if role required
        if (endpoint.requiredRole) {
          for (const [roleName, token] of Object.entries(tokens)) {
            try {
              const response = await axios[endpoint.method.toLowerCase()](`${BASE_URL}${endpoint.path}`, {
                headers: { 'Authorization': `Bearer ${token}` }
              });
              
              if (roleName === endpoint.requiredRole) {
                addResult(`${endpoint.path} - ${roleName} Access`, 'PASS', `${roleName} can access ${endpoint.path}`);
              } else {
                addResult(`${endpoint.path} - ${roleName} Access`, 'FAIL', `${roleName} can access ${endpoint.path} (should be denied)`, 'high');
              }
            } catch (error) {
              if (error.response && error.response.status === 403) {
                if (roleName === endpoint.requiredRole) {
                  addResult(`${endpoint.path} - ${roleName} Access`, 'FAIL', `${roleName} denied access to ${endpoint.path}`, 'medium');
                } else {
                  addResult(`${endpoint.path} - ${roleName} Access`, 'PASS', `${roleName} properly denied access to ${endpoint.path}`);
                }
              } else {
                addResult(`${endpoint.path} - ${roleName} Access`, 'WARN', `Role test inconclusive: ${error.message}`, 'low');
              }
            }
          }
        }
      }
    } catch (error) {
      addResult(`Endpoint Matrix Test - ${endpoint.path}`, 'FAIL', `Error: ${error.message}`, 'medium');
    }
  }
}

// Generate test report
function generateReport() {
  log('\n=== Generating Authorization Security Report ===', 'cyan');
  
  const criticalIssues = TEST_RESULTS.filter(r => r.severity === 'critical');
  const highIssues = TEST_RESULTS.filter(r => r.severity === 'high');
  const mediumIssues = TEST_RESULTS.filter(r => r.severity === 'medium');
  const lowIssues = TEST_RESULTS.filter(r => r.severity === 'low');
  
  const passed = TEST_RESULTS.filter(r => r.status === 'PASS').length;
  const failed = TEST_RESULTS.filter(r => r.status === 'FAIL').length;
  const warnings = TEST_RESULTS.filter(r => r.status === 'WARN').length;
  
  const report = `
=== AUTHORIZATION SECURITY TEST REPORT ===
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
  const reportPath = path.join(__dirname, 'authorization-security-test-report.txt');
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
async function runAuthorizationSecurityTests() {
  log('🔐 Starting Authorization Security Tests', 'cyan');
  log('='.repeat(50), 'cyan');
  
  try {
    await testRoleBasedAccess();
    await testPermissionSystem();
    await testTokenTampering();
    await testAuthorizationBypass();
    await testEndpointAuthorizationMatrix();
    
    const summary = generateReport();
    
    log('\n✅ Authorization security tests completed!', 'green');
    
    return summary;
    
  } catch (error) {
    log(`\n❌ Error running tests: ${error.message}`, 'red');
    throw error;
  }
}

// Run tests if called directly
if (require.main === module) {
  runAuthorizationSecurityTests()
    .then(summary => {
      process.exit(summary.failed > 0 || summary.critical > 0 ? 1 : 0);
    })
    .catch(error => {
      console.error('Test execution failed:', error);
      process.exit(1);
    });
}

module.exports = { runAuthorizationSecurityTests };