const API_BASE_URL = ((import.meta.env.VITE_API_BASE_URL as string | undefined) ?? '/api/v1').replace(/\/$/, '')

export class ApiError extends Error {
  constructor(public readonly status: number, message: string) {
	super(message)
	this.name = 'ApiError'
  }
}

function getMessage(body: unknown, fallback: string): string {
  if (typeof body === 'string' && body.trim()) return body
	if (body && typeof body === 'object' && 'detail' in body && typeof body.detail === 'string' && body.detail.trim()) {
	return body.detail
  }
  if (body && typeof body === 'object' && 'message' in body && typeof body.message === 'string' && body.message.trim()) {
	return body.message
  }
	if (body && typeof body === 'object' && 'errors' in body && body.errors && typeof body.errors === 'object') {
	const messages = Object.values(body.errors).flatMap(value => Array.isArray(value) ? value : [value]).filter((value): value is string => typeof value === 'string' && value.trim().length > 0)
	if (messages.length) return messages.join(' ')
	}
  return fallback
}

export async function apiRequest<T>(path: string, options: RequestInit = {}): Promise<T> {
  const token = sessionStorage.getItem('talentmatch.token')
  const headers = new Headers(options.headers)
  headers.set('Accept', 'application/json')
  if (options.body && !headers.has('Content-Type')) headers.set('Content-Type', 'application/json')
  if (token) headers.set('Authorization', `Bearer ${token}`)

  const response = await fetch(`${API_BASE_URL}${path}`, { ...options, headers })
  const text = await response.text()
  let body: unknown = undefined
  if (text) {
	try { body = JSON.parse(text) } catch { body = text }
  }
  if (!response.ok) {
	const isLoginRequest = path === '/Auth/login'
	const fallback = response.status === 400 ? 'La solicitud no es válida.'
	  : response.status === 401 ? (isLoginRequest ? 'Las credenciales no son válidas.' : 'La sesión no es válida o ha caducado.')
	  : response.status === 403 ? 'No tienes permisos para realizar esta acción.'
	  : response.status >= 500 ? 'El servidor no está disponible.'
	  : 'No se pudo completar la solicitud.'
	throw new ApiError(response.status, getMessage(body, fallback))
  }
  return body as T
}

export const api = {
  login: (data: object) => apiRequest<import('../types/api').AuthResponse>('/Auth/login', { method: 'POST', body: JSON.stringify(data) }),
  registerStudent: (data: object) => apiRequest<void>('/Usuarios', { method: 'POST', body: JSON.stringify(data) }),
  projects: () => apiRequest<import('../types/api').Project[]>('/Proyectos'),
  project: (id: number) => apiRequest<import('../types/api').Project>(`/Proyectos/${id}`),
  createApplication: (data: import('../types/api').CreateApplicationRequest) =>
	apiRequest<import('../types/api').Application>('/Postulaciones', {
	  method: 'POST',
	  body: JSON.stringify(data),
	}),
  users: () => apiRequest<import('../types/api').UserSummary[]>('/Usuarios'),
	searchStudents: (params: URLSearchParams) => apiRequest<import('../types/api').TalentSearchResponse>(`/Usuarios/estudiantes/busqueda?${params.toString()}`),
  createAdministrativeUser: (data: import('../types/api').CreateAdministrativeUserRequest) =>
	apiRequest<import('../types/api').UserSummary>('/Usuarios/administrativo', { method: 'POST', body: JSON.stringify(data) }),
	updateUser: (id: number, data: import('../types/api').UpdateUserRequest) => apiRequest<import('../types/api').UserSummary>(`/Usuarios/${id}`, { method: 'PUT', body: JSON.stringify(data) }),
	assignProfessor: (id: number) => apiRequest<import('../types/api').UserSummary>(`/Usuarios/${id}/rol-profesor`, { method: 'PUT' }),
  profile: (userId: number) => apiRequest<import('../types/api').Profile>(`/Perfiles/${userId}`),
	updateProfile: (userId: number, data: import('../types/api').UpdateProfileRequest) => apiRequest<import('../types/api').Profile>(`/Perfiles/${userId}`, { method: 'PUT', body: JSON.stringify({ usuarioId: userId, ...data }) }),
  createProject: (data: import('../types/api').CreateProjectRequest) => apiRequest<import('../types/api').Project>('/Proyectos', { method: 'POST', body: JSON.stringify(data) }),
  createCollaborativeProject: (data: import('../types/api').CreateCollaborativeProjectRequest) => apiRequest<import('../types/api').CollaborativeProject>('/Proyectos/colaborativos', { method: 'POST', body: JSON.stringify(data) }),
  myCollaborativeProjects: () => apiRequest<import('../types/api').CollaborativeProject[]>('/Proyectos/colaborativos/mios'),
  recommendationsByProject: (projectId: number) => apiRequest<import('../types/api').TalentRecommendation[]>(`/Recomendaciones/proyectos/${projectId}`),
  skills: () => apiRequest<import('../types/api').Skill[]>('/Habilidades'),
  interests: () => apiRequest<import('../types/api').Interest[]>('/Intereses'),
	updateProject: (id: number, data: import('../types/api').UpdateProjectRequest) => apiRequest<import('../types/api').Project>(`/Proyectos/${id}`, { method: 'PUT', body: JSON.stringify(data) }),
  deleteProject: (id: number) => apiRequest<void>(`/Proyectos/${id}`, { method: 'DELETE' }),
  applicationsByProject: (projectId: number) => apiRequest<import('../types/api').Application[]>(`/Postulaciones/proyecto/${projectId}`),
	myApplications: () => apiRequest<import('../types/api').Application[]>('/Postulaciones/mias'),
  acceptApplication: (id: number) => apiRequest<import('../types/api').Application>(`/Postulaciones/${id}/aceptar`, { method: 'PUT' }),
  rejectApplication: (id: number) => apiRequest<import('../types/api').Application>(`/Postulaciones/${id}/rechazar`, { method: 'PUT' }),
  team: (id: number) => apiRequest<import('../types/api').Team>(`/Equipos/${id}`),
	myTeams: () => apiRequest<import('../types/api').Team[]>('/Equipos/mios'),
  createTeam: (data: import('../types/api').CreateTeamRequest) => apiRequest<import('../types/api').Team>('/Equipos', { method: 'POST', body: JSON.stringify(data) }),
  addTeamMember: (teamId: number, studentId: number) => apiRequest<import('../types/api').Team>(`/Equipos/${teamId}/miembros/${studentId}`, { method: 'POST' }),
  assignTeamLeader: (teamId: number, studentId: number) => apiRequest<import('../types/api').Team>(`/Equipos/${teamId}/lider`, { method: 'PUT', body: JSON.stringify({ estudianteId: studentId }) }),
	receivedTeamInvitations: () => apiRequest<import('../types/api').TeamInvitation[]>('/InvitacionesEquipo/recibidas'),
  sentTeamInvitations: () => apiRequest<import('../types/api').TeamInvitation[]>('/InvitacionesEquipo/enviadas'),
  createTeamInvitation: (data: import('../types/api').CreateTeamInvitationRequest) => apiRequest<import('../types/api').TeamInvitation>('/InvitacionesEquipo', { method: 'POST', body: JSON.stringify(data) }),
  acceptTeamInvitation: (id: number) => apiRequest<import('../types/api').TeamInvitation>(`/InvitacionesEquipo/${id}/aceptar`, { method: 'PUT' }),
  rejectTeamInvitation: (id: number) => apiRequest<import('../types/api').TeamInvitation>(`/InvitacionesEquipo/${id}/rechazar`, { method: 'PUT' }),
  cancelTeamInvitation: (id: number) => apiRequest<import('../types/api').TeamInvitation>(`/InvitacionesEquipo/${id}/cancelar`, { method: 'PUT' }),
  notifications: (userId: number) => apiRequest<import('../types/api').Notification[]>(`/Notificaciones/usuario/${userId}`),
	myNotifications: () => apiRequest<import('../types/api').Notification[]>('/Notificaciones/mias'),
  markNotificationRead: (id: number) => apiRequest<import('../types/api').Notification>(`/Notificaciones/${id}/leer`, { method: 'PUT' }),
  conversations: () => apiRequest<import('../types/api').Conversation[]>('/Mensajes/conversaciones'),
  createConversation: (usuarioId: number) => apiRequest<import('../types/api').Conversation>('/Mensajes/conversaciones', { method: 'POST', body: JSON.stringify({ usuarioId }) }),
  sendMessage: (conversationId: number, contenido: string) => apiRequest<import('../types/api').Message>(`/Mensajes/conversaciones/${conversationId}/mensajes`, { method: 'POST', body: JSON.stringify({ contenido }) }),
  markConversationRead: (conversationId: number) => apiRequest<void>(`/Mensajes/conversaciones/${conversationId}/leidos`, { method: 'PUT' }),
}
