import React from 'react';
import { useAuth } from '../contexts/AuthContext';

interface RoleProtectedComponentProps {
  children: React.ReactNode;
  requiredRole?: string;
  requiredRoles?: string[];
  requiredPermission?: string;
  requiredPermissions?: string[];
  requireAll?: boolean; // Wenn true, müssen alle Berechtigungen vorhanden sein
  fallback?: React.ReactNode; // Was angezeigt wird, wenn keine Berechtigung
  allowAdminOverride?: boolean; // Admin kann alles sehen
}

/**
 * Komponente zur rollenbasierten Anzeige von Inhalten
 */
export const RoleProtectedComponent: React.FC<RoleProtectedComponentProps> = ({
  children,
  requiredRole,
  requiredRoles,
  requiredPermission,
  requiredPermissions,
  requireAll = false,
  fallback = null,
  allowAdminOverride = true,
}) => {
  const { hasRole, hasAnyRole, hasPermission, isAdmin } = useAuth();

  // Admin Override - Admin sieht alles (außer explizit deaktiviert)
  if (allowAdminOverride && isAdmin()) {
    return <>{children}</>;
  }

  // Rollen-Check
  if (requiredRole && !hasRole(requiredRole)) {
    return <>{fallback}</>;
  }

  if (requiredRoles && !hasAnyRole(requiredRoles)) {
    return <>{fallback}</>;
  }

  // Berechtigungs-Check
  if (requiredPermission && !hasPermission(requiredPermission)) {
    return <>{fallback}</>;
  }

  if (requiredPermissions) {
    if (requireAll) {
      // Alle Berechtigungen müssen vorhanden sein
      const hasAllPermissions = requiredPermissions.every(permission => 
        hasPermission(permission)
      );
      if (!hasAllPermissions) {
        return <>{fallback}</>;
      }
    } else {
      // Mindestens eine Berechtigung muss vorhanden sein
      const hasAnyPermission = requiredPermissions.some(permission => 
        hasPermission(permission)
      );
      if (!hasAnyPermission) {
        return <>{fallback}</>;
      }
    }
  }

  return <>{children}</>;
};

/**
 * Hook für rollenbasierte Logik in Komponenten
 */
export const useRoleProtection = () => {
  const { hasRole, hasAnyRole, hasPermission, isAdmin, isManager, user } = useAuth();

  const canViewGlobalStats = () => {
    return hasPermission('view_global_statistics') || isAdmin() || isManager();
  };

  const canManageUsers = () => {
    return hasPermission('manage_users') || isAdmin();
  };

  const canViewAllReports = () => {
    return hasPermission('view_all_reports') || isAdmin();
  };

  const canViewTeamReports = () => {
    return hasPermission('view_team_reports') || canViewAllReports();
  };

  const canExportData = () => {
    return hasPermission('export_data') || isAdmin() || isManager();
  };

  const canViewAnalytics = () => {
    return hasPermission('view_analytics') || isAdmin() || isManager();
  };

  const canManageCustomers = () => {
    return hasPermission('manage_customers') || isAdmin();
  };

  return {
    user,
    hasRole,
    hasAnyRole,
    hasPermission,
    isAdmin,
    isManager,
    canViewGlobalStats,
    canManageUsers,
    canViewAllReports,
    canViewTeamReports,
    canExportData,
    canViewAnalytics,
    canManageCustomers,
  };
};

/**
 * Spezielle Komponenten für häufige Anwendungsfälle
 */

interface AdminOnlyProps {
  children: React.ReactNode;
  fallback?: React.ReactNode;
}

export const AdminOnly: React.FC<AdminOnlyProps> = ({ children, fallback = null }) => {
  return (
    <RoleProtectedComponent 
      requiredRole="admin" 
      fallback={fallback}
      allowAdminOverride={false}
    >
      {children}
    </RoleProtectedComponent>
  );
};

export const ManagerOrAdmin: React.FC<AdminOnlyProps> = ({ children, fallback = null }) => {
  return (
    <RoleProtectedComponent 
      requiredRoles={['admin', 'manager']} 
      fallback={fallback}
    >
      {children}
    </RoleProtectedComponent>
  );
};

export const WithPermission: React.FC<{
  children: React.ReactNode;
  permission: string;
  fallback?: React.ReactNode;
}> = ({ children, permission, fallback = null }) => {
  return (
    <RoleProtectedComponent 
      requiredPermission={permission} 
      fallback={fallback}
    >
      {children}
    </RoleProtectedComponent>
  );
};

export const WithAnyPermission: React.FC<{
  children: React.ReactNode;
  permissions: string[];
  fallback?: React.ReactNode;
}> = ({ children, permissions, fallback = null }) => {
  return (
    <RoleProtectedComponent 
      requiredPermissions={permissions} 
      requireAll={false}
      fallback={fallback}
    >
      {children}
    </RoleProtectedComponent>
  );
};

export const WithAllPermissions: React.FC<{
  children: React.ReactNode;
  permissions: string[];
  fallback?: React.ReactNode;
}> = ({ children, permissions, fallback = null }) => {
  return (
    <RoleProtectedComponent 
      requiredPermissions={permissions} 
      requireAll={true}
      fallback={fallback}
    >
      {children}
    </RoleProtectedComponent>
  );
};