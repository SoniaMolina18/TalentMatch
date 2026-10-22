import { ReactNode } from "react";
import Sidebar from "./Sidebar";
import { Page } from "../types";

interface LayoutProps {
  children: ReactNode;
  currentPage: Page;
  onNavigate: (page: Page) => void;
  topBarExtra?: ReactNode;
}

export default function Layout({ children, currentPage, onNavigate, topBarExtra }: LayoutProps) {
  return (
    <div className="flex h-full" style={{ backgroundColor: "#F7FAF8", fontFamily: "'Inter', sans-serif" }}>
      <Sidebar currentPage={currentPage} onNavigate={onNavigate} />
      <div className="flex-1 flex flex-col min-h-full ml-64 overflow-auto">
        {children}
      </div>
    </div>
  );
}
