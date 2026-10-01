import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
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
  privilege: 100,
  goldCoin: 1_000_000,
  silverCoin: 50_000,
  lastLoginTime: '20261001191200',
  lastLoginIp: '192.0.2.1',
  regDate: '20260901100000',
}

const accountsResponse = (
  items = [accountItem],
  total = 21,
  page = 1,
  pageSize = 20,
) =>
  new Response(JSON.stringify({ page, pageSize, total, items }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  })

let queryClient: QueryClient

beforeEach(() => {
  fetchMock.mockReset()
  queryClient = new QueryClient({
    defaultOptions: {
      queries: { retry: false },
      mutations: { retry: false },
    },
  })
  fetchMock.mockResolvedValue(accountsResponse())
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

const renderPage = () =>
  render(
    <QueryClientProvider client={queryClient}>
      <AccountsPage />
    </QueryClientProvider>,
  )

const getLastRequestedUrl = (): string => {
  const call = fetchMock.mock.calls[fetchMock.mock.calls.length - 1]
  if (!call) throw new Error('fetch was not called')
  return String(call[0])
}

describe('accounts page', () => {
  it('renders the seven columns and server account data', async () => {
    renderPage()

    expect(
      screen.getByRole('heading', { name: '账号管理' }),
    ).toBeInTheDocument()
    expect(screen.getByText('查询和创建游戏账号')).toBeInTheDocument()

    for (const column of [
      '账号',
      '权限',
      '金币',
      '银币',
      '最后登录',
      '最后登录 IP',
      '注册时间',
    ]) {
      expect(
        screen.getByRole('columnheader', { name: column }),
      ).toBeInTheDocument()
    }

    const row = (await screen.findByText('server-account')).closest('tr')
    if (!row) throw new Error('server account row not found')
    expect(within(row).getByText('100')).toBeInTheDocument()
    expect(within(row).getByText('1,000,000')).toBeInTheDocument()
    expect(within(row).getByText('50,000')).toBeInTheDocument()
    expect(within(row).getByText('2026-10-01 19:12:00')).toBeInTheDocument()
    expect(within(row).getByText('192.0.2.1')).toBeInTheDocument()
    expect(within(row).getByText('2026-09-01 10:00:00')).toBeInTheDocument()
    expect(getLastRequestedUrl()).toBe('/_api/accounts?page=1&pageSize=20')
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
    expect(getLastRequestedUrl()).toBe('/_api/accounts?page=2&pageSize=20')
  })

  it('returns to page one when page size changes', async () => {
    const user = userEvent.setup()
    renderPage()
    await screen.findByText('server-account')

    await user.click(screen.getByRole('combobox'))
    await user.click(await screen.findByTitle('50 / page'))

    await waitFor(() => {
      expect(getLastRequestedUrl()).toBe('/_api/accounts?page=1&pageSize=50')
    })
  })

  it('only sends account search after submit and clears the active filter', async () => {
    const user = userEvent.setup()
    renderPage()
    await screen.findByText('server-account')
    const search = screen.getByPlaceholderText('搜索账号')

    await user.type(search, '  test_01  ')
    expect(fetchMock).toHaveBeenCalledTimes(1)

    await user.keyboard('{Enter}')
    await waitFor(() => {
      expect(getLastRequestedUrl()).toBe(
        '/_api/accounts?page=1&pageSize=20&account=test_01',
      )
    })

    await user.clear(search)
    await waitFor(() => {
      expect(getLastRequestedUrl()).toBe('/_api/accounts?page=1&pageSize=20')
    })
  })

  it('shows table loading while the first request is pending', async () => {
    let resolveRequest: (response: Response) => void = () => undefined
    fetchMock.mockReturnValue(
      new Promise((resolve) => {
        resolveRequest = resolve
      }),
    )
    renderPage()

    expect(document.querySelector('[aria-busy="true"]')).toBeInTheDocument()

    resolveRequest(accountsResponse())
    expect(await screen.findByText('server-account')).toBeInTheDocument()
  })

  it('shows a load error and retries the request', async () => {
    fetchMock
      .mockResolvedValueOnce(new Response(null, { status: 500 }))
      .mockResolvedValueOnce(accountsResponse())
    const user = userEvent.setup()
    renderPage()

    expect(await screen.findByText('账号列表加载失败')).toBeInTheDocument()
    await user.click(screen.getByRole('button', { name: '重试' }))

    expect(await screen.findByText('server-account')).toBeInTheDocument()
    expect(fetchMock).toHaveBeenCalledTimes(2)
  })

  it('opens the registration modal', async () => {
    const user = userEvent.setup()
    renderPage()

    await user.click(screen.getByRole('button', { name: '注册账号' }))

    const dialog = await screen.findByRole('dialog')
    expect(within(dialog).getByText('注册账号')).toBeInTheDocument()
    expect(within(dialog).getByLabelText('账号')).toBeInTheDocument()
  })
})
