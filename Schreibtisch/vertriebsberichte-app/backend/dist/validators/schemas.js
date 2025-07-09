"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.updateReportSchema = exports.reportSchema = exports.loginSchema = exports.registerSchema = void 0;
const zod_1 = require("zod");
const sanitizer_1 = require("../utils/sanitizer");
// Custom Zod validators for security
const secureName = zod_1.z.string()
    .min(2, 'Name muss mindestens 2 Zeichen lang sein')
    .max(100, 'Name darf maximal 100 Zeichen lang sein')
    .refine((val) => (0, sanitizer_1.validateXSSSafe)(val), {
    message: 'Name enthält unzulässige Zeichen oder Script-Inhalte'
})
    .refine((val) => (0, sanitizer_1.validateSQLSafe)(val), {
    message: 'Name enthält potenziell gefährliche Inhalte'
})
    .transform((val) => {
    const result = (0, sanitizer_1.sanitizeInput)(val, { maxLength: 100, allowHTML: false });
    return result.value;
});
const secureText = (minLength, maxLength, fieldName) => zod_1.z.string()
    .min(minLength, `${fieldName} muss mindestens ${minLength} Zeichen lang sein`)
    .max(maxLength, `${fieldName} darf maximal ${maxLength} Zeichen lang sein`)
    .refine((val) => (0, sanitizer_1.validateXSSSafe)(val), {
    message: `${fieldName} enthält unzulässige Script-Inhalte`
})
    .refine((val) => (0, sanitizer_1.validateSQLSafe)(val), {
    message: `${fieldName} enthält potenziell gefährliche SQL-Inhalte`
})
    .transform((val) => {
    const result = (0, sanitizer_1.sanitizeInput)(val, { maxLength, allowHTML: false });
    return result.value;
});
const secureOptionalText = (maxLength, fieldName) => zod_1.z.string()
    .max(maxLength, `${fieldName} darf maximal ${maxLength} Zeichen lang sein`)
    .refine((val) => (0, sanitizer_1.validateXSSSafe)(val), {
    message: `${fieldName} enthält unzulässige Script-Inhalte`
})
    .refine((val) => (0, sanitizer_1.validateSQLSafe)(val), {
    message: `${fieldName} enthält potenziell gefährliche SQL-Inhalte`
})
    .transform((val) => {
    const result = (0, sanitizer_1.sanitizeInput)(val, { maxLength, allowHTML: false });
    return result.value;
})
    .optional();
exports.registerSchema = zod_1.z.object({
    body: zod_1.z.object({
        name: secureName,
        email: zod_1.z.string()
            .email('Ungültige E-Mail-Adresse')
            .max(255, 'E-Mail-Adresse darf maximal 255 Zeichen lang sein'),
        password: zod_1.z.string()
            .min(6, 'Passwort muss mindestens 6 Zeichen lang sein')
            .max(128, 'Passwort darf maximal 128 Zeichen lang sein'),
        region: zod_1.z.string()
            .min(1, 'Region ist erforderlich')
            .max(20, 'Region-Code darf maximal 20 Zeichen lang sein')
            .regex(/^[A-Z0-9_]+$/, 'Region-Code enthält ungültige Zeichen'),
    }).strict(), // Reject any additional properties
});
exports.loginSchema = zod_1.z.object({
    body: zod_1.z.object({
        email: zod_1.z.string()
            .email('Ungültige E-Mail-Adresse')
            .max(255, 'E-Mail-Adresse darf maximal 255 Zeichen lang sein'),
        password: zod_1.z.string()
            .min(1, 'Passwort ist erforderlich')
            .max(128, 'Passwort darf maximal 128 Zeichen lang sein'),
    }).strict(), // Reject any additional properties
});
exports.reportSchema = zod_1.z.object({
    body: zod_1.z.object({
        kundeNr: zod_1.z.string()
            .min(1, 'Kundennummer ist erforderlich')
            .max(50, 'Kundennummer darf maximal 50 Zeichen lang sein')
            .regex(/^[A-Za-z0-9\-_]+$/, 'Kundennummer enthält ungültige Zeichen'),
        kundeName: secureText(1, 255, 'Kundenname'),
        ansprechpartner: secureText(1, 255, 'Ansprechpartner'),
        ort: secureText(1, 255, 'Ort'),
        datum: zod_1.z.string()
            .regex(/^\d{4}-\d{2}-\d{2}$/, 'Ungültiges Datumsformat')
            .refine((val) => {
            const date = new Date(val);
            return date instanceof Date && !isNaN(date.getTime());
        }, 'Ungültiges Datum'),
        kurzbericht: secureText(10, 2000, 'Kurzbericht'),
        todos: secureOptionalText(1000, 'Todos'),
        klassifizierung: zod_1.z.enum(['A', 'B', 'C'], {
            errorMap: () => ({ message: 'Klassifizierung muss A, B oder C sein' })
        }),
        auftragswert: zod_1.z.number()
            .min(0, 'Auftragswert muss mindestens 0 sein')
            .max(999999999.99, 'Auftragswert ist zu hoch')
            .optional(),
        angebotswert: zod_1.z.number()
            .min(0, 'Angebotswert muss mindestens 0 sein')
            .max(999999999.99, 'Angebotswert ist zu hoch')
            .optional(),
        naechsterBesuch: zod_1.z.number()
            .int('Nächster Besuch muss eine ganze Zahl sein')
            .min(1, 'Nächster Besuch muss mindestens 1 Woche sein')
            .max(52, 'Nächster Besuch darf maximal 52 Wochen sein')
            .optional(),
        neukunde: zod_1.z.boolean(),
        uebernachtung: zod_1.z.boolean(),
        status: zod_1.z.enum(['B', 'U', 'K', 'O', 'V', 'I'], {
            errorMap: () => ({ message: 'Ungültiger Status' })
        }).optional(),
    }).strict(), // Reject any additional properties
});
exports.updateReportSchema = zod_1.z.object({
    body: zod_1.z.object({
        ansprechpartner: secureText(1, 255, 'Ansprechpartner'),
        ort: secureText(1, 255, 'Ort'),
        datum: zod_1.z.string()
            .regex(/^\d{4}-\d{2}-\d{2}$/, 'Ungültiges Datumsformat')
            .refine((val) => {
            const date = new Date(val);
            return date instanceof Date && !isNaN(date.getTime());
        }, 'Ungültiges Datum'),
        kurzbericht: secureText(10, 2000, 'Kurzbericht'),
        todos: secureOptionalText(1000, 'Todos'),
        klassifizierung: zod_1.z.enum(['A', 'B', 'C'], {
            errorMap: () => ({ message: 'Klassifizierung muss A, B oder C sein' })
        }),
        auftragswert: zod_1.z.number()
            .min(0, 'Auftragswert muss mindestens 0 sein')
            .max(999999999.99, 'Auftragswert ist zu hoch')
            .optional(),
        angebotswert: zod_1.z.number()
            .min(0, 'Angebotswert muss mindestens 0 sein')
            .max(999999999.99, 'Angebotswert ist zu hoch')
            .optional(),
        naechsterBesuch: zod_1.z.number()
            .int('Nächster Besuch muss eine ganze Zahl sein')
            .min(1, 'Nächster Besuch muss mindestens 1 Woche sein')
            .max(52, 'Nächster Besuch darf maximal 52 Wochen sein')
            .optional(),
        neukunde: zod_1.z.boolean(),
        uebernachtung: zod_1.z.boolean(),
        status: zod_1.z.enum(['B', 'U', 'K', 'O', 'V', 'I'], {
            errorMap: () => ({ message: 'Ungültiger Status' })
        }).optional(),
    }).strict(), // Reject any additional properties
});
