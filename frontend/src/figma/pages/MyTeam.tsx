import Layout from "../components/Layout";
import { Page } from "../types";
import { useCallback, useEffect, useState } from "react";
import { api, ApiError } from "../../services/apiClient";
import type { Team } from "../../types/api";

interface Props { onNavigate: (page: Page) => void; }

export default function MyTeam({ onNavigate }: Props) {
  const [teams, setTeams] = useState<Team[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const loadTeams = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      setTeams(await api.myTeams());
    } catch (err) {
      setError(err instanceof ApiError ? err.message : "No se pudieron cargar tus equipos.");
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { void loadTeams(); }, [loadTeams]);

  return (
    <Layout currentPage="my-team" onNavigate={onNavigate}>
      <div className="px-8 py-8 max-w-3xl">
        <h1 className="text-xl font-bold text-gray-900">Mis equipos</h1>

        {loading && <div className="mt-6 rounded-2xl bg-white p-8 text-sm text-gray-500">Cargando tus equipos...</div>}
        {!loading && error && <div className="mt-6 rounded-2xl border border-red-200 bg-red-50 p-6 text-sm text-red-700"><p>{error}</p><button onClick={() => void loadTeams()} className="mt-4 rounded-xl bg-brand-dark px-4 py-2 font-semibold text-white">Reintentar</button></div>}
        {!loading && !error && teams.length === 0 && <div className="mt-6 rounded-2xl border-2 border-dashed border-[#D1F2E2] bg-white p-12 text-center"><p className="font-semibold text-gray-900">Aún no perteneces a un equipo</p><p className="mt-2 text-sm text-gray-500">Cuando te integres a un equipo, aparecerá aquí su proyecto e integrantes.</p><button onClick={() => onNavigate("explore")} className="mt-5 rounded-xl bg-brand-dark px-4 py-2 text-sm font-semibold text-white">Explorar proyectos</button></div>}
        {!loading && !error && teams.length > 0 && <div className="mt-6 grid gap-5">{teams.map(team => <article key={team.id} className="rounded-2xl border border-[#E5EDE8] bg-white p-6 shadow-sm"><div className="flex items-start justify-between gap-4"><div><h2 className="font-semibold text-gray-900">{team.nombre}</h2><p className="mt-1 text-sm text-gray-500">{team.proyecto?.titulo ?? `Proyecto #${team.proyectoId}`}</p></div><span className="rounded-full bg-[#E7F7EF] px-3 py-1 text-xs font-semibold text-brand-dark">{String(team.estado)}</span></div><p className="mt-4 text-sm text-gray-600">{team.proyecto?.descripcion ?? "Sin descripción del proyecto."}</p><h3 className="mt-5 text-sm font-semibold text-gray-900">Integrantes ({team.miembros?.length ?? 0})</h3>{team.miembros?.length ? <ul className="mt-2 grid gap-2 sm:grid-cols-2">{team.miembros.map(member => <li key={member.estudianteId} className="rounded-xl bg-[#F7FAF8] px-3 py-2 text-sm text-gray-700">{member.nombre} {member.apellido}</li>)}</ul> : <p className="mt-2 text-sm text-gray-500">No hay integrantes registrados.</p>}</article>)}</div>}
        </div>
    </Layout>
  );
}
