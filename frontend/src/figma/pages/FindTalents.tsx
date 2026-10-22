import Layout from "../components/Layout";
import { Page } from "../types";
import { FormEvent, useCallback, useEffect, useState } from "react";
import { api, ApiError } from "../../services/apiClient";
import { useAuth } from "../../features/auth/AuthContext";
import type { TalentStudent, Team, CreateTeamInvitationRequest, CollaborativeProject, TalentRecommendation } from "../../types/api";

interface Props { onNavigate: (page: Page) => void; }

export default function FindTalents({ onNavigate }: Props) {
  const { user } = useAuth();
  const [students, setStudents] = useState<TalentStudent[]>([]);
  const [search, setSearch] = useState("");
  const [skill, setSkill] = useState("");
  const [interest, setInterest] = useState("");
  const [availability, setAvailability] = useState("");
  const [page, setPage] = useState(1);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [teams, setTeams] = useState<Team[]>([]);
  const [selectedStudent, setSelectedStudent] = useState<TalentStudent | null>(null);
  const [selectedTeamId, setSelectedTeamId] = useState("");
  const [invitationMessage, setInvitationMessage] = useState("");
  const [invitationError, setInvitationError] = useState<string | null>(null);
  const [invitationStatus, setInvitationStatus] = useState<"idle" | "sending" | "sent">("idle");
  const [projects, setProjects] = useState<CollaborativeProject[]>([]);
  const [selectedProjectId, setSelectedProjectId] = useState("");
  const [recommendations, setRecommendations] = useState<TalentRecommendation[]>([]);
  const [recommendationsLoading, setRecommendationsLoading] = useState(false);

  const loadStudents = useCallback(async (nextPage = page) => {
    setLoading(true); setError(null);
    const params = new URLSearchParams({ page: String(nextPage), pageSize: "12" });
    if (search.trim()) params.set("search", search.trim());
    if (skill.trim()) params.set("skill", skill.trim());
    if (interest.trim()) params.set("interest", interest.trim());
    if (availability.trim()) params.set("availability", availability.trim());
    try { const result = await api.searchStudents(params); setStudents(result.items); setTotal(result.total); setPage(result.page); }
    catch (err) { setError(err instanceof ApiError ? err.message : "No se pudieron cargar los talentos."); }
    finally { setLoading(false); }
  }, [availability, interest, page, search, skill]);

  useEffect(() => { void loadStudents(1); }, []);

  useEffect(() => {
    if (user?.rol !== "Estudiante") return;
    void api.myCollaborativeProjects().then(setProjects).catch(err => setError(err instanceof ApiError ? err.message : "No se pudieron cargar tus proyectos."));
  }, [user?.rol]);

  useEffect(() => {
    if (!selectedProjectId) { setRecommendations([]); return; }
    setRecommendationsLoading(true);
    void api.recommendationsByProject(Number(selectedProjectId))
      .then(setRecommendations)
      .catch(err => setError(err instanceof ApiError ? err.message : "No se pudieron cargar las compatibilidades."))
      .finally(() => setRecommendationsLoading(false));
  }, [selectedProjectId]);

  const openInvitation = async (student: TalentStudent) => {
    setSelectedStudent(student); setSelectedTeamId(""); setInvitationMessage(""); setInvitationError(null); setInvitationStatus("idle");
    try {
      const availableTeams = await api.myTeams();
      setTeams(availableTeams.filter(team =>
        (team.estado === 1 || team.estado === "Activo")
        && team.liderUsuarioId === user?.id
        && !!team.proyecto
        && (team.miembros ?? []).length < team.proyecto.cuposDisponibles
        && !(team.miembros ?? []).some(member => member.usuarioId === student.usuarioId)
      ));
    } catch (err) {
      setInvitationError(err instanceof ApiError ? err.message : "No se pudieron cargar tus equipos.");
    }
  };

  const sendInvitation = async () => {
    if (!selectedStudent || !selectedTeamId) return;
    setInvitationStatus("sending"); setInvitationError(null);
    const data: CreateTeamInvitationRequest = { equipoId: Number(selectedTeamId), destinatarioUsuarioId: selectedStudent.usuarioId, mensaje: invitationMessage.trim() || undefined };
    try { await api.createTeamInvitation(data); setInvitationStatus("sent"); }
    catch (err) { setInvitationStatus("idle"); setInvitationError(err instanceof ApiError ? err.message : "No se pudo enviar la invitación."); }
  };

  const submit = (event: FormEvent) => { event.preventDefault(); void loadStudents(1); };

  return (
    <Layout currentPage="find-talents" onNavigate={onNavigate}>
      <div className="px-8 py-8 max-w-3xl">
        <h1 className="text-xl font-bold text-gray-900">Encontrar talentos</h1>
        {user?.rol === "Estudiante" && <label className="mt-5 block text-sm font-medium text-gray-700">Buscar talento para<select value={selectedProjectId} onChange={event => setSelectedProjectId(event.target.value)} className="mt-2 w-full rounded-xl border border-gray-200 bg-white px-3 py-2 text-sm"><option value="">Búsqueda general</option>{projects.map(project => <option key={project.id} value={project.id}>{project.titulo}</option>)}</select></label>}
        {selectedProjectId && recommendationsLoading && <p className="mt-3 text-sm text-gray-500">Cargando compatibilidades...</p>}
        <form onSubmit={submit} className="mt-6 grid gap-3 rounded-2xl border border-[#E5EDE8] bg-white p-5 shadow-sm sm:grid-cols-2"><input value={search} onChange={e => setSearch(e.target.value)} placeholder="Nombre o carrera" className="rounded-xl border border-gray-200 px-3 py-2 text-sm" /><input value={skill} onChange={e => setSkill(e.target.value)} placeholder="Habilidad" className="rounded-xl border border-gray-200 px-3 py-2 text-sm" /><input value={interest} onChange={e => setInterest(e.target.value)} placeholder="Interés" className="rounded-xl border border-gray-200 px-3 py-2 text-sm" /><input value={availability} onChange={e => setAvailability(e.target.value)} placeholder="Disponibilidad" className="rounded-xl border border-gray-200 px-3 py-2 text-sm" /><button type="submit" className="rounded-xl bg-brand-dark px-4 py-2 text-sm font-semibold text-white sm:col-span-2">Buscar talentos</button></form>
        {loading && <div className="mt-5 rounded-2xl bg-white p-8 text-sm text-gray-500">Buscando estudiantes...</div>}
        {!loading && error && <div className="mt-5 rounded-2xl border border-red-200 bg-red-50 p-6 text-sm text-red-700"><p>{error}</p><button onClick={() => void loadStudents()} className="mt-4 rounded-xl bg-brand-dark px-4 py-2 font-semibold text-white">Reintentar</button></div>}
        {!loading && !error && students.length === 0 && <div className="mt-5 rounded-2xl border-2 border-dashed border-[#D1F2E2] bg-white p-10 text-center text-sm text-gray-500">No encontramos estudiantes con esos filtros.</div>}
         {!loading && !error && students.length > 0 && <><div className="mt-5 grid gap-4">{students.map(student => { const recommendation = recommendations.find(item => item.estudianteId === student.estudianteId); return <article key={student.estudianteId} className="rounded-2xl border border-[#E5EDE8] bg-white p-5 shadow-sm"><div className="flex items-start justify-between gap-3"><div><h2 className="font-semibold text-gray-900">{student.nombre} {student.apellido}</h2><p className="mt-1 text-sm text-gray-500">{student.carrera} · Semestre {student.semestre}</p></div>{recommendation ? <span className="rounded-full bg-[#E7F7EF] px-3 py-1 text-xs font-semibold text-brand-dark">{recommendation.porcentajeCompatibilidad}% compatible</span> : <span className="rounded-full bg-[#E7F7EF] px-3 py-1 text-xs font-semibold text-brand-dark">{student.disponibilidad || "Disponibilidad no indicada"}</span>}</div>{recommendation && <div className="mt-3 text-xs text-gray-600"><p>Habilidades: {recommendation.habilidadesCoincidentes.join(", ") || "Sin coincidencias"}</p><p>Intereses: {recommendation.interesesCoincidentes.join(", ") || "Sin coincidencias"}</p></div>}{student.descripcion && <p className="mt-3 text-sm text-gray-600">{student.descripcion}</p>}<div className="mt-4 flex flex-wrap gap-2">{student.habilidades.map(value => <span key={value} className="rounded-full bg-[#F0F7F3] px-2.5 py-1 text-xs text-brand-dark">{value}</span>)}{student.intereses.map(value => <span key={value} className="rounded-full bg-[#FFF5E8] px-2.5 py-1 text-xs text-amber-800">{value}</span>)}</div><div className="mt-4 flex flex-wrap gap-2"><button type="button" onClick={() => { void api.createConversation(student.usuarioId).then(() => onNavigate("messages")).catch(err => setError(err instanceof ApiError ? err.message : "No se pudo iniciar la conversación.")); }} className="rounded-xl bg-brand-dark px-3 py-2 text-sm font-semibold text-white">Enviar mensaje</button>{user?.rol === "Estudiante" && <button type="button" onClick={() => void openInvitation(student)} className="rounded-xl border border-brand-dark px-3 py-2 text-sm font-semibold text-brand-dark">Invitar a equipo</button>}</div></article>; })}</div><div className="mt-5 flex items-center justify-between text-sm text-gray-500"><span>{total} resultados</span><div className="flex gap-2"><button disabled={page <= 1} onClick={() => void loadStudents(page - 1)} className="rounded-lg border px-3 py-1 disabled:opacity-40">Anterior</button><button disabled={page * 12 >= total} onClick={() => void loadStudents(page + 1)} className="rounded-lg border px-3 py-1 disabled:opacity-40">Siguiente</button></div></div></>}
      </div>
      {selectedStudent && <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-4"><div className="w-full max-w-md rounded-2xl bg-white p-6 shadow-xl"><h2 className="text-lg font-bold text-gray-900">Invitar a {selectedStudent.nombre} {selectedStudent.apellido}</h2>{invitationStatus === "sent" ? <><p className="mt-4 text-sm text-green-700">Invitación enviada correctamente.</p><button onClick={() => setSelectedStudent(null)} className="mt-5 rounded-xl bg-brand-dark px-4 py-2 text-sm font-semibold text-white">Cerrar</button></> : teams.length === 0 && !invitationError ? <><p className="mt-4 text-sm text-gray-600">No tienes equipos que puedas gestionar para enviar invitaciones.</p><button onClick={() => setSelectedStudent(null)} className="mt-5 rounded-xl border px-4 py-2 text-sm">Cerrar</button></> : <><label className="mt-5 block text-sm font-medium text-gray-700">Equipo<select value={selectedTeamId} onChange={event => setSelectedTeamId(event.target.value)} className="mt-2 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm"><option value="">Selecciona un equipo</option>{teams.map(team => <option key={team.id} value={team.id}>{team.nombre} · {team.proyecto?.titulo ?? `Proyecto #${team.proyectoId}`}</option>)}</select></label><textarea value={invitationMessage} onChange={event => setInvitationMessage(event.target.value)} placeholder="Mensaje opcional" className="mt-4 min-h-24 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm" />{invitationError && <p className="mt-3 text-sm text-red-700">{invitationError}</p>}<div className="mt-5 flex justify-end gap-2"><button onClick={() => setSelectedStudent(null)} className="rounded-xl border px-4 py-2 text-sm">Cancelar</button><button disabled={!selectedTeamId || invitationStatus === "sending"} onClick={() => void sendInvitation()} className="rounded-xl bg-brand-dark px-4 py-2 text-sm font-semibold text-white disabled:opacity-50">{invitationStatus === "sending" ? "Enviando..." : "Enviar invitación"}</button></div></> }</div></div>}
    </Layout>
  );
}
