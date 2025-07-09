"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const auth_middleware_1 = require("../middleware/auth.middleware");
const permission_middleware_1 = require("../middleware/permission.middleware");
const admin_controller_1 = require("../controllers/admin.controller");
const router = (0, express_1.Router)();
// Alle Admin-Routen erfordern Authentifizierung
router.use(auth_middleware_1.authenticateToken);
// Benutzer-Berechtigungen (jeder authentifizierte Benutzer kann seine eigenen Berechtigungen abrufen)
router.get('/permissions/me', admin_controller_1.getCurrentUserPermissions);
// Rollen- und Berechtigungsübersicht (Admin und Manager können diese abrufen)
router.get('/roles', permission_middleware_1.requireAdminOrManager, admin_controller_1.getRoles);
router.get('/permissions', permission_middleware_1.requireAdminOrManager, admin_controller_1.getPermissions);
// Benutzer-Verwaltung (nur Admin)
router.get('/users', permission_middleware_1.requireAdmin, admin_controller_1.getUsers);
router.get('/users/:userId/permissions', permission_middleware_1.requireAdmin, admin_controller_1.getUserPermissionsController);
// Rollen-Zuweisung (nur Admin)
router.post('/users/:userId/role', permission_middleware_1.requireAdmin, admin_controller_1.assignUserRole);
// Berechtigungs-Verwaltung (nur Admin)
router.post('/users/:userId/permissions', permission_middleware_1.requireAdmin, admin_controller_1.assignUserPermission);
router.delete('/users/:userId/permissions', permission_middleware_1.requireAdmin, admin_controller_1.removeUserPermission);
// Rollen- und Berechtigungs-Erstellung (nur Admin mit spezieller Berechtigung)
router.post('/roles', (0, permission_middleware_1.requirePermission)('manage_roles'), admin_controller_1.createRole);
router.post('/permissions', (0, permission_middleware_1.requirePermission)('manage_roles'), admin_controller_1.createPermission);
exports.default = router;
