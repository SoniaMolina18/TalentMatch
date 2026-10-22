import { useState } from "react";
import Layout from "../components/Layout";
import MatchScore from "../components/MatchScore";
import { Page } from "../types";

interface Props {
  onNavigate: (page: Page) => void;
}

const matchingSkills = ["Python", "SQL", "Data Analysis"];
const missingSkills = ["Machine Learning", "TensorFlow"];
const members = [
  { name: "Carlos M.", role: "Líder de datos", img: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=60&h=60&fit=crop&auto=format" },
  { name: "Laura P.", role: "Analista", img: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=60&h=60&fit=crop&auto=format" },
];

export default function ProjectDetail({ onNavigate }: Props) {
  const [applied, setApplied] = useState(false);

  return (
    <Layout currentPage="explore" onNavigate={onNavigate}>
      <div className="px-8 py-8 max-w-screen-xl">
        {/* Back */}
        <button
          onClick={() => onNavigate("explore")}
          className="flex items-center gap-2 text-sm font-medium mb-6 hover:underline"
          style={{ color: "#176B45" }}
        >
          <svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><polyline points="15 18 9 12 15 6" /></svg>
          Volver a proyectos
        </button>

        <div className="grid grid-cols-3 gap-6">
          {/* Main */}
          <div className="col-span-2 space-y-5">
            {/* Header card */}
            <div className="bg-white rounded-2xl p-6 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <div className="flex items-start justify-between mb-4">
                <div className="flex-1">
                  <div className="flex items-center gap-2 mb-2">
                    <span className="text-xs font-semibold px-2.5 py-1 rounded-full" style={{ backgroundColor: "#D1F2E2", color: "#0B3D2E" }}>Ciencias de Datos</span>
                    <span className="text-xs px-2.5 py-1 rounded-full bg-blue-50 text-blue-700 font-semibold">Remota</span>
                    <span className="text-xs px-2.5 py-1 rounded-full bg-amber-50 text-amber-700 font-semibold">Activo</span>
                  </div>
                  <h1 className="text-xl font-bold text-gray-900 leading-snug">
                    Predicción de deserción universitaria con Machine Learning
                  </h1>
                </div>
                <MatchScore score={94} size="lg" />
              </div>

              <div className="grid grid-cols-3 gap-4 py-4 border-y my-4" style={{ borderColor: "#F0F0F0" }}>
                {[
                  { label: "Profesor", val: "Carlos Ramírez", icon: "👨‍🏫" },
                  { label: "Duración", val: "6 meses", icon: "⏱️" },
                  { label: "Vacantes", val: "3 disponibles", icon: "🎯" },
                ].map((x) => (
                  <div key={x.label}>
                    <p className="text-xs text-gray-400 mb-0.5">{x.icon} {x.label}</p>
                    <p className="text-sm font-semibold text-gray-900">{x.val}</p>
                  </div>
                ))}
              </div>

              {!applied ? (
                <button
                  onClick={() => setApplied(true)}
                  className="w-full py-3 rounded-xl text-white font-semibold text-sm transition-all hover:opacity-90 shadow-lg shadow-green-200"
                  style={{ backgroundColor: "#176B45" }}
                >
                  Postularme a este proyecto
                </button>
              ) : (
                <div className="w-full py-3 rounded-xl text-center font-semibold text-sm" style={{ backgroundColor: "#D1F2E2", color: "#0B3D2E" }}>
                  ✓ Postulación enviada — te avisaremos por correo
                </div>
              )}
            </div>

            {/* Description */}
            <div className="bg-white rounded-2xl p-6 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <h2 className="font-semibold text-gray-900 mb-3">Descripción del proyecto</h2>
              <p className="text-sm text-gray-600 leading-relaxed">
                Este proyecto tiene como objetivo desarrollar modelos de machine learning capaces de identificar con alta precisión a estudiantes universitarios en riesgo de abandono académico, usando datos históricos de rendimiento, asistencia y factores socioeconómicos.
              </p>
              <p className="text-sm text-gray-600 leading-relaxed mt-3">
                El equipo trabajará con bases de datos reales anonimizadas de la universidad, aplicando técnicas como regresión logística, árboles de decisión, Random Forest y redes neuronales, evaluando cada modelo con métricas de precisión, recall y AUC-ROC.
              </p>
              <div className="mt-4 grid grid-cols-2 gap-3">
                {[
                  { label: "Departamento", val: "Ingeniería de Sistemas" },
                  { label: "Inicio estimado", val: "Octubre 2026" },
                  { label: "Modalidad", val: "100% remota" },
                  { label: "Dedicación", val: "15-20 hrs/semana" },
                ].map((x) => (
                  <div key={x.label} className="bg-gray-50 rounded-xl p-3">
                    <p className="text-xs text-gray-400">{x.label}</p>
                    <p className="text-sm font-medium text-gray-800 mt-0.5">{x.val}</p>
                  </div>
                ))}
              </div>
            </div>

            {/* Team */}
            <div className="bg-white rounded-2xl p-6 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <h2 className="font-semibold text-gray-900 mb-4">Integrantes actuales</h2>
              <div className="space-y-3">
                {members.map((m) => (
                  <div key={m.name} className="flex items-center gap-3">
                    <img src={m.img} alt={m.name} className="w-10 h-10 rounded-full object-cover" />
                    <div>
                      <p className="text-sm font-semibold text-gray-900">{m.name}</p>
                      <p className="text-xs text-gray-500">{m.role}</p>
                    </div>
                    <span className="ml-auto text-xs px-2.5 py-1 rounded-full" style={{ backgroundColor: "#D1F2E2", color: "#0B3D2E" }}>Activo</span>
                  </div>
                ))}
                <div className="flex items-center gap-3 opacity-50">
                  <div className="w-10 h-10 rounded-full border-2 border-dashed flex items-center justify-center" style={{ borderColor: "#29A66A" }}>
                    <span style={{ color: "#29A66A" }}>+</span>
                  </div>
                  <p className="text-sm text-gray-400">3 vacantes disponibles</p>
                </div>
              </div>
            </div>
          </div>

          {/* Sidebar */}
          <div className="space-y-5">
            {/* Match breakdown */}
            <div className="bg-white rounded-2xl p-5 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <h3 className="font-semibold text-gray-900 mb-4">Tu compatibilidad</h3>
              <div className="flex items-center justify-center mb-4">
                <MatchScore score={94} size="lg" />
              </div>
              <div className="mb-4">
                <p className="text-xs font-semibold uppercase tracking-wider text-gray-500 mb-2">✅ Habilidades que tienes</p>
                <div className="flex flex-wrap gap-1.5">
                  {matchingSkills.map((s) => (
                    <span key={s} className="text-xs px-2.5 py-1 rounded-full font-medium" style={{ backgroundColor: "#D1F2E2", color: "#166534" }}>{s}</span>
                  ))}
                </div>
              </div>
              <div>
                <p className="text-xs font-semibold uppercase tracking-wider text-gray-500 mb-2">🔶 Habilidades a desarrollar</p>
                <div className="flex flex-wrap gap-1.5">
                  {missingSkills.map((s) => (
                    <span key={s} className="text-xs px-2.5 py-1 rounded-full font-medium bg-amber-50 text-amber-700">{s}</span>
                  ))}
                </div>
              </div>
            </div>

            {/* Required skills */}
            <div className="bg-white rounded-2xl p-5 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <h3 className="font-semibold text-gray-900 mb-3">Habilidades requeridas</h3>
              {[...matchingSkills, ...missingSkills].map((s) => {
                const has = matchingSkills.includes(s);
                return (
                  <div key={s} className="flex items-center justify-between py-2 border-b last:border-0" style={{ borderColor: "#F5F5F5" }}>
                    <span className="text-sm text-gray-700">{s}</span>
                    <span className={`text-xs font-semibold px-2 py-0.5 rounded-full ${has ? "text-green-700" : "text-amber-700"}`} style={{ backgroundColor: has ? "#D1F2E2" : "#FEF3C7" }}>
                      {has ? "✓ Tienes" : "Pendiente"}
                    </span>
                  </div>
                );
              })}
            </div>

            {/* Professor */}
            <div className="bg-white rounded-2xl p-5 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <h3 className="font-semibold text-gray-900 mb-3">Sobre el profesor</h3>
              <div className="flex items-center gap-3 mb-3">
                <img src="https://images.unsplash.com/photo-1568602471122-7832951cc4c5?w=60&h=60&fit=crop&auto=format" alt="Prof" className="w-12 h-12 rounded-full object-cover" />
                <div>
                  <p className="text-sm font-semibold text-gray-900">Carlos Ramírez</p>
                  <p className="text-xs text-gray-500">PhD en Ciencias de Datos</p>
                </div>
              </div>
              <p className="text-xs text-gray-500 leading-relaxed">Especialista en ML aplicado con 12 años de experiencia en investigación universitaria y proyectos de impacto social.</p>
              <button className="mt-3 w-full py-2 rounded-xl border text-sm font-medium transition-colors hover:bg-gray-50" style={{ borderColor: "#29A66A", color: "#176B45" }}>
                Enviar mensaje
              </button>
            </div>
          </div>
        </div>
      </div>
    </Layout>
  );
}
