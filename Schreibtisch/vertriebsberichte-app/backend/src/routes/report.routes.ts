import { Router } from 'express';
import {
  createReport,
  getReports,
  getReport,
  updateReport,
  deleteReport,
  getRegionalStatistics,
  getGlobalStatistics,
} from '../controllers/report.controller';
import { authenticateToken } from '../middleware/auth.middleware';
import { 
  requireAdminOrManager,
  requireDataAccess 
} from '../middleware/permission.middleware';
import { validate } from '../middleware/validate.middleware';
import { reportSchema, updateReportSchema } from '../validators/schemas';

const router = Router();

router.use(authenticateToken);

// Basis-Funktionen - alle authentifizierten Benutzer
router.post('/', validate(reportSchema), createReport);
router.get('/', getReports); // Controller prüft automatisch Benutzer-Berechtigung

// Regionale Statistiken - nur Manager und Admin
router.get('/statistics', requireAdminOrManager, getRegionalStatistics);

// Globale Statistiken - nur Manager und Admin
router.get('/statistics/global', requireAdminOrManager, getGlobalStatistics);

// Einzelne Berichte - nur eigene Berichte oder Admin/Manager
router.get('/:id', getReport); // Controller prüft Berechtigung
router.put('/:id', validate(updateReportSchema), updateReport); // Controller prüft Berechtigung
router.delete('/:id', deleteReport); // Controller prüft Berechtigung

export default router;