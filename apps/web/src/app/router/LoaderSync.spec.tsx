import {
  createMemoryHistory,
  createRootRoute,
  createRoute,
  createRouter,
  Outlet,
  RouterProvider,
} from '@tanstack/react-router'
import { act, cleanup, render, screen } from '@testing-library/react'
import { StrictMode } from 'react'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { useLoaderStore } from './loaderStore'
import { LoaderSync } from './LoaderSync'
import { RouterProgress } from './RouterProgress'
import { RouterSpinner } from './RouterSpinner'

const TestInnerWrap = ({ children }: React.PropsWithChildren) => (
  <>
    <LoaderSync />
    {children}
  </>
)

const advance = async (ms: number) => {
  await act(async () => {
    await vi.advanceTimersByTimeAsync(ms)
  })
}
const setup = () => {
  let resolve!: () => void
  let reject!: (error: Error) => void
  const promise = new Promise<void>((done, fail) => {
    resolve = done
    reject = fail
  })
  const root = createRootRoute({
    component: Outlet,
    errorComponent: () => <h1>Failed</h1>,
  })
  const home = createRoute({
    getParentRoute: () => root,
    path: '/',
    component: () => <h1>Home</h1>,
  })
  const loader = vi.fn(() => promise)
  const slow = createRoute({
    getParentRoute: () => root,
    path: '/slow',
    loader,
    component: () => <h1>Loaded</h1>,
  })
  const router = createRouter({
    routeTree: root.addChildren([home, slow]),
    history: createMemoryHistory({ initialEntries: ['/slow'] }),
    InnerWrap: TestInnerWrap,
    defaultStaleReloadMode: 'blocking',
  })
  const view = render(
    <StrictMode>
      <RouterProvider router={router} />
      <RouterSpinner />
      <RouterProgress />
    </StrictMode>,
  )
  return { router, loader, resolve, reject, ...view }
}
beforeEach(() => {
  vi.useFakeTimers()
  useLoaderStore.setState(useLoaderStore.getInitialState(), true)
  vi.spyOn(console, 'warn').mockImplementation(() => {})
  vi.spyOn(console, 'error').mockImplementation(() => {})
  vi.spyOn(window, 'scrollTo').mockImplementation(() => {})
})
afterEach(() => {
  cleanup()
  useLoaderStore.setState(useLoaderStore.getInitialState(), true)
  vi.clearAllTimers()
  vi.useRealTimers()
  vi.restoreAllMocks()
})
describe('路由加载同步', () => {
  it.each(['success', 'failure'] as const)(
    '首次慢加载 %s 后清除 boot',
    async (result) => {
      const { resolve, reject } = setup()
      await advance(150)
      expect(useLoaderStore.getState().mode).toBe('boot')
      expect(screen.getByRole('status')).toBeInTheDocument()
      expect(document.querySelector('.router-progress')).toBeNull()
      await act(async () => {
        if (result === 'success') resolve()
        else reject(new Error('Load failed'))
      })
      await advance(0)
      expect(useLoaderStore.getState().mode).toBe('idle')
      expect(
        screen.getByRole('heading', {
          name: result === 'success' ? 'Loaded' : 'Failed',
        }),
      ).toBeInTheDocument()
      await advance(300)
      expect(screen.queryByRole('status')).toBeNull()
    },
  )

  it('站内导航同步 navigation，卸载清除状态', async () => {
    const { router, loader, resolve, unmount } = setup()
    await act(async () => {
      resolve()
    })
    await advance(0)
    await act(async () => {
      await router.navigate({ to: '/' })
    })
    let finish!: () => void
    const task = new Promise<void>((done) => {
      finish = done
    })
    loader.mockReturnValue(task)
    await act(async () => {
      void router.navigate({ href: '/slow' })
    })
    await advance(150)
    expect(useLoaderStore.getState().mode).toBe('navigation')
    expect(document.querySelectorAll('.router-progress')).toHaveLength(1)
    expect(screen.queryByRole('status')).toBeNull()
    unmount()
    expect(useLoaderStore.getState().mode).toBe('idle')
    await act(async () => {
      finish()
    })
    await advance(0)
    expect(useLoaderStore.getState().mode).toBe('idle')
  })
})
