import Layout from "../components/Layout";
import MatchScore from "../components/MatchScore";
import { Page } from "../types";

interface Props {
  onNavigate: (page: Page) => void;
}

const skills = [
  { name: "Python", level: 90 },
  { name: "SQL", level: 85 },
  { name: "Data Analysis", level: 80 },
  { name: "React", level: 70 },
  { name: "Machine Learning", level: 60 },
  { name: "Figma", level: 55 },
];

const projects = [
  { title: "Análisis de redes sociales académicas", role: "Analista de datos", status: "En progreso", match: 91 },
  { title: "App de gestión de horarios universitarios", role: "Frontend developer", status: "Completado", match: 85 },
];

export default function StudentProfile({ onNavigate }: Props) {
  return (
    <Layout currentPage="student-profile" onNavigate={onNavigate}>
      <div className="px-8 py-8 max-w-screen-xl">
        <div className="grid grid-cols-3 gap-6">
          {/* Left column */}
          <div className="space-y-5">
            {/* Profile card */}
            <div
              className="bg-white rounded-2xl p-6 shadow-sm border text-center"
              style={{ borderColor: "#E5EDE8" }}
            >
              <div className="relative inline-block mb-4">
                <img
                  src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=120&h=120&fit=crop&auto=format"
                  alt="Yuliana"
                  className="w-24 h-24 rounded-full object-cover ring-4 ring-green-200 mx-auto"
                />
                <div
                  className="absolute bottom-1 right-1 w-5 h-5 rounded-full border-2 border-white"
                  style={{ backgroundColor: "#29A66A" }}
                />
              </div>
              <h1 className="text-lg font-bold text-gray-900">Yuliana Pérez García</h1>
              <p className="text-sm text-gray-500 mt-0.5">Ingeniería de Sistemas</p>
              <p className="text-xs text-gray-400 mt-0.5">7mo semestre · Universidad CUN</p>

              <div className="mt-4 flex justify-center">
                <MatchScore score={87} size="lg" />
              </div>
              <p className="text-xs text-gray-400 mt-2">TalentMatch Score</p>

              <div className="mt-4 grid grid-cols-3 gap-2 pt-4 border-t" style={{ borderColor: "#F0F0F0" }}>
                {[
                  { val: "12", label: "Habilidades" },
                  { val: "5", label: "Proyectos" },
                  { val: "3", label: "Equipos" },
                ].map((x) => (
                  <div key={x.label}>
                    <p className="text-base font-bold text-gray-900">{x.val}</p>
                    <p className="text-xs text-gray-400">{x.label}</p>
                  </div>
                ))}
              </div>

              <div className="mt-4 space-y-2">
                <button className="w-full py-2 rounded-xl text-white text-sm font-semibold hover:opacity-90" style={{ backgroundColor: "#176B45" }}>
                  Editar perfil
                </button>
                <button className="w-full py-2 rounded-xl border text-sm font-medium hover:bg-gray-50" style={{ borderColor: "#E5E7EB", color: "#374151" }}>
                  Descargar CV
                </button>
              </div>
            </div>

            {/* Availability */}
            <div className="bg-white rounded-2xl p-5 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <h3 className="font-semibold text-gray-900 mb-3">Disponibilidad</h3>
              <div className="flex items-center gap-2">
                <div className="w-2.5 h-2.5 rounded-full" style={{ backgroundColor: "#29A66A" }} />
                <span className="text-sm text-gray-700">Disponible — Tiempo completo</span>
              </div>
              <p className="text-xs text-gray-400 mt-1 ml-4.5">Lunes a viernes, horario flexible</p>
            </div>

            {/* Contact */}
            <div className="bg-white rounded-2xl p-5 shadow-sm border space-y-3" style={{ borderColor: "#E5EDE8" }}>
              <h3 className="font-semibold text-gray-900 mb-1">Contacto</h3>
              {[
                { icon: "✉️", val: "y.perez@unal.edu.co" },
                { icon: "🔗", val: "linkedin.com/in/yuliaperez" },
                { icon: "💻", val: "github.com/yuliaperez" },
              ].map((x) => (
                <div key={x.val} className="flex items-center gap-2 text-sm text-gray-600">
                  <span>{x.icon}</span>
                  <span className="truncate">{x.val}</span>
                </div>
              ))}
            </div>
          </div>

          {/* Right columns */}
          <div className="col-span-2 space-y-5">
            {/* Bio */}
            <div className="bg-white rounded-2xl p-6 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <h2 className="font-semibold text-gray-900 mb-3">Sobre mí</h2>
              <p className="text-sm text-gray-600 leading-relaxed">
                Estudiante de Ingeniería de Sistemas apasionada por la ciencia de datos y el desarrollo de soluciones tecnológicas de impacto social. Tengo experiencia en análisis de datos con Python y SQL, y estoy profundizando en machine learning aplicado a problemas educativos. Busco proyectos donde pueda combinar mis habilidades técnicas con un propósito significativo.
              </p>
              <div className="mt-4 flex flex-wrap gap-2">
                {["Aprendizaje automático", "Análisis de datos", "Educación tecnológica", "Impacto social"].map((t) => (
                  <span key={t} className="text-xs px-3 py-1 rounded-full" style={{ backgroundColor: "#F0FDF4", color: "#166534" }}>{t}</span>
                ))}
              </div>
            </div>

            {/* Skills */}
            <div className="bg-white rounded-2xl p-6 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <h2 className="font-semibold text-gray-900 mb-4">Habilidades</h2>
              <div className="space-y-3">
                {skills.map((s) => (
                  <div key={s.name}>
                    <div className="flex justify-between items-center mb-1">
                      <span className="text-sm font-medium text-gray-700">{s.name}</span>
                      <span className="text-xs text-gray-400">{s.level}%</span>
                    </div>
                    <div className="h-2 rounded-full bg-gray-100 overflow-hidden">
                      <div
                        className="h-full rounded-full transition-all"
                        style={{ width: `${s.level}%`, background: `linear-gradient(90deg, #176B45, #29A66A)` }}
                      />
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {/* Projects */}
            <div className="bg-white rounded-2xl p-6 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <h2 className="font-semibold text-gray-900 mb-4">Proyectos académicos</h2>
              <div className="space-y-3">
                {projects.map((p) => (
                  <div
                    key={p.title}
                    className="flex items-center gap-4 p-4 rounded-xl"
                    style={{ backgroundColor: "#F7FAF8" }}
                  >
                    <MatchScore score={p.match} size="sm" />
                    <div className="flex-1 min-w-0">
                      <p className="text-sm font-semibold text-gray-900">{p.title}</p>
                      <p className="text-xs text-gray-500 mt-0.5">{p.role}</p>
                    </div>
                    <span
                      className="text-xs px-2.5 py-1 rounded-full font-medium shrink-0"
                      style={p.status === "Completado" ? { backgroundColor: "#D1F2E2", color: "#0B3D2E" } : { backgroundColor: "#FEF3C7", color: "#92400E" }}
                    >
                      {p.status}
                    </span>
                  </div>
                ))}
              </div>
            </div>

            {/* Certifications */}
            <div className="bg-white rounded-2xl p-6 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <h2 className="font-semibold text-gray-900 mb-4">Certificaciones</h2>
              <div className="grid grid-cols-2 gap-3">
                {[
                  { name: "Python for Data Science", org: "Coursera · IBM", date: "Jun 2026" },
                  { name: "SQL Fundamentals", org: "DataCamp", date: "Mar 2026" },
                  { name: "Machine Learning Specialization", org: "Coursera · Stanford", date: "En progreso" },
                ].map((c) => (
                  <div key={c.name} className="p-3 rounded-xl border" style={{ borderColor: "#E5EDE8" }}>
                    <p className="text-sm font-semibold text-gray-900">{c.name}</p>
                    <p className="text-xs text-gray-500 mt-0.5">{c.org}</p>
                    <p className="text-xs mt-1" style={{ color: "#29A66A" }}>{c.date}</p>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>
    </Layout>
  );
}
