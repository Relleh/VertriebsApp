import { Router } from 'express';
import { authenticateToken } from '../middleware/auth.middleware';
import { 
  requireAdmin, 
  requireAdminOrManager, 
  requirePermission 
} from '../middleware/permission.middleware';
import {
  getRoles,
  getPermissions,
  getUsers,
  getUserPermissionsController,
  assignUserRole,
  assignUserPermission,
  removeUserPermission,
  getCurrentUserPermissions,
  createRole,
  createPermission
} from '../controllers/admin.controller';

const router = Router();

// Alle Admin-Routen erfordern Authentifizierung
router.use(authenticateToken);

// Benutzer-Berechtigungen (jeder authentifizierte Benutzer kann seine eigenen Berechtigungen abrufen)
router.get('/permissions/me', getCurrentUserPermissions);

// Rollen- und Berechtigungsübersicht (Admin und Manager können diese abrufen)
router.get('/roles', requireAdminOrManager, getRoles);
router.get('/permissions', requireAdminOrManager, getPermissions);

// Benutzer-Verwaltung (nur Admin)
router.get('/users', requireAdmin, getUsers);
router.get('/users/:userId/permissions', requireAdmin, getUserPermissionsController);

// Rollen-Zuweisung (nur Admin)
router.post('/users/:userId/role', requireAdmin, assignUserRole);

// Berechtigungs-Verwaltung (nur Admin)
router.post('/users/:userId/permissions', requireAdmin, assignUserPermission);
router.delete('/users/:userId/permissions', requireAdmin, removeUserPermission);

// Rollen- und Berechtigungs-Erstellung (nur Admin mit spezieller Berechtigung)
router.post('/roles', requirePermission('manage_roles'), createRole);
router.post('/permissions', requirePermission('manage_roles'), createPermission);

export default router;