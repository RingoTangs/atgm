import {
  createMemoryHistory,
  createRootRoute,
  createRoute,
  createRouter,
  RouterProvider,
} from '@tanstack/react-router'
import { cleanup, render, screen, waitFor } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { installMatchMedia } from '@/features/lpc/lpcTestUtils'
import { Route } from './lpc'

beforeEach(() => {
  installMatchMedia()
  vi.stubGlobal(
    'ResizeObserver',
    class ResizeObserver {
      observe = vi.fn()
      unobserve = vi.fn()
      disconnect = vi.fn()
    },
  )
})

afterEach(() => {
  cleanup()
  vi.restoreAllMocks()
  vi.unstubAllGlobals()
})

async function renderRoute(url: string) {
  const root = createRootRoute()
  const app = createRoute({ getParentRoute: () => root, id: '_app' })
  const lpc = createRoute({
    getParentRoute: () => app,
    path: '/lpc',
    validateSearch: Route.options.validateSearch,
    component: Route.options.component,
  })
  const history = createMemoryHistory({ initialEntries: ['/previous', url] })
  const router = createRouter({
    history,
    routeTree: root.addChildren([app.addChildren([lpc])]),
  })
  const view = render(<RouterProvider router={router} />)
  await screen.findByRole('radio', { name: '格式化' })
  return { ...view, router, history }
}

describe('lpc mode URL', () => {
  it.each([
    { url: '/lpc', mode: '格式化' },
    { url: '/lpc?mode=format', mode: '格式化' },
    { url: '/lpc?mode=analysis', mode: '深度解析' },
    { url: '/lpc?mode=invalid', mode: '格式化' },
    { url: '/lpc?mode=', mode: '格式化' },
    { url: '/lpc?mode=123', mode: '格式化' },
  ])('restores $mode from $url', async ({ url, mode }) => {
    await renderRoute(url)
    expect(screen.getByRole('radio', { name: mode })).toBeChecked()
  })

  it('replaces the URL, preserves other parameters, and restores the selection after reload', async () => {
    const user = userEvent.setup()
    const { router, history, unmount } = await renderRoute('/lpc?source=test')
    const initialIndex = history.location.state.__TSR_index
    await user.click(screen.getByText('深度解析'))
    await waitFor(() => {
      expect(router.state.location.search).toMatchObject({
        mode: 'analysis',
        source: 'test',
      })
      expect(screen.getByRole('radio', { name: '深度解析' })).toBeChecked()
    })
    expect(history.location.state.__TSR_index).toBe(initialIndex)
    const url = history.location.href
    expect(new URL(url, 'http://localhost').searchParams.get('mode')).toBe(
      'analysis',
    )
    unmount()
    await renderRoute(url)
    expect(screen.getByRole('radio', { name: '深度解析' })).toBeChecked()
  })

  it('writes format to the URL when switching back without clearing input', async () => {
    const user = userEvent.setup()
    const { router } = await renderRoute('/lpc?mode=analysis')
    await user.type(screen.getByLabelText('原始 LPC'), '123')
    await user.click(screen.getByText('格式化'))
    await waitFor(() =>
      expect(router.state.location.search).toMatchObject({ mode: 'format' }),
    )
    expect(screen.getByRole('radio', { name: '格式化' })).toBeChecked()
    expect(screen.getByLabelText('原始 LPC')).toHaveValue('123')
  })
})
