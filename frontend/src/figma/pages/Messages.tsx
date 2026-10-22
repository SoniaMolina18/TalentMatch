import Layout from "../components/Layout";
import { Page } from "../types";
import { FormEvent, useCallback, useEffect, useState } from "react";
import { api, ApiError } from "../../services/apiClient";
import type { Conversation } from "../../types/api";

interface Props { onNavigate: (page: Page) => void; }

export default function Messages({ onNavigate }: Props) {
  const [conversations, setConversations] = useState<Conversation[]>([]);
  const [selected, setSelected] = useState<number | null>(null);
  const [content, setContent] = useState("");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [sending, setSending] = useState(false);
  const load = useCallback(async () => {
    setLoading(true); setError(null);
    try { const result = await api.conversations(); setConversations(result); setSelected(current => current ?? result[0]?.id ?? null); }
    catch (err) { setError(err instanceof ApiError ? err.message : "No se pudieron cargar las conversaciones."); }
    finally { setLoading(false); }
  }, []);
  useEffect(() => { void load(); }, [load]);
  const active = conversations.find(item => item.id === selected);
  useEffect(() => {
    if (selected === null) return;
    void api.markConversationRead(selected).catch(() => undefined);
  }, [selected]);
  const send = async (event: FormEvent) => {
    event.preventDefault();
    if (!active || !content.trim()) return;
    setSending(true); setError(null);
    try { const message = await api.sendMessage(active.id, content.trim()); setConversations(current => current.map(item => item.id === active.id ? { ...item, mensajes: [...item.mensajes, message] } : item)); setContent(""); }
    catch (err) { setError(err instanceof ApiError ? err.message : "No se pudo enviar el mensaje."); }
    finally { setSending(false); }
  };

  return (
    <Layout currentPage="messages" onNavigate={onNavigate}>
      <div className="px-8 py-8 max-w-3xl">
        <h1 className="text-xl font-bold text-gray-900">Mensajes</h1>
        {loading && <div className="mt-6 rounded-2xl bg-white p-8 text-sm text-gray-500">Cargando conversaciones...</div>}
        {!loading && error && <div className="mt-6 rounded-2xl border border-red-200 bg-red-50 p-6 text-sm text-red-700"><p>{error}</p><button onClick={() => void load()} className="mt-4 rounded-xl bg-brand-dark px-4 py-2 font-semibold text-white">Reintentar</button></div>}
        {!loading && !error && conversations.length === 0 && <div className="mt-6 rounded-2xl border-2 border-dashed border-[#D1F2E2] bg-white p-12 text-center"><p className="font-semibold text-gray-900">Aún no tienes conversaciones</p><p className="mt-2 text-sm text-gray-500">Las conversaciones aparecerán cuando se habilite el contacto con otro usuario.</p></div>}
        {!loading && conversations.length > 0 && <div className="mt-6 grid gap-4 md:grid-cols-[220px_1fr]"><div className="rounded-2xl border border-[#E5EDE8] bg-white p-3">{conversations.map(item => <button key={item.id} onClick={() => setSelected(item.id)} className={`w-full rounded-xl p-3 text-left text-sm ${item.id === selected ? "bg-[#E7F7EF] text-brand-dark" : "hover:bg-gray-50"}`}>{item.otroNombre} {item.otroApellido}</button>)}</div><section className="flex min-h-[420px] flex-col rounded-2xl border border-[#E5EDE8] bg-white p-5"><h2 className="font-semibold text-gray-900">{active ? `${active.otroNombre} ${active.otroApellido}` : "Conversación"}</h2><div className="mt-4 flex-1 space-y-3 overflow-auto">{active?.mensajes.map(message => <div key={message.id} className={`max-w-[85%] rounded-xl px-3 py-2 text-sm ${message.remitenteId === active.otroUsuarioId ? "bg-gray-100 text-gray-700" : "ml-auto bg-brand-dark text-white"}`}>{message.contenido}<div className="mt-1 text-[10px] opacity-70">{new Date(message.fechaEnvio).toLocaleString("es-CO")}</div></div>)}</div><form onSubmit={send} className="mt-4 flex gap-2"><input value={content} onChange={event => setContent(event.target.value)} placeholder="Escribe un mensaje" className="min-w-0 flex-1 rounded-xl border border-gray-200 px-3 py-2 text-sm" /><button disabled={sending || !content.trim()} className="rounded-xl bg-brand-dark px-4 py-2 text-sm font-semibold text-white disabled:opacity-50">Enviar</button></form></section></div>}
      </div>
    </Layout>
  );
}
