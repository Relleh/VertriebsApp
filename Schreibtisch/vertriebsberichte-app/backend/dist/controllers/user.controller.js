"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getStatistics = exports.getProfile = void 0;
const database_1 = require("../config/database");
const getProfile = (req, res, next) => {
    try {
        const userId = req.user?.userId;
        const result = (0, database_1.query)(`SELECT 
        u.id, u.name, u.email, u.created_at,
        r.code as region_code, r.name as region_name,
        ur.id as role_id, ur.name as role_name
      FROM users u
      JOIN regions r ON u.region_id = r.id
      LEFT JOIN user_roles ur ON u.role_id = ur.id
      WHERE u.id = ?`, [userId]);
        res.json({
            status: 'success',
            data: result.rows[0],
        });
    }
    catch (error) {
        next(error);
    }
};
exports.getProfile = getProfile;
const getStatistics = (req, res, next) => {
    try {
        const userId = req.user?.userId;
        const stats = (0, database_1.query)(`SELECT 
        COUNT(DISTINCT r.id) as total_reports,
        COUNT(DISTINCT r.customer_id) as total_customers,
        COUNT(DISTINCT CASE WHEN r.neukunde = 1 THEN r.customer_id END) as new_customers,
        COALESCE(SUM(r.auftragswert), 0) as total_orders,
        COALESCE(SUM(r.angebotswert), 0) as total_offers,
        COUNT(DISTINCT CASE WHEN r.datum >= date('now', '-7 days') THEN r.id END) as reports_last_week,
        COUNT(DISTINCT CASE WHEN r.datum >= date('now', '-30 days') THEN r.id END) as reports_last_month
      FROM reports r
      WHERE r.user_id = ?`, [userId]);
        res.json({
            status: 'success',
            data: stats.rows[0],
        });
    }
    catch (error) {
        next(error);
    }
};
exports.getStatistics = getStatistics;
