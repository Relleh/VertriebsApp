import { Request, Response, NextFunction } from 'express';
import { AppError } from './error.middleware';
import { getUserPermissions, hasPermission } from '../services/permission.service';

interface JwtPayload {
  userId: number;
  email: string;
  roleId?: number;
  roleName?: string;
  permissions?: string[];
}

/**
 * Middleware zur Überprüfung spezifischer Berechtigungen
 * @param requiredPermissions - Array von erforderlichen Berechtigungen
 * @param requireAll - Wenn true, müssen alle Berechtigungen vorhanden sein. Wenn false, reicht eine.
 */
export const requirePermission = (
  requiredPermissions: string | string[],
  requireAll: boolean = false
) => {
  return async (req: Request, res: Response, next: NextFunction) => {
    try {
      if (!req.user) {
        return next(new AppError('Benutzer nicht authentifiziert', 401));
      }

      const userId = req.user.userId;
      const permissions = typeof requiredPermissions === 'string' 
        ? [requiredPermissions] 
        : requiredPermissions;

      // Benutzerberechtigungen laden
      const userPermissions = await getUserPermissions(userId);
      
      // Berechtigungen zu req.user hinzufügen für spätere Verwendung
      req.user.permissions = userPermissions.permissions;
      req.user.roleId = userPermissions.roleId;
      req.user.roleName = userPermissions.roleName;

      // Berechtigungen prüfen
      let hasRequiredPermissions = false;
      
      if (requireAll) {
        // Alle Berechtigungen müssen vorhanden sein
        hasRequiredPermissions = permissions.every(permission => 
          userPermissions.permissions.includes(permission)
        );
      } else {
        // Mindestens eine Berechtigung muss vorhanden sein
        hasRequiredPermissions = permissions.some(permission => 
          userPermissions.permissions.includes(permission)
        );
      }

      if (!hasRequiredPermissions) {
        return next(new AppError('Unzureichende Berechtigungen', 403));
      }

      next();
    } catch (error) {
      next(new AppError('Fehler beim Überprüfen der Berechtigungen', 500));
    }
  };
};

/**
 * Middleware zur Überprüfung von Benutzerrollen
 * @param requiredRoles - Array von erforderlichen Rollen
 */
export const requireRole = (requiredRoles: string | string[]) => {
  return async (req: Request, res: Response, next: NextFunction) => {
    try {
      if (!req.user) {
        return next(new AppError('Benutzer nicht authentifiziert', 401));
      }

      const userId = req.user.userId;
      const roles = typeof requiredRoles === 'string' ? [requiredRoles] : requiredRoles;

      // Benutzerrolle laden
      const userPermissions = await getUserPermissions(userId);
      
      // Rolle zu req.user hinzufügen
      req.user.permissions = userPermissions.permissions;
      req.user.roleId = userPermissions.roleId;
      req.user.roleName = userPermissions.roleName;

      if (!userPermissions.roleName || !roles.includes(userPermissions.roleName)) {
        return next(new AppError('Unzureichende Rollenberechtigung', 403));
      }

      next();
    } catch (error) {
      next(new AppError('Fehler beim Überprüfen der Rolle', 500));
    }
  };
};

/**
 * Middleware zur Überprüfung ob Benutzer Admin ist
 */
export const requireAdmin = requireRole('admin');

/**
 * Middleware zur Überprüfung ob Benutzer Admin oder Manager ist
 */
export const requireAdminOrManager = requireRole(['admin', 'manager']);

/**
 * Middleware zur Überprüfung spezifischer Berechtigungen mit flexibler Logik
 * @param permissionCheck - Funktion die die Berechtigungslogik implementiert
 */
export const requireCustomPermission = (
  permissionCheck: (user: JwtPayload) => Promise<boolean>
) => {
  return async (req: Request, res: Response, next: NextFunction) => {
    try {
      if (!req.user) {
        return next(new AppError('Benutzer nicht authentifiziert', 401));
      }

      const userId = req.user.userId;
      const userPermissions = await getUserPermissions(userId);
      
      // Berechtigungen zu req.user hinzufügen
      req.user.permissions = userPermissions.permissions;
      req.user.roleId = userPermissions.roleId;
      req.user.roleName = userPermissions.roleName;

      const hasPermission = await permissionCheck(req.user);
      
      if (!hasPermission) {
        return next(new AppError('Unzureichende Berechtigungen', 403));
      }

      next();
    } catch (error) {
      next(new AppError('Fehler beim Überprüfen der Berechtigungen', 500));
    }
  };
};

/**
 * Middleware zur Überprüfung ob Benutzer Zugriff auf bestimmte Daten hat
 * Zum Beispiel: Nur eigene Daten oder Daten der eigenen Region
 */
export const requireDataAccess = (
  dataOwnerId: number | ((req: Request) => number),
  allowRoles: string[] = ['admin', 'manager']
) => {
  return async (req: Request, res: Response, next: NextFunction) => {
    try {
      if (!req.user) {
        return next(new AppError('Benutzer nicht authentifiziert', 401));
      }

      const userId = req.user.userId;
      const userPermissions = await getUserPermissions(userId);
      
      // Berechtigungen zu req.user hinzufügen
      req.user.permissions = userPermissions.permissions;
      req.user.roleId = userPermissions.roleId;
      req.user.roleName = userPermissions.roleName;

      // Admin und Manager haben immer Zugriff
      if (userPermissions.roleName && allowRoles.includes(userPermissions.roleName)) {
        return next();
      }

      // Daten-Owner ID ermitteln
      const ownerId = typeof dataOwnerId === 'function' ? dataOwnerId(req) : dataOwnerId;
      
      // Benutzer kann nur auf eigene Daten zugreifen
      if (userId !== ownerId) {
        return next(new AppError('Zugriff verweigert', 403));
      }

      next();
    } catch (error) {
      next(new AppError('Fehler beim Überprüfen des Datenzugriffs', 500));
    }
  };
};