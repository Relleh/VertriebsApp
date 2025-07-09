"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const user_controller_1 = require("../controllers/user.controller");
const auth_middleware_1 = require("../middleware/auth.middleware");
const router = (0, express_1.Router)();
router.use(auth_middleware_1.authenticateToken);
// Persönliche Benutzerdaten - alle authentifizierten Benutzer
router.get('/profile', user_controller_1.getProfile);
// Persönliche Statistiken - alle authentifizierten Benutzer
router.get('/statistics', user_controller_1.getStatistics);
exports.default = router;
