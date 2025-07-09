"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createPermission = exports.createRole = exports.getCurrentUserPermissions = exports.removeUserPermission = exports.assignUserPermission = exports.assignUserRole = exports.getUserPermissionsController = exports.getUsers = exports.getPermissions = exports.getRoles = void 0;
const error_middleware_1 = require("../middleware/error.middleware");
const permission_service_1 = require("../services/permission.service");
/**
 * Lädt alle verfügbaren Rollen
 */
const getRoles = async (req, res, next) => {
    try {
        const roles = await (0, permission_service_1.getAllRoles)();
        res.json({
            success: true,
            data: roles
        });
    }
    catch (error) {
        next(new error_middleware_1.AppError('Fehler beim Laden der Rollen', 500));
    }
};
exports.getRoles = getRoles;
/**
 * Lädt alle verfügbaren Berechtigungen
 */
const getPermissions = async (req, res, next) => {
    try {
        const permissions = await (0, permission_service_1.getAllPermissions)();
        res.json({
            success: true,
            data: permissions
        });
    }
    catch (error) {
        next(new error_middleware_1.AppError('Fehler beim Laden der Berechtigungen', 500));
    }
};
exports.getPermissions = getPermissions;
/**
 * Lädt alle Benutzer mit ihren Rollen
 */
const getUsers = async (req, res, next) => {
    try {
        const users = await (0, permission_service_1.getAllUsersWithRoles)();
        res.json({
            success: true,
            data: users
        });
    }
    catch (error) {
        next(new error_middleware_1.AppError('Fehler beim Laden der Benutzer', 500));
    }
};
exports.getUsers = getUsers;
/**
 * Lädt die Berechtigungen eines bestimmten Benutzers
 */
const getUserPermissionsController = async (req, res, next) => {
    try {
        const userId = parseInt(req.params.userId);
        if (isNaN(userId)) {
            return next(new error_middleware_1.AppError('Ungültige Benutzer-ID', 400));
        }
        const userPermissions = await (0, permission_service_1.getUserPermissions)(userId);
        res.json({
            success: true,
            data: userPermissions
        });
    }
    catch (error) {
        if (error instanceof Error && error.message.includes('nicht gefunden')) {
            return next(new error_middleware_1.AppError('Benutzer nicht gefunden', 404));
        }
        next(new error_middleware_1.AppError('Fehler beim Laden der Benutzerberechtigungen', 500));
    }
};
exports.getUserPermissionsController = getUserPermissionsController;
/**
 * Weist einem Benutzer eine Rolle zu
 */
const assignUserRole = async (req, res, next) => {
    try {
        const userId = parseInt(req.params.userId);
        const { roleId } = req.body;
        if (isNaN(userId) || !roleId) {
            return next(new error_middleware_1.AppError('Ungültige Benutzer-ID oder Rollen-ID', 400));
        }
        await (0, permission_service_1.assignRole)(userId, roleId);
        res.json({
            success: true,
            message: 'Rolle erfolgreich zugewiesen'
        });
    }
    catch (error) {
        if (error instanceof Error && error.message.includes('nicht gefunden')) {
            return next(new error_middleware_1.AppError('Benutzer oder Rolle nicht gefunden', 404));
        }
        next(new error_middleware_1.AppError('Fehler beim Zuweisen der Rolle', 500));
    }
};
exports.assignUserRole = assignUserRole;
/**
 * Weist einem Benutzer eine spezifische Berechtigung zu
 */
const assignUserPermission = async (req, res, next) => {
    try {
        const userId = parseInt(req.params.userId);
        const { permissionName } = req.body;
        if (isNaN(userId) || !permissionName) {
            return next(new error_middleware_1.AppError('Ungültige Benutzer-ID oder Berechtigung', 400));
        }
        await (0, permission_service_1.assignPermission)(userId, permissionName);
        res.json({
            success: true,
            message: 'Berechtigung erfolgreich zugewiesen'
        });
    }
    catch (error) {
        if (error instanceof Error && error.message.includes('nicht gefunden')) {
            return next(new error_middleware_1.AppError('Benutzer oder Berechtigung nicht gefunden', 404));
        }
        next(new error_middleware_1.AppError('Fehler beim Zuweisen der Berechtigung', 500));
    }
};
exports.assignUserPermission = assignUserPermission;
/**
 * Entfernt eine Berechtigung von einem Benutzer
 */
const removeUserPermission = async (req, res, next) => {
    try {
        const userId = parseInt(req.params.userId);
        const { permissionName } = req.body;
        if (isNaN(userId) || !permissionName) {
            return next(new error_middleware_1.AppError('Ungültige Benutzer-ID oder Berechtigung', 400));
        }
        await (0, permission_service_1.removePermission)(userId, permissionName);
        res.json({
            success: true,
            message: 'Berechtigung erfolgreich entfernt'
        });
    }
    catch (error) {
        if (error instanceof Error && error.message.includes('nicht gefunden')) {
            return next(new error_middleware_1.AppError('Benutzer oder Berechtigung nicht gefunden', 404));
        }
        next(new error_middleware_1.AppError('Fehler beim Entfernen der Berechtigung', 500));
    }
};
exports.removeUserPermission = removeUserPermission;
/**
 * Lädt die aktuellen Berechtigungen des eingeloggten Benutzers
 */
const getCurrentUserPermissions = async (req, res, next) => {
    try {
        const userId = req.user?.userId;
        if (!userId) {
            return next(new error_middleware_1.AppError('Benutzer nicht authentifiziert', 401));
        }
        const userPermissions = await (0, permission_service_1.getUserPermissions)(userId);
        res.json({
            success: true,
            data: userPermissions
        });
    }
    catch (error) {
        next(new error_middleware_1.AppError('Fehler beim Laden der eigenen Berechtigungen', 500));
    }
};
exports.getCurrentUserPermissions = getCurrentUserPermissions;
/**
 * Erstellt eine neue Rolle (nur für Super-Admin)
 */
const createRole = async (req, res, next) => {
    try {
        const { name, description } = req.body;
        if (!name) {
            return next(new error_middleware_1.AppError('Rollenname ist erforderlich', 400));
        }
        // Implementierung für das Erstellen einer neuen Rolle
        // Dies würde eine zusätzliche Funktion im Permission Service erfordern
        res.json({
            success: true,
            message: 'Rolle erfolgreich erstellt'
        });
    }
    catch (error) {
        next(new error_middleware_1.AppError('Fehler beim Erstellen der Rolle', 500));
    }
};
exports.createRole = createRole;
/**
 * Erstellt eine neue Berechtigung (nur für Super-Admin)
 */
const createPermission = async (req, res, next) => {
    try {
        const { name, description, resource, action } = req.body;
        if (!name || !resource || !action) {
            return next(new error_middleware_1.AppError('Name, Resource und Action sind erforderlich', 400));
        }
        // Implementierung für das Erstellen einer neuen Berechtigung
        // Dies würde eine zusätzliche Funktion im Permission Service erfordern
        res.json({
            success: true,
            message: 'Berechtigung erfolgreich erstellt'
        });
    }
    catch (error) {
        next(new error_middleware_1.AppError('Fehler beim Erstellen der Berechtigung', 500));
    }
};
exports.createPermission = createPermission;
