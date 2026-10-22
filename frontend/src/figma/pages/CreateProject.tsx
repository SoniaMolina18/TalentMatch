import { FormEvent, useState } from "react";
import { useAuth } from "../../features/auth/AuthContext";
import { ApiError, api } from "../../services/apiClient";
import { Page } from "../types";

interface Props { onNavigate: (page: Page) => void; }

export default function CreateProject({ onNavigate }: Props) {
  const { user } = useAuth();
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [deadline, setDeadline] = useState("");
  const [slots, setSlots] = useState("1");
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState("");

  async function submit(event: FormEvent) {
    event.preventDefault();
    if (!user) return;
    const normalizedTitle = title.trim();
    const normalizedDescription = description.trim();
    const numericSlots = Number(slots);
    if (!normalizedTitle || !normalizedDescription || !deadline || !Number.isInteger(numericSlots) || numericSlots < 1) {
      setError("Completa t&iacute;tulo, descripci&oacute;n, fecha l&iacute;mite y un n&uacute;mero entero de cupos mayor que cero.");
      return;
    }
    setError("");
    setSaving(true);
    try {
      await api.createProject({ titulo: normalizedTitle, descripcion: normalizedDescription, fechaLimite: deadline, cuposDisponibles: numericSlots });
      onNavigate("teacher-panel");
    } catch (err) {
      setError(err instanceof ApiError ? err.message : "No se pudo crear el proyecto.");
    } finally {
      setSaving(false);
    }
  }

  return (
    <div className="min-h-full bg-[#F7FAF8]">
      {/* Top nav */}
      <div className="bg-white border-b border-[#E5EDE8] px-8 py-4 flex items-center gap-4">
        <button type="button" onClick={() => onNavigate("teacher-panel")} className="text-sm font-medium text-brand-dark">Volver</button>
        <h1 className="text-sm font-semibold text-gray-900">Crear nuevo proyecto</h1>
      </div>

      <div className="max-w-3xl mx-auto px-6 py-10">
        <h2 className="text-2xl font-bold text-gray-900 mb-8">Nuevo proyecto acad&eacute;mico</h2>
        <p className="text-sm text-gray-500 mb-8">Completa &uacute;nicamente la informaci&oacute;n que admite la API.</p>

        <form className="space-y-5" onSubmit={submit}>
          {error && <div className="rounded-xl bg-red-50 px-4 py-3 text-sm text-red-700">{error}</div>}

          {/* Basic info */}
          <div className="bg-white rounded-2xl p-6 shadow-sm border border-[#E5EDE8] space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1.5" htmlFor="titulo">T&iacute;tulo *</label>
              <input
                id="titulo"
                required
                value={title}
                onChange={event => setTitle(event.target.value)}
                className="w-full px-4 py-2.5 text-sm rounded-xl border border-brand-light bg-brand-bg outline-none"
                placeholder="Ej: Predicci&oacute;n de deserci&oacute;n universitaria con ML"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1.5" htmlFor="descripcion">Descripci&oacute;n *</label>
              <textarea
                id="descripcion"
                required
                rows={6}
                value={description}
                onChange={event => setDescription(event.target.value)}
                className="w-full px-4 py-2.5 text-sm rounded-xl border border-brand-light bg-brand-bg outline-none resize-y"
                placeholder="Describe el objetivo, metodolog&iacute;a y alcance del proyecto..."
              />
            </div>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1.5" htmlFor="fecha">Fecha l&iacute;mite *</label>
                <input
                  id="fecha"
                  required
                  type="date"
                  value={deadline}
                  onChange={event => setDeadline(event.target.value)}
                  className="w-full px-4 py-2.5 text-sm rounded-xl border border-brand-light bg-brand-bg outline-none"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1.5" htmlFor="cupos">Cupos disponibles *</label>
                <input
                  id="cupos"
                  required
                  type="number"
                  min="1"
                  step="1"
                  value={slots}
                  onChange={event => setSlots(event.target.value)}
                  className="w-full px-4 py-2.5 text-sm rounded-xl border border-brand-light bg-brand-bg outline-none"
                />
              </div>
            </div>
          </div>

          {/* Submit */}
          <div className="flex gap-3">
            <button
              type="button"
              onClick={() => onNavigate("teacher-panel")}
              className="flex-1 py-3 rounded-xl border text-sm font-semibold text-gray-700 hover:bg-gray-50"
              style={{ borderColor: "#E5E7EB" }}
            >
              Cancelar
            </button>
            <button
              type="submit"
              disabled={saving}
              className="flex-1 py-3 rounded-xl bg-brand-dark text-white text-sm font-semibold disabled:opacity-50"
            >
              {saving ? "Guardando..." : "Crear proyecto"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
