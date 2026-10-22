import { useState } from "react";
import Layout from "../components/Layout";
import MatchScore from "../components/MatchScore";
import { Page } from "../types";

interface Props {
  onNavigate: (page: Page) => void;
}

const teams = [
  {
    name: "DataSciUnal",
    project: "Predicción de deserción universitaria con ML",
    members: [
      { name: "Yuliana Pérez", role: "Analista de datos", skills: ["Python", "SQL", "Data Analysis"], img: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=60&h=60&fit=crop&auto=format", match: 94 },
      { name: "Santiago López", role: "ML Engineer", skills: ["Machine Learning", "TensorFlow", "Python"], img: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=60&h=60&fit=crop&auto=format", match: 89 },
      { name: "Felipe Moreno", role: "Estadístico", skills: ["R", "SPSS", "Visualización"], img: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=60&h=60&fit=crop&auto=format", match: 81 },
    ],
    coveredSkills: ["Python", "SQL", "Data Analysis", "Machine Learning", "R", "Visualización"],
    missingSkills: ["Cloud Computing", "MLOps"],
    teamMatch: 88,
    status: "Activo",
  },
  {
    name: "InnovateTech",
    project: "App móvil de bienestar estudiantil con IA",
    members: [
      { name: "Yuliana Pérez", role: "Analista UX", skills: ["UX Research", "Figma", "Python"], img: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=60&h=60&fit=crop&auto=format", match: 88 },
      { name: "Daniela Torres", role: "Diseñadora UI", skills: ["Figma", "Illustrator", "Prototyping"], img: "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=60&h=60&fit=crop&auto=format", match: 85 },
    ],
    coveredSkills: ["UX Research", "Figma", "Illustrator", "Python"],
    missingSkills: ["React Native", "Node.js", "OpenAI API"],
    teamMatch: 79,
    status: "Buscando miembros",
  },
];

export default function MyTeam({ onNavigate }: Props) {
  const [activeTeam, setActiveTeam] = useState(0);
  const team = teams[activeTeam];

  return (
    <Layout currentPage="my-team" onNavigate={onNavigate}>
      <div className="px-8 py-8 max-w-screen-xl">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h1 className="text-xl font-bold text-gray-900">Mi equipo</h1>
            <p className="text-sm text-gray-500 mt-0.5">Gestiona tus equipos y colaboradores</p>
          </div>
          <button className="text-sm font-semibold px-4 py-2 rounded-xl text-white hover:opacity-90" style={{ backgroundColor: "#176B45" }}>
            + Crear equipo
          </button>
        </div>

        {/* Team tabs */}
        <div className="flex gap-3 mb-6">
          {teams.map((t, i) => (
            <button
              key={t.name}
              onClick={() => setActiveTeam(i)}
              className={`px-4 py-2 rounded-xl text-sm font-medium border transition-all ${activeTeam === i ? "text-white border-transparent" : "bg-white text-gray-600 border-gray-200 hover:border-green-300"}`}
              style={activeTeam === i ? { backgroundColor: "#176B45" } : {}}
            >
              {t.name}
              <span className={`ml-2 text-xs px-1.5 py-0.5 rounded-full ${activeTeam === i ? "bg-white/20 text-white" : "bg-gray-100 text-gray-500"}`}>
                {t.members.length}
              </span>
            </button>
          ))}
        </div>

        <div className="grid grid-cols-3 gap-6">
          {/* Members */}
          <div className="col-span-2 space-y-4">
            {/* Team header */}
            <div className="bg-white rounded-2xl p-5 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <div className="flex items-start justify-between">
                <div>
                  <h2 className="text-lg font-bold text-gray-900">{team.name}</h2>
                  <p className="text-sm text-gray-500 mt-0.5">{team.project}</p>
                </div>
                <div className="flex items-center gap-3">
                  <span
                    className="text-xs font-semibold px-3 py-1 rounded-full"
                    style={team.status === "Activo" ? { backgroundColor: "#D1F2E2", color: "#0B3D2E" } : { backgroundColor: "#FEF3C7", color: "#92400E" }}
                  >
                    {team.status}
                  </span>
                  <MatchScore score={team.teamMatch} size="md" />
                </div>
              </div>
            </div>

            {/* Members list */}
            <div className="bg-white rounded-2xl p-5 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <h3 className="font-semibold text-gray-900 mb-4">Integrantes del equipo</h3>
              <div className="space-y-4">
                {team.members.map((m) => (
                  <div key={m.name} className="flex items-center gap-4 p-4 rounded-xl" style={{ backgroundColor: "#F7FAF8" }}>
                    <img src={m.img} alt={m.name} className="w-12 h-12 rounded-full object-cover shrink-0" />
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2">
                        <p className="text-sm font-semibold text-gray-900">{m.name}</p>
                        <span className="text-xs px-2 py-0.5 rounded-full" style={{ backgroundColor: "#D1F2E2", color: "#0B3D2E" }}>{m.role}</span>
                      </div>
                      <div className="flex flex-wrap gap-1 mt-1.5">
                        {m.skills.map((s) => (
                          <span key={s} className="text-xs px-2 py-0.5 rounded-md" style={{ backgroundColor: "#F0FDF4", color: "#166534" }}>{s}</span>
                        ))}
                      </div>
                    </div>
                    <MatchScore score={m.match} size="sm" />
                    <button className="text-gray-400 hover:text-gray-600 transition-colors">
                      <svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><circle cx="12" cy="12" r="1" /><circle cx="19" cy="12" r="1" /><circle cx="5" cy="12" r="1" /></svg>
                    </button>
                  </div>
                ))}

                {/* Invite slot */}
                <button
                  onClick={() => onNavigate("find-talents")}
                  className="w-full p-4 rounded-xl border-2 border-dashed flex items-center justify-center gap-2 text-sm font-medium transition-colors hover:bg-green-50"
                  style={{ borderColor: "#29A66A", color: "#176B45" }}
                >
                  <svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" /></svg>
                  Invitar nuevo miembro
                </button>
              </div>
            </div>

            {/* Activity timeline */}
            <div className="bg-white rounded-2xl p-5 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <h3 className="font-semibold text-gray-900 mb-4">Actividad del equipo</h3>
              <div className="space-y-4">
                {[
                  { text: "Santiago López completó el módulo de preprocesamiento de datos", time: "Hoy, 10:30 AM", type: "task" },
                  { text: "Reunión semanal realizada — acta disponible", time: "Ayer, 3:00 PM", type: "meeting" },
                  { text: "Yuliana Pérez subió el informe de análisis exploratorio", time: "Hace 3 días", type: "file" },
                ].map((a, i) => (
                  <div key={i} className="flex gap-3">
                    <div className="w-2 h-2 rounded-full mt-1.5 shrink-0" style={{ backgroundColor: "#29A66A" }} />
                    <div>
                      <p className="text-sm text-gray-700">{a.text}</p>
                      <p className="text-xs text-gray-400 mt-0.5">{a.time}</p>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>

          {/* Sidebar */}
          <div className="space-y-4">
            {/* Team compatibility */}
            <div className="bg-white rounded-2xl p-5 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <h3 className="font-semibold text-gray-900 mb-4">Compatibilidad del equipo</h3>
              <div className="flex items-center justify-center mb-4">
                <MatchScore score={team.teamMatch} size="lg" />
              </div>
              <p className="text-xs text-gray-500 text-center">Compatibilidad promedio del equipo</p>
            </div>

            {/* Covered skills */}
            <div className="bg-white rounded-2xl p-5 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <h3 className="font-semibold text-gray-900 mb-3">Habilidades cubiertas</h3>
              <div className="flex flex-wrap gap-1.5 mb-4">
                {team.coveredSkills.map((s) => (
                  <span key={s} className="text-xs px-2.5 py-1 rounded-full font-medium" style={{ backgroundColor: "#D1F2E2", color: "#166534" }}>✓ {s}</span>
                ))}
              </div>
              <h4 className="text-xs font-semibold uppercase tracking-wider text-gray-500 mb-2">Habilidades faltantes</h4>
              <div className="flex flex-wrap gap-1.5">
                {team.missingSkills.map((s) => (
                  <span key={s} className="text-xs px-2.5 py-1 rounded-full font-medium bg-amber-50 text-amber-700">⚠ {s}</span>
                ))}
              </div>
              <button
                onClick={() => onNavigate("find-talents")}
                className="mt-4 w-full py-2 rounded-xl text-sm font-medium text-white hover:opacity-90"
                style={{ backgroundColor: "#176B45" }}
              >
                Buscar talento complementario
              </button>
            </div>

            {/* Quick actions */}
            <div className="bg-white rounded-2xl p-5 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <h3 className="font-semibold text-gray-900 mb-3">Acciones rápidas</h3>
              <div className="space-y-2">
                {["Programar reunión", "Compartir archivos", "Ver proyecto", "Configurar equipo"].map((action) => (
                  <button key={action} className="w-full text-left px-3 py-2 rounded-xl text-sm text-gray-600 hover:bg-gray-50 transition-colors flex items-center gap-2">
                    <div className="w-1.5 h-1.5 rounded-full" style={{ backgroundColor: "#29A66A" }} />
                    {action}
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
