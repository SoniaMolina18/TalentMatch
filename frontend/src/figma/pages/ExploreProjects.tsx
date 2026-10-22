import { useState } from "react";
import Layout from "../components/Layout";
import MatchScore from "../components/MatchScore";
import { Page } from "../types";

interface Props {
  onNavigate: (page: Page) => void;
}

const projects = [
  { title: "Predicción de deserción universitaria con Machine Learning", teacher: "Carlos Ramírez", modality: "Remota", skills: ["Python", "SQL", "ML", "Data Analysis"], vacancies: 3, match: 94, category: "Ciencias de Datos", duration: "6 meses", dept: "Sistemas" },
  { title: "App móvil de bienestar estudiantil con IA conversacional", teacher: "María González", modality: "Híbrida", skills: ["React Native", "Node.js", "OpenAI API"], vacancies: 2, match: 88, category: "Desarrollo Móvil", duration: "4 meses", dept: "Sistemas" },
  { title: "Sistema blockchain para certificación académica", teacher: "Andrés Mora", modality: "Presencial", skills: ["Solidity", "Web3.js", "React"], vacancies: 4, match: 79, category: "Blockchain", duration: "8 meses", dept: "Electrónica" },
  { title: "Dashboard ESG para empresas colombianas con BI", teacher: "Lucía Herrera", modality: "Remota", skills: ["Power BI", "SQL", "Python", "Excel"], vacancies: 2, match: 76, category: "Business Intelligence", duration: "3 meses", dept: "Administración" },
  { title: "Plataforma de e-learning con gamificación adaptativa", teacher: "Roberto Suárez", modality: "Híbrida", skills: ["Vue.js", "Node.js", "MongoDB", "UX"], vacancies: 3, match: 72, category: "Educación", duration: "5 meses", dept: "Sistemas" },
  { title: "Optimización de rutas de transporte urbano con algoritmos genéticos", teacher: "Sandra Patiño", modality: "Presencial", skills: ["Python", "Algoritmos", "GIS", "Optimización"], vacancies: 2, match: 68, category: "Investigación", duration: "7 meses", dept: "Industrial" },
];

const categories = ["Todos", "Ciencias de Datos", "Desarrollo Móvil", "Blockchain", "Business Intelligence", "Educación", "Investigación"];
const modalities = ["Todos", "Remota", "Presencial", "Híbrida"];

export default function ExploreProjects({ onNavigate }: Props) {
  const [search, setSearch] = useState("");
  const [catFilter, setCatFilter] = useState("Todos");
  const [modalFilter, setModalFilter] = useState("Todos");
  const [view, setView] = useState<"grid" | "list">("grid");

  const filtered = projects.filter((p) => {
    const q = search.toLowerCase();
    const matchSearch = !q || p.title.toLowerCase().includes(q) || p.teacher.toLowerCase().includes(q) || p.skills.some((s) => s.toLowerCase().includes(q));
    const matchCat = catFilter === "Todos" || p.category === catFilter;
    const matchMod = modalFilter === "Todos" || p.modality === modalFilter;
    return matchSearch && matchCat && matchMod;
  });

  return (
    <Layout currentPage="explore" onNavigate={onNavigate}>
      {/* TopBar */}
      <div className="sticky top-0 z-30 bg-white/90 backdrop-blur-md border-b px-8 py-4 flex items-center gap-4" style={{ borderColor: "#E5EDE8" }}>
        <div className="flex-1 relative">
          <svg className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <circle cx="11" cy="11" r="8" /><line x1="21" y1="21" x2="16.65" y2="16.65" />
          </svg>
          <input
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder="Buscar por título, profesor, habilidad..."
            className="w-full pl-9 pr-4 py-2 text-sm rounded-xl border outline-none"
            style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }}
          />
        </div>
        <div className="flex gap-1 bg-gray-100 rounded-xl p-1">
          <button onClick={() => setView("grid")} className={`p-1.5 rounded-lg transition-all ${view === "grid" ? "bg-white shadow-sm" : "text-gray-400 hover:text-gray-600"}`}>
            <svg className="w-4 h-4" viewBox="0 0 24 24" fill="currentColor"><rect x="3" y="3" width="7" height="7" rx="1" /><rect x="14" y="3" width="7" height="7" rx="1" /><rect x="3" y="14" width="7" height="7" rx="1" /><rect x="14" y="14" width="7" height="7" rx="1" /></svg>
          </button>
          <button onClick={() => setView("list")} className={`p-1.5 rounded-lg transition-all ${view === "list" ? "bg-white shadow-sm" : "text-gray-400 hover:text-gray-600"}`}>
            <svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><line x1="8" y1="6" x2="21" y2="6" /><line x1="8" y1="12" x2="21" y2="12" /><line x1="8" y1="18" x2="21" y2="18" /><line x1="3" y1="6" x2="3.01" y2="6" /><line x1="3" y1="12" x2="3.01" y2="12" /><line x1="3" y1="18" x2="3.01" y2="18" /></svg>
          </button>
        </div>
      </div>

      <div className="flex flex-1">
        {/* Sidebar filters */}
        <aside className="w-56 shrink-0 p-6 border-r" style={{ borderColor: "#E5EDE8" }}>
          <h3 className="text-xs font-semibold uppercase tracking-wider text-gray-500 mb-3">Categoría</h3>
          <div className="space-y-1 mb-6">
            {categories.map((c) => (
              <button
                key={c}
                onClick={() => setCatFilter(c)}
                className={`w-full text-left px-3 py-2 rounded-xl text-sm transition-all ${catFilter === c ? "font-semibold text-white" : "text-gray-600 hover:bg-gray-50"}`}
                style={catFilter === c ? { backgroundColor: "#176B45" } : {}}
              >
                {c}
              </button>
            ))}
          </div>
          <h3 className="text-xs font-semibold uppercase tracking-wider text-gray-500 mb-3">Modalidad</h3>
          <div className="space-y-1 mb-6">
            {modalities.map((m) => (
              <button
                key={m}
                onClick={() => setModalFilter(m)}
                className={`w-full text-left px-3 py-2 rounded-xl text-sm transition-all ${modalFilter === m ? "font-semibold text-white" : "text-gray-600 hover:bg-gray-50"}`}
                style={modalFilter === m ? { backgroundColor: "#176B45" } : {}}
              >
                {m}
              </button>
            ))}
          </div>
          <h3 className="text-xs font-semibold uppercase tracking-wider text-gray-500 mb-3">Match mínimo</h3>
          <input type="range" min="0" max="100" defaultValue="0" disabled title="El backend no expone puntuaciones de compatibilidad para filtrar." className="w-full accent-green-600 opacity-50" />
          <div className="flex justify-between text-xs text-gray-400 mt-1"><span>60%</span><span>100%</span></div>
        </aside>

        {/* Main content */}
        <main className="flex-1 p-6">
          <div className="flex items-center justify-between mb-5">
            <p className="text-sm text-gray-500">{filtered.length} proyectos encontrados</p>
            <select disabled title="No se puede ordenar por compatibilidad sin datos reales de recomendación." className="text-sm rounded-xl border px-3 py-1.5 outline-none text-gray-400" style={{ borderColor: "#D1FAE5" }}>
              <option>Mayor compatibilidad</option>
              <option>Más recientes</option>
              <option>Más vacantes</option>
            </select>
          </div>

          {view === "grid" ? (
            <div className="grid grid-cols-2 xl:grid-cols-3 gap-4">
              {filtered.map((p) => (
                <div
                  key={p.title}
                  className="bg-white rounded-2xl p-5 shadow-sm border hover:shadow-md hover:-translate-y-0.5 transition-all cursor-pointer"
                  style={{ borderColor: "#E5EDE8" }}
                  onClick={() => onNavigate("project-detail")}
                >
                  <div className="flex items-start justify-between mb-3">
                    <span className="text-xs font-semibold px-2.5 py-1 rounded-full" style={{ backgroundColor: "#D1F2E2", color: "#0B3D2E" }}>{p.category}</span>
                    <MatchScore score={p.match} size="sm" />
                  </div>
                  <h3 className="text-sm font-semibold text-gray-900 leading-snug mb-2 line-clamp-2">{p.title}</h3>
                  <p className="text-xs text-gray-500 mb-3">Prof. {p.teacher} · {p.modality}</p>
                  <div className="flex flex-wrap gap-1 mb-3">
                    {p.skills.map((s) => (
                      <span key={s} className="text-xs px-2 py-0.5 rounded-md font-medium" style={{ backgroundColor: "#F0FDF4", color: "#166534" }}>{s}</span>
                    ))}
                  </div>
                  <div className="flex items-center justify-between pt-3 border-t" style={{ borderColor: "#F0F0F0" }}>
                    <span className="text-xs text-gray-500"><strong className="text-gray-700">{p.vacancies}</strong> vacantes · {p.duration}</span>
                    <button className="text-xs font-semibold px-3 py-1.5 rounded-lg text-white hover:opacity-90" style={{ backgroundColor: "#176B45" }}>
                      Ver proyecto
                    </button>
                  </div>
                </div>
              ))}
            </div>
          ) : (
            <div className="space-y-3">
              {filtered.map((p) => (
                <div
                  key={p.title}
                  className="bg-white rounded-2xl px-5 py-4 shadow-sm border flex items-center gap-4 hover:shadow-md transition-shadow cursor-pointer"
                  style={{ borderColor: "#E5EDE8" }}
                  onClick={() => onNavigate("project-detail")}
                >
                  <MatchScore score={p.match} size="md" />
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2 mb-1">
                      <h3 className="text-sm font-semibold text-gray-900 truncate">{p.title}</h3>
                      <span className="text-xs px-2 py-0.5 rounded-full shrink-0" style={{ backgroundColor: "#D1F2E2", color: "#0B3D2E" }}>{p.category}</span>
                    </div>
                    <p className="text-xs text-gray-500">Prof. {p.teacher} · {p.modality} · {p.duration}</p>
                  </div>
                  <div className="flex flex-wrap gap-1 shrink-0">
                    {p.skills.slice(0, 2).map((s) => (
                      <span key={s} className="text-xs px-2 py-0.5 rounded-md" style={{ backgroundColor: "#F0FDF4", color: "#166534" }}>{s}</span>
                    ))}
                  </div>
                  <span className="text-xs text-gray-500 shrink-0">{p.vacancies} vacantes</span>
                  <button className="text-xs font-semibold px-3 py-1.5 rounded-lg text-white shrink-0" style={{ backgroundColor: "#176B45" }}>Ver</button>
                </div>
              ))}
            </div>
          )}
        </main>
      </div>
    </Layout>
  );
}
