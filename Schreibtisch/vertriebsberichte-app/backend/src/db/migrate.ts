import fs from 'fs';
import path from 'path';
import Database from 'better-sqlite3';
import dotenv from 'dotenv';

dotenv.config();

async function migrate() {
  try {
    console.log('Starte Datenbank-Migration...');
    
    const dbPath = path.resolve(process.env.DB_PATH || './database.sqlite');
    const db = new Database(dbPath);
    
    // Enable foreign key constraints
    db.pragma('foreign_keys = ON');
    
    const schemaPath = path.join(__dirname, 'sqlite-schema.sql');
    const schema = fs.readFileSync(schemaPath, 'utf8');
    
    // Execute schema
    db.exec(schema);
    
    console.log('Migration erfolgreich abgeschlossen!');
    console.log('SQLite-Datenbank erstellt:', dbPath);
    
    db.close();
  } catch (error) {
    console.error('Fehler bei der Migration:', error);
    process.exit(1);
  }
}

migrate();