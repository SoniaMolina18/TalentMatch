import { useCallback, useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { useAuth } from '../features/auth/AuthContext'
import { api, ApiError } from '../services/apiClient'
import type { Notification, Project } from '../types/api'

export function DashboardPage() {
  const { user } = useAuth()
  const [projects, setProjects] = useState<Project[]>([])
  const [notifications, setNotifications] = useState<Notification[]>([])
  const [error, setError] = useState('')
  const [notificationsLoading, setNotificationsLoading] = useState(true)
  const [notificationsError, setNotificationsError] = useState('')
  const loadNotifications = useCallback(async () => {
    if (!user) return
    setNotificationsLoading(true)
    setNotificationsError('')
    try { setNotifications(await api.myNotifications()) }
    catch (reason) { setNotificationsError(reason instanceof ApiError ? reason.message : 'No se pudieron cargar las notificaciones.') }
    finally { setNotificationsLoading(false) }
  }, [user])
  useEffect(() => {
    if (!user) return
    let cancelled = false
    api.projects().then(value => { if (!cancelled) setProjects(value) }).catch(reason => { if (!cancelled) setError(reason instanceof Error ? reason.message : 'No se pudo cargar el catálogo.') })
    void loadNotifications()
    return () => { cancelled = true }
  }, [user, loadNotifications])
  const unreadCount = notifications.filter(notification => !notification.leida).length
  const roleText = user?.rol === 'Estudiante' ? 'Encuentra proyectos donde desarrollar tu talento.' : user?.rol === 'Profesor' ? 'Gestiona tus proyectos y descubre talento.' : 'Supervisa la actividad de la plataforma.'
  const markAsRead = async (notification: Notification) => {
    if (notification.leida) return
    try {
      const updated = await api.markNotificationRead(notification.id)
      setNotifications(current => current.map(item => item.id === updated.id ? updated : item))
    } catch (reason) { setNotificationsError(reason instanceof ApiError ? reason.message : 'No se pudo marcar la notificación.') }
  }

  return <main className="px-8 py-8 space-y-8 max-w-screen-xl">
    <header><h1 className="text-2xl font-bold text-gray-900">Hola, {user?.nombre} 👋</h1><p className="text-sm mt-1 text-gray-500">{roleText}</p></header>
    <section className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-5">{[["🎯", "Proyectos disponibles", projects.length, "Catálogo actual"]].map(([icon, label, value, sub]) => <article key={label} className="bg-white rounded-2xl p-5 shadow-sm border border-[#E5EDE8] hover:shadow-md transition-shadow"><div className="flex items-center justify-between"><span className="text-2xl">{icon}</span><span className="text-xs text-brand-main">TalentMatch</span></div><p className="text-2xl font-bold text-gray-900 mt-4">{value}</p><p className="text-xs text-gray-500 mt-0.5">{label}</p><p className="text-xs text-brand-main mt-2">{sub}</p></article>)}<article className="bg-white rounded-2xl p-5 shadow-sm border border-[#E5EDE8]"><p className="text-2xl font-bold text-gray-900">{unreadCount}</p><p className="text-xs text-gray-500 mt-0.5">No leídas</p><p className="text-xs text-brand-main mt-2">Notificaciones</p></article>{error && <article className="sm:col-span-2 xl:col-span-3 rounded-2xl bg-red-50 p-5 text-sm text-red-700">{error}</article>}</section>
    <section className="bg-white rounded-2xl p-6 shadow-sm border border-[#E5EDE8]"><div className="flex items-center justify-between mb-5"><div><p className="text-xs font-semibold uppercase tracking-wider text-brand-main">Actividad</p><h2 className="font-semibold text-gray-900 mt-1">Notificaciones</h2></div>{!notificationsLoading && <span className="text-xs text-gray-500">{unreadCount} sin leer</span>}</div>{notificationsLoading ? <p className="text-sm text-gray-500">Cargando notificaciones...</p> : notificationsError ? <div className="rounded-xl bg-red-50 p-4 text-sm text-red-700"><p>{notificationsError}</p><button onClick={() => void loadNotifications()} className="mt-3 rounded-lg bg-brand-dark px-3 py-1.5 font-semibold text-white">Reintentar</button></div> : notifications.length === 0 ? <p className="text-sm text-gray-500">No tienes notificaciones.</p> : <div className="space-y-2">{notifications.map(notification => <button key={notification.id} onClick={() => void markAsRead(notification)} className={`w-full rounded-xl px-3 py-3 text-left text-sm ${notification.leida ? 'bg-gray-50 text-gray-500' : 'bg-brand-bg text-gray-800 font-medium'}`}><span className="block">{notification.titulo || 'Notificación'}</span><span className="mt-1 block">{notification.mensaje || 'Notificación sin mensaje'}</span><span className="mt-1 block text-xs text-gray-400">{notification.fechaCreacion ? new Date(notification.fechaCreacion).toLocaleString('es-CO') : ''}{!notification.leida && ' · Pulsa para marcar como leída'}</span></button>)}</div>}</section>
  </main>
}
