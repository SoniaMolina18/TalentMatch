import { createContext, useContext, useMemo, useState, type ReactNode } from 'react'
import type { AuthResponse, LoginRequest, PublicUser, RegisterStudentRequest } from '../../types/api'
import { api } from '../../services/apiClient'

interface AuthContextValue {
  user: PublicUser | null
  token: string | null
  login: (data: LoginRequest) => Promise<void>
  registerStudent: (data: RegisterStudentRequest) => Promise<void>
  logout: () => void
}

const AuthContext = createContext<AuthContextValue | undefined>(undefined)
const USER_KEY = 'talentmatch.user'
const TOKEN_KEY = 'talentmatch.token'

function readUser(): PublicUser | null {
  const value = sessionStorage.getItem(USER_KEY)
  if (!value) return null
  try { return JSON.parse(value) as PublicUser } catch { return null }
}

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<PublicUser | null>(readUser)
  const [token, setToken] = useState<string | null>(() => sessionStorage.getItem(TOKEN_KEY))

  const logout = () => {
	sessionStorage.removeItem(TOKEN_KEY)
	sessionStorage.removeItem(USER_KEY)
	setToken(null)
	setUser(null)
  }

  const saveSession = ({ token: nextToken, usuario }: AuthResponse) => {
	sessionStorage.setItem(TOKEN_KEY, nextToken)
	sessionStorage.setItem(USER_KEY, JSON.stringify(usuario))
	setToken(nextToken)
	setUser(usuario)
  }

  const value = useMemo<AuthContextValue>(() => ({
	user,
	token,
	login: async data => saveSession(await api.login(data)),
	registerStudent: async data => { await api.registerStudent(data) },
	logout,
  }), [token, user])

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>
}

export function useAuth() {
  const context = useContext(AuthContext)
  if (!context) throw new Error('useAuth debe utilizarse dentro de AuthProvider')
  return context
}
