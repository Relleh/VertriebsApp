"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.sanitizeHTML = sanitizeHTML;
exports.validateSQLSafe = validateSQLSafe;
exports.validateXSSSafe = validateXSSSafe;
exports.sanitizeInput = sanitizeInput;
exports.isValidIdentifier = isValidIdentifier;
exports.sanitizeObject = sanitizeObject;
const jsdom_1 = require("jsdom");
const dompurify_1 = __importDefault(require("dompurify"));
const validator_1 = __importDefault(require("validator"));
// Initialize DOMPurify with jsdom window
const window = new jsdom_1.JSDOM('').window;
const purify = (0, dompurify_1.default)(window);
// SQL injection patterns to detect and reject
const SQL_INJECTION_PATTERNS = [
    /('|(\\)|;|\||&)/,
    /(union|select|insert|update|delete|drop|create|alter|exec|execute)/i,
    /(--|\/\*|\*\/)/,
    /(script|javascript|vbscript|onload|onerror|onclick)/i,
    /(\<script|\<\/script\>)/i
];
// XSS patterns to detect and reject
const XSS_PATTERNS = [
    /<script[\s\S]*?>[\s\S]*?<\/script>/gi,
    /<iframe[\s\S]*?>[\s\S]*?<\/iframe>/gi,
    /<object[\s\S]*?>[\s\S]*?<\/object>/gi,
    /<embed[\s\S]*?>[\s\S]*?<\/embed>/gi,
    /<link[\s\S]*?>/gi,
    /<meta[\s\S]*?>/gi,
    /javascript:/gi,
    /vbscript:/gi,
    /on\w+\s*=/gi,
    /<.*?style\s*=.*?expression\s*\(/gi
];
/**
 * Sanitizes HTML content by removing dangerous elements and attributes
 * @param input - The input string to sanitize
 * @returns Sanitized string
 */
function sanitizeHTML(input) {
    if (!input || typeof input !== 'string') {
        return '';
    }
    // Configure DOMPurify to be very strict
    const cleanHTML = purify.sanitize(input, {
        ALLOWED_TAGS: [], // No HTML tags allowed
        ALLOWED_ATTR: [], // No attributes allowed
        KEEP_CONTENT: true, // Keep text content
        ALLOW_DATA_ATTR: false,
        ALLOW_UNKNOWN_PROTOCOLS: false,
        RETURN_DOM: false,
        RETURN_DOM_FRAGMENT: false,
        RETURN_DOM_IMPORT: false
    });
    return cleanHTML;
}
/**
 * Validates input for SQL injection patterns
 * @param input - The input string to validate
 * @returns true if safe, false if contains SQL injection patterns
 */
function validateSQLSafe(input) {
    if (!input || typeof input !== 'string') {
        return true;
    }
    // Check for SQL injection patterns
    for (const pattern of SQL_INJECTION_PATTERNS) {
        if (pattern.test(input)) {
            return false;
        }
    }
    return true;
}
/**
 * Validates input for XSS patterns
 * @param input - The input string to validate
 * @returns true if safe, false if contains XSS patterns
 */
function validateXSSSafe(input) {
    if (!input || typeof input !== 'string') {
        return true;
    }
    // Check for XSS patterns
    for (const pattern of XSS_PATTERNS) {
        if (pattern.test(input)) {
            return false;
        }
    }
    return true;
}
/**
 * Comprehensive input sanitization for text fields
 * @param input - The input string to sanitize
 * @param options - Sanitization options
 * @returns Sanitized and validated string
 */
function sanitizeInput(input, options = {}) {
    const errors = [];
    let sanitizedValue = input;
    // Basic type check
    if (!input || typeof input !== 'string') {
        return { value: '', isValid: true, errors: [] };
    }
    // Length validation
    if (options.maxLength && input.length > options.maxLength) {
        errors.push(`Input exceeds maximum length of ${options.maxLength} characters`);
        sanitizedValue = input.substring(0, options.maxLength);
    }
    // SQL injection validation
    if (options.stripSQL !== false && !validateSQLSafe(sanitizedValue)) {
        errors.push('Input contains potentially dangerous SQL patterns');
        return { value: '', isValid: false, errors };
    }
    // XSS validation
    if (options.stripXSS !== false && !validateXSSSafe(sanitizedValue)) {
        errors.push('Input contains potentially dangerous script content');
        return { value: '', isValid: false, errors };
    }
    // HTML sanitization
    if (!options.allowHTML) {
        sanitizedValue = sanitizeHTML(sanitizedValue);
    }
    // Additional validation with validator.js
    sanitizedValue = validator_1.default.escape(sanitizedValue); // Escape HTML entities
    sanitizedValue = validator_1.default.trim(sanitizedValue); // Trim whitespace
    return {
        value: sanitizedValue,
        isValid: errors.length === 0,
        errors
    };
}
/**
 * Validates if a string is a safe identifier (for database column names, etc.)
 * @param input - The input string to validate
 * @returns true if safe identifier, false otherwise
 */
function isValidIdentifier(input) {
    if (!input || typeof input !== 'string') {
        return false;
    }
    // Only allow alphanumeric characters and underscores, must start with letter
    return /^[a-zA-Z][a-zA-Z0-9_]*$/.test(input);
}
/**
 * Sanitizes an object recursively, applying sanitization to all string values
 * @param obj - The object to sanitize
 * @param options - Sanitization options
 * @returns Sanitized object with validation results
 */
function sanitizeObject(obj, options = {}) {
    const sanitized = {};
    const errors = {};
    let isValid = true;
    for (const [key, value] of Object.entries(obj)) {
        if (typeof value === 'string') {
            const result = sanitizeInput(value, options);
            sanitized[key] = result.value;
            if (!result.isValid) {
                errors[key] = result.errors;
                isValid = false;
            }
        }
        else if (typeof value === 'object' && value !== null) {
            const nestedResult = sanitizeObject(value, options);
            sanitized[key] = nestedResult.sanitized;
            if (!nestedResult.isValid) {
                errors[key] = Object.values(nestedResult.errors).flat();
                isValid = false;
            }
        }
        else {
            sanitized[key] = value;
        }
    }
    return { sanitized, isValid, errors };
}
