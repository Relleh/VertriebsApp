import { Request, Response } from 'express';
import { query } from '../config/database';
import { AppError } from '../middleware/error.middleware';

/**
 * Persönliche Analytics-Daten für einen Benutzer abrufen
 */
export const getPersonalAnalytics = async (req: Request, res: Response) => {
  try {
    const userId = req.user?.userId;
    if (!userId) {
      throw new AppError('Benutzer nicht authentifiziert', 401);
    }

    const days = parseInt(req.query.days as string) || 30;
    const dateFrom = new Date();
    dateFrom.setDate(dateFrom.getDate() - days);

    // Persönliche Statistiken
    const personalStatsQuery = `
      SELECT 
        COUNT(*) as totalReports,
        COALESCE(AVG(r.auftragswert), 0) as averageOrderValue,
        COALESCE(SUM(r.auftragswert), 0) as totalOrderValue,
        COUNT(CASE WHEN r.neukunde = 1 THEN 1 END) as newCustomers
      FROM reports r 
      WHERE r.user_id = ? AND r.datum >= ?
    `;

    const personalStats = query(personalStatsQuery, [userId, dateFrom.toISOString().split('T')[0]]);

    // Neueste Aktivitäten
    const recentActivityQuery = `
      SELECT 
        r.datum as date,
        COALESCE(c.name, 'Unbekannter Kunde') as kunde_name,
        r.auftragswert,
        r.status
      FROM reports r
      LEFT JOIN customers c ON r.customer_id = c.id
      WHERE r.user_id = ? AND r.datum >= ?
      ORDER BY r.datum DESC, r.created_at DESC
      LIMIT 10
    `;

    const recentActivity = query(recentActivityQuery, [userId, dateFrom.toISOString().split('T')[0]]);

    // Monatstrends (letzte 6 Monate)
    const monthlyTrendsQuery = `
      SELECT 
        strftime('%Y-%m', r.datum) as month,
        COUNT(*) as reportCount,
        COALESCE(SUM(r.auftragswert), 0) as totalValue
      FROM reports r
      WHERE r.user_id = ? AND r.datum >= date('now', '-6 months')
      GROUP BY strftime('%Y-%m', r.datum)
      ORDER BY month DESC
      LIMIT 6
    `;

    const monthlyTrends = query(monthlyTrendsQuery, [userId]);

    // Status-Verteilung
    const statusDistributionQuery = `
      SELECT 
        CASE r.status
          WHEN 'K' THEN 'Komplett'
          WHEN 'U' THEN 'Umsetzung'
          WHEN 'B' THEN 'Bearbeitung'
          WHEN 'O' THEN 'Offen'
          WHEN 'V' THEN 'Verschoben'
          WHEN 'I' THEN 'Info'
          ELSE 'Unbekannt'
        END as status,
        COUNT(*) as count,
        ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM reports WHERE user_id = ? AND datum >= ?), 1) as percentage
      FROM reports r
      WHERE r.user_id = ? AND r.datum >= ?
      GROUP BY r.status
      ORDER BY count DESC
    `;

    const statusDistribution = query(statusDistributionQuery, [userId, dateFrom.toISOString().split('T')[0], userId, dateFrom.toISOString().split('T')[0]]);

    // Formatiere monatliche Trends für bessere Lesbarkeit
    const formattedMonthlyTrends = monthlyTrends.rows.map((trend: any) => ({
      month: new Date(trend.month + '-01').toLocaleDateString('de-DE', { year: 'numeric', month: 'short' }),
      reportCount: trend.reportCount,
      totalValue: trend.totalValue
    })).reverse(); // Chronologisch sortieren

    const result = {
      personalStats: personalStats.rows[0] || {
        totalReports: 0,
        averageOrderValue: 0,
        totalOrderValue: 0,
        newCustomers: 0
      },
      recentActivity: recentActivity.rows,
      monthlyTrends: formattedMonthlyTrends,
      statusDistribution: statusDistribution.rows
    };

    res.json(result);
  } catch (error) {
    console.error('Fehler beim Abrufen der Analytics-Daten:', error);
    res.status(500).json({
      status: 'error',
      message: 'Fehler beim Abrufen der Analytics-Daten'
    });
  }
};

/**
 * Team-Analytics-Daten für Manager abrufen (falls erweitert werden soll)
 */
export const getTeamAnalytics = async (req: Request, res: Response) => {
  try {
    const userId = req.user?.userId;
    if (!userId) {
      throw new AppError('Benutzer nicht authentifiziert', 401);
    }

    // Hier könnte Team-Analytics für Manager implementiert werden
    res.json({
      message: 'Team-Analytics noch nicht implementiert'
    });
  } catch (error) {
    console.error('Fehler beim Abrufen der Team-Analytics:', error);
    res.status(500).json({
      status: 'error',
      message: 'Fehler beim Abrufen der Team-Analytics'
    });
  }
};

/**
 * Performance-Vergleiche für Analytics
 */
export const getPerformanceComparison = async (req: Request, res: Response) => {
  try {
    const userId = req.user?.userId;
    if (!userId) {
      throw new AppError('Benutzer nicht authentifiziert', 401);
    }

    const period = req.query.period as string || 'month';
    
    // Vergleiche mit vorheriger Periode
    let dateCondition = '';
    let previousDateCondition = '';
    
    switch (period) {
      case 'week':
        dateCondition = "r.datum >= date('now', '-7 days')";
        previousDateCondition = "r.datum >= date('now', '-14 days') AND r.datum < date('now', '-7 days')";
        break;
      case 'month':
        dateCondition = "r.datum >= date('now', '-30 days')";
        previousDateCondition = "r.datum >= date('now', '-60 days') AND r.datum < date('now', '-30 days')";
        break;
      case 'quarter':
        dateCondition = "r.datum >= date('now', '-90 days')";
        previousDateCondition = "r.datum >= date('now', '-180 days') AND r.datum < date('now', '-90 days')";
        break;
      default:
        dateCondition = "r.datum >= date('now', '-30 days')";
        previousDateCondition = "r.datum >= date('now', '-60 days') AND r.datum < date('now', '-30 days')";
    }

    const currentPeriodQuery = `
      SELECT 
        COUNT(*) as reportCount,
        COALESCE(SUM(r.auftragswert), 0) as totalValue,
        COALESCE(AVG(r.auftragswert), 0) as averageValue
      FROM reports r 
      WHERE r.user_id = ? AND ${dateCondition}
    `;

    const previousPeriodQuery = `
      SELECT 
        COUNT(*) as reportCount,
        COALESCE(SUM(r.auftragswert), 0) as totalValue,
        COALESCE(AVG(r.auftragswert), 0) as averageValue
      FROM reports r 
      WHERE r.user_id = ? AND ${previousDateCondition}
    `;

    const currentPeriod = query(currentPeriodQuery, [userId]);
    const previousPeriod = query(previousPeriodQuery, [userId]);

    const current = currentPeriod.rows[0];
    const previous = previousPeriod.rows[0];

    const comparison = {
      current: current,
      previous: previous,
      changes: {
        reportCount: previous.reportCount > 0 ? 
          Math.round(((current.reportCount - previous.reportCount) / previous.reportCount) * 100) : 0,
        totalValue: previous.totalValue > 0 ? 
          Math.round(((current.totalValue - previous.totalValue) / previous.totalValue) * 100) : 0,
        averageValue: previous.averageValue > 0 ? 
          Math.round(((current.averageValue - previous.averageValue) / previous.averageValue) * 100) : 0
      }
    };

    res.json(comparison);
  } catch (error) {
    console.error('Fehler beim Abrufen der Performance-Vergleiche:', error);
    res.status(500).json({
      status: 'error',
      message: 'Fehler beim Abrufen der Performance-Vergleiche'
    });
  }
};