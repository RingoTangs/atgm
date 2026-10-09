import type { CharacterDetailResponse } from '@atgm/contracts'
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
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { CharacterDetailPage } from './CharacterDetailPage'

const gid = '0000000000000003'
const detail: CharacterDetailResponse = {
  basicInfo: {
    gid,
    name: '女金',
    account: '1',
    level: 33,
    polar: 1,
    gender: 2,
    createTime: '2018-04-13 15:53:02',
  },
  sectInfo: { family: '五龙山云霄洞', master: '云霄童子', title: '金系精英' },
  attributes: { strength: 33, constitution: 33, dexterity: 33, wiz: 33 },
  combat: {
    life: 2109,
    maxLife: 1804,
    mana: 1270,
    maxMana: 1233,
    speed: 114,
    defense: 185,
    physicalPower: 205,
    magPower: 205,
  },
  cultivation: {
    experience: 2827,
    experienceToNextLevel: 3439,
    tao: 100,
    potential: 7034,
  },
  assets: {
    cash: 27,
    goldCoin: 1999995004,
    silverCoin: 2000000000,
    voucher: 117000,
  },
}
const jsonResponse = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { 'Content-Type': 'application/json' },
  })
const fetchMock = vi.fn<typeof fetch>()
const itemsFetchMock = vi.fn<typeof fetch>()
let queryClient: QueryClient

beforeEach(() => {
  queryClient = new QueryClient({
    defaultOptions: { queries: { retry: false } },
  })
  fetchMock.mockReset().mockImplementation(async () => jsonResponse(detail))
  itemsFetchMock
    .mockReset()
    .mockImplementation(async () =>
      jsonResponse({ branchExists: false, items: [] }),
    )
  vi.stubGlobal('fetch', (...args: Parameters<typeof fetch>) =>
    String(args[0]).endsWith('/items')
      ? itemsFetchMock(...args)
      : fetchMock(...args),
  )
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

function renderPage() {
  const root = createRootRoute()
  const detailRoute = createRoute({
    getParentRoute: () => root,
    path: '/characters/$gid',
    component: () => <CharacterDetailPage gid={gid} />,
  })
  const listRoute = createRoute({
    getParentRoute: () => root,
    path: '/characters',
    component: () => <h1>角色列表测试页</h1>,
  })
  const accountRoute = createRoute({
    getParentRoute: () => root,
    path: '/accounts/$account',
    component: () => <h1>账号详情测试页</h1>,
  })
  const router = createRouter({
    history: createMemoryHistory({ initialEntries: [`/characters/${gid}`] }),
    routeTree: root.addChildren([detailRoute, listRoute, accountRoute]),
  })
  return render(
    <QueryClientProvider client={queryClient}>
      <RouterProvider router={router} />
    </QueryClientProvider>,
  )
}

function valueFor(label: string) {
  const labelCell = screen.getByText(label).closest('th,td')!
  return labelCell.nextElementSibling as HTMLElement
}

describe('character detail page', () => {
  it('requests and displays all six groups of read-only character details', async () => {
    renderPage()
    await screen.findByText('女金')
    expect(fetchMock).toHaveBeenCalledWith(`/_api/characters/${gid}`)
    for (const title of [
      '基本信息',
      '门派信息',
      '人物属性',
      '战斗属性',
      '修炼信息',
      '资产信息',
    ])
      expect(screen.getByText(title)).toBeInTheDocument()
    const expected = {
      GID: gid,
      角色名: '女金',
      关联账号: '1',
      等级: '33',
      相性: '金',
      性别: '女',
      创建时间: '2018-04-13 15:53:02',
      门派: '五龙山云霄洞',
      师父: '云霄童子',
      称号: '金系精英',
      力量: '33',
      体质: '33',
      敏捷: '33',
      灵力: '33',
      气血: '2,109',
      最大气血: '1,804',
      法力: '1,270',
      最大法力: '1,233',
      速度: '114',
      防御: '185',
      物伤: '205',
      法伤: '205',
      经验: '2,827',
      升级所需经验: '3,439',
      道行: '100',
      潜能: '7,034',
      现金: '27',
      金元宝: '1,999,995,004',
      银元宝: '2,000,000,000',
      代金券: '117,000',
    }
    for (const [label, value] of Object.entries(expected))
      expect(valueFor(label)).toHaveTextContent(value)
    expect(screen.queryByRole('button', { name: /修改|充值|编辑/ })).toBeNull()
  })

  it('shows missing values as dashes, preserves zero, and does not link a missing account', async () => {
    fetchMock.mockImplementation(async () =>
      jsonResponse({
        ...detail,
        basicInfo: {
          ...detail.basicInfo,
          account: null,
          level: null,
          createTime: '',
        },
        sectInfo: { family: null, master: null, title: null },
        assets: { cash: 0, goldCoin: null, silverCoin: null, voucher: null },
      }),
    )
    renderPage()
    await screen.findByText('女金')
    for (const label of [
      '关联账号',
      '等级',
      '创建时间',
      '门派',
      '师父',
      '称号',
      '金元宝',
      '银元宝',
      '代金券',
    ])
      expect(valueFor(label)).toHaveTextContent(/^-$/)
    expect(valueFor('现金')).toHaveTextContent(/^0$/)
    expect(within(valueFor('关联账号')).queryByRole('link')).toBeNull()
  })

  it('preserves basic information when the user record is missing', async () => {
    fetchMock.mockImplementation(async () =>
      jsonResponse({
        basicInfo: { ...detail.basicInfo, account: null, level: null },
        sectInfo: { family: null, master: null, title: null },
        attributes: {
          strength: null,
          constitution: null,
          dexterity: null,
          wiz: null,
        },
        combat: {
          life: null,
          maxLife: null,
          mana: null,
          maxMana: null,
          speed: null,
          defense: null,
          physicalPower: null,
          magPower: null,
        },
        cultivation: {
          experience: null,
          experienceToNextLevel: null,
          tao: null,
          potential: null,
        },
        assets: { cash: null, goldCoin: null, silverCoin: null, voucher: null },
      }),
    )
    renderPage()
    await screen.findByText('女金')
    expect(valueFor('GID')).toHaveTextContent(gid)
    expect(valueFor('创建时间')).toHaveTextContent(detail.basicInfo.createTime!)
    expect(valueFor('相性')).toHaveTextContent('金')
    expect(valueFor('性别')).toHaveTextContent('女')
    for (const label of [
      '关联账号',
      '等级',
      '门派',
      '师父',
      '称号',
      '力量',
      '体质',
      '敏捷',
      '灵力',
      '气血',
      '最大气血',
      '法力',
      '最大法力',
      '速度',
      '防御',
      '物伤',
      '法伤',
      '经验',
      '升级所需经验',
      '道行',
      '潜能',
      '现金',
      '金元宝',
      '银元宝',
      '代金券',
    ])
      expect(valueFor(label)).toHaveTextContent(/^-$/)
  })

  it('uses the existing unknown-value display for polar and gender', async () => {
    fetchMock.mockImplementation(async () =>
      jsonResponse({
        ...detail,
        basicInfo: { ...detail.basicInfo, polar: 9, gender: 8 },
      }),
    )
    renderPage()
    expect(await screen.findByText('未知(9)')).toBeInTheDocument()
    expect(screen.getByText('未知(8)')).toBeInTheDocument()
  })

  it.each([
    { link: '返回角色列表', href: '/characters', heading: '角色列表测试页' },
    { link: '1', href: '/accounts/1', heading: '账号详情测试页' },
  ])('navigates using $link', async ({ link, href, heading }) => {
    const user = userEvent.setup()
    renderPage()
    await screen.findByText('女金')
    const element = screen.getByRole('link', { name: link })
    expect(element).toHaveAttribute('href', href)
    await user.click(element)
    expect(
      await screen.findByRole('heading', { name: heading }),
    ).toBeInTheDocument()
  })

  it('shows a skeleton while the request is pending', async () => {
    let resolve!: (response: Response) => void
    fetchMock.mockImplementation(
      () =>
        new Promise<Response>((done) => {
          resolve = done
        }),
    )
    const { container } = renderPage()
    await waitFor(() =>
      expect(container.querySelector('.ant-skeleton')).toBeInTheDocument(),
    )
    expect(
      screen.getByRole('link', { name: '返回角色列表' }),
    ).toBeInTheDocument()
    resolve(jsonResponse(detail))
    await screen.findByText('女金')
    expect(container.querySelector('.ant-skeleton')).toBeNull()
  })

  it('shows a not-found state with a return link', async () => {
    fetchMock.mockImplementation(async () =>
      jsonResponse({ code: 'CHARACTER_NOT_FOUND', message: '角色不存在' }, 404),
    )
    renderPage()
    expect(await screen.findByText('角色不存在')).toBeInTheDocument()
    expect(screen.getByRole('link', { name: '返回角色列表' })).toHaveAttribute(
      'href',
      '/characters',
    )
    expect(screen.queryByRole('button', { name: '重试' })).toBeNull()
  })

  it('shows an error and retries the detail request', async () => {
    fetchMock
      .mockResolvedValueOnce(new Response(null, { status: 500 }))
      .mockResolvedValueOnce(jsonResponse(detail))
    const user = userEvent.setup()
    renderPage()
    await screen.findByText('角色详情加载失败')
    await user.click(screen.getByRole('button', { name: '重试' }))
    await screen.findByText('女金')
    expect(fetchMock).toHaveBeenCalledTimes(2)
  })

  it('displays a clear error for damaged character data', async () => {
    fetchMock.mockImplementation(async () =>
      jsonResponse(
        {
          code: 'CHARACTER_DATA_INVALID',
          message: '角色数据损坏：me.gid must match the requested GID',
        },
        500,
      ),
    )
    renderPage()
    expect(
      await screen.findByText(
        '角色数据损坏：me.gid must match the requested GID',
      ),
    ).toBeInTheDocument()
    expect(screen.queryByText('基本信息')).toBeNull()
  })
})

describe('character items section', () => {
  it('requests items independently and renders the carry rows and empty aliases', async () => {
    itemsFetchMock.mockResolvedValue(
      jsonResponse({
        branchExists: true,
        items: [
          { entryKey: 1, name: '长枪', alias: '被强化的长枪' },
          { entryKey: 2, name: '簪子', alias: '被强化的簪子' },
          { entryKey: 3, name: '布裙', alias: '被强化的布裙' },
          { entryKey: 10, name: '麻鞋', alias: '被强化的麻鞋' },
          { entryKey: 51, name: '布带', alias: '被强化的布带' },
          { entryKey: 101, name: '新手礼包（35级）', alias: null },
          { entryKey: 102, name: '驯兽诀', alias: null },
          { entryKey: 103, name: '中级法玲珑', alias: null },
          { entryKey: 104, name: '特级八卦阴阳令', alias: null },
          { entryKey: 105, name: '中级血玲珑', alias: null },
        ],
      }),
    )
    renderPage()
    const section = await screen.findByRole('region', { name: '物品信息' })
    await within(section).findByText('长枪')
    expect(itemsFetchMock).toHaveBeenCalledWith(`/_api/characters/${gid}/items`)
    expect(
      within(section)
        .getAllByRole('columnheader')
        .map((cell) => cell.textContent),
    ).toEqual(['记录 Key', '物品名称', '别名'])
    const rows = within(section).getAllByRole('row').slice(1)
    expect(rows.map((row) => row.getAttribute('data-row-key'))).toEqual([
      '1',
      '2',
      '3',
      '10',
      '51',
      '101',
      '102',
      '103',
      '104',
      '105',
    ])
    expect(within(rows[0]).getByText('被强化的长枪')).toBeInTheDocument()
    expect(within(rows[9]).getByText('中级血玲珑')).toBeInTheDocument()
    expect(within(rows[9]).getAllByRole('cell')[2]).toHaveTextContent(/^-$/)
    expect(section.querySelector('.ant-pagination')).toBeNull()
    expect(screen.getByText('女金')).toBeInTheDocument()
    expect(screen.getByRole('link', { name: '1' })).toHaveAttribute(
      'href',
      '/accounts/1',
    )
  })

  it.each([false, true])(
    'shows an empty list with branchExists %s',
    async (branchExists) => {
      itemsFetchMock.mockResolvedValue(
        jsonResponse({ branchExists, items: [] }),
      )
      renderPage()
      const section = await screen.findByRole('region', { name: '物品信息' })
      expect(await within(section).findByText('暂无物品')).toBeInTheDocument()
    },
  )

  it('loads items without hiding the character details', async () => {
    let resolve!: (response: Response) => void
    itemsFetchMock.mockImplementation(
      () =>
        new Promise<Response>((done) => {
          resolve = done
        }),
    )
    renderPage()
    const section = await screen.findByRole('region', { name: '物品信息' })
    expect(within(section).getByText('加载中')).toBeInTheDocument()
    expect(section.querySelector('.ant-spin-spinning')).not.toBeNull()
    expect(screen.getByText('女金')).toBeInTheDocument()
    expect(screen.getByText('基本信息')).toBeInTheDocument()
    resolve(jsonResponse({ branchExists: true, items: [] }))
    expect(await within(section).findByText('暂无物品')).toBeInTheDocument()
  })

  it('isolates item errors and retries only the items query', async () => {
    itemsFetchMock
      .mockResolvedValueOnce(
        jsonResponse(
          { code: 'INTERNAL_SERVER_ERROR', message: 'Internal Server Error' },
          500,
        ),
      )
      .mockResolvedValueOnce(
        jsonResponse({
          branchExists: true,
          items: [{ entryKey: 1, name: '长枪', alias: null }],
        }),
      )
    const user = userEvent.setup()
    renderPage()
    const section = await screen.findByRole('region', { name: '物品信息' })
    expect(
      await within(section).findByText('物品信息加载失败'),
    ).toBeInTheDocument()
    expect(screen.getByText('女金')).toBeInTheDocument()
    expect(
      screen.getByRole('link', { name: '返回角色列表' }),
    ).toBeInTheDocument()
    expect(screen.getByRole('link', { name: '1' })).toBeInTheDocument()
    expect(within(section).queryByText('暂无物品')).toBeNull()
    await user.click(within(section).getByRole('button', { name: '重试' }))
    expect(await within(section).findByText('长枪')).toBeInTheDocument()
    expect(itemsFetchMock).toHaveBeenCalledTimes(2)
    expect(fetchMock).toHaveBeenCalledTimes(1)
  })

  it('does not request items when the character does not exist', async () => {
    fetchMock.mockResolvedValue(
      jsonResponse({ code: 'CHARACTER_NOT_FOUND', message: '角色不存在' }, 404),
    )
    renderPage()
    await screen.findByText('角色不存在')
    expect(itemsFetchMock).not.toHaveBeenCalled()
    expect(screen.queryByRole('region', { name: '物品信息' })).toBeNull()
  })
})
