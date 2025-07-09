import React from 'react';
import { Navigate, useLocation } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';

interface RoleProtectedRouteProps {
  children: React.ReactNode;
  requiredRole?: string;
  requiredRoles?: string[];
  requiredPermission?: string;
  requiredPermissions?: string[];
  requireAll?: boolean;
  redirectTo?: string;
  allowAdminOverride?: boolean;
}

/**
 * Geschützte Route mit rollenbasierter Zugriffskontrolle
 */
export const RoleProtectedRoute: React.FC<RoleProtectedRouteProps> = ({
  children,
  requiredRole,
  requiredRoles,
  requiredPermission,
  requiredPermissions,
  requireAll = false,
  redirectTo = '/dashboard',
  allowAdminOverride = true,
}) => {
  const { user, isLoading, hasRole, hasAnyRole, hasPermission, isAdmin } = useAuth();
  const location = useLocation();

  // Lade-Zustand
  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-500"></div>
      </div>
    );
  }

  // Nicht eingeloggt
  if (!user) {
    return <Navigate to="/login" state={{ from: location }} replace />;
  }

  // Admin Override
  if (allowAdminOverride && isAdmin()) {
    return <>{children}</>;
  }

  // Rollen-Check
  if (requiredRole && !hasRole(requiredRole)) {
    return <Navigate to={redirectTo} replace />;
  }

  if (requiredRoles && !hasAnyRole(requiredRoles)) {
    return <Navigate to={redirectTo} replace />;
  }

  // Berechtigungs-Check
  if (requiredPermission && !hasPermission(requiredPermission)) {
    return <Navigate to={redirectTo} replace />;
  }

  if (requiredPermissions) {
    if (requireAll) {
      const hasAllPermissions = requiredPermissions.every(permission => 
        hasPermission(permission)
      );
      if (!hasAllPermissions) {
        return <Navigate to={redirectTo} replace />;
      }
    } else {
      const hasAnyPermission = requiredPermissions.some(permission => 
        hasPermission(permission)
      );
      if (!hasAnyPermission) {
        return <Navigate to={redirectTo} replace />;
      }
    }
  }

  return <>{children}</>;
};

/**
 * Vorgefertigte Routen für häufige Anwendungsfälle
 */

export const AdminRoute: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  return (
    <RoleProtectedRoute 
      requiredRole="admin"
      redirectTo="/dashboard"
      allowAdminOverride={false}
    >
      {children}
    </RoleProtectedRoute>
  );
};

export const ManagerRoute: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  return (
    <RoleProtectedRoute 
      requiredRoles={['admin', 'manager']}
      redirectTo="/dashboard"
    >
      {children}
    </RoleProtectedRoute>
  );
};

export const GlobalStatsRoute: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  return (
    <RoleProtectedRoute 
      requiredPermission="view_global_statistics"
      redirectTo="/dashboard"
    >
      {children}
    </RoleProtectedRoute>
  );
};

export const AnalyticsRoute: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  return (
    <RoleProtectedRoute 
      requiredPermission="view_analytics"
      redirectTo="/dashboard"
    >
      {children}
    </RoleProtectedRoute>
  );
};