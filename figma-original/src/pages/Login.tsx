import { Page } from "../types";

interface Props {
  onNavigate: (page: Page) => void;
}

export default function Login({ onNavigate }: Props) {
  return (
    <div className="min-h-full flex" style={{ fontFamily: "'Inter', sans-serif" }}>
      {/* Left panel */}
      <div
        className="hidden lg:flex lg:w-1/2 flex-col justify-between p-12 relative overflow-hidden"
        style={{ background: "linear-gradient(145deg, #0B3D2E 0%, #176B45 60%, #29A66A 100%)" }}
      >
        {/* Background decoration */}
        <div className="absolute inset-0 opacity-10">
          <div className="absolute top-20 right-20 w-64 h-64 rounded-full border-2 border-white" />
          <div className="absolute top-40 right-40 w-32 h-32 rounded-full border border-white" />
          <div className="absolute bottom-32 left-16 w-48 h-48 rounded-full border border-white" />
        </div>
        <div className="relative z-10">
          <div className="flex items-center gap-3 mb-16">
            <div className="w-10 h-10 rounded-xl bg-white/20 flex items-center justify-center text-white font-bold text-xl">
              T
            </div>
            <span className="text-white font-bold text-xl">TalentMatch</span>
          </div>
          <h1 className="text-4xl font-bold text-white leading-tight mb-4">
            Conecta tu talento con los proyectos que te inspiran
          </h1>
          <p className="text-white/70 text-lg leading-relaxed">
            La plataforma universitaria que te ayuda a encontrar el proyecto académico perfecto según tus habilidades e intereses.
          </p>
        </div>

        {/* Stats */}
        <div className="relative z-10 grid grid-cols-3 gap-4">
          {[
            { val: "2,400+", label: "Estudiantes activos" },
            { val: "380+", label: "Proyectos disponibles" },
            { val: "94%", label: "Tasa de satisfacción" },
          ].map((s) => (
            <div key={s.label} className="bg-white/10 rounded-xl p-4 backdrop-blur-sm">
              <p className="text-2xl font-bold text-white">{s.val}</p>
              <p className="text-xs text-white/60 mt-1">{s.label}</p>
            </div>
          ))}
        </div>
      </div>

      {/* Right panel */}
      <div className="flex-1 flex items-center justify-center p-8 bg-white">
        <div className="w-full max-w-sm">
          {/* Mobile logo */}
          <div className="flex items-center gap-2 mb-10 lg:hidden">
            <div className="w-8 h-8 rounded-xl flex items-center justify-center text-white font-bold" style={{ backgroundColor: "#176B45" }}>T</div>
            <span className="font-bold text-lg" style={{ color: "#0B3D2E" }}>TalentMatch</span>
          </div>

          <h2 className="text-2xl font-bold text-gray-900 mb-1">Bienvenido de nuevo</h2>
          <p className="text-sm text-gray-500 mb-8">Ingresa tu cuenta para continuar</p>

          <form className="space-y-4" onSubmit={(e) => { e.preventDefault(); onNavigate("dashboard"); }}>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1.5">Correo institucional</label>
              <input
                type="email"
                placeholder="usuario@universidad.edu.co"
                className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none transition-all focus:ring-2 focus:ring-green-200"
                style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }}
              />
            </div>
            <div>
              <div className="flex justify-between mb-1.5">
                <label className="text-sm font-medium text-gray-700">Contraseña</label>
                <button type="button" className="text-xs font-medium" style={{ color: "#176B45" }}>¿Olvidaste tu contraseña?</button>
              </div>
              <input
                type="password"
                placeholder="••••••••"
                className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none transition-all focus:ring-2 focus:ring-green-200"
                style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }}
              />
            </div>
            <button
              type="submit"
              className="w-full py-2.5 rounded-xl text-white font-semibold text-sm transition-all hover:opacity-90 mt-2"
              style={{ backgroundColor: "#176B45" }}
            >
              Iniciar sesión
            </button>
          </form>

          <div className="flex items-center gap-3 my-6">
            <div className="flex-1 h-px bg-gray-200" />
            <span className="text-xs text-gray-400">o continúa con</span>
            <div className="flex-1 h-px bg-gray-200" />
          </div>

          <button className="w-full py-2.5 rounded-xl border text-sm font-medium text-gray-700 flex items-center justify-center gap-2 hover:bg-gray-50 transition-colors" style={{ borderColor: "#E5E7EB" }}>
            <svg viewBox="0 0 24 24" className="w-4 h-4">
              <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4" />
              <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853" />
              <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05" />
              <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335" />
            </svg>
            Continuar con Google
          </button>

          <p className="text-center text-sm text-gray-500 mt-8">
            ¿No tienes cuenta?{" "}
            <button className="font-semibold" style={{ color: "#176B45" }} onClick={() => onNavigate("register")}>
              Regístrate gratis
            </button>
          </p>
        </div>
      </div>
    </div>
  );
}
