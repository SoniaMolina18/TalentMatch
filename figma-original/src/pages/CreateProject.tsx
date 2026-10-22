import { useState } from "react";
import { Page } from "../types";

interface Props {
  onNavigate: (page: Page) => void;
}

const skillOptions = ["Python", "JavaScript", "React", "Node.js", "SQL", "Machine Learning", "UX Design", "Figma", "Java", "R", "Data Analysis", "Cloud Computing", "Docker", "TensorFlow", "Power BI"];

export default function CreateProject({ onNavigate }: Props) {
  const [selected, setSelected] = useState<string[]>([]);
  const toggle = (s: string) => setSelected((prev) => prev.includes(s) ? prev.filter((x) => x !== s) : [...prev, s]);

  return (
    <div className="min-h-full" style={{ backgroundColor: "#F7FAF8", fontFamily: "'Inter', sans-serif" }}>
      {/* Top nav */}
      <div className="bg-white border-b px-8 py-4 flex items-center gap-4" style={{ borderColor: "#E5EDE8" }}>
        <button onClick={() => onNavigate("teacher-panel")} className="flex items-center gap-2 text-sm font-medium" style={{ color: "#176B45" }}>
          <svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><polyline points="15 18 9 12 15 6" /></svg>
          Volver
        </button>
        <div className="flex items-center gap-2 ml-2">
          <div className="w-7 h-7 rounded-lg flex items-center justify-center text-white text-sm font-bold" style={{ backgroundColor: "#176B45" }}>T</div>
          <span className="font-bold" style={{ color: "#0B3D2E" }}>TalentMatch</span>
        </div>
        <h1 className="text-sm font-semibold text-gray-900 ml-4">Crear nuevo proyecto</h1>
      </div>

      <div className="max-w-3xl mx-auto px-6 py-10">
        <div className="mb-8">
          <h2 className="text-2xl font-bold text-gray-900">Nuevo proyecto académico</h2>
          <p className="text-sm text-gray-500 mt-1">Los campos marcados con * son obligatorios. TalentMatch encontrará estudiantes compatibles automáticamente.</p>
        </div>

        <form className="space-y-6" onSubmit={(e) => { e.preventDefault(); onNavigate("teacher-panel"); }}>
          {/* Basic info */}
          <div className="bg-white rounded-2xl p-6 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
            <h3 className="font-semibold text-gray-900 mb-4">Información básica</h3>
            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1.5">Título del proyecto *</label>
                <input className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }} placeholder="Ej: Predicción de deserción universitaria con ML" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1.5">Descripción *</label>
                <textarea rows={4} className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none resize-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }} placeholder="Describe el objetivo, metodología y alcance del proyecto..." />
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1.5">Categoría *</label>
                  <select className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }}>
                    <option>Ciencias de Datos</option>
                    <option>Desarrollo Móvil</option>
                    <option>Blockchain</option>
                    <option>Business Intelligence</option>
                    <option>Investigación</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1.5">Departamento *</label>
                  <select className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }}>
                    <option>Ingeniería de Sistemas</option>
                    <option>Electrónica</option>
                    <option>Industrial</option>
                    <option>Administración</option>
                  </select>
                </div>
              </div>
            </div>
          </div>

          {/* Logistics */}
          <div className="bg-white rounded-2xl p-6 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
            <h3 className="font-semibold text-gray-900 mb-4">Logística</h3>
            <div className="grid grid-cols-3 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1.5">Modalidad *</label>
                <select className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }}>
                  <option>Remota</option>
                  <option>Presencial</option>
                  <option>Híbrida</option>
                </select>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1.5">Duración *</label>
                <select className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }}>
                  {["1 mes", "2 meses", "3 meses", "4 meses", "5 meses", "6 meses", "8 meses", "1 año"].map((d) => <option key={d}>{d}</option>)}
                </select>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1.5">Vacantes *</label>
                <input type="number" min="1" max="10" defaultValue="3" className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }} />
              </div>
            </div>
            <div className="grid grid-cols-2 gap-4 mt-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1.5">Fecha de inicio</label>
                <input type="date" className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }} />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1.5">Dedicación semanal</label>
                <select className="w-full px-4 py-2.5 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }}>
                  <option>5-10 hrs/semana</option>
                  <option>10-15 hrs/semana</option>
                  <option>15-20 hrs/semana</option>
                  <option>20+ hrs/semana</option>
                </select>
              </div>
            </div>
          </div>

          {/* Skills */}
          <div className="bg-white rounded-2xl p-6 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
            <h3 className="font-semibold text-gray-900 mb-1">Habilidades requeridas *</h3>
            <p className="text-xs text-gray-500 mb-4">Selecciona las habilidades que necesitas en el equipo. TalentMatch las usará para calcular compatibilidad.</p>
            <div className="flex flex-wrap gap-2">
              {skillOptions.map((s) => (
                <button
                  key={s}
                  type="button"
                  onClick={() => toggle(s)}
                  className={`px-3 py-1.5 rounded-xl text-sm font-medium border transition-all ${selected.includes(s) ? "text-white border-transparent" : "bg-white text-gray-600 border-gray-200 hover:border-green-300"}`}
                  style={selected.includes(s) ? { backgroundColor: "#176B45" } : {}}
                >
                  {selected.includes(s) ? "✓ " : ""}{s}
                </button>
              ))}
            </div>
            {selected.length > 0 && (
              <p className="mt-3 text-sm" style={{ color: "#176B45" }}>{selected.length} habilidades seleccionadas</p>
            )}
          </div>

          {/* Submit */}
          <div className="flex gap-3">
            <button type="button" onClick={() => onNavigate("teacher-panel")} className="flex-1 py-3 rounded-xl border text-sm font-semibold text-gray-700 hover:bg-gray-50" style={{ borderColor: "#E5E7EB" }}>
              Cancelar
            </button>
            <button type="button" className="flex-1 py-3 rounded-xl border text-sm font-semibold hover:bg-gray-50" style={{ borderColor: "#29A66A", color: "#176B45" }}>
              Guardar borrador
            </button>
            <button type="submit" className="flex-1 py-3 rounded-xl text-white text-sm font-semibold hover:opacity-90 shadow-lg shadow-green-200" style={{ backgroundColor: "#176B45" }}>
              Publicar proyecto
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
