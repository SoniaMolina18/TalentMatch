import { Page } from "../types";

interface SidebarProps {
  currentPage: Page;
  onNavigate: (page: Page) => void;
}

const navItems = [
  { id: "dashboard" as Page, label: "Inicio", icon: HomeIcon },
  { id: "explore" as Page, label: "Explorar proyectos", icon: SearchIcon },
  { id: "my-team" as Page, label: "Mis proyectos", icon: FolderIcon },
  { id: "find-talents" as Page, label: "Encontrar talentos", icon: UsersIcon },
  { id: "my-team" as Page, label: "Mi equipo", icon: TeamIcon },
  { id: "requests" as Page, label: "Solicitudes", icon: BellRingIcon },
  { id: "messages" as Page, label: "Mensajes", icon: MessageIcon },
  { id: "dashboard" as Page, label: "Notificaciones", icon: NotifIcon },
  { id: "student-profile" as Page, label: "Perfil", icon: UserIcon },
  { id: "dashboard" as Page, label: "Configuración", icon: SettingsIcon },
];

export default function Sidebar({ currentPage, onNavigate }: SidebarProps) {
  return (
    <aside
      className="fixed left-0 top-0 h-full w-64 flex flex-col z-40 shadow-xl"
      style={{ backgroundColor: "#0B3D2E" }}
    >
      {/* Logo */}
      <div className="px-6 py-6 border-b border-white/10">
        <div className="flex items-center gap-3">
          <div
            className="w-9 h-9 rounded-xl flex items-center justify-center text-white font-bold text-lg"
            style={{ backgroundColor: "#29A66A" }}
          >
            T
          </div>
          <div>
            <div className="text-white font-bold text-base leading-none">TalentMatch</div>
            <div className="text-xs mt-0.5" style={{ color: "#86EFAC" }}>
              Plataforma universitaria
            </div>
          </div>
        </div>
      </div>

      {/* Nav */}
      <nav className="flex-1 px-3 py-4 overflow-y-auto">
        <div className="space-y-0.5">
          {navItems.map((item, i) => {
            const Icon = item.icon;
            const isActive = currentPage === item.id && i < 2;
            const active = currentPage === item.id;
            return (
              <button
                key={i}
                onClick={() => onNavigate(item.id)}
                className={`w-full flex items-center gap-3 px-3 py-2.5 rounded-xl text-sm font-medium transition-all duration-150 text-left group
                  ${active
                    ? "text-white"
                    : "text-white/60 hover:text-white hover:bg-white/8"
                  }`}
                style={active ? { backgroundColor: "#176B45" } : {}}
              >
                <Icon
                  className={`w-4.5 h-4.5 shrink-0 transition-colors ${active ? "text-[#29A66A]" : "text-white/40 group-hover:text-white/70"}`}
                />
                <span>{item.label}</span>
                {item.label === "Solicitudes" && (
                  <span
                    className="ml-auto text-xs font-semibold px-1.5 py-0.5 rounded-full text-white"
                    style={{ backgroundColor: "#29A66A" }}
                  >
                    4
                  </span>
                )}
                {item.label === "Mensajes" && (
                  <span
                    className="ml-auto text-xs font-semibold px-1.5 py-0.5 rounded-full text-white"
                    style={{ backgroundColor: "#29A66A" }}
                  >
                    2
                  </span>
                )}
              </button>
            );
          })}
        </div>

        {/* Separator */}
        <div className="mt-4 pt-4 border-t border-white/10">
          <button
            onClick={() => onNavigate("teacher-panel")}
            className="w-full flex items-center gap-3 px-3 py-2.5 rounded-xl text-sm font-medium text-white/60 hover:text-white hover:bg-white/8 transition-all"
          >
            <AcademicIcon className="w-4.5 h-4.5 shrink-0 text-white/40" />
            <span>Panel Profesor</span>
          </button>
          <button
            onClick={() => onNavigate("admin-panel")}
            className="w-full flex items-center gap-3 px-3 py-2.5 rounded-xl text-sm font-medium text-white/60 hover:text-white hover:bg-white/8 transition-all"
          >
            <ShieldIcon className="w-4.5 h-4.5 shrink-0 text-white/40" />
            <span>Panel Admin</span>
          </button>
        </div>
      </nav>

      {/* User */}
      <div className="px-4 py-4 border-t border-white/10">
        <div className="flex items-center gap-3">
          <img
            src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=80&h=80&fit=crop&auto=format"
            alt="Yuliana"
            className="w-9 h-9 rounded-full object-cover ring-2 ring-white/20"
          />
          <div className="flex-1 min-w-0">
            <div className="text-white text-sm font-semibold truncate">Yuliana Pérez</div>
            <div className="text-xs truncate" style={{ color: "#86EFAC" }}>
              Ing. de Sistemas · 7mo sem.
            </div>
          </div>
          <button className="text-white/40 hover:text-white transition-colors">
            <LogoutIcon className="w-4 h-4" />
          </button>
        </div>
      </div>
    </aside>
  );
}

/* ---- Inline SVG Icons ---- */
function HomeIcon({ className }: { className?: string }) {
  return (
    <svg className={className} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2z" /><polyline points="9 22 9 12 15 12 15 22" />
    </svg>
  );
}
function SearchIcon({ className }: { className?: string }) {
  return (
    <svg className={className} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <circle cx="11" cy="11" r="8" /><line x1="21" y1="21" x2="16.65" y2="16.65" />
    </svg>
  );
}
function FolderIcon({ className }: { className?: string }) {
  return (
    <svg className={className} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M22 19a2 2 0 01-2 2H4a2 2 0 01-2-2V5a2 2 0 012-2h5l2 3h9a2 2 0 012 2z" />
    </svg>
  );
}
function UsersIcon({ className }: { className?: string }) {
  return (
    <svg className={className} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2" /><circle cx="9" cy="7" r="4" /><path d="M23 21v-2a4 4 0 00-3-3.87" /><path d="M16 3.13a4 4 0 010 7.75" />
    </svg>
  );
}
function TeamIcon({ className }: { className?: string }) {
  return (
    <svg className={className} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <rect x="2" y="7" width="20" height="14" rx="2" /><path d="M16 7V5a2 2 0 00-2-2h-4a2 2 0 00-2 2v2" /><line x1="12" y1="12" x2="12" y2="16" /><line x1="10" y1="14" x2="14" y2="14" />
    </svg>
  );
}
function BellRingIcon({ className }: { className?: string }) {
  return (
    <svg className={className} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M18 8A6 6 0 006 8c0 7-3 9-3 9h18s-3-2-3-9" /><path d="M13.73 21a2 2 0 01-3.46 0" />
    </svg>
  );
}
function MessageIcon({ className }: { className?: string }) {
  return (
    <svg className={className} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M21 15a2 2 0 01-2 2H7l-4 4V5a2 2 0 012-2h14a2 2 0 012 2z" />
    </svg>
  );
}
function NotifIcon({ className }: { className?: string }) {
  return (
    <svg className={className} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M18 8A6 6 0 006 8c0 7-3 9-3 9h18s-3-2-3-9" /><path d="M13.73 21a2 2 0 01-3.46 0" /><circle cx="18" cy="4" r="3" fill="#29A66A" stroke="none" />
    </svg>
  );
}
function UserIcon({ className }: { className?: string }) {
  return (
    <svg className={className} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2" /><circle cx="12" cy="7" r="4" />
    </svg>
  );
}
function SettingsIcon({ className }: { className?: string }) {
  return (
    <svg className={className} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <circle cx="12" cy="12" r="3" /><path d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 010 2.83 2 2 0 01-2.83 0l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 01-4 0v-.09A1.65 1.65 0 009 19.4a1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 01-2.83-2.83l.06-.06A1.65 1.65 0 004.68 15a1.65 1.65 0 00-1.51-1H3a2 2 0 010-4h.09A1.65 1.65 0 004.6 9a1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 012.83-2.83l.06.06A1.65 1.65 0 009 4.68a1.65 1.65 0 001-1.51V3a2 2 0 014 0v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 012.83 2.83l-.06.06A1.65 1.65 0 0019.4 9a1.65 1.65 0 001.51 1H21a2 2 0 010 4h-.09a1.65 1.65 0 00-1.51 1z" />
    </svg>
  );
}
function AcademicIcon({ className }: { className?: string }) {
  return (
    <svg className={className} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M22 10v6M2 10l10-5 10 5-10 5z" /><path d="M6 12v5c3 3 9 3 12 0v-5" />
    </svg>
  );
}
function ShieldIcon({ className }: { className?: string }) {
  return (
    <svg className={className} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" />
    </svg>
  );
}
function LogoutIcon({ className }: { className?: string }) {
  return (
    <svg className={className} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4" /><polyline points="16 17 21 12 16 7" /><line x1="21" y1="12" x2="9" y2="12" />
    </svg>
  );
}
