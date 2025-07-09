"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.requireDataAccess = exports.requireCustomPermission = exports.requireAdminOrManager = exports.requireAdmin = exports.requireRole = exports.requirePermission = void 0;
const error_middleware_1 = require("./error.middleware");
const permission_service_1 = require("../services/permission.service");
/**
 * Middleware zur Überprüfung spezifischer Berechtigungen
 * @param requiredPermissions - Array von erforderlichen Berechtigungen
 * @param requireAll - Wenn true, müssen alle Berechtigungen vorhanden sein. Wenn false, reicht eine.
 */
const requirePermission = (requiredPermissions, requireAll = false) => {
    return async (req, res, next) => {
        try {
            if (!req.user) {
                return next(new error_middleware_1.AppError('Benutzer nicht authentifiziert', 401));
            }
            const userId = req.user.userId;
            const permissions = typeof requiredPermissions === 'string'
                ? [requiredPermissions]
                : requiredPermissions;
            // Benutzerberechtigungen laden
            const userPermissions = await (0, permission_service_1.getUserPermissions)(userId);
            // Berechtigungen zu req.user hinzufügen für spätere Verwendung
            req.user.permissions = userPermissions.permissions;
            req.user.roleId = userPermissions.roleId;
            req.user.roleName = userPermissions.roleName;
            // Berechtigungen prüfen
            let hasRequiredPermissions = false;
            if (requireAll) {
                // Alle Berechtigungen müssen vorhanden sein
                hasRequiredPermissions = permissions.every(permission => userPermissions.permissions.includes(permission));
            }
            else {
                // Mindestens eine Berechtigung muss vorhanden sein
                hasRequiredPermissions = permissions.some(permission => userPermissions.permissions.includes(permission));
            }
            if (!hasRequiredPermissions) {
                return next(new error_middleware_1.AppError('Unzureichende Berechtigungen', 403));
            }
            next();
        }
        catch (error) {
            next(new error_middleware_1.AppError('Fehler beim Überprüfen der Berechtigungen', 500));
        }
    };
};
exports.requirePermission = requirePermission;
/**
 * Middleware zur Überprüfung von Benutzerrollen
 * @param requiredRoles - Array von erforderlichen Rollen
 */
const requireRole = (requiredRoles) => {
    return async (req, res, next) => {
        try {
            if (!req.user) {
                return next(new error_middleware_1.AppError('Benutzer nicht authentifiziert', 401));
            }
            const userId = req.user.userId;
            const roles = typeof requiredRoles === 'string' ? [requiredRoles] : requiredRoles;
            // Benutzerrolle laden
            const userPermissions = await (0, permission_service_1.getUserPermissions)(userId);
            // Rolle zu req.user hinzufügen
            req.user.permissions = userPermissions.permissions;
            req.user.roleId = userPermissions.roleId;
            req.user.roleName = userPermissions.roleName;
            if (!userPermissions.roleName || !roles.includes(userPermissions.roleName)) {
                return next(new error_middleware_1.AppError('Unzureichende Rollenberechtigung', 403));
            }
            next();
        }
        catch (error) {
            next(new error_middleware_1.AppError('Fehler beim Überprüfen der Rolle', 500));
        }
    };
};
exports.requireRole = requireRole;
/**
 * Middleware zur Überprüfung ob Benutzer Admin ist
 */
exports.requireAdmin = (0, exports.requireRole)('admin');
/**
 * Middleware zur Überprüfung ob Benutzer Admin oder Manager ist
 */
exports.requireAdminOrManager = (0, exports.requireRole)(['admin', 'manager']);
/**
 * Middleware zur Überprüfung spezifischer Berechtigungen mit flexibler Logik
 * @param permissionCheck - Funktion die die Berechtigungslogik implementiert
 */
const requireCustomPermission = (permissionCheck) => {
    return async (req, res, next) => {
        try {
            if (!req.user) {
                return next(new error_middleware_1.AppError('Benutzer nicht authentifiziert', 401));
            }
            const userId = req.user.userId;
            const userPermissions = await (0, permission_service_1.getUserPermissions)(userId);
            // Berechtigungen zu req.user hinzufügen
            req.user.permissions = userPermissions.permissions;
            req.user.roleId = userPermissions.roleId;
            req.user.roleName = userPermissions.roleName;
            const hasPermission = await permissionCheck(req.user);
            if (!hasPermission) {
                return next(new error_middleware_1.AppError('Unzureichende Berechtigungen', 403));
            }
            next();
        }
        catch (error) {
            next(new error_middleware_1.AppError('Fehler beim Überprüfen der Berechtigungen', 500));
        }
    };
};
exports.requireCustomPermission = requireCustomPermission;
/**
 * Middleware zur Überprüfung ob Benutzer Zugriff auf bestimmte Daten hat
 * Zum Beispiel: Nur eigene Daten oder Daten der eigenen Region
 */
const requireDataAccess = (dataOwnerId, allowRoles = ['admin', 'manager']) => {
    return async (req, res, next) => {
        try {
            if (!req.user) {
                return next(new error_middleware_1.AppError('Benutzer nicht authentifiziert', 401));
            }
            const userId = req.user.userId;
            const userPermissions = await (0, permission_service_1.getUserPermissions)(userId);
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
                return next(new error_middleware_1.AppError('Zugriff verweigert', 403));
            }
            next();
        }
        catch (error) {
            next(new error_middleware_1.AppError('Fehler beim Überprüfen des Datenzugriffs', 500));
        }
    };
};
exports.requireDataAccess = requireDataAccess;
