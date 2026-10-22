import { useEffect, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { api, ApiError } from '../services/apiClient'
import { useAuth } from '../features/auth/AuthContext'
import { projectStatusLabel, type Project } from '../types/api'

export function ProjectDetailPage() {
  const { id } = useParams()
  const { user } = useAuth()
  const [project, setProject] = useState<Project | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [message, setMessage] = useState('')
  const [applicationError, setApplicationError] = useState('')
  const [applying, setApplying] = useState(false)
  const [applied, setApplied] = useState(false)
  useEffect(() => {
    const projectId = Number(id)
    if (!Number.isInteger(projectId)) { setError('El proyecto solicitado no es válido.'); setLoading(false); return }
    let cancelled = false
    setLoading(true)
    api.project(projectId).then(value => { if (!cancelled) setProject(value) }).catch(err => { if (!cancelled) setError(err instanceof ApiError ? err.message : 'No se pudo cargar el proyecto.') }).finally(() => { if (!cancelled) setLoading(false) })
    return () => { cancelled = true }
  }, [id])
  async function apply() { if (!user || !project || applied) return; setApplicationError(''); setApplying(true); try { await api.createApplication({ estudianteId: user.id, proyectoId: project.id, mensaje: message || undefined }); setApplied(true) } catch (err) { setApplicationError(err instanceof ApiError ? err.message : 'No se pudo enviar la postulación.') } finally { setApplying(false) } }
  if (loading) return <main className="p-8 text-sm text-gray-500">Cargando proyecto…</main>
  if (error || !project) return <main className="p-8"><div className="rounded-xl bg-red-50 px-4 py-3 text-sm text-red-700">{error || 'No se encontró el proyecto.'}</div><Link to="/proyectos" className="mt-4 inline-block text-sm font-semibold text-brand-dark">Volver al catálogo</Link></main>
  const status = projectStatusLabel(project.estado)
  return (
    <main className="px-8 py-8 max-w-screen-xl">
      <Link to="/proyectos" className="flex items-center gap-2 text-sm font-medium text-brand-dark mb-6">
        ← Volver a proyectos
      </Link>
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div className="lg:col-span-2 space-y-5">
          <article className="bg-white rounded-2xl p-6 shadow-sm border border-[#E5EDE8]">
            <div className="flex items-start justify-between gap-4">
              <div>
                <span className="text-xs font-semibold px-2.5 py-1 rounded-full bg-brand-light text-brand-darkest">
                  Proyecto académico
                </span>
                <h1 className="text-xl font-bold text-gray-900 leading-snug mt-3">
                  {project.titulo}
                </h1>
              </div>
              <span className="text-xs font-semibold px-2.5 py-1 rounded-full bg-amber-50 text-amber-700">
                {status}
              </span>
            </div>
            <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 py-4 border-y border-gray-100 my-5">
              <div>
                <p className="text-xs text-gray-400 mb-1">🎯 Vacantes</p>
                <p className="text-sm font-semibold text-gray-900">
                  {project.cuposDisponibles} disponibles
                </p>
              </div>
              <div>
                <p className="text-xs text-gray-400 mb-1">⏱ Fecha límite</p>
                <p className="text-sm font-semibold text-gray-900">
                  {project.fechaLimite ? new Date(project.fechaLimite).toLocaleDateString('es-ES') : 'Sin fecha'}
                </p>
              </div>
              <div>
                <p className="text-xs text-gray-400 mb-1">📅 Creado</p>
                <p className="text-sm font-semibold text-gray-900">
                  {new Date(project.fechaCreacion).toLocaleDateString('es-ES')}
                </p>
              </div>
            </div>
            {user?.rol === 'Estudiante' && (applied ? 
              <div className="rounded-xl bg-brand-light px-4 py-3 text-center text-sm font-semibold text-brand-darkest">
                ✓ Postulación enviada correctamente
              </div> : 
              <div>
                <label htmlFor="mensaje" className="block text-sm font-medium text-gray-700 mb-2">
                  Mensaje para el equipo (opcional)
                </label>
                <textarea
                  id="mensaje"
                  value={message}
                  onChange={event => setMessage(event.target.value)}
                  rows={4}
                  maxLength={1000}
                  placeholder="Cuéntales por qué encajas en el proyecto…"
                  className="w-full resize-y rounded-xl border border-brand-light bg-brand-bg px-4 py-3 text-sm outline-none focus:ring-2 focus:ring-green-200"
                />
                {applicationError && <div className="rounded-xl bg-red-50 px-4 py-3 text-sm text-red-700 mt-3">{applicationError}</div>}
                <button
                  onClick={apply}
                  disabled={applying || project.cuposDisponibles < 1 || status !== 'Abierto'}
                  className="w-full mt-4 rounded-xl bg-brand-dark py-3 text-sm font-semibold text-white hover:opacity-90 disabled:opacity-50"
                >
                  {applying ? 'Enviando…' : status !== 'Abierto' ? 'Proyecto no disponible' : 'Postularme a este proyecto'}
                </button>
              </div>
            )}
          </article>
          <article className="bg-white rounded-2xl p-6 shadow-sm border border-[#E5EDE8]">
            <h2 className="font-semibold text-gray-900 mb-3">Descripción del proyecto</h2>
            <p className="text-sm text-gray-600 leading-relaxed whitespace-pre-line">
              {project.descripcion}
            </p>
          </article>
        </div>
        <aside className="bg-white rounded-2xl p-5 shadow-sm border border-[#E5EDE8] h-fit">
          <h2 className="font-semibold text-gray-900 mb-4">Resumen</h2>
          <div className="space-y-4 text-sm">
            <div>
              <p className="text-xs text-gray-400">Estado</p>
              <p className="font-medium text-gray-800 mt-1">{status}</p>
            </div>
            <div>
              <p className="text-xs text-gray-400">Profesor responsable</p>
              <p className="font-medium text-gray-800 mt-1">ID {project.profesorId}</p>
            </div>
            <div>
              <p className="text-xs text-gray-400">Plazas disponibles</p>
              <p className="font-medium text-gray-800 mt-1">{project.cuposDisponibles}</p>
            </div>
          </div>
        </aside>
      </div>
    </main>
  )
}
