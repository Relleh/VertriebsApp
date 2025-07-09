import { query } from '../config/database';

export interface UserPermissions {
  userId: number;
  roleId?: number;
  roleName?: string;
  permissions: string[];
}

export interface Permission {
  id: number;
  name: string;
  description: string;
  resource: string;
  action: string;
}

export interface Role {
  id: number;
  name: string;
  description: string;
}

/**
 * Lädt alle Berechtigungen eines Benutzers aus der Datenbank
 * @param userId - ID des Benutzers
 * @returns Benutzerrollen und -berechtigungen
 */
export async function getUserPermissions(userId: number): Promise<UserPermissions> {
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

  const result = query(queryStr, [userId]);
  const rows = result.rows;

  if (rows.length === 0) {
    throw new Error(`Benutzer mit ID ${userId} nicht gefunden`);
  }

  const userPermissions: UserPermissions = {
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
export async function hasPermission(userId: number, permissionName: string): Promise<boolean> {
  const userPermissions = await getUserPermissions(userId);
  return userPermissions.permissions.includes(permissionName);
}

/**
 * Prüft ob ein Benutzer eine bestimmte Rolle hat
 * @param userId - ID des Benutzers
 * @param roleName - Name der Rolle
 * @returns true wenn Rolle vorhanden, false sonst
 */
export async function hasRole(userId: number, roleName: string): Promise<boolean> {
  const userPermissions = await getUserPermissions(userId);
  return userPermissions.roleName === roleName;
}

/**
 * Lädt alle verfügbaren Rollen
 * @returns Array aller Rollen
 */
export async function getAllRoles(): Promise<Role[]> {
  const queryStr = `
    SELECT id, name, description
    FROM user_roles
    ORDER BY name
  `;

  const result = query(queryStr);
  return result.rows as Role[];
}

/**
 * Lädt alle verfügbaren Berechtigungen
 * @returns Array aller Berechtigungen
 */
export async function getAllPermissions(): Promise<Permission[]> {
  const queryStr = `
    SELECT id, name, description, resource, action
    FROM permissions
    ORDER BY resource, action
  `;

  const result = query(queryStr);
  return result.rows as Permission[];
}

/**
 * Weist einem Benutzer eine Rolle zu
 * @param userId - ID des Benutzers
 * @param roleId - ID der Rolle
 */
export async function assignRole(userId: number, roleId: number): Promise<void> {
  const updateQuery = `
    UPDATE users 
    SET role_id = ?, updated_at = datetime('now')
    WHERE id = ?
  `;

  const result = query(updateQuery, [roleId, userId]);

  if (result.rows[0]?.affectedRows === 0) {
    throw new Error(`Benutzer mit ID ${userId} nicht gefunden`);
  }

  // Alte Berechtigungen löschen
  const deletePermissionsQuery = `
    DELETE FROM user_permissions WHERE user_id = ?
  `;
  query(deletePermissionsQuery, [userId]);

  // Neue Berechtigungen basierend auf Rolle zuweisen
  await assignRolePermissions(userId, roleId);
}

/**
 * Weist einem Benutzer basierend auf seiner Rolle die entsprechenden Berechtigungen zu
 * @param userId - ID des Benutzers
 * @param roleId - ID der Rolle
 */
export async function assignRolePermissions(userId: number, roleId: number): Promise<void> {
  const roleQuery = `SELECT name FROM user_roles WHERE id = ?`;
  const roleResult = query(roleQuery, [roleId]);
  const role = roleResult.rows[0] as { name: string } | undefined;

  if (!role) {
    throw new Error(`Rolle mit ID ${roleId} nicht gefunden`);
  }

  let permissionNames: string[] = [];

  switch (role.name) {
    case 'admin':
      // Admin erhält alle Berechtigungen
      const allPermissionsQuery = `SELECT name FROM permissions`;
      const allPermissionsResult = query(allPermissionsQuery);
      const allPermissions = allPermissionsResult.rows as { name: string }[];
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
    const permissionResult = query(permissionQuery, [permissionName]);
    const permission = permissionResult.rows[0] as { id: number } | undefined;

    if (permission) {
      const insertQuery = `
        INSERT OR IGNORE INTO user_permissions (user_id, permission_id)
        VALUES (?, ?)
      `;
      query(insertQuery, [userId, permission.id]);
    }
  }
}

/**
 * Weist einem Benutzer eine spezifische Berechtigung zu
 * @param userId - ID des Benutzers
 * @param permissionName - Name der Berechtigung
 */
export async function assignPermission(userId: number, permissionName: string): Promise<void> {
  const permissionQuery = `SELECT id FROM permissions WHERE name = ?`;
  const permissionResult = query(permissionQuery, [permissionName]);
  const permission = permissionResult.rows[0] as { id: number } | undefined;

  if (!permission) {
    throw new Error(`Berechtigung '${permissionName}' nicht gefunden`);
  }

  const insertQuery = `
    INSERT OR IGNORE INTO user_permissions (user_id, permission_id)
    VALUES (?, ?)
  `;

  query(insertQuery, [userId, permission.id]);
}

/**
 * Entfernt eine Berechtigung von einem Benutzer
 * @param userId - ID des Benutzers
 * @param permissionName - Name der Berechtigung
 */
export async function removePermission(userId: number, permissionName: string): Promise<void> {
  const permissionQuery = `SELECT id FROM permissions WHERE name = ?`;
  const permissionResult = query(permissionQuery, [permissionName]);
  const permission = permissionResult.rows[0] as { id: number } | undefined;

  if (!permission) {
    throw new Error(`Berechtigung '${permissionName}' nicht gefunden`);
  }

  const deleteQuery = `
    DELETE FROM user_permissions 
    WHERE user_id = ? AND permission_id = ?
  `;

  query(deleteQuery, [userId, permission.id]);
}

/**
 * Lädt alle Benutzer mit ihren Rollen
 * @returns Array aller Benutzer mit Rollen
 */
export async function getAllUsersWithRoles(): Promise<Array<{
  id: number;
  name: string;
  email: string;
  roleName: string | null;
  roleId: number | null;
}>> {
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

  const result = query(queryStr);
  return result.rows as any[];
}