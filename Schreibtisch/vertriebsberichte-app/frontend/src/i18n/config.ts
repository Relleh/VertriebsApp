import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import LanguageDetector from 'i18next-browser-languagedetector';

// Import translation files
import deCommon from '../locales/de/common.json';
import deReports from '../locales/de/reports.json';
import deAuth from '../locales/de/auth.json';
import deStatus from '../locales/de/status.json';
import deDashboard from '../locales/de/dashboard.json';
import deStatistics from '../locales/de/statistics.json';
import deAdmin from '../locales/de/admin.json';
import deGlobalStats from '../locales/de/globalStats.json';
import enCommon from '../locales/en/common.json';
import enReports from '../locales/en/reports.json';
import enAuth from '../locales/en/auth.json';
import enStatus from '../locales/en/status.json';
import enDashboard from '../locales/en/dashboard.json';
import enStatistics from '../locales/en/statistics.json';
import enAdmin from '../locales/en/admin.json';
import enGlobalStats from '../locales/en/globalStats.json';

const resources = {
  de: {
    common: deCommon,
    reports: deReports,
    auth: deAuth,
    status: deStatus,
    dashboard: deDashboard,
    statistics: deStatistics,
    admin: deAdmin,
    globalStats: deGlobalStats
  },
  en: {
    common: enCommon,
    reports: enReports,
    auth: enAuth,
    status: enStatus,
    dashboard: enDashboard,
    statistics: enStatistics,
    admin: enAdmin,
    globalStats: enGlobalStats
  }
};

i18n
  // Detect user language
  .use(LanguageDetector)
  // Pass the i18n instance to react-i18next
  .use(initReactI18next)
  // Initialize i18n
  .init({
    resources,
    lng: 'de', // Default language
    fallbackLng: 'de', // Fallback language
    
    ns: ['common', 'reports', 'auth', 'status', 'dashboard', 'statistics', 'admin', 'globalStats'], // Namespaces
    defaultNS: 'common', // Default namespace
    
    keySeparator: '.', // Separator for nested keys
    
    interpolation: {
      escapeValue: false // React already escapes values
    },
    
    detection: {
      order: ['localStorage', 'navigator', 'htmlTag'],
      caches: ['localStorage']
    }
  });

export default i18n;