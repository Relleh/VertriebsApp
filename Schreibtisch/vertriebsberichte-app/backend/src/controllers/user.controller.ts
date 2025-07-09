import { Request, Response, NextFunction } from 'express';
import { query } from '../config/database';

export const getProfile = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = req.user?.userId;

    const result = query(
      `SELECT 
        u.id, u.name, u.email, u.created_at,
        r.code as region_code, r.name as region_name,
        ur.id as role_id, ur.name as role_name
      FROM users u
      JOIN regions r ON u.region_id = r.id
      LEFT JOIN user_roles ur ON u.role_id = ur.id
      WHERE u.id = ?`,
      [userId]
    );

    res.json({
      status: 'success',
      data: result.rows[0],
    });
  } catch (error) {
    next(error);
  }
};

export const getStatistics = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const userId = req.user?.userId;

    const stats = query(
      `SELECT 
        COUNT(DISTINCT r.id) as total_reports,
        COUNT(DISTINCT r.customer_id) as total_customers,
        COUNT(DISTINCT CASE WHEN r.neukunde = 1 THEN r.customer_id END) as new_customers,
        COALESCE(SUM(r.auftragswert), 0) as total_orders,
        COALESCE(SUM(r.angebotswert), 0) as total_offers,
        COUNT(DISTINCT CASE WHEN r.datum >= date('now', '-7 days') THEN r.id END) as reports_last_week,
        COUNT(DISTINCT CASE WHEN r.datum >= date('now', '-30 days') THEN r.id END) as reports_last_month
      FROM reports r
      WHERE r.user_id = ?`,
      [userId]
    );

    res.json({
      status: 'success',
      data: stats.rows[0],
    });
  } catch (error) {
    next(error);
  }
};