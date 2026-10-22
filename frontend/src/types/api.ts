export type Role = 'Administrador' | 'Profesor' | 'Estudiante'

export interface PublicUser {
  id: number
  nombre: string
  apellido: string
  correo: string
  rol: Role
}

export interface Message {
  id: number
  remitenteId: number
  remitenteNombre: string
  contenido: string
  fechaEnvio: string
  leido: boolean
}

export interface Conversation {
  id: number
  otroUsuarioId: number
  otroNombre: string
  otroApellido: string
  fechaCreacion: string
  mensajes: Message[]
}

export interface TalentStudent {
  estudianteId: number
  usuarioId: number
  nombre: string
  apellido: string
  carrera: string
  semestre: number
  descripcion?: string | null
  disponibilidad?: string | null
  habilidades: string[]
  intereses: string[]
}

export interface TalentSearchResponse {
  items: TalentStudent[]
  page: number
  pageSize: number
  total: number
}

export interface UpdateProjectRequest {
  titulo: string
  descripcion: string
  fechaLimite: string
  cuposDisponibles: number
}

export interface UserSummary extends PublicUser {
  activo: boolean
  fechaRegistro: string
}

export interface UpdateUserRequest {
  nombre: string
  apellido: string
  correo: string
}

export interface CreateAdministrativeUserRequest {
  nombre: string
  apellido: string
  correo: string
  password: string
  rol: 'Estudiante' | 'Profesor'
}

export interface Profile {
  id: number
  usuarioId: number
  descripcion?: string | null
  disponibilidad?: string | null
  fotoPerfil?: string | null
}

export interface UpdateProfileRequest {
  descripcion?: string
  disponibilidad?: string
  fotoPerfil?: string
}

export interface CreateProjectRequest {
  titulo: string
  descripcion: string
  fechaLimite: string
  cuposDisponibles: number
}

export interface Notification {
  id: number
  usuarioId: number
  mensaje?: string | null
  leida?: boolean
  fechaCreacion?: string
  titulo?: string
  tipo?: string
}

export interface Team {
  id: number
  nombre: string
  proyectoId: number
	liderUsuarioId?: number | null
  estado: number | string
  fechaCreacion: string
  proyecto?: TeamProject | null
  miembros?: TeamMember[]
}

export interface TeamProject {
  id: number
  titulo: string
  descripcion: string
  fechaLimite?: string | null
  profesorId?: number | null
  cuposDisponibles: number
}

export interface TeamMember {
  estudianteId: number
  usuarioId: number
  nombre: string
  apellido: string
  fechaIngreso: string
}

export interface CreateTeamRequest {
  nombre: string
  proyectoId: number
}

export interface TeamInvitation {
  id: number
  equipoId: number
  equipo: string
  proyectoId: number
  proyecto: string
  remitenteUsuarioId: number
  remitente: string
  destinatarioUsuarioId: number
  destinatario: string
  mensaje?: string | null
  estado: number | string
  fechaCreacion: string
  fechaRespuesta?: string | null
}

export interface CreateTeamInvitationRequest {
  equipoId: number
  destinatarioUsuarioId: number
  mensaje?: string
}

export interface AuthResponse {
  token: string
  usuario: PublicUser
}

export interface LoginRequest {
  correo: string
  password: string
}

export interface RegisterStudentRequest {
  nombre: string
  apellido: string
  correo: string
  password: string
  rol: 'Estudiante'
}

export interface CreateApplicationRequest {
  estudianteId: number
  proyectoId: number
  mensaje?: string
}

export interface Application {
  id: number
  estudianteId: number
	estudianteNombre?: string
  estudianteApellido?: string
  estudianteCarrera?: string | null
  estudianteSemestre?: number | null
  proyectoId: number
  mensaje?: string | null
	estado?: number | string
  fechaPostulacion?: string
  proyecto?: ApplicationProject | null
}

export interface ApplicationProject {
  id: number
  titulo: string
  descripcion: string
  fechaLimite: string
}

export function applicationStatusLabel(status: Application['estado']): string {
  if (typeof status === 'number') return ({ 1: 'Pendiente', 2: 'Aceptada', 3: 'Rechazada' } as Record<number, string>)[status] ?? 'Desconocida'
  return status ?? 'Pendiente'
}

export interface Project {
  id: number
  titulo: string
  descripcion: string
	estado: number | string
  fechaCreacion: string
  fechaLimite?: string | null
  cuposDisponibles: number
  profesorId?: number | null
	tipo?: number | string
  creadorEstudianteId?: number | null
  objetivo?: string | null
}

export interface CreateCollaborativeProjectRequest {
  titulo: string
  descripcion: string
  objetivo?: string
  cuposDisponibles: number
  fechaLimite?: string
  disponibilidad?: string
  habilidadesIds: number[]
  interesesIds: number[]
}

export interface CollaborativeProject extends Project {
  tipo: number | string
  creadorEstudianteId: number
  liderUsuarioId: number
  equipo: Team
  habilidadesIds: number[]
  interesesIds: number[]
}

export interface TalentRecommendation {
  estudianteId: number
  nombre: string
	carrera: string
  semestre: number
  disponibilidad?: string | null
  porcentajeCompatibilidad: number
  habilidadesCoincidentes: string[]
  interesesCoincidentes: string[]
}

export function projectStatusLabel(status: Project['estado']): string {
  if (typeof status === 'number') return ({ 1: 'Abierto', 2: 'Cerrado', 3: 'En curso', 4: 'Finalizado' } as Record<number, string>)[status] ?? 'Desconocido'
  return status
}

export interface Skill {
  id: number
  nombre: string
  categoria?: string | null
}

export interface Interest {
  id: number
  nombre: string
}
