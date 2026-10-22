import { useState } from "react";
import Layout from "../components/Layout";
import MatchScore from "../components/MatchScore";
import { Page } from "../types";

interface Props {
  onNavigate: (page: Page) => void;
}

const myProjects = [
  { title: "Predicción de deserción universitaria con ML", applicants: 8, team: 2, vacancies: 3, match: 91, status: "Activo" },
  { title: "Dashboard ESG para empresas colombianas", applicants: 4, team: 1, vacancies: 2, status: "Reclutando", match: 83 },
];

const applicants = [
  { name: "Yuliana Pérez", career: "Ing. de Sistemas", skills: ["Python", "SQL", "Data Analysis"], match: 94, img: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=60&h=60&fit=crop&auto=format" },
  { name: "Miguel Ángel Díaz", career: "Estadística", skills: ["R", "Python", "SPSS"], match: 88, img: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=60&h=60&fit=crop&auto=format" },
  { name: "Catalina Reyes", career: "Ing. de Sistemas", skills: ["Machine Learning", "Python", "TensorFlow"], match: 85, img: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=60&h=60&fit=crop&auto=format" },
];

export default function TeacherPanel({ onNavigate }: Props) {
  const [activeProject, setActiveProject] = useState(0);

  return (
    <Layout currentPage="teacher-panel" onNavigate={onNavigate}>
      <div className="px-8 py-8 max-w-screen-xl">
        {/* Header */}
        <div className="flex items-start justify-between mb-6">
          <div className="flex items-center gap-4">
            <img src="https://images.unsplash.com/photo-1568602471122-7832951cc4c5?w=80&h=80&fit=crop&auto=format" alt="Prof" className="w-14 h-14 rounded-full object-cover ring-2 ring-green-200" />
            <div>
              <h1 className="text-xl font-bold text-gray-900">Dr. Carlos Ramírez</h1>
              <p className="text-sm text-gray-500">PhD Ciencias de Datos · Ingeniería de Sistemas</p>
              <p className="text-xs mt-0.5" style={{ color: "#29A66A" }}>Universidad CUN</p>
            </div>
          </div>
          <button onClick={() => onNavigate("create-project")} className="px-4 py-2.5 rounded-xl text-sm font-semibold text-white hover:opacity-90" style={{ backgroundColor: "#176B45" }}>
            + Crear nuevo proyecto
          </button>
        </div>

        {/* Stats */}
        <div className="grid grid-cols-4 gap-4 mb-6">
          {[
            { label: "Proyectos activos", val: "2", icon: "📋" },
            { label: "Postulaciones", val: "12", icon: "📨" },
            { label: "Estudiantes en equipo", val: "3", icon: "👥" },
            { label: "Match promedio", val: "89%", icon: "🎯" },
          ].map((s) => (
            <div key={s.label} className="bg-white rounded-2xl p-4 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-2xl font-bold text-gray-900">{s.val}</p>
                  <p className="text-xs text-gray-500 mt-0.5">{s.label}</p>
                </div>
                <span className="text-2xl">{s.icon}</span>
              </div>
            </div>
          ))}
        </div>

        <div className="grid grid-cols-3 gap-6">
          {/* My projects */}
          <div className="col-span-2 space-y-5">
            <div className="bg-white rounded-2xl p-5 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <h2 className="font-semibold text-gray-900 mb-4">Mis proyectos</h2>
              <div className="space-y-3">
                {myProjects.map((p, i) => (
                  <button
                    key={p.title}
                    onClick={() => setActiveProject(i)}
                    className={`w-full p-4 rounded-xl text-left border transition-all ${activeProject === i ? "border-transparent" : "border-gray-100 hover:border-green-200"}`}
                    style={activeProject === i ? { backgroundColor: "#F0FDF4", borderColor: "#29A66A" } : { backgroundColor: "#F9FAFB" }}
                  >
                    <div className="flex items-start justify-between">
                      <div className="flex-1">
                        <p className="text-sm font-semibold text-gray-900">{p.title}</p>
                        <div className="flex items-center gap-3 mt-1.5 text-xs text-gray-500">
                          <span>📨 {p.applicants} postulantes</span>
                          <span>👥 {p.team} en equipo</span>
                          <span>🎯 {p.vacancies} vacantes</span>
                        </div>
                      </div>
                      <div className="flex items-center gap-2">
                        <span className="text-xs px-2.5 py-1 rounded-full font-semibold" style={p.status === "Activo" ? { backgroundColor: "#D1F2E2", color: "#0B3D2E" } : { backgroundColor: "#FEF3C7", color: "#92400E" }}>{p.status}</span>
                        <MatchScore score={p.match} size="sm" />
                      </div>
                    </div>
                  </button>
                ))}
              </div>
            </div>

            {/* Applicants */}
            <div className="bg-white rounded-2xl p-5 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <div className="flex items-center justify-between mb-4">
                <h2 className="font-semibold text-gray-900">Postulantes · {myProjects[activeProject].title.slice(0, 35)}...</h2>
                <select className="text-xs rounded-xl border px-2 py-1 outline-none" style={{ borderColor: "#D1FAE5" }}>
                  <option>Mayor compatibilidad</option>
                </select>
              </div>
              <div className="space-y-3">
                {applicants.map((a) => (
                  <div key={a.name} className="flex items-center gap-4 p-4 rounded-xl" style={{ backgroundColor: "#F7FAF8" }}>
                    <img src={a.img} alt={a.name} className="w-11 h-11 rounded-full object-cover" />
                    <div className="flex-1 min-w-0">
                      <p className="text-sm font-semibold text-gray-900">{a.name}</p>
                      <p className="text-xs text-gray-500 mt-0.5">{a.career}</p>
                      <div className="flex flex-wrap gap-1 mt-1.5">
                        {a.skills.map((s) => (
                          <span key={s} className="text-xs px-2 py-0.5 rounded-md" style={{ backgroundColor: "#F0FDF4", color: "#166534" }}>{s}</span>
                        ))}
                      </div>
                    </div>
                    <MatchScore score={a.match} size="sm" />
                    <div className="flex gap-2">
                      <button className="text-xs px-3 py-1.5 rounded-xl border font-medium hover:bg-gray-50" style={{ borderColor: "#E5E7EB", color: "#374151" }}>Ver perfil</button>
                      <button className="text-xs px-3 py-1.5 rounded-xl text-white font-medium hover:opacity-90" style={{ backgroundColor: "#176B45" }}>Aceptar</button>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>

          {/* Sidebar */}
          <div className="space-y-5">
            <div className="rounded-2xl p-5 text-white" style={{ background: "linear-gradient(135deg, #0B3D2E 0%, #176B45 100%)" }}>
              <p className="text-xs uppercase tracking-wider text-white/60 mb-3">Compatibilidad promedio</p>
              <div className="flex items-center gap-3">
                <MatchScore score={89} size="lg" />
                <div>
                  <p className="text-2xl font-bold">89%</p>
                  <p className="text-xs text-white/70">Tus proyectos atraen talento de alta calidad</p>
                </div>
              </div>
            </div>

            <div className="bg-white rounded-2xl p-5 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <h3 className="font-semibold text-gray-900 mb-3">Acciones rápidas</h3>
              <div className="space-y-2">
                {[
                  { label: "Crear proyecto", action: () => onNavigate("create-project") },
                  { label: "Ver mis equipos", action: () => onNavigate("my-team") },
                  { label: "Revisar solicitudes", action: () => onNavigate("requests") },
                  { label: "Explorar estudiantes", action: () => onNavigate("find-talents") },
                ].map((x) => (
                  <button key={x.label} onClick={x.action} className="w-full text-left px-3 py-2.5 rounded-xl text-sm hover:bg-gray-50 flex items-center gap-2 text-gray-700">
                    <div className="w-1.5 h-1.5 rounded-full" style={{ backgroundColor: "#29A66A" }} />
                    {x.label}
                  </button>
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>
    </Layout>
  );
}
