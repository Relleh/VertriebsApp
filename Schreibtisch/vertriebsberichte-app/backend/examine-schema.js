const Database = require('better-sqlite3');
const path = require('path');

const dbPath = path.resolve('./database.sqlite');
const db = new Database(dbPath);

console.log('=== Current Database Schema ===');

// Get all tables
const tables = db.prepare("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'").all();

tables.forEach(table => {
  console.log(`\n--- Table: ${table.name} ---`);
  
  // Get table schema
  const schema = db.prepare(`PRAGMA table_info(${table.name})`).all();
  schema.forEach(column => {
    console.log(`  ${column.name}: ${column.type} ${column.notnull ? 'NOT NULL' : ''} ${column.dflt_value ? `DEFAULT ${column.dflt_value}` : ''} ${column.pk ? 'PRIMARY KEY' : ''}`);
  });
  
  // Get sample data (first 2 rows)
  try {
    const sampleData = db.prepare(`SELECT * FROM ${table.name} LIMIT 2`).all();
    if (sampleData.length > 0) {
      console.log('  Sample data:');
      sampleData.forEach((row, i) => {
        console.log(`    Row ${i + 1}:`, row);
      });
    }
  } catch (error) {
    console.log('  Error reading sample data:', error.message);
  }
});

db.close();