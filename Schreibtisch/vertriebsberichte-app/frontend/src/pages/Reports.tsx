import { useEffect, useState, useCallback } from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';
import { format } from 'date-fns';
import { de } from 'date-fns/locale';
import { useTranslation } from 'react-i18next';
import AdvancedFilters, { FilterValues } from '../components/AdvancedFilters';

interface Report {
  id: number;
  kunde_nr: string;
  kunde_name: string;
  mitarbeiter_name: string;
  ansprechpartner: string;
  ort: string;
  datum: string;
  klassifizierung: string;
  auftragswert: number;
  angebotswert: number;
  neukunde: boolean;
  region_name: string;
  status: string;
  kurzbericht: string;
  todos: string;
  created_at: string;
  updated_at: string;
}

interface Pagination {
  page: number;
  limit: number;
  total: number;
  totalPages: number;
}

const Reports = () => {
  const { t, i18n } = useTranslation(['reports', 'common', 'status']);
  const [reports, setReports] = useState<Report[]>([]);
  const [pagination, setPagination] = useState<Pagination | null>(null);
  const [loading, setLoading] = useState(true);
  const [currentPage, setCurrentPage] = useState(1);
  const [filters, setFilters] = useState<FilterValues>({
    startDate: '',
    endDate: '',
    kundeNr: '',
    kundeName: '',
    mitarbeiterName: '',
    ort: '',
    klassifizierung: '',
    status: '',
    neukunde: '',
    minAuftragswert: '',
    maxAuftragswert: '',
    search: '',
    sortBy: 'datum',
    sortOrder: 'desc'
  });

  const fetchReports = useCallback(async () => {
    try {
      setLoading(true);
      const params: any = {
        page: currentPage,
        limit: 20,
        ...filters
      };

      // Remove empty filters
      Object.keys(params).forEach(key => {
        if (params[key] === '' || params[key] === null || params[key] === undefined) {
          delete params[key];
        }
      });

      const response = await axios.get('/api/reports', { params });
      setReports(response.data.data);
      setPagination(response.data.pagination);
    } catch (error) {
      console.error(t('reports:messages.loadError'), error);
    } finally {
      setLoading(false);
    }
  }, [currentPage, filters]);

  useEffect(() => {
    fetchReports();
  }, [fetchReports]);

  const handleFiltersChange = useCallback((newFilters: FilterValues) => {
    setFilters(newFilters);
    setCurrentPage(1); // Reset to first page when filters change
  }, []);

  const handleDelete = async (id: number) => {
    if (!window.confirm(t('reports:list.deleteConfirm'))) {
      return;
    }

    try {
      await axios.delete(`/api/reports/${id}`);
      fetchReports();
    } catch (error) {
      console.error(t('reports:messages.deleteError'), error);
      alert(t('reports:list.deleteError'));
    }
  };

  const getStatusBadgeColor = (status: string) => {
    switch (status) {
      case 'B': return 'bg-yellow-100 text-yellow-800';
      case 'U': return 'bg-blue-100 text-blue-800';
      case 'K': return 'bg-green-100 text-green-800';
      case 'O': return 'bg-red-100 text-red-800';
      case 'V': return 'bg-purple-100 text-purple-800';
      case 'I': return 'bg-gray-100 text-gray-800';
      default: return 'bg-gray-100 text-gray-800';
    }
  };

  const getStatusText = (status: string) => {
    return t(`status:process.${status.toLowerCase()}`, { defaultValue: status });
  };

  if (loading && reports.length === 0) {
    return (
      <div className="flex justify-center items-center h-64">
        <div className="text-gray-500">{t('reports:list.loading')}</div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">{t('reports:list.title')}</h1>
          <p className="text-gray-600 mt-1">
            {pagination ? `${pagination.total} ${t('reports:list.found')}` : t('reports:list.loading')}
          </p>
        </div>
        <Link
          to="/reports/new"
          className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700"
        >
          {t('reports:list.newReport')}
        </Link>
      </div>

      {/* Advanced Filters */}
      <AdvancedFilters 
        onFiltersChange={handleFiltersChange}
        initialFilters={filters}
      />

      {reports.length > 0 ? (
        <>
          <div className="bg-white shadow overflow-hidden sm:rounded-md">
            <ul className="divide-y divide-gray-200">
              {reports.map((report) => (
                <li key={report.id}>
                  <div className="px-4 py-4 sm:px-6 hover:bg-gray-50">
                    <div className="flex items-center justify-between">
                      <div className="flex-1">
                        <div className="flex items-center justify-between">
                          <div>
                            <p className="text-sm font-medium text-indigo-600 truncate">
                              🏢 {report.kunde_name} ({report.kunde_nr})
                            </p>
                            <p className="text-sm text-gray-500">
                              👤 {report.ansprechpartner} • 📍 {report.ort}
                            </p>
                            {report.mitarbeiter_name && (
                              <p className="text-sm text-gray-500">
                                {t('reports:list.employee')} {report.mitarbeiter_name}
                              </p>
                            )}
                          </div>
                          <div className="ml-2 flex-shrink-0 flex items-center space-x-2">
                            <span className={`inline-flex px-2 py-1 text-xs font-semibold rounded-full ${
                              report.klassifizierung === 'A' ? 'bg-red-100 text-red-800' :
                              report.klassifizierung === 'B' ? 'bg-yellow-100 text-yellow-800' :
                              report.klassifizierung === 'C' ? 'bg-green-100 text-green-800' :
                              'bg-gray-100 text-gray-800'
                            }`}>
                              {report.klassifizierung}
                            </span>
                            {report.status && (
                              <span className={`inline-flex px-2 py-1 text-xs font-semibold rounded-full ${getStatusBadgeColor(report.status)}`}>
                                {getStatusText(report.status)}
                              </span>
                            )}
                            {report.neukunde && (
                              <span className="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-800">
                                {t('reports:list.newCustomerBadge')}
                              </span>
                            )}
                          </div>
                        </div>
                        <div className="mt-2 sm:flex sm:justify-between">
                          <div className="sm:flex sm:space-x-4">
                            <p className="flex items-center text-sm text-gray-500">
                              📅 {format(new Date(report.datum), 'dd.MM.yyyy', { locale: de })}
                            </p>
                            <p className="mt-2 flex items-center text-sm text-gray-500 sm:mt-0">
                              🌍 {report.region_name}
                            </p>
                          </div>
                          <div className="mt-2 flex items-center text-sm text-gray-500 sm:mt-0 space-x-4">
                            <span>
                              {t('reports:list.orderLabel')} {new Intl.NumberFormat(i18n.language === 'en' ? 'en-US' : 'de-DE', {
                                style: 'currency',
                                currency: 'EUR',
                              }).format(report.auftragswert || 0)}
                            </span>
                            <span>
                              {t('reports:list.offerLabel')} {new Intl.NumberFormat(i18n.language === 'en' ? 'en-US' : 'de-DE', {
                                style: 'currency',
                                currency: 'EUR',
                              }).format(report.angebotswert || 0)}
                            </span>
                          </div>
                        </div>
                        {/* Kurzbericht Preview */}
                        {report.kurzbericht && (
                          <div className="mt-2 text-sm text-gray-600">
                            <span className="font-medium">{t('reports:list.shortReportLabel')}</span>{' '}
                            {report.kurzbericht.length > 100 
                              ? `${report.kurzbericht.substring(0, 100)}...` 
                              : report.kurzbericht
                            }
                          </div>
                        )}
                      </div>
                      <div className="ml-4 flex-shrink-0 flex space-x-2">
                        <Link
                          to={`/reports/${report.id}/edit`}
                          className="text-indigo-600 hover:text-indigo-900 text-sm font-medium"
                        >
                          {t('reports:list.edit')}
                        </Link>
                        <button
                          onClick={() => handleDelete(report.id)}
                          className="text-red-600 hover:text-red-900 text-sm font-medium"
                        >
                          {t('reports:list.delete')}
                        </button>
                      </div>
                    </div>
                  </div>
                </li>
              ))}
            </ul>
          </div>

          {pagination && pagination.totalPages > 1 && (
            <div className="mt-6 flex items-center justify-between">
              <div className="flex-1 flex justify-between sm:hidden">
                <button
                  onClick={() => setCurrentPage(currentPage - 1)}
                  disabled={currentPage === 1}
                  className="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 disabled:bg-gray-100 disabled:text-gray-400"
                >
                  {t('reports:pagination.previous')}
                </button>
                <button
                  onClick={() => setCurrentPage(currentPage + 1)}
                  disabled={currentPage === pagination.totalPages}
                  className="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 disabled:bg-gray-100 disabled:text-gray-400"
                >
                  {t('reports:pagination.next')}
                </button>
              </div>
              <div className="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                <div>
                  <p className="text-sm text-gray-700">
                    {t('reports:pagination.showing')} <span className="font-medium">{((currentPage - 1) * pagination.limit) + 1}</span> {t('reports:pagination.to')}{' '}
                    <span className="font-medium">
                      {Math.min(currentPage * pagination.limit, pagination.total)}
                    </span>{' '}
                    {t('reports:pagination.of')} <span className="font-medium">{pagination.total}</span> {t('reports:pagination.reports')}
                  </p>
                </div>
                <div>
                  <nav className="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                    <button
                      onClick={() => setCurrentPage(currentPage - 1)}
                      disabled={currentPage === 1}
                      className="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50 disabled:bg-gray-100 disabled:text-gray-400"
                    >
                      {t('reports:pagination.previous')}
                    </button>
                    
                    {[...Array(Math.min(5, pagination.totalPages))].map((_, i) => {
                      const pageNum = i + 1;
                      return (
                        <button
                          key={pageNum}
                          onClick={() => setCurrentPage(pageNum)}
                          className={`relative inline-flex items-center px-4 py-2 border text-sm font-medium ${
                            pageNum === currentPage
                              ? 'z-10 bg-indigo-50 border-indigo-500 text-indigo-600'
                              : 'bg-white border-gray-300 text-gray-500 hover:bg-gray-50'
                          }`}
                        >
                          {pageNum}
                        </button>
                      );
                    })}
                    
                    <button
                      onClick={() => setCurrentPage(currentPage + 1)}
                      disabled={currentPage === pagination.totalPages}
                      className="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50 disabled:bg-gray-100 disabled:text-gray-400"
                    >
                      {t('reports:pagination.next')}
                    </button>
                  </nav>
                </div>
              </div>
            </div>
          )}
        </>
      ) : (
        <div className="text-center py-12 bg-white rounded-lg shadow">
          <div className="text-6xl mb-4">📋</div>
          <h3 className="text-lg font-medium text-gray-900 mb-2">
            {Object.values(filters).some(v => v !== '' && v !== 'datum' && v !== 'desc')
              ? t('reports:empty.noReportsFound')
              : t('reports:empty.noReportsYet')}
          </h3>
          <p className="text-gray-500 mb-6">
            {Object.values(filters).some(v => v !== '' && v !== 'datum' && v !== 'desc')
              ? t('reports:empty.adjustFilters')
              : t('reports:empty.createFirst')}
          </p>
          {!Object.values(filters).some(v => v !== '' && v !== 'datum' && v !== 'desc') && (
            <Link
              to="/reports/new"
              className="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700"
            >
              {t('reports:empty.createFirstButton')}
            </Link>
          )}
        </div>
      )}
    </div>
  );
};

export default Reports;