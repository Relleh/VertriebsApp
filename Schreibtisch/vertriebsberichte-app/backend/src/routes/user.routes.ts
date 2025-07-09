import { Router } from 'express';
import { getProfile, getStatistics } from '../controllers/user.controller';
import { authenticateToken } from '../middleware/auth.middleware';
import { requireAdminOrManager } from '../middleware/permission.middleware';

const router = Router();

router.use(authenticateToken);

// Persönliche Benutzerdaten - alle authentifizierten Benutzer
router.get('/profile', getProfile);

// Persönliche Statistiken - alle authentifizierten Benutzer
router.get('/statistics', getStatistics);

export default router;