import { Outlet, useLocation, useNavigate } from 'react-router-dom'
import { useAuth } from '../features/auth/AuthContext'
import FigmaLayout from '../figma/components/Layout'
import type { Page } from '../figma/types'

function currentPage(pathname: string): Page {
  if (pathname.startsWith('/proyectos')) return pathname === '/proyectos' ? 'explore' : 'project-detail'
  if (pathname.startsWith('/perfil')) return 'student-profile'
  if (pathname.startsWith('/solicitudes')) return 'requests'
  if (pathname.startsWith('/equipo')) return 'my-team'
  if (pathname.startsWith('/mensajes')) return 'messages'
  if (pathname.startsWith('/profesor')) return pathname.includes('/nuevo') ? 'create-project' : 'teacher-panel'
  if (pathname.startsWith('/admin')) return 'admin-panel'
  return 'dashboard'
}

export function AppLayout() {
  const { logout } = useAuth()
  const navigate = useNavigate()
  const location = useLocation()

  const onNavigate = (page: Page) => {
    const routes: Record<Page, string> = {
      dashboard: '/dashboard', login: '/login', register: '/registro', explore: '/proyectos',
      'project-detail': '/proyectos', 'student-profile': '/perfil', 'find-talents': '/talentos',
      'my-team': '/equipo', requests: '/solicitudes', messages: '/mensajes',
      'teacher-panel': '/profesor', 'create-project': '/profesor/proyectos/nuevo', 'admin-panel': '/admin',
      'my-projects': '/mis-proyectos', 'create-collaborative-project': '/proyectos/colaborativos/nuevo',
    }
    navigate(routes[page])
  }

  return <FigmaLayout currentPage={currentPage(location.pathname)} onNavigate={onNavigate} onLogout={() => { logout(); navigate('/login') }}>
    <Outlet />
  </FigmaLayout>
}
