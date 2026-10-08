import type { AccountCharactersResponse } from '@atgm/contracts'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import {
  createMemoryHistory,
  createRootRoute,
  createRoute,
  createRouter,
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
import { ConfigProvider } from 'antd'
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

const jsonResponse = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { 'Content-Type': 'application/json' },
  })

const accountCharacters: AccountCharactersResponse = {
  recRole: '0000000000000003',
  chars: [
    {
      gid: '0000000000000003',
      name: '女金',
      polar: 1,
      gender: 2,
      time: '2026-10-02 23:37:54',
    },
    {
      gid: '0000000000000004',
      name: '龙宫守卫',
      polar: 5,
      gender: 1,
      time: '',
    },
  ],
}
let detailResponse: () => Promise<Response>
let charactersResponse: () => Promise<Response>
let queryClient: QueryClient

beforeEach(() => {
  fetchMock.mockReset()
  detailResponse = async () => jsonResponse(accountDetail)
  charactersResponse = async () => jsonResponse(accountCharacters)
  fetchMock.mockImplementation(async (input, init) => {
    const url = String(input)
    if (url === '/_api/accounts/server-account/characters')
      return charactersResponse()
    if (url === '/_api/accounts/server-account' && !init?.method)
      return detailResponse()
    if (
      url === '/_api/accounts/server-account/recharge' &&
      init?.method === 'PATCH'
    )
      return jsonResponse({
        account: 'server-account',
        goldCoin: 1000010,
        silverCoin: 50000,
      })
    if (
      url === '/_api/accounts/server-account/privilege' &&
      init?.method === 'PATCH'
    )
      return jsonResponse({ account: 'server-account', privilege: 120 })
    throw new Error(`Unexpected request: ${url}`)
  })
  queryClient = new QueryClient({
    defaultOptions: {
      queries: { retry: false },
    },
  })
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
      <ConfigProvider theme={{ token: { motion: false } }}>
        <RouterProvider router={router} />
      </ConfigProvider>
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
    expect(
      fetchMock.mock.calls.some(([url]) => String(url) === '/_api/privileges'),
    ).toBe(false)
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
    detailResponse = async () =>
      jsonResponse({ ...accountDetail, online: false })
    renderPage()

    expect(await screen.findByText('离线')).toBeInTheDocument()
    expect(screen.getByRole('button', { name: '充值' })).toBeEnabled()
    expect(screen.getByRole('button', { name: '变更权限' })).toBeEnabled()
    expect(screen.queryByRole('button', { name: '编辑' })).toBeNull()
  })

  it('disables both actions for an online account and explains why', async () => {
    const user = userEvent.setup()
    renderPage()

    const editButton = await screen.findByRole('button', { name: '充值' })

    expect(editButton).toBeDisabled()
    expect(screen.getByRole('button', { name: '变更权限' })).toBeDisabled()
    expect(screen.queryByRole('button', { name: '编辑' })).toBeNull()
    await user.hover(editButton.parentElement as HTMLElement)
    expect(await screen.findByText('账号在线时无法修改')).toBeInTheDocument()
  })

  it.each([
    ['充值', '充值账号：server-account', '充值成功'],
    ['变更权限', '变更权限：server-account', '权限变更成功'],
  ])('opens %s and closes it after success', async (action, title, success) => {
    detailResponse = async () =>
      jsonResponse({ ...accountDetail, online: false })
    const invalidateQueries = vi.spyOn(queryClient, 'invalidateQueries')
    const user = userEvent.setup()
    renderPage()
    await user.click(await screen.findByRole('button', { name: action }))
    expect(
      await screen.findByRole('dialog', { name: title }),
    ).toBeInTheDocument()
    if (action === '充值') {
      await user.clear(screen.getByLabelText('金元宝充值数量'))
      await user.type(screen.getByLabelText('金元宝充值数量'), '10')
      const dialog = screen.getByRole('dialog')
      await user.click(within(dialog).getByRole('button', { name: '充值' }))
    } else {
      await waitFor(() =>
        expect(screen.getByRole('button', { name: '保存' })).toBeEnabled(),
      )
      await user.click(screen.getByRole('button', { name: '保存' }))
    }
    expect(await screen.findByText(success)).toBeInTheDocument()
    await waitFor(() =>
      expect(screen.queryByRole('dialog', { name: title })).toBeNull(),
    )
    expect(invalidateQueries).toHaveBeenCalledWith({
      queryKey: ['account', 'server-account'],
    })
    expect(invalidateQueries).toHaveBeenCalledWith({ queryKey: ['accounts'] })
  })

  it('falls back safely for an unknown privilege', async () => {
    detailResponse = async () =>
      jsonResponse({ ...accountDetail, privilege: 999 })
    renderPage()

    expect(await screen.findByText('999')).toBeInTheDocument()
    expect(screen.getByText('未知权限')).toBeInTheDocument()
  })

  it('shows the not-found state with a link back to accounts', async () => {
    detailResponse = async () =>
      jsonResponse(
        { code: 'ACCOUNT_NOT_FOUND', message: 'Account not found' },
        404,
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
    detailResponse = async () => {
      accountRequests += 1
      return accountRequests === 1
        ? new Response(null, { status: 500 })
        : jsonResponse(accountDetail)
    }
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

describe('account associated characters', () => {
  it('requests characters and renders the last login character and rows in API order', async () => {
    renderPage()
    const section = await screen.findByRole('region', { name: '关联角色' })
    expect(await within(section).findByText('女金')).toBeInTheDocument()
    expect(fetchMock).toHaveBeenCalledWith(
      '/_api/accounts/server-account/characters',
    )
    expect(within(section).queryByText(/最近登陆角色 GID/)).toBeNull()
    const rows = within(section).getAllByRole('row').slice(1)
    expect(within(rows[0]).getByText('0000000000000003')).toBeInTheDocument()
    expect(within(rows[1]).getByText('0000000000000004')).toBeInTheDocument()
    expect(within(rows[0]).getByText('最近登陆')).toBeInTheDocument()
    expect(within(rows[1]).queryByText('最近登陆')).toBeNull()
    expect(within(rows[0]).getByText('金')).toBeInTheDocument()
    expect(within(rows[0]).getByText('女')).toBeInTheDocument()
    expect(within(rows[1]).getByText('土')).toBeInTheDocument()
    expect(within(rows[1]).getByText('男')).toBeInTheDocument()
    expect(within(rows[1]).getByText('-')).toBeInTheDocument()
    expect(
      within(section)
        .getAllByRole('columnheader')
        .map((cell) => cell.textContent),
    ).toEqual(['GID', '角色名', '相性', '性别', '创建时间'])
    expect(section.querySelector('.ant-pagination')).toBeNull()
    const content = screen
      .getByText('基本信息')
      .closest('.account-detail-page')!
    expect(content.textContent).toMatch(
      /基本信息.*资产.*关联角色.*登录信息.*封禁信息/s,
    )
  })

  it.each([
    { recRole: null, chars: [] },
    { recRole: '0000000000000003', chars: [] },
  ])(
    'renders empty characters without a GID hint for recRole $recRole',
    async (response) => {
      charactersResponse = async () => jsonResponse(response)
      renderPage()
      const section = await screen.findByRole('region', { name: '关联角色' })
      expect(await within(section).findByText('暂无角色')).toBeInTheDocument()
      expect(within(section).queryByText(/最近登陆角色 GID/)).toBeNull()
    },
  )

  it('does not mark other characters as last login when recRole is absent from the list', async () => {
    charactersResponse = async () =>
      jsonResponse({ ...accountCharacters, recRole: 'missing' })
    renderPage()
    const section = await screen.findByRole('region', { name: '关联角色' })
    expect(await within(section).findByText('女金')).toBeInTheDocument()
    expect(within(section).queryByText(/最近登陆角色 GID/)).toBeNull()
    expect(within(section).queryByText('最近登陆')).toBeNull()
  })

  it.each([
    { polar: 1, label: '金' },
    { polar: 2, label: '木' },
    { polar: 3, label: '水' },
    { polar: 4, label: '火' },
    { polar: 5, label: '土' },
    { polar: 9, label: '未知(9)' },
  ])('maps polar $polar to $label', async ({ polar, label }) => {
    charactersResponse = async () =>
      jsonResponse({
        recRole: null,
        chars: [{ ...accountCharacters.chars[0], polar }],
      })
    renderPage()
    const section = await screen.findByRole('region', { name: '关联角色' })
    expect(await within(section).findByText(label)).toBeInTheDocument()
  })

  it.each([
    { gender: 1, label: '男' },
    { gender: 2, label: '女' },
    { gender: 9, label: '未知(9)' },
  ])('maps gender $gender to $label', async ({ gender, label }) => {
    charactersResponse = async () =>
      jsonResponse({
        recRole: null,
        chars: [{ ...accountCharacters.chars[0], gender }],
      })
    renderPage()
    const section = await screen.findByRole('region', { name: '关联角色' })
    expect(await within(section).findByText(label)).toBeInTheDocument()
  })

  it('loads characters without returning the account page to a skeleton', async () => {
    let resolveCharacters!: (response: Response) => void
    charactersResponse = () =>
      new Promise((resolve) => {
        resolveCharacters = resolve
      })
    renderPage()
    expect(await screen.findByText('server-account')).toBeInTheDocument()
    const section = screen.getByRole('region', { name: '关联角色' })
    expect(within(section).getByText('加载中')).toBeInTheDocument()
    expect(section.querySelector('.ant-spin-spinning')).not.toBeNull()
    expect(document.querySelector('.ant-skeleton')).toBeNull()
    expect(screen.getByText('1,000,000')).toBeInTheDocument()
    expect(screen.getByText('登录信息')).toBeInTheDocument()
    expect(screen.getByText('封禁信息')).toBeInTheDocument()
    resolveCharacters(jsonResponse(accountCharacters))
    expect(await within(section).findByText('女金')).toBeInTheDocument()
  })

  it('isolates characters errors and retries only the characters request', async () => {
    let characterRequests = 0
    charactersResponse = async () => {
      characterRequests++
      return characterRequests === 1
        ? new Response(null, { status: 500 })
        : jsonResponse(accountCharacters)
    }
    const user = userEvent.setup()
    renderPage()
    const section = await screen.findByRole('region', { name: '关联角色' })
    expect(
      await within(section).findByText('关联角色加载失败'),
    ).toBeInTheDocument()
    expect(screen.getByText('server-account')).toBeInTheDocument()
    expect(screen.getByText('基本信息')).toBeInTheDocument()
    expect(screen.getByText('1,000,000')).toBeInTheDocument()
    expect(screen.getByText('2026-10-01 19:12:00')).toBeInTheDocument()
    expect(screen.getByText('封禁信息')).toBeInTheDocument()
    expect(screen.queryByText('账号详情加载失败')).toBeNull()
    expect(within(section).queryByText('暂无角色')).toBeNull()
    await user.click(within(section).getByRole('button', { name: '重试' }))
    expect(await within(section).findByText('女金')).toBeInTheDocument()
    expect(characterRequests).toBe(2)
    expect(
      fetchMock.mock.calls.filter(
        ([url]) => url === '/_api/accounts/server-account',
      ),
    ).toHaveLength(1)
  })

  it('renders duplicate gids as separate rows without duplicate key warnings', async () => {
    const consoleError = vi.spyOn(console, 'error').mockImplementation(() => {})
    charactersResponse = async () =>
      jsonResponse({
        recRole: accountCharacters.recRole,
        chars: [accountCharacters.chars[0], accountCharacters.chars[0]],
      })
    renderPage()
    const section = await screen.findByRole('region', { name: '关联角色' })
    await waitFor(() =>
      expect(within(section).getAllByText('女金')).toHaveLength(2),
    )
    expect(within(section).getAllByText('最近登陆')).toHaveLength(2)
    expect(consoleError.mock.calls.flat().join(' ')).not.toMatch(
      /same key|unique.*key/i,
    )
  })
})
