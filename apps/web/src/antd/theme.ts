import type { ThemeConfig } from 'antd'
import type { ResolvedTheme } from '@/theme/theme'
import { theme } from 'antd'

function readThemeTokens(mode: ResolvedTheme) {
  const probe = document.createElement('div')

  probe.className = mode === 'dark' ? 'dark' : ''
  probe.style.cssText =
    'position:absolute;visibility:hidden;pointer-events:none'

  document.body.appendChild(probe)

  try {
    const styles = getComputedStyle(probe)
    const get = (name: string) => styles.getPropertyValue(name).trim()

    return {
      primary: get('--primary'),
      background: get('--background'),
      foreground: get('--foreground'),
    }
  } finally {
    probe.remove()
  }
}

export function createAntdTheme(mode: ResolvedTheme): ThemeConfig {
  const tokens = readThemeTokens(mode)

  return {
    algorithm: mode === 'dark' ? theme.darkAlgorithm : theme.defaultAlgorithm,

    token: {
      colorPrimary: tokens.primary,
      colorBgBase: tokens.background,
      colorTextBase: tokens.foreground,
    },
  }
}
