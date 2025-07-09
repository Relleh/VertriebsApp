import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';
import { format } from 'date-fns';
import { de, enUS } from 'date-fns/locale';
import { useTranslation } from 'react-i18next';

interface Statistics {
  total_reports: number;
  total_customers: number;
  new_customers: number;
  total_orders: number;
  total_offers: number;
  reports_last_week: number;
  reports_last_month: number;
}

interface RecentReport {
  id: number;
  kunde_name: string;
  datum: string;
  ort: string;
  klassifizierung: string;
  auftragswert: number;
}

const Dashboard = () => {
  const { t, i18n } = useTranslation(['dashboard', 'common']);
  const [statistics, setStatistics] = useState<Statistics | null>(null);
  const [recentReports, setRecentReports] = useState<RecentReport[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const [statsRes, reportsRes] = await Promise.all([
        axios.get('/api/users/statistics'),
        axios.get('/api/reports?limit=5')
      ]);

      setStatistics(statsRes.data.data);
      setRecentReports(reportsRes.data.data);
    } catch (error) {
      console.error(t('dashboard:error'), error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="flex justify-center items-center h-64">
        <div className="text-gray-500">{t('dashboard:loading')}</div>
      </div>
    );
  }

  return (
    <div className="px-4 py-6 sm:px-0">
      <h1 className="text-2xl font-bold text-gray-900 mb-6">{t('dashboard:title')}</h1>

      <div className="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-4">
        <div className="bg-white overflow-hidden shadow rounded-lg">
          <div className="px-4 py-5 sm:p-6">
            <dt className="text-sm font-medium text-gray-500 truncate">
              {t('dashboard:statistics.totalReports')}
            </dt>
            <dd className="mt-1 text-3xl font-semibold text-gray-900">
              {statistics?.total_reports || 0}
            </dd>
          </div>
        </div>

        <div className="bg-white overflow-hidden shadow rounded-lg">
          <div className="px-4 py-5 sm:p-6">
            <dt className="text-sm font-medium text-gray-500 truncate">
              {t('dashboard:statistics.totalCustomers')}
            </dt>
            <dd className="mt-1 text-3xl font-semibold text-gray-900">
              {statistics?.total_customers || 0}
            </dd>
          </div>
        </div>

        <div className="bg-white overflow-hidden shadow rounded-lg">
          <div className="px-4 py-5 sm:p-6">
            <dt className="text-sm font-medium text-gray-500 truncate">
              {t('dashboard:statistics.newCustomers')}
            </dt>
            <dd className="mt-1 text-3xl font-semibold text-gray-900">
              {statistics?.new_customers || 0}
            </dd>
          </div>
        </div>

        <div className="bg-white overflow-hidden shadow rounded-lg">
          <div className="px-4 py-5 sm:p-6">
            <dt className="text-sm font-medium text-gray-500 truncate">
              {t('dashboard:statistics.totalOrderValue')}
            </dt>
            <dd className="mt-1 text-3xl font-semibold text-gray-900">
              {new Intl.NumberFormat(i18n.language === 'en' ? 'en-US' : 'de-DE', {
                style: 'currency',
                currency: 'EUR',
              }).format(statistics?.total_orders || 0)}
            </dd>
          </div>
        </div>
      </div>

      <div className="mt-8 grid grid-cols-1 gap-5 lg:grid-cols-2">
        <div className="bg-white shadow rounded-lg">
          <div className="px-4 py-5 sm:p-6">
            <h3 className="text-lg leading-6 font-medium text-gray-900 mb-4">
              {t('dashboard:sections.reportsLastWeek')}/{t('dashboard:sections.reportsLastMonth')}
            </h3>
            <dl className="space-y-2">
              <div className="flex justify-between">
                <dt className="text-sm font-medium text-gray-500">{t('dashboard:statistics.lastWeek')}</dt>
                <dd className="text-sm text-gray-900">{statistics?.reports_last_week || 0}</dd>
              </div>
              <div className="flex justify-between">
                <dt className="text-sm font-medium text-gray-500">{t('dashboard:statistics.lastMonth')}</dt>
                <dd className="text-sm text-gray-900">{statistics?.reports_last_month || 0}</dd>
              </div>
            </dl>
          </div>
        </div>

        <div className="bg-white shadow rounded-lg">
          <div className="px-4 py-5 sm:p-6">
            <h3 className="text-lg leading-6 font-medium text-gray-900 mb-4">
              {t('dashboard:statistics.totalOfferValue')}
            </h3>
            <p className="text-3xl font-semibold text-gray-900">
              {new Intl.NumberFormat(i18n.language === 'en' ? 'en-US' : 'de-DE', {
                style: 'currency',
                currency: 'EUR',
              }).format(statistics?.total_offers || 0)}
            </p>
          </div>
        </div>
      </div>

      <div className="mt-8">
        <div className="bg-white shadow rounded-lg">
          <div className="px-4 py-5 sm:p-6">
            <div className="flex justify-between items-center mb-4">
              <h3 className="text-lg leading-6 font-medium text-gray-900">
                {t('dashboard:sections.recentReports')}
              </h3>
              <Link
                to="/reports"
                className="text-sm text-indigo-600 hover:text-indigo-900"
              >
                {t('dashboard:actions.viewAll')}
              </Link>
            </div>
            
            {recentReports.length > 0 ? (
              <div className="overflow-hidden">
                <table className="min-w-full divide-y divide-gray-200">
                  <thead className="bg-gray-50">
                    <tr>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {t('dashboard:table.customer')}
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {t('dashboard:table.date')}
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {t('dashboard:table.location')}
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {t('dashboard:table.class')}
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {t('dashboard:table.orderValue')}
                      </th>
                    </tr>
                  </thead>
                  <tbody className="bg-white divide-y divide-gray-200">
                    {recentReports.map((report) => (
                      <tr key={report.id}>
                        <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                          {report.kunde_name}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                          {format(new Date(report.datum), i18n.language === 'en' ? 'MM/dd/yyyy' : 'dd.MM.yyyy', { 
                            locale: i18n.language === 'en' ? enUS : de 
                          })}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                          {report.ort}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap">
                          <span className={`inline-flex px-2 py-1 text-xs font-semibold rounded-full ${
                            report.klassifizierung === 'A' ? 'bg-green-100 text-green-800' :
                            report.klassifizierung === 'B' ? 'bg-yellow-100 text-yellow-800' :
                            'bg-gray-100 text-gray-800'
                          }`}>
                            {report.klassifizierung}
                          </span>
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                          {new Intl.NumberFormat(i18n.language === 'en' ? 'en-US' : 'de-DE', {
                            style: 'currency',
                            currency: 'EUR',
                          }).format(report.auftragswert || 0)}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            ) : (
              <p className="text-gray-500 text-center py-4">
                {t('dashboard:empty.noReports')} <Link to="/reports/new" className="text-indigo-600 hover:text-indigo-900">{t('dashboard:empty.createFirstReport')}</Link>
              </p>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;