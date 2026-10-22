import { useCallback, useEffect, useState, type FormEvent } from "react";
import Layout from "../components/Layout";
import { Page } from "../types";
import { useAuth } from "../../features/auth/AuthContext";
import { api, ApiError } from "../../services/apiClient";
import type { CreateAdministrativeUserRequest, Project, UpdateUserRequest, UserSummary } from "../../types/api";
import { projectStatusLabel } from "../../types/api";

interface Props {
  onNavigate: (page: Page) => void;
}

type Tab = "users" | "projects" | "reports";
type UserForm = UpdateUserRequest;
type CreateUserForm = {
  nombre: string;
  apellido: string;
  correo: string;
  password: string;
  rol: "Estudiante" | "Profesor";
};

function errorMessage(error: unknown): string {
  return error instanceof ApiError ? error.message : "No se pudo cargar la información.";
}

function formatDate(value: string): string {
  const date = new Date(value);
  return Number.isNaN(date.getTime()) ? value : date.toLocaleDateString("es-ES");
}

function statusStyle(status: string | number) {
  const label = typeof status === "number" ? projectStatusLabel(status) : status;
  return label.toLowerCase().includes("abierto") || label.toLowerCase().includes("activo")
    ? { backgroundColor: "#D1F2E2", color: "#0B3D2E" }
    : { backgroundColor: "#E0E7FF", color: "#3730A3" };
}

export default function AdminPanel({ onNavigate }: Props) {
  const { user } = useAuth();
  const [tab, setTab] = useState<Tab>("users");
  const [users, setUsers] = useState<UserSummary[]>([]);
  const [projects, setProjects] = useState<Project[]>([]);
  const [usersLoaded, setUsersLoaded] = useState(false);
  const [projectsLoaded, setProjectsLoaded] = useState(false);
  const [usersRequested, setUsersRequested] = useState(false);
  const [projectsRequested, setProjectsRequested] = useState(false);
  const [usersLoading, setUsersLoading] = useState(false);
  const [projectsLoading, setProjectsLoading] = useState(false);
  const [usersError, setUsersError] = useState<string | null>(null);
  const [projectsError, setProjectsError] = useState<string | null>(null);
  const [editingUser, setEditingUser] = useState<UserSummary | null>(null);
  const [creatingUser, setCreatingUser] = useState(false);
  const [createForm, setCreateForm] = useState<CreateUserForm>({ nombre: "", apellido: "", correo: "", password: "", rol: "Estudiante" });
  const [createError, setCreateError] = useState<string | null>(null);
  const [createSaving, setCreateSaving] = useState(false);
  const [form, setForm] = useState<UserForm>({ nombre: "", apellido: "", correo: "" });
  const [saving, setSaving] = useState(false);
  const [actionError, setActionError] = useState<string | null>(null);
  const [assigningId, setAssigningId] = useState<number | null>(null);

  const loadUsers = useCallback(async () => {
    setUsersRequested(true);
    setUsersLoading(true);
    setUsersError(null);
    try {
      setUsers(await api.users());
      setUsersLoaded(true);
    } catch (loadError) {
      setUsersError(errorMessage(loadError));
    } finally {
      setUsersLoading(false);
    }
  }, []);

  const loadProjects = useCallback(async () => {
    setProjectsRequested(true);
    setProjectsLoading(true);
    setProjectsError(null);
    try {
      setProjects(await api.projects());
      setProjectsLoaded(true);
    } catch (loadError) {
      setProjectsError(errorMessage(loadError));
    } finally {
      setProjectsLoading(false);
    }
  }, []);

  useEffect(() => {
    if (tab === "users" && !usersLoaded && !usersRequested) void loadUsers();
    if (tab === "projects" && !projectsLoaded && !projectsRequested) void loadProjects();
    if (tab === "reports") {
      if (!usersLoaded && !usersRequested) void loadUsers();
      if (!projectsLoaded && !projectsRequested) void loadProjects();
    }
  }, [loadProjects, loadUsers, projectsLoaded, projectsRequested, tab, usersLoaded, usersRequested]);

  const openCreateUser = () => {
    setCreateError(null);
    setCreateForm({ nombre: "", apellido: "", correo: "", password: "", rol: "Estudiante" });
    setCreatingUser(true);
  };

  const validateCreateUser = () => {
    if (!createForm.nombre.trim() || !createForm.apellido.trim() || !createForm.correo.trim() || !createForm.password) return "Nombre, apellido, correo y contraseña son obligatorios.";
    if (!/^\S+@\S+\.\S+$/.test(createForm.correo)) return "Introduce un correo electrónico válido.";
    if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}$/.test(createForm.password)) return "La contraseña debe tener al menos 8 caracteres, mayúscula, minúscula, número y símbolo.";
    return null;
  };

  const submitCreateUser = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const validationError = validateCreateUser();
    if (validationError) {
      setCreateError(validationError);
      return;
    }
    if (!window.confirm(`¿Confirmas crear la cuenta de ${createForm.nombre.trim()} ${createForm.apellido.trim()}?`)) return;

    setCreateSaving(true);
    setCreateError(null);
    try {
      const created = await api.createAdministrativeUser(createForm as CreateAdministrativeUserRequest);
      setUsers(current => [...current, created]);
      setUsersLoaded(true);
      setCreatingUser(false);
    } catch (createRequestError) {
      setCreateError(errorMessage(createRequestError));
    } finally {
      setCreateSaving(false);
    }
  };

  const openEditor = (selectedUser: UserSummary) => {
    setActionError(null);
    setEditingUser(selectedUser);
    setForm({ nombre: selectedUser.nombre, apellido: selectedUser.apellido, correo: selectedUser.correo });
  };

  const saveUser = async () => {
    if (!editingUser || !form.nombre.trim() || !form.apellido.trim() || !form.correo.trim()) {
      setActionError("Nombre, apellido y correo son obligatorios.");
      return;
    }
    if (!window.confirm("¿Confirmas guardar los cambios de este usuario?")) return;
    setSaving(true);
    setActionError(null);
    try {
      const updated = await api.updateUser(editingUser.id, {
        nombre: form.nombre.trim(),
        apellido: form.apellido.trim(),
        correo: form.correo.trim(),
      });
      setUsers(current => current.map(item => item.id === updated.id ? updated : item));
      setEditingUser(null);
    } catch (saveError) {
      setActionError(errorMessage(saveError));
    } finally {
      setSaving(false);
    }
  };

  const assignProfessor = async (selectedUser: UserSummary) => {
    if (!window.confirm(`¿Confirmas asignar el rol Profesor a ${selectedUser.nombre} ${selectedUser.apellido}?`)) return;
    setAssigningId(selectedUser.id);
    setActionError(null);
    try {
      const updated = await api.assignProfessor(selectedUser.id);
      setUsers(current => current.map(item => item.id === updated.id ? updated : item));
    } catch (assignError) {
      setActionError(errorMessage(assignError));
    } finally {
      setAssigningId(null);
    }
  };

  const activeUsers = users.filter(item => item.activo).length;
  const professorCount = users.filter(item => item.rol === "Profesor").length;
  const studentCount = users.filter(item => item.rol === "Estudiante").length;
  const activeProjects = projects.filter(item => {
    const label = projectStatusLabel(item.estado).toLowerCase();
    return label.includes("abierto") || label.includes("activo") || label.includes("curso");
  }).length;
  const stats = tab === "reports" || users.length > 0 || projects.length > 0 ? [
    { label: "Estudiantes", value: usersLoaded ? String(studentCount) : "No disponible", icon: "👥" },
    { label: "Profesores", value: usersLoaded ? String(professorCount) : "No disponible", icon: "👨‍🏫" },
    { label: "Proyectos activos", value: projectsLoaded ? String(activeProjects) : "No disponible", icon: "📋" },
    { label: "Usuarios activos", value: usersLoaded ? String(activeUsers) : "No disponible", icon: "✓" },
    { label: "Match promedio global", value: "No disponible", icon: "🎯" },
  ] : [];

  return (
    <Layout currentPage="admin-panel" onNavigate={onNavigate}>
      <div className="px-8 py-8 max-w-screen-xl">
        {/* Encabezado */}
        <div className="flex items-center justify-between mb-6">
          <div>
            <div className="flex items-center gap-2 mb-1">
              <span
                className="text-xs font-semibold px-2.5 py-1 rounded-full text-white"
                style={{ backgroundColor: "#0B3D2E" }}
              >
                Panel Administrador
              </span>
            </div>
            <h1 className="text-xl font-bold text-gray-900">Gestión de TalentMatch</h1>
            <p className="text-sm text-gray-500 mt-0.5">Universidad CUN</p>
          </div>
          <div className="flex items-center gap-3">
            <div
              className="w-10 h-10 rounded-full flex items-center justify-center text-white font-semibold"
              style={{ backgroundColor: "#176B45" }}
            >
              {user?.nombre?.charAt(0) ?? "A"}
            </div>
            <div>
              <p className="text-sm font-semibold text-gray-900">
                {user ? `${user.nombre} ${user.apellido}` : "Administrador"}
              </p>
              <p className="text-xs text-gray-500">{user?.rol ?? "Administrador"}</p>
            </div>
          </div>
        </div>

        {/* Estadísticas */}
        <div className="grid grid-cols-5 gap-4 mb-6">
          {stats.map((stat) => (
            <div
              key={stat.label}
              className="bg-white rounded-2xl p-4 shadow-sm border"
              style={{ borderColor: "#E5EDE8" }}
            >
              <div className="flex items-center justify-between mb-1">
                <span className="text-xl">{stat.icon}</span>
              </div>
              <p className="text-2xl font-bold text-gray-900">{stat.value}</p>
              <p className="text-xs text-gray-400 mt-0.5">{stat.label}</p>
            </div>
          ))}
        </div>

        {/* Pestañas */}
        <div className="flex gap-1 bg-gray-100 rounded-xl p-1 w-fit mb-5">
          {([
            ["users", "Usuarios"],
            ["projects", "Proyectos"],
            ["reports", "Reportes"],
          ] as const).map(([id, label]) => (
            <button
              key={id}
              onClick={() => setTab(id)}
              className={`px-4 py-1.5 rounded-lg text-sm font-medium transition-all ${
                tab === id
                  ? "bg-white shadow-sm text-gray-900"
                  : "text-gray-500 hover:text-gray-700"
              }`}
            >
              {label}
            </button>
          ))}
        </div>

        {/* Contenido de las pestañas */}
        {tab === "users" && (
          <div
            className="bg-white rounded-2xl shadow-sm border overflow-hidden"
            style={{ borderColor: "#E5EDE8" }}
          >
            {/* Encabezado de tabla */}
            <div
              className="px-5 py-4 border-b flex items-center justify-between"
              style={{ borderColor: "#F5F5F5" }}
            >
              <div>
                <h3 className="font-semibold text-gray-900">Usuarios</h3>
                <p className="text-xs text-gray-500 mt-1">
                  {usersLoaded ? `${users.length} registros reales` : "Consulta protegida por JWT"}
                </p>
              </div>
              <button
                onClick={openCreateUser}
                className="text-xs font-medium px-3 py-1.5 rounded-xl text-white"
                style={{ backgroundColor: "#176B45" }}
              >
                + Agregar usuario
              </button>
            </div>

            {/* Estado de carga y errores */}
            {usersLoading && (
              <div className="p-8 text-center text-sm text-gray-500">Cargando usuarios...</div>
            )}

            {!usersLoading && usersError && (
              <div className="p-5 text-sm text-red-700 bg-red-50">
                <p>{usersError}</p>
                <button
                  onClick={() => void loadUsers()}
                  className="mt-3 px-3 py-1.5 rounded-lg border border-red-300 text-red-700"
                >
                  Reintentar
                </button>
              </div>
            )}

            {/* Tabla de usuarios */}
            {!usersLoading && !usersError && usersLoaded && users.length === 0 && (
              <div className="p-8 text-center text-sm text-gray-500">
                No hay usuarios para mostrar.
              </div>
            )}

            {!usersLoading && !usersError && usersLoaded && users.length > 0 && (
              <div className="overflow-x-auto">
                <table className="w-full">
                  <thead>
                    <tr style={{ backgroundColor: "#F7FAF8" }}>
                      {["Usuario", "Correo", "Rol", "Estado", "Registro", "Acciones"].map((heading) => (
                        <th
                          key={heading}
                          className="text-left text-xs font-semibold uppercase tracking-wider text-gray-500 px-5 py-3"
                        >
                          {heading}
                        </th>
                      ))}
                    </tr>
                  </thead>
                  <tbody>
                    {users.map((item) => (
                      <tr
                        key={item.id}
                        className="border-t hover:bg-gray-50"
                        style={{ borderColor: "#F5F5F5" }}
                      >
                        <td className="px-5 py-3 text-sm font-medium text-gray-900">
                          {item.nombre} {item.apellido}
                        </td>
                        <td className="px-5 py-3 text-sm text-gray-500">{item.correo}</td>
                        <td className="px-5 py-3">
                          <span
                            className="text-xs px-2.5 py-1 rounded-full font-medium"
                            style={
                              item.rol === "Profesor"
                                ? { backgroundColor: "#EDE9FE", color: "#5B21B6" }
                                : { backgroundColor: "#D1F2E2", color: "#0B3D2E" }
                            }
                          >
                            {item.rol}
                          </span>
                        </td>
                        <td className="px-5 py-3 text-sm text-gray-600">
                          {item.activo ? "Activo" : "Inactivo"}
                        </td>
                        <td className="px-5 py-3 text-sm text-gray-500">
                          {formatDate(item.fechaRegistro)}
                        </td>
                        <td className="px-5 py-3">
                          <div className="flex gap-2 flex-wrap">
                            <button
                              onClick={() => openEditor(item)}
                              className="text-xs px-2.5 py-1 rounded-lg border hover:bg-gray-50"
                              style={{ borderColor: "#E5E7EB", color: "#374151" }}
                            >
                              Editar
                            </button>
                            <button
                              disabled
                              title="Funcionalidad pendiente de implementación"
                              className="text-xs px-2.5 py-1 rounded-lg border text-gray-400 opacity-60 cursor-not-allowed"
                              style={{ borderColor: "#D1D5DB" }}
                            >
                              Suspender
                            </button>
                            {item.rol !== "Profesor" && item.rol !== "Administrador" && (
                              <button
                                disabled={assigningId === item.id}
                                onClick={() => void assignProfessor(item)}
                                className="text-xs px-2.5 py-1 rounded-lg border hover:bg-green-50"
                                style={{ borderColor: "#A7D9BD", color: "#176B45" }}
                              >
                                {assigningId === item.id ? "Asignando..." : "Asignar Profesor"}
                              </button>
                            )}
                          </div>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        )}

        {tab === "projects" && (
          <div
            className="bg-white rounded-2xl shadow-sm border overflow-hidden"
            style={{ borderColor: "#E5EDE8" }}
          >
            {/* Encabezado de tabla */}
            <div
              className="px-5 py-4 border-b"
              style={{ borderColor: "#F5F5F5" }}
            >
              <h3 className="font-semibold text-gray-900">Proyectos</h3>
            </div>

            {/* Estado de carga y errores */}
            {projectsLoading && (
              <div className="p-8 text-center text-sm text-gray-500">Cargando proyectos...</div>
            )}

            {!projectsLoading && projectsError && (
              <div className="p-5 text-sm text-red-700 bg-red-50">
                <p>{projectsError}</p>
                <button
                  onClick={() => void loadProjects()}
                  className="mt-3 px-3 py-1.5 rounded-lg border border-red-300 text-red-700"
                >
                  Reintentar
                </button>
              </div>
            )}

            {/* Tabla de proyectos */}
            {!projectsLoading && !projectsError && projectsLoaded && projects.length === 0 && (
              <div className="p-8 text-center text-sm text-gray-500">
                No hay proyectos para mostrar.
              </div>
            )}

            {!projectsLoading && !projectsError && projectsLoaded && projects.length > 0 && (
              <div className="overflow-x-auto">
                <table className="w-full">
                  <thead>
                    <tr style={{ backgroundColor: "#F7FAF8" }}>
                      {["Proyecto", "Profesor ID", "Estado", "Fecha de creación", "Límite", "Cupos"].map(
                        (heading) => (
                          <th
                            key={heading}
                            className="text-left text-xs font-semibold uppercase tracking-wider text-gray-500 px-5 py-3"
                          >
                            {heading}
                          </th>
                        )
                      )}
                    </tr>
                  </thead>
                  <tbody>
                    {projects.map((item) => (
                      <tr
                        key={item.id}
                        className="border-t hover:bg-gray-50"
                        style={{ borderColor: "#F5F5F5" }}
                      >
                        <td className="px-5 py-3 text-sm font-medium text-gray-900">{item.titulo}</td>
                        <td className="px-5 py-3 text-sm text-gray-500">{item.profesorId}</td>
                        <td className="px-5 py-3">
                          <span
                            className="text-xs px-2.5 py-1 rounded-full font-medium"
                            style={statusStyle(item.estado)}
                          >
                            {projectStatusLabel(item.estado)}
                          </span>
                        </td>
                        <td className="px-5 py-3 text-sm text-gray-500">
                          {formatDate(item.fechaCreacion)}
                        </td>
                        <td className="px-5 py-3 text-sm text-gray-500">
                          {item.fechaLimite ? formatDate(item.fechaLimite) : "No disponible"}
                        </td>
                        <td className="px-5 py-3 text-sm text-gray-700">{item.cuposDisponibles}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        )}

        {tab === "reports" && (
          <div className="grid grid-cols-2 gap-5">
            {(usersLoading || projectsLoading) && (
              <div className="col-span-2 bg-white rounded-2xl p-4 text-sm text-gray-500">
                Cargando métricas disponibles...
              </div>
            )}
            {usersError && (
              <div className="col-span-2 bg-red-50 border border-red-200 rounded-2xl p-4 text-sm text-red-700">
                Usuarios: {usersError}
                <button onClick={() => void loadUsers()} className="ml-2 underline">
                  Reintentar
                </button>
              </div>
            )}
            {projectsError && (
              <div className="col-span-2 bg-red-50 border border-red-200 rounded-2xl p-4 text-sm text-red-700">
                Proyectos: {projectsError}
                <button onClick={() => void loadProjects()} className="ml-2 underline">
                  Reintentar
                </button>
              </div>
            )}
            <div
              className="bg-white rounded-2xl p-5 shadow-sm border"
              style={{ borderColor: "#E5EDE8" }}
            >
              <h3 className="font-semibold text-gray-900 mb-3">Resumen disponible</h3>
              <div className="space-y-3 text-sm">
                <p className="flex justify-between">
                  <span className="text-gray-500">Usuarios registrados</span>
                  <strong>{usersLoaded ? users.length : "No disponible"}</strong>
                </p>
                <p className="flex justify-between">
                  <span className="text-gray-500">Proyectos registrados</span>
                  <strong>{projectsLoaded ? projects.length : "No disponible"}</strong>
                </p>
                <p className="flex justify-between">
                  <span className="text-gray-500">Usuarios activos</span>
                  <strong>{usersLoaded ? activeUsers : "No disponible"}</strong>
                </p>
                <p className="flex justify-between">
                  <span className="text-gray-500">Proyectos activos</span>
                  <strong>{projectsLoaded ? activeProjects : "No disponible"}</strong>
                </p>
              </div>
            </div>
            <div
              className="bg-white rounded-2xl p-5 shadow-sm border"
              style={{ borderColor: "#E5EDE8" }}
            >
              <h3 className="font-semibold text-gray-900 mb-3">Métricas no disponibles</h3>
              <p className="text-sm text-gray-500">
                Compatibilidad global, actividad mensual, postulantes por proyecto y habilidades
                demandadas: <strong className="text-gray-700">No disponible</strong>.
              </p>
            </div>
          </div>
        )}

        {/* Mensajes de error generales */}
        {actionError && (
          <div className="mt-5 bg-red-50 border border-red-200 rounded-2xl p-4 text-sm text-red-700">
            {actionError}
          </div>
        )}
      </div>

      {/* Modal de edición de usuario */}
      {editingUser && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 px-4">
          <div className="w-full max-w-md bg-white rounded-2xl shadow-xl p-6">
            <div className="flex items-center justify-between mb-5">
              <h2 className="text-lg font-semibold text-gray-900">Editar usuario</h2>
              <button
                onClick={() => setEditingUser(null)}
                className="text-gray-400 hover:text-gray-700"
                aria-label="Cerrar"
              >
                ✕
              </button>
            </div>
            <div className="space-y-4">
              <label className="block text-sm text-gray-700">
                Nombre
                <input
                  value={form.nombre}
                  onChange={(event) => setForm({ ...form, nombre: event.target.value })}
                  className="mt-1 w-full rounded-lg border px-3 py-2"
                />
              </label>
              <label className="block text-sm text-gray-700">
                Apellido
                <input
                  value={form.apellido}
                  onChange={(event) => setForm({ ...form, apellido: event.target.value })}
                  className="mt-1 w-full rounded-lg border px-3 py-2"
                />
              </label>
              <label className="block text-sm text-gray-700">
                Correo
                <input
                  type="email"
                  value={form.correo}
                  onChange={(event) => setForm({ ...form, correo: event.target.value })}
                  className="mt-1 w-full rounded-lg border px-3 py-2"
                />
              </label>
            </div>
            <div className="flex justify-end gap-3 mt-6">
              <button
                onClick={() => setEditingUser(null)}
                className="px-4 py-2 text-sm rounded-lg border"
              >
                Cancelar
              </button>
              <button
                disabled={saving}
                onClick={() => void saveUser()}
                className="px-4 py-2 text-sm rounded-lg text-white disabled:opacity-60"
                style={{ backgroundColor: "#176B45" }}
              >
                {saving ? "Guardando..." : "Guardar"}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Modal de creación de usuario */}
      {creatingUser && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 px-4">
          <form onSubmit={submitCreateUser} className="w-full max-w-md bg-white rounded-2xl shadow-xl p-6">
            <div className="flex items-center justify-between mb-5">
              <div>
                <h2 className="text-lg font-semibold text-gray-900">Agregar usuario</h2>
                <p className="text-xs text-gray-500 mt-1">Alta protegida para Administradores.</p>
              </div>
              <button
                type="button"
                onClick={() => setCreatingUser(false)}
                className="text-gray-400 hover:text-gray-700"
                aria-label="Cerrar"
              >
                ✕
              </button>
            </div>

            <div className="space-y-3">
              <label className="block text-sm text-gray-700">
                Nombre
                <input
                  required
                  value={createForm.nombre}
                  onChange={(event) => setCreateForm({ ...createForm, nombre: event.target.value })}
                  className="mt-1 w-full rounded-lg border px-3 py-2"
                />
              </label>
              <label className="block text-sm text-gray-700">
                Apellido
                <input
                  required
                  value={createForm.apellido}
                  onChange={(event) => setCreateForm({ ...createForm, apellido: event.target.value })}
                  className="mt-1 w-full rounded-lg border px-3 py-2"
                />
              </label>
              <label className="block text-sm text-gray-700">
                Correo
                <input
                  required
                  type="email"
                  value={createForm.correo}
                  onChange={(event) => setCreateForm({ ...createForm, correo: event.target.value })}
                  className="mt-1 w-full rounded-lg border px-3 py-2"
                />
              </label>
              <label className="block text-sm text-gray-700">
                Contraseña inicial
                <input
                  required
                  minLength={8}
                  type="password"
                  value={createForm.password}
                  onChange={(event) => setCreateForm({ ...createForm, password: event.target.value })}
                  className="mt-1 w-full rounded-lg border px-3 py-2"
                />
                <span className="text-xs text-gray-500">
                  Usa al menos 8 caracteres, mayúscula, minúscula, número y símbolo.
                </span>
              </label>
              <label className="block text-sm text-gray-700">
                Rol
                <select
                  value={createForm.rol}
                  onChange={(event) =>
                    setCreateForm({
                      ...createForm,
                      rol: event.target.value as CreateUserForm["rol"],
                    })
                  }
                  className="mt-1 w-full rounded-lg border px-3 py-2"
                >
                  <option value="Estudiante">Estudiante</option>
                  <option value="Profesor">Profesor</option>
                </select>
              </label>
            </div>

            {(createError || validateCreateUser()) && (
              <p className="mt-4 text-sm text-red-700">{createError || validateCreateUser()}</p>
            )}
            <p className="mt-4 rounded-lg bg-green-50 p-3 text-xs text-green-800">
              La cuenta se creará mediante el endpoint administrativo protegido y nunca mediante el registro público.
            </p>
            <div className="flex justify-end gap-3 mt-6">
              <button
                type="button"
                onClick={() => setCreatingUser(false)}
                className="px-4 py-2 text-sm rounded-lg border"
              >
                Cancelar
              </button>
              <button
                type="submit"
                disabled={createSaving || Boolean(validateCreateUser())}
                className="px-4 py-2 text-sm rounded-lg text-white disabled:opacity-50 disabled:cursor-not-allowed"
                style={{ backgroundColor: "#176B45" }}
              >
                {createSaving ? "Creando..." : "Guardar usuario"}
              </button>
            </div>
          </form>
        </div>
      )}
    </Layout>
  );
}
