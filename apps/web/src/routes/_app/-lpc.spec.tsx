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
import {
  decodeLpcUrlContent,
  encodeLpcUrlContent,
} from '@/features/lpc/lpcUrlContent'
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
  await router.load()
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

describe('lpc content URL', () => {
  it.each(['format', 'analysis'])(
    'saves input and restores it without executing in %s mode',
    async (mode) => {
      const user = userEvent.setup()
      const { router, history, unmount } = await renderRoute(
        `/lpc?mode=${mode}&source=test`,
      )
      const initialIndex = history.location.state.__TSR_index
      const source = '(["name":"女金😀",])'
      await user.click(screen.getByLabelText('原始 LPC'))
      await user.paste(source)
      expect(router.state.location.search).not.toHaveProperty(
        'content',
        expect.any(String),
      )
      await user.click(screen.getByRole('button', { name: '执行' }))
      await waitFor(() =>
        expect(router.state.location.search).toMatchObject({
          content: encodeLpcUrlContent(source),
          mode,
          source: 'test',
        }),
      )
      expect(decodeLpcUrlContent(router.state.location.search.content!)).toBe(
        source,
      )
      expect(history.location.state.__TSR_index).toBe(initialIndex)
      const url = history.location.href
      unmount()
      await renderRoute(url)
      expect(screen.getByLabelText('原始 LPC')).toHaveValue(source)
      expect(
        screen.getByRole('radio', {
          name: mode === 'analysis' ? '深度解析' : '格式化',
        }),
      ).toBeChecked()
      expect(screen.queryByRole('textbox', { name: '格式化结果' })).toBeNull()
      expect(screen.queryByRole('tree')).toBeNull()
      expect(
        screen.getByText(
          mode === 'analysis'
            ? '输入 LPC 内容后，点击「执行」查看解析树'
            : '输入 LPC 内容后，点击「执行」查看格式化结果',
        ),
      ).toBeInTheDocument()
    },
  )

  it('saves invalid LPC input even when execution fails', async () => {
    const user = userEvent.setup()
    const { router, history, unmount } = await renderRoute('/lpc')
    await user.type(screen.getByLabelText('原始 LPC'), 'invalid')
    await user.click(screen.getByRole('button', { name: '执行' }))
    await screen.findByText('格式化失败')
    await waitFor(() =>
      expect(router.state.location.search).toMatchObject({
        content: encodeLpcUrlContent('invalid'),
      }),
    )
    const url = history.location.href
    unmount()
    await renderRoute(url)
    expect(screen.getByLabelText('原始 LPC')).toHaveValue('invalid')
    expect(screen.queryByText('格式化失败')).toBeNull()
  })

  it('keeps the saved content on mode changes and removes it on clear', async () => {
    const user = userEvent.setup()
    const saved = encodeLpcUrlContent('123')
    const { router, history, unmount } = await renderRoute(
      `/lpc?content=${saved}&source=test`,
    )
    const initialIndex = history.location.state.__TSR_index
    await user.type(screen.getByLabelText('原始 LPC'), '4')
    await user.click(screen.getByText('深度解析'))
    await waitFor(() =>
      expect(router.state.location.search).toMatchObject({
        mode: 'analysis',
        content: saved,
        source: 'test',
      }),
    )
    expect(screen.getByLabelText('原始 LPC')).toHaveValue('1234')
    await user.click(screen.getByRole('button', { name: '执行' }))
    await waitFor(() =>
      expect(router.state.location.search).toMatchObject({
        content: encodeLpcUrlContent('1234'),
      }),
    )
    await user.click(screen.getByRole('button', { name: '清空' }))
    await waitFor(() =>
      expect(
        new URL(history.location.href, 'http://localhost').searchParams.has(
          'content',
        ),
      ).toBe(false),
    )
    expect(router.state.location.search).toMatchObject({
      mode: 'analysis',
      source: 'test',
    })
    expect(history.location.state.__TSR_index).toBe(initialIndex)
    expect(screen.getByLabelText('原始 LPC')).toHaveValue('')
    expect(screen.queryByRole('tree')).toBeNull()
    const url = history.location.href
    unmount()
    await renderRoute(url)
    expect(screen.getByLabelText('原始 LPC')).toHaveValue('')
  })

  it('reports malformed URL content and allows it to be replaced', async () => {
    const user = userEvent.setup()
    const { router } = await renderRoute('/lpc?content=invalid!&mode=analysis')
    expect(await screen.findByText('URL 中的 LPC 内容无效')).toBeInTheDocument()
    expect(screen.getByLabelText('原始 LPC')).toHaveValue('')
    await user.type(screen.getByLabelText('原始 LPC'), '123')
    await user.click(screen.getByRole('button', { name: '执行' }))
    await waitFor(() =>
      expect(router.state.location.search).toMatchObject({
        content: encodeLpcUrlContent('123'),
      }),
    )
    expect(screen.queryByText('URL 中的 LPC 内容无效')).toBeNull()
    expect(screen.getByLabelText('原始 LPC')).toHaveValue('123')
  })

  it('saves empty input when executing', async () => {
    const user = userEvent.setup()
    const { router } = await renderRoute('/lpc')
    await user.click(screen.getByRole('button', { name: '执行' }))
    await waitFor(() =>
      expect(router.state.location.search).toMatchObject({ content: '' }),
    )
  })
})
