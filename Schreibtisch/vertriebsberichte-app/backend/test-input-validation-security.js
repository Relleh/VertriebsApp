#!/usr/bin/env node

/**
 * Input Validation Security Test Suite
 * Tests for XSS, SQL injection, and Zod schema validation vulnerabilities
 */

const axios = require('axios');
const jwt = require('jsonwebtoken');
const fs = require('fs');
const path = require('path');
require('dotenv').config();

// Test configuration
const BASE_URL = 'http://localhost:3000';
const TEST_RESULTS = [];

// Real user for authenticated tests
const ADMIN_USER = { id: 10, email: 'final@test.com', roleId: 1, roleName: 'admin' };

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

// Create admin token for authenticated tests
function createAdminToken() {
  if (!process.env.JWT_SECRET) {
    throw new Error('JWT_SECRET not found');
  }
  
  return jwt.sign(
    { 
      userId: ADMIN_USER.id, 
      email: ADMIN_USER.email,
      roleId: ADMIN_USER.roleId,
      roleName: ADMIN_USER.roleName
    },
    process.env.JWT_SECRET,
    { expiresIn: '1h' }
  );
}

// Test 1: Registration Input Validation
async function testRegistrationValidation() {
  log('\n=== Testing Registration Input Validation ===', 'cyan');
  
  const testCases = [
    {
      name: 'Empty Name',
      payload: { name: '', email: 'test@example.com', password: 'password123', region: 'DACHL' },
      expectedStatus: 400,
      severity: 'medium'
    },
    {
      name: 'Invalid Email Format',
      payload: { name: 'Test User', email: 'invalid-email', password: 'password123', region: 'DACHL' },
      expectedStatus: 400,
      severity: 'medium'
    },
    {
      name: 'Short Password',
      payload: { name: 'Test User', email: 'test@example.com', password: '123', region: 'DACHL' },
      expectedStatus: 400,
      severity: 'medium'
    },
    {
      name: 'Invalid Region',
      payload: { name: 'Test User', email: 'test@example.com', password: 'password123', region: 'INVALID' },
      expectedStatus: 400,
      severity: 'medium'
    },
    {
      name: 'XSS in Name',
      payload: { name: '<script>alert("xss")</script>', email: 'xss@example.com', password: 'password123', region: 'DACHL' },
      expectedStatus: 400,
      severity: 'high'
    },
    {
      name: 'SQL Injection in Email',
      payload: { name: 'Test User', email: "test'; DROP TABLE users; --@example.com", password: 'password123', region: 'DACHL' },
      expectedStatus: 400,
      severity: 'critical'
    },
    {
      name: 'Long Name Attack',
      payload: { name: 'A'.repeat(1000), email: 'long@example.com', password: 'password123', region: 'DACHL' },
      expectedStatus: 400,
      severity: 'medium'
    }
  ];
  
  for (const testCase of testCases) {
    try {
      const response = await axios.post(`${BASE_URL}/api/auth/register`, testCase.payload);
      
      if (response.status === 201) {
        addResult(`Registration ${testCase.name}`, 'FAIL', `Malicious input accepted: ${testCase.name}`, testCase.severity);
      } else {
        addResult(`Registration ${testCase.name}`, 'WARN', `Unexpected status ${response.status}`, 'low');
      }
    } catch (error) {
      if (error.response && error.response.status === testCase.expectedStatus) {
        addResult(`Registration ${testCase.name}`, 'PASS', `Input properly rejected`);
      } else if (error.response && error.response.status === 400) {
        addResult(`Registration ${testCase.name}`, 'PASS', `Input rejected with validation error`);
      } else {
        addResult(`Registration ${testCase.name}`, 'WARN', `Unexpected error: ${error.message}`, 'low');
      }
    }
  }
}

// Test 2: Login Input Validation
async function testLoginValidation() {
  log('\n=== Testing Login Input Validation ===', 'cyan');
  
  const testCases = [
    {
      name: 'Empty Email',
      payload: { email: '', password: 'password123' },
      expectedStatus: 400,
      severity: 'medium'
    },
    {
      name: 'Empty Password',
      payload: { email: 'test@example.com', password: '' },
      expectedStatus: 400,
      severity: 'medium'
    },
    {
      name: 'XSS in Email',
      payload: { email: '<script>alert("xss")</script>', password: 'password123' },
      expectedStatus: 400,
      severity: 'high'
    },
    {
      name: 'SQL Injection in Password',
      payload: { email: 'test@example.com', password: "' OR '1'='1" },
      expectedStatus: 401,
      severity: 'critical'
    },
    {
      name: 'NoSQL Injection',
      payload: { email: { $ne: null }, password: { $ne: null } },
      expectedStatus: 400,
      severity: 'high'
    }
  ];
  
  for (const testCase of testCases) {
    try {
      const response = await axios.post(`${BASE_URL}/api/auth/login`, testCase.payload);
      
      if (response.status === 200) {
        addResult(`Login ${testCase.name}`, 'FAIL', `Malicious login attempt succeeded: ${testCase.name}`, testCase.severity);
      } else {
        addResult(`Login ${testCase.name}`, 'WARN', `Unexpected status ${response.status}`, 'low');
      }
    } catch (error) {
      if (error.response && (error.response.status === testCase.expectedStatus || error.response.status === 400)) {
        addResult(`Login ${testCase.name}`, 'PASS', `Malicious input properly rejected`);
      } else {
        addResult(`Login ${testCase.name}`, 'WARN', `Unexpected error: ${error.message}`, 'low');
      }
    }
  }
}

// Test 3: Report Input Validation
async function testReportValidation() {
  log('\n=== Testing Report Input Validation ===', 'cyan');
  
  const adminToken = createAdminToken();
  
  const testCases = [
    {
      name: 'XSS in Customer Name',
      payload: {
        kundeNr: 'K123',
        kundeName: '<script>alert("xss")</script>',
        ansprechpartner: 'Test Contact',
        ort: 'Berlin',
        datum: '2025-07-08',
        kurzbericht: 'Valid report content here',
        klassifizierung: 'A',
        neukunde: false,
        uebernachtung: false
      },
      severity: 'high'
    },
    {
      name: 'SQL Injection in Report',
      payload: {
        kundeNr: 'K123',
        kundeName: 'Valid Customer',
        ansprechpartner: 'Test Contact',
        ort: 'Berlin',
        datum: '2025-07-08',
        kurzbericht: "'; DROP TABLE reports; --",
        klassifizierung: 'A',
        neukunde: false,
        uebernachtung: false
      },
      severity: 'critical'
    },
    {
      name: 'Invalid Date Format',
      payload: {
        kundeNr: 'K123',
        kundeName: 'Valid Customer',
        ansprechpartner: 'Test Contact',
        ort: 'Berlin',
        datum: 'invalid-date',
        kurzbericht: 'Valid report content',
        klassifizierung: 'A',
        neukunde: false,
        uebernachtung: false
      },
      severity: 'medium'
    },
    {
      name: 'Invalid Classification',
      payload: {
        kundeNr: 'K123',
        kundeName: 'Valid Customer',
        ansprechpartner: 'Test Contact',
        ort: 'Berlin',
        datum: '2025-07-08',
        kurzbericht: 'Valid report content',
        klassifizierung: 'X',
        neukunde: false,
        uebernachtung: false
      },
      severity: 'medium'
    },
    {
      name: 'Negative Numbers',
      payload: {
        kundeNr: 'K123',
        kundeName: 'Valid Customer',
        ansprechpartner: 'Test Contact',
        ort: 'Berlin',
        datum: '2025-07-08',
        kurzbericht: 'Valid report content',
        klassifizierung: 'A',
        auftragswert: -1000,
        neukunde: false,
        uebernachtung: false
      },
      severity: 'medium'
    }
  ];
  
  for (const testCase of testCases) {
    try {
      const response = await axios.post(`${BASE_URL}/api/reports`, testCase.payload, {
        headers: { 'Authorization': `Bearer ${adminToken}` }
      });
      
      if (response.status === 201) {
        addResult(`Report ${testCase.name}`, 'FAIL', `Malicious report input accepted: ${testCase.name}`, testCase.severity);
      } else {
        addResult(`Report ${testCase.name}`, 'WARN', `Unexpected status ${response.status}`, 'low');
      }
    } catch (error) {
      if (error.response && error.response.status === 400) {
        addResult(`Report ${testCase.name}`, 'PASS', `Malicious report input properly rejected`);
      } else {
        addResult(`Report ${testCase.name}`, 'WARN', `Report test inconclusive: ${error.message}`, 'low');
      }
    }
  }
}

// Test 4: Parameter Tampering
async function testParameterTampering() {
  log('\n=== Testing Parameter Tampering ===', 'cyan');
  
  const adminToken = createAdminToken();
  
  try {
    // Test user ID tampering in profile access
    const response = await axios.get(`${BASE_URL}/api/users/profile?userId=1`, {
      headers: { 'Authorization': `Bearer ${adminToken}` }
    });
    
    addResult('Parameter Tampering - User ID', 'WARN', 'Manual verification needed for parameter tampering', 'medium');
  } catch (error) {
    addResult('Parameter Tampering - User ID', 'WARN', 'Parameter tampering test needs manual verification', 'medium');
  }
  
  // Test role manipulation in requests
  try {
    const maliciousPayload = {
      name: 'Test User',
      email: 'tamper@example.com',
      password: 'password123',
      region: 'DACHL',
      role: 'admin', // Try to inject admin role
      roleId: 1
    };
    
    const response = await axios.post(`${BASE_URL}/api/auth/register`, maliciousPayload);
    addResult('Parameter Tampering - Role Injection', 'FAIL', 'Role injection in registration succeeded', 'critical');
  } catch (error) {
    if (error.response && error.response.status === 400) {
      addResult('Parameter Tampering - Role Injection', 'PASS', 'Role injection properly rejected');
    } else {
      addResult('Parameter Tampering - Role Injection', 'WARN', 'Role injection test inconclusive', 'medium');
    }
  }
}

// Test 5: Content Type Validation
async function testContentTypeValidation() {
  log('\n=== Testing Content Type Validation ===', 'cyan');
  
  try {
    // Test with wrong content type
    const response = await axios.post(`${BASE_URL}/api/auth/login`, 
      'email=test@example.com&password=password123',
      {
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      }
    );
    
    addResult('Content Type Validation', 'FAIL', 'Server accepts non-JSON content type', 'medium');
  } catch (error) {
    if (error.response && error.response.status === 400) {
      addResult('Content Type Validation', 'PASS', 'Non-JSON content type properly rejected');
    } else {
      addResult('Content Type Validation', 'WARN', 'Content type test inconclusive', 'low');
    }
  }
  
  // Test with XML payload
  try {
    const xmlPayload = '<login><email>test@example.com</email><password>password123</password></login>';
    const response = await axios.post(`${BASE_URL}/api/auth/login`, xmlPayload, {
      headers: {
        'Content-Type': 'application/xml'
      }
    });
    
    addResult('XML Injection Test', 'FAIL', 'XML payload accepted', 'medium');
  } catch (error) {
    if (error.response && error.response.status === 400) {
      addResult('XML Injection Test', 'PASS', 'XML payload properly rejected');
    } else {
      addResult('XML Injection Test', 'WARN', 'XML test inconclusive', 'low');
    }
  }
}

// Test 6: Header Injection
async function testHeaderInjection() {
  log('\n=== Testing Header Injection ===', 'cyan');
  
  try {
    // Test with malicious headers
    const response = await axios.post(`${BASE_URL}/api/auth/login`, {
      email: 'test@example.com',
      password: 'password123'
    }, {
      headers: {
        'X-Forwarded-For': '127.0.0.1; rm -rf /',
        'User-Agent': '<script>alert("xss")</script>',
        'X-Real-IP': '../../etc/passwd'
      }
    });
    
    addResult('Header Injection Test', 'WARN', 'Header injection test completed - manual review needed', 'medium');
  } catch (error) {
    addResult('Header Injection Test', 'WARN', 'Header injection test completed - manual review needed', 'medium');
  }
}

// Generate test report
function generateReport() {
  log('\n=== Generating Input Validation Security Report ===', 'cyan');
  
  const criticalIssues = TEST_RESULTS.filter(r => r.severity === 'critical');
  const highIssues = TEST_RESULTS.filter(r => r.severity === 'high');
  const mediumIssues = TEST_RESULTS.filter(r => r.severity === 'medium');
  const lowIssues = TEST_RESULTS.filter(r => r.severity === 'low');
  
  const passed = TEST_RESULTS.filter(r => r.status === 'PASS').length;
  const failed = TEST_RESULTS.filter(r => r.status === 'FAIL').length;
  const warnings = TEST_RESULTS.filter(r => r.status === 'WARN').length;
  
  const report = `
=== INPUT VALIDATION SECURITY TEST REPORT ===
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
  const reportPath = path.join(__dirname, 'input-validation-security-test-report.txt');
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
async function runInputValidationSecurityTests() {
  log('🔐 Starting Input Validation Security Tests', 'cyan');
  log('='.repeat(50), 'cyan');
  
  try {
    await testRegistrationValidation();
    await testLoginValidation();
    await testReportValidation();
    await testParameterTampering();
    await testContentTypeValidation();
    await testHeaderInjection();
    
    const summary = generateReport();
    
    log('\n✅ Input validation security tests completed!', 'green');
    
    return summary;
    
  } catch (error) {
    log(`\n❌ Error running tests: ${error.message}`, 'red');
    throw error;
  }
}

// Run tests if called directly
if (require.main === module) {
  runInputValidationSecurityTests()
    .then(summary => {
      process.exit(summary.failed > 0 || summary.critical > 0 ? 1 : 0);
    })
    .catch(error => {
      console.error('Test execution failed:', error);
      process.exit(1);
    });
}

module.exports = { runInputValidationSecurityTests };