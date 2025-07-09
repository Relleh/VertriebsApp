import { useEffect, useState } from 'react';
import axios from 'axios';
import { useTranslation } from 'react-i18next';

interface RegionalStatistic {
  region_code: string;
  region_name: string;
  a_kunden: number;
  b_kunden: number;
  c_kunden: number;
  gesamt_kunden: number;
  neue_kunden: number;
  gesamt_auftragswert: number;
  gesamt_angebotswert: number;
}

const Statistics = () => {
  const { t, i18n } = useTranslation(['statistics', 'common']);
  const [statistics, setStatistics] = useState<RegionalStatistic[]>([]);
  const [loading, setLoading] = useState(true);
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');

  useEffect(() => {
    fetchStatistics();
  }, [startDate, endDate]);

  const fetchStatistics = async () => {
    try {
      setLoading(true);
      const params: any = {};
      if (startDate) params.startDate = startDate;
      if (endDate) params.endDate = endDate;

      const response = await axios.get('/api/reports/statistics', { params });
      setStatistics(response.data.data);
    } catch (error) {
      console.error(t('statistics:errorLoading'), error);
    } finally {
      setLoading(false);
    }
  };

  const totals = statistics.reduce(
    (acc, stat) => ({
      a_kunden: acc.a_kunden + stat.a_kunden,
      b_kunden: acc.b_kunden + stat.b_kunden,
      c_kunden: acc.c_kunden + stat.c_kunden,
      gesamt_kunden: acc.gesamt_kunden + stat.gesamt_kunden,
      neue_kunden: acc.neue_kunden + stat.neue_kunden,
      gesamt_auftragswert: acc.gesamt_auftragswert + stat.gesamt_auftragswert,
      gesamt_angebotswert: acc.gesamt_angebotswert + stat.gesamt_angebotswert,
    }),
    {
      a_kunden: 0,
      b_kunden: 0,
      c_kunden: 0,
      gesamt_kunden: 0,
      neue_kunden: 0,
      gesamt_auftragswert: 0,
      gesamt_angebotswert: 0,
    }
  );

  if (loading) {
    return (
      <div className="flex justify-center items-center h-64">
        <div className="text-gray-500">{t('statistics:loading')}</div>
      </div>
    );
  }

  return (
    <div className="px-4 py-6 sm:px-0">
      <h1 className="text-2xl font-bold text-gray-900 mb-6">{t('statistics:title')}</h1>

      <div className="bg-white shadow rounded-lg mb-6 p-4">
        <div className="grid grid-cols-1 gap-4 md:grid-cols-3">
          <div>
            <label className="block text-sm font-medium text-gray-700">{t('statistics:dateFilter.fromDate')}</label>
            <input
              type="date"
              value={startDate}
              onChange={(e) => setStartDate(e.target.value)}
              className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium text-gray-700">{t('statistics:dateFilter.toDate')}</label>
            <input
              type="date"
              value={endDate}
              onChange={(e) => setEndDate(e.target.value)}
              className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            />
          </div>
          
          <div className="flex items-end">
            <button
              onClick={() => {
                setStartDate('');
                setEndDate('');
              }}
              className="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50"
            >
              {t('statistics:dateFilter.resetFilters')}
            </button>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-4 mb-8">
        <div className="bg-white overflow-hidden shadow rounded-lg">
          <div className="px-4 py-5 sm:p-6">
            <dt className="text-sm font-medium text-gray-500 truncate">
              {t('statistics:kpis.totalCustomers')}
            </dt>
            <dd className="mt-1 text-3xl font-semibold text-gray-900">
              {totals.gesamt_kunden}
            </dd>
          </div>
        </div>

        <div className="bg-white overflow-hidden shadow rounded-lg">
          <div className="px-4 py-5 sm:p-6">
            <dt className="text-sm font-medium text-gray-500 truncate">
              {t('statistics:kpis.newCustomers')}
            </dt>
            <dd className="mt-1 text-3xl font-semibold text-gray-900">
              {totals.neue_kunden}
            </dd>
          </div>
        </div>

        <div className="bg-white overflow-hidden shadow rounded-lg">
          <div className="px-4 py-5 sm:p-6">
            <dt className="text-sm font-medium text-gray-500 truncate">
              {t('statistics:kpis.totalOrderValue')}
            </dt>
            <dd className="mt-1 text-3xl font-semibold text-gray-900">
              {new Intl.NumberFormat(i18n.language === 'en' ? 'en-US' : 'de-DE', {
                style: 'currency',
                currency: 'EUR',
                notation: 'compact',
                maximumFractionDigits: 1,
              }).format(totals.gesamt_auftragswert)}
            </dd>
          </div>
        </div>

        <div className="bg-white overflow-hidden shadow rounded-lg">
          <div className="px-4 py-5 sm:p-6">
            <dt className="text-sm font-medium text-gray-500 truncate">
              {t('statistics:kpis.totalOfferValue')}
            </dt>
            <dd className="mt-1 text-3xl font-semibold text-gray-900">
              {new Intl.NumberFormat(i18n.language === 'en' ? 'en-US' : 'de-DE', {
                style: 'currency',
                currency: 'EUR',
                notation: 'compact',
                maximumFractionDigits: 1,
              }).format(totals.gesamt_angebotswert)}
            </dd>
          </div>
        </div>
      </div>

      <div className="bg-white shadow overflow-hidden sm:rounded-lg">
        <div className="px-4 py-5 sm:p-6">
          <h3 className="text-lg leading-6 font-medium text-gray-900 mb-4">
            {t('statistics:breakdown.title')}
          </h3>
          
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    {t('statistics:breakdown.headers.region')}
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    {t('statistics:breakdown.headers.aCustomers')}
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    {t('statistics:breakdown.headers.bCustomers')}
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    {t('statistics:breakdown.headers.cCustomers')}
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    {t('statistics:breakdown.headers.total')}
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    {t('statistics:breakdown.headers.newCustomers')}
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    {t('statistics:breakdown.headers.orderValue')}
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    {t('statistics:breakdown.headers.offerValue')}
                  </th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {statistics.map((stat) => (
                  <tr key={stat.region_code} className="hover:bg-gray-50">
                    <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                      {stat.region_name}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      <span className="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">
                        {stat.a_kunden}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      <span className="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-yellow-100 text-yellow-800">
                        {stat.b_kunden}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      <span className="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-gray-100 text-gray-800">
                        {stat.c_kunden}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      {stat.gesamt_kunden}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      <span className="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-800">
                        {stat.neue_kunden}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      {new Intl.NumberFormat(i18n.language === 'en' ? 'en-US' : 'de-DE', {
                        style: 'currency',
                        currency: 'EUR',
                        notation: 'compact',
                        maximumFractionDigits: 1,
                      }).format(stat.gesamt_auftragswert)}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      {new Intl.NumberFormat(i18n.language === 'en' ? 'en-US' : 'de-DE', {
                        style: 'currency',
                        currency: 'EUR',
                        notation: 'compact',
                        maximumFractionDigits: 1,
                      }).format(stat.gesamt_angebotswert)}
                    </td>
                  </tr>
                ))}
                {statistics.length > 1 && (
                  <tr className="bg-gray-50 font-semibold">
                    <td className="px-6 py-4 whitespace-nowrap text-sm font-bold text-gray-900">
                      {t('statistics:breakdown.summary')}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      <span className="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-green-200 text-green-900">
                        {totals.a_kunden}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      <span className="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-yellow-200 text-yellow-900">
                        {totals.b_kunden}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      <span className="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-gray-200 text-gray-900">
                        {totals.c_kunden}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm font-bold text-gray-900">
                      {totals.gesamt_kunden}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      <span className="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-blue-200 text-blue-900">
                        {totals.neue_kunden}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm font-bold text-gray-900">
                      {new Intl.NumberFormat(i18n.language === 'en' ? 'en-US' : 'de-DE', {
                        style: 'currency',
                        currency: 'EUR',
                        notation: 'compact',
                        maximumFractionDigits: 1,
                      }).format(totals.gesamt_auftragswert)}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm font-bold text-gray-900">
                      {new Intl.NumberFormat(i18n.language === 'en' ? 'en-US' : 'de-DE', {
                        style: 'currency',
                        currency: 'EUR',
                        notation: 'compact',
                        maximumFractionDigits: 1,
                      }).format(totals.gesamt_angebotswert)}
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Statistics;