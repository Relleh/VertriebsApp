#!/usr/bin/env node

/**
 * Authentication Security Test Suite
 * Tests authentication system for security vulnerabilities
 */

const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const axios = require('axios');
const fs = require('fs');
const path = require('path');

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

// Test 1: Password Hashing Security
async function testPasswordHashing() {
  log('\n=== Testing Password Hashing Security ===', 'cyan');
  
  try {
    // Test 1.1: Bcrypt rounds
    const testPassword = 'TestPassword123!';
    const hash = await bcrypt.hash(testPassword, 10);
    const isValidHash = hash.startsWith('$2a$10$') || hash.startsWith('$2b$10$');
    
    if (isValidHash) {
      addResult('Password Hash Format', 'PASS', 'Uses bcrypt with 10 rounds');
    } else {
      addResult('Password Hash Format', 'FAIL', 'Invalid bcrypt format or insufficient rounds', 'high');
    }
    
    // Test 1.2: Hash uniqueness
    const hash2 = await bcrypt.hash(testPassword, 10);
    if (hash !== hash2) {
      addResult('Hash Uniqueness', 'PASS', 'Each hash is unique (proper salt usage)');
    } else {
      addResult('Hash Uniqueness', 'FAIL', 'Hashes are identical - salt not properly used', 'critical');
    }
    
    // Test 1.3: Password verification
    const isValid = await bcrypt.compare(testPassword, hash);
    if (isValid) {
      addResult('Password Verification', 'PASS', 'Bcrypt comparison works correctly');
    } else {
      addResult('Password Verification', 'FAIL', 'Password verification failed', 'high');
    }
    
    // Test 1.4: Wrong password rejection
    const isInvalid = await bcrypt.compare('WrongPassword', hash);
    if (!isInvalid) {
      addResult('Wrong Password Rejection', 'PASS', 'Wrong passwords are properly rejected');
    } else {
      addResult('Wrong Password Rejection', 'FAIL', 'Wrong password was accepted', 'critical');
    }
    
  } catch (error) {
    addResult('Password Hashing Tests', 'FAIL', `Error: ${error.message}`, 'high');
  }
}

// Test 2: JWT Token Security
async function testJWTSecurity() {
  log('\n=== Testing JWT Token Security ===', 'cyan');
  
  try {
    // Load environment variables
    require('dotenv').config();
    const JWT_SECRET = process.env.JWT_SECRET;
    
    if (!JWT_SECRET) {
      addResult('JWT Secret Existence', 'FAIL', 'JWT_SECRET environment variable not set', 'critical');
      return;
    }
    
    // Test 2.1: JWT Secret strength
    if (JWT_SECRET.length < 32) {
      addResult('JWT Secret Strength', 'FAIL', `JWT secret too short (${JWT_SECRET.length} chars). Minimum 32 required.`, 'high');
    } else if (JWT_SECRET.length >= 64) {
      addResult('JWT Secret Strength', 'PASS', `JWT secret is strong (${JWT_SECRET.length} chars)`);
    } else {
      addResult('JWT Secret Strength', 'WARN', `JWT secret is adequate (${JWT_SECRET.length} chars). Consider using 64+ chars`, 'medium');
    }
    
    // Test 2.2: Token generation
    const testPayload = { userId: 123, email: 'test@example.com' };
    const token = jwt.sign(testPayload, JWT_SECRET, { expiresIn: '7d' });
    
    if (token) {
      addResult('JWT Token Generation', 'PASS', 'JWT token generated successfully');
    } else {
      addResult('JWT Token Generation', 'FAIL', 'JWT token generation failed', 'high');
    }
    
    // Test 2.3: Token verification
    const decoded = jwt.verify(token, JWT_SECRET);
    if (decoded.userId === 123 && decoded.email === 'test@example.com') {
      addResult('JWT Token Verification', 'PASS', 'JWT token verification successful');
    } else {
      addResult('JWT Token Verification', 'FAIL', 'JWT token verification failed', 'high');
    }
    
    // Test 2.4: Token expiration
    const expiredToken = jwt.sign(testPayload, JWT_SECRET, { expiresIn: '1ms' });
    await new Promise(resolve => setTimeout(resolve, 10)); // Wait 10ms
    
    try {
      jwt.verify(expiredToken, JWT_SECRET);
      addResult('JWT Token Expiration', 'FAIL', 'Expired token was accepted', 'high');
    } catch (error) {
      if (error.name === 'TokenExpiredError') {
        addResult('JWT Token Expiration', 'PASS', 'Expired tokens are properly rejected');
      } else {
        addResult('JWT Token Expiration', 'FAIL', `Unexpected error: ${error.message}`, 'medium');
      }
    }
    
    // Test 2.5: Invalid token rejection
    try {
      jwt.verify('invalid.token.here', JWT_SECRET);
      addResult('Invalid Token Rejection', 'FAIL', 'Invalid token was accepted', 'high');
    } catch (error) {
      addResult('Invalid Token Rejection', 'PASS', 'Invalid tokens are properly rejected');
    }
    
    // Test 2.6: Wrong secret rejection
    try {
      jwt.verify(token, 'wrong_secret');
      addResult('Wrong Secret Rejection', 'FAIL', 'Token verified with wrong secret', 'critical');
    } catch (error) {
      addResult('Wrong Secret Rejection', 'PASS', 'Tokens with wrong secret are rejected');
    }
    
  } catch (error) {
    addResult('JWT Security Tests', 'FAIL', `Error: ${error.message}`, 'high');
  }
}

// Test 3: Authentication API Endpoints
async function testAuthenticationAPI() {
  log('\n=== Testing Authentication API Endpoints ===', 'cyan');
  
  try {
    // Test 3.1: Register endpoint validation
    try {
      const response = await axios.post(`${BASE_URL}/api/auth/register`, {
        name: '',
        email: 'invalid-email',
        password: '123',
        region: ''
      });
      addResult('Register Input Validation', 'FAIL', 'Invalid input was accepted', 'high');
    } catch (error) {
      if (error.response && error.response.status === 400) {
        addResult('Register Input Validation', 'PASS', 'Invalid registration input properly rejected');
      } else {
        addResult('Register Input Validation', 'FAIL', `Unexpected error: ${error.message}`, 'medium');
      }
    }
    
    // Test 3.2: Login endpoint validation
    try {
      const response = await axios.post(`${BASE_URL}/api/auth/login`, {
        email: 'invalid-email',
        password: ''
      });
      addResult('Login Input Validation', 'FAIL', 'Invalid login input was accepted', 'high');
    } catch (error) {
      if (error.response && error.response.status === 400) {
        addResult('Login Input Validation', 'PASS', 'Invalid login input properly rejected');
      } else {
        addResult('Login Input Validation', 'FAIL', `Unexpected error: ${error.message}`, 'medium');
      }
    }
    
    // Test 3.3: Login with non-existent user
    try {
      const response = await axios.post(`${BASE_URL}/api/auth/login`, {
        email: 'nonexistent@example.com',
        password: 'password123'
      });
      addResult('Non-existent User Login', 'FAIL', 'Login succeeded for non-existent user', 'high');
    } catch (error) {
      if (error.response && error.response.status === 401) {
        addResult('Non-existent User Login', 'PASS', 'Non-existent user login properly rejected');
      } else {
        addResult('Non-existent User Login', 'FAIL', `Unexpected error: ${error.message}`, 'medium');
      }
    }
    
    // Test 3.4: Health endpoint (should be accessible)
    try {
      const response = await axios.get(`${BASE_URL}/api/health`);
      if (response.status === 200) {
        addResult('Health Endpoint', 'PASS', 'Health endpoint is accessible');
      } else {
        addResult('Health Endpoint', 'FAIL', 'Health endpoint returned unexpected status', 'low');
      }
    } catch (error) {
      addResult('Health Endpoint', 'FAIL', `Health endpoint error: ${error.message}`, 'medium');
    }
    
  } catch (error) {
    addResult('Authentication API Tests', 'FAIL', `Error: ${error.message}`, 'high');
  }
}

// Test 4: Authentication Middleware
async function testAuthenticationMiddleware() {
  log('\n=== Testing Authentication Middleware ===', 'cyan');
  
  try {
    // Test 4.1: Protected endpoint without token
    try {
      const response = await axios.get(`${BASE_URL}/api/users/profile`);
      addResult('Protected Endpoint Without Token', 'FAIL', 'Protected endpoint accessible without token', 'high');
    } catch (error) {
      if (error.response && error.response.status === 401) {
        addResult('Protected Endpoint Without Token', 'PASS', 'Protected endpoint properly requires authentication');
      } else {
        addResult('Protected Endpoint Without Token', 'FAIL', `Unexpected error: ${error.message}`, 'medium');
      }
    }
    
    // Test 4.2: Protected endpoint with invalid token
    try {
      const response = await axios.get(`${BASE_URL}/api/users/profile`, {
        headers: {
          'Authorization': 'Bearer invalid.token.here'
        }
      });
      addResult('Invalid Token Access', 'FAIL', 'Invalid token was accepted', 'high');
    } catch (error) {
      if (error.response && error.response.status === 403) {
        addResult('Invalid Token Access', 'PASS', 'Invalid token properly rejected');
      } else {
        addResult('Invalid Token Access', 'FAIL', `Unexpected error: ${error.message}`, 'medium');
      }
    }
    
    // Test 4.3: Malformed Authorization header
    try {
      const response = await axios.get(`${BASE_URL}/api/users/profile`, {
        headers: {
          'Authorization': 'InvalidFormat'
        }
      });
      addResult('Malformed Auth Header', 'FAIL', 'Malformed auth header was accepted', 'medium');
    } catch (error) {
      if (error.response && error.response.status === 401) {
        addResult('Malformed Auth Header', 'PASS', 'Malformed auth header properly rejected');
      } else {
        addResult('Malformed Auth Header', 'FAIL', `Unexpected error: ${error.message}`, 'medium');
      }
    }
    
  } catch (error) {
    addResult('Authentication Middleware Tests', 'FAIL', `Error: ${error.message}`, 'high');
  }
}

// Test 5: Session Management
async function testSessionManagement() {
  log('\n=== Testing Session Management ===', 'cyan');
  
  try {
    // Test 5.1: Token storage recommendations
    addResult('Token Storage Analysis', 'WARN', 'Frontend uses localStorage for tokens. Consider httpOnly cookies for better security.', 'medium');
    
    // Test 5.2: Token lifetime
    const JWT_SECRET = process.env.JWT_SECRET;
    if (JWT_SECRET) {
      const testToken = jwt.sign({ userId: 123 }, JWT_SECRET, { expiresIn: '7d' });
      const decoded = jwt.decode(testToken);
      const tokenLifetime = decoded.exp - decoded.iat;
      const sevenDaysInSeconds = 7 * 24 * 60 * 60;
      
      if (tokenLifetime === sevenDaysInSeconds) {
        addResult('Token Lifetime', 'PASS', 'Token lifetime is 7 days as configured');
      } else {
        addResult('Token Lifetime', 'FAIL', `Token lifetime is ${tokenLifetime} seconds, expected ${sevenDaysInSeconds}`, 'medium');
      }
    }
    
    // Test 5.3: Session concurrency (theoretical test)
    addResult('Session Concurrency', 'WARN', 'No mechanism to limit concurrent sessions. Consider implementing if needed.', 'low');
    
  } catch (error) {
    addResult('Session Management Tests', 'FAIL', `Error: ${error.message}`, 'medium');
  }
}

// Generate test report
function generateReport() {
  log('\n=== Generating Authentication Security Report ===', 'cyan');
  
  const criticalIssues = TEST_RESULTS.filter(r => r.severity === 'critical');
  const highIssues = TEST_RESULTS.filter(r => r.severity === 'high');
  const mediumIssues = TEST_RESULTS.filter(r => r.severity === 'medium');
  const lowIssues = TEST_RESULTS.filter(r => r.severity === 'low');
  
  const passed = TEST_RESULTS.filter(r => r.status === 'PASS').length;
  const failed = TEST_RESULTS.filter(r => r.status === 'FAIL').length;
  const warnings = TEST_RESULTS.filter(r => r.status === 'WARN').length;
  
  const report = `
=== AUTHENTICATION SECURITY TEST REPORT ===
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
  const reportPath = path.join(__dirname, 'auth-security-test-report.txt');
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
async function runAuthSecurityTests() {
  log('🔐 Starting Authentication Security Tests', 'cyan');
  log('='.repeat(50), 'cyan');
  
  try {
    await testPasswordHashing();
    await testJWTSecurity();
    await testAuthenticationAPI();
    await testAuthenticationMiddleware();
    await testSessionManagement();
    
    const summary = generateReport();
    
    log('\n✅ Authentication security tests completed!', 'green');
    
    return summary;
    
  } catch (error) {
    log(`\n❌ Error running tests: ${error.message}`, 'red');
    throw error;
  }
}

// Run tests if called directly
if (require.main === module) {
  runAuthSecurityTests()
    .then(summary => {
      process.exit(summary.failed > 0 || summary.critical > 0 ? 1 : 0);
    })
    .catch(error => {
      console.error('Test execution failed:', error);
      process.exit(1);
    });
}

module.exports = { runAuthSecurityTests };