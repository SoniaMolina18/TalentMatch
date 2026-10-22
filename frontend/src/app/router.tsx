import { Navigate, Outlet, createBrowserRouter } from 'react-router-dom'
import { useAuth } from '../features/auth/AuthContext'
import { LoginPage } from '../pages/LoginPage'
import { RegisterPage } from '../pages/RegisterPage'
import { DashboardPage } from '../pages/DashboardPage'
import { ProjectsPage } from '../pages/ProjectsPage'
import { ProjectDetailPage } from '../pages/ProjectDetailPage'
import { AppLayout } from '../components/AppLayout'
import { FigmaPage } from './FigmaPage'
import type { Role } from '../types/api'

function ProtectedRoute({ roles }: { roles?: Role[] }) {
  const { user } = useAuth()
  if (!user) return <Navigate to="/login" replace />
  if (roles && !roles.includes(user.rol)) return <Navigate to="/dashboard" replace />
  return <Outlet />
}

export const router = createBrowserRouter([
  { path: '/login', element: <LoginPage /> },
  { path: '/registro', element: <RegisterPage /> },
  {
    element: <ProtectedRoute />,
    children: [
      { element: <AppLayout />, children: [
        { path: '/', element: <Navigate to="/dashboard" replace /> },
        { path: '/dashboard', element: <DashboardPage /> },
        { path: '/proyectos', element: <ProjectsPage /> },
        { path: '/proyectos/:id', element: <ProjectDetailPage /> },
      ] },
      { path: '/perfil', element: <FigmaPage /> },
      { path: '/equipo', element: <FigmaPage /> },
      { path: '/solicitudes', element: <FigmaPage /> },
      { path: '/mensajes', element: <FigmaPage /> },
      { element: <ProtectedRoute roles={['Estudiante']} />, children: [
        { path: '/mis-proyectos', element: <FigmaPage /> },
        { path: '/proyectos/colaborativos/nuevo', element: <FigmaPage /> },
      ] },
      { element: <ProtectedRoute roles={['Estudiante', 'Profesor', 'Administrador']} />, children: [
        { path: '/talentos', element: <FigmaPage /> },
      ] },
      { element: <ProtectedRoute roles={['Profesor']} />, children: [
        { path: '/profesor', element: <FigmaPage /> },
        { path: '/profesor/proyectos/nuevo', element: <FigmaPage /> },
      ] },
      { element: <ProtectedRoute roles={['Administrador']} />, children: [
        { path: '/admin', element: <FigmaPage /> },
      ] },
    ],
  },
  { path: '*', element: <Navigate to="/dashboard" replace /> },
])
