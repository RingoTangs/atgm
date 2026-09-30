import type { ThemeConfig } from 'antd'
import type { ResolvedTheme } from '@/theme/theme'
import { theme } from 'antd'

// function readThemeTokens(mode: ResolvedTheme) {
//   const probe = document.createElement('div')

//   probe.className = mode === 'dark' ? 'dark' : ''
//   probe.style.cssText =
//     'position:absolute;visibility:hidden;pointer-events:none'

//   document.body.appendChild(probe)

//   try {
//     const styles = getComputedStyle(probe)
//     const get = (name: string) => styles.getPropertyValue(name).trim()

//     return {
//       primary: get('--primary'),
//       background: get('--background'),
//       foreground: get('--foreground'),
//     }
//   } finally {
//     probe.remove()
//   }
// }

export function createAntdTheme(mode: ResolvedTheme): ThemeConfig {
  const isLight = mode === 'light'
  return {
    algorithm: isLight ? theme.defaultAlgorithm : theme.darkAlgorithm,
    token: {
      colorPrimary: '#1677ff',
      colorBgBase: isLight ? '#ffffff' : '#141414',
      colorTextBase: isLight ? '#171717' : '#f5f5f5',
    },
  }
}
