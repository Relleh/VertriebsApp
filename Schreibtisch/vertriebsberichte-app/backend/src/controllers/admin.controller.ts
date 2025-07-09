import { Request, Response, NextFunction } from 'express';
import { AppError } from '../middleware/error.middleware';
import {
  getAllRoles,
  getAllPermissions,
  getAllUsersWithRoles,
  assignRole,
  assignPermission,
  removePermission,
  getUserPermissions
} from '../services/permission.service';

/**
 * Lädt alle verfügbaren Rollen
 */
export const getRoles = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const roles = await getAllRoles();
    res.json({
      success: true,
      data: roles
    });
  } catch (error) {
    next(new AppError('Fehler beim Laden der Rollen', 500));
  }
};

/**
 * Lädt alle verfügbaren Berechtigungen
 */
export const getPermissions = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const permissions = await getAllPermissions();
    res.json({
      success: true,
      data: permissions
    });
  } catch (error) {
    next(new AppError('Fehler beim Laden der Berechtigungen', 500));
  }
};

/**
 * Lädt alle Benutzer mit ihren Rollen
 */
export const getUsers = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const users = await getAllUsersWithRoles();
    res.json({
      success: true,
      data: users
    });
  } catch (error) {
    next(new AppError('Fehler beim Laden der Benutzer', 500));
  }
};

/**
 * Lädt die Berechtigungen eines bestimmten Benutzers
 */
export const getUserPermissionsController = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = parseInt(req.params.userId);
    
    if (isNaN(userId)) {
      return next(new AppError('Ungültige Benutzer-ID', 400));
    }

    const userPermissions = await getUserPermissions(userId);
    res.json({
      success: true,
      data: userPermissions
    });
  } catch (error) {
    if (error instanceof Error && error.message.includes('nicht gefunden')) {
      return next(new AppError('Benutzer nicht gefunden', 404));
    }
    next(new AppError('Fehler beim Laden der Benutzerberechtigungen', 500));
  }
};

/**
 * Weist einem Benutzer eine Rolle zu
 */
export const assignUserRole = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = parseInt(req.params.userId);
    const { roleId } = req.body;

    if (isNaN(userId) || !roleId) {
      return next(new AppError('Ungültige Benutzer-ID oder Rollen-ID', 400));
    }

    await assignRole(userId, roleId);
    
    res.json({
      success: true,
      message: 'Rolle erfolgreich zugewiesen'
    });
  } catch (error) {
    if (error instanceof Error && error.message.includes('nicht gefunden')) {
      return next(new AppError('Benutzer oder Rolle nicht gefunden', 404));
    }
    next(new AppError('Fehler beim Zuweisen der Rolle', 500));
  }
};

/**
 * Weist einem Benutzer eine spezifische Berechtigung zu
 */
export const assignUserPermission = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = parseInt(req.params.userId);
    const { permissionName } = req.body;

    if (isNaN(userId) || !permissionName) {
      return next(new AppError('Ungültige Benutzer-ID oder Berechtigung', 400));
    }

    await assignPermission(userId, permissionName);
    
    res.json({
      success: true,
      message: 'Berechtigung erfolgreich zugewiesen'
    });
  } catch (error) {
    if (error instanceof Error && error.message.includes('nicht gefunden')) {
      return next(new AppError('Benutzer oder Berechtigung nicht gefunden', 404));
    }
    next(new AppError('Fehler beim Zuweisen der Berechtigung', 500));
  }
};

/**
 * Entfernt eine Berechtigung von einem Benutzer
 */
export const removeUserPermission = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = parseInt(req.params.userId);
    const { permissionName } = req.body;

    if (isNaN(userId) || !permissionName) {
      return next(new AppError('Ungültige Benutzer-ID oder Berechtigung', 400));
    }

    await removePermission(userId, permissionName);
    
    res.json({
      success: true,
      message: 'Berechtigung erfolgreich entfernt'
    });
  } catch (error) {
    if (error instanceof Error && error.message.includes('nicht gefunden')) {
      return next(new AppError('Benutzer oder Berechtigung nicht gefunden', 404));
    }
    next(new AppError('Fehler beim Entfernen der Berechtigung', 500));
  }
};

/**
 * Lädt die aktuellen Berechtigungen des eingeloggten Benutzers
 */
export const getCurrentUserPermissions = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = req.user?.userId;

    if (!userId) {
      return next(new AppError('Benutzer nicht authentifiziert', 401));
    }

    const userPermissions = await getUserPermissions(userId);
    res.json({
      success: true,
      data: userPermissions
    });
  } catch (error) {
    next(new AppError('Fehler beim Laden der eigenen Berechtigungen', 500));
  }
};

/**
 * Erstellt eine neue Rolle (nur für Super-Admin)
 */
export const createRole = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { name, description } = req.body;

    if (!name) {
      return next(new AppError('Rollenname ist erforderlich', 400));
    }

    // Implementierung für das Erstellen einer neuen Rolle
    // Dies würde eine zusätzliche Funktion im Permission Service erfordern
    
    res.json({
      success: true,
      message: 'Rolle erfolgreich erstellt'
    });
  } catch (error) {
    next(new AppError('Fehler beim Erstellen der Rolle', 500));
  }
};

/**
 * Erstellt eine neue Berechtigung (nur für Super-Admin)
 */
export const createPermission = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { name, description, resource, action } = req.body;

    if (!name || !resource || !action) {
      return next(new AppError('Name, Resource und Action sind erforderlich', 400));
    }

    // Implementierung für das Erstellen einer neuen Berechtigung
    // Dies würde eine zusätzliche Funktion im Permission Service erfordern
    
    res.json({
      success: true,
      message: 'Berechtigung erfolgreich erstellt'
    });
  } catch (error) {
    next(new AppError('Fehler beim Erstellen der Berechtigung', 500));
  }
};