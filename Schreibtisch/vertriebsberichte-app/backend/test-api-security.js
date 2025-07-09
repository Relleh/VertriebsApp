#!/usr/bin/env node

/**
 * API Security Test Suite
 * Tests API endpoints for security vulnerabilities, CORS, headers, rate limiting
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

// Test 1: CORS Configuration
async function testCORSConfiguration() {
  log('\n=== Testing CORS Configuration ===', 'cyan');
  
  try {
    // Test 1.1: Basic CORS headers
    const response = await axios.get(`${BASE_URL}/api/health`, {
      headers: {
        'Origin': 'http://localhost:3001'
      }
    });
    
    const corsHeaders = {
      'Access-Control-Allow-Origin': response.headers['access-control-allow-origin'],
      'Access-Control-Allow-Methods': response.headers['access-control-allow-methods'],
      'Access-Control-Allow-Headers': response.headers['access-control-allow-headers']
    };
    
    if (corsHeaders['Access-Control-Allow-Origin']) {
      if (corsHeaders['Access-Control-Allow-Origin'] === '*') {
        addResult('CORS Allow Origin', 'WARN', 'CORS allows all origins (*) - consider restricting for production', 'medium');
      } else {
        addResult('CORS Allow Origin', 'PASS', `CORS origin: ${corsHeaders['Access-Control-Allow-Origin']}`);
      }
    } else {
      addResult('CORS Allow Origin', 'WARN', 'No CORS headers found', 'medium');
    }
    
    // Test 1.2: Preflight request
    try {
      const preflightResponse = await axios({
        method: 'OPTIONS',
        url: `${BASE_URL}/api/auth/login`,
        headers: {
          'Origin': 'http://malicious-site.com',
          'Access-Control-Request-Method': 'POST',
          'Access-Control-Request-Headers': 'Content-Type'
        }
      });
      
      if (preflightResponse.status === 200) {
        addResult('CORS Preflight', 'PASS', 'CORS preflight requests are handled');
      } else {
        addResult('CORS Preflight', 'WARN', 'CORS preflight handling needs verification', 'low');
      }
    } catch (error) {
      addResult('CORS Preflight', 'WARN', 'CORS preflight test inconclusive', 'low');
    }
    
  } catch (error) {
    addResult('CORS Configuration Tests', 'FAIL', `Error: ${error.message}`, 'medium');
  }
}

// Test 2: HTTP Security Headers
async function testSecurityHeaders() {
  log('\n=== Testing HTTP Security Headers ===', 'cyan');
  
  try {
    const response = await axios.get(`${BASE_URL}/api/health`);
    const headers = response.headers;
    
    // Test 2.1: Content Security Policy
    if (headers['content-security-policy']) {
      addResult('Content Security Policy', 'PASS', 'CSP header present');
    } else {
      addResult('Content Security Policy', 'FAIL', 'Missing Content-Security-Policy header', 'medium');
    }
    
    // Test 2.2: X-Frame-Options
    if (headers['x-frame-options']) {
      addResult('X-Frame-Options', 'PASS', `X-Frame-Options: ${headers['x-frame-options']}`);
    } else {
      addResult('X-Frame-Options', 'FAIL', 'Missing X-Frame-Options header', 'medium');
    }
    
    // Test 2.3: X-Content-Type-Options
    if (headers['x-content-type-options']) {
      addResult('X-Content-Type-Options', 'PASS', `X-Content-Type-Options: ${headers['x-content-type-options']}`);
    } else {
      addResult('X-Content-Type-Options', 'FAIL', 'Missing X-Content-Type-Options header', 'medium');
    }
    
    // Test 2.4: Strict-Transport-Security (HSTS)
    if (headers['strict-transport-security']) {
      addResult('HSTS Header', 'PASS', `HSTS: ${headers['strict-transport-security']}`);
    } else {
      addResult('HSTS Header', 'WARN', 'Missing Strict-Transport-Security header (expected for HTTPS)', 'low');
    }
    
    // Test 2.5: X-XSS-Protection
    if (headers['x-xss-protection']) {
      addResult('X-XSS-Protection', 'PASS', `X-XSS-Protection: ${headers['x-xss-protection']}`);
    } else {
      addResult('X-XSS-Protection', 'WARN', 'Missing X-XSS-Protection header', 'low');
    }
    
    // Test 2.6: Referrer-Policy
    if (headers['referrer-policy']) {
      addResult('Referrer Policy', 'PASS', `Referrer-Policy: ${headers['referrer-policy']}`);
    } else {
      addResult('Referrer Policy', 'FAIL', 'Missing Referrer-Policy header', 'medium');
    }
    
    // Test 2.7: Server header disclosure
    if (headers['server']) {
      addResult('Server Header Disclosure', 'WARN', `Server header reveals: ${headers['server']}`, 'low');
    } else {
      addResult('Server Header Disclosure', 'PASS', 'Server header not disclosed');
    }
    
    // Test 2.8: X-Powered-By header disclosure
    if (headers['x-powered-by']) {
      addResult('X-Powered-By Disclosure', 'WARN', `X-Powered-By header reveals: ${headers['x-powered-by']}`, 'low');
    } else {
      addResult('X-Powered-By Disclosure', 'PASS', 'X-Powered-By header not disclosed');
    }
    
  } catch (error) {
    addResult('Security Headers Tests', 'FAIL', `Error: ${error.message}`, 'medium');
  }
}

// Test 3: Rate Limiting
async function testRateLimiting() {
  log('\n=== Testing Rate Limiting ===', 'cyan');
  
  try {
    const requests = [];
    const testEndpoint = `${BASE_URL}/api/health`;
    
    // Test 3.1: Rapid requests to check for rate limiting
    for (let i = 0; i < 20; i++) {
      requests.push(
        axios.get(testEndpoint).catch(error => ({ error: error.response }))
      );
    }
    
    const responses = await Promise.all(requests);
    const rateLimitedResponses = responses.filter(r => 
      r.error && (r.error.status === 429 || r.error.status === 503)
    );
    
    if (rateLimitedResponses.length > 0) {
      addResult('Rate Limiting', 'PASS', `Rate limiting detected after ${20 - rateLimitedResponses.length} requests`);
    } else {
      addResult('Rate Limiting', 'WARN', 'No rate limiting detected - may allow DoS attacks', 'medium');
    }
    
    // Test 3.2: Check for rate limit headers
    const singleResponse = await axios.get(testEndpoint);
    const rateLimitHeaders = [
      'x-ratelimit-limit',
      'x-ratelimit-remaining',
      'x-ratelimit-reset',
      'retry-after'
    ];
    
    const hasRateLimitHeaders = rateLimitHeaders.some(header => 
      singleResponse.headers[header]
    );
    
    if (hasRateLimitHeaders) {
      addResult('Rate Limit Headers', 'PASS', 'Rate limit headers are present');
    } else {
      addResult('Rate Limit Headers', 'WARN', 'No rate limit headers found', 'low');
    }
    
  } catch (error) {
    addResult('Rate Limiting Tests', 'FAIL', `Error: ${error.message}`, 'medium');
  }
}

// Test 4: Error Information Disclosure
async function testErrorInformationDisclosure() {
  log('\n=== Testing Error Information Disclosure ===', 'cyan');
  
  try {
    // Test 4.1: Invalid endpoint
    try {
      const response = await axios.get(`${BASE_URL}/api/nonexistent`);
      addResult('404 Error Handling', 'FAIL', 'Invalid endpoint returned 200', 'medium');
    } catch (error) {
      if (error.response && error.response.status === 404) {
        const errorBody = error.response.data;
        
        // Check if error reveals sensitive information
        const sensitivePatterns = [
          'stack trace',
          'file path',
          'database error',
          'internal server error',
          'sqlstate',
          'node_modules'
        ];
        
        const errorString = JSON.stringify(errorBody).toLowerCase();
        const revealsSensitiveInfo = sensitivePatterns.some(pattern => 
          errorString.includes(pattern)
        );
        
        if (revealsSensitiveInfo) {
          addResult('404 Error Information', 'FAIL', 'Error response reveals sensitive information', 'medium');
        } else {
          addResult('404 Error Information', 'PASS', '404 errors do not reveal sensitive information');
        }
      } else {
        addResult('404 Error Handling', 'WARN', '404 test inconclusive', 'low');
      }
    }
    
    // Test 4.2: Invalid JSON payload
    try {
      const response = await axios.post(`${BASE_URL}/api/auth/login`, 
        'invalid json{',
        {
          headers: { 'Content-Type': 'application/json' }
        }
      );
      addResult('Invalid JSON Handling', 'FAIL', 'Invalid JSON accepted', 'medium');
    } catch (error) {
      if (error.response && error.response.status === 400) {
        const errorBody = error.response.data;
        const errorString = JSON.stringify(errorBody).toLowerCase();
        
        if (errorString.includes('syntax') || errorString.includes('parse')) {
          addResult('Invalid JSON Handling', 'WARN', 'JSON parse errors may reveal implementation details', 'low');
        } else {
          addResult('Invalid JSON Handling', 'PASS', 'Invalid JSON handled without revealing details');
        }
      } else {
        addResult('Invalid JSON Handling', 'WARN', 'JSON handling test inconclusive', 'low');
      }
    }
    
    // Test 4.3: Database error simulation
    const adminToken = createAdminToken();
    try {
      const response = await axios.get(`${BASE_URL}/api/admin/users/999999`, {
        headers: { 'Authorization': `Bearer ${adminToken}` }
      });
      addResult('Database Error Handling', 'WARN', 'Database error test inconclusive', 'low');
    } catch (error) {
      if (error.response) {
        const errorBody = error.response.data;
        const errorString = JSON.stringify(errorBody).toLowerCase();
        
        const databasePatterns = ['sql', 'sqlite', 'constraint', 'foreign key'];
        const revealsDbInfo = databasePatterns.some(pattern => 
          errorString.includes(pattern)
        );
        
        if (revealsDbInfo) {
          addResult('Database Error Handling', 'FAIL', 'Database errors reveal implementation details', 'medium');
        } else {
          addResult('Database Error Handling', 'PASS', 'Database errors handled securely');
        }
      } else {
        addResult('Database Error Handling', 'WARN', 'Database error test inconclusive', 'low');
      }
    }
    
  } catch (error) {
    addResult('Error Information Disclosure Tests', 'FAIL', `Error: ${error.message}`, 'medium');
  }
}

// Test 5: HTTP Methods Security
async function testHTTPMethodSecurity() {
  log('\n=== Testing HTTP Methods Security ===', 'cyan');
  
  try {
    const methods = ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'HEAD', 'OPTIONS', 'TRACE'];
    const testEndpoint = `${BASE_URL}/api/health`;
    
    for (const method of methods) {
      try {
        const response = await axios({
          method: method,
          url: testEndpoint,
          timeout: 5000
        });
        
        if (method === 'GET' || method === 'HEAD' || method === 'OPTIONS') {
          addResult(`HTTP ${method} Method`, 'PASS', `${method} method properly supported`);
        } else if (method === 'TRACE') {
          addResult(`HTTP ${method} Method`, 'FAIL', 'TRACE method enabled - security risk', 'medium');
        } else {
          addResult(`HTTP ${method} Method`, 'WARN', `${method} method enabled on health endpoint`, 'low');
        }
      } catch (error) {
        if (error.response && error.response.status === 405) {
          if (method === 'TRACE') {
            addResult(`HTTP ${method} Method`, 'PASS', 'TRACE method properly disabled');
          } else {
            addResult(`HTTP ${method} Method`, 'PASS', `${method} method properly restricted`);
          }
        } else {
          addResult(`HTTP ${method} Method`, 'WARN', `${method} method test inconclusive`, 'low');
        }
      }
    }
    
  } catch (error) {
    addResult('HTTP Methods Security Tests', 'FAIL', `Error: ${error.message}`, 'medium');
  }
}

// Test 6: Content Type Validation
async function testContentTypeValidation() {
  log('\n=== Testing Content Type Validation ===', 'cyan');
  
  try {
    // Test 6.1: JSON content type enforcement
    try {
      const response = await axios.post(`${BASE_URL}/api/auth/login`, {
        email: 'test@example.com',
        password: 'password123'
      }, {
        headers: {
          'Content-Type': 'text/plain'
        }
      });
      addResult('Content Type Enforcement', 'FAIL', 'Non-JSON content type accepted', 'medium');
    } catch (error) {
      if (error.response && error.response.status === 400) {
        addResult('Content Type Enforcement', 'PASS', 'Non-JSON content type properly rejected');
      } else {
        addResult('Content Type Enforcement', 'WARN', 'Content type test inconclusive', 'low');
      }
    }
    
    // Test 6.2: Large payload handling
    try {
      const largePayload = 'A'.repeat(10 * 1024 * 1024); // 10MB
      const response = await axios.post(`${BASE_URL}/api/auth/login`, {
        email: 'test@example.com',
        password: largePayload
      });
      addResult('Large Payload Handling', 'FAIL', 'Large payload accepted - DoS risk', 'medium');
    } catch (error) {
      if (error.response && (error.response.status === 413 || error.response.status === 400)) {
        addResult('Large Payload Handling', 'PASS', 'Large payloads properly rejected');
      } else {
        addResult('Large Payload Handling', 'WARN', 'Large payload test inconclusive', 'low');
      }
    }
    
  } catch (error) {
    addResult('Content Type Validation Tests', 'FAIL', `Error: ${error.message}`, 'medium');
  }
}

// Generate test report
function generateReport() {
  log('\n=== Generating API Security Report ===', 'cyan');
  
  const criticalIssues = TEST_RESULTS.filter(r => r.severity === 'critical');
  const highIssues = TEST_RESULTS.filter(r => r.severity === 'high');
  const mediumIssues = TEST_RESULTS.filter(r => r.severity === 'medium');
  const lowIssues = TEST_RESULTS.filter(r => r.severity === 'low');
  
  const passed = TEST_RESULTS.filter(r => r.status === 'PASS').length;
  const failed = TEST_RESULTS.filter(r => r.status === 'FAIL').length;
  const warnings = TEST_RESULTS.filter(r => r.status === 'WARN').length;
  
  const report = `
=== API SECURITY TEST REPORT ===
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
  const reportPath = path.join(__dirname, 'api-security-test-report.txt');
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
async function runAPISecurityTests() {
  log('🔐 Starting API Security Tests', 'cyan');
  log('='.repeat(50), 'cyan');
  
  try {
    await testCORSConfiguration();
    await testSecurityHeaders();
    await testRateLimiting();
    await testErrorInformationDisclosure();
    await testHTTPMethodSecurity();
    await testContentTypeValidation();
    
    const summary = generateReport();
    
    log('\n✅ API security tests completed!', 'green');
    
    return summary;
    
  } catch (error) {
    log(`\n❌ Error running tests: ${error.message}`, 'red');
    throw error;
  }
}

// Run tests if called directly
if (require.main === module) {
  runAPISecurityTests()
    .then(summary => {
      process.exit(summary.failed > 0 || summary.critical > 0 ? 1 : 0);
    })
    .catch(error => {
      console.error('Test execution failed:', error);
      process.exit(1);
    });
}

module.exports = { runAPISecurityTests };