import type { ResolvedTheme, ThemeMode } from './theme'
import { createContext } from 'react'

export interface ThemeContextValue {
  theme: ThemeMode
  resolvedTheme: ResolvedTheme
  setTheme: (theme: ThemeMode) => void
}

export const ThemeContext = createContext<ThemeContextValue | undefined>(
  undefined,
)
