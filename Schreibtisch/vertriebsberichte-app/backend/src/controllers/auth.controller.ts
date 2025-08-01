import { Request, Response, NextFunction } from 'express';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { query } from '../config/database';
import { AppError } from '../middleware/error.middleware';
import { LoginInput, RegisterInput } from '../validators/schemas';
import { assignRolePermissions } from '../services/permission.service';

const generateToken = (userId: number, email: string): string => {
  const jwtSecret = process.env.JWT_SECRET;
  
  if (!jwtSecret) {
    throw new Error('JWT_SECRET is not configured');
  }
  
  if (jwtSecret.length < 32) {
    throw new Error('JWT_SECRET is too short - must be at least 32 characters');
  }
  
  if (!userId || !email) {
    throw new Error('Invalid user data for token generation');
  }
  
  try {
    return jwt.sign(
      { userId, email },
      jwtSecret,
      { expiresIn: '7d' }
    );
  } catch (error) {
    const errorMsg = error instanceof Error ? error.message : String(error);
    throw new Error(`Token generation failed: ${errorMsg}`);
  }
};

export const register = async (
  req: Request<{}, {}, RegisterInput['body']>,
  res: Response,
  next: NextFunction
) => {
  try {
    const { name, email, password, region } = req.body;

    // Input validation
    if (!name || !email || !password || !region) {
      return next(new AppError('Alle Felder sind erforderlich', 400));
    }

    // Check if user already exists
    let existingUser;
    try {
      existingUser = query(
        'SELECT id FROM users WHERE email = ?',
        [email]
      );
    } catch (error) {
      return next(new AppError('Fehler beim Überprüfen der E-Mail-Adresse', 500));
    }

    if (existingUser.rows.length > 0) {
      return next(new AppError('E-Mail-Adresse bereits registriert', 400));
    }

    // Validate region
    let regionResult;
    try {
      regionResult = query(
        'SELECT id FROM regions WHERE code = ?',
        [region]
      );
    } catch (error) {
      return next(new AppError('Fehler beim Validieren der Region', 500));
    }

    if (regionResult.rows.length === 0) {
      return next(new AppError('Ungültige Region', 400));
    }

    // Hash password
    let hashedPassword;
    try {
      hashedPassword = await bcrypt.hash(password, 10);
    } catch (error) {
      return next(new AppError('Fehler beim Verschlüsseln des Passworts', 500));
    }

    // Get default role (employee)
    let defaultRole;
    try {
      defaultRole = query(
        'SELECT id FROM user_roles WHERE name = ?',
        ['employee']
      );
    } catch (error) {
      return next(new AppError('Fehler beim Laden der Standard-Rolle', 500));
    }

    if (defaultRole.rows.length === 0) {
      return next(new AppError('Standard-Rolle nicht gefunden. Bitte führen Sie die Datenbank-Migration aus.', 500));
    }

    // Create user with default role
    let newUser;
    try {
      newUser = query(
        'INSERT INTO users (name, email, password_hash, region_id, role_id) VALUES (?, ?, ?, ?, ?) RETURNING id, name, email',
        [name, email, hashedPassword, regionResult.rows[0].id, defaultRole.rows[0].id]
      );
    } catch (error) {
      return next(new AppError('Fehler beim Erstellen des Benutzers', 500));
    }

    // Validate user creation
    if (!newUser.rows || newUser.rows.length === 0 || !newUser.rows[0]) {
      return next(new AppError('Benutzer konnte nicht erstellt werden', 500));
    }

    const createdUser = newUser.rows[0];
    if (!createdUser.id || !createdUser.name || !createdUser.email) {
      return next(new AppError('Ungültige Benutzerdaten nach Erstellung', 500));
    }

    // Assign role permissions
    try {
      await assignRolePermissions(createdUser.id, defaultRole.rows[0].id);
    } catch (error) {
      console.error('Warning: Fehler beim Zuweisen der Berechtigungen:', error);
      // Don't fail the registration if permission assignment fails
    }

    // Get user role information for response
    let userWithRole;
    try {
      userWithRole = query(
        `SELECT u.id, u.name, u.email, ur.id as role_id, ur.name as role_name
         FROM users u
         LEFT JOIN user_roles ur ON u.role_id = ur.id
         WHERE u.id = ?`,
        [createdUser.id]
      );
    } catch (error) {
      console.error('Warning: Fehler beim Laden der Rollendaten:', error);
    }

    // Generate token
    let token;
    try {
      token = generateToken(createdUser.id, createdUser.email);
    } catch (error) {
      return next(new AppError('Fehler beim Generieren des Tokens', 500));
    }

    const userData = userWithRole?.rows?.[0] || createdUser;

    res.status(201).json({
      status: 'success',
      token,
      user: {
        id: userData.id,
        name: userData.name,
        email: userData.email,
        roleId: userData.role_id,
        roleName: userData.role_name,
      },
    });
  } catch (error) {
    next(new AppError('Unerwarteter Fehler bei der Registrierung', 500));
  }
};

export const login = async (
  req: Request<{}, {}, LoginInput['body']>,
  res: Response,
  next: NextFunction
) => {
  try {
    const { email, password } = req.body;

    // Input validation
    if (!email || !password) {
      return next(new AppError('E-Mail und Passwort sind erforderlich', 400));
    }

    // Find user with role information
    let result;
    try {
      result = query(
        `SELECT u.id, u.name, u.email, u.password_hash, ur.id as role_id, ur.name as role_name
         FROM users u
         LEFT JOIN user_roles ur ON u.role_id = ur.id
         WHERE u.email = ?`,
        [email]
      );
    } catch (error) {
      return next(new AppError('Fehler beim Suchen des Benutzers', 500));
    }

    if (!result.rows || result.rows.length === 0) {
      return next(new AppError('Ungültige Anmeldedaten', 401));
    }

    const user = result.rows[0];
    
    // Validate user data
    if (!user || !user.id || !user.email || !user.password_hash) {
      return next(new AppError('Ungültige Benutzerdaten', 500));
    }

    // Verify password
    let isPasswordValid;
    try {
      isPasswordValid = await bcrypt.compare(password, user.password_hash);
    } catch (error) {
      return next(new AppError('Fehler beim Überprüfen des Passworts', 500));
    }

    if (!isPasswordValid) {
      return next(new AppError('Ungültige Anmeldedaten', 401));
    }

    // Generate token
    let token;
    try {
      token = generateToken(user.id, user.email);
    } catch (error) {
      return next(new AppError('Fehler beim Generieren des Tokens', 500));
    }

    res.json({
      status: 'success',
      token,
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        roleId: user.role_id,
        roleName: user.role_name,
      },
    });
  } catch (error) {
    next(new AppError('Unerwarteter Fehler bei der Anmeldung', 500));
  }
};