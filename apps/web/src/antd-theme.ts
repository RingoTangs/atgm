import type { ThemeConfig } from 'antd'
import { theme } from 'antd'

export const themes = {
  light: {
    background: '#ffffff',
    foreground: '#171717',
    card: '#ffffff',
    primary: '#1677ff',
    muted: '#f5f5f5',
    mutedForeground: '#737373',
    border: '#d9d9d9',
    destructive: '#ff4d4f',
  },
  dark: {
    background: '#141414',
    foreground: '#f5f5f5',
    card: '#1f1f1f',
    primary: '#1677ff',
    muted: '#262626',
    mutedForeground: '#a3a3a3',
    border: '#424242',
    destructive: '#ff7875',
  },
} as const

export type ThemeMode = keyof typeof themes

export function createAntdTheme(mode: ThemeMode): ThemeConfig {
  const t = themes[mode]

  return {
    algorithm: mode === 'dark' ? theme.darkAlgorithm : theme.defaultAlgorithm,

    token: {
      colorPrimary: t.primary,
      colorError: t.destructive,
      colorBgBase: t.background,
      colorTextBase: t.foreground,
      borderRadius: 8,
    },
  }
}
