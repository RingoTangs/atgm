import { parseLpcValue } from '@atgm/lpc'
import {
  cleanup,
  render,
  screen,
  waitFor,
  within,
} from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { buildLpcAnalysisTree } from './buildLpcAnalysisTree'
import { LpcAnalysisView } from './LpcAnalysisView'
import { installMatchMedia } from './lpcTestUtils'

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

function treeLabel(label: string) {
  return within(screen.getByRole('tree')).getByText(label, { exact: true })
}

async function expand(user: ReturnType<typeof userEvent.setup>, label: string) {
  const item = treeLabel(label).closest('.ant-tree-treenode')
  const switcher = item?.querySelector('.ant-tree-switcher')
  if (!switcher) throw new Error(`No switcher for ${label}`)
  await user.click(switcher)
}

const embeddedSource = String.raw`(["carry":([103:"中级法玲珑:([255:36,\"type\":8,])",]),])`

describe('lpc analysis view', () => {
  it('shows containers and scalar details and copies path and numeric value', async () => {
    const user = userEvent.setup()
    const write = vi.spyOn(navigator.clipboard, 'writeText').mockResolvedValue()
    render(
      <LpcAnalysisView
        root={buildLpcAnalysisTree(
          parseLpcValue('(["me":(["level":33,]),"items":({"hello",}),])'),
        )}
      />,
    )
    expect(treeLabel('root')).toBeInTheDocument()
    expect(treeLabel('me')).toBeInTheDocument()
    expect(treeLabel('[0]')).toBeInTheDocument()
    expect(screen.getByRole('button', { name: '复制值' })).toBeDisabled()
    await user.click(treeLabel('level'))
    expect(screen.getByText('Number')).toBeInTheDocument()
    expect(screen.getByText('$.me.level')).toBeInTheDocument()
    expect(screen.getAllByText('33').length).toBeGreaterThan(0)
    await user.click(screen.getByRole('button', { name: '复制 Path' }))
    expect(write).toHaveBeenLastCalledWith('$.me.level')
    await user.click(screen.getByRole('button', { name: '复制值' }))
    expect(write).toHaveBeenLastCalledWith('33')
  })

  it('flattens the embedded payload layer while preserving details and true paths', async () => {
    const user = userEvent.setup()
    const write = vi.spyOn(navigator.clipboard, 'writeText').mockResolvedValue()
    render(
      <LpcAnalysisView
        root={buildLpcAnalysisTree(parseLpcValue(embeddedSource))}
      />,
    )
    expect(treeLabel('103')).toBeInTheDocument()
    expect(
      within(screen.getByRole('tree')).queryByText('255'),
    ).not.toBeInTheDocument()
    await user.click(treeLabel('103'))
    expect(screen.getByText('Embedded LPC')).toBeInTheDocument()
    expect(screen.getByText('中级法玲珑:')).toBeInTheDocument()
    expect(
      screen.getByText('中级法玲珑:([255:36,"type":8,])'),
    ).toBeInTheDocument()
    await user.click(screen.getByRole('button', { name: '复制值' }))
    expect(write).toHaveBeenLastCalledWith('中级法玲珑:([255:36,"type":8,])')
    await expand(user, '103')
    expect(treeLabel('255')).toBeInTheDocument()
    expect(treeLabel('type')).toBeInTheDocument()
    expect(
      within(screen.getByRole('tree')).queryByText('embedded', { exact: true }),
    ).not.toBeInTheDocument()
    const item = treeLabel('255').closest('.ant-tree-treenode')
    expect(item?.querySelectorAll('.ant-tree-indent-unit')).toHaveLength(3)
    await user.click(treeLabel('255'))
    expect(screen.getByText('$.carry[103].embedded[255]')).toBeInTheDocument()
  })

  it('keeps deeper containers collapsed and resets selection when the root changes', async () => {
    const user = userEvent.setup()
    const { rerender } = render(
      <LpcAnalysisView
        root={buildLpcAnalysisTree(
          parseLpcValue('(["a":(["b":(["deep":1,]),]),])'),
        )}
      />,
    )
    expect(treeLabel('b')).toBeInTheDocument()
    expect(
      within(screen.getByRole('tree')).queryByText('deep'),
    ).not.toBeInTheDocument()
    await user.click(treeLabel('b'))
    expect(screen.getByText('$.a.b')).toBeInTheDocument()
    rerender(<LpcAnalysisView root={buildLpcAnalysisTree([1])} />)
    expect(screen.queryByText('$.a.b')).not.toBeInTheDocument()
    expect(screen.getByText('Array')).toBeInTheDocument()
    expect(screen.getByText('$')).toBeInTheDocument()
    expect(treeLabel('[0]')).toBeInTheDocument()
  })

  it.each([
    [0, 'Number', '0'],
    ['', 'String', ''],
    [{ type: 'special', value: 'ABC' } as const, 'Special', ':ABC:'],
  ])(
    'copies scalar %s including zero and empty string',
    async (value, kind, expected) => {
      const user = userEvent.setup()
      const write = vi
        .spyOn(navigator.clipboard, 'writeText')
        .mockResolvedValue()
      render(<LpcAnalysisView root={buildLpcAnalysisTree(value)} />)
      expect(screen.getByText(kind)).toBeInTheDocument()
      expect(screen.getByRole('button', { name: '复制值' })).toBeEnabled()
      await user.click(screen.getByRole('button', { name: '复制值' }))
      expect(write).toHaveBeenCalledWith(expected)
    },
  )

  it('truncates tree previews but keeps the full string in details and reports copy failure', async () => {
    const user = userEvent.setup()
    vi.spyOn(navigator.clipboard, 'writeText').mockRejectedValue(
      new Error('Denied'),
    )
    const value = '很长的文本'.repeat(30)
    render(<LpcAnalysisView root={buildLpcAnalysisTree(value)} />)
    expect(
      within(screen.getByRole('tree')).queryByText(value),
    ).not.toBeInTheDocument()
    expect(screen.getByText(value)).toBeInTheDocument()
    await user.click(screen.getByRole('button', { name: '复制值' }))
    expect(await screen.findByText('复制失败，请手动复制')).toBeInTheDocument()
  })
})

describe('responsive node details', () => {
  it.each([767, 768, 1599, 1600])(
    'uses the expected detail presentation at width %s',
    async (width) => {
      installMatchMedia(width)
      const user = userEvent.setup()
      const write = vi
        .spyOn(navigator.clipboard, 'writeText')
        .mockResolvedValue()
      render(
        <LpcAnalysisView
          root={buildLpcAnalysisTree(new Map([['level', 33]]))}
        />,
      )
      expect(screen.queryByRole('dialog')).not.toBeInTheDocument()
      if (width < 1600)
        expect(screen.queryByText('节点详情')).not.toBeInTheDocument()
      else expect(screen.getByText('节点详情')).toBeInTheDocument()
      await user.click(treeLabel('level'))
      const details =
        width < 1600
          ? await screen.findByRole('dialog', { name: '节点详情' })
          : screen.getByText('节点详情').closest<HTMLElement>('.ant-card')!
      expect(within(details).getByText('Number')).toBeInTheDocument()
      expect(within(details).getByText('$.level')).toBeInTheDocument()
      await user.click(within(details).getByRole('button', { name: '复制值' }))
      expect(write).toHaveBeenCalledWith('33')
      if (width >= 1600) {
        expect(screen.queryByRole('dialog')).not.toBeInTheDocument()
        return
      }
      expect(details.closest('.ant-drawer')).toHaveClass(
        width < 768 ? 'ant-drawer-bottom' : 'ant-drawer-right',
      )
      const wrapper = details.closest<HTMLElement>(
        '.ant-drawer-content-wrapper',
      )!
      expect(width < 768 ? wrapper.style.height : wrapper.style.width).toBe(
        width < 768 ? '60vh' : '480px',
      )
      await user.click(
        within(details).getByRole('button', { name: '关闭节点详情' }),
      )
      await waitFor(() =>
        expect(screen.queryByRole('dialog')).not.toBeInTheDocument(),
      )
      expect(treeLabel('level').closest('.ant-tree-treenode')).toHaveClass(
        'ant-tree-treenode-selected',
      )
      await user.click(treeLabel('level'))
      expect(
        await screen.findByRole('dialog', { name: '节点详情' }),
      ).toHaveTextContent('$.level')
    },
  )

  it('adapts an open drawer on resize and requires selection after returning from inline details', async () => {
    const resize = installMatchMedia(1599)
    const user = userEvent.setup()
    render(<LpcAnalysisView root={buildLpcAnalysisTree([1])} />)
    await user.click(treeLabel('[0]'))
    expect(
      (await screen.findByRole('dialog')).closest('.ant-drawer'),
    ).toHaveClass('ant-drawer-right')
    resize(767)
    expect(screen.getByRole('dialog').closest('.ant-drawer')).toHaveClass(
      'ant-drawer-bottom',
    )
    expect(screen.getByRole('dialog')).toHaveTextContent('$[0]')
    resize(1600)
    expect(screen.queryByRole('dialog')).not.toBeInTheDocument()
    expect(screen.getByText('$[0]')).toBeInTheDocument()
    resize(768)
    expect(screen.queryByRole('dialog')).not.toBeInTheDocument()
    expect(screen.queryByText('节点详情')).not.toBeInTheDocument()
    await user.click(treeLabel('[0]'))
    expect(await screen.findByRole('dialog')).toHaveTextContent('$[0]')
  })

  it('closes the drawer and resets selected and expanded nodes for a replacement result', async () => {
    installMatchMedia(768)
    const user = userEvent.setup()
    const { rerender } = render(
      <LpcAnalysisView root={buildLpcAnalysisTree(new Map([['level', 33]]))} />,
    )
    await user.click(treeLabel('level'))
    expect(await screen.findByRole('dialog')).toHaveTextContent('$.level')
    rerender(<LpcAnalysisView root={buildLpcAnalysisTree([2])} />)
    await waitFor(() =>
      expect(screen.queryByRole('dialog')).not.toBeInTheDocument(),
    )
    await user.click(treeLabel('root'))
    const details = await screen.findByRole('dialog')
    expect(within(details).getByText('$', { exact: true })).toBeInTheDocument()
    expect(within(details).getByText('Array')).toBeInTheDocument()
    expect(treeLabel('[0]')).toBeInTheDocument()
  })

  it.each([767, 768])(
    'preserves Embedded LPC details and children with a drawer at width %s',
    async (width) => {
      installMatchMedia(width)
      const user = userEvent.setup()
      render(
        <LpcAnalysisView
          root={buildLpcAnalysisTree(parseLpcValue(embeddedSource))}
        />,
      )
      await user.click(treeLabel('103'))
      const details = await screen.findByRole('dialog')
      expect(within(details).getByText('Embedded LPC')).toBeInTheDocument()
      expect(within(details).getByText('中级法玲珑:')).toBeInTheDocument()
      expect(
        within(details).getByText('中级法玲珑:([255:36,"type":8,])'),
      ).toBeInTheDocument()
      expect(
        within(details).getByText('([255:36,"type":8,])'),
      ).toBeInTheDocument()
      await user.click(
        within(details).getByRole('button', { name: '关闭节点详情' }),
      )
      await waitFor(() =>
        expect(screen.queryByRole('dialog')).not.toBeInTheDocument(),
      )
      await expand(user, '103')
      expect(treeLabel('255')).toBeInTheDocument()
      expect(
        within(screen.getByRole('tree')).queryByText('embedded', {
          exact: true,
        }),
      ).not.toBeInTheDocument()
      await user.click(treeLabel('255'))
      expect(await screen.findByRole('dialog')).toHaveTextContent(
        '$.carry[103].embedded[255]',
      )
    },
  )
})
