"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.migrateRoles = migrateRoles;
const fs_1 = __importDefault(require("fs"));
const path_1 = __importDefault(require("path"));
const better_sqlite3_1 = __importDefault(require("better-sqlite3"));
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
async function migrateRoles() {
    try {
        console.log('🚀 Starte Rollen-Migration...');
        const dbPath = path_1.default.resolve(process.env.DB_PATH || './database.sqlite');
        const db = new better_sqlite3_1.default(dbPath);
        // Enable foreign key constraints
        db.pragma('foreign_keys = ON');
        console.log('📂 Verwende Datenbank:', dbPath);
        // Prüfe ob Rollentabellen bereits existieren
        const tablesCheck = db.prepare(`
      SELECT name FROM sqlite_master 
      WHERE type='table' AND name IN ('user_roles', 'permissions', 'user_permissions')
    `).all();
        console.log('🔍 Gefundene Rollentabellen:', tablesCheck.map((t) => t.name));
        if (tablesCheck.length >= 3) {
            console.log('✅ Rollentabellen existieren bereits');
            // Prüfe ob users Tabelle role_id Spalte hat
            const usersSchema = db.prepare("PRAGMA table_info(users)").all();
            const hasRoleColumn = usersSchema.some((col) => col.name === 'role_id');
            if (hasRoleColumn) {
                console.log('✅ users.role_id Spalte existiert bereits');
                // Prüfe ob Rollen bereits erstellt wurden
                const rolesCount = db.prepare("SELECT COUNT(*) as count FROM user_roles").get();
                if (rolesCount.count > 0) {
                    console.log('✅ Rollen sind bereits konfiguriert');
                    console.log('✨ Migration bereits abgeschlossen!');
                    db.close();
                    return;
                }
            }
        }
        console.log('⚡ Führe Rollen-Migration durch...');
        // Lese und führe das komplette Schema aus
        const schemaPath = path_1.default.join(__dirname, 'sqlite-schema.sql');
        const schema = fs_1.default.readFileSync(schemaPath, 'utf8');
        // First check if users table exists and needs role_id column
        const usersTableExists = db.prepare(`
      SELECT name FROM sqlite_master WHERE type='table' AND name='users'
    `).get();
        if (usersTableExists) {
            console.log('👤 Existierende users Tabelle gefunden');
            // Check if role_id column exists
            const usersSchema = db.prepare("PRAGMA table_info(users)").all();
            const hasRoleColumn = usersSchema.some((col) => col.name === 'role_id');
            if (!hasRoleColumn) {
                console.log('🔧 Füge role_id Spalte zur users Tabelle hinzu...');
                db.exec('ALTER TABLE users ADD COLUMN role_id INTEGER REFERENCES user_roles(id)');
                console.log('✅ role_id Spalte hinzugefügt');
            }
        }
        // Execute schema (this will create missing tables but not modify existing ones)
        db.exec(schema);
        console.log('✅ Schema erfolgreich ausgeführt');
        // Prüfe ob es Benutzer ohne Rollen gibt und weise Standard-Rolle zu
        const usersWithoutRoles = db.prepare(`
      SELECT id, name, email FROM users WHERE role_id IS NULL
    `).all();
        if (usersWithoutRoles.length > 0) {
            console.log(`👤 Gefunden: ${usersWithoutRoles.length} Benutzer ohne Rollen`);
            // Hole employee role ID
            const employeeRole = db.prepare(`
        SELECT id FROM user_roles WHERE name = 'employee'
      `).get();
            if (employeeRole) {
                console.log('📝 Weise Standard-Rolle "employee" zu...');
                const updateStmt = db.prepare(`
          UPDATE users SET role_id = ? WHERE id = ?
        `);
                const insertPermissionStmt = db.prepare(`
          INSERT OR IGNORE INTO user_permissions (user_id, permission_id)
          SELECT ?, p.id FROM permissions p WHERE p.name = 'view_analytics'
        `);
                for (const user of usersWithoutRoles) {
                    // Weise Rolle zu
                    updateStmt.run(employeeRole.id, user.id);
                    // Weise Standard-Berechtigungen zu
                    insertPermissionStmt.run(user.id);
                    console.log(`  ✅ ${user.name} (${user.email}) -> employee`);
                }
            }
            else {
                console.error('❌ Employee-Rolle nicht gefunden!');
            }
        }
        // Statistiken ausgeben
        const stats = {
            roles: db.prepare("SELECT COUNT(*) as count FROM user_roles").get(),
            permissions: db.prepare("SELECT COUNT(*) as count FROM permissions").get(),
            users: db.prepare("SELECT COUNT(*) as count FROM users").get(),
            userPermissions: db.prepare("SELECT COUNT(*) as count FROM user_permissions").get()
        };
        console.log('\n📊 Migration-Statistiken:');
        console.log(`   Rollen: ${stats.roles.count}`);
        console.log(`   Berechtigungen: ${stats.permissions.count}`);
        console.log(`   Benutzer: ${stats.users.count}`);
        console.log(`   Benutzer-Berechtigungen: ${stats.userPermissions.count}`);
        // Zeige Rollen-Verteilung
        const roleDistribution = db.prepare(`
      SELECT ur.name as role, COUNT(u.id) as user_count
      FROM user_roles ur
      LEFT JOIN users u ON u.role_id = ur.id
      GROUP BY ur.id, ur.name
      ORDER BY user_count DESC
    `).all();
        console.log('\n👥 Benutzer-Verteilung:');
        roleDistribution.forEach((role) => {
            const icon = role.role === 'admin' ? '👑' : role.role === 'manager' ? '📊' : '👤';
            console.log(`   ${icon} ${role.role}: ${role.user_count} Benutzer`);
        });
        console.log('\n🎉 Rollen-Migration erfolgreich abgeschlossen!');
        console.log('\n💡 Nächste Schritte:');
        console.log('   1. Server neu starten');
        console.log('   2. Mit einem Admin-Account anmelden');
        console.log('   3. Benutzerrollen über Admin-Interface verwalten');
        db.close();
    }
    catch (error) {
        console.error('❌ Fehler bei der Rollen-Migration:', error);
        process.exit(1);
    }
}
// Führe Migration aus, wenn Skript direkt aufgerufen wird
if (require.main === module) {
    migrateRoles();
}
