import {
  createMemoryHistory,
  createRootRoute,
  createRoute,
  createRouter,
  Outlet,
  RouterProvider,
} from '@tanstack/react-router'
import { cleanup, render, screen, within } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { ConfigProvider } from 'antd'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { GeneralError } from '@/features/errors/GeneralError'
import { NotFoundError } from '@/features/errors/NotFoundError'
import { ThemeProvider } from '@/theme'
import { AppLayout } from './AppLayout'

const DashboardPage: React.FC = () => (
  <div>
    <h1>Dashboard</h1>
    <p>欢迎使用 ATGM</p>
  </div>
)

const installMatchMedia = (width: number, dark = false) => {
  vi.stubGlobal(
    'matchMedia',
    vi.fn((query: string) => {
      const minWidth = query.match(/min-width:\s*(\d+)px/)
      const maxWidth = query.match(/max-width:\s*(\d+)px/)
      const matches = query.includes('prefers-color-scheme')
        ? dark
        : (!minWidth || width >= Number(minWidth[1])) &&
          (!maxWidth || width <= Number(maxWidth[1]))

      return {
        matches,
        media: query,
        onchange: null,
        addEventListener: vi.fn(),
        removeEventListener: vi.fn(),
        addListener: vi.fn(),
        removeListener: vi.fn(),
        dispatchEvent: vi.fn(() => true),
      } as unknown as MediaQueryList
    }),
  )
}

const BrokenPage = () => {
  throw new Error('Route failed')
}

const renderApplication = (initialEntry = '/') => {
  const rootRoute = createRootRoute({
    component: Outlet,
    errorComponent: GeneralError,
    notFoundComponent: NotFoundError,
  })
  const appRoute = createRoute({
    getParentRoute: () => rootRoute,
    id: '_app',
    component: () => (
      <AppLayout>
        <Outlet />
      </AppLayout>
    ),
  })
  const dashboardRoute = createRoute({
    getParentRoute: () => appRoute,
    path: '/',
    component: DashboardPage,
  })
  const brokenRoute = createRoute({
    getParentRoute: () => rootRoute,
    path: '/broken',
    component: BrokenPage,
  })
  const router = createRouter({
    history: createMemoryHistory({ initialEntries: [initialEntry] }),
    routeTree: rootRoute.addChildren([
      appRoute.addChildren([dashboardRoute]),
      brokenRoute,
    ]),
  })

  return render(
    <ThemeProvider>
      <ConfigProvider>
        <RouterProvider router={router} />
      </ConfigProvider>
    </ThemeProvider>,
  )
}

beforeEach(() => {
  localStorage.clear()
  document.documentElement.classList.remove('dark')
  document.documentElement.style.colorScheme = ''
  vi.stubGlobal(
    'ResizeObserver',
    class ResizeObserver {
      observe = vi.fn()
      unobserve = vi.fn()
      disconnect = vi.fn()
    },
  )
  vi.spyOn(window, 'scrollTo').mockImplementation(() => {})
})

afterEach(() => {
  cleanup()
  vi.restoreAllMocks()
  vi.unstubAllGlobals()
})

describe('app layout', () => {
  it('在桌面端渲染 Dashboard、品牌和当前菜单', async () => {
    installMatchMedia(1280)
    renderApplication()

    expect(
      await screen.findByRole('heading', { name: 'Dashboard' }),
    ).toBeInTheDocument()
    expect(screen.getByText('欢迎使用 ATGM')).toBeInTheDocument()
    expect(screen.getByLabelText('ATGM')).toBeInTheDocument()

    const dashboardItem = screen.getByRole('menuitem', {
      name: 'Dashboard',
    })
    expect(within(dashboardItem).getByText('Dashboard')).toHaveAttribute(
      'aria-current',
      'page',
    )
  })

  it('可以折叠和展开桌面侧边栏', async () => {
    const user = userEvent.setup()
    installMatchMedia(1280)
    renderApplication()

    await screen.findByRole('heading', { name: 'Dashboard' })
    expect(screen.getByText('AskTao GM')).toBeInTheDocument()

    await user.click(screen.getByRole('button', { name: '折叠侧边栏' }))
    expect(screen.queryByText('AskTao GM')).not.toBeInTheDocument()
    expect(
      screen.getByRole('button', { name: '展开侧边栏' }),
    ).toBeInTheDocument()

    await user.click(screen.getByRole('button', { name: '展开侧边栏' }))
    expect(screen.getByText('AskTao GM')).toBeInTheDocument()
  })

  it('可以选择浅色、深色和跟随系统主题', async () => {
    const user = userEvent.setup()
    installMatchMedia(1280)
    renderApplication()

    const openThemeMenu = async (currentTheme: string) => {
      await user.click(
        screen.getByRole('button', {
          name: `切换主题，当前：${currentTheme}`,
        }),
      )
    }

    await screen.findByRole('heading', { name: 'Dashboard' })
    await openThemeMenu('跟随系统')
    await user.click(await screen.findByRole('menuitem', { name: '深色' }))
    expect(document.documentElement).toHaveClass('dark')

    await openThemeMenu('深色')
    await user.click(await screen.findByRole('menuitem', { name: '浅色' }))
    expect(document.documentElement).not.toHaveClass('dark')

    await openThemeMenu('浅色')
    await user.click(await screen.findByRole('menuitem', { name: '跟随系统' }))
    expect(
      screen.getByRole('button', {
        name: '切换主题，当前：跟随系统',
      }),
    ).toBeInTheDocument()
  })

  it('在移动端通过 Drawer 导航并在点击菜单后关闭', async () => {
    const user = userEvent.setup()
    installMatchMedia(390)
    renderApplication()

    await screen.findByRole('heading', { name: 'Dashboard' })
    expect(
      screen.queryByRole('button', { name: '折叠侧边栏' }),
    ).not.toBeInTheDocument()

    await user.click(screen.getByRole('button', { name: '打开导航' }))
    const drawer = await screen.findByRole('dialog', { name: '导航' })
    expect(
      within(drawer).getByRole('menuitem', { name: 'Dashboard' }),
    ).toBeVisible()

    await user.click(within(drawer).getByRole('button', { name: '关闭导航' }))
    expect(
      screen.queryByRole('dialog', { name: '导航' }),
    ).not.toBeInTheDocument()

    await user.click(screen.getByRole('button', { name: '打开导航' }))
    const reopenedDrawer = await screen.findByRole('dialog', { name: '导航' })
    await user.click(
      within(reopenedDrawer).getByRole('menuitem', { name: 'Dashboard' }),
    )
    expect(
      screen.queryByRole('dialog', { name: '导航' }),
    ).not.toBeInTheDocument()
  })

  it('保持根路由的 404 行为且不包裹后台布局', async () => {
    installMatchMedia(1280)
    renderApplication('/missing')

    expect(
      await screen.findByRole('heading', { name: '404' }),
    ).toBeInTheDocument()
    expect(screen.queryByLabelText('ATGM')).not.toBeInTheDocument()
  })

  it('保持根路由的 Error Boundary 行为', async () => {
    installMatchMedia(1280)
    renderApplication('/broken')

    expect(
      await screen.findByRole('heading', { name: '500' }),
    ).toBeInTheDocument()
    expect(screen.getByText(/Something went wrong/)).toBeInTheDocument()
  })
})
