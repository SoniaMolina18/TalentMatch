import { FormEvent, useEffect, useState } from "react";
import Layout from "../components/Layout";
import { Page } from "../types";
import { ApiError, api } from "../../services/apiClient";
import type { Interest, Skill } from "../../types/api";

interface Props { onNavigate: (page: Page) => void; }

export default function CreateCollaborativeProject({ onNavigate }: Props) {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [objective, setObjective] = useState("");
  const [slots, setSlots] = useState("1");
  const [deadline, setDeadline] = useState("");
  const [skills, setSkills] = useState<Skill[]>([]);
  const [interests, setInterests] = useState<Interest[]>([]);
  const [selectedSkills, setSelectedSkills] = useState<number[]>([]);
  const [selectedInterests, setSelectedInterests] = useState<number[]>([]);
  const [loadingCatalogs, setLoadingCatalogs] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
	Promise.all([api.skills(), api.interests()])
	  .then(([loadedSkills, loadedInterests]) => { setSkills(loadedSkills); setInterests(loadedInterests); })
	  .catch(err => setError(err instanceof ApiError ? err.message : "No se pudieron cargar los catálogos."))
	  .finally(() => setLoadingCatalogs(false));
  }, []);

  function toggle(values: number[], value: number, setter: (next: number[]) => void) {
	setter(values.includes(value) ? values.filter(item => item !== value) : [...values, value]);
  }

  async function submit(event: FormEvent) {
	event.preventDefault();
	const numericSlots = Number(slots);
	if (!title.trim() || !description.trim() || !Number.isInteger(numericSlots) || numericSlots <= 0) {
	  setError("El título, la descripción y los cupos mayores que cero son obligatorios."); return;
	}
	if (selectedSkills.length === 0) { setError("Selecciona al menos una habilidad requerida."); return; }
	setSaving(true); setError("");
	try {
	  await api.createCollaborativeProject({
		titulo: title.trim(), descripcion: description.trim(), objetivo: objective.trim() || undefined,
		cuposDisponibles: numericSlots, fechaLimite: deadline || undefined,
		habilidadesIds: selectedSkills, interesesIds: selectedInterests,
	  });
	  onNavigate("my-projects");
	} catch (err) { setError(err instanceof ApiError ? err.message : "No se pudo crear el proyecto."); }
	finally { setSaving(false); }
  }

  return <Layout currentPage="create-collaborative-project" onNavigate={onNavigate}>
	<div className="max-w-3xl px-8 py-8">
	  <button type="button" onClick={() => onNavigate("my-projects")} className="text-sm font-medium text-brand-dark">Volver</button>
	  <h1 className="mt-4 text-2xl font-bold text-gray-900">Crear proyecto colaborativo</h1>
	  <p className="mt-2 text-sm text-gray-500">Serás líder del equipo creado para este proyecto.</p>
	  <form onSubmit={submit} className="mt-6 space-y-5">
		{error && <div className="rounded-xl bg-red-50 px-4 py-3 text-sm text-red-700">{error}</div>}
		<div className="space-y-4 rounded-2xl border border-[#E5EDE8] bg-white p-6 shadow-sm">
		  <input required value={title} onChange={event => setTitle(event.target.value)} placeholder="Título *" className="w-full rounded-xl border border-gray-200 px-4 py-2.5 text-sm" />
		  <textarea required rows={5} value={description} onChange={event => setDescription(event.target.value)} placeholder="Descripción *" className="w-full rounded-xl border border-gray-200 px-4 py-2.5 text-sm" />
		  <textarea rows={3} value={objective} onChange={event => setObjective(event.target.value)} placeholder="Objetivo" className="w-full rounded-xl border border-gray-200 px-4 py-2.5 text-sm" />
		  <div className="grid gap-4 sm:grid-cols-2">
			<input required min="1" step="1" type="number" value={slots} onChange={event => setSlots(event.target.value)} placeholder="Cupos *" className="rounded-xl border border-gray-200 px-4 py-2.5 text-sm" />
			<input type="date" value={deadline} onChange={event => setDeadline(event.target.value)} className="rounded-xl border border-gray-200 px-4 py-2.5 text-sm" />
		  </div>
		</div>
		<div className="grid gap-5 md:grid-cols-2">
		  <Catalog title="Habilidades requeridas *" loading={loadingCatalogs} items={skills.map(item => ({ id: item.id, name: item.nombre }))} selected={selectedSkills} onToggle={value => toggle(selectedSkills, value, setSelectedSkills)} />
		  <Catalog title="Intereses relacionados" loading={loadingCatalogs} items={interests.map(item => ({ id: item.id, name: item.nombre }))} selected={selectedInterests} onToggle={value => toggle(selectedInterests, value, setSelectedInterests)} />
		</div>
		<button disabled={saving || loadingCatalogs} className="w-full rounded-xl bg-brand-dark px-4 py-3 text-sm font-semibold text-white disabled:opacity-50">{saving ? "Creando..." : "Crear proyecto colaborativo"}</button>
	  </form>
	</div>
  </Layout>;
}

function Catalog({ title, loading, items, selected, onToggle }: { title: string; loading: boolean; items: { id: number; name: string }[]; selected: number[]; onToggle: (id: number) => void }) {
  return <fieldset className="rounded-2xl border border-[#E5EDE8] bg-white p-5 shadow-sm"><legend className="px-1 text-sm font-semibold text-gray-800">{title}</legend>{loading ? <p className="text-sm text-gray-500">Cargando...</p> : <div className="mt-2 max-h-52 space-y-2 overflow-y-auto">{items.map(item => <label key={item.id} className="flex items-center gap-2 text-sm text-gray-700"><input type="checkbox" checked={selected.includes(item.id)} onChange={() => onToggle(item.id)} />{item.name}</label>)}</div>}</fieldset>;
}
