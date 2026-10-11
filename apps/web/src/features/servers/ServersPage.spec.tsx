import type { ServerListItem } from '@atgm/contracts'
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
import { ServersPage } from './ServersPage'

const server: ServerListItem = {
  id: 1,
  server: '万里长城一线',
  dist: '万里长城',
  alias: '',
  ip: '47.97.104.166',
  port: 8160,
  maxUser: 1200,
  enable: 1,
}
const fetchMock = vi.fn<typeof fetch>()
let queryClient: QueryClient
const response = (items = [server], total = 21, page = 1, pageSize = 10) =>
  new Response(JSON.stringify({ page, pageSize, total, items }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  })
const renderPage = () =>
  render(
    <QueryClientProvider client={queryClient}>
      <ServersPage />
    </QueryClientProvider>,
  )

beforeEach(() => {
  queryClient = new QueryClient({
    defaultOptions: { queries: { retry: false } },
  })
  fetchMock.mockReset()
  fetchMock.mockImplementation(async () => response())
  vi.stubGlobal('fetch', fetchMock)
  vi.stubGlobal(
    'ResizeObserver',
    class {
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

describe('servers page', () => {
  it('renders the title, eight columns, Chinese names and server row keys', async () => {
    renderPage()
    expect(
      screen.getByRole('heading', { name: '服务器管理' }),
    ).toBeInTheDocument()
    expect(screen.getByText('查询游戏服务器配置')).toBeInTheDocument()
    expect(
      screen.getAllByRole('columnheader').map((header) => header.textContent),
    ).toEqual([
      '线路 ID',
      '服务器名称',
      '所属区组',
      '别名',
      'IP 地址',
      '端口',
      '最大人数',
      '启用状态',
    ])
    const row = (await screen.findByText(server.server)).closest('tr')!
    expect(row).toHaveAttribute('data-row-key', server.server)
    expect(within(row).getByText(server.dist)).toBeInTheDocument()
    expect(within(row).getByText(server.ip)).toBeInTheDocument()
    expect(fetchMock).toHaveBeenCalledWith('/_api/servers?page=1&pageSize=10')
  })

  it('renders enabled, disabled and unknown states with duplicate ids', async () => {
    fetchMock.mockResolvedValue(
      response([
        server,
        { ...server, server: '万里长城二线', enable: 0 },
        { ...server, server: '万里长城三线', enable: 9 },
      ]),
    )
    renderPage()
    for (const [name, label] of [
      [server.server, '已启用'],
      ['万里长城二线', '已禁用'],
      ['万里长城三线', '未知状态（9）'],
    ]) {
      const row = (await screen.findByText(name)).closest('tr')!
      expect(row).toHaveAttribute('data-row-key', name)
      expect(within(row).getByText(label)).toBeInTheDocument()
    }
  })

  it('uses server total to request the second page', async () => {
    const user = userEvent.setup()
    renderPage()
    await screen.findByText(server.server)
    expect(screen.getByTitle('3')).toBeInTheDocument()
    await user.click(screen.getByTitle('2'))
    await waitFor(() =>
      expect(fetchMock).toHaveBeenLastCalledWith(
        '/_api/servers?page=2&pageSize=10',
      ),
    )
  })

  it('returns to page one when changing page size from the second page', async () => {
    const user = userEvent.setup()
    renderPage()
    await screen.findByText(server.server)
    await user.click(screen.getByTitle('2'))
    await waitFor(() =>
      expect(fetchMock).toHaveBeenLastCalledWith(
        '/_api/servers?page=2&pageSize=10',
      ),
    )
    await user.click(screen.getByRole('combobox'))
    await user.click(await screen.findByTitle('50 / page'))
    await waitFor(() =>
      expect(fetchMock).toHaveBeenLastCalledWith(
        '/_api/servers?page=1&pageSize=50',
      ),
    )
  })

  it('shows loading while the initial request is pending', async () => {
    let resolve!: (value: Response) => void
    fetchMock.mockReturnValue(
      new Promise<Response>((done) => {
        resolve = done
      }),
    )
    const { container } = renderPage()
    await waitFor(() =>
      expect(container.querySelector('.ant-spin-spinning')).toBeInTheDocument(),
    )
    resolve(response())
    await screen.findByText(server.server)
    await waitFor(() =>
      expect(
        container.querySelector('.ant-spin-spinning'),
      ).not.toBeInTheDocument(),
    )
  })

  it('retains previous rows and shows loading while fetching another page', async () => {
    let resolve!: (value: Response) => void
    fetchMock.mockResolvedValueOnce(response()).mockImplementationOnce(
      () =>
        new Promise<Response>((done) => {
          resolve = done
        }),
    )
    const user = userEvent.setup()
    const { container } = renderPage()
    await screen.findByText(server.server)
    await user.click(screen.getByTitle('2'))
    await waitFor(() =>
      expect(container.querySelector('.ant-spin-spinning')).toBeInTheDocument(),
    )
    expect(screen.getByText(server.server)).toBeInTheDocument()
    resolve(response([{ ...server, server: '第二页服务器' }], 21, 2))
    await screen.findByText('第二页服务器')
    expect(screen.queryByText(server.server)).not.toBeInTheDocument()
  })

  it('shows an error and retries the request', async () => {
    fetchMock
      .mockResolvedValueOnce(new Response('failed', { status: 500 }))
      .mockResolvedValueOnce(response())
    const user = userEvent.setup()
    renderPage()
    await screen.findByText('服务器列表加载失败')
    await user.click(screen.getByRole('button', { name: '重试' }))
    await screen.findByText(server.server)
    expect(screen.queryByText('服务器列表加载失败')).not.toBeInTheDocument()
    expect(fetchMock).toHaveBeenCalledTimes(2)
  })

  it('shows the empty list text', async () => {
    fetchMock.mockResolvedValue(response([], 0))
    renderPage()
    expect(await screen.findByText('暂无服务器')).toBeInTheDocument()
  })
})
