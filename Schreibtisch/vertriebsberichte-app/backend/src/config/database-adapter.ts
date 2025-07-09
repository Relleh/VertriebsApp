import Database from 'better-sqlite3';
import { Pool } from 'pg';
import dotenv from 'dotenv';
import path from 'path';

dotenv.config();

// Database adapter interface
export interface DatabaseAdapter {
  query(text: string, params?: any[]): Promise<{ rows: any[] }> | { rows: any[] };
  close(): void;
  beginTransaction(): void;
  commit(): void;
  rollback(): void;
}

// SQLite adapter
export class SQLiteAdapter implements DatabaseAdapter {
  private db: Database.Database;
  
  constructor() {
    const dbPath = path.resolve(process.env.DB_PATH || './database.sqlite');
    this.db = new Database(dbPath);
    this.db.pragma('foreign_keys = ON');
  }
  
  query(text: string, params?: any[]): { rows: any[] } {
    try {
      // Convert PostgreSQL syntax to SQLite syntax
      let sqliteQuery = text
        .replace(/\$(\d+)/g, '?') // Replace $1, $2, etc. with ?
        .replace(/SERIAL/g, 'INTEGER') // Replace SERIAL with INTEGER
        .replace(/CURRENT_TIMESTAMP/g, "datetime('now')") // Replace CURRENT_TIMESTAMP
      
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
      } else if (text.toLowerCase().includes('insert') && text.toLowerCase().includes('returning')) {
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
      } else {
        // Regular INSERT/UPDATE/DELETE
        const stmt = this.db.prepare(sqliteQuery);
        const result = stmt.run(convertedParams || []);
        return { rows: [{ id: result.lastInsertRowid, affectedRows: result.changes }] };
      }
    } catch (error) {
      console.error('Database query error:', error);
      console.error('Query:', text);
      console.error('Params:', params);
      
      // Wrap in a more descriptive error
      const errorMsg = error instanceof Error ? error.message : String(error);
      throw new Error(`Database operation failed: ${errorMsg}`);
    }
  }
  
  beginTransaction(): void {
    this.db.prepare('BEGIN').run();
  }
  
  commit(): void {
    this.db.prepare('COMMIT').run();
  }
  
  rollback(): void {
    this.db.prepare('ROLLBACK').run();
  }
  
  close(): void {
    this.db.close();
  }
}

// PostgreSQL adapter (for future migration)
export class PostgreSQLAdapter implements DatabaseAdapter {
  private pool: Pool;
  
  constructor() {
    this.pool = new Pool({
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
  
  async query(text: string, params?: any[]): Promise<{ rows: any[] }> {
    try {
      const result = await this.pool.query(text, params);
      return { rows: result.rows };
    } catch (error) {
      console.error('Database query error:', error);
      console.error('Query:', text);
      console.error('Params:', params);
      throw error;
    }
  }
  
  async beginTransaction(): Promise<void> {
    await this.query('BEGIN');
  }
  
  async commit(): Promise<void> {
    await this.query('COMMIT');
  }
  
  async rollback(): Promise<void> {
    await this.query('ROLLBACK');
  }
  
  close(): void {
    this.pool.end();
  }
}

// Factory to create the appropriate adapter
export function createDatabaseAdapter(): DatabaseAdapter {
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
export const dbAdapter = createDatabaseAdapter();

// Wrapper functions for backward compatibility
export const query = (text: string, params?: any[]) => dbAdapter.query(text, params);
export const pool = {
  end: () => dbAdapter.close()
};