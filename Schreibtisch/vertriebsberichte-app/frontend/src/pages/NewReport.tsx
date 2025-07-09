import { useNavigate } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import axios from 'axios';
import { useState } from 'react';
import { useTranslation } from 'react-i18next';

const createReportSchema = (t: any) => z.object({
  kundeNr: z.string().min(1, t('reports:validation.customerNumberRequired')),
  kundeName: z.string().min(1, t('reports:validation.customerNameRequired')),
  ansprechpartner: z.string().min(1, t('reports:validation.contactPersonRequired')),
  ort: z.string().min(1, t('reports:validation.locationRequired')),
  datum: z.string().regex(/^\d{4}-\d{2}-\d{2}$/, t('reports:validation.invalidDateFormat')),
  kurzbericht: z.string().min(10, t('reports:validation.shortReportMinLength')),
  todos: z.string().min(1, t('reports:validation.todosRequired')),
  klassifizierung: z.enum(['A', 'B', 'C']),
  auftragswert: z.string().transform((val) => val ? parseFloat(val) : undefined).optional(),
  angebotswert: z.string().transform((val) => val ? parseFloat(val) : undefined).optional(),
  naechsterBesuch: z.string().transform((val) => val ? parseInt(val) : undefined).optional(),
  neukunde: z.boolean(),
  uebernachtung: z.boolean(),
  status: z.enum(['B', 'U', 'K']).optional(),
});

const NewReport = () => {
  const navigate = useNavigate();
  const { t } = useTranslation(['reports', 'common', 'status']);
  const [error, setError] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const reportSchema = createReportSchema(t);
  type ReportFormData = z.infer<typeof reportSchema>;

  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<ReportFormData>({
    resolver: zodResolver(reportSchema),
    defaultValues: {
      datum: new Date().toISOString().split('T')[0],
      klassifizierung: 'B',
      neukunde: false,
      uebernachtung: false,
    },
  });

  const onSubmit = async (data: ReportFormData) => {
    try {
      setError(null);
      setIsSubmitting(true);
      
      const submitData = {
        ...data,
        auftragswert: data.auftragswert || 0,
        angebotswert: data.angebotswert || 0,
        naechsterBesuch: data.naechsterBesuch || undefined,
      };

      await axios.post('/api/reports', submitData);
      navigate('/reports');
    } catch (err: any) {
      setError(err.response?.data?.message || t('reports:messages.saveError'));
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="max-w-4xl mx-auto">
      <h1 className="text-2xl font-bold text-gray-900 mb-6">{t('reports:title.new')}</h1>

      {error && (
        <div className="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded">
          {error}
        </div>
      )}

      <form onSubmit={handleSubmit(onSubmit)} className="space-y-6 bg-white shadow px-6 py-6 rounded-lg">
        <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
          <div>
            <label className="block text-sm font-medium text-gray-700">
              {t('reports:fields.customerNumber')}
            </label>
            <input
              {...register('kundeNr')}
              type="text"
              className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            />
            {errors.kundeNr && (
              <p className="mt-1 text-sm text-red-600">{errors.kundeNr.message}</p>
            )}
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">
              {t('reports:fields.customerName')}
            </label>
            <input
              {...register('kundeName')}
              type="text"
              className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            />
            {errors.kundeName && (
              <p className="mt-1 text-sm text-red-600">{errors.kundeName.message}</p>
            )}
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">
              {t('reports:fields.contactPerson')}
            </label>
            <input
              {...register('ansprechpartner')}
              type="text"
              className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            />
            {errors.ansprechpartner && (
              <p className="mt-1 text-sm text-red-600">{errors.ansprechpartner.message}</p>
            )}
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">
              {t('reports:fields.location')}
            </label>
            <input
              {...register('ort')}
              type="text"
              className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            />
            {errors.ort && (
              <p className="mt-1 text-sm text-red-600">{errors.ort.message}</p>
            )}
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">
              {t('reports:fields.date')}
            </label>
            <input
              {...register('datum')}
              type="date"
              className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            />
            {errors.datum && (
              <p className="mt-1 text-sm text-red-600">{errors.datum.message}</p>
            )}
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">
              {t('reports:fields.classification')}
            </label>
            <select
              {...register('klassifizierung')}
              className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            >
              <option value="A">{t('common:classification.A')}</option>
              <option value="B">{t('common:classification.B')}</option>
              <option value="C">{t('common:classification.C')}</option>
            </select>
          </div>
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700">
            {t('reports:fields.shortReport')}
          </label>
          <textarea
            {...register('kurzbericht')}
            rows={4}
            className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
          />
          {errors.kurzbericht && (
            <p className="mt-1 text-sm text-red-600">{errors.kurzbericht.message}</p>
          )}
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700">
            {t('reports:fields.todos')} *
          </label>
          <textarea
            {...register('todos')}
            rows={3}
            className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
          />
          {errors.todos && (
            <p className="mt-1 text-sm text-red-600">{errors.todos.message}</p>
          )}
        </div>

        <div className="grid grid-cols-1 gap-6 md:grid-cols-3">
          <div>
            <label className="block text-sm font-medium text-gray-700">
              {t('reports:fields.orderValue')}
            </label>
            <input
              {...register('auftragswert')}
              type="number"
              step="0.01"
              min="0"
              className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">
              {t('reports:fields.offerValue')}
            </label>
            <input
              {...register('angebotswert')}
              type="number"
              step="0.01"
              min="0"
              className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">
              {t('reports:fields.nextVisit')}
            </label>
            <input
              {...register('naechsterBesuch')}
              type="number"
              min="1"
              max="52"
              className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            />
          </div>
        </div>

        <div className="grid grid-cols-1 gap-6 md:grid-cols-3">
          <div className="flex items-center">
            <input
              {...register('neukunde')}
              type="checkbox"
              className="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded"
            />
            <label className="ml-2 block text-sm text-gray-900">
              {t('reports:fields.newCustomer')}
            </label>
          </div>

          <div className="flex items-center">
            <input
              {...register('uebernachtung')}
              type="checkbox"
              className="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded"
            />
            <label className="ml-2 block text-sm text-gray-900">
              {t('reports:fields.overnight')}
            </label>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">
              {t('status:absenceReason.label')}
              <span className="text-xs text-gray-500 ml-2">({t('status:absenceReason.note')})</span>
            </label>
            <select
              {...register('status')}
              className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            >
              <option value="">{t('status:absenceReason.none')}</option>
              <option value="B">{t('status:absenceReason.B')}</option>
              <option value="U">{t('status:absenceReason.U')}</option>
              <option value="K">{t('status:absenceReason.K')}</option>
            </select>
          </div>
        </div>

        <div className="flex justify-end space-x-3">
          <button
            type="button"
            onClick={() => navigate('/reports')}
            className="px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
          >
            {t('common:buttons.cancel')}
          </button>
          <button
            type="submit"
            disabled={isSubmitting}
            className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 disabled:bg-gray-400"
          >
            {isSubmitting ? t('common:buttons.loading') : t('common:buttons.save')}
          </button>
        </div>
      </form>
    </div>
  );
};

export default NewReport;