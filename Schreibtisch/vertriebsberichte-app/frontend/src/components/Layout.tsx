import { Outlet, NavLink, useNavigate } from 'react-router-dom';
import { useState, useEffect, useRef } from 'react';
import { useAuth } from '../contexts/AuthContext';
import { ManagerOrAdmin, WithPermission } from './RoleProtectedComponent';
import { useTranslation } from 'react-i18next';
import LanguageSwitcher from './LanguageSwitcher';

const Layout = () => {
  const { user, logout, userPermissions } = useAuth();
  const navigate = useNavigate();
  const { t } = useTranslation(['common', 'auth']);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [isReportsDropdownOpen, setIsReportsDropdownOpen] = useState(false);
  const [isAnalyticsDropdownOpen, setIsAnalyticsDropdownOpen] = useState(false);
  const [isAdminDropdownOpen, setIsAdminDropdownOpen] = useState(false);
  
  const reportsDropdownRef = useRef<HTMLDivElement>(null);
  const analyticsDropdownRef = useRef<HTMLDivElement>(null);
  const adminDropdownRef = useRef<HTMLDivElement>(null);

  // Click outside handler for dropdowns
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (reportsDropdownRef.current && !reportsDropdownRef.current.contains(event.target as Node)) {
        setIsReportsDropdownOpen(false);
      }
      if (analyticsDropdownRef.current && !analyticsDropdownRef.current.contains(event.target as Node)) {
        setIsAnalyticsDropdownOpen(false);
      }
      if (adminDropdownRef.current && !adminDropdownRef.current.contains(event.target as Node)) {
        setIsAdminDropdownOpen(false);
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, []);

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  const navLinkClass = ({ isActive }: { isActive: boolean }) =>
    `px-3 py-2 rounded-md text-sm font-medium transition-colors duration-200 ${
      isActive
        ? 'bg-indigo-700 text-white'
        : 'text-gray-300 hover:bg-gray-700 hover:text-white'
    }`;

  const dropdownLinkClass = ({ isActive }: { isActive: boolean }) =>
    `block px-4 py-2 text-sm transition-colors duration-200 ${
      isActive
        ? 'bg-indigo-700 text-white'
        : 'text-gray-300 hover:bg-gray-700 hover:text-white'
    }`;

  const mobileNavLinkClass = ({ isActive }: { isActive: boolean }) =>
    `block px-3 py-2 rounded-md text-base font-medium transition-colors duration-200 ${
      isActive
        ? 'bg-indigo-700 text-white'
        : 'text-gray-300 hover:bg-gray-700 hover:text-white'
    }`;

  return (
    <div className="min-h-screen bg-gray-50">
      <nav className="bg-gray-800 shadow-lg">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-16">
            {/* Logo */}
            <div className="flex items-center">
              <div className="flex-shrink-0">
                <NavLink to="/dashboard" className="flex items-center">
                  <div className="w-8 h-8 bg-indigo-600 rounded-lg flex items-center justify-center mr-3">
                    <span className="text-white font-bold text-lg">V</span>
                  </div>
                  <h1 className="text-white text-xl font-bold hidden sm:block">{t('common:appName')}</h1>
                </NavLink>
              </div>

              {/* Desktop Navigation */}
              <div className="hidden lg:block">
                <div className="ml-10 flex items-baseline space-x-2">
                  {/* Dashboard */}
                  <NavLink to="/dashboard" className={navLinkClass}>
                    <span className="flex items-center">
                       {t('common:navigation.dashboard')}
                    </span>
                  </NavLink>

                  {/* Berichte Dropdown */}
                  <div className="relative" ref={reportsDropdownRef}>
                    <button
                      onClick={() => setIsReportsDropdownOpen(!isReportsDropdownOpen)}
                      className="px-3 py-2 rounded-md text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white transition-colors duration-200 flex items-center"
                    >
                       {t('common:navigation.reports')}
                      <svg className="ml-1 h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                      </svg>
                    </button>
                    {isReportsDropdownOpen && (
                      <div className="absolute left-0 mt-2 w-48 rounded-md shadow-lg bg-gray-800 ring-1 ring-black ring-opacity-5 z-50">
                        <div className="py-1">
                          <NavLink to="/reports" className={dropdownLinkClass} onClick={() => setIsReportsDropdownOpen(false)}>
                             {t('common:navigation.reports')}
                          </NavLink>
                          <NavLink to="/reports/new" className={dropdownLinkClass} onClick={() => setIsReportsDropdownOpen(false)}>
                             {t('common:buttons.new')}
                          </NavLink>
                        </div>
                      </div>
                    )}
                  </div>

                  {/* Analytics Dropdown */}
                  <div className="relative" ref={analyticsDropdownRef}>
                    <button
                      onClick={() => setIsAnalyticsDropdownOpen(!isAnalyticsDropdownOpen)}
                      className="px-3 py-2 rounded-md text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white transition-colors duration-200 flex items-center"
                    >
                       {t('common:navigation.analytics')}
                      <svg className="ml-1 h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                      </svg>
                    </button>
                    {isAnalyticsDropdownOpen && (
                      <div className="absolute left-0 mt-2 w-48 rounded-md shadow-lg bg-gray-800 ring-1 ring-black ring-opacity-5 z-50">
                        <div className="py-1">
                          <NavLink to="/statistics" className={dropdownLinkClass} onClick={() => setIsAnalyticsDropdownOpen(false)}>
                             {t('common:navigation.analytics')}
                          </NavLink>
                          <WithPermission permission="view_analytics">
                            <NavLink to="/analytics" className={dropdownLinkClass} onClick={() => setIsAnalyticsDropdownOpen(false)}>
                              {t('common:navigation.personalAnalytics')}
                            </NavLink>
                          </WithPermission>
                          <ManagerOrAdmin>
                            <NavLink to="/statistics/global" className={dropdownLinkClass} onClick={() => setIsAnalyticsDropdownOpen(false)}>
                               {t('common:navigation.globalStatistics')}
                            </NavLink>
                          </ManagerOrAdmin>
                        </div>
                      </div>
                    )}
                  </div>

                  {/* Admin Dropdown */}
                  <WithPermission permission="manage_users">
                    <div className="relative" ref={adminDropdownRef}>
                      <button
                        onClick={() => setIsAdminDropdownOpen(!isAdminDropdownOpen)}
                        className="px-3 py-2 rounded-md text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white transition-colors duration-200 flex items-center"
                      >
                        {t('common:navigation.adminDashboard')}
                        <svg className="ml-1 h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                        </svg>
                      </button>
                      {isAdminDropdownOpen && (
                        <div className="absolute left-0 mt-2 w-48 rounded-md shadow-lg bg-gray-800 ring-1 ring-black ring-opacity-5 z-50">
                          <div className="py-1">
                            <NavLink to="/admin/users" className={dropdownLinkClass} onClick={() => setIsAdminDropdownOpen(false)}>
                               {t('common:navigation.adminDashboard')}
                            </NavLink>
                          </div>
                        </div>
                      )}
                    </div>
                  </WithPermission>
                </div>
              </div>
            </div>

            {/* User Info & Mobile Menu Button */}
            <div className="flex items-center space-x-3">
              {/* Language Switcher */}
              <div className="hidden md:block">
                <LanguageSwitcher />
              </div>

              {/* User Info */}
              <div className="hidden md:flex items-center text-gray-300">
                <div className="text-right">
                  <div className="text-sm font-medium">{user?.name}</div>
                  {userPermissions?.roleName && (
                    <div className="text-xs text-gray-400">
                      {userPermissions.roleName === 'admin' && t('auth:roles.admin')}
                      {userPermissions.roleName === 'manager' && t('auth:roles.manager')}
                      {userPermissions.roleName === 'employee' && t('auth:roles.employee')}
                    </div>
                  )}
                </div>
              </div>

              {/* Logout Button */}
              <button
                onClick={handleLogout}
                className="bg-gray-700 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-gray-600 transition-colors duration-200 hidden md:block"
              >
                {t('common:navigation.logout')}
              </button>

              {/* Mobile menu button */}
              <button
                onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
                className="lg:hidden inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-white hover:bg-gray-700 transition-colors duration-200"
              >
                <svg className="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  {isMobileMenuOpen ? (
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                  ) : (
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
                  )}
                </svg>
              </button>
            </div>
          </div>

          {/* Mobile Navigation */}
          {isMobileMenuOpen && (
            <div className="lg:hidden">
              <div className="px-2 pt-2 pb-3 space-y-1 sm:px-3 border-t border-gray-700">
                {/* User Info Mobile */}
                <div className="text-gray-300 px-3 py-2 border-b border-gray-700 mb-2">
                  <div className="text-sm font-medium">{user?.name}</div>
                  {userPermissions?.roleName && (
                    <div className="text-xs text-gray-400">
                      {userPermissions.roleName === 'admin' && t('auth:roles.admin')}
                      {userPermissions.roleName === 'manager' && t('auth:roles.manager')}
                      {userPermissions.roleName === 'employee' && t('auth:roles.employee')}
                    </div>
                  )}
                </div>

                <NavLink to="/dashboard" className={mobileNavLinkClass} onClick={() => setIsMobileMenuOpen(false)}>
                   {t('common:navigation.dashboard')}
                </NavLink>
                <NavLink to="/reports" className={mobileNavLinkClass} onClick={() => setIsMobileMenuOpen(false)}>
                   {t('common:navigation.reports')}
                </NavLink>
                <NavLink to="/reports/new" className={mobileNavLinkClass} onClick={() => setIsMobileMenuOpen(false)}>
                   {t('common:buttons.new')}
                </NavLink>
                <NavLink to="/statistics" className={mobileNavLinkClass} onClick={() => setIsMobileMenuOpen(false)}>
                   {t('common:navigation.analytics')}
                </NavLink>
                <WithPermission permission="view_analytics">
                  <NavLink to="/analytics" className={mobileNavLinkClass} onClick={() => setIsMobileMenuOpen(false)}>
                    {t('common:navigation.personalAnalytics')}
                  </NavLink>
                </WithPermission>
                <ManagerOrAdmin>
                  <NavLink to="/statistics/global" className={mobileNavLinkClass} onClick={() => setIsMobileMenuOpen(false)}>
                     {t('common:navigation.globalStatistics')}
                  </NavLink>
                </ManagerOrAdmin>
                <WithPermission permission="manage_users">
                  <NavLink to="/admin/users" className={mobileNavLinkClass} onClick={() => setIsMobileMenuOpen(false)}>
                     {t('common:navigation.adminDashboard')}
                  </NavLink>
                </WithPermission>
                
                {/* Mobile Language Switcher */}
                <div className="px-3 py-2 mt-4 border-t border-gray-700 pt-4">
                  <div className="text-sm text-gray-400 mb-2">{t('common:language.selectLanguage')}</div>
                  <LanguageSwitcher />
                </div>
                
                {/* Mobile Logout */}
                <button
                  onClick={handleLogout}
                  className="w-full text-left px-3 py-2 rounded-md text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white transition-colors duration-200 mt-2"
                >
                   {t('common:navigation.logout')}
                </button>
              </div>
            </div>
          )}
        </div>
      </nav>

      <main className="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <Outlet />
      </main>
    </div>
  );
};

export default Layout;