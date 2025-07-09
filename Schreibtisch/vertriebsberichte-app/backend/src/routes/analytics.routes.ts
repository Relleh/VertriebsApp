import { Router } from 'express';
import { getPersonalAnalytics, getTeamAnalytics, getPerformanceComparison } from '../controllers/analytics.controller';
import { authenticateToken } from '../middleware/auth.middleware';
import { requirePermission } from '../middleware/permission.middleware';

const router = Router();

// Alle Analytics-Routen benötigen Authentifizierung
router.use(authenticateToken);

/**
 * @route   GET /api/analytics/personal
 * @desc    Persönliche Analytics-Daten abrufen
 * @access  Private (alle authentifizierten Benutzer mit view_analytics Berechtigung)
 */
router.get('/personal', requirePermission('view_analytics'), getPersonalAnalytics);

/**
 * @route   GET /api/analytics/performance-comparison
 * @desc    Performance-Vergleiche abrufen
 * @access  Private (alle authentifizierten Benutzer mit view_analytics Berechtigung)
 */
router.get('/performance-comparison', requirePermission('view_analytics'), getPerformanceComparison);

/**
 * @route   GET /api/analytics/team
 * @desc    Team-Analytics-Daten abrufen (für Manager)
 * @access  Private (Manager und Admin)
 */
router.get('/team', requirePermission('view_team_reports'), getTeamAnalytics);

export default router;