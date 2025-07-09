import React, { useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';

interface AdvancedFiltersProps {
  onFiltersChange: (filters: FilterValues) => void;
  initialFilters?: Partial<FilterValues>;
}

export interface FilterValues {
  startDate: string;
  endDate: string;
  kundeNr: string;
  kundeName: string;
  mitarbeiterName: string;
  ort: string;
  klassifizierung: string;
  status: string;
  neukunde: string;
  minAuftragswert: string;
  maxAuftragswert: string;
  search: string;
  sortBy: string;
  sortOrder: string;
}

const AdvancedFilters: React.FC<AdvancedFiltersProps> = ({
  onFiltersChange,
  initialFilters = {}
}) => {
  const { t } = useTranslation(['reports', 'common', 'status']);
  const [isExpanded, setIsExpanded] = useState(false);
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
    sortOrder: 'desc',
    ...initialFilters
  });

  useEffect(() => {
    onFiltersChange(filters);
  }, [filters, onFiltersChange]);

  const handleFilterChange = (key: keyof FilterValues, value: string) => {
    setFilters(prev => ({
      ...prev,
      [key]: value
    }));
  };

  const resetFilters = () => {
    setFilters({
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
  };

  const hasActiveFilters = Object.values(filters).some(value => 
    value !== '' && value !== 'datum' && value !== 'desc'
  );

  return (
    <div className="bg-white shadow rounded-lg mb-6">
      {/* Header */}
      <div 
        className="px-6 py-4 border-b border-gray-200 cursor-pointer flex items-center justify-between"
        onClick={() => setIsExpanded(!isExpanded)}
      >
        <div className="flex items-center">
          <h2 className="text-lg font-medium text-gray-900">{t('reports:filters.title')}</h2>
          {hasActiveFilters && (
            <span className="ml-3 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
              {t('reports:filters.activeLabel')}
            </span>
          )}
        </div>
        <div className="flex items-center space-x-3">
          {hasActiveFilters && (
            <button
              onClick={(e) => {
                e.stopPropagation();
                resetFilters();
              }}
              className="text-sm text-gray-500 hover:text-gray-700"
            >
              {t('reports:filters.reset')}
            </button>
          )}
          <span className="text-gray-400 text-lg">
            {isExpanded ? '▲' : '▼'}
          </span>
        </div>
      </div>

      {/* Filter Content */}
      {isExpanded && (
        <div className="p-6 space-y-6">
          {/* Quick Search */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              {t('reports:filters.search.label')}
            </label>
            <input
              type="text"
              value={filters.search}
              onChange={(e) => handleFilterChange('search', e.target.value)}
              placeholder={t('reports:filters.search.placeholder')}
              className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>

          {/* Date Range */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                {t('reports:filters.dates.fromDate')}
              </label>
              <input
                type="date"
                value={filters.startDate}
                onChange={(e) => handleFilterChange('startDate', e.target.value)}
                className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                {t('reports:filters.dates.toDate')}
              </label>
              <input
                type="date"
                value={filters.endDate}
                onChange={(e) => handleFilterChange('endDate', e.target.value)}
                className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
          </div>

          {/* Customer & Employee Filters */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                {t('reports:filters.customer.number')}
              </label>
              <input
                type="text"
                value={filters.kundeNr}
                onChange={(e) => handleFilterChange('kundeNr', e.target.value)}
                placeholder={t('reports:filters.customer.numberPlaceholder')}
                className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                {t('reports:filters.customer.name')}
              </label>
              <input
                type="text"
                value={filters.kundeName}
                onChange={(e) => handleFilterChange('kundeName', e.target.value)}
                placeholder={t('reports:filters.customer.namePlaceholder')}
                className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                {t('reports:filters.employee.name')}
              </label>
              <input
                type="text"
                value={filters.mitarbeiterName}
                onChange={(e) => handleFilterChange('mitarbeiterName', e.target.value)}
                placeholder={t('reports:filters.employee.placeholder')}
                className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
          </div>

          {/* Location & Classification */}
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                {t('reports:filters.location.label')}
              </label>
              <input
                type="text"
                value={filters.ort}
                onChange={(e) => handleFilterChange('ort', e.target.value)}
                placeholder={t('reports:filters.location.placeholder')}
                className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                {t('reports:filters.classification.label')}
              </label>
              <select
                value={filters.klassifizierung}
                onChange={(e) => handleFilterChange('klassifizierung', e.target.value)}
                className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                <option value="">{t('reports:filters.classification.all')}</option>
                <option value="A">{t('reports:filters.classification.premium')}</option>
                <option value="B">{t('reports:filters.classification.standard')}</option>
                <option value="C">{t('reports:filters.classification.basic')}</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                {t('reports:filters.status.label')}
              </label>
              <select
                value={filters.status}
                onChange={(e) => handleFilterChange('status', e.target.value)}
                className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                <option value="">{t('status:processStatus.all')}</option>
                <option value="B">{t('status:processStatus.B')}</option>
                <option value="U">{t('status:processStatus.U')}</option>
                <option value="K">{t('status:processStatus.K')}</option>
                <option value="O">{t('status:processStatus.O')}</option>
                <option value="V">{t('status:processStatus.V')}</option>
                <option value="I">{t('status:processStatus.I')}</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                {t('reports:filters.newCustomer.label')}
              </label>
              <select
                value={filters.neukunde}
                onChange={(e) => handleFilterChange('neukunde', e.target.value)}
                className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                <option value="">{t('reports:filters.newCustomer.all')}</option>
                <option value="true">{t('reports:filters.newCustomer.onlyNew')}</option>
                <option value="false">{t('reports:filters.newCustomer.onlyExisting')}</option>
              </select>
            </div>
          </div>

          {/* Value Range */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                {t('reports:filters.orderValue.min')}
              </label>
              <input
                type="number"
                value={filters.minAuftragswert}
                onChange={(e) => handleFilterChange('minAuftragswert', e.target.value)}
                placeholder={t('reports:filters.orderValue.minPlaceholder')}
                min="0"
                step="100"
                className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                {t('reports:filters.orderValue.max')}
              </label>
              <input
                type="number"
                value={filters.maxAuftragswert}
                onChange={(e) => handleFilterChange('maxAuftragswert', e.target.value)}
                placeholder={t('reports:filters.orderValue.maxPlaceholder')}
                min="0"
                step="100"
                className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
          </div>

          {/* Sorting */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                {t('reports:filters.sorting.sortBy')}
              </label>
              <select
                value={filters.sortBy}
                onChange={(e) => handleFilterChange('sortBy', e.target.value)}
                className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                <option value="datum">{t('reports:filters.sorting.fields.date')}</option>
                <option value="kunde_name">{t('reports:filters.sorting.fields.customerName')}</option>
                <option value="mitarbeiter_name">{t('reports:filters.sorting.fields.employeeName')}</option>
                <option value="ort">{t('reports:filters.sorting.fields.location')}</option>
                <option value="klassifizierung">{t('reports:filters.sorting.fields.classification')}</option>
                <option value="auftragswert">{t('reports:filters.sorting.fields.orderValue')}</option>
                <option value="angebotswert">{t('reports:filters.sorting.fields.offerValue')}</option>
                <option value="status">{t('reports:filters.sorting.fields.status')}</option>
                <option value="created_at">{t('reports:filters.sorting.fields.createdAt')}</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                {t('reports:filters.sorting.sortOrder')}
              </label>
              <select
                value={filters.sortOrder}
                onChange={(e) => handleFilterChange('sortOrder', e.target.value)}
                className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                <option value="desc">{t('reports:filters.sorting.directions.desc')}</option>
                <option value="asc">{t('reports:filters.sorting.directions.asc')}</option>
              </select>
            </div>
          </div>

          {/* Action Buttons */}
          <div className="flex justify-between items-center pt-4 border-t border-gray-200">
            <div className="text-sm text-gray-500">
              {hasActiveFilters && (
                <span>{t('reports:filters.activeMessage')}</span>
              )}
            </div>
            <div className="flex space-x-3">
              <button
                onClick={resetFilters}
                className="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50"
              >
                {t('reports:filters.resetAll')}
              </button>
              <button
                onClick={() => setIsExpanded(false)}
                className="px-4 py-2 bg-blue-600 text-white rounded-md text-sm font-medium hover:bg-blue-700"
              >
                {t('reports:filters.close')}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default AdvancedFilters;