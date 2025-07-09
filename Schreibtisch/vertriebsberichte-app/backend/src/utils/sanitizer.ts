import { JSDOM } from 'jsdom';
import DOMPurify from 'dompurify';
import validator from 'validator';

// Initialize DOMPurify with jsdom window
const window = new JSDOM('').window;
const purify = DOMPurify(window);

// SQL injection patterns to detect and reject
const SQL_INJECTION_PATTERNS = [
  // Match SQL comments
  /(--|\/\*|\*\/|#)/,
  // Match dangerous SQL keywords with word boundaries to avoid false positives
  /\b(union\s+select|select\s+\*|insert\s+into|update\s+\w+\s+set|delete\s+from|drop\s+(table|database)|create\s+(table|database)|alter\s+table|exec\s*\(|execute\s+)/i,
  // Match common SQL injection attempts
  /(\'\s*or\s*\'|\'\s*and\s*\'|\'\s*--|\';|1\s*=\s*1|1\s*=\s*\'1)/i,
  // Match script tags and javascript
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
export function sanitizeHTML(input: string): string {
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
    RETURN_DOM_FRAGMENT: false
  });

  return cleanHTML;
}

/**
 * Validates input for SQL injection patterns
 * @param input - The input string to validate
 * @returns true if safe, false if contains SQL injection patterns
 */
export function validateSQLSafe(input: string): boolean {
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
export function validateXSSSafe(input: string): boolean {
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
export function sanitizeInput(input: string, options: {
  maxLength?: number;
  allowHTML?: boolean;
  stripSQL?: boolean;
  stripXSS?: boolean;
} = {}): { value: string; isValid: boolean; errors: string[] } {
  
  const errors: string[] = [];
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
    errors.push('Der Text enthält potentiell gefährliche SQL-Muster (z.B. SQL-Kommentare oder Injection-Versuche)');
    return { value: '', isValid: false, errors };
  }

  // XSS validation
  if (options.stripXSS !== false && !validateXSSSafe(sanitizedValue)) {
    errors.push('Der Text enthält potentiell gefährliche Script-Inhalte (z.B. <script> Tags oder JavaScript)');
    return { value: '', isValid: false, errors };
  }

  // HTML sanitization
  if (!options.allowHTML) {
    sanitizedValue = sanitizeHTML(sanitizedValue);
  }

  // Additional validation with validator.js
  sanitizedValue = validator.escape(sanitizedValue); // Escape HTML entities
  sanitizedValue = validator.trim(sanitizedValue); // Trim whitespace

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
export function isValidIdentifier(input: string): boolean {
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
export function sanitizeObject(obj: any, options: {
  maxLength?: number;
  allowHTML?: boolean;
  stripSQL?: boolean;
  stripXSS?: boolean;
} = {}): { sanitized: any; isValid: boolean; errors: Record<string, string[]> } {
  
  const sanitized: any = {};
  const errors: Record<string, string[]> = {};
  let isValid = true;

  for (const [key, value] of Object.entries(obj)) {
    if (typeof value === 'string') {
      const result = sanitizeInput(value, options);
      sanitized[key] = result.value;
      
      if (!result.isValid) {
        errors[key] = result.errors;
        isValid = false;
      }
    } else if (typeof value === 'object' && value !== null) {
      const nestedResult = sanitizeObject(value, options);
      sanitized[key] = nestedResult.sanitized;
      
      if (!nestedResult.isValid) {
        errors[key] = Object.values(nestedResult.errors).flat();
        isValid = false;
      }
    } else {
      sanitized[key] = value;
    }
  }

  return { sanitized, isValid, errors };
}