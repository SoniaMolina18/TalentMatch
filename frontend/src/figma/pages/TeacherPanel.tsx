import { useEffect, useMemo, useState } from "react";
import Layout from "../components/Layout";
import { ApiError, api } from "../../services/apiClient";
import { useAuth } from "../../features/auth/AuthContext";
import { applicationStatusLabel, projectStatusLabel, type Application, type Project, type Team } from "../../types/api";
import { Page } from "../types";

interface Props { onNavigate: (page: Page) => void; }

export default function TeacherPanel({ onNavigate }: Props) {
  const { user } = useAuth();
  const [projects, setProjects] = useState<Project[]>([]);
  const [applications, setApplications] = useState<Application[]>([]);
  const [selected, setSelected] = useState<number>();
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [actionError, setActionError] = useState("");
  const [editing, setEditing] = useState<Project | null>(null);
  const [editTitle, setEditTitle] = useState("");
  const [editDescription, setEditDescription] = useState("");
  const [editDeadline, setEditDeadline] = useState("");
  const [editSlots, setEditSlots] = useState("1");
  const [savingProject, setSavingProject] = useState(false);
  const [teams, setTeams] = useState<Team[]>([]);
  const [assigningLeader, setAssigningLeader] = useState<number | null>(null);

  async function load() {
    setLoading(true); setError("");
    try {
      const all = await api.projects();
      const own = all.filter(project => project.profesorId === user?.id);
      setProjects(own); setSelected(current => current && own.some(p => p.id === current) ? current : own[0]?.id);
    } catch (err) { setError(err instanceof ApiError ? err.message : "No se pudieron cargar tus proyectos."); }
    finally { setLoading(false); }
  }
  useEffect(() => { if (user) void load(); }, [user?.id]);
  useEffect(() => {
    if (!selected) { setApplications([]); return; }
    let cancelled = false;
    setActionError("");
    api.applicationsByProject(selected).then(value => { if (!cancelled) setApplications(value); }).catch(err => { if (!cancelled) setActionError(err instanceof ApiError ? err.message : "No se pudieron cargar las postulaciones."); });
    return () => { cancelled = true; };
  }, [selected]);
  useEffect(() => {
    if (!selected) { setTeams([]); return; }
    let cancelled = false;
    api.myTeams().then(value => {
      if (!cancelled) setTeams(value.filter(team => team.proyectoId === selected));
    }).catch(err => {
      if (!cancelled) setActionError(err instanceof ApiError ? err.message : "No se pudieron cargar los equipos.");
    });
    return () => { cancelled = true; };
  }, [selected]);

  function startEdit(project: Project) {
    setEditing(project);
    setEditTitle(project.titulo);
    setEditDescription(project.descripcion);
    setEditDeadline(project.fechaLimite?.slice(0, 10) ?? "");
    setEditSlots(String(project.cuposDisponibles));
    setActionError("");
  }

  async function assignLeader(team: Team, studentId: number, studentName: string) {
    if (!window.confirm(`¿Asignar a ${studentName} como líder de ${team.nombre}?`)) return;
    setAssigningLeader(team.id); setActionError("");
    try {
      await api.assignTeamLeader(team.id, studentId);
      const updated = await api.team(team.id);
      setTeams(current => current.map(item => item.id === updated.id ? updated : item));
    } catch (err) {
      setActionError(err instanceof ApiError ? err.message : "No se pudo asignar el líder del equipo.");
    } finally {
      setAssigningLeader(null);
    }
  }

  async function saveProject() {
    if (!editing || !editTitle.trim() || !editDescription.trim() || !editDeadline || Number(editSlots) < 1) { setActionError("Completa todos los campos del proyecto."); return; }
    setSavingProject(true); setActionError("");
    try { await api.updateProject(editing.id, { titulo: editTitle.trim(), descripcion: editDescription.trim(), fechaLimite: editDeadline, cuposDisponibles: Number(editSlots) }); setEditing(null); await load(); }
    catch (err) { setActionError(err instanceof ApiError ? err.message : "No se pudo actualizar el proyecto."); }
    finally { setSavingProject(false); }
  }

  async function removeProject(project: Project) {
    if (!window.confirm(`¿Eliminar el proyecto "${project.titulo}"?`)) return;
    setActionError("");
    try { await api.deleteProject(project.id); await load(); }
    catch (err) { setActionError(err instanceof ApiError ? err.message : "No se pudo eliminar el proyecto."); }
  }

  async function changeApplication(id: number, accept: boolean) {
    setActionError("");
    try { const updated = await (accept ? api.acceptApplication(id) : api.rejectApplication(id)); setApplications(current => current.map(item => item.id === id ? updated : item)); }
    catch (err) { setActionError(err instanceof ApiError ? err.message : "No se pudo actualizar la postulación."); }
  }
  const active = projects.find(project => project.id === selected);
  const openCount = useMemo(() => projects.filter(project => projectStatusLabel(project.estado) === "Abierto").length, [projects]);

  return (
    <Layout currentPage="teacher-panel" onNavigate={onNavigate}>
      <div className="px-8 py-8 max-w-screen-xl">
        <div className="flex items-start justify-between mb-6">
          <div>
            <h1 className="text-xl font-bold text-gray-900">Mis proyectos</h1>
            <p className="text-sm text-gray-500">Proyectos propiedad de tu usuario autenticado.</p>
          </div>
          <button onClick={() => onNavigate("create-project")} className="px-4 py-2.5 rounded-xl text-sm font-semibold text-white bg-brand-dark">
            + Crear nuevo proyecto
          </button>
        </div>

        {error && (
          <div className="mb-4 rounded-xl bg-red-50 px-4 py-3 text-sm text-red-700">
            {error}
            <button onClick={() => void load()} className="ml-3 underline">Reintentar</button>
          </div>
        )}

        {loading ? (
          <p className="text-sm text-gray-500">Cargando proyectos…</p>
        ) : projects.length === 0 ? (
          <div className="rounded-2xl border-2 border-dashed border-[#D1F2E2] p-12 text-center text-sm text-gray-500">
            No tienes proyectos creados.
          </div>
        ) : (
          <>
            <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-6">
              {[["Proyectos", projects.length], ["Abiertos", openCount], ["Postulaciones", applications.length]].map(([label, value]) => (
                <div key={label} className="bg-white rounded-2xl p-5 border border-[#E5EDE8]">
                  <p className="text-2xl font-bold text-gray-900">{value}</p>
                  <p className="text-xs text-gray-500">{label}</p>
                </div>
              ))}
            </div>
            <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
              <div className="lg:col-span-1 space-y-3">
                {projects.map(project => (
                  <button
                    key={project.id}
                    onClick={() => setSelected(project.id)}
                    className={`w-full text-left bg-white rounded-xl p-4 border ${project.id === selected ? "border-brand-main bg-brand-bg" : "border-[#E5EDE8]"}`}
                  >
                    <p className="text-sm font-semibold text-gray-900">{project.titulo}</p>
                    <p className="text-xs text-gray-500 mt-1">{projectStatusLabel(project.estado)} · {project.cuposDisponibles} cupos</p>
                  </button>
                ))}
                {active && (
                  <div className="flex gap-2">
                    <button type="button" onClick={() => startEdit(active)} className="flex-1 rounded-xl border px-3 py-2 text-xs font-semibold">
                      Editar proyecto
                    </button>
                    <button type="button" onClick={() => void removeProject(active)} className="rounded-xl border border-red-200 px-3 py-2 text-xs font-semibold text-red-700">
                      Eliminar
                    </button>
                  </div>
                )}
              </div>
              <div className="lg:col-span-2 bg-white rounded-2xl p-5 border border-[#E5EDE8]">
                <h2 className="font-semibold text-gray-900">{active?.titulo}</h2>
                <p className="text-sm text-gray-500 mt-1">Postulaciones del proyecto seleccionado</p>
                {actionError && <p className="text-sm text-red-700 mt-3">{actionError}</p>}
                <div className="mt-4 space-y-3">
                  {applications.length === 0 ? (
                    <p className="text-sm text-gray-500">No hay postulaciones.</p>
                  ) : (
                    applications.map(application => (
                      <div key={application.id} className="rounded-xl bg-[#F7FAF8] p-4 flex items-center justify-between gap-3">
                        <div>
                          <p className="text-sm font-semibold">Estudiante #{application.estudianteId}</p>
                          <p className="text-xs text-gray-500">Estado: {applicationStatusLabel(application.estado)}</p>
                        </div>
                        {applicationStatusLabel(application.estado) === "Pendiente" && (
                          <div className="flex gap-2">
                            <button onClick={() => void changeApplication(application.id, true)} className="px-3 py-1.5 rounded-xl text-xs text-white bg-brand-dark">Aceptar</button>
                            <button onClick={() => void changeApplication(application.id, false)} className="px-3 py-1.5 rounded-xl text-xs border">Rechazar</button>
                          </div>
                        )}
                      </div>
                    ))
                  )}
                </div>
                 <h3 className="mt-8 font-semibold text-gray-900">Equipos del proyecto</h3>
                 {teams.length === 0 ? (
                   <p className="mt-3 text-sm text-gray-500">No hay equipos asociados a este proyecto.</p>
                 ) : (
                   <div className="mt-3 space-y-3">
                     {teams.map(team => (
                       <div key={team.id} className="rounded-xl border border-[#E5EDE8] p-4">
                         <div className="flex items-start justify-between gap-3">
                           <div>
                             <p className="font-semibold text-gray-900">{team.nombre}</p>
                             <p className="mt-1 text-xs text-gray-500">Líder actual: {team.liderUsuarioId ? (team.miembros ?? []).find(member => member.usuarioId === team.liderUsuarioId)?.nombre + " " + (team.miembros ?? []).find(member => member.usuarioId === team.liderUsuarioId)?.apellido : "Sin líder asignado"}</p>
                           </div>
                         </div>
                         <div className="mt-3 grid gap-2">
                           {(team.miembros ?? []).length === 0 ? <p className="text-sm text-gray-500">No hay integrantes.</p> : (team.miembros ?? []).map(member => (
                             <div key={member.estudianteId} className="flex items-center justify-between gap-3 rounded-lg bg-[#F7FAF8] px-3 py-2">
                               <span className="text-sm text-gray-700">{member.nombre} {member.apellido}</span>
                               {member.usuarioId === team.liderUsuarioId ? <span className="text-xs font-semibold text-brand-dark">Líder</span> : <button type="button" disabled={assigningLeader === team.id} onClick={() => void assignLeader(team, member.estudianteId, `${member.nombre} ${member.apellido}`)} className="rounded-lg border border-brand-dark px-2.5 py-1.5 text-xs font-semibold text-brand-dark disabled:opacity-50">Asignar como líder</button>}
                             </div>
                           ))}
                         </div>
                       </div>
                     ))}
                   </div>
                 )}
              </div>
            </div>
            {editing && (
              <div className="mt-6 rounded-2xl bg-white p-5 border border-[#E5EDE8]">
                <h2 className="font-semibold text-gray-900">Editar proyecto</h2>
                <div className="mt-4 grid gap-3">
                  <input value={editTitle} onChange={event => setEditTitle(event.target.value)} className="rounded-xl border px-3 py-2 text-sm" placeholder="Título" />
                  <textarea value={editDescription} onChange={event => setEditDescription(event.target.value)} className="rounded-xl border px-3 py-2 text-sm" rows={4} placeholder="Descripción" />
                  <div className="grid grid-cols-2 gap-3">
                    <input type="date" value={editDeadline} onChange={event => setEditDeadline(event.target.value)} className="rounded-xl border px-3 py-2 text-sm" />
                    <input type="number" min="1" value={editSlots} onChange={event => setEditSlots(event.target.value)} className="rounded-xl border px-3 py-2 text-sm" />
                  </div>
                  <div className="flex gap-2">
                    <button type="button" onClick={() => setEditing(null)} className="rounded-xl border px-4 py-2 text-sm">Cancelar</button>
                    <button type="button" disabled={savingProject} onClick={() => void saveProject()} className="rounded-xl bg-brand-dark px-4 py-2 text-sm font-semibold text-white disabled:opacity-50">{savingProject ? "Guardando…" : "Guardar"}</button>
                  </div>
                </div>
              </div>
            )}
          </>
        )}
      </div>
    </Layout>
  );
}
