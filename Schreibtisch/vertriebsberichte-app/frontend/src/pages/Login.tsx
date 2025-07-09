import { useState } from 'react';
import { useNavigate, Navigate } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { useAuth } from '../contexts/AuthContext';
import { useTranslation } from 'react-i18next';

const createLoginSchema = (t: any) => z.object({
  email: z.string().email(t('auth:validation.emailInvalid')),
  password: z.string().min(1, t('auth:validation.passwordRequired')),
});

const createRegisterSchema = (t: any) => z.object({
  name: z.string().min(2, t('auth:validation.nameMinLength')),
  email: z.string().email(t('auth:validation.emailInvalid')),
  password: z.string().min(6, t('auth:validation.passwordMinLength')),
  region: z.string().min(1, t('auth:validation.regionRequired')),
});

type LoginFormData = {
  email: string;
  password: string;
};
type RegisterFormData = {
  name: string;
  email: string;
  password: string;
  region: string;
};

const Login = () => {
  const [isRegister, setIsRegister] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const navigate = useNavigate();
  const { login, register: registerUser, user } = useAuth();
  const { t } = useTranslation(['auth', 'common']);

  const loginForm = useForm<LoginFormData>({
    resolver: zodResolver(createLoginSchema(t)),
  });

  const registerForm = useForm<RegisterFormData>({
    resolver: zodResolver(createRegisterSchema(t)),
  });

  if (user) {
    return <Navigate to="/dashboard" replace />;
  }

  const onLoginSubmit = async (data: LoginFormData) => {
    try {
      setError(null);
      await login(data.email, data.password);
      navigate('/dashboard');
    } catch (err: any) {
      setError(err.response?.data?.message || t('auth:errors.loginFailed'));
    }
  };

  const onRegisterSubmit = async (data: RegisterFormData) => {
    try {
      setError(null);
      await registerUser(data.name, data.email, data.password, data.region);
      navigate('/dashboard');
    } catch (err: any) {
      setError(err.response?.data?.message || t('auth:errors.registerFailed'));
    }
  };

  const regions = [
    { code: 'BENE', name: 'Benelux' },
    { code: 'DACHL', name: 'DACH & Länder' },
    { code: 'EUEAST', name: 'EU East' },
    { code: 'EUSOUTH', name: 'EU South' },
    { code: 'IBERIA', name: 'Iberia' },
    { code: 'ROW', name: 'Rest of World' },
    { code: 'TCG', name: 'TCG' },
    { code: 'UK', name: 'United Kingdom' },
  ];

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-md w-full space-y-8">
        <div>
          <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
            {isRegister ? t('auth:register.title') : t('auth:login.title')}
          </h2>
        </div>
        
        {error && (
          <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded">
            {error}
          </div>
        )}

        {!isRegister ? (
          <form className="mt-8 space-y-6" onSubmit={loginForm.handleSubmit(onLoginSubmit)}>
            <div className="rounded-md shadow-sm -space-y-px">
              <div>
                <label htmlFor="email" className="sr-only">
                  {t('auth:labels.email')}
                </label>
                <input
                  {...loginForm.register('email')}
                  type="email"
                  autoComplete="email"
                  className="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-t-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
                  placeholder={t('auth:placeholders.email')}
                />
                {loginForm.formState.errors.email && (
                  <p className="mt-1 text-sm text-red-600">{loginForm.formState.errors.email.message}</p>
                )}
              </div>
              <div>
                <label htmlFor="password" className="sr-only">
                  {t('auth:labels.password')}
                </label>
                <input
                  {...loginForm.register('password')}
                  type="password"
                  autoComplete="current-password"
                  className="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-b-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
                  placeholder={t('auth:placeholders.password')}
                />
                {loginForm.formState.errors.password && (
                  <p className="mt-1 text-sm text-red-600">{loginForm.formState.errors.password.message}</p>
                )}
              </div>
            </div>

            <div>
              <button
                type="submit"
                className="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
              >
                {t('auth:login.button')}
              </button>
            </div>
          </form>
        ) : (
          <form className="mt-8 space-y-6" onSubmit={registerForm.handleSubmit(onRegisterSubmit)}>
            <div className="space-y-4">
              <div>
                <label htmlFor="name" className="block text-sm font-medium text-gray-700">
                  {t('auth:labels.name')}
                </label>
                <input
                  {...registerForm.register('name')}
                  type="text"
                  className="mt-1 appearance-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
                  placeholder={t('auth:placeholders.name')}
                />
                {registerForm.formState.errors.name && (
                  <p className="mt-1 text-sm text-red-600">{registerForm.formState.errors.name.message}</p>
                )}
              </div>

              <div>
                <label htmlFor="email" className="block text-sm font-medium text-gray-700">
                  {t('auth:labels.email')}
                </label>
                <input
                  {...registerForm.register('email')}
                  type="email"
                  autoComplete="email"
                  className="mt-1 appearance-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
                  placeholder={t('auth:placeholders.email')}
                />
                {registerForm.formState.errors.email && (
                  <p className="mt-1 text-sm text-red-600">{registerForm.formState.errors.email.message}</p>
                )}
              </div>

              <div>
                <label htmlFor="password" className="block text-sm font-medium text-gray-700">
                  {t('auth:labels.password')}
                </label>
                <input
                  {...registerForm.register('password')}
                  type="password"
                  autoComplete="new-password"
                  className="mt-1 appearance-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
                  placeholder={t('auth:placeholders.password')}
                />
                {registerForm.formState.errors.password && (
                  <p className="mt-1 text-sm text-red-600">{registerForm.formState.errors.password.message}</p>
                )}
              </div>

              <div>
                <label htmlFor="region" className="block text-sm font-medium text-gray-700">
                  {t('auth:labels.region')}
                </label>
                <select
                  {...registerForm.register('region')}
                  className="mt-1 block w-full pl-3 pr-10 py-2 text-base border border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md"
                >
                  <option value="">{t('auth:placeholders.selectRegion')}</option>
                  {regions.map((region) => (
                    <option key={region.code} value={region.code}>
                      {region.name}
                    </option>
                  ))}
                </select>
                {registerForm.formState.errors.region && (
                  <p className="mt-1 text-sm text-red-600">{registerForm.formState.errors.region.message}</p>
                )}
              </div>
            </div>

            <div>
              <button
                type="submit"
                className="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
              >
                {t('auth:register.button')}
              </button>
            </div>
          </form>
        )}

        <div className="text-center">
          <button
            type="button"
            onClick={() => setIsRegister(!isRegister)}
            className="font-medium text-indigo-600 hover:text-indigo-500"
          >
            {isRegister
              ? t('auth:links.switchToLogin')
              : t('auth:links.switchToRegister')}
          </button>
        </div>
      </div>
    </div>
  );
};

export default Login;