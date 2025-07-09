"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const fs_1 = __importDefault(require("fs"));
const path_1 = __importDefault(require("path"));
const better_sqlite3_1 = __importDefault(require("better-sqlite3"));
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
async function migrate() {
    try {
        console.log('Starte Datenbank-Migration...');
        const dbPath = path_1.default.resolve(process.env.DB_PATH || './database.sqlite');
        const db = new better_sqlite3_1.default(dbPath);
        // Enable foreign key constraints
        db.pragma('foreign_keys = ON');
        const schemaPath = path_1.default.join(__dirname, 'sqlite-schema.sql');
        const schema = fs_1.default.readFileSync(schemaPath, 'utf8');
        // Execute schema
        db.exec(schema);
        console.log('Migration erfolgreich abgeschlossen!');
        console.log('SQLite-Datenbank erstellt:', dbPath);
        db.close();
    }
    catch (error) {
        console.error('Fehler bei der Migration:', error);
        process.exit(1);
    }
}
migrate();
