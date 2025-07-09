import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { AdminOnly } from '../components/RoleProtectedComponent';
import { useAuth } from '../contexts/AuthContext';
import { useTranslation } from 'react-i18next';

interface User {
  id: number;
  name: string;
  email: string;
  roleName: string | null;
  roleId: number | null;
}

interface Role {
  id: number;
  name: string;
  description: string;
}

const AdminDashboard: React.FC = () => {
  const { user } = useAuth();
  const { t } = useTranslation(['admin', 'common']);
  const [users, setUsers] = useState<User[]>([]);
  const [roles, setRoles] = useState<Role[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [selectedUser, setSelectedUser] = useState<User | null>(null);
  const [selectedRole, setSelectedRole] = useState<string>('');

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      setLoading(true);
      const [usersResponse, rolesResponse] = await Promise.all([
        axios.get('/api/admin/users'),
        axios.get('/api/admin/roles')
      ]);
      
      setUsers(usersResponse.data.data);
      setRoles(rolesResponse.data.data);
      setError(null);
    } catch (err) {
      setError(t('admin:messages.errorLoading'));
      console.error('Admin dashboard error:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleRoleAssignment = async () => {
    if (!selectedUser || !selectedRole) return;

    try {
      await axios.post(`/api/admin/users/${selectedUser.id}/role`, {
        roleId: parseInt(selectedRole)
      });
      
      // Reload data
      await loadData();
      
      // Reset selection
      setSelectedUser(null);
      setSelectedRole('');
      
      alert(t('admin:roleAssignment.success'));
    } catch (err) {
      console.error('Role assignment error:', err);
      alert(t('admin:roleAssignment.error'));
    }
  };

  const getRoleIcon = (roleName: string | null) => {
    switch (roleName) {
      case 'admin': return '👑';
      case 'manager': return '📊';
      case 'employee': return '👤';
      default: return '❓';
    }
  };

  const getRoleBadgeColor = (roleName: string | null) => {
    switch (roleName) {
      case 'admin': return 'bg-red-100 text-red-800';
      case 'manager': return 'bg-blue-100 text-blue-800';
      case 'employee': return 'bg-green-100 text-green-800';
      default: return 'bg-gray-100 text-gray-800';
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-500"></div>
      </div>
    );
  }

  return (
    <AdminOnly fallback={
      <div className="text-center py-12">
        <h2 className="text-2xl font-bold text-gray-900 mb-4">{t('admin:accessDenied.title')}</h2>
        <p className="text-gray-600">{t('admin:accessDenied.message')}</p>
      </div>
    }>
      <div className="space-y-6">
        {/* Header */}
        <div className="border-b border-gray-200 pb-4">
          <h1 className="text-3xl font-bold text-gray-900">{t('admin:title')}</h1>
          <p className="text-gray-600 mt-2">
            {t('admin:welcome', { name: user?.name })}
          </p>
        </div>

        {error && (
          <div className="bg-red-50 border border-red-200 rounded-md p-4">
            <div className="text-red-800">{error}</div>
          </div>
        )}

        {/* Statistics Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <div className="bg-white overflow-hidden shadow rounded-lg">
            <div className="p-5">
              <div className="flex items-center">
                <div className="flex-shrink-0">
                  <span className="text-2xl">👥</span>
                </div>
                <div className="ml-5 w-0 flex-1">
                  <dl>
                    <dt className="text-sm font-medium text-gray-500 truncate">
                      {t('admin:statistics.totalUsers')}
                    </dt>
                    <dd className="text-lg font-medium text-gray-900">
                      {users.length}
                    </dd>
                  </dl>
                </div>
              </div>
            </div>
          </div>

          <div className="bg-white overflow-hidden shadow rounded-lg">
            <div className="p-5">
              <div className="flex items-center">
                <div className="flex-shrink-0">
                  <span className="text-2xl">👑</span>
                </div>
                <div className="ml-5 w-0 flex-1">
                  <dl>
                    <dt className="text-sm font-medium text-gray-500 truncate">
                      {t('admin:statistics.administrators')}
                    </dt>
                    <dd className="text-lg font-medium text-gray-900">
                      {users.filter(u => u.roleName === 'admin').length}
                    </dd>
                  </dl>
                </div>
              </div>
            </div>
          </div>

          <div className="bg-white overflow-hidden shadow rounded-lg">
            <div className="p-5">
              <div className="flex items-center">
                <div className="flex-shrink-0">
                  <span className="text-2xl">📊</span>
                </div>
                <div className="ml-5 w-0 flex-1">
                  <dl>
                    <dt className="text-sm font-medium text-gray-500 truncate">
                      {t('admin:statistics.managers')}
                    </dt>
                    <dd className="text-lg font-medium text-gray-900">
                      {users.filter(u => u.roleName === 'manager').length}
                    </dd>
                  </dl>
                </div>
              </div>
            </div>
          </div>

          <div className="bg-white overflow-hidden shadow rounded-lg">
            <div className="p-5">
              <div className="flex items-center">
                <div className="flex-shrink-0">
                  <span className="text-2xl">👤</span>
                </div>
                <div className="ml-5 w-0 flex-1">
                  <dl>
                    <dt className="text-sm font-medium text-gray-500 truncate">
                      {t('admin:statistics.employees')}
                    </dt>
                    <dd className="text-lg font-medium text-gray-900">
                      {users.filter(u => u.roleName === 'employee').length}
                    </dd>
                  </dl>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Role Assignment Section */}
        <div className="bg-white shadow rounded-lg p-6">
          <h2 className="text-lg font-medium text-gray-900 mb-4">{t('admin:roleAssignment.title')}</h2>
          
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                {t('admin:roleAssignment.selectUser')}
              </label>
              <select
                value={selectedUser?.id || ''}
                onChange={(e) => {
                  const userId = parseInt(e.target.value);
                  const user = users.find(u => u.id === userId);
                  setSelectedUser(user || null);
                }}
                className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                <option value="">{t('admin:roleAssignment.userPlaceholder')}</option>
                {users.map(user => (
                  <option key={user.id} value={user.id}>
                    {user.name} ({user.email})
                  </option>
                ))}
              </select>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                {t('admin:roleAssignment.selectRole')}
              </label>
              <select
                value={selectedRole}
                onChange={(e) => setSelectedRole(e.target.value)}
                className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                <option value="">{t('admin:roleAssignment.rolePlaceholder')}</option>
                {roles.map(role => (
                  <option key={role.id} value={role.id}>
                    {getRoleIcon(role.name)} {role.name} - {role.description}
                  </option>
                ))}
              </select>
            </div>

            <div className="flex items-end">
              <button
                onClick={handleRoleAssignment}
                disabled={!selectedUser || !selectedRole}
                className="w-full bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 disabled:bg-gray-300 disabled:cursor-not-allowed"
              >
                {t('admin:roleAssignment.assignButton')}
              </button>
            </div>
          </div>

          {selectedUser && (
            <div className="bg-blue-50 border border-blue-200 rounded-md p-3">
              <p className="text-sm text-blue-800">
                <strong>{t('admin:userManagement.roleInfo.current')}</strong> {selectedUser.name} {t('admin:userManagement.roleInfo.hasRole')}{' '}
                <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${getRoleBadgeColor(selectedUser.roleName)}`}>
                  {getRoleIcon(selectedUser.roleName)} {selectedUser.roleName || t('admin:userManagement.roleInfo.noRole')}
                </span>
              </p>
            </div>
          )}
        </div>

        {/* Users Table */}
        <div className="bg-white shadow rounded-lg">
          <div className="px-6 py-4 border-b border-gray-200">
            <h2 className="text-lg font-medium text-gray-900">{t('admin:userManagement.title')}</h2>
          </div>
          
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    {t('admin:userManagement.table.user')}
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    {t('admin:userManagement.table.role')}
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    {t('admin:userManagement.table.actions')}
                  </th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {users.map(user => (
                  <tr key={user.id} className="hover:bg-gray-50">
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div>
                        <div className="text-sm font-medium text-gray-900">
                          {user.name}
                        </div>
                        <div className="text-sm text-gray-500">
                          {user.email}
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${getRoleBadgeColor(user.roleName)}`}>
                        {getRoleIcon(user.roleName)} {user.roleName || t('admin:userManagement.roleInfo.noRole')}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      <button
                        onClick={() => {
                          setSelectedUser(user);
                          setSelectedRole(user.roleId?.toString() || '');
                        }}
                        className="text-blue-600 hover:text-blue-900"
                      >
                        {t('admin:userManagement.table.edit')}
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </AdminOnly>
  );
};

export default AdminDashboard;