import { useLocation, useNavigate } from 'react-router-dom'
import AdminPanel from '../figma/pages/AdminPanel'
import CreateProject from '../figma/pages/CreateProject'
import CreateCollaborativeProject from '../figma/pages/CreateCollaborativeProject'
import FindTalents from '../figma/pages/FindTalents'
import Messages from '../figma/pages/Messages'
import MyTeam from '../figma/pages/MyTeam'
import MyProjects from '../figma/pages/MyProjects'
import Requests from '../figma/pages/Requests'
import StudentProfile from '../figma/pages/StudentProfile'
import TeacherPanel from '../figma/pages/TeacherPanel'
import type { Page } from '../figma/types'

export function FigmaPage() {
  const location = useLocation()
  const navigate = useNavigate()
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
  if (location.pathname === '/perfil') return <StudentProfile onNavigate={onNavigate} />
  if (location.pathname === '/equipo') return <MyTeam onNavigate={onNavigate} />
	if (location.pathname === '/mis-proyectos') return <MyProjects onNavigate={onNavigate} />
  if (location.pathname === '/proyectos/colaborativos/nuevo') return <CreateCollaborativeProject onNavigate={onNavigate} />
  if (location.pathname === '/solicitudes') return <Requests onNavigate={onNavigate} />
  if (location.pathname === '/mensajes') return <Messages onNavigate={onNavigate} />
  if (location.pathname === '/talentos') return <FindTalents onNavigate={onNavigate} />
  if (location.pathname === '/profesor/proyectos/nuevo') return <CreateProject onNavigate={onNavigate} />
  if (location.pathname === '/profesor') return <TeacherPanel onNavigate={onNavigate} />
  if (location.pathname === '/admin') return <AdminPanel onNavigate={onNavigate} />
	return <main className="min-h-screen bg-[#F7FAF8] p-8"><div className="max-w-2xl mx-auto rounded-2xl bg-white border border-[#E5EDE8] p-8"><h1 className="text-xl font-bold text-gray-900">Pantalla no disponible</h1><p className="mt-2 text-sm text-gray-500">La ruta solicitada no está integrada con una pantalla válida.</p><button onClick={() => navigate('/dashboard')} className="mt-5 rounded-xl bg-brand-dark px-4 py-2 text-sm font-semibold text-white">Volver al inicio</button></div></main>
}
