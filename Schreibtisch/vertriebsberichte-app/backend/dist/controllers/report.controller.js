"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getGlobalStatistics = exports.getRegionalStatistics = exports.deleteReport = exports.updateReport = exports.getReport = exports.getReports = exports.createReport = void 0;
const database_1 = require("../config/database");
const error_middleware_1 = require("../middleware/error.middleware");
const createReport = (req, res, next) => {
    try {
        const userId = req.user?.userId;
        const { kundeNr, kundeName, ansprechpartner, ort, datum, kurzbericht, todos, klassifizierung, auftragswert, angebotswert, naechsterBesuch, neukunde, uebernachtung, status, } = req.body;
        // Get customer or create new one
        let customerId;
        const customerResult = (0, database_1.query)('SELECT id FROM customers WHERE kunde_nr = ?', [kundeNr]);
        if (customerResult.rows.length === 0) {
            const userRegion = (0, database_1.query)('SELECT region_id FROM users WHERE id = ?', [userId]);
            const newCustomer = (0, database_1.query)('INSERT INTO customers (kunde_nr, name, region_id, klassifizierung, is_neukunde) VALUES (?, ?, ?, ?, ?) RETURNING id', [kundeNr, kundeName, userRegion.rows[0].region_id, klassifizierung, neukunde]);
            customerId = newCustomer.rows[0].id;
        }
        else {
            customerId = customerResult.rows[0].id;
            (0, database_1.query)('UPDATE customers SET klassifizierung = ?, is_neukunde = ?, updated_at = datetime(\'now\') WHERE id = ?', [klassifizierung, neukunde, customerId]);
        }
        const report = (0, database_1.query)(`INSERT INTO reports (
        user_id, customer_id, ansprechpartner, ort, datum, 
        kurzbericht, todos, klassifizierung, auftragswert, 
        angebotswert, naechster_besuch_wochen, neukunde, 
        uebernachtung, status
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) 
      RETURNING *`, [
            userId, customerId, ansprechpartner, ort, datum,
            kurzbericht, todos, klassifizierung, auftragswert,
            angebotswert, naechsterBesuch, neukunde,
            uebernachtung, status
        ]);
        res.status(201).json({
            status: 'success',
            data: report.rows[0],
        });
    }
    catch (error) {
        console.error('Report creation error:', error);
        const errorMsg = error instanceof Error ? error.message : 'Unbekannter Fehler';
        next(new error_middleware_1.AppError(`Fehler beim Erstellen des Berichts: ${errorMsg}`, 500));
    }
};
exports.createReport = createReport;
const getReports = (req, res, next) => {
    try {
        const userId = req.user?.userId;
        const { page = 1, limit = 20, startDate, endDate, kundeNr, kundeName, mitarbeiterName, ort, klassifizierung, status, neukunde, minAuftragswert, maxAuftragswert, sortBy = 'datum', sortOrder = 'desc', search } = req.query;
        const offset = (Number(page) - 1) * Number(limit);
        let queryText = `
      SELECT 
        r.*,
        c.kunde_nr,
        c.name as kunde_name,
        u.name as mitarbeiter_name,
        reg.name as region_name
      FROM reports r
      JOIN customers c ON r.customer_id = c.id
      JOIN users u ON r.user_id = u.id
      JOIN regions reg ON u.region_id = reg.id
      WHERE r.user_id = ?
    `;
        const queryParams = [userId];
        let countQueryText = `
      SELECT COUNT(*) as count 
      FROM reports r
      JOIN customers c ON r.customer_id = c.id
      JOIN users u ON r.user_id = u.id
      WHERE r.user_id = ?
    `;
        const countParams = [userId];
        // Erweiterte Filter
        if (startDate) {
            queryParams.push(startDate);
            countParams.push(startDate);
            queryText += ` AND r.datum >= ?`;
            countQueryText += ` AND r.datum >= ?`;
        }
        if (endDate) {
            queryParams.push(endDate);
            countParams.push(endDate);
            queryText += ` AND r.datum <= ?`;
            countQueryText += ` AND r.datum <= ?`;
        }
        if (kundeNr) {
            queryParams.push(`%${kundeNr}%`);
            countParams.push(`%${kundeNr}%`);
            queryText += ` AND c.kunde_nr LIKE ?`;
            countQueryText += ` AND c.kunde_nr LIKE ?`;
        }
        if (kundeName) {
            queryParams.push(`%${kundeName}%`);
            countParams.push(`%${kundeName}%`);
            queryText += ` AND c.name LIKE ?`;
            countQueryText += ` AND c.name LIKE ?`;
        }
        if (mitarbeiterName) {
            queryParams.push(`%${mitarbeiterName}%`);
            countParams.push(`%${mitarbeiterName}%`);
            queryText += ` AND u.name LIKE ?`;
            countQueryText += ` AND u.name LIKE ?`;
        }
        if (ort) {
            queryParams.push(`%${ort}%`);
            countParams.push(`%${ort}%`);
            queryText += ` AND r.ort LIKE ?`;
            countQueryText += ` AND r.ort LIKE ?`;
        }
        if (klassifizierung) {
            queryParams.push(klassifizierung);
            countParams.push(klassifizierung);
            queryText += ` AND r.klassifizierung = ?`;
            countQueryText += ` AND r.klassifizierung = ?`;
        }
        if (status) {
            queryParams.push(status);
            countParams.push(status);
            queryText += ` AND r.status = ?`;
            countQueryText += ` AND r.status = ?`;
        }
        if (neukunde !== undefined) {
            const neukundeValue = neukunde === 'true' ? 1 : 0;
            queryParams.push(neukundeValue);
            countParams.push(neukundeValue);
            queryText += ` AND r.neukunde = ?`;
            countQueryText += ` AND r.neukunde = ?`;
        }
        if (minAuftragswert) {
            queryParams.push(Number(minAuftragswert));
            countParams.push(Number(minAuftragswert));
            queryText += ` AND r.auftragswert >= ?`;
            countQueryText += ` AND r.auftragswert >= ?`;
        }
        if (maxAuftragswert) {
            queryParams.push(Number(maxAuftragswert));
            countParams.push(Number(maxAuftragswert));
            queryText += ` AND r.auftragswert <= ?`;
            countQueryText += ` AND r.auftragswert <= ?`;
        }
        // Volltext-Suche
        if (search) {
            const searchTerm = `%${search}%`;
            queryParams.push(searchTerm, searchTerm, searchTerm, searchTerm);
            countParams.push(searchTerm, searchTerm, searchTerm, searchTerm);
            queryText += ` AND (
        r.kurzbericht LIKE ? OR 
        r.todos LIKE ? OR 
        c.name LIKE ? OR 
        r.ansprechpartner LIKE ?
      )`;
            countQueryText += ` AND (
        r.kurzbericht LIKE ? OR 
        r.todos LIKE ? OR 
        c.name LIKE ? OR 
        r.ansprechpartner LIKE ?
      )`;
        }
        // Sortierung
        const validSortFields = {
            'datum': 'r.datum',
            'kunde_name': 'c.name',
            'mitarbeiter_name': 'u.name',
            'ort': 'r.ort',
            'klassifizierung': 'r.klassifizierung',
            'auftragswert': 'r.auftragswert',
            'angebotswert': 'r.angebotswert',
            'status': 'r.status',
            'created_at': 'r.created_at'
        };
        const sortField = validSortFields[sortBy] || 'r.datum';
        const sortDirection = String(sortOrder || '').toLowerCase() === 'asc' ? 'ASC' : 'DESC';
        queryText += ` ORDER BY ${sortField} ${sortDirection}, r.created_at DESC`;
        // Pagination
        queryParams.push(Number(limit), offset);
        queryText += ` LIMIT ? OFFSET ?`;
        const reports = (0, database_1.query)(queryText, queryParams);
        const countResult = (0, database_1.query)(countQueryText, countParams);
        res.json({
            status: 'success',
            data: reports.rows,
            pagination: {
                page: Number(page),
                limit: Number(limit),
                total: Number(countResult.rows[0].count),
                totalPages: Math.ceil(Number(countResult.rows[0].count) / Number(limit)),
            },
            filters: {
                startDate,
                endDate,
                kundeNr,
                kundeName,
                mitarbeiterName,
                ort,
                klassifizierung,
                status,
                neukunde,
                minAuftragswert,
                maxAuftragswert,
                sortBy,
                sortOrder,
                search
            }
        });
    }
    catch (error) {
        console.error('Get reports error:', error);
        next(new error_middleware_1.AppError('Fehler beim Laden der Berichte', 500));
    }
};
exports.getReports = getReports;
const getReport = (req, res, next) => {
    try {
        const userId = req.user?.userId;
        const { id } = req.params;
        const report = (0, database_1.query)(`SELECT 
        r.*,
        c.kunde_nr,
        c.name as kunde_name,
        u.name as mitarbeiter_name,
        u.email as mitarbeiter_email,
        reg.name as region_name
      FROM reports r
      JOIN customers c ON r.customer_id = c.id
      JOIN users u ON r.user_id = u.id
      JOIN regions reg ON u.region_id = reg.id
      WHERE r.id = ? AND r.user_id = ?`, [id, userId]);
        if (report.rows.length === 0) {
            return next(new error_middleware_1.AppError('Bericht nicht gefunden', 404));
        }
        res.json({
            status: 'success',
            data: report.rows[0],
        });
    }
    catch (error) {
        next(error);
    }
};
exports.getReport = getReport;
const updateReport = (req, res, next) => {
    try {
        const userId = req.user?.userId;
        const { id } = req.params;
        const { ansprechpartner, ort, datum, kurzbericht, todos, klassifizierung, auftragswert, angebotswert, naechsterBesuch, neukunde, uebernachtung, status, } = req.body;
        const existingReport = (0, database_1.query)('SELECT id FROM reports WHERE id = ? AND user_id = ?', [id, userId]);
        if (existingReport.rows.length === 0) {
            return next(new error_middleware_1.AppError('Bericht nicht gefunden', 404));
        }
        const updatedReport = (0, database_1.query)(`UPDATE reports SET 
        ansprechpartner = ?, ort = ?, datum = ?, kurzbericht = ?,
        todos = ?, klassifizierung = ?, auftragswert = ?,
        angebotswert = ?, naechster_besuch_wochen = ?, neukunde = ?,
        uebernachtung = ?, status = ?, updated_at = datetime('now')
      WHERE id = ? AND user_id = ? RETURNING *`, [
            ansprechpartner, ort, datum, kurzbericht, todos,
            klassifizierung, auftragswert, angebotswert, naechsterBesuch,
            neukunde, uebernachtung, status, id, userId
        ]);
        res.json({
            status: 'success',
            data: updatedReport.rows[0],
        });
    }
    catch (error) {
        console.error('Report update error:', error);
        const errorMsg = error instanceof Error ? error.message : 'Unbekannter Fehler';
        next(new error_middleware_1.AppError(`Fehler beim Aktualisieren des Berichts: ${errorMsg}`, 500));
    }
};
exports.updateReport = updateReport;
const deleteReport = (req, res, next) => {
    try {
        const userId = req.user?.userId;
        const { id } = req.params;
        const result = (0, database_1.query)('DELETE FROM reports WHERE id = ? AND user_id = ? RETURNING id', [id, userId]);
        if (result.rows.length === 0) {
            return next(new error_middleware_1.AppError('Bericht nicht gefunden', 404));
        }
        res.status(204).send();
    }
    catch (error) {
        next(error);
    }
};
exports.deleteReport = deleteReport;
const getRegionalStatistics = (req, res, next) => {
    try {
        const { startDate, endDate } = req.query;
        let queryText = `
      SELECT 
        r.code as region_code,
        r.name as region_name,
        COUNT(DISTINCT CASE WHEN c.klassifizierung = 'A' THEN c.id END) as a_kunden,
        COUNT(DISTINCT CASE WHEN c.klassifizierung = 'B' THEN c.id END) as b_kunden,
        COUNT(DISTINCT CASE WHEN c.klassifizierung = 'C' THEN c.id END) as c_kunden,
        COUNT(DISTINCT c.id) as gesamt_kunden,
        COUNT(DISTINCT CASE WHEN c.is_neukunde = true THEN c.id END) as neue_kunden,
        COALESCE(SUM(rep.auftragswert), 0) as gesamt_auftragswert,
        COALESCE(SUM(rep.angebotswert), 0) as gesamt_angebotswert
      FROM regions r
      LEFT JOIN users u ON u.region_id = r.id
      LEFT JOIN reports rep ON rep.user_id = u.id
      LEFT JOIN customers c ON rep.customer_id = c.id
    `;
        const queryParams = [];
        if (startDate || endDate) {
            queryText += ' WHERE 1=1';
            if (startDate) {
                queryParams.push(startDate);
                queryText += ` AND rep.datum >= ?`;
            }
            if (endDate) {
                queryParams.push(endDate);
                queryText += ` AND rep.datum <= ?`;
            }
        }
        queryText += ' GROUP BY r.id, r.code, r.name ORDER BY r.name';
        const statistics = (0, database_1.query)(queryText, queryParams);
        res.json({
            status: 'success',
            data: statistics.rows,
        });
    }
    catch (error) {
        next(error);
    }
};
exports.getRegionalStatistics = getRegionalStatistics;
const getGlobalStatistics = (req, res, next) => {
    try {
        const { startDate, endDate } = req.query;
        const queryParams = [];
        // Globale Übersicht - Gesamtzahlen
        let globalQueryText = `
      SELECT 
        COUNT(DISTINCT rep.id) as gesamt_berichte,
        COUNT(DISTINCT c.id) as gesamt_kunden,
        COUNT(DISTINCT CASE WHEN c.is_neukunde = true THEN c.id END) as neue_kunden,
        COUNT(DISTINCT CASE WHEN c.klassifizierung = 'A' THEN c.id END) as a_kunden,
        COUNT(DISTINCT CASE WHEN c.klassifizierung = 'B' THEN c.id END) as b_kunden,
        COUNT(DISTINCT CASE WHEN c.klassifizierung = 'C' THEN c.id END) as c_kunden,
        COUNT(DISTINCT u.id) as aktive_mitarbeiter,
        COALESCE(SUM(rep.auftragswert), 0) as gesamt_auftragswert,
        COALESCE(SUM(rep.angebotswert), 0) as gesamt_angebotswert,
        COALESCE(AVG(rep.auftragswert), 0) as durchschnitt_auftragswert,
        COALESCE(AVG(rep.angebotswert), 0) as durchschnitt_angebotswert
      FROM reports rep
      JOIN customers c ON rep.customer_id = c.id
      JOIN users u ON rep.user_id = u.id
    `;
        // Mitarbeiter-Performance
        let employeeQueryText = `
      SELECT 
        u.id as mitarbeiter_id,
        u.name as mitarbeiter_name,
        u.email as mitarbeiter_email,
        r.name as region_name,
        COUNT(DISTINCT rep.id) as anzahl_berichte,
        COUNT(DISTINCT c.id) as anzahl_kunden,
        COUNT(DISTINCT CASE WHEN c.is_neukunde = true THEN c.id END) as neue_kunden,
        COALESCE(SUM(rep.auftragswert), 0) as auftragswert_gesamt,
        COALESCE(SUM(rep.angebotswert), 0) as angebotswert_gesamt,
        COALESCE(AVG(rep.auftragswert), 0) as auftragswert_durchschnitt
      FROM users u
      JOIN regions r ON u.region_id = r.id
      LEFT JOIN reports rep ON rep.user_id = u.id
      LEFT JOIN customers c ON rep.customer_id = c.id
    `;
        // Top Kunden
        let topCustomersQueryText = `
      SELECT 
        c.kunde_nr,
        c.name as kunde_name,
        c.klassifizierung,
        r.name as region_name,
        COUNT(rep.id) as anzahl_berichte,
        COALESCE(SUM(rep.auftragswert), 0) as auftragswert_gesamt,
        COALESCE(SUM(rep.angebotswert), 0) as angebotswert_gesamt,
        MAX(rep.datum) as letzter_besuch
      FROM customers c
      JOIN users u ON c.region_id = u.region_id
      JOIN regions r ON c.region_id = r.id
      LEFT JOIN reports rep ON rep.customer_id = c.id
    `;
        // Zeitbasierte Trends (letzte 12 Monate)
        let trendsQueryText = `
      SELECT 
        strftime('%Y-%m', rep.datum) as monat,
        COUNT(DISTINCT rep.id) as berichte_anzahl,
        COUNT(DISTINCT c.id) as kunden_anzahl,
        COALESCE(SUM(rep.auftragswert), 0) as auftragswert,
        COALESCE(SUM(rep.angebotswert), 0) as angebotswert
      FROM reports rep
      JOIN customers c ON rep.customer_id = c.id
      WHERE rep.datum >= date('now', '-12 months')
    `;
        // Date filter anwenden
        if (startDate || endDate) {
            const whereClause = ' WHERE 1=1';
            globalQueryText += whereClause;
            employeeQueryText += whereClause;
            topCustomersQueryText += whereClause;
            if (startDate) {
                queryParams.push(startDate, startDate, startDate);
                globalQueryText += ` AND rep.datum >= ?`;
                employeeQueryText += ` AND rep.datum >= ?`;
                topCustomersQueryText += ` AND rep.datum >= ?`;
            }
            if (endDate) {
                queryParams.push(endDate, endDate, endDate);
                globalQueryText += ` AND rep.datum <= ?`;
                employeeQueryText += ` AND rep.datum <= ?`;
                topCustomersQueryText += ` AND rep.datum <= ?`;
            }
        }
        // GROUP BY und ORDER BY
        employeeQueryText += ' GROUP BY u.id, u.name, u.email, r.name ORDER BY auftragswert_gesamt DESC';
        topCustomersQueryText += ' GROUP BY c.id, c.kunde_nr, c.name, c.klassifizierung, r.name ORDER BY auftragswert_gesamt DESC LIMIT 20';
        trendsQueryText += ' GROUP BY strftime(\'%Y-%m\', rep.datum) ORDER BY monat DESC';
        // Alle Queries ausführen
        const globalStats = (0, database_1.query)(globalQueryText, queryParams.slice(0, queryParams.length / 3));
        const employeeStats = (0, database_1.query)(employeeQueryText, queryParams.slice(0, queryParams.length / 3));
        const topCustomers = (0, database_1.query)(topCustomersQueryText, queryParams.slice(0, queryParams.length / 3));
        const trends = (0, database_1.query)(trendsQueryText, []);
        res.json({
            status: 'success',
            data: {
                global: globalStats.rows[0] || {},
                mitarbeiter: employeeStats.rows || [],
                topKunden: topCustomers.rows || [],
                trends: trends.rows || []
            }
        });
    }
    catch (error) {
        console.error('Global statistics error:', error);
        next(new error_middleware_1.AppError('Fehler beim Laden der globalen Statistiken', 500));
    }
};
exports.getGlobalStatistics = getGlobalStatistics;
