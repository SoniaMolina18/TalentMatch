import { useState } from "react";
import Layout from "../components/Layout";
import MatchScore from "../components/MatchScore";
import { Page } from "../types";

interface Props {
  onNavigate: (page: Page) => void;
}

const recommendedProjects = [
  {
    title: "Predicción de deserción universitaria con Machine Learning",
    description: "Desarrollar modelos predictivos para identificar estudiantes en riesgo de abandonar sus estudios mediante técnicas de ML avanzadas.",
    teacher: "Carlos Ramírez",
    modality: "Remota",
    skills: ["Python", "SQL", "Machine Learning", "Data Analysis"],
    vacancies: 3,
    match: 94,
    category: "Ciencias de Datos",
    duration: "6 meses",
  },
  {
    title: "App móvil de bienestar estudiantil con IA conversacional",
    description: "Crear una aplicación de apoyo emocional y académico para estudiantes universitarios integrando chatbots con IA generativa.",
    teacher: "María González",
    modality: "Híbrida",
    skills: ["React Native", "Node.js", "OpenAI API", "UX Design"],
    vacancies: 2,
    match: 88,
    category: "Desarrollo Móvil",
    duration: "4 meses",
  },
  {
    title: "Sistema blockchain para certificación de competencias académicas",
    description: "Plataforma descentralizada para emitir y verificar certificados académicos usando tecnología blockchain.",
    teacher: "Andrés Mora",
    modality: "Presencial",
    skills: ["Solidity", "Web3.js", "React", "Node.js"],
    vacancies: 4,
    match: 79,
    category: "Blockchain",
    duration: "8 meses",
  },
];

const talents = [
  {
    name: "Santiago López",
    career: "Ing. de Sistemas",
    semester: "8vo semestre",
    skills: ["React", "TypeScript", "Node.js", "PostgreSQL"],
    availability: "Tiempo completo",
    match: 92,
    img: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=80&h=80&fit=crop&auto=format",
  },
  {
    name: "Daniela Torres",
    career: "Diseño Industrial",
    semester: "6to semestre",
    skills: ["Figma", "UX Research", "Illustrator", "Prototyping"],
    availability: "Medio tiempo",
    match: 85,
    img: "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=80&h=80&fit=crop&auto=format",
  },
  {
    name: "Felipe Moreno",
    career: "Estadística",
    semester: "9no semestre",
    skills: ["R", "Python", "SPSS", "Visualización de datos"],
    availability: "Fines de semana",
    match: 81,
    img: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=80&h=80&fit=crop&auto=format",
  },
];

const activities = [
  { type: "accepted", text: "Tu postulación al proyecto 'Dashboard ESG con IA' fue aceptada", time: "Hace 2 horas", color: "#29A66A" },
  { type: "invite", text: "Santiago López te invitó a unirte al equipo 'DataSciUnal'", time: "Hace 5 horas", color: "#176B45" },
  { type: "new", text: "3 nuevos proyectos compatibles con tu perfil disponibles", time: "Hace 1 día", color: "#0B3D2E" },
  { type: "review", text: "El profesor Carlos Ramírez revisó tu perfil", time: "Hace 2 días", color: "#29A66A" },
];

export default function Dashboard({ onNavigate }: Props) {
  const [search, setSearch] = useState("");

  return (
    <Layout currentPage="dashboard" onNavigate={onNavigate}>
      {/* TopBar */}
      <div
        className="sticky top-0 z-30 bg-white/90 backdrop-blur-md border-b px-8 py-4 flex items-center gap-4"
        style={{ borderColor: "#E5EDE8" }}
      >
        <div className="flex-1">
          <div className="relative max-w-md">
            <svg
              className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4"
              style={{ color: "#9CA3AF" }}
              viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"
            >
              <circle cx="11" cy="11" r="8" /><line x1="21" y1="21" x2="16.65" y2="16.65" />
            </svg>
            <input
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              placeholder="Buscar proyectos, estudiantes, habilidades..."
              className="w-full pl-9 pr-4 py-2 text-sm rounded-xl border outline-none transition-all focus:ring-2"
              style={{
                borderColor: "#D1FAE5",
                backgroundColor: "#F7FAF8",
                fontFamily: "'Inter', sans-serif",
              }}
            />
          </div>
        </div>
        <button className="relative p-2 rounded-xl hover:bg-gray-100 transition-colors">
          <svg className="w-5 h-5 text-gray-500" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <path d="M18 8A6 6 0 006 8c0 7-3 9-3 9h18s-3-2-3-9" /><path d="M13.73 21a2 2 0 01-3.46 0" />
          </svg>
          <span className="absolute top-1.5 right-1.5 w-2 h-2 rounded-full" style={{ backgroundColor: "#29A66A" }} />
        </button>
        <img
          src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=80&h=80&fit=crop&auto=format"
          alt="Yuliana"
          className="w-9 h-9 rounded-full object-cover ring-2 ring-green-300 cursor-pointer"
          onClick={() => onNavigate("student-profile")}
        />
      </div>

      <main className="px-8 py-8 space-y-8 max-w-screen-xl">
        {/* Greeting */}
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Hola, Yuliana 👋</h1>
          <p className="text-sm mt-1" style={{ color: "#6B7280" }}>
            Tienes 12 proyectos nuevos compatibles con tu perfil esta semana.
          </p>
        </div>

        {/* Stats cards */}
        <div className="grid grid-cols-4 gap-5">
          {[
            { label: "Match promedio", value: "87%", sub: "+3% esta semana", icon: "🎯", accent: "#29A66A" },
            { label: "Proyectos recomendados", value: "12", sub: "3 nuevos hoy", icon: "📋", accent: "#176B45" },
            { label: "Solicitudes activas", value: "4", sub: "2 pendientes de respuesta", icon: "📨", accent: "#0B3D2E" },
            { label: "Equipos activos", value: "2", sub: "1 en busca de miembros", icon: "👥", accent: "#29A66A" },
          ].map((stat) => (
            <div
              key={stat.label}
              className="bg-white rounded-2xl p-5 shadow-sm border hover:shadow-md transition-shadow"
              style={{ borderColor: "#E5EDE8" }}
            >
              <div className="flex items-start justify-between">
                <div>
                  <p className="text-xs font-medium uppercase tracking-wider" style={{ color: "#9CA3AF" }}>
                    {stat.label}
                  </p>
                  <p className="text-3xl font-bold mt-1 text-gray-900">{stat.value}</p>
                  <p className="text-xs mt-1" style={{ color: stat.accent }}>
                    {stat.sub}
                  </p>
                </div>
                <span className="text-2xl">{stat.icon}</span>
              </div>
            </div>
          ))}
        </div>

        {/* Recommended projects */}
        <section>
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Proyectos recomendados para ti</h2>
            <button
              onClick={() => onNavigate("explore")}
              className="text-sm font-medium hover:underline"
              style={{ color: "#176B45" }}
            >
              Ver todos →
            </button>
          </div>
          <div className="grid grid-cols-3 gap-5">
            {recommendedProjects.map((project) => (
              <div
                key={project.title}
                className="bg-white rounded-2xl p-5 shadow-sm border hover:shadow-md hover:-translate-y-0.5 transition-all cursor-pointer"
                style={{ borderColor: "#E5EDE8" }}
                onClick={() => onNavigate("project-detail")}
              >
                <div className="flex items-start justify-between mb-3">
                  <span
                    className="text-xs font-semibold px-2.5 py-1 rounded-full"
                    style={{ backgroundColor: "#D1F2E2", color: "#0B3D2E" }}
                  >
                    {project.category}
                  </span>
                  <MatchScore score={project.match} size="sm" />
                </div>
                <h3 className="text-sm font-semibold text-gray-900 leading-snug mb-2 line-clamp-2">
                  {project.title}
                </h3>
                <p className="text-xs text-gray-500 leading-relaxed mb-3 line-clamp-2">
                  {project.description}
                </p>
                <div className="flex items-center gap-1.5 mb-3">
                  <svg className="w-3.5 h-3.5 text-gray-400" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                    <path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2" /><circle cx="12" cy="7" r="4" />
                  </svg>
                  <span className="text-xs text-gray-500">Prof. {project.teacher}</span>
                  <span className="text-gray-300 mx-1">·</span>
                  <span className="text-xs" style={{ color: "#176B45" }}>{project.modality}</span>
                </div>
                <div className="flex flex-wrap gap-1 mb-3">
                  {project.skills.map((s) => (
                    <span
                      key={s}
                      className="text-xs px-2 py-0.5 rounded-md font-medium"
                      style={{ backgroundColor: "#F0FDF4", color: "#166534" }}
                    >
                      {s}
                    </span>
                  ))}
                </div>
                <div className="flex items-center justify-between pt-3 border-t" style={{ borderColor: "#F0F0F0" }}>
                  <span className="text-xs text-gray-500">
                    <strong className="text-gray-700">{project.vacancies}</strong> vacantes · {project.duration}
                  </span>
                  <button
                    className="text-xs font-semibold px-3 py-1.5 rounded-lg text-white transition-colors hover:opacity-90"
                    style={{ backgroundColor: "#176B45" }}
                  >
                    Ver proyecto
                  </button>
                </div>
              </div>
            ))}
          </div>
        </section>

        {/* Talents + Activity side by side */}
        <div className="grid grid-cols-5 gap-6">
          {/* Talents */}
          <section className="col-span-3">
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-lg font-semibold text-gray-900">Personas que complementan tu perfil</h2>
              <button
                onClick={() => onNavigate("find-talents")}
                className="text-sm font-medium hover:underline"
                style={{ color: "#176B45" }}
              >
                Ver más →
              </button>
            </div>
            <div className="space-y-3">
              {talents.map((t) => (
                <div
                  key={t.name}
                  className="bg-white rounded-2xl p-4 shadow-sm border flex items-center gap-4 hover:shadow-md transition-shadow"
                  style={{ borderColor: "#E5EDE8" }}
                >
                  <img src={t.img} alt={t.name} className="w-12 h-12 rounded-full object-cover shrink-0" />
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2">
                      <span className="text-sm font-semibold text-gray-900">{t.name}</span>
                      <span className="text-xs text-gray-400">·</span>
                      <span className="text-xs text-gray-500">{t.semester}</span>
                    </div>
                    <p className="text-xs text-gray-500 mb-2">{t.career}</p>
                    <div className="flex flex-wrap gap-1">
                      {t.skills.slice(0, 3).map((s) => (
                        <span
                          key={s}
                          className="text-xs px-2 py-0.5 rounded-md"
                          style={{ backgroundColor: "#F0FDF4", color: "#166534" }}
                        >
                          {s}
                        </span>
                      ))}
                      {t.skills.length > 3 && (
                        <span className="text-xs px-2 py-0.5 rounded-md bg-gray-100 text-gray-500">
                          +{t.skills.length - 3}
                        </span>
                      )}
                    </div>
                  </div>
                  <div className="flex flex-col items-center gap-2 shrink-0">
                    <MatchScore score={t.match} size="sm" />
                    <div className="flex gap-1.5">
                      <button
                        className="text-xs px-2.5 py-1 rounded-lg border font-medium transition-colors hover:bg-gray-50"
                        style={{ borderColor: "#29A66A", color: "#176B45" }}
                        onClick={() => onNavigate("student-profile")}
                      >
                        Ver perfil
                      </button>
                      <button
                        className="text-xs px-2.5 py-1 rounded-lg font-medium text-white transition-colors hover:opacity-90"
                        style={{ backgroundColor: "#176B45" }}
                      >
                        Invitar
                      </button>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </section>

          {/* Activity */}
          <section className="col-span-2">
            <h2 className="text-lg font-semibold text-gray-900 mb-4">Actividad reciente</h2>
            <div className="bg-white rounded-2xl p-5 shadow-sm border space-y-4" style={{ borderColor: "#E5EDE8" }}>
              {activities.map((a, i) => (
                <div key={i} className="flex gap-3">
                  <div
                    className="w-2 h-2 rounded-full mt-1.5 shrink-0"
                    style={{ backgroundColor: a.color }}
                  />
                  <div>
                    <p className="text-sm text-gray-700 leading-snug">{a.text}</p>
                    <p className="text-xs text-gray-400 mt-1">{a.time}</p>
                  </div>
                </div>
              ))}
              <button className="w-full text-center text-xs font-medium pt-2 border-t" style={{ borderColor: "#F0F0F0", color: "#176B45" }}>
                Ver toda la actividad
              </button>
            </div>

            {/* TalentMatch Score widget */}
            <div
              className="mt-4 rounded-2xl p-5 text-white"
              style={{ background: "linear-gradient(135deg, #0B3D2E 0%, #176B45 100%)" }}
            >
              <p className="text-xs font-semibold uppercase tracking-wider text-white/60 mb-3">
                Tu TalentMatch Score
              </p>
              <div className="flex items-center gap-4">
                <MatchScore score={87} size="lg" />
                <div>
                  <p className="text-2xl font-bold">87%</p>
                  <p className="text-xs text-white/70 mt-0.5">Compatibilidad promedio</p>
                  <p className="text-xs mt-2" style={{ color: "#86EFAC" }}>
                    ↑ Mejoró 3% esta semana
                  </p>
                </div>
              </div>
              <div className="mt-4 pt-4 border-t border-white/10 grid grid-cols-3 gap-2 text-center">
                {[
                  { label: "Habilidades", val: "12" },
                  { label: "Proyectos", val: "5" },
                  { label: "Certificados", val: "3" },
                ].map((x) => (
                  <div key={x.label}>
                    <p className="text-base font-bold">{x.val}</p>
                    <p className="text-xs text-white/60">{x.label}</p>
                  </div>
                ))}
              </div>
            </div>
          </section>
        </div>
      </main>
    </Layout>
  );
}
