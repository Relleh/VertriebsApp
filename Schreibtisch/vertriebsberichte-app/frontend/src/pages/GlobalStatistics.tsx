import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { ManagerOrAdmin } from '../components/RoleProtectedComponent';
import { useAuth } from '../contexts/AuthContext';
import { useTranslation } from 'react-i18next';

interface GlobalStats {
  gesamt_berichte: number;
  gesamt_kunden: number;
  neue_kunden: number;
  a_kunden: number;
  b_kunden: number;
  c_kunden: number;
  aktive_mitarbeiter: number;
  gesamt_auftragswert: number;
  gesamt_angebotswert: number;
  durchschnitt_auftragswert: number;
  durchschnitt_angebotswert: number;
}

interface Employee {
  mitarbeiter_id: number;
  mitarbeiter_name: string;
  mitarbeiter_email: string;
  region_name: string;
  anzahl_berichte: number;
  anzahl_kunden: number;
  neue_kunden: number;
  auftragswert_gesamt: number;
  angebotswert_gesamt: number;
  auftragswert_durchschnitt: number;
}

interface TopCustomer {
  kunde_nr: string;
  kunde_name: string;
  klassifizierung: string;
  region_name: string;
  anzahl_berichte: number;
  auftragswert_gesamt: number;
  angebotswert_gesamt: number;
  letzter_besuch: string;
}

interface Trend {
  monat: string;
  berichte_anzahl: number;
  kunden_anzahl: number;
  auftragswert: number;
  angebotswert: number;
}

interface GlobalStatisticsData {
  global: GlobalStats;
  mitarbeiter: Employee[];
  topKunden: TopCustomer[];
  trends: Trend[];
}

const GlobalStatistics: React.FC = () => {
  const { user } = useAuth();
  const { t, i18n } = useTranslation(['globalStats', 'common']);
  const [data, setData] = useState<GlobalStatisticsData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');

  useEffect(() => {
    loadGlobalStatistics();
  }, [startDate, endDate]);

  const loadGlobalStatistics = async () => {
    try {
      setLoading(true);
      
      const params = new URLSearchParams();
      if (startDate) params.append('startDate', startDate);
      if (endDate) params.append('endDate', endDate);
      
      const response = await axios.get(`/api/reports/statistics/global?${params}`);
      setData(response.data.data);
      setError(null);
    } catch (err) {
      setError(t('globalStats:errorLoading'));
      console.error('Global statistics error:', err);
    } finally {
      setLoading(false);
    }
  };

  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat(i18n.language === 'en' ? 'en-US' : 'de-DE', {
      style: 'currency',
      currency: 'EUR'
    }).format(amount);
  };

  const formatDate = (dateString: string) => {
    if (!dateString) return t('globalStats:topCustomers.neverVisited');
    return new Date(dateString).toLocaleDateString(i18n.language === 'en' ? 'en-US' : 'de-DE');
  };

  const getCustomerBadgeColor = (classification: string) => {
    switch (classification) {
      case 'A': return 'bg-red-100 text-red-800';
      case 'B': return 'bg-yellow-100 text-yellow-800';
      case 'C': return 'bg-green-100 text-green-800';
      default: return 'bg-gray-100 text-gray-800';
    }
  };

  const resetFilters = () => {
    setStartDate('');
    setEndDate('');
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-blue-500"></div>
      </div>
    );
  }

  return (
    <ManagerOrAdmin fallback={
      <div className="text-center py-12">
        <h2 className="text-2xl font-bold text-gray-900 mb-4">{t('globalStats:accessDenied.title')}</h2>
        <p className="text-gray-600">{t('globalStats:accessDenied.message')}</p>
      </div>
    }>
      <div className="space-y-6">
        {/* Header */}
        <div className="border-b border-gray-200 pb-4">
          <h1 className="text-3xl font-bold text-gray-900">{t('globalStats:title')}</h1>
          <p className="text-gray-600 mt-2">
            {t('globalStats:subtitle')} - {user?.name}
          </p>
        </div>

        {/* Filters */}
        <div className="bg-white shadow rounded-lg p-6">
          <h2 className="text-lg font-medium text-gray-900 mb-4">{t('globalStats:dateFilter.title')}</h2>
          
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                {t('globalStats:dateFilter.fromDate')}
              </label>
              <input
                type="date"
                value={startDate}
                onChange={(e) => setStartDate(e.target.value)}
                className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                {t('globalStats:dateFilter.toDate')}
              </label>
              <input
                type="date"
                value={endDate}
                onChange={(e) => setEndDate(e.target.value)}
                className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            
            <div className="flex items-end">
              <button
                onClick={resetFilters}
                className="w-full bg-gray-600 text-white px-4 py-2 rounded-md hover:bg-gray-700"
              >
                {t('globalStats:dateFilter.resetFilters')}
              </button>
            </div>
            
            <div className="flex items-end">
              <button
                onClick={loadGlobalStatistics}
                className="w-full bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700"
              >
                {t('globalStats:dateFilter.refresh')}
              </button>
            </div>
          </div>
        </div>

        {error && (
          <div className="bg-red-50 border border-red-200 rounded-md p-4">
            <div className="text-red-800">{error}</div>
          </div>
        )}

        {data && (
          <>
            {/* Global Statistics Cards */}
            <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
              <div className="bg-white overflow-hidden shadow rounded-lg">
                <div className="p-5">
                  <div className="flex items-center">
                    <div className="flex-shrink-0">
                      <span className="text-2xl">📊</span>
                    </div>
                    <div className="ml-5 w-0 flex-1">
                      <dl>
                        <dt className="text-sm font-medium text-gray-500 truncate">
                          {t('globalStats:kpis.totalReports')}
                        </dt>
                        <dd className="text-lg font-medium text-gray-900">
                          {data.global.gesamt_berichte?.toLocaleString(i18n.language === 'en' ? 'en-US' : 'de-DE') || 0}
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
                      <span className="text-2xl">👥</span>
                    </div>
                    <div className="ml-5 w-0 flex-1">
                      <dl>
                        <dt className="text-sm font-medium text-gray-500 truncate">
                          {t('globalStats:kpis.totalCustomers')}
                        </dt>
                        <dd className="text-lg font-medium text-gray-900">
                          {data.global.gesamt_kunden?.toLocaleString(i18n.language === 'en' ? 'en-US' : 'de-DE') || 0}
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
                      <span className="text-2xl">💰</span>
                    </div>
                    <div className="ml-5 w-0 flex-1">
                      <dl>
                        <dt className="text-sm font-medium text-gray-500 truncate">
                          {t('globalStats:kpis.totalOrderValue')}
                        </dt>
                        <dd className="text-lg font-medium text-gray-900">
                          {formatCurrency(data.global.gesamt_auftragswert || 0)}
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
                      <span className="text-2xl">📈</span>
                    </div>
                    <div className="ml-5 w-0 flex-1">
                      <dl>
                        <dt className="text-sm font-medium text-gray-500 truncate">
                          {t('globalStats:kpis.newCustomers')}
                        </dt>
                        <dd className="text-lg font-medium text-gray-900">
                          {data.global.neue_kunden?.toLocaleString(i18n.language === 'en' ? 'en-US' : 'de-DE') || 0}
                        </dd>
                      </dl>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            {/* Customer Classification */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div className="bg-white overflow-hidden shadow rounded-lg">
                <div className="p-5">
                  <div className="flex items-center">
                    <div className="flex-shrink-0">
                      <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">A</span>
                    </div>
                    <div className="ml-5 w-0 flex-1">
                      <dl>
                        <dt className="text-sm font-medium text-gray-500 truncate">
                          {t('globalStats:kpis.aCustomers')}
                        </dt>
                        <dd className="text-lg font-medium text-gray-900">
                          {data.global.a_kunden?.toLocaleString(i18n.language === 'en' ? 'en-US' : 'de-DE') || 0}
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
                      <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">B</span>
                    </div>
                    <div className="ml-5 w-0 flex-1">
                      <dl>
                        <dt className="text-sm font-medium text-gray-500 truncate">
                          {t('globalStats:kpis.bCustomers')}
                        </dt>
                        <dd className="text-lg font-medium text-gray-900">
                          {data.global.b_kunden?.toLocaleString(i18n.language === 'en' ? 'en-US' : 'de-DE') || 0}
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
                      <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">C</span>
                    </div>
                    <div className="ml-5 w-0 flex-1">
                      <dl>
                        <dt className="text-sm font-medium text-gray-500 truncate">
                          {t('globalStats:kpis.cCustomers')}
                        </dt>
                        <dd className="text-lg font-medium text-gray-900">
                          {data.global.c_kunden?.toLocaleString(i18n.language === 'en' ? 'en-US' : 'de-DE') || 0}
                        </dd>
                      </dl>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            {/* Employee Performance */}
            <div className="bg-white shadow rounded-lg">
              <div className="px-6 py-4 border-b border-gray-200">
                <h2 className="text-lg font-medium text-gray-900">{t('globalStats:employeePerformance.title')}</h2>
              </div>
              
              <div className="overflow-x-auto">
                <table className="min-w-full divide-y divide-gray-200">
                  <thead className="bg-gray-50">
                    <tr>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {t('globalStats:employeePerformance.headers.employee')}
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {t('globalStats:employeePerformance.headers.region')}
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {t('globalStats:employeePerformance.headers.reports')}
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {t('globalStats:employeePerformance.headers.customers')}
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {t('globalStats:employeePerformance.headers.orderValue')}
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {t('globalStats:employeePerformance.headers.avgOrderValue')}
                      </th>
                    </tr>
                  </thead>
                  <tbody className="bg-white divide-y divide-gray-200">
                    {data.mitarbeiter.map(employee => (
                      <tr key={employee.mitarbeiter_id} className="hover:bg-gray-50">
                        <td className="px-6 py-4 whitespace-nowrap">
                          <div>
                            <div className="text-sm font-medium text-gray-900">
                              {employee.mitarbeiter_name}
                            </div>
                            <div className="text-sm text-gray-500">
                              {employee.mitarbeiter_email}
                            </div>
                          </div>
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                          {employee.region_name}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                          {employee.anzahl_berichte}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                          {employee.anzahl_kunden}
                          {employee.neue_kunden > 0 && (
                            <span className="ml-1 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                              +{employee.neue_kunden} {t('globalStats:topCustomers.newCustomer')}
                            </span>
                          )}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                          {formatCurrency(employee.auftragswert_gesamt)}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                          {formatCurrency(employee.auftragswert_durchschnitt)}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>

            {/* Top Customers */}
            <div className="bg-white shadow rounded-lg">
              <div className="px-6 py-4 border-b border-gray-200">
                <h2 className="text-lg font-medium text-gray-900">{t('globalStats:topCustomers.title')}</h2>
              </div>
              
              <div className="overflow-x-auto">
                <table className="min-w-full divide-y divide-gray-200">
                  <thead className="bg-gray-50">
                    <tr>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {t('globalStats:topCustomers.headers.customer')}
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {t('globalStats:topCustomers.headers.region')}
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {t('globalStats:topCustomers.headers.class')}
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {t('globalStats:topCustomers.headers.reports')}
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {t('globalStats:topCustomers.headers.orderValue')}
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {t('globalStats:topCustomers.headers.lastVisit')}
                      </th>
                    </tr>
                  </thead>
                  <tbody className="bg-white divide-y divide-gray-200">
                    {data.topKunden.map((customer, index) => (
                      <tr key={customer.kunde_nr} className="hover:bg-gray-50">
                        <td className="px-6 py-4 whitespace-nowrap">
                          <div>
                            <div className="text-sm font-medium text-gray-900">
                              #{index + 1} {customer.kunde_name}
                            </div>
                            <div className="text-sm text-gray-500">
                              {customer.kunde_nr}
                            </div>
                          </div>
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                          {customer.region_name}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap">
                          <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${getCustomerBadgeColor(customer.klassifizierung)}`}>
                            {customer.klassifizierung}
                          </span>
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                          {customer.anzahl_berichte}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                          {formatCurrency(customer.auftragswert_gesamt)}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                          {formatDate(customer.letzter_besuch)}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          </>
        )}
      </div>
    </ManagerOrAdmin>
  );
};

export default GlobalStatistics;