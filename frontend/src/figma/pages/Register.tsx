import { useState } from "react";
import { Page } from "../types";

interface Props {
  onNavigate: (page: Page) => void;
}

const skills = ["Python", "JavaScript", "React", "Node.js", "SQL", "Machine Learning", "UX Design", "Figma", "Java", "C++", "R", "Data Analysis", "Cloud Computing", "Docker"];

export default function Register({ onNavigate }: Props) {
  const [step, setStep] = useState(1);
  const [selected, setSelected] = useState<string[]>([]);

  const toggle = (s: string) =>
    setSelected((prev) => prev.includes(s) ? prev.filter((x) => x !== s) : [...prev, s]);

  return (
    <div className="min-h-full flex" style={{ fontFamily: "'Inter', sans-serif" }}>
      {/* Left */}
      <div
        className="hidden lg:flex lg:w-[380px] flex-col justify-between p-10 relative overflow-hidden shrink-0"
        style={{ background: "linear-gradient(145deg, #0B3D2E 0%, #176B45 100%)" }}
      >
        <div>
          <div className="flex items-center gap-2 mb-12">
            <div className="w-9 h-9 rounded-xl bg-white/20 flex items-center justify-center text-white font-bold">T</div>
            <span className="text-white font-bold text-lg">TalentMatch</span>
          </div>
          <h2 className="text-3xl font-bold text-white mb-4">Crea tu perfil y empieza a conectar</h2>
          <p className="text-white/70 text-sm leading-relaxed">
            En menos de 3 minutos tendrás acceso a cientos de proyectos académicos compatibles con tus habilidades.
          </p>
        </div>

        {/* Steps indicator */}
        <div className="space-y-4">
          {[
            { n: 1, label: "Datos personales" },
            { n: 2, label: "Perfil académico" },
            { n: 3, label: "Habilidades" },
          ].map((s) => (
            <div key={s.n} className="flex items-center gap-3">
              <div
                className={`w-7 h-7 rounded-full flex items-center justify-center text-sm font-bold transition-all ${
                  step >= s.n ? "bg-white text-green-800" : "bg-white/20 text-white"
                }`}
              >
                {step > s.n ? "✓" : s.n}
              </div>
              <span className={`text-sm ${step >= s.n ? "text-white font-medium" : "text-white/50"}`}>
                {s.label}
              </span>
            </div>
          ))}
        </div>
      </div>

      {/* Right */}
      <div className="flex-1 flex items-center justify-center p-8 bg-white overflow-y-auto">
        <div className="w-full max-w-lg">
          <div className="mb-8">
            <div className="flex items-center gap-2 mb-2">
              <span className="text-xs font-semibold px-2.5 py-1 rounded-full text-white" style={{ backgroundColor: "#176B45" }}>
                Paso {step} de 3
              </span>
            </div>
            <h2 className="text-2xl font-bold text-gray-900">
              {step === 1 && "Datos personales"}
              {step === 2 && "Perfil académico"}
              {step === 3 && "Tus habilidades"}
            </h2>
            <p className="text-sm text-gray-500 mt-1">
              {step === 1 && "Cuéntanos quién eres"}
              {step === 2 && "Información de tu carrera"}
              {step === 3 && "Selecciona las habilidades que dominas"}
            </p>
          </div>

          {step === 1 && (
            <div className="space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1.5">Nombres</label>
                  <input className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }} placeholder="Yuliana" />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1.5">Apellidos</label>
                  <input className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }} placeholder="Pérez García" />
                </div>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1.5">Correo institucional</label>
                <input type="email" className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }} placeholder="y.perez@universidad.edu.co" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1.5">Contraseña</label>
                <input type="password" className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }} placeholder="••••••••" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1.5">Confirmar contraseña</label>
                <input type="password" className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }} placeholder="••••••••" />
              </div>
            </div>
          )}

          {step === 2 && (
            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1.5">Universidad</label>
                <select className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }}>
                  <option>Universidad CUN</option>
                  <option>Universidad de los Andes</option>
                  <option>Universidad Javeriana</option>
                </select>
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1.5">Carrera</label>
                  <select className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }}>
                    <option>Ingeniería de Sistemas</option>
                    <option>Diseño Industrial</option>
                    <option>Estadística</option>
                    <option>Matemáticas</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1.5">Semestre actual</label>
                  <select className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }}>
                    {[1,2,3,4,5,6,7,8,9,10].map((n) => <option key={n}>{n}° semestre</option>)}
                  </select>
                </div>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1.5">Código estudiantil</label>
                <input className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }} placeholder="2023XXXXXX" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1.5">Disponibilidad horaria</label>
                <div className="grid grid-cols-3 gap-2">
                  {["Tiempo completo", "Medio tiempo", "Fines de semana"].map((o) => (
                    <button key={o} className="py-2 text-xs rounded-xl border font-medium transition-all hover:border-green-400" style={{ borderColor: "#D1FAE5", color: "#176B45" }}>{o}</button>
                  ))}
                </div>
              </div>
            </div>
          )}

          {step === 3 && (
            <div>
              <div className="flex flex-wrap gap-2 mb-6">
                {skills.map((s) => (
                  <button
                    key={s}
                    onClick={() => toggle(s)}
                    className={`px-3 py-1.5 rounded-xl text-sm font-medium border transition-all ${
                      selected.includes(s)
                        ? "text-white border-transparent"
                        : "bg-white text-gray-600 border-gray-200 hover:border-green-300"
                    }`}
                    style={selected.includes(s) ? { backgroundColor: "#176B45", borderColor: "#176B45" } : {}}
                  >
                    {selected.includes(s) ? "✓ " : ""}{s}
                  </button>
                ))}
              </div>
              {selected.length > 0 && (
                <p className="text-sm" style={{ color: "#176B45" }}>{selected.length} habilidades seleccionadas</p>
              )}
            </div>
          )}

          <div className="flex gap-3 mt-8">
            {step > 1 && (
              <button
                onClick={() => setStep((s) => s - 1)}
                className="flex-1 py-2.5 rounded-xl border text-sm font-semibold text-gray-700 hover:bg-gray-50 transition-colors"
                style={{ borderColor: "#E5E7EB" }}
              >
                Atrás
              </button>
            )}
            <button
              onClick={() => step < 3 ? setStep((s) => s + 1) : onNavigate("dashboard")}
              className="flex-1 py-2.5 rounded-xl text-white text-sm font-semibold transition-all hover:opacity-90"
              style={{ backgroundColor: "#176B45" }}
            >
              {step === 3 ? "Crear cuenta" : "Continuar"}
            </button>
          </div>

          <p className="text-center text-sm text-gray-500 mt-6">
            ¿Ya tienes cuenta?{" "}
            <button className="font-semibold" style={{ color: "#176B45" }} onClick={() => onNavigate("login")}>
              Inicia sesión
            </button>
          </p>
        </div>
      </div>
    </div>
  );
}
