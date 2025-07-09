"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.pool = exports.query = exports.dbAdapter = exports.PostgreSQLAdapter = exports.SQLiteAdapter = void 0;
exports.createDatabaseAdapter = createDatabaseAdapter;
const better_sqlite3_1 = __importDefault(require("better-sqlite3"));
const pg_1 = require("pg");
const dotenv_1 = __importDefault(require("dotenv"));
const path_1 = __importDefault(require("path"));
dotenv_1.default.config();
// SQLite adapter
class SQLiteAdapter {
    db;
    constructor() {
        const dbPath = path_1.default.resolve(process.env.DB_PATH || './database.sqlite');
        this.db = new better_sqlite3_1.default(dbPath);
        this.db.pragma('foreign_keys = ON');
    }
    query(text, params) {
        try {
            // Convert PostgreSQL syntax to SQLite syntax
            let sqliteQuery = text
                .replace(/\$(\d+)/g, '?') // Replace $1, $2, etc. with ?
                .replace(/SERIAL/g, 'INTEGER') // Replace SERIAL with INTEGER
                .replace(/CURRENT_TIMESTAMP/g, "datetime('now')"); // Replace CURRENT_TIMESTAMP
            // Convert boolean values to 0/1 for SQLite
            const convertedParams = params?.map(param => {
                if (typeof param === 'boolean') {
                    return param ? 1 : 0;
                }
                return param;
            });
            if (text.toLowerCase().includes('select')) {
                // Regular SELECT query
                const stmt = this.db.prepare(sqliteQuery);
                const rows = stmt.all(convertedParams || []);
                return { rows };
            }
            else if (text.toLowerCase().includes('insert') && text.toLowerCase().includes('returning')) {
                // Handle INSERT with RETURNING
                // Extract RETURNING fields
                const returningMatch = text.match(/RETURNING\s+(.+)$/i);
                const returningFields = returningMatch
                    ? returningMatch[1].split(',').map(field => field.trim())
                    : ['*'];
                // Remove RETURNING from query
                const insertQuery = sqliteQuery.replace(/\s+RETURNING.*$/i, '');
                // Execute INSERT
                const stmt = this.db.prepare(insertQuery);
                const result = stmt.run(convertedParams || []);
                if (!result.lastInsertRowid) {
                    throw new Error('INSERT operation failed - no row inserted');
                }
                // Get the inserted row with only the requested fields
                const tableName = text.match(/INSERT INTO (\w+)/i)?.[1];
                if (!tableName) {
                    throw new Error('Could not extract table name from INSERT query');
                }
                const selectFields = returningFields.join(', ');
                const selectStmt = this.db.prepare(`SELECT ${selectFields} FROM ${tableName} WHERE id = ?`);
                const insertedRow = selectStmt.get(result.lastInsertRowid);
                if (!insertedRow) {
                    throw new Error('Failed to retrieve inserted row');
                }
                return { rows: [insertedRow] };
            }
            else {
                // Regular INSERT/UPDATE/DELETE
                const stmt = this.db.prepare(sqliteQuery);
                const result = stmt.run(convertedParams || []);
                return { rows: [{ id: result.lastInsertRowid, affectedRows: result.changes }] };
            }
        }
        catch (error) {
            console.error('Database query error:', error);
            console.error('Query:', text);
            console.error('Params:', params);
            // Wrap in a more descriptive error
            const errorMsg = error instanceof Error ? error.message : String(error);
            throw new Error(`Database operation failed: ${errorMsg}`);
        }
    }
    beginTransaction() {
        this.db.prepare('BEGIN').run();
    }
    commit() {
        this.db.prepare('COMMIT').run();
    }
    rollback() {
        this.db.prepare('ROLLBACK').run();
    }
    close() {
        this.db.close();
    }
}
exports.SQLiteAdapter = SQLiteAdapter;
// PostgreSQL adapter (for future migration)
class PostgreSQLAdapter {
    pool;
    constructor() {
        this.pool = new pg_1.Pool({
            host: process.env.DB_HOST || 'localhost',
            port: parseInt(process.env.DB_PORT || '5432'),
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            database: process.env.DB_NAME,
            max: 20,
            idleTimeoutMillis: 30000,
            connectionTimeoutMillis: 2000,
        });
    }
    async query(text, params) {
        try {
            const result = await this.pool.query(text, params);
            return { rows: result.rows };
        }
        catch (error) {
            console.error('Database query error:', error);
            console.error('Query:', text);
            console.error('Params:', params);
            throw error;
        }
    }
    async beginTransaction() {
        await this.query('BEGIN');
    }
    async commit() {
        await this.query('COMMIT');
    }
    async rollback() {
        await this.query('ROLLBACK');
    }
    close() {
        this.pool.end();
    }
}
exports.PostgreSQLAdapter = PostgreSQLAdapter;
// Factory to create the appropriate adapter
function createDatabaseAdapter() {
    const dbType = process.env.DB_TYPE || 'sqlite';
    switch (dbType.toLowerCase()) {
        case 'postgresql':
        case 'postgres':
        case 'pg':
            return new PostgreSQLAdapter();
        case 'sqlite':
        default:
            return new SQLiteAdapter();
    }
}
// Export a singleton instance
exports.dbAdapter = createDatabaseAdapter();
// Wrapper functions for backward compatibility
const query = (text, params) => exports.dbAdapter.query(text, params);
exports.query = query;
exports.pool = {
    end: () => exports.dbAdapter.close()
};
