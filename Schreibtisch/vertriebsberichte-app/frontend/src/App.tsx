import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider } from './contexts/AuthContext';
import PrivateRoute from './components/PrivateRoute';
import Layout from './components/Layout';
import { AdminRoute, GlobalStatsRoute, AnalyticsRoute } from './components/RoleProtectedRoute';
import Login from './pages/Login';
import Dashboard from './pages/Dashboard';
import Reports from './pages/Reports';
import NewReport from './pages/NewReport';
import EditReport from './pages/EditReport';
import Statistics from './pages/Statistics';
import Analytics from './pages/Analytics';
import AdminDashboard from './pages/AdminDashboard';
import GlobalStatistics from './pages/GlobalStatistics';

function App() {
  return (
    <AuthProvider>
      <Router>
        <Routes>
          <Route path="/login" element={<Login />} />
          <Route path="/" element={<PrivateRoute><Layout /></PrivateRoute>}>
            <Route index element={<Navigate to="/dashboard" replace />} />
            <Route path="dashboard" element={<Dashboard />} />
            <Route path="reports" element={<Reports />} />
            <Route path="reports/new" element={<NewReport />} />
            <Route path="reports/:id/edit" element={<EditReport />} />
            <Route path="statistics" element={<Statistics />} />
            <Route path="statistics/global" element={
              <GlobalStatsRoute>
                <GlobalStatistics />
              </GlobalStatsRoute>
            } />
            <Route path="analytics" element={
              <AnalyticsRoute>
                <Analytics />
              </AnalyticsRoute>
            } />
            <Route path="admin/users" element={
              <AdminRoute>
                <AdminDashboard />
              </AdminRoute>
            } />
          </Route>
        </Routes>
      </Router>
    </AuthProvider>
  );
}

export default App;