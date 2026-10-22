import Layout from "../components/Layout";
import { Page } from "../types";
import { useCallback, useEffect, useMemo, useState } from "react";
import { api, ApiError } from "../../services/apiClient";
import { useAuth } from "../../features/auth/AuthContext";
import { applicationStatusLabel, type Application, type Project, type TeamInvitation } from "../../types/api";

interface Props { onNavigate: (page: Page) => void; }
type Decision = "aceptar" | "rechazar";
type StudentTab = "applications" | "project-received" | "received" | "sent";

function isPending(application: Application): boolean {
  return application.estado === 1 || application.estado === "Pendiente";
}

function ApplicationList({ applications, actionId, onDecision }: { applications: Application[]; actionId: number | null; onDecision: (application: Application, decision: Decision) => void }) {
  if (applications.length === 0) return <div className="mt-6 rounded-2xl border-2 border-dashed border-[#D1F2E2] bg-white p-12 text-center"><p className="font-semibold text-gray-900">No hay solicitudes recibidas</p></div>;
  return <div className="mt-6 grid gap-4">{applications.map(application => <article key={application.id} className="rounded-2xl border border-[#E5EDE8] bg-white p-6 shadow-sm"><div className="flex items-start justify-between gap-4"><div><h2 className="font-semibold text-gray-900">{application.estudianteNombre ? `${application.estudianteNombre} ${application.estudianteApellido ?? ""}` : `Estudiante #${application.estudianteId}`}</h2>{application.estudianteCarrera && <p className="mt-1 text-sm text-gray-500">{application.estudianteCarrera}{application.estudianteSemestre ? ` · Semestre ${application.estudianteSemestre}` : ""}</p>}<p className="mt-1 text-sm text-gray-500">Proyecto: {application.proyecto?.titulo ?? `Proyecto #${application.proyectoId}`}</p><p className="mt-1 text-xs text-gray-500">{application.fechaPostulacion ? new Date(application.fechaPostulacion).toLocaleDateString("es-CO") : "Fecha no disponible"}</p></div><span className="rounded-full bg-[#E7F7EF] px-3 py-1 text-xs font-semibold text-brand-dark">{applicationStatusLabel(application.estado)}</span></div><p className="mt-4 text-sm text-gray-600">{application.mensaje || "Sin mensaje"}</p>{isPending(application) && <div className="mt-5 flex gap-2"><button disabled={actionId === application.id} onClick={() => onDecision(application, "aceptar")} className="rounded-xl bg-brand-dark px-4 py-2 text-sm font-semibold text-white disabled:opacity-50">Aceptar</button><button disabled={actionId === application.id} onClick={() => onDecision(application, "rechazar")} className="rounded-xl border border-red-200 px-4 py-2 text-sm font-semibold text-red-700 disabled:opacity-50">Rechazar</button></div>}</article>)}</div>;
}

function invitationStatusLabel(status: TeamInvitation["estado"]): string {
  if (typeof status === "number") return ({ 1: "Pendiente", 2: "Aceptada", 3: "Rechazada", 4: "Cancelada" } as Record<number, string>)[status] ?? "Desconocida";
  return status;
}

function isInvitationPending(invitation: TeamInvitation): boolean {
  return invitation.estado === 1 || invitation.estado === "Pendiente";
}

function projectApplication(application: Application, project: Project): Application {
  return { ...application, proyecto: application.proyecto ?? { id: project.id, titulo: project.titulo, descripcion: project.descripcion, fechaLimite: project.fechaLimite ?? "" } };
}

export default function Requests({ onNavigate }: Props) {
  const { user } = useAuth();
  const [applications, setApplications] = useState<Application[]>([]);
  const [projects, setProjects] = useState<Project[]>([]);
  const [received, setReceived] = useState<TeamInvitation[]>([]);
  const [sent, setSent] = useState<TeamInvitation[]>([]);
  const [receivedApplications, setReceivedApplications] = useState<Application[]>([]);
  const [hasCollaborativeProjects, setHasCollaborativeProjects] = useState(false);
  const [tab, setTab] = useState<StudentTab>("applications");
  const [loading, setLoading] = useState(true);
  const [invitationLoading, setInvitationLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [actionId, setActionId] = useState<number | null>(null);
  const [invitationActionId, setInvitationActionId] = useState<number | null>(null);
  const [projectFilter, setProjectFilter] = useState("all");
  const [studentFilter, setStudentFilter] = useState("");
  const [statusFilter, setStatusFilter] = useState("all");

  const loadApplications = useCallback(async () => {
	if (!user) return;
	setLoading(true); setError(null);
	try {
	  switch (user.rol) {
		case "Estudiante": {
		  const [mine, collaborativeProjects] = await Promise.all([api.myApplications(), api.myCollaborativeProjects()]);
		  const receivedResults = await Promise.all(collaborativeProjects.map(async project => (await api.applicationsByProject(project.id)).map(application => projectApplication(application, project))));
		  setProjects([]); setApplications(mine); setReceivedApplications(receivedResults.flat()); setHasCollaborativeProjects(collaborativeProjects.length > 0);
		  break;
		}
		case "Profesor": {
		  const ownProjects = (await api.projects()).filter(project => project.profesorId === user.id);
		  const results = await Promise.all(ownProjects.map(async project => (await api.applicationsByProject(project.id)).map(application => projectApplication(application, project))));
		  setProjects(ownProjects); setApplications(results.flat());
		  break;
		}
		case "Administrador": setProjects([]); setApplications([]); break;
		default: setProjects([]); setApplications([]); setError("El rol autenticado no puede consultar solicitudes."); break;
	  }
	} catch (loadError) {
	  setError(loadError instanceof ApiError ? loadError.message : "No se pudieron cargar las solicitudes.");
	} finally { setLoading(false); }
  }, [user]);

  const loadInvitations = useCallback(async () => {
	if (user?.rol !== "Estudiante") return;
	setInvitationLoading(true); setError(null);
	try {
	  const [receivedInvitations, sentInvitations] = await Promise.all([api.receivedTeamInvitations(), api.sentTeamInvitations()]);
	  setReceived(receivedInvitations); setSent(sentInvitations);
	} catch (loadError) {
	  setError(loadError instanceof ApiError ? loadError.message : "No se pudieron cargar las invitaciones.");
	} finally { setInvitationLoading(false); }
  }, [user?.rol]);

  useEffect(() => { void loadApplications(); }, [loadApplications]);
  useEffect(() => { void loadInvitations(); }, [loadInvitations]);

  const filteredApplications = useMemo(() => applications.filter(application => {
	const projectMatches = projectFilter === "all" || String(application.proyectoId) === projectFilter;
	const studentMatches = !studentFilter.trim() || String(application.estudianteId).includes(studentFilter.trim());
	const statusMatches = statusFilter === "all" || applicationStatusLabel(application.estado) === statusFilter;
	return projectMatches && studentMatches && statusMatches;
  }), [applications, projectFilter, statusFilter, studentFilter]);

  const decide = async (application: Application, decision: Decision) => {
	if (!isPending(application)) return;
	setActionId(application.id); setError(null);
	try {
	  const updated = decision === "aceptar" ? await api.acceptApplication(application.id) : await api.rejectApplication(application.id);
	  const update = (current: Application[]) => current.map(item => item.id === updated.id ? { ...item, ...updated, proyecto: item.proyecto } : item);
	  setApplications(update); setReceivedApplications(update);
	} catch (decisionError) {
	  setError(decisionError instanceof ApiError ? decisionError.message : "No se pudo actualizar la solicitud.");
	} finally { setActionId(null); }
  };

  const resolveInvitation = async (invitation: TeamInvitation, action: "accept" | "reject" | "cancel") => {
	if (!isInvitationPending(invitation)) return;
	setInvitationActionId(invitation.id); setError(null);
	try {
	  const updated = action === "accept" ? await api.acceptTeamInvitation(invitation.id) : action === "reject" ? await api.rejectTeamInvitation(invitation.id) : await api.cancelTeamInvitation(invitation.id);
	  if (action === "cancel") setSent(current => current.map(item => item.id === updated.id ? updated : item));
	  else setReceived(current => current.map(item => item.id === updated.id ? updated : item));
	} catch (actionError) {
	  setError(actionError instanceof ApiError ? actionError.message : "No se pudo actualizar la invitación.");
	} finally { setInvitationActionId(null); }
  };

  const isStudent = user?.rol === "Estudiante";
  const isProfessor = user?.rol === "Profesor";
  const isAdmin = user?.rol === "Administrador";

  return (
	<Layout currentPage="requests" onNavigate={onNavigate}>
	  <div className="px-8 py-8 max-w-4xl">
		<h1 className="text-xl font-bold text-gray-900">Solicitudes</h1>
		<p className="mt-1 text-sm text-gray-500">{isStudent ? "Consulta tus postulaciones e invitaciones de equipo." : isProfessor ? "Gestiona las postulaciones de tus proyectos." : "Supervisión administrativa no disponible con los contratos actuales."}</p>
		{isStudent && <div className="mt-5 flex flex-wrap gap-2"><button onClick={() => setTab("applications")} className={`rounded-xl px-4 py-2 text-sm font-semibold ${tab === "applications" ? "bg-brand-dark text-white" : "border border-gray-200 text-gray-600"}`}>Mis postulaciones</button>{hasCollaborativeProjects && <button onClick={() => setTab("project-received")} className={`rounded-xl px-4 py-2 text-sm font-semibold ${tab === "project-received" ? "bg-brand-dark text-white" : "border border-gray-200 text-gray-600"}`}>Solicitudes recibidas</button>}<button onClick={() => setTab("received")} className={`rounded-xl px-4 py-2 text-sm font-semibold ${tab === "received" ? "bg-brand-dark text-white" : "border border-gray-200 text-gray-600"}`}>Invitaciones recibidas</button><button onClick={() => setTab("sent")} className={`rounded-xl px-4 py-2 text-sm font-semibold ${tab === "sent" ? "bg-brand-dark text-white" : "border border-gray-200 text-gray-600"}`}>Invitaciones enviadas</button></div>}
		{isAdmin && <div className="mt-5 rounded-2xl border border-amber-200 bg-amber-50 p-5 text-sm text-amber-800">La supervisión administrativa de solicitudes no está disponible en el contrato actual.</div>}
		{isStudent && tab !== "applications" && tab !== "project-received" && invitationLoading && <div className="mt-6 rounded-2xl bg-white p-8 text-sm text-gray-500">Cargando invitaciones...</div>}
		{isStudent && tab === "applications" && loading && <div className="mt-6 rounded-2xl bg-white p-8 text-sm text-gray-500">Cargando solicitudes...</div>}
		{error && <div className="mt-6 rounded-2xl border border-red-200 bg-red-50 p-6 text-sm text-red-700"><p>{error}</p><button onClick={() => tab === "applications" ? void loadApplications() : void loadInvitations()} className="mt-4 rounded-xl bg-brand-dark px-4 py-2 font-semibold text-white">Reintentar</button></div>}
		{isStudent && tab === "received" && !invitationLoading && !error && <InvitationList invitations={received} actionId={invitationActionId} onAction={(invitation, action) => void resolveInvitation(invitation, action)} received />}
		{isStudent && tab === "sent" && !invitationLoading && !error && <InvitationList invitations={sent} actionId={invitationActionId} onAction={(invitation, action) => void resolveInvitation(invitation, action)} />}
		{isStudent && tab === "project-received" && !loading && !error && <ApplicationList applications={receivedApplications} actionId={actionId} onDecision={(application, decision) => void decide(application, decision)} />}
		{(!isStudent || tab === "applications") && !loading && !error && filteredApplications.length === 0 && <div className="mt-6 rounded-2xl border-2 border-dashed border-[#D1F2E2] bg-white p-12 text-center"><p className="font-semibold text-gray-900">No hay solicitudes para mostrar</p>{isStudent && <button onClick={() => onNavigate("explore")} className="mt-5 rounded-xl bg-brand-dark px-4 py-2 text-sm font-semibold text-white">Explorar proyectos</button>}</div>}
		{(!isStudent || tab === "applications") && !loading && !error && filteredApplications.length > 0 && <div className="mt-6 grid gap-4">{filteredApplications.map(application => <article key={application.id} className="rounded-2xl border border-[#E5EDE8] bg-white p-6 shadow-sm"><div className="flex items-start justify-between gap-4"><div><h2 className="font-semibold text-gray-900">{application.proyecto?.titulo ?? `Proyecto #${application.proyectoId}`}</h2><p className="mt-1 text-sm text-gray-500">Estudiante #{application.estudianteId}</p><p className="mt-1 text-xs text-gray-500">{application.fechaPostulacion ? new Date(application.fechaPostulacion).toLocaleDateString("es-CO") : "Fecha no disponible"}</p></div><span className="rounded-full bg-[#E7F7EF] px-3 py-1 text-xs font-semibold text-brand-dark">{applicationStatusLabel(application.estado)}</span></div><p className="mt-4 text-sm text-gray-600">{application.mensaje || "Sin mensaje"}</p>{isProfessor && isPending(application) && <div className="mt-5 flex gap-2"><button disabled={actionId === application.id} onClick={() => void decide(application, "aceptar")} className="rounded-xl bg-brand-dark px-4 py-2 text-sm font-semibold text-white disabled:opacity-50">Aceptar</button><button disabled={actionId === application.id} onClick={() => void decide(application, "rechazar")} className="rounded-xl border border-red-200 px-4 py-2 text-sm font-semibold text-red-700 disabled:opacity-50">Rechazar</button></div>}</article>)}</div>}
	  </div>
	</Layout>
  );
}

function InvitationList({ invitations, actionId, onAction, received = false }: { invitations: TeamInvitation[]; actionId: number | null; onAction: (invitation: TeamInvitation, action: "accept" | "reject" | "cancel") => void; received?: boolean }) {
  if (invitations.length === 0) return <div className="mt-6 rounded-2xl border-2 border-dashed border-[#D1F2E2] bg-white p-12 text-center"><p className="font-semibold text-gray-900">No hay invitaciones para mostrar</p></div>;
  return <div className="mt-6 grid gap-4">{invitations.map(invitation => <article key={invitation.id} className="rounded-2xl border border-[#E5EDE8] bg-white p-6 shadow-sm"><div className="flex items-start justify-between gap-4"><div><h2 className="font-semibold text-gray-900">{invitation.equipo}</h2><p className="mt-1 text-sm text-gray-500">Proyecto: {invitation.proyecto}</p><p className="mt-1 text-sm text-gray-500">{received ? `De: ${invitation.remitente}` : `Destinatario: ${invitation.destinatario}`}</p><p className="mt-1 text-xs text-gray-500">{new Date(invitation.fechaCreacion).toLocaleDateString("es-CO")}</p></div><span className="rounded-full bg-[#E7F7EF] px-3 py-1 text-xs font-semibold text-brand-dark">{invitationStatusLabel(invitation.estado)}</span></div>{invitation.mensaje && <p className="mt-4 text-sm text-gray-600">{invitation.mensaje}</p>}{isInvitationPending(invitation) && <div className="mt-5 flex gap-2">{received ? <><button disabled={actionId === invitation.id} onClick={() => onAction(invitation, "accept")} className="rounded-xl bg-brand-dark px-4 py-2 text-sm font-semibold text-white disabled:opacity-50">Aceptar</button><button disabled={actionId === invitation.id} onClick={() => onAction(invitation, "reject")} className="rounded-xl border border-red-200 px-4 py-2 text-sm font-semibold text-red-700 disabled:opacity-50">Rechazar</button></> : <button disabled={actionId === invitation.id} onClick={() => onAction(invitation, "cancel")} className="rounded-xl border border-gray-300 px-4 py-2 text-sm font-semibold text-gray-700 disabled:opacity-50">Cancelar</button>}</div>}</article>)}</div>;
}
