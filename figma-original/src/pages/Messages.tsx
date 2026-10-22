import { useState } from "react";
import Layout from "../components/Layout";
import { Page } from "../types";

interface Props {
  onNavigate: (page: Page) => void;
}

const conversations = [
  { id: 1, name: "Santiago López", role: "ML Engineer", last: "¿Puedes revisar el notebook de preprocesamiento?", time: "10:30", unread: 2, img: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=60&h=60&fit=crop&auto=format", online: true },
  { id: 2, name: "Prof. Carlos Ramírez", role: "Profesor", last: "Tu postulación fue revisada. Nos ponemos en contacto pronto.", time: "9:15", unread: 0, img: "https://images.unsplash.com/photo-1568602471122-7832951cc4c5?w=60&h=60&fit=crop&auto=format", online: false },
  { id: 3, name: "Daniela Torres", role: "UI/UX Designer", last: "¡Genial! Mañana subimos el prototipo.", time: "Ayer", unread: 0, img: "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=60&h=60&fit=crop&auto=format", online: true },
  { id: 4, name: "Equipo DataSciUnal", role: "Equipo · 3 miembros", last: "Felipe: Reunión mañana a las 3pm", time: "Ayer", unread: 1, img: "https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=60&h=60&fit=crop&auto=format", online: false },
];

const initialMessages: Record<number, { from: string; text: string; time: string; mine: boolean }[]> = {
  1: [
    { from: "Santiago López", text: "Hola Yuliana! ¿Cómo vas con el análisis de los datos de matrícula?", time: "10:15", mine: false },
    { from: "Yo", text: "¡Bien! Ya terminé la limpieza. Hay algunos valores nulos en 2018-2019 que tuve que imputar.", time: "10:22", mine: true },
    { from: "Santiago López", text: "Perfecto. ¿Puedes revisar el notebook de preprocesamiento?", time: "10:30", mine: false },
  ],
};

export default function Messages({ onNavigate }: Props) {
  const [activeConv, setActiveConv] = useState(1);
  const [messages, setMessages] = useState(initialMessages);
  const [input, setInput] = useState("");

  const conv = conversations.find((c) => c.id === activeConv)!;
  const convMessages = messages[activeConv] || [];

  const send = () => {
    if (!input.trim()) return;
    setMessages((prev) => ({
      ...prev,
      [activeConv]: [...(prev[activeConv] || []), { from: "Yo", text: input, time: new Date().toLocaleTimeString("es-CO", { hour: "2-digit", minute: "2-digit" }), mine: true }],
    }));
    setInput("");
  };

  return (
    <Layout currentPage="messages" onNavigate={onNavigate}>
      <div className="flex flex-1 overflow-hidden" style={{ height: "calc(100vh - 0px)" }}>
        {/* Conversations list */}
        <div className="w-72 border-r bg-white flex flex-col shrink-0" style={{ borderColor: "#E5EDE8" }}>
          <div className="p-4 border-b" style={{ borderColor: "#E5EDE8" }}>
            <h2 className="font-semibold text-gray-900 mb-3">Mensajes</h2>
            <div className="relative">
              <svg className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><circle cx="11" cy="11" r="8" /><line x1="21" y1="21" x2="16.65" y2="16.65" /></svg>
              <input placeholder="Buscar conversación..." className="w-full pl-9 pr-4 py-2 text-sm rounded-xl border outline-none" style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }} />
            </div>
          </div>
          <div className="flex-1 overflow-y-auto">
            {conversations.map((c) => (
              <button
                key={c.id}
                onClick={() => setActiveConv(c.id)}
                className={`w-full px-4 py-3 flex items-center gap-3 text-left transition-colors border-b ${activeConv === c.id ? "" : "hover:bg-gray-50"}`}
                style={{
                  borderColor: "#F5F5F5",
                  backgroundColor: activeConv === c.id ? "#F0FDF4" : undefined,
                  borderLeft: activeConv === c.id ? "3px solid #29A66A" : "3px solid transparent",
                }}
              >
                <div className="relative shrink-0">
                  <img src={c.img} alt={c.name} className="w-10 h-10 rounded-full object-cover" />
                  {c.online && <div className="absolute bottom-0 right-0 w-2.5 h-2.5 rounded-full border-2 border-white" style={{ backgroundColor: "#29A66A" }} />}
                </div>
                <div className="flex-1 min-w-0">
                  <div className="flex items-center justify-between">
                    <span className="text-sm font-semibold text-gray-900 truncate">{c.name}</span>
                    <span className="text-xs text-gray-400 shrink-0 ml-1">{c.time}</span>
                  </div>
                  <p className="text-xs text-gray-500 truncate mt-0.5">{c.last}</p>
                </div>
                {c.unread > 0 && (
                  <span className="w-5 h-5 rounded-full text-xs font-bold text-white flex items-center justify-center shrink-0" style={{ backgroundColor: "#29A66A" }}>{c.unread}</span>
                )}
              </button>
            ))}
          </div>
        </div>

        {/* Chat area */}
        <div className="flex-1 flex flex-col">
          {/* Chat header */}
          <div className="bg-white border-b px-5 py-4 flex items-center gap-3 shrink-0" style={{ borderColor: "#E5EDE8" }}>
            <div className="relative">
              <img src={conv.img} alt={conv.name} className="w-10 h-10 rounded-full object-cover" />
              {conv.online && <div className="absolute bottom-0 right-0 w-2.5 h-2.5 rounded-full border-2 border-white" style={{ backgroundColor: "#29A66A" }} />}
            </div>
            <div>
              <p className="text-sm font-semibold text-gray-900">{conv.name}</p>
              <p className="text-xs text-gray-500">{conv.role} · {conv.online ? <span style={{ color: "#29A66A" }}>En línea</span> : "Desconectado"}</p>
            </div>
            <div className="ml-auto flex gap-2">
              {["📞", "📹", "⋯"].map((icon) => (
                <button key={icon} className="w-8 h-8 rounded-lg hover:bg-gray-100 flex items-center justify-center text-sm">{icon}</button>
              ))}
            </div>
          </div>

          {/* Messages */}
          <div className="flex-1 overflow-y-auto p-5 space-y-3" style={{ backgroundColor: "#F7FAF8" }}>
            {convMessages.map((m, i) => (
              <div key={i} className={`flex ${m.mine ? "justify-end" : "justify-start"}`}>
                <div className={`max-w-xs lg:max-w-md px-4 py-2.5 rounded-2xl text-sm ${m.mine ? "text-white rounded-br-sm" : "bg-white text-gray-800 rounded-bl-sm shadow-sm"}`}
                  style={m.mine ? { backgroundColor: "#176B45" } : {}}>
                  <p>{m.text}</p>
                  <p className={`text-xs mt-1 ${m.mine ? "text-white/60" : "text-gray-400"}`}>{m.time}</p>
                </div>
              </div>
            ))}
          </div>

          {/* Input */}
          <div className="bg-white border-t p-4 flex items-center gap-3 shrink-0" style={{ borderColor: "#E5EDE8" }}>
            <button className="text-gray-400 hover:text-gray-600">
              <svg className="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M21.44 11.05l-9.19 9.19a6 6 0 01-8.49-8.49l9.19-9.19a4 4 0 015.66 5.66l-9.2 9.19a2 2 0 01-2.83-2.83l8.49-8.48" /></svg>
            </button>
            <input
              value={input}
              onChange={(e) => setInput(e.target.value)}
              onKeyDown={(e) => e.key === "Enter" && send()}
              placeholder="Escribe un mensaje..."
              className="flex-1 px-4 py-2 text-sm rounded-xl border outline-none"
              style={{ borderColor: "#D1FAE5", backgroundColor: "#F7FAF8" }}
            />
            <button
              onClick={send}
              className="w-9 h-9 rounded-xl flex items-center justify-center text-white transition-colors hover:opacity-90"
              style={{ backgroundColor: "#176B45" }}
            >
              <svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><line x1="22" y1="2" x2="11" y2="13" /><polygon points="22 2 15 22 11 13 2 9 22 2" /></svg>
            </button>
          </div>
        </div>
      </div>
    </Layout>
  );
}
