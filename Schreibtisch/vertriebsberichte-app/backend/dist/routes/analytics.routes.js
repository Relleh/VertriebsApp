"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const analytics_controller_1 = require("../controllers/analytics.controller");
const auth_middleware_1 = require("../middleware/auth.middleware");
const permission_middleware_1 = require("../middleware/permission.middleware");
const router = (0, express_1.Router)();
// Alle Analytics-Routen benötigen Authentifizierung
router.use(auth_middleware_1.authenticateToken);
/**
 * @route   GET /api/analytics/personal
 * @desc    Persönliche Analytics-Daten abrufen
 * @access  Private (alle authentifizierten Benutzer mit view_analytics Berechtigung)
 */
router.get('/personal', (0, permission_middleware_1.requirePermission)('view_analytics'), analytics_controller_1.getPersonalAnalytics);
/**
 * @route   GET /api/analytics/performance-comparison
 * @desc    Performance-Vergleiche abrufen
 * @access  Private (alle authentifizierten Benutzer mit view_analytics Berechtigung)
 */
router.get('/performance-comparison', (0, permission_middleware_1.requirePermission)('view_analytics'), analytics_controller_1.getPerformanceComparison);
/**
 * @route   GET /api/analytics/team
 * @desc    Team-Analytics-Daten abrufen (für Manager)
 * @access  Private (Manager und Admin)
 */
router.get('/team', (0, permission_middleware_1.requirePermission)('view_team_reports'), analytics_controller_1.getTeamAnalytics);
exports.default = router;
