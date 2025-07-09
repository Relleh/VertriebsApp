import { z } from 'zod';
import { validateSQLSafe, validateXSSSafe, sanitizeInput } from '../utils/sanitizer';

// Custom Zod validators for security
const secureName = z.string()
  .min(2, 'Name muss mindestens 2 Zeichen lang sein')
  .max(100, 'Name darf maximal 100 Zeichen lang sein')
  .refine((val) => validateXSSSafe(val), {
    message: 'Name enthält unzulässige Script-Inhalte (z.B. <script> Tags)'
  })
  .refine((val) => validateSQLSafe(val), {
    message: 'Name enthält potenzielle SQL-Injection-Muster (z.B. SQL-Kommentare)'
  })
  .transform((val) => {
    const result = sanitizeInput(val, { maxLength: 100, allowHTML: false });
    return result.value;
  });

const secureText = (minLength: number, maxLength: number, fieldName: string) =>
  z.string()
    .min(minLength, `${fieldName} muss mindestens ${minLength} Zeichen lang sein`)
    .max(maxLength, `${fieldName} darf maximal ${maxLength} Zeichen lang sein`)
    .refine((val) => validateXSSSafe(val), {
      message: `${fieldName} enthält unzulässige Script-Inhalte (z.B. <script> Tags)`
    })
    .refine((val) => validateSQLSafe(val), {
      message: `${fieldName} enthält potenzielle SQL-Injection-Muster (z.B. SQL-Kommentare "--" oder "/*")`
    })
    .transform((val) => {
      const result = sanitizeInput(val, { maxLength, allowHTML: false });
      return result.value;
    });

const secureOptionalText = (maxLength: number, fieldName: string) =>
  z.string()
    .max(maxLength, `${fieldName} darf maximal ${maxLength} Zeichen lang sein`)
    .refine((val) => validateXSSSafe(val), {
      message: `${fieldName} enthält unzulässige Script-Inhalte (z.B. <script> Tags)`
    })
    .refine((val) => validateSQLSafe(val), {
      message: `${fieldName} enthält potenzielle SQL-Injection-Muster (z.B. SQL-Kommentare "--" oder "/*")`
    })
    .transform((val) => {
      const result = sanitizeInput(val, { maxLength, allowHTML: false });
      return result.value;
    })
    .optional();

export const registerSchema = z.object({
  body: z.object({
    name: secureName,
    email: z.string()
      .email('Ungültige E-Mail-Adresse')
      .max(255, 'E-Mail-Adresse darf maximal 255 Zeichen lang sein'),
    password: z.string()
      .min(6, 'Passwort muss mindestens 6 Zeichen lang sein')
      .max(128, 'Passwort darf maximal 128 Zeichen lang sein'),
    region: z.string()
      .min(1, 'Region ist erforderlich')
      .max(20, 'Region-Code darf maximal 20 Zeichen lang sein')
      .regex(/^[A-Z0-9_]+$/, 'Region-Code enthält ungültige Zeichen'),
  }).strict(), // Reject any additional properties
});

export const loginSchema = z.object({
  body: z.object({
    email: z.string()
      .email('Ungültige E-Mail-Adresse')
      .max(255, 'E-Mail-Adresse darf maximal 255 Zeichen lang sein'),
    password: z.string()
      .min(1, 'Passwort ist erforderlich')
      .max(128, 'Passwort darf maximal 128 Zeichen lang sein'),
  }).strict(), // Reject any additional properties
});

export const reportSchema = z.object({
  body: z.object({
    kundeNr: z.string()
      .min(1, 'Kundennummer ist erforderlich')
      .max(50, 'Kundennummer darf maximal 50 Zeichen lang sein')
      .regex(/^[A-Za-z0-9\-_]+$/, 'Kundennummer enthält ungültige Zeichen'),
    kundeName: secureText(1, 255, 'Kundenname'),
    ansprechpartner: secureText(1, 255, 'Ansprechpartner'),
    ort: secureText(1, 255, 'Ort'),
    datum: z.string()
      .regex(/^\d{4}-\d{2}-\d{2}$/, 'Ungültiges Datumsformat')
      .refine((val) => {
        const date = new Date(val);
        return date instanceof Date && !isNaN(date.getTime());
      }, 'Ungültiges Datum'),
    kurzbericht: secureText(10, 2000, 'Kurzbericht'),
    todos: secureOptionalText(1000, 'Todos'),
    klassifizierung: z.enum(['A', 'B', 'C'], {
      errorMap: () => ({ message: 'Klassifizierung muss A, B oder C sein' })
    }),
    auftragswert: z.number()
      .min(0, 'Auftragswert muss mindestens 0 sein')
      .max(999999999.99, 'Auftragswert ist zu hoch')
      .optional(),
    angebotswert: z.number()
      .min(0, 'Angebotswert muss mindestens 0 sein')
      .max(999999999.99, 'Angebotswert ist zu hoch')
      .optional(),
    naechsterBesuch: z.number()
      .int('Nächster Besuch muss eine ganze Zahl sein')
      .min(1, 'Nächster Besuch muss mindestens 1 Woche sein')
      .max(52, 'Nächster Besuch darf maximal 52 Wochen sein')
      .optional(),
    neukunde: z.boolean(),
    uebernachtung: z.boolean(),
    status: z.enum(['B', 'U', 'K'], {
      errorMap: () => ({ message: 'Ungültiger Status' })
    }).optional(),
  }).strict(), // Reject any additional properties
});

export const updateReportSchema = z.object({
  body: z.object({
    ansprechpartner: secureText(1, 255, 'Ansprechpartner'),
    ort: secureText(1, 255, 'Ort'),
    datum: z.string()
      .regex(/^\d{4}-\d{2}-\d{2}$/, 'Ungültiges Datumsformat')
      .refine((val) => {
        const date = new Date(val);
        return date instanceof Date && !isNaN(date.getTime());
      }, 'Ungültiges Datum'),
    kurzbericht: secureText(10, 2000, 'Kurzbericht'),
    todos: secureOptionalText(1000, 'Todos'),
    klassifizierung: z.enum(['A', 'B', 'C'], {
      errorMap: () => ({ message: 'Klassifizierung muss A, B oder C sein' })
    }),
    auftragswert: z.number()
      .min(0, 'Auftragswert muss mindestens 0 sein')
      .max(999999999.99, 'Auftragswert ist zu hoch')
      .optional(),
    angebotswert: z.number()
      .min(0, 'Angebotswert muss mindestens 0 sein')
      .max(999999999.99, 'Angebotswert ist zu hoch')
      .optional(),
    naechsterBesuch: z.number()
      .int('Nächster Besuch muss eine ganze Zahl sein')
      .min(1, 'Nächster Besuch muss mindestens 1 Woche sein')
      .max(52, 'Nächster Besuch darf maximal 52 Wochen sein')
      .optional(),
    neukunde: z.boolean(),
    uebernachtung: z.boolean(),
    status: z.enum(['B', 'U', 'K'], {
      errorMap: () => ({ message: 'Ungültiger Status' })
    }).optional(),
  }).strict(), // Reject any additional properties
});

export type RegisterInput = z.infer<typeof registerSchema>;
export type LoginInput = z.infer<typeof loginSchema>;
export type ReportInput = z.infer<typeof reportSchema>;
export type UpdateReportInput = z.infer<typeof updateReportSchema>;