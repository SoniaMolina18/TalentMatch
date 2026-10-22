import { useState } from "react";
import Layout from "../components/Layout";
import MatchScore from "../components/MatchScore";
import { Page } from "../types";

interface Props {
  onNavigate: (page: Page) => void;
}

type RequestStatus = "pending" | "accepted" | "rejected";

const initialRequests = [
  { id: 1, type: "received", title: "Invitación a equipo DataSciUnal", from: "Santiago López", project: "Predicción de deserción universitaria", match: 92, time: "Hace 2 horas", status: "pending" as RequestStatus, img: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=60&h=60&fit=crop&auto=format" },
  { id: 2, type: "sent", title: "Postulación enviada", from: "Prof. Carlos Ramírez", project: "Predicción de deserción universitaria con ML", match: 94, time: "Hace 5 horas", status: "pending" as RequestStatus, img: "https://images.unsplash.com/photo-1568602471122-7832951cc4c5?w=60&h=60&fit=crop&auto=format" },
  { id: 3, type: "received", title: "Solicitud de colaboración", from: "Daniela Torres", project: "App de bienestar estudiantil", match: 85, time: "Ayer", status: "accepted" as RequestStatus, img: "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=60&h=60&fit=crop&auto=format" },
  { id: 4, type: "sent", title: "Postulación enviada", from: "Prof. María González", project: "App móvil de bienestar con IA", match: 88, time: "Hace 3 días", status: "accepted" as RequestStatus, img: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=60&h=60&fit=crop&auto=format" },
];

export default function Requests({ onNavigate }: Props) {
  const [tab, setTab] = useState<"all" | "received" | "sent">("all");
  const [requests, setRequests] = useState(initialRequests);

  const updateStatus = (id: number, status: RequestStatus) => {
    setRequests((prev) => prev.map((r) => r.id === id ? { ...r, status } : r));
  };

  const filtered = requests.filter((r) => tab === "all" || r.type === tab);

  const statusColor: Record<RequestStatus, { bg: string; text: string; label: string }> = {
    pending: { bg: "#FEF3C7", text: "#92400E", label: "Pendiente" },
    accepted: { bg: "#D1F2E2", text: "#0B3D2E", label: "Aceptada" },
    rejected: { bg: "#FEE2E2", text: "#991B1B", label: "Rechazada" },
  };

  return (
    <Layout currentPage="requests" onNavigate={onNavigate}>
      <div className="px-8 py-8 max-w-screen-lg">
        <div className="mb-6">
          <h1 className="text-xl font-bold text-gray-900">Solicitudes</h1>
          <p className="text-sm text-gray-500 mt-0.5">Gestiona tus postulaciones e invitaciones</p>
        </div>

        {/* Summary cards */}
        <div className="grid grid-cols-4 gap-4 mb-6">
          {[
            { label: "Total", val: requests.length, color: "#176B45" },
            { label: "Pendientes", val: requests.filter((r) => r.status === "pending").length, color: "#D97706" },
            { label: "Aceptadas", val: requests.filter((r) => r.status === "accepted").length, color: "#29A66A" },
            { label: "Rechazadas", val: requests.filter((r) => r.status === "rejected").length, color: "#EF4444" },
          ].map((s) => (
            <div key={s.label} className="bg-white rounded-2xl p-4 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
              <p className="text-2xl font-bold" style={{ color: s.color }}>{s.val}</p>
              <p className="text-xs text-gray-500 mt-0.5">{s.label}</p>
            </div>
          ))}
        </div>

        {/* Tabs */}
        <div className="flex gap-1 bg-gray-100 rounded-xl p-1 w-fit mb-5">
          {(["all", "received", "sent"] as const).map((t) => (
            <button
              key={t}
              onClick={() => setTab(t)}
              className={`px-4 py-1.5 rounded-lg text-sm font-medium transition-all ${tab === t ? "bg-white shadow-sm text-gray-900" : "text-gray-500 hover:text-gray-700"}`}
            >
              {t === "all" ? "Todas" : t === "received" ? "Recibidas" : "Enviadas"}
            </button>
          ))}
        </div>

        {/* Requests list */}
        <div className="space-y-3">
          {filtered.map((r) => {
            const sc = statusColor[r.status];
            return (
              <div key={r.id} className="bg-white rounded-2xl p-5 shadow-sm border" style={{ borderColor: "#E5EDE8" }}>
                <div className="flex items-start gap-4">
                  <img src={r.img} alt="" className="w-12 h-12 rounded-full object-cover shrink-0" />
                  <div className="flex-1 min-w-0">
                    <div className="flex items-start justify-between">
                      <div>
                        <h3 className="text-sm font-semibold text-gray-900">{r.title}</h3>
                        <p className="text-xs text-gray-500 mt-0.5">
                          {r.type === "received" ? "De" : "Para"}: <strong>{r.from}</strong>
                        </p>
                      </div>
                      <div className="flex items-center gap-2 shrink-0">
                        <MatchScore score={r.match} size="sm" />
                        <span className="text-xs font-semibold px-2.5 py-1 rounded-full" style={{ backgroundColor: sc.bg, color: sc.text }}>
                          {sc.label}
                        </span>
                      </div>
                    </div>
                    <p className="text-xs text-gray-500 mt-1.5">
                      📋 {r.project} · ⏱ {r.time}
                    </p>
                    {r.status === "pending" && r.type === "received" && (
                      <div className="flex gap-2 mt-3">
                        <button
                          onClick={() => updateStatus(r.id, "accepted")}
                          className="px-4 py-1.5 rounded-xl text-sm font-semibold text-white hover:opacity-90"
                          style={{ backgroundColor: "#176B45" }}
                        >
                          Aceptar
                        </button>
                        <button
                          onClick={() => updateStatus(r.id, "rejected")}
                          className="px-4 py-1.5 rounded-xl text-sm font-medium border text-gray-600 hover:bg-gray-50"
                          style={{ borderColor: "#E5E7EB" }}
                        >
                          Rechazar
                        </button>
                        <button
                          onClick={() => onNavigate("student-profile")}
                          className="px-4 py-1.5 rounded-xl text-sm font-medium border hover:bg-gray-50 transition-colors"
                          style={{ borderColor: "#29A66A", color: "#176B45" }}
                        >
                          Ver perfil
                        </button>
                      </div>
                    )}
                    {r.status === "pending" && r.type === "sent" && (
                      <div className="mt-3">
                        <button
                          onClick={() => updateStatus(r.id, "rejected")}
                          className="px-4 py-1.5 rounded-xl text-sm font-medium border text-gray-500 hover:bg-gray-50"
                          style={{ borderColor: "#E5E7EB" }}
                        >
                          Cancelar solicitud
                        </button>
                      </div>
                    )}
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </Layout>
  );
}
