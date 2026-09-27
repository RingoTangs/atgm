import { act, cleanup, fireEvent, render, screen } from '@testing-library/react'
import { StrictMode } from 'react'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { ThemeProvider, useTheme } from '@/theme'
import { THEME_STORAGE_KEY } from './theme'

const SYSTEM_THEME_QUERY = '(prefers-color-scheme: dark)'

const installMatchMedia = (initialMatches = false) => {
  let matches = initialMatches
  const listeners = new Set<(event: MediaQueryListEvent) => void>()
  const addEventListener = vi.fn(
    (_type: string, listener: (event: MediaQueryListEvent) => void) => {
      listeners.add(listener)
    },
  )
  const removeEventListener = vi.fn(
    (_type: string, listener: (event: MediaQueryListEvent) => void) => {
      listeners.delete(listener)
    },
  )
  const mediaQueryList = {
    get matches() {
      return matches
    },
    media: SYSTEM_THEME_QUERY,
    onchange: null,
    addEventListener,
    removeEventListener,
    addListener: vi.fn(),
    removeListener: vi.fn(),
    dispatchEvent: vi.fn(() => true),
  } as unknown as MediaQueryList

  vi.stubGlobal(
    'matchMedia',
    vi.fn(() => mediaQueryList),
  )

  return {
    listeners,
    setMatches(nextMatches: boolean) {
      matches = nextMatches
      const event = {
        matches,
        media: SYSTEM_THEME_QUERY,
      } as MediaQueryListEvent
      listeners.forEach((listener) => listener(event))
    },
  }
}

const ThemeConsumer: React.FC = () => {
  const { theme, resolvedTheme, setTheme } = useTheme()

  return (
    <>
      <output data-testid="theme">{theme}</output>
      <output data-testid="resolved-theme">{resolvedTheme}</output>
      <button type="button" onClick={() => setTheme('light')}>
        Light
      </button>
      <button type="button" onClick={() => setTheme('dark')}>
        Dark
      </button>
      <button type="button" onClick={() => setTheme('system')}>
        System
      </button>
    </>
  )
}

const renderTheme = () => {
  return render(
    <ThemeProvider>
      <ThemeConsumer />
    </ThemeProvider>,
  )
}

beforeEach(() => {
  localStorage.clear()
  document.documentElement.classList.remove('dark')
  document.documentElement.style.colorScheme = ''
})

afterEach(() => {
  cleanup()
  vi.unstubAllGlobals()
})

describe('theme provider', () => {
  it('默认跟随浅色系统主题', () => {
    installMatchMedia()
    renderTheme()

    expect(screen.getByTestId('theme')).toHaveTextContent('system')
    expect(screen.getByTestId('resolved-theme')).toHaveTextContent('light')
    expect(document.documentElement).not.toHaveClass('dark')
    expect(document.documentElement.style.colorScheme).toBe('light')
    expect(localStorage.getItem(THEME_STORAGE_KEY)).toBe('system')
  })

  it('恢复已保存的深色主题', () => {
    localStorage.setItem(THEME_STORAGE_KEY, 'dark')
    installMatchMedia()
    renderTheme()

    expect(screen.getByTestId('theme')).toHaveTextContent('dark')
    expect(screen.getByTestId('resolved-theme')).toHaveTextContent('dark')
    expect(document.documentElement).toHaveClass('dark')
  })

  it('无效存储值回退为 system', () => {
    localStorage.setItem(THEME_STORAGE_KEY, 'unknown')
    installMatchMedia(true)
    renderTheme()

    expect(screen.getByTestId('theme')).toHaveTextContent('system')
    expect(screen.getByTestId('resolved-theme')).toHaveTextContent('dark')
    expect(localStorage.getItem(THEME_STORAGE_KEY)).toBe('system')
  })

  it('切换主题时同步 DOM 和存储', () => {
    installMatchMedia()
    renderTheme()

    fireEvent.click(screen.getByRole('button', { name: 'Dark' }))
    expect(screen.getByTestId('theme')).toHaveTextContent('dark')
    expect(document.documentElement).toHaveClass('dark')
    expect(document.documentElement.style.colorScheme).toBe('dark')
    expect(localStorage.getItem(THEME_STORAGE_KEY)).toBe('dark')

    fireEvent.click(screen.getByRole('button', { name: 'Light' }))
    expect(document.documentElement).not.toHaveClass('dark')
    expect(localStorage.getItem(THEME_STORAGE_KEY)).toBe('light')
  })

  it('system 模式响应系统变化，显式主题保持不变', () => {
    const media = installMatchMedia()
    renderTheme()

    act(() => media.setMatches(true))
    expect(screen.getByTestId('resolved-theme')).toHaveTextContent('dark')
    expect(document.documentElement).toHaveClass('dark')

    fireEvent.click(screen.getByRole('button', { name: 'Light' }))
    act(() => media.setMatches(false))
    act(() => media.setMatches(true))
    expect(screen.getByTestId('resolved-theme')).toHaveTextContent('light')
    expect(document.documentElement).not.toHaveClass('dark')
  })

  it('响应其他标签页的主题变化', () => {
    installMatchMedia()
    renderTheme()

    act(() => {
      window.dispatchEvent(
        new StorageEvent('storage', {
          key: THEME_STORAGE_KEY,
          newValue: 'dark',
        }),
      )
    })

    expect(screen.getByTestId('theme')).toHaveTextContent('dark')
    expect(document.documentElement).toHaveClass('dark')
  })

  it('strict mode 卸载后清理系统主题监听', () => {
    const media = installMatchMedia()
    const { unmount } = render(
      <StrictMode>
        <ThemeProvider>
          <ThemeConsumer />
        </ThemeProvider>
      </StrictMode>,
    )

    expect(media.listeners.size).toBe(1)
    unmount()
    expect(media.listeners.size).toBe(0)
  })

  it('在 Provider 外使用时抛出错误', () => {
    const consoleError = vi.spyOn(console, 'error').mockImplementation(() => {})

    expect(() => render(<ThemeConsumer />)).toThrow(
      'useTheme must be used within a ThemeProvider',
    )

    consoleError.mockRestore()
  })
})
