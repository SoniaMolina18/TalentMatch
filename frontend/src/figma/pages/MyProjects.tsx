import { useEffect, useState } from "react";
import Layout from "../components/Layout";
import { Page } from "../types";
import { ApiError, api } from "../../services/apiClient";
import type { CollaborativeProject, Interest, Skill } from "../../types/api";

interface Props { onNavigate: (page: Page) => void; }

export default function MyProjects({ onNavigate }: Props) {
  const [projects, setProjects] = useState<CollaborativeProject[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [skills, setSkills] = useState<Skill[]>([]);
  const [interests, setInterests] = useState<Interest[]>([]);

  useEffect(() => {
	Promise.all([api.myCollaborativeProjects(), api.skills(), api.interests()])
	  .then(([loadedProjects, loadedSkills, loadedInterests]) => { setProjects(loadedProjects); setSkills(loadedSkills); setInterests(loadedInterests); })
	  .catch(err => setError(err instanceof ApiError ? err.message : "No se pudieron cargar tus proyectos."))
	  .finally(() => setLoading(false));
  }, []);

  return <Layout currentPage="my-projects" onNavigate={onNavigate}>
	<div className="px-8 py-8">
	  <div className="flex flex-wrap items-center justify-between gap-3">
		<div><h1 className="text-2xl font-bold text-gray-900">Mis proyectos</h1><p className="mt-1 text-sm text-gray-500">Proyectos colaborativos que lideras.</p></div>
		<button onClick={() => onNavigate("create-collaborative-project")} className="rounded-xl bg-brand-dark px-4 py-2.5 text-sm font-semibold text-white">Crear proyecto</button>
	  </div>
	  {loading && <p className="mt-8 text-sm text-gray-500">Cargando proyectos...</p>}
	  {!loading && error && <div className="mt-8 rounded-xl bg-red-50 px-4 py-3 text-sm text-red-700">{error}</div>}
	  {!loading && !error && projects.length === 0 && <div className="mt-8 rounded-2xl border-2 border-dashed border-[#D1F2E2] bg-white p-10 text-center text-sm text-gray-500">Aún no has creado proyectos colaborativos.</div>}
	  <div className="mt-6 grid gap-5 lg:grid-cols-2">{projects.map(project => {
		const members = project.equipo?.miembros ?? [];
		return <article key={project.id} className="rounded-2xl border border-[#E5EDE8] bg-white p-6 shadow-sm">
		  <div className="flex items-start justify-between gap-3"><div><h2 className="text-lg font-semibold text-gray-900">{project.titulo}</h2><p className="mt-1 text-xs text-gray-500">Proyecto colaborativo · {project.estado}</p></div><span className="rounded-full bg-[#E7F7EF] px-3 py-1 text-xs font-semibold text-brand-dark">Líder</span></div>
		  <p className="mt-4 text-sm text-gray-600">{project.descripcion}</p>
		  {project.objetivo && <p className="mt-3 text-sm"><strong>Objetivo:</strong> {project.objetivo}</p>}
		  <p className="mt-3 text-sm text-gray-700"><strong>Cupos:</strong> {members.length}/{project.cuposDisponibles}</p>
			<div className="mt-4"><strong className="text-xs text-gray-700">Habilidades</strong><div className="mt-2 flex flex-wrap gap-2">{project.habilidadesIds.map(id => <span key={id} className="rounded-full bg-[#F0F7F3] px-2.5 py-1 text-xs text-brand-dark">{skills.find(item => item.id === id)?.nombre ?? "Habilidad"}</span>)}</div></div>
		  <div className="mt-3"><strong className="text-xs text-gray-700">Intereses</strong><div className="mt-2 flex flex-wrap gap-2">{project.interesesIds.map(id => <span key={id} className="rounded-full bg-[#FFF5E8] px-2.5 py-1 text-xs text-amber-800">{interests.find(item => item.id === id)?.nombre ?? "Interés"}</span>)}</div></div>
		  <div className="mt-5 border-t border-gray-100 pt-4"><p className="text-xs font-semibold text-gray-700">Integrantes</p><div className="mt-2 flex flex-wrap gap-2">{members.map(member => <span key={member.usuarioId} className="text-sm text-gray-600">{member.nombre} {member.apellido}</span>)}</div></div>
		  <div className="mt-5 flex gap-2"><button onClick={() => onNavigate("my-team")} className="flex-1 rounded-xl border border-gray-200 px-3 py-2 text-sm font-semibold text-gray-700">Ver equipo</button><button onClick={() => onNavigate("find-talents")} className="flex-1 rounded-xl bg-brand-dark px-3 py-2 text-sm font-semibold text-white">Encontrar talentos</button></div>
		</article>;
	  })}</div>
	</div>
  </Layout>;
}
