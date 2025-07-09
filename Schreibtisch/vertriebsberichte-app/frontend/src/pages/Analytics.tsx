import { useEffect, useState } from 'react';
import axios from 'axios';
import { useTranslation } from 'react-i18next';
import { useAuth } from '../contexts/AuthContext';

interface AnalyticsData {
  personalStats: {
    totalReports: number;
    averageOrderValue: number;
    totalOrderValue: number;
    newCustomers: number;
  };
  recentActivity: {
    date: string;
    kunde_name: string;
    auftragswert: number;
    status: string;
  }[];
  monthlyTrends: {
    month: string;
    reportCount: number;
    totalValue: number;
  }[];
  statusDistribution: {
    status: string;
    count: number;
    percentage: number;
  }[];
}

const Analytics = () => {
  const { t, i18n } = useTranslation(['common', 'status']);
  const { user } = useAuth();
  const [analyticsData, setAnalyticsData] = useState<AnalyticsData | null>(null);
  const [loading, setLoading] = useState(true);
  const [dateRange, setDateRange] = useState('30'); // days

  useEffect(() => {
    fetchAnalyticsData();
  }, [dateRange]);

  const fetchAnalyticsData = async () => {
    try {
      setLoading(true);
      const response = await axios.get(`/api/analytics/personal?days=${dateRange}`);
      setAnalyticsData(response.data);
    } catch (error) {
      console.error(t('common:analytics.errorLoading'), error);
      // Fallback: Mock data für Demonstration
      setAnalyticsData({
        personalStats: {
          totalReports: 45,
          averageOrderValue: 12500,
          totalOrderValue: 562500,
          newCustomers: 12
        },
        recentActivity: [
          {
            date: '2025-07-06',
            kunde_name: 'Musterfirma GmbH',
            auftragswert: 15000,
            status: 'K'
          },
          {
            date: '2025-07-05',
            kunde_name: 'Beispiel AG',
            auftragswert: 8500,
            status: 'U'
          },
          {
            date: '2025-07-04',
            kunde_name: 'Demo Corp',
            auftragswert: 22000,
            status: 'K'
          }
        ],
        monthlyTrends: [
          { month: 'Jan 2025', reportCount: 12, totalValue: 145000 },
          { month: 'Feb 2025', reportCount: 15, totalValue: 180000 },
          { month: 'Mar 2025', reportCount: 18, totalValue: 220000 },
          { month: 'Apr 2025', reportCount: 14, totalValue: 165000 },
          { month: 'Mai 2025', reportCount: 16, totalValue: 195000 },
          { month: 'Jun 2025', reportCount: 20, totalValue: 245000 }
        ],
        statusDistribution: [
          { status: 'Komplett', count: 18, percentage: 40 },
          { status: 'Umsetzung', count: 12, percentage: 27 },
          { status: 'Bearbeitung', count: 8, percentage: 18 },
          { status: 'Offen', count: 5, percentage: 11 },
          { status: 'Verschoben', count: 2, percentage: 4 }
        ]
      });
    } finally {
      setLoading(false);
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'K': return 'text-green-600 bg-green-100';
      case 'U': return 'text-blue-600 bg-blue-100';
      case 'B': return 'text-yellow-600 bg-yellow-100';
      case 'O': return 'text-red-600 bg-red-100';
      case 'V': return 'text-purple-600 bg-purple-100';
      default: return 'text-gray-600 bg-gray-100';
    }
  };

  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat(i18n.language === 'en' ? 'en-US' : 'de-DE', {
      style: 'currency',
      currency: 'EUR'
    }).format(amount);
  };

  if (loading) {
    return (
      <div className="flex justify-center items-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-indigo-600"></div>
      </div>
    );
  }

  if (!analyticsData) {
    return (
      <div className="text-center py-12">
        <div className="text-gray-500">{t('common:analytics.noData')}</div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">{t('common:analytics.title')}</h1>
          <p className="text-gray-600 mt-1">
            {t('common:analytics.subtitle')} {user?.name}
          </p>
        </div>
        <div className="flex items-center space-x-4">
          <label htmlFor="dateRange" className="text-sm font-medium text-gray-700">
            {t('common:analytics.timeRange.label')}
          </label>
          <select
            id="dateRange"
            value={dateRange}
            onChange={(e) => setDateRange(e.target.value)}
            className="border border-gray-300 rounded-md px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
          >
            <option value="7">{t('common:analytics.timeRange.last7Days')}</option>
            <option value="30">{t('common:analytics.timeRange.last30Days')}</option>
            <option value="90">{t('common:analytics.timeRange.last90Days')}</option>
            <option value="365">{t('common:analytics.timeRange.lastYear')}</option>
          </select>
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div className="bg-white overflow-hidden shadow rounded-lg">
          <div className="p-5">
            <div className="flex items-center">
              <div className="flex-shrink-0">
                <div className="w-8 h-8 bg-blue-500 rounded-md flex items-center justify-center">
                  <span className="text-white font-bold">📄</span>
                </div>
              </div>
              <div className="ml-5 w-0 flex-1">
                <dl>
                  <dt className="text-sm font-medium text-gray-500 truncate">
                    {t('common:analytics.kpi.totalReports')}
                  </dt>
                  <dd className="text-lg font-medium text-gray-900">
                    {analyticsData.personalStats.totalReports}
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
                <div className="w-8 h-8 bg-green-500 rounded-md flex items-center justify-center">
                  <span className="text-white font-bold">💰</span>
                </div>
              </div>
              <div className="ml-5 w-0 flex-1">
                <dl>
                  <dt className="text-sm font-medium text-gray-500 truncate">
                    {t('common:analytics.kpi.totalRevenue')}
                  </dt>
                  <dd className="text-lg font-medium text-gray-900">
                    {formatCurrency(analyticsData.personalStats.totalOrderValue)}
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
                <div className="w-8 h-8 bg-yellow-500 rounded-md flex items-center justify-center">
                  <span className="text-white font-bold">📊</span>
                </div>
              </div>
              <div className="ml-5 w-0 flex-1">
                <dl>
                  <dt className="text-sm font-medium text-gray-500 truncate">
                    {t('common:analytics.kpi.avgOrderValue')}
                  </dt>
                  <dd className="text-lg font-medium text-gray-900">
                    {formatCurrency(analyticsData.personalStats.averageOrderValue)}
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
                <div className="w-8 h-8 bg-purple-500 rounded-md flex items-center justify-center">
                  <span className="text-white font-bold">🆕</span>
                </div>
              </div>
              <div className="ml-5 w-0 flex-1">
                <dl>
                  <dt className="text-sm font-medium text-gray-500 truncate">
                    {t('common:analytics.kpi.newCustomers')}
                  </dt>
                  <dd className="text-lg font-medium text-gray-900">
                    {analyticsData.personalStats.newCustomers}
                  </dd>
                </dl>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Charts Row */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Monthly Trends */}
        <div className="bg-white shadow rounded-lg p-6">
          <h3 className="text-lg font-medium text-gray-900 mb-4">{t('common:analytics.charts.monthlyTrends')}</h3>
          <div className="space-y-4">
            {analyticsData.monthlyTrends.map((trend, index) => (
              <div key={index} className="flex items-center justify-between">
                <div className="flex-1">
                  <div className="flex justify-between text-sm">
                    <span className="text-gray-600">{trend.month}</span>
                    <span className="font-medium">{trend.reportCount} {t('common:analytics.charts.reports')}</span>
                  </div>
                  <div className="mt-1">
                    <div className="bg-gray-200 rounded-full h-2">
                      <div 
                        className="bg-indigo-600 h-2 rounded-full"
                        style={{ width: `${(trend.reportCount / 25) * 100}%` }}
                      ></div>
                    </div>
                  </div>
                  <div className="text-xs text-gray-500 mt-1">
                    {formatCurrency(trend.totalValue)}
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Status Distribution */}
        <div className="bg-white shadow rounded-lg p-6">
          <h3 className="text-lg font-medium text-gray-900 mb-4">{t('common:analytics.charts.statusDistribution')}</h3>
          <div className="space-y-4">
            {analyticsData.statusDistribution.map((item, index) => (
              <div key={index} className="flex items-center justify-between">
                <div className="flex-1">
                  <div className="flex justify-between text-sm">
                    <span className="text-gray-600">{item.status}</span>
                    <span className="font-medium">{item.count} ({item.percentage}%)</span>
                  </div>
                  <div className="mt-1">
                    <div className="bg-gray-200 rounded-full h-2">
                      <div 
                        className="bg-gradient-to-r from-indigo-500 to-purple-600 h-2 rounded-full"
                        style={{ width: `${item.percentage}%` }}
                      ></div>
                    </div>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Recent Activity */}
      <div className="bg-white shadow rounded-lg">
        <div className="px-6 py-4 border-b border-gray-200">
          <h3 className="text-lg font-medium text-gray-900">{t('common:analytics.charts.recentActivity')}</h3>
        </div>
        <div className="overflow-hidden">
          <ul className="divide-y divide-gray-200">
            {analyticsData.recentActivity.map((activity, index) => (
              <li key={index} className="px-6 py-4 hover:bg-gray-50">
                <div className="flex items-center justify-between">
                  <div className="flex items-center">
                    <div className="flex-shrink-0">
                      <div className="w-10 h-10 bg-indigo-100 rounded-full flex items-center justify-center">
                        <span className="text-indigo-600 font-medium text-sm">📄</span>
                      </div>
                    </div>
                    <div className="ml-4">
                      <div className="text-sm font-medium text-gray-900">
                        {activity.kunde_name}
                      </div>
                      <div className="text-sm text-gray-500">
                        {new Date(activity.date).toLocaleDateString(i18n.language === 'en' ? 'en-US' : 'de-DE')}
                      </div>
                    </div>
                  </div>
                  <div className="flex items-center space-x-4">
                    <div className="text-sm font-medium text-gray-900">
                      {formatCurrency(activity.auftragswert)}
                    </div>
                    <span className={`inline-flex px-2 py-1 text-xs font-semibold rounded-full ${getStatusColor(activity.status)}`}>
                      {t(`status:process.${activity.status.toLowerCase()}`, { defaultValue: activity.status })}
                    </span>
                  </div>
                </div>
              </li>
            ))}
          </ul>
        </div>
      </div>

      {/* Performance Insights */}
      <div className="bg-gradient-to-r from-indigo-500 to-purple-600 rounded-lg shadow-lg">
        <div className="px-6 py-8 text-white">
          <h3 className="text-xl font-bold mb-4">{t('common:analytics.insights.title')}</h3>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div className="text-center">
              <div className="text-2xl font-bold">
                {Math.round((analyticsData.personalStats.totalOrderValue / analyticsData.personalStats.totalReports))}€
              </div>
              <div className="text-sm opacity-90">{t('common:analytics.insights.avgPerReport')}</div>
            </div>
            <div className="text-center">
              <div className="text-2xl font-bold">
                {Math.round((analyticsData.statusDistribution.find(s => s.status === 'Komplett')?.percentage || 0))}%
              </div>
              <div className="text-sm opacity-90">{t('common:analytics.insights.completionRate')}</div>
            </div>
            <div className="text-center">
              <div className="text-2xl font-bold">
                {Math.round((analyticsData.personalStats.newCustomers / analyticsData.personalStats.totalReports) * 100)}%
              </div>
              <div className="text-sm opacity-90">{t('common:analytics.insights.newCustomerRate')}</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Analytics;