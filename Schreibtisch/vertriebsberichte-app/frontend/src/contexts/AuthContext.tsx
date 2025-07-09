import React, { createContext, useState, useContext, useEffect } from 'react';
import axios from 'axios';

interface User {
  id: number;
  name: string;
  email: string;
  roleId?: number;
  roleName?: string;
  permissions?: string[];
}

interface UserPermissions {
  userId: number;
  roleId?: number;
  roleName?: string;
  permissions: string[];
}

interface AuthContextType {
  user: User | null;
  userPermissions: UserPermissions | null;
  login: (email: string, password: string) => Promise<void>;
  register: (name: string, email: string, password: string, region: string) => Promise<void>;
  logout: () => void;
  isLoading: boolean;
  hasPermission: (permission: string) => boolean;
  hasRole: (role: string) => boolean;
  hasAnyRole: (roles: string[]) => boolean;
  isAdmin: () => boolean;
  isManager: () => boolean;
  refreshPermissions: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);
  const [userPermissions, setUserPermissions] = useState<UserPermissions | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const token = localStorage.getItem('token');
    if (token) {
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
      fetchUserProfile();
    } else {
      setIsLoading(false);
    }
  }, []);

  const fetchUserProfile = async () => {
    try {
      const [profileResponse, permissionsResponse] = await Promise.all([
        axios.get('/api/users/profile'),
        axios.get('/api/admin/permissions/me')
      ]);
      
      const userData = profileResponse.data.data;
      const permissionsData = permissionsResponse.data.data;
      
      setUser({
        id: userData.id,
        name: userData.name,
        email: userData.email,
        roleId: permissionsData.roleId,
        roleName: permissionsData.roleName,
        permissions: permissionsData.permissions,
      });
      
      setUserPermissions(permissionsData);
    } catch (error) {
      console.error('Error fetching user data:', error);
      localStorage.removeItem('token');
      delete axios.defaults.headers.common['Authorization'];
      setUser(null);
      setUserPermissions(null);
    } finally {
      setIsLoading(false);
    }
  };

  const refreshPermissions = async () => {
    try {
      const response = await axios.get('/api/admin/permissions/me');
      const permissionsData = response.data.data;
      
      setUserPermissions(permissionsData);
      
      if (user) {
        setUser({
          ...user,
          roleId: permissionsData.roleId,
          roleName: permissionsData.roleName,
          permissions: permissionsData.permissions,
        });
      }
    } catch (error) {
      console.error('Error refreshing permissions:', error);
    }
  };

  const login = async (email: string, password: string) => {
    const response = await axios.post('/api/auth/login', { email, password });
    const { token, user } = response.data;
    
    localStorage.setItem('token', token);
    axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
    setUser(user);
    
    // Berechtigungen nach Login laden
    await refreshPermissions();
  };

  const register = async (name: string, email: string, password: string, region: string) => {
    const response = await axios.post('/api/auth/register', {
      name,
      email,
      password,
      region,
    });
    const { token, user } = response.data;
    
    localStorage.setItem('token', token);
    axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
    setUser(user);
    
    // Berechtigungen nach Registrierung laden
    await refreshPermissions();
  };

  const logout = () => {
    localStorage.removeItem('token');
    delete axios.defaults.headers.common['Authorization'];
    setUser(null);
    setUserPermissions(null);
  };

  // Berechtigungsfunktionen
  const hasPermission = (permission: string): boolean => {
    return userPermissions?.permissions?.includes(permission) || false;
  };

  const hasRole = (role: string): boolean => {
    return userPermissions?.roleName === role;
  };

  const hasAnyRole = (roles: string[]): boolean => {
    return userPermissions?.roleName ? roles.includes(userPermissions.roleName) : false;
  };

  const isAdmin = (): boolean => {
    return hasRole('admin');
  };

  const isManager = (): boolean => {
    return hasRole('manager');
  };

  return (
    <AuthContext.Provider value={{ 
      user, 
      userPermissions,
      login, 
      register, 
      logout, 
      isLoading,
      hasPermission,
      hasRole,
      hasAnyRole,
      isAdmin,
      isManager,
      refreshPermissions
    }}>
      {children}
    </AuthContext.Provider>
  );
};