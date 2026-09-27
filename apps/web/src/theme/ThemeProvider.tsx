import { useEffect, useMemo, useState } from 'react'
import {
  applyTheme,
  getSystemTheme,
  isThemeMode,
  persistTheme,
  readStoredTheme,
  SYSTEM_THEME_QUERY,
  THEME_STORAGE_KEY,
} from './theme'
import { ThemeContext } from './ThemeContext'

export const ThemeProvider: React.FC<React.PropsWithChildren> = ({
  children,
}) => {
  const [theme, setTheme] = useState(readStoredTheme)
  const [systemTheme, setSystemTheme] = useState(getSystemTheme)
  const resolvedTheme = theme === 'system' ? systemTheme : theme

  useEffect(() => {
    const mediaQuery = matchMedia(SYSTEM_THEME_QUERY)
    const updateSystemTheme = (event: MediaQueryListEvent) => {
      setSystemTheme(event.matches ? 'dark' : 'light')
    }

    mediaQuery.addEventListener('change', updateSystemTheme)
    return () => mediaQuery.removeEventListener('change', updateSystemTheme)
  }, [])

  useEffect(() => {
    applyTheme(resolvedTheme)
    persistTheme(theme)
  }, [resolvedTheme, theme])

  useEffect(() => {
    const syncTheme = (event: StorageEvent) => {
      if (event.key !== THEME_STORAGE_KEY) return
      setTheme(isThemeMode(event.newValue) ? event.newValue : 'system')
    }

    window.addEventListener('storage', syncTheme)
    return () => window.removeEventListener('storage', syncTheme)
  }, [])

  const value = useMemo(
    () => ({ theme, resolvedTheme, setTheme }),
    [resolvedTheme, theme],
  )

  return <ThemeContext value={value}>{children}</ThemeContext>
}
