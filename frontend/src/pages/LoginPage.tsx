import { FormEvent, useState } from 'react'
import { Link, useLocation, useNavigate } from 'react-router-dom'
import { useAuth } from '../features/auth/AuthContext'
import { ApiError } from '../services/apiClient'

export function LoginPage() {
	const { login } = useAuth()
  const navigate = useNavigate()
  const location = useLocation()
  const [correo, setCorreo] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)

  async function submit(event: FormEvent) {
	event.preventDefault()
	setError('')
	setLoading(true)
	try {
	  await login({ correo, password })
	  navigate((location.state as { from?: string } | null)?.from ?? '/dashboard', { replace: true })
	} catch (err) {
	  setError(err instanceof ApiError ? err.message : 'No se pudo iniciar sesión.')
	} finally {
	  setLoading(false)
	}
  }

  return <main className="min-h-screen flex bg-white font-sans">
	<section className="hidden lg:flex lg:w-1/2 flex-col justify-between p-12 relative overflow-hidden bg-gradient-to-br from-brand-darkest via-brand-dark to-brand-main">
	  <div className="absolute inset-0 opacity-10"><div className="absolute top-20 right-20 w-64 h-64 rounded-full border-2 border-white" /><div className="absolute top-40 right-40 w-32 h-32 rounded-full border border-white" /><div className="absolute bottom-32 left-16 w-48 h-48 rounded-full border border-white" /></div>
	  <div className="relative z-10"><div className="flex items-center gap-3 mb-16"><div className="w-10 h-10 rounded-xl bg-white/20 flex items-center justify-center text-white font-bold text-xl">T</div><span className="text-white font-bold text-xl">TalentMatch</span></div><h1 className="text-4xl font-bold text-white leading-tight mb-4">Conecta tu talento con los proyectos que te inspiran</h1><p className="text-white/70 text-lg leading-relaxed">La plataforma universitaria que te ayuda a encontrar el proyecto académico perfecto según tus habilidades e intereses.</p></div>
	  <div className="relative z-10 grid grid-cols-3 gap-4">{[['2,400+', 'Estudiantes activos'], ['380+', 'Proyectos disponibles'], ['94%', 'Tasa de satisfacción']].map(([value, label]) => <div key={label} className="bg-white/10 rounded-xl p-4 backdrop-blur-sm"><p className="text-2xl font-bold text-white">{value}</p><p className="text-xs text-white/60 mt-1">{label}</p></div>)}</div>
	</section>
	<section className="flex-1 flex items-center justify-center p-8"><div className="w-full max-w-sm">
	  <div className="flex items-center gap-2 mb-10 lg:hidden"><div className="w-8 h-8 rounded-xl flex items-center justify-center text-white font-bold bg-brand-dark">T</div><span className="font-bold text-lg text-brand-darkest">TalentMatch</span></div>
	  <h2 className="text-2xl font-bold text-gray-900 mb-1">Bienvenido de nuevo</h2><p className="text-sm text-gray-500 mb-8">Ingresa tu cuenta para continuar</p>
	  <form className="space-y-4" onSubmit={submit}>{error && <div className="rounded-xl bg-red-50 px-4 py-3 text-sm text-red-700">{error}</div>}<div><label htmlFor="correo" className="block text-sm font-medium text-gray-700 mb-1.5">Correo institucional</label><input id="correo" type="email" value={correo} onChange={event => setCorreo(event.target.value)} required placeholder="usuario@universidad.edu.co" className="w-full px-4 py-2.5 text-sm rounded-xl border border-brand-light bg-brand-bg outline-none focus:ring-2 focus:ring-green-200" /></div><div><label htmlFor="password" className="block text-sm font-medium text-gray-700 mb-1.5">Contraseña</label><input id="password" type="password" value={password} onChange={event => setPassword(event.target.value)} required placeholder="••••••••" className="w-full px-4 py-2.5 text-sm rounded-xl border border-brand-light bg-brand-bg outline-none focus:ring-2 focus:ring-green-200" /></div><button disabled={loading} className="w-full py-2.5 rounded-xl text-white font-semibold text-sm bg-brand-dark hover:opacity-90 disabled:opacity-60">{loading ? 'Comprobando…' : 'Iniciar sesión'}</button></form>
	  <div className="flex items-center gap-3 my-6"><div className="flex-1 h-px bg-gray-200" /><span className="text-xs text-gray-400">Acceso seguro con JWT</span><div className="flex-1 h-px bg-gray-200" /></div><p className="text-center text-sm text-gray-500">¿No tienes cuenta? <Link className="font-semibold text-brand-dark" to="/registro">Regístrate gratis</Link></p>
	</div></section>
  </main>
}
