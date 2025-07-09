"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getUserPermissions = getUserPermissions;
exports.hasPermission = hasPermission;
exports.hasRole = hasRole;
exports.getAllRoles = getAllRoles;
exports.getAllPermissions = getAllPermissions;
exports.assignRole = assignRole;
exports.assignRolePermissions = assignRolePermissions;
exports.assignPermission = assignPermission;
exports.removePermission = removePermission;
exports.getAllUsersWithRoles = getAllUsersWithRoles;
const database_1 = require("../config/database");
/**
 * Lädt alle Berechtigungen eines Benutzers aus der Datenbank
 * @param userId - ID des Benutzers
 * @returns Benutzerrollen und -berechtigungen
 */
async function getUserPermissions(userId) {
    const queryStr = `
    SELECT 
      u.id as userId,
      ur.id as roleId,
      ur.name as roleName,
      p.name as permissionName
    FROM users u
    LEFT JOIN user_roles ur ON u.role_id = ur.id
    LEFT JOIN user_permissions up ON u.id = up.user_id
    LEFT JOIN permissions p ON up.permission_id = p.id
    WHERE u.id = ?
  `;
    const result = (0, database_1.query)(queryStr, [userId]);
    const rows = result.rows;
    if (rows.length === 0) {
        throw new Error(`Benutzer mit ID ${userId} nicht gefunden`);
    }
    const userPermissions = {
        userId: rows[0].userId,
        roleId: rows[0].roleId,
        roleName: rows[0].roleName,
        permissions: []
    };
    // Berechtigungen sammeln (null-Werte filtern)
    userPermissions.permissions = rows
        .filter(row => row.permissionName !== null)
        .map(row => row.permissionName);
    return userPermissions;
}
/**
 * Prüft ob ein Benutzer eine bestimmte Berechtigung hat
 * @param userId - ID des Benutzers
 * @param permissionName - Name der Berechtigung
 * @returns true wenn Berechtigung vorhanden, false sonst
 */
async function hasPermission(userId, permissionName) {
    const userPermissions = await getUserPermissions(userId);
    return userPermissions.permissions.includes(permissionName);
}
/**
 * Prüft ob ein Benutzer eine bestimmte Rolle hat
 * @param userId - ID des Benutzers
 * @param roleName - Name der Rolle
 * @returns true wenn Rolle vorhanden, false sonst
 */
async function hasRole(userId, roleName) {
    const userPermissions = await getUserPermissions(userId);
    return userPermissions.roleName === roleName;
}
/**
 * Lädt alle verfügbaren Rollen
 * @returns Array aller Rollen
 */
async function getAllRoles() {
    const queryStr = `
    SELECT id, name, description
    FROM user_roles
    ORDER BY name
  `;
    const result = (0, database_1.query)(queryStr);
    return result.rows;
}
/**
 * Lädt alle verfügbaren Berechtigungen
 * @returns Array aller Berechtigungen
 */
async function getAllPermissions() {
    const queryStr = `
    SELECT id, name, description, resource, action
    FROM permissions
    ORDER BY resource, action
  `;
    const result = (0, database_1.query)(queryStr);
    return result.rows;
}
/**
 * Weist einem Benutzer eine Rolle zu
 * @param userId - ID des Benutzers
 * @param roleId - ID der Rolle
 */
async function assignRole(userId, roleId) {
    const updateQuery = `
    UPDATE users 
    SET role_id = ?, updated_at = datetime('now')
    WHERE id = ?
  `;
    const result = (0, database_1.query)(updateQuery, [roleId, userId]);
    if (result.rows[0]?.affectedRows === 0) {
        throw new Error(`Benutzer mit ID ${userId} nicht gefunden`);
    }
    // Alte Berechtigungen löschen
    const deletePermissionsQuery = `
    DELETE FROM user_permissions WHERE user_id = ?
  `;
    (0, database_1.query)(deletePermissionsQuery, [userId]);
    // Neue Berechtigungen basierend auf Rolle zuweisen
    await assignRolePermissions(userId, roleId);
}
/**
 * Weist einem Benutzer basierend auf seiner Rolle die entsprechenden Berechtigungen zu
 * @param userId - ID des Benutzers
 * @param roleId - ID der Rolle
 */
async function assignRolePermissions(userId, roleId) {
    const roleQuery = `SELECT name FROM user_roles WHERE id = ?`;
    const roleResult = (0, database_1.query)(roleQuery, [roleId]);
    const role = roleResult.rows[0];
    if (!role) {
        throw new Error(`Rolle mit ID ${roleId} nicht gefunden`);
    }
    let permissionNames = [];
    switch (role.name) {
        case 'admin':
            // Admin erhält alle Berechtigungen
            const allPermissionsQuery = `SELECT name FROM permissions`;
            const allPermissionsResult = (0, database_1.query)(allPermissionsQuery);
            const allPermissions = allPermissionsResult.rows;
            permissionNames = allPermissions.map(p => p.name);
            break;
        case 'manager':
            // Manager erhält spezifische Berechtigungen
            permissionNames = [
                'view_global_statistics',
                'view_team_reports',
                'export_data',
                'view_analytics'
            ];
            break;
        case 'employee':
            // Mitarbeiter erhält Basis-Berechtigungen
            permissionNames = [
                'view_analytics'
            ];
            break;
        default:
            // Unbekannte Rolle - keine Berechtigungen
            break;
    }
    // Berechtigungen zuweisen
    for (const permissionName of permissionNames) {
        const permissionQuery = `SELECT id FROM permissions WHERE name = ?`;
        const permissionResult = (0, database_1.query)(permissionQuery, [permissionName]);
        const permission = permissionResult.rows[0];
        if (permission) {
            const insertQuery = `
        INSERT OR IGNORE INTO user_permissions (user_id, permission_id)
        VALUES (?, ?)
      `;
            (0, database_1.query)(insertQuery, [userId, permission.id]);
        }
    }
}
/**
 * Weist einem Benutzer eine spezifische Berechtigung zu
 * @param userId - ID des Benutzers
 * @param permissionName - Name der Berechtigung
 */
async function assignPermission(userId, permissionName) {
    const permissionQuery = `SELECT id FROM permissions WHERE name = ?`;
    const permissionResult = (0, database_1.query)(permissionQuery, [permissionName]);
    const permission = permissionResult.rows[0];
    if (!permission) {
        throw new Error(`Berechtigung '${permissionName}' nicht gefunden`);
    }
    const insertQuery = `
    INSERT OR IGNORE INTO user_permissions (user_id, permission_id)
    VALUES (?, ?)
  `;
    (0, database_1.query)(insertQuery, [userId, permission.id]);
}
/**
 * Entfernt eine Berechtigung von einem Benutzer
 * @param userId - ID des Benutzers
 * @param permissionName - Name der Berechtigung
 */
async function removePermission(userId, permissionName) {
    const permissionQuery = `SELECT id FROM permissions WHERE name = ?`;
    const permissionResult = (0, database_1.query)(permissionQuery, [permissionName]);
    const permission = permissionResult.rows[0];
    if (!permission) {
        throw new Error(`Berechtigung '${permissionName}' nicht gefunden`);
    }
    const deleteQuery = `
    DELETE FROM user_permissions 
    WHERE user_id = ? AND permission_id = ?
  `;
    (0, database_1.query)(deleteQuery, [userId, permission.id]);
}
/**
 * Lädt alle Benutzer mit ihren Rollen
 * @returns Array aller Benutzer mit Rollen
 */
async function getAllUsersWithRoles() {
    const queryStr = `
    SELECT 
      u.id,
      u.name,
      u.email,
      ur.name as roleName,
      ur.id as roleId
    FROM users u
    LEFT JOIN user_roles ur ON u.role_id = ur.id
    ORDER BY u.name
  `;
    const result = (0, database_1.query)(queryStr);
    return result.rows;
}
