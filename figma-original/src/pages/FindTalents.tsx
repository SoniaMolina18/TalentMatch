import { useState } from "react";
import Layout from "../components/Layout";
import MatchScore from "../components/MatchScore";
import { Page } from "../types";

interface Props {
  onNavigate: (page: Page) => void;
}

const talents = [
  { name: "Santiago López", career: "Ing. de Sistemas", semester: "8vo", skills: ["React", "TypeScript", "Node.js", "PostgreSQL"], availability: "Tiempo completo", match: 92, img: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=80&h=80&fit=crop&auto=format", complementary: ["React", "TypeScript"] },
  { name: "Daniela Torres", career: "Diseño Industrial", semester: "6to", skills: ["Figma", "UX Research", "Illustrator", "Prototyping"], availability: "Medio tiempo", match: 85, img: "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=80&h=80&fit=crop&auto=format", complementary: ["Figma", "UX Research"] },
  { name: "Felipe Moreno", career: "Estadística", semester: "9no", skills: ["R", "Python", "SPSS", "Visualización"], availability: "Fines de semana", match: 81, img: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=80&h=80&fit=crop&auto=format", complementary: ["R", "SPSS"] },
  { name: "Valentina Cruz", career: "Administración", semester: "7mo", skills: ["Power BI", "Excel", "Gestión de proyectos", "Scrum"], availability: "Tiempo completo", match: 77, img: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=80&h=80&fit=crop&auto=format", complementary: ["Gestión de proyectos", "Scrum"] },
  { name: "Andrés Bermúdez", career: "Electrónica", semester: "8vo", skills: ["Arduino", "IoT", "C++", "Raspberry Pi"], availability: "Medio tiempo", match: 73, img: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=80&h=80&fit=crop&auto=format", complementary: ["IoT", "C++"] },
  { name: "María Fernanda Ríos", career: "Comunicación", semester: "5to", skills: ["Copywriting", "SEO", "Redes sociales", "Marketing digital"], availability: "Fines de semana", match: 69, img: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=80&h=80&fit=crop&auto=format", complementary: ["Marketing digital", "SEO"] },
];

const careers = ["Todos", "Ing. de Sistemas", "Diseño Industrial", "Estadística", "Administración", "Electrónica", "Comunicación"];
const availabilities = ["Todos", "Tiempo completo", "Medio tiempo", "Fines de semana"];

export default function FindTalents({ onNavigate }: Props) {
  const [search, setSearch] = useState("");
  const [careerFilter, setCareerFilter] = useState("Todos");
  const [availFilter, setAvailFilter] = useState("Todos");

  const filtered = talents.filter((t) => {
    const q = search.toLowerCase();
    const matchQ = !q || t.name.toLowerCase().includes(q) || t.career.toLowerCase().includes(q) || t.skills.some((s) => s.toLowerCase().includes(q));
    const matchC = careerFilter === "Todos" || t.career === careerFilter;
    const matchA = availFilter === "Todos" || t.availability === availFilter;
    return matchQ && matchC && matchA;
  });

  return (
    <Layout currentPage="find-talents" onNavigate={onNavigate}>
      <div className="sticky top-0 z-30 bg-white/90 backdrop-blur-md border-b px-8 py-4 flex items-center gap-4" style={{ borderColor: "#E5EDE8" }}>
        <div className="relative flex-1 max-w-md">
          <svg className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><circle cx="11" cy="11" r="8" /><line x1="21" y1="21" x2="16.65" y2="16.65" /></svg>
          <input value={search} onChange={(e) => setSearch(e.target.value)} placeholder="Buscar por nombre, carrera, habilidad..." className="w-full pl-9 pr-4 py-2 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }} />
        </div>
        <select onChange={(e) => setCareerFilter(e.target.value)} className="text-sm rounded-xl border px-3 py-2 outline-none" style={{ borderColor: "#D1FAE5" }}>
          {careers.map((c) => <option key={c}>{c}</option>)}
        </select>
        <select onChange={(e) => setAvailFilter(e.target.value)} className="text-sm rounded-xl border px-3 py-2 outline-none" style={{ borderColor: "#D1FAE5" }}>
          {availabilities.map((a) => <option key={a}>{a}</option>)}
        </select>
      </div>

      <div className="px-8 py-8 max-w-screen-xl">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h1 className="text-xl font-bold text-gray-900">Encontrar talentos</h1>
            <p className="text-sm text-gray-500 mt-0.5">{filtered.length} estudiantes compatibles con tu perfil</p>
          </div>
          <button className="text-sm font-medium px-4 py-2 rounded-xl text-white" style={{ backgroundColor: "#176B45" }}>
            + Crear equipo
          </button>
        </div>

        <div className="grid grid-cols-2 gap-4">
          {filtered.map((t) => (
            <div key={t.name} className="bg-white rounded-2xl p-5 shadow-sm border hover:shadow-md transition-all" style={{ borderColor: "#E5EDE8" }}>
              <div className="flex items-start gap-4">
                <img src={t.img} alt={t.name} className="w-14 h-14 rounded-full object-cover ring-2 ring-green-200" />
                <div className="flex-1 min-w-0">
                  <div className="flex items-start justify-between">
                    <div>
                      <h3 className="text-sm font-semibold text-gray-900">{t.name}</h3>
                      <p className="text-xs text-gray-500 mt-0.5">{t.career} · {t.semester} sem.</p>
                    </div>
                    <MatchScore score={t.match} size="sm" />
                  </div>

                  {/* Availability */}
                  <div className="flex items-center gap-1.5 mt-2">
                    <div className="w-1.5 h-1.5 rounded-full" style={{ backgroundColor: "#29A66A" }} />
                    <span className="text-xs text-gray-500">{t.availability}</span>
                  </div>

                  {/* All skills */}
                  <div className="flex flex-wrap gap-1 mt-2">
                    {t.skills.map((s) => {
                      const isComp = t.complementary.includes(s);
                      return (
                        <span
                          key={s}
                          className="text-xs px-2 py-0.5 rounded-md font-medium"
                          style={isComp
                            ? { backgroundColor: "#D1F2E2", color: "#166534" }
                            : { backgroundColor: "#F3F4F6", color: "#6B7280" }
                          }
                        >
                          {s}
                        </span>
                      );
                    })}
                  </div>

                  {/* Complementary indicator */}
                  <div className="mt-2 text-xs" style={{ color: "#176B45" }}>
                    🔄 Complementa: {t.complementary.join(", ")}
                  </div>
                </div>
              </div>

              <div className="flex gap-2 mt-4 pt-3 border-t" style={{ borderColor: "#F0F0F0" }}>
                <button
                  onClick={() => onNavigate("student-profile")}
                  className="flex-1 py-2 rounded-xl border text-sm font-medium transition-colors hover:bg-gray-50"
                  style={{ borderColor: "#29A66A", color: "#176B45" }}
                >
                  Ver perfil
                </button>
                <button
                  className="flex-1 py-2 rounded-xl text-white text-sm font-medium transition-colors hover:opacity-90"
                  style={{ backgroundColor: "#176B45" }}
                >
                  Invitar al equipo
                </button>
                <button className="py-2 px-3 rounded-xl border text-gray-400 hover:bg-gray-50 transition-colors" style={{ borderColor: "#E5E7EB" }}>
                  <svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M21 15a2 2 0 01-2 2H7l-4 4V5a2 2 0 012-2h14a2 2 0 012 2z" /></svg>
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>
    </Layout>
  );
}
