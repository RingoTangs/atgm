import type { CharacterItemDetailResponse } from '@atgm/contracts'
import { formatLpc, parseEmbeddedLpc, parseLpcValue } from '@atgm/lpc'
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
import { installMatchMedia } from '@/features/lpc/lpcTestUtils'
import fixture from '../../../../../packages/lpc/src/fixtures/gid-03-carry.txt?raw'
import { CharacterItems } from './CharacterItems'

const gid = '0000000000000003'
const carry = (parseLpcValue(fixture) as Map<string, Map<number, string>>).get(
  'carry',
)!
const details: CharacterItemDetailResponse[] = [103, 1].map((entryKey) => {
  const embedded = parseEmbeddedLpc(carry.get(entryKey)!)!
  return {
    entryKey,
    name: embedded.prefix.slice(0, -1),
    alias: (embedded.value as Map<string, string>).get('alias') ?? null,
    lpc: embedded.source,
  }
})
const json = (value: unknown, status = 200) =>
  new Response(JSON.stringify(value), {
    status,
    headers: { 'Content-Type': 'application/json' },
  })
const fetchDetail = vi.fn<typeof fetch>()
let client: QueryClient
beforeEach(() => {
  client = new QueryClient({ defaultOptions: { queries: { retry: false } } })
  fetchDetail
    .mockReset()
    .mockImplementation(async (input) =>
      json(details.find((item) => String(input).endsWith(`/${item.entryKey}`))),
    )
  vi.stubGlobal('fetch', (input: RequestInfo | URL, init?: RequestInit) =>
    String(input).endsWith('/items')
      ? Promise.resolve(
          json({
            branchExists: true,
            items: details.map(({ lpc: _lpc, ...item }) => item),
          }),
        )
      : fetchDetail(input, init),
  )
  installMatchMedia()
  vi.stubGlobal(
    'ResizeObserver',
    class {
      observe = vi.fn()
      unobserve = vi.fn()
      disconnect = vi.fn()
    },
  )
})
afterEach(() => {
  cleanup()
  client.clear()
  vi.restoreAllMocks()
  vi.unstubAllGlobals()
})
function renderItems(value = gid) {
  return (
    <QueryClientProvider client={client}>
      <CharacterItems key={value} gid={value} />
    </QueryClientProvider>
  )
}
async function open(name = '中级法玲珑') {
  const row = (await screen.findByText(name)).closest('tr')!
  await userEvent.click(within(row).getByRole('button', { name: '查看详情' }))
}

describe('carry item drawer', () => {
  it('loads only on open, displays real attributes and copies original LPC', async () => {
    const user = userEvent.setup()
    render(renderItems())
    await screen.findByText('中级法玲珑')
    expect(fetchDetail).not.toHaveBeenCalled()
    await open()
    const drawer = await screen.findByRole('dialog', { name: '物品详情' })
    expect(await within(drawer).findByText('中级法玲珑')).toBeInTheDocument()
    expect(within(drawer).getAllByText('103').length).toBeGreaterThan(0)
    expect(within(drawer).getByText('-')).toBeInTheDocument()
    expect(within(drawer).getByText('233')).toBeInTheDocument()
    expect(
      within(drawer).getByText(':6ABD337600010147A4F4:'),
    ).toBeInTheDocument()
    expect(within(drawer).getByText('recover')).toBeInTheDocument()
    expect(fetchDetail).toHaveBeenCalledWith(
      `/_api/characters/${gid}/items/103`,
      undefined,
    )
    await user.click(within(drawer).getByRole('tab', { name: '原始 LPC' }))
    expect(
      within(drawer).getByRole('textbox', { name: '原始 LPC' }),
    ).toHaveValue(formatLpc(details[0].lpc))
    const writeText = vi
      .spyOn(navigator.clipboard, 'writeText')
      .mockResolvedValue()
    await user.click(
      within(drawer).getByRole('button', { name: '复制原始 LPC' }),
    )
    expect(writeText).toHaveBeenCalledWith(details[0].lpc)
    await user.click(
      within(drawer).getByRole('button', { name: '关闭物品详情' }),
    )
    await waitFor(() =>
      expect(screen.queryByRole('dialog', { name: '物品详情' })).toBeNull(),
    )
  })
  it('shows loading and never shows the previous item during a switch', async () => {
    const user = userEvent.setup()
    render(renderItems())
    await open()
    let drawer = await screen.findByRole('dialog', { name: '物品详情' })
    await within(drawer).findByText('中级法玲珑')
    await user.click(
      within(drawer).getByRole('button', { name: '关闭物品详情' }),
    )
    let resolve!: (response: Response) => void
    fetchDetail.mockImplementationOnce(
      () =>
        new Promise((done) => {
          resolve = done
        }),
    )
    await open('长枪')
    drawer = await screen.findByRole('dialog', { name: '物品详情' })
    expect(within(drawer).queryByText('中级法玲珑')).toBeNull()
    expect(drawer.querySelector('.ant-spin-spinning')).not.toBeNull()
    resolve(json(details[1]))
    expect(
      (await within(drawer).findAllByText('被强化的长枪')).length,
    ).toBeGreaterThan(0)
  })
  it('ignores a late response after opening another item', async () => {
    const user = userEvent.setup()
    let resolve!: (response: Response) => void
    fetchDetail.mockImplementationOnce(
      () =>
        new Promise((done) => {
          resolve = done
        }),
    )
    render(renderItems())
    await open()
    const pending = await screen.findByRole('dialog', { name: '物品详情' })
    await user.click(
      within(pending).getByRole('button', { name: '关闭物品详情' }),
    )
    await open('长枪')
    const drawer = await screen.findByRole('dialog', { name: '物品详情' })
    await within(drawer).findAllByText('被强化的长枪')
    resolve(json(details[0]))
    await waitFor(() =>
      expect(
        client.getQueryData(['characters', 'itemDetail', gid, 103]),
      ).toEqual(details[0]),
    )
    expect(within(drawer).queryByText('中级法玲珑')).toBeNull()
    expect(
      within(drawer).getByRole('tab', { name: '属性解析' }),
    ).toHaveAttribute('aria-selected', 'true')
  })
  it.each([404, 500])(
    'supports error and retry for status %s',
    async (status) => {
      fetchDetail.mockResolvedValueOnce(
        json(
          {
            code:
              status === 404
                ? 'CHARACTER_ITEM_NOT_FOUND'
                : 'INTERNAL_SERVER_ERROR',
            message: status === 404 ? '物品不存在' : 'Internal Server Error',
          },
          status,
        ),
      )
      render(renderItems())
      await open()
      const drawer = await screen.findByRole('dialog', { name: '物品详情' })
      expect(
        await within(drawer).findByText('物品详情加载失败'),
      ).toBeInTheDocument()
      await userEvent.click(
        within(drawer).getByRole('button', { name: '重试' }),
      )
      expect(await within(drawer).findByText('中级法玲珑')).toBeInTheDocument()
      expect(fetchDetail).toHaveBeenCalledTimes(2)
    },
  )
  it('isolates identical item keys across characters', async () => {
    const view = render(renderItems())
    await open()
    await within(
      await screen.findByRole('dialog', { name: '物品详情' }),
    ).findByText('中级法玲珑')
    view.rerender(renderItems('second-gid'))
    expect(screen.queryByRole('dialog', { name: '物品详情' })).toBeNull()
    await open()
    await waitFor(() =>
      expect(fetchDetail).toHaveBeenCalledWith(
        '/_api/characters/second-gid/items/103',
        undefined,
      ),
    )
  })
  it('reports clipboard failures', async () => {
    const user = userEvent.setup()
    render(renderItems())
    await open()
    const drawer = await screen.findByRole('dialog', { name: '物品详情' })
    await within(drawer).findByText('中级法玲珑')
    await user.click(within(drawer).getByRole('tab', { name: '原始 LPC' }))
    vi.spyOn(navigator.clipboard, 'writeText').mockRejectedValue(
      new Error('unavailable'),
    )
    await user.click(
      within(drawer).getByRole('button', { name: '复制原始 LPC' }),
    )
    expect(await screen.findByText('复制失败，请手动复制')).toBeInTheDocument()
  })
})
