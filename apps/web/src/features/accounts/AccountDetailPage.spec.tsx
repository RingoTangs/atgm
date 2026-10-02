import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
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
import { AccountDetailPage } from './AccountDetailPage'

const fetchMock = vi.fn<typeof fetch>()

const accountDetail = {
  account: 'server-account',
  online: true,
  privilege: 120,
  goldCoin: 1_000_000,
  silverCoin: 50_000,
  blockedTime: '',
  blockedReason: '',
  tempBlockedTime: '',
  tempBlockedReason: '',
  firstLoginTime: '2026-09-01 11:00:00',
  firstLoginMac: '',
  lastLoginTime: '2026-10-01 19:12:00',
  lastLoginIp: '192.0.2.1',
  lastLoginId: '',
  regDate: '2026-09-01 10:00:00',
}

const privilege = {
  privilege: 120,
  grant: 'GA',
  constant: 'ADMINISTRATOR',
  type: '管理特权',
  description: '管理员',
}

const jsonResponse = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { 'Content-Type': 'application/json' },
  })

let queryClient: QueryClient

beforeEach(() => {
  fetchMock.mockReset()
  fetchMock.mockImplementation(async (input) =>
    String(input) === '/_api/privileges'
      ? jsonResponse([privilege])
      : jsonResponse(accountDetail),
  )
  queryClient = new QueryClient({
    defaultOptions: {
      queries: { retry: false },
    },
  })
  vi.stubGlobal('fetch', fetchMock)
  vi.stubGlobal(
    'matchMedia',
    vi.fn((query: string) => ({
      matches: false,
      media: query,
      onchange: null,
      addEventListener: vi.fn(),
      removeEventListener: vi.fn(),
      addListener: vi.fn(),
      removeListener: vi.fn(),
      dispatchEvent: vi.fn(() => true),
    })),
  )
})

afterEach(() => {
  cleanup()
  queryClient.clear()
  vi.restoreAllMocks()
  vi.unstubAllGlobals()
})

const renderPage = () => {
  const rootRoute = createRootRoute()
  const accountsRoute = createRoute({
    getParentRoute: () => rootRoute,
    path: '/accounts',
    component: () => <h1>账号管理页面</h1>,
  })
  const detailRoute = createRoute({
    getParentRoute: () => rootRoute,
    path: '/accounts/$account',
    component: () => <AccountDetailPage account="server-account" />,
  })
  const router = createRouter({
    history: createMemoryHistory({
      initialEntries: ['/accounts/server-account'],
    }),
    routeTree: rootRoute.addChildren([accountsRoute, detailRoute]),
  })

  return render(
    <QueryClientProvider client={queryClient}>
      <RouterProvider router={router} />
    </QueryClientProvider>,
  )
}

describe('account detail page', () => {
  it('loads and renders the read-only account details', async () => {
    renderPage()

    expect(
      await screen.findByRole('heading', { name: '账号详情' }),
    ).toBeInTheDocument()
    expect(fetchMock).toHaveBeenCalledWith('/_api/accounts/server-account')
    expect(fetchMock).toHaveBeenCalledWith('/_api/privileges')
    expect(await screen.findByText('server-account')).toBeInTheDocument()
    expect(screen.getByText('在线')).toBeInTheDocument()
    expect(screen.getByText('1,000,000')).toBeInTheDocument()
    expect(screen.getByText('50,000')).toBeInTheDocument()
    expect(screen.getByText('2026-09-01 11:00:00')).toBeInTheDocument()
    expect(screen.getByText('2026-10-01 19:12:00')).toBeInTheDocument()
    expect(
      screen.getByText('120 - GA - ADMINISTRATOR(管理员)'),
    ).toBeInTheDocument()
    expect(screen.getAllByText('-').length).toBeGreaterThan(0)
  })

  it('renders the offline account status', async () => {
    fetchMock.mockImplementation(async (input) =>
      String(input) === '/_api/privileges'
        ? jsonResponse([privilege])
        : jsonResponse({ ...accountDetail, online: false }),
    )
    renderPage()

    expect(await screen.findByText('离线')).toBeInTheDocument()
  })

  it('opens the core account edit modal', async () => {
    const user = userEvent.setup()
    renderPage()

    await user.click(await screen.findByRole('button', { name: '编辑' }))

    expect(
      await screen.findByRole('dialog', {
        name: '编辑账号：server-account',
      }),
    ).toBeInTheDocument()
    expect(screen.getByLabelText('金币')).toHaveValue('1000000')
    expect(screen.getByLabelText('银币')).toHaveValue('50000')
    expect(screen.queryByLabelText('账号')).toBeNull()
  })

  it('falls back safely for an unknown privilege', async () => {
    fetchMock.mockImplementation(async (input) =>
      String(input) === '/_api/privileges'
        ? jsonResponse([privilege])
        : jsonResponse({ ...accountDetail, privilege: 999 }),
    )
    renderPage()

    expect(await screen.findByText('999')).toBeInTheDocument()
    expect(screen.getByText('未知权限')).toBeInTheDocument()
  })

  it('keeps rendering details when the privilege dictionary fails', async () => {
    fetchMock.mockImplementation(async (input) =>
      String(input) === '/_api/privileges'
        ? new Response(null, { status: 500 })
        : jsonResponse(accountDetail),
    )
    renderPage()

    expect(await screen.findByText('server-account')).toBeInTheDocument()
    expect(screen.getByText('120')).toBeInTheDocument()
    expect(screen.getByText('未知权限')).toBeInTheDocument()
  })

  it('shows the not-found state with a link back to accounts', async () => {
    fetchMock.mockImplementation(async (input) =>
      String(input) === '/_api/privileges'
        ? jsonResponse([privilege])
        : jsonResponse({ message: '账号不存在' }, 404),
    )
    renderPage()

    expect(await screen.findByText('账号不存在')).toBeInTheDocument()
    expect(screen.getByRole('link', { name: '返回账号列表' })).toHaveAttribute(
      'href',
      '/accounts',
    )
  })

  it('shows a generic error and retries the account request', async () => {
    let accountRequests = 0
    fetchMock.mockImplementation(async (input) => {
      if (String(input) === '/_api/privileges') return jsonResponse([privilege])

      accountRequests += 1
      return accountRequests === 1
        ? new Response(null, { status: 500 })
        : jsonResponse(accountDetail)
    })
    const user = userEvent.setup()
    renderPage()

    expect(await screen.findByText('账号详情加载失败')).toBeInTheDocument()
    await user.click(screen.getByRole('button', { name: '重试' }))

    await waitFor(() => {
      expect(screen.getByText('server-account')).toBeInTheDocument()
    })
    expect(accountRequests).toBe(2)
  })
})
