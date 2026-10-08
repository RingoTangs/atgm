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
import { CharactersPage } from './CharactersPage'

const character = {
  gid: 'character-gid',
  name: '中文角色',
  polar: 1,
  gender: 2,
  time: '2018-04-13 15:53:02',
}
const fetchMock = vi.fn<typeof fetch>()
let queryClient: QueryClient
const response = (items = [character], total = 21, page = 1, pageSize = 20) =>
  new Response(JSON.stringify({ page, pageSize, total, items }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  })
const renderPage = () =>
  render(
    <QueryClientProvider client={queryClient}>
      <CharactersPage />
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

describe('characters page', () => {
  it('renders the title, five columns and server data with the default request', async () => {
    renderPage()
    expect(
      screen.getByRole('heading', { name: '角色管理' }),
    ).toBeInTheDocument()
    expect(screen.getByText('查询游戏角色')).toBeInTheDocument()
    for (const name of ['GID', '角色名', '相性', '性别', '时间']) {
      expect(screen.getByRole('columnheader', { name })).toBeInTheDocument()
    }
    expect(screen.getAllByRole('columnheader')).toHaveLength(5)
    const row = (await screen.findByText('中文角色')).closest('tr')!
    expect(row).toHaveAttribute('data-row-key', character.gid)
    expect(within(row).getByText(character.time)).toBeInTheDocument()
    expect(within(row).getByText('金')).toBeInTheDocument()
    expect(within(row).getByText('女')).toBeInTheDocument()
    expect(fetchMock).toHaveBeenCalledWith(
      '/_api/characters?page=1&pageSize=20',
    )
  })

  it.each([
    { polar: 1, label: '金' },
    { polar: 2, label: '木' },
    { polar: 3, label: '水' },
    { polar: 4, label: '火' },
    { polar: 5, label: '土' },
    { polar: 9, label: '未知(9)' },
  ])('displays polar $polar as $label', async ({ polar, label }) => {
    fetchMock.mockResolvedValue(response([{ ...character, polar }]))
    renderPage()
    const row = (await screen.findByText(character.name)).closest('tr')!
    expect(within(row).getByText(label)).toBeInTheDocument()
  })

  it.each([
    { gender: 1, label: '男' },
    { gender: 2, label: '女' },
    { gender: 9, label: '未知(9)' },
  ])('displays gender $gender as $label', async ({ gender, label }) => {
    fetchMock.mockResolvedValue(response([{ ...character, gender }]))
    renderPage()
    const row = (await screen.findByText(character.name)).closest('tr')!
    expect(within(row).getByText(label)).toBeInTheDocument()
  })

  it('uses server total to request the second page', async () => {
    const user = userEvent.setup()
    renderPage()
    await screen.findByText(character.name)
    expect(screen.queryByTitle('3')).not.toBeInTheDocument()
    await user.click(screen.getByTitle('2'))
    await waitFor(() =>
      expect(fetchMock).toHaveBeenLastCalledWith(
        '/_api/characters?page=2&pageSize=20',
      ),
    )
  })

  it('returns to page one when changing page size from the second page', async () => {
    const user = userEvent.setup()
    renderPage()
    await screen.findByText(character.name)
    await user.click(screen.getByTitle('2'))
    await waitFor(() =>
      expect(fetchMock).toHaveBeenLastCalledWith(
        '/_api/characters?page=2&pageSize=20',
      ),
    )
    await user.click(screen.getByRole('combobox'))
    await user.click(await screen.findByTitle('50 / page'))
    await waitFor(() =>
      expect(fetchMock).toHaveBeenLastCalledWith(
        '/_api/characters?page=1&pageSize=50',
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
    await screen.findByText(character.name)
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
    await screen.findByText(character.name)
    await user.click(screen.getByTitle('2'))
    await waitFor(() =>
      expect(container.querySelector('.ant-spin-spinning')).toBeInTheDocument(),
    )
    expect(screen.getByText(character.name)).toBeInTheDocument()
    resolve(
      response(
        [{ ...character, gid: 'second-gid', name: '第二页角色' }],
        21,
        2,
      ),
    )
    await screen.findByText('第二页角色')
    expect(screen.queryByText(character.name)).not.toBeInTheDocument()
  })

  it('shows an error and retries the request', async () => {
    fetchMock
      .mockResolvedValueOnce(new Response('failed', { status: 500 }))
      .mockResolvedValueOnce(response())
    const user = userEvent.setup()
    renderPage()
    await screen.findByText('角色列表加载失败')
    await user.click(screen.getByRole('button', { name: '重试' }))
    await screen.findByText(character.name)
    expect(screen.queryByText('角色列表加载失败')).not.toBeInTheDocument()
    expect(fetchMock).toHaveBeenCalledTimes(2)
  })

  it('shows the empty list text', async () => {
    fetchMock.mockResolvedValue(response([], 0))
    renderPage()
    expect(await screen.findByText('暂无角色')).toBeInTheDocument()
  })

  it('shows a dash for an empty time', async () => {
    fetchMock.mockResolvedValue(response([{ ...character, time: '' }]))
    renderPage()
    await screen.findByText(character.name)
    expect(screen.getByText('-')).toBeInTheDocument()
  })
})
