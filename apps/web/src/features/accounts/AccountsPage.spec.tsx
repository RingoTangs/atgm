import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import {
  createMemoryHistory,
  createRootRoute,
  createRoute,
  createRouter,
  Outlet,
  RouterProvider,
} from '@tanstack/react-router'
import {
  cleanup,
  render,
  screen,
  waitFor,
  within,
} from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { AccountsPage } from './AccountsPage'

const fetchMock = vi.fn<typeof fetch>()

const accountItem = {
  account: 'server-account',
  online: true,
  privilege: 100,
  goldCoin: 1_000_000,
  silverCoin: 50_000,
  lastLoginTime: '2026-10-01 19:12:00',
  lastLoginIp: '192.0.2.1',
  regDate: '2026-09-01 10:00:00',
}

const accountsResponse = (
  items = [accountItem],
  total = 21,
  page = 1,
  pageSize = 10,
) =>
  new Response(JSON.stringify({ page, pageSize, total, items }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  })

const mockDefaultApiResponses = () => {
  fetchMock.mockImplementation(async () => {
    return accountsResponse()
  })
}

let queryClient: QueryClient

beforeEach(() => {
  fetchMock.mockReset()
  queryClient = new QueryClient({
    defaultOptions: {
      queries: { retry: false },
      mutations: { retry: false },
    },
  })
  mockDefaultApiResponses()
  vi.stubGlobal('fetch', fetchMock)
  vi.stubGlobal(
    'ResizeObserver',
    class ResizeObserver {
      observe = vi.fn()
      unobserve = vi.fn()
      disconnect = vi.fn()
    },
  )
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
  const rootRoute = createRootRoute({ component: Outlet })
  const accountsRoute = createRoute({
    getParentRoute: () => rootRoute,
    path: '/accounts',
    component: AccountsPage,
  })
  const accountDetailRoute = createRoute({
    getParentRoute: () => rootRoute,
    path: '/accounts/$account',
    component: () => <h1>账号详情测试页</h1>,
  })
  const router = createRouter({
    history: createMemoryHistory({ initialEntries: ['/accounts'] }),
    routeTree: rootRoute.addChildren([accountsRoute, accountDetailRoute]),
  })

  return render(
    <QueryClientProvider client={queryClient}>
      <RouterProvider router={router} />
    </QueryClientProvider>,
  )
}

const getAccountRequestUrls = (): string[] =>
  fetchMock.mock.calls
    .map(([input]) => String(input))
    .filter((url) => url.startsWith('/_api/accounts?'))

const getLastAccountRequestedUrl = (): string => {
  const accountRequestUrls = getAccountRequestUrls()
  const url = accountRequestUrls[accountRequestUrls.length - 1]

  if (!url) throw new Error('accounts API was not called')
  return url
}

const getPrivilegeRequestUrls = (): string[] =>
  fetchMock.mock.calls
    .map(([input]) => String(input))
    .filter((url) => url === '/_api/privileges')

describe('accounts page', () => {
  it('renders the nine columns and server account data', async () => {
    renderPage()

    expect(
      await screen.findByRole('heading', { name: '账号管理' }),
    ).toBeInTheDocument()
    expect(screen.getByText('查询和创建游戏账号')).toBeInTheDocument()

    for (const column of [
      '账号',
      '状态',
      '权限',
      '金元宝',
      '银元宝',
      '最后登录',
      '最后登录 IP',
      '注册时间',
      '操作',
    ]) {
      expect(
        screen.getByRole('columnheader', { name: column }),
      ).toBeInTheDocument()
    }
    expect(screen.getAllByRole('columnheader')).toHaveLength(9)

    const row = (await screen.findByText('server-account')).closest('tr')
    if (!row) throw new Error('server account row not found')
    expect(
      within(row).queryByRole('link', { name: 'server-account' }),
    ).not.toBeInTheDocument()
    expect(
      within(row).getByRole('link', { name: '查看详情' }),
    ).toBeInTheDocument()
    expect(within(row).getByText('在线')).toBeInTheDocument()
    expect(within(row).getByText('100')).toBeInTheDocument()
    expect(within(row).getByText('未知权限')).toBeInTheDocument()
    expect(within(row).getByText('1,000,000')).toBeInTheDocument()
    expect(within(row).getByText('50,000')).toBeInTheDocument()
    expect(within(row).getByText('2026-10-01 19:12:00')).toBeInTheDocument()
    expect(within(row).getByText('192.0.2.1')).toBeInTheDocument()
    expect(within(row).getByText('2026-09-01 10:00:00')).toBeInTheDocument()
    expect(getAccountRequestUrls()).toContain(
      '/_api/accounts?page=1&pageSize=10',
    )
    expect(getPrivilegeRequestUrls()).toEqual([])
  })

  it('renders an offline badge for an offline account', async () => {
    fetchMock.mockImplementation(async () => {
      return accountsResponse([{ ...accountItem, online: false }])
    })
    renderPage()

    const row = (await screen.findByText('server-account')).closest('tr')
    if (!row) throw new Error('server account row not found')
    expect(within(row).getByText('离线')).toBeInTheDocument()
    expect(within(row).queryByText('在线')).not.toBeInTheDocument()
  })

  it('navigates to account details from the action column', async () => {
    const user = userEvent.setup()
    renderPage()

    const row = (await screen.findByText('server-account')).closest('tr')
    if (!row) throw new Error('server account row not found')
    await user.click(within(row).getByRole('link', { name: '查看详情' }))

    expect(
      await screen.findByRole('heading', { name: '账号详情测试页' }),
    ).toBeInTheDocument()
  })

  it('renders known privilege details and metadata in a tooltip', async () => {
    fetchMock.mockImplementation(async () => {
      return accountsResponse([{ ...accountItem, privilege: 120 }])
    })
    const user = userEvent.setup()
    renderPage()

    const row = (await screen.findByText('server-account')).closest('tr')
    if (!row) throw new Error('server account row not found')
    const privilege = await within(row).findByText('120 - GA')
    expect(privilege).toBeInTheDocument()

    await user.hover(privilege)
    expect(await screen.findByText('常量：ADMINISTRATOR')).toBeInTheDocument()
    expect(screen.getByText('类型：管理特权')).toBeInTheDocument()
    expect(screen.getByText('描述：管理员')).toBeInTheDocument()
  })

  it('renders placeholders for empty account times', async () => {
    fetchMock.mockImplementation(async () => {
      return accountsResponse([
        { ...accountItem, lastLoginTime: '', regDate: '' },
      ])
    })
    renderPage()

    const row = (await screen.findByText('server-account')).closest('tr')
    if (!row) throw new Error('server account row not found')
    expect(within(row).getAllByText('-')).toHaveLength(2)
  })

  it('uses the server total and requests the selected page', async () => {
    fetchMock.mockImplementation(async (input) => {
      const url = new URL(String(input), 'http://localhost')
      const page = Number(url.searchParams.get('page'))
      return accountsResponse(
        [{ ...accountItem, account: `page-${page}-account` }],
        21,
        page,
      )
    })
    const user = userEvent.setup()
    renderPage()

    await screen.findByText('page-1-account')
    await user.click(screen.getByTitle('2'))

    expect(await screen.findByText('page-2-account')).toBeInTheDocument()
    expect(getLastAccountRequestedUrl()).toBe(
      '/_api/accounts?page=2&pageSize=10',
    )
  })

  it('returns to page one when page size changes', async () => {
    const user = userEvent.setup()
    renderPage()
    await screen.findByText('server-account')

    await user.click(screen.getByRole('combobox'))
    await user.click(await screen.findByTitle('50 / page'))

    await waitFor(() => {
      expect(getLastAccountRequestedUrl()).toBe(
        '/_api/accounts?page=1&pageSize=50',
      )
    })
  })

  it('only sends account search after submit and clears the active filter', async () => {
    const user = userEvent.setup()
    renderPage()
    await screen.findByText('server-account')
    const search = screen.getByPlaceholderText('搜索账号')

    await user.type(search, '  test_01  ')
    expect(getAccountRequestUrls()).toHaveLength(1)

    await user.keyboard('{Enter}')
    await waitFor(() => {
      expect(getLastAccountRequestedUrl()).toBe(
        '/_api/accounts?page=1&pageSize=10&account=test_01',
      )
    })

    await user.clear(search)
    await waitFor(() => {
      expect(getLastAccountRequestedUrl()).toBe(
        '/_api/accounts?page=1&pageSize=10',
      )
    })
  })

  it('shows table loading while the first request is pending', async () => {
    let resolveRequest: (response: Response) => void = () => undefined
    fetchMock.mockImplementation(() => {
      return new Promise((resolve) => {
        resolveRequest = resolve
      })
    })
    renderPage()

    await waitFor(() => {
      expect(document.querySelector('[aria-busy="true"]')).toBeInTheDocument()
    })

    resolveRequest(accountsResponse())
    expect(await screen.findByText('server-account')).toBeInTheDocument()
  })

  it('shows a load error and retries the request', async () => {
    let accountsRequestCount = 0
    fetchMock.mockImplementation(async () => {
      accountsRequestCount += 1
      return accountsRequestCount === 1
        ? new Response(null, { status: 500 })
        : accountsResponse()
    })
    const user = userEvent.setup()
    renderPage()

    expect(await screen.findByText('账号列表加载失败')).toBeInTheDocument()
    await user.click(screen.getByRole('button', { name: '重试' }))

    expect(await screen.findByText('server-account')).toBeInTheDocument()
    expect(getAccountRequestUrls()).toHaveLength(2)
  })

  it('opens the registration modal using shared privileges without a request', async () => {
    const user = userEvent.setup()
    renderPage()

    await user.click(await screen.findByRole('button', { name: '注册账号' }))

    const dialog = await screen.findByRole('dialog')
    expect(within(dialog).getByText('注册账号')).toBeInTheDocument()
    expect(within(dialog).getByLabelText('账号')).toBeInTheDocument()
    await waitFor(() => {
      expect(getPrivilegeRequestUrls()).toEqual([])
    })
  })
})
