"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const report_controller_1 = require("../controllers/report.controller");
const auth_middleware_1 = require("../middleware/auth.middleware");
const permission_middleware_1 = require("../middleware/permission.middleware");
const validate_middleware_1 = require("../middleware/validate.middleware");
const schemas_1 = require("../validators/schemas");
const router = (0, express_1.Router)();
router.use(auth_middleware_1.authenticateToken);
// Basis-Funktionen - alle authentifizierten Benutzer
router.post('/', (0, validate_middleware_1.validate)(schemas_1.reportSchema), report_controller_1.createReport);
router.get('/', report_controller_1.getReports); // Controller prüft automatisch Benutzer-Berechtigung
// Regionale Statistiken - nur Manager und Admin
router.get('/statistics', permission_middleware_1.requireAdminOrManager, report_controller_1.getRegionalStatistics);
// Globale Statistiken - nur Manager und Admin
router.get('/statistics/global', permission_middleware_1.requireAdminOrManager, report_controller_1.getGlobalStatistics);
// Einzelne Berichte - nur eigene Berichte oder Admin/Manager
router.get('/:id', report_controller_1.getReport); // Controller prüft Berechtigung
router.put('/:id', (0, validate_middleware_1.validate)(schemas_1.updateReportSchema), report_controller_1.updateReport); // Controller prüft Berechtigung
router.delete('/:id', report_controller_1.deleteReport); // Controller prüft Berechtigung
exports.default = router;
