import { useState } from "react";
import Layout from "../components/Layout";
import { Page } from "../types";

interface Props {
  onNavigate: (page: Page) => void;
}

const recentUsers = [
  { name: "Yuliana Pérez", role: "Estudiante", career: "Ing. Sistemas", status: "Activo", joined: "Sep 1, 2026", img: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=60&h=60&fit=crop&auto=format" },
  { name: "Santiago López", role: "Estudiante", career: "Ing. Sistemas", status: "Activo", joined: "Sep 2, 2026", img: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=60&h=60&fit=crop&auto=format" },
  { name: "Dr. Carlos Ramírez", role: "Profesor", career: "PhD Ciencias de Datos", status: "Activo", joined: "Ago 28, 2026", img: "https://images.unsplash.com/photo-1568602471122-7832951cc4c5?w=60&h=60&fit=crop&auto=format" },
  { name: "Daniela Torres", role: "Estudiante", career: "Diseño Industrial", status: "Inactivo", joined: "Ago 30, 2026", img: "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=60&h=60&fit=crop&auto=format" },
];

const recentProjects = [
  { title: "Predicción de deserción universitaria con ML", teacher: "Carlos Ramírez", status: "Activo", applicants: 8 },
  { title: "App móvil de bienestar estudiantil con IA", teacher: "María González", status: "Reclutando", applicants: 5 },
  { title: "Sistema blockchain para certificación académica", teacher: "Andrés Mora", status: "Revisión", applicants: 3 },
];

export default function AdminPanel({ onNavigate }: Props) {
  const [tab, setTab] = useState<"users" | "projects" | "reports">("users");

  return (
    <Layout currentPage="admin-panel" onNavigate={onNavigate}>
      <div className="px-8 py-8 max-w-screen-xl">
        {/* Header */}
        <div className="flex items-center justify-between mb-6">
          <div>
            <div className="flex items-center gap-2 mb-1">
              <span className="text-xs font-semibold px-2.5 py-1 rounded-full text-white" style={{ backgroundColor: "#0B3D2E" }}>Panel Administrador</span>
            </div>
            <h1 className="text-xl font-bold text-gray-900">Gestión de TalentMatch</h1>
            <p className="text-sm text-gray-500 mt-0.5">Universidad CUN</p>
          </div>
          <div className="flex items-center gap-3">
            <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=60&h=60&fit=crop&auto=format" alt="Admin" className="w-10 h-10 rounded-full object-cover" />
            <div>
              <p className="text-sm font-semibold text-gray-900">Admin Principal</p>
              <p className="text-xs text-gray-500">Superadministrador</p>
            </div>
          </div>
        </div>

        {/* Global stats */}
        <div className="grid grid-cols-5 gap-4 mb-6">
          {[
            { label: "Estudiantes", val: "2,431", change: "+48 este mes", icon: "👥" },
            { label: "Profesores", val: "127", change: "+5 este mes", icon: "👨‍🏫" },
            { label: "Proyectos activos", val: "384", change: "+22 este mes", icon: "📋" },
            { label: "Equipos formados", val: "196", change: "+14 este mes", icon: "🤝" },
            { label: "Match promedio global", val: "83%", change: "+2% vs mes anterior", icon: "🎯" },
          ].map((s) => (
            <div key={s.label} className="bg-white rounded-2xl p-4 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <div className="flex items-center justify-between mb-1">
                <span className="text-xl">{s.icon}</span>
              </div>
              <p className="text-2xl font-bold text-gray-900">{s.val}</p>
              <p className="text-xs text-gray-400 mt-0.5">{s.label}</p>
              <p className="text-xs mt-1" style={{ color: "#29A66A" }}>{s.change}</p>
            </div>
          ))}
        </div>

        {/* Charts row */}
        <div className="grid grid-cols-3 gap-5 mb-6">
          {/* Activity chart placeholder */}
          <div className="col-span-2 bg-white rounded-2xl p-5 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
            <h3 className="font-semibold text-gray-900 mb-4">Actividad mensual</h3>
            <div className="flex items-end gap-2 h-32">
              {[40, 65, 55, 80, 70, 90, 75, 95, 85, 78, 88, 100].map((h, i) => (
                <div key={i} className="flex-1 flex flex-col items-center gap-1">
                  <div className="w-full rounded-t-lg transition-all" style={{ height: `${h}%`, background: i === 11 ? "linear-gradient(180deg, #29A66A, #176B45)" : "#D1F2E2" }} />
                  <span className="text-xs text-gray-400">
                    {["E","F","M","A","M","J","J","A","S","O","N","D"][i]}
                  </span>
                </div>
              ))}
            </div>
          </div>

          {/* Match distribution */}
          <div className="bg-white rounded-2xl p-5 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
            <h3 className="font-semibold text-gray-900 mb-4">Distribución de Match</h3>
            <div className="space-y-3">
              {[
                { range: "90-100%", pct: 35, color: "#29A66A" },
                { range: "80-89%", pct: 28, color: "#176B45" },
                { range: "70-79%", pct: 22, color: "#0B3D2E" },
                { range: "60-69%", pct: 10, color: "#D1F2E2" },
                { range: "<60%", pct: 5, color: "#E5EDE8" },
              ].map((d) => (
                <div key={d.range}>
                  <div className="flex justify-between text-xs mb-1">
                    <span className="text-gray-600">{d.range}</span>
                    <span className="font-medium text-gray-900">{d.pct}%</span>
                  </div>
                  <div className="h-2 bg-gray-100 rounded-full overflow-hidden">
                    <div className="h-full rounded-full" style={{ width: `${d.pct}%`, backgroundColor: d.color }} />
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Tabs */}
        <div className="flex gap-1 bg-gray-100 rounded-xl p-1 w-fit mb-5">
          {([["users", "Usuarios"], ["projects", "Proyectos"], ["reports", "Reportes"]] as const).map(([id, label]) => (
            <button
              key={id}
              onClick={() => setTab(id)}
              className={`px-4 py-1.5 rounded-lg text-sm font-medium transition-all ${tab === id ? "bg-white shadow-sm text-gray-900" : "text-gray-500 hover:text-gray-700"}`}
            >
              {label}
            </button>
          ))}
        </div>

        {tab === "users" && (
          <div className="bg-white rounded-2xl shadow-sm border overflow-hidden" style={{ borderColor: "#E5EDE8" }}>
            <div className="px-5 py-4 border-b flex items-center justify-between" style={{ borderColor: "#F5F5F5" }}>
              <h3 className="font-semibold text-gray-900">Usuarios recientes</h3>
              <button className="text-xs font-medium px-3 py-1.5 rounded-xl text-white" style={{ backgroundColor: "#176B45" }}>+ Agregar usuario</button>
            </div>
            <table className="w-full">
              <thead>
                <tr style={{ backgroundColor: "#F7FAF8" }}>
                  {["Usuario", "Rol", "Área", "Estado", "Registro", "Acciones"].map((h) => (
                    <th key={h} className="text-left text-xs font-semibold uppercase tracking-wider text-gray-500 px-5 py-3">{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {recentUsers.map((u, i) => (
                  <tr key={u.name} className="border-t hover:bg-gray-50 transition-colors" style={{ borderColor: "#F5F5F5" }}>
                    <td className="px-5 py-3">
                      <div className="flex items-center gap-3">
                        <img src={u.img} alt={u.name} className="w-8 h-8 rounded-full object-cover" />
                        <span className="text-sm font-medium text-gray-900">{u.name}</span>
                      </div>
                    </td>
                    <td className="px-5 py-3">
                      <span className="text-xs px-2.5 py-1 rounded-full font-medium" style={u.role === "Profesor" ? { backgroundColor: "#EDE9FE", color: "#5B21B6" } : { backgroundColor: "#D1F2E2", color: "#0B3D2E" }}>{u.role}</span>
                    </td>
                    <td className="px-5 py-3 text-sm text-gray-500">{u.career}</td>
                    <td className="px-5 py-3">
                      <div className="flex items-center gap-1.5">
                        <div className="w-1.5 h-1.5 rounded-full" style={{ backgroundColor: u.status === "Activo" ? "#29A66A" : "#D1D5DB" }} />
                        <span className="text-sm text-gray-600">{u.status}</span>
                      </div>
                    </td>
                    <td className="px-5 py-3 text-sm text-gray-500">{u.joined}</td>
                    <td className="px-5 py-3">
                      <div className="flex gap-2">
                        <button className="text-xs px-2.5 py-1 rounded-lg border hover:bg-gray-50" style={{ borderColor: "#E5E7EB", color: "#374151" }}>Editar</button>
                        <button className="text-xs px-2.5 py-1 rounded-lg border hover:bg-red-50 text-red-500" style={{ borderColor: "#FCA5A5" }}>Suspender</button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}

        {tab === "projects" && (
          <div className="bg-white rounded-2xl shadow-sm border overflow-hidden" style={{ borderColor: "#E5EDE8" }}>
            <div className="px-5 py-4 border-b" style={{ borderColor: "#F5F5F5" }}>
              <h3 className="font-semibold text-gray-900">Proyectos recientes</h3>
            </div>
            <table className="w-full">
              <thead>
                <tr style={{ backgroundColor: "#F7FAF8" }}>
                  {["Proyecto", "Profesor", "Estado", "Postulantes", "Acciones"].map((h) => (
                    <th key={h} className="text-left text-xs font-semibold uppercase tracking-wider text-gray-500 px-5 py-3">{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {recentProjects.map((p) => (
                  <tr key={p.title} className="border-t hover:bg-gray-50" style={{ borderColor: "#F5F5F5" }}>
                    <td className="px-5 py-3 text-sm font-medium text-gray-900 max-w-xs truncate">{p.title}</td>
                    <td className="px-5 py-3 text-sm text-gray-500">{p.teacher}</td>
                    <td className="px-5 py-3">
                      <span className="text-xs px-2.5 py-1 rounded-full font-medium"
                        style={p.status === "Activo" ? { backgroundColor: "#D1F2E2", color: "#0B3D2E" } : p.status === "Reclutando" ? { backgroundColor: "#FEF3C7", color: "#92400E" } : { backgroundColor: "#E0E7FF", color: "#3730A3" }}>
                        {p.status}
                      </span>
                    </td>
                    <td className="px-5 py-3 text-sm text-gray-700 font-semibold">{p.applicants}</td>
                    <td className="px-5 py-3">
                      <div className="flex gap-2">
                        <button className="text-xs px-2.5 py-1 rounded-lg border hover:bg-gray-50" style={{ borderColor: "#E5E7EB" }}>Ver</button>
                        <button className="text-xs px-2.5 py-1 rounded-lg border hover:bg-red-50 text-red-500" style={{ borderColor: "#FCA5A5" }}>Archivar</button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}

        {tab === "reports" && (
          <div className="grid grid-cols-2 gap-5">
            {[
              { title: "Reporte de compatibilidad global", desc: "Análisis de distribución de match scores por carrera y semestre.", icon: "📊" },
              { title: "Actividad de usuarios", desc: "Logins, postulaciones y mensajes del último mes.", icon: "📈" },
              { title: "Proyectos más populares", desc: "Top 10 proyectos por número de postulantes.", icon: "🏆" },
              { title: "Habilidades más demandadas", desc: "Ranking de habilidades requeridas por profesores.", icon: "💡" },
            ].map((r) => (
              <div key={r.title} className="bg-white rounded-2xl p-5 shadow-sm border hover:shadow-md transition-all cursor-pointer" style={{ borderColor: "#E5EDE8" }}>
                <div className="text-3xl mb-3">{r.icon}</div>
                <h3 className="font-semibold text-gray-900 mb-1">{r.title}</h3>
                <p className="text-sm text-gray-500">{r.desc}</p>
                <button className="mt-4 text-sm font-medium" style={{ color: "#176B45" }}>Descargar PDF →</button>
              </div>
            ))}
          </div>
        )}
      </div>
    </Layout>
  );
}
