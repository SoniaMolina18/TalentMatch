import { FormEvent, useEffect, useState } from "react";
import Layout from "../components/Layout";
import { ApiError, api } from "../../services/apiClient";
import { useAuth } from "../../features/auth/AuthContext";
import type { Profile } from "../../types/api";
import { Page } from "../types";

interface Props {
  onNavigate: (page: Page) => void;
}

export default function StudentProfile({ onNavigate }: Props) {
  const { user } = useAuth();
  const [profile, setProfile] = useState<Profile | null>(null);
  const [description, setDescription] = useState("");
  const [availability, setAvailability] = useState("");
  const [photo, setPhoto] = useState("");
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState("");
  const [message, setMessage] = useState("");

  useEffect(() => {
    if (!user) {
      setLoading(false);
      setError("Debes iniciar sesión para consultar tu perfil.");
      return;
    }
    let cancelled = false;
    api.profile(user.id)
      .then((value) => {
        if (cancelled) return;
        setProfile(value);
        setDescription(value.descripcion ?? "");
        setAvailability(value.disponibilidad ?? "");
        setPhoto(value.fotoPerfil ?? "");
      })
      .catch((err) => { if (!cancelled) setError(err instanceof ApiError ? err.message : "No se pudo cargar el perfil."); })
      .finally(() => { if (!cancelled) setLoading(false); });
    return () => { cancelled = true; };
  }, [user?.id]);

  async function save(event: FormEvent) {
    event.preventDefault();
    if (!user) return;
    setSaving(true);
    setError("");
    setMessage("");
    try {
      const value = await api.updateProfile(user.id, {
        descripcion: description.trim(),
        disponibilidad: availability.trim(),
        fotoPerfil: photo.trim(),
      });
      setProfile(value);
      setMessage("Perfil actualizado correctamente.");
    } catch (err) {
      setError(err instanceof ApiError ? err.message : "No se pudo actualizar el perfil.");
    } finally {
      setSaving(false);
    }
  }

  return (
    <Layout currentPage="student-profile" onNavigate={onNavigate}>
      <div className="px-8 py-8 max-w-3xl">
        <h1 className="text-xl font-bold text-gray-900">Mi perfil</h1>
        <p className="text-sm text-gray-500 mt-1">Información propia gestionada por la API.</p>

        {loading ? (
          <p className="mt-6 text-sm text-gray-500">Cargando perfil…</p>
        ) : (
          <form
            onSubmit={save}
            className="mt-6 bg-white rounded-2xl p-6 border border-[#E5EDE8] space-y-4"
          >
            {error && (
              <div className="rounded-xl bg-red-50 px-4 py-3 text-sm text-red-700">
                {error}
              </div>
            )}
            {message && (
              <div className="rounded-xl bg-green-50 px-4 py-3 text-sm text-green-700">
                {message}
              </div>
            )}
            <div>
              <p className="text-sm font-semibold text-gray-900">
                {user?.nombre} {user?.apellido}
              </p>
              <p className="text-sm text-gray-500">
                {user?.correo} · {user?.rol}
              </p>
            </div>

            <div>
              <label
                htmlFor="descripcion"
                className="block text-sm font-medium text-gray-700 mb-1"
              >
                Descripción
              </label>
              <textarea
                id="descripcion"
                rows={6}
                value={description}
                onChange={(e) => setDescription(e.target.value)}
                className="w-full rounded-xl border border-brand-light bg-brand-bg px-4 py-3 text-sm"
              />
            </div>

            <div>
              <label
                htmlFor="disponibilidad"
                className="block text-sm font-medium text-gray-700 mb-1"
              >
                Disponibilidad
              </label>
              <input
                id="disponibilidad"
                value={availability}
                onChange={(e) => setAvailability(e.target.value)}
                className="w-full rounded-xl border border-brand-light bg-brand-bg px-4 py-3 text-sm"
              />
            </div>

            <div>
              <label
                htmlFor="foto"
                className="block text-sm font-medium text-gray-700 mb-1"
              >
                URL de foto (opcional)
              </label>
              <input
                id="foto"
                type="url"
                value={photo}
                onChange={(e) => setPhoto(e.target.value)}
                className="w-full rounded-xl border border-brand-light bg-brand-bg px-4 py-3 text-sm"
              />
            </div>

            <button
              type="submit"
              disabled={saving}
              className="rounded-xl bg-brand-dark px-5 py-3 text-sm font-semibold text-white disabled:opacity-50"
            >
              {saving ? "Guardando…" : "Guardar cambios"}
            </button>

            <button
              type="button"
              disabled
              title="La API no ofrece generación ni descarga de CV."
              className="w-full py-2 rounded-xl border text-sm font-medium text-gray-400 cursor-not-allowed"
              style={{ borderColor: "#E5E7EB" }}
            >
              Descargar CV (no disponible)
            </button>
          </form>
        )}
      </div>
    </Layout>
  );
}
