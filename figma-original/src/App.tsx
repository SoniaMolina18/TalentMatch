import { useState } from "react";
import { Page } from "./types";
import Login from "./pages/Login";
import Register from "./pages/Register";
import Dashboard from "./pages/Dashboard";
import ExploreProjects from "./pages/ExploreProjects";
import ProjectDetail from "./pages/ProjectDetail";
import StudentProfile from "./pages/StudentProfile";
import FindTalents from "./pages/FindTalents";
import MyTeam from "./pages/MyTeam";
import Requests from "./pages/Requests";
import Messages from "./pages/Messages";
import TeacherPanel from "./pages/TeacherPanel";
import CreateProject from "./pages/CreateProject";
import AdminPanel from "./pages/AdminPanel";

export default function App() {
  const [page, setPage] = useState<Page>("dashboard");

  const navigate = (p: Page) => setPage(p);

  switch (page) {
    case "login":
      return <Login onNavigate={navigate} />;
    case "register":
      return <Register onNavigate={navigate} />;
    case "dashboard":
      return <Dashboard onNavigate={navigate} />;
    case "explore":
      return <ExploreProjects onNavigate={navigate} />;
    case "project-detail":
      return <ProjectDetail onNavigate={navigate} />;
    case "student-profile":
      return <StudentProfile onNavigate={navigate} />;
    case "find-talents":
      return <FindTalents onNavigate={navigate} />;
    case "my-team":
      return <MyTeam onNavigate={navigate} />;
    case "requests":
      return <Requests onNavigate={navigate} />;
    case "messages":
      return <Messages onNavigate={navigate} />;
    case "teacher-panel":
      return <TeacherPanel onNavigate={navigate} />;
    case "create-project":
      return <CreateProject onNavigate={navigate} />;
    case "admin-panel":
      return <AdminPanel onNavigate={navigate} />;
    default:
      return <Dashboard onNavigate={navigate} />;
  }
}
