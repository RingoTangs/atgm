import { cleanup, render, screen, within } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { AccountsPage } from './AccountsPage'

beforeEach(() => {
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
  vi.restoreAllMocks()
  vi.unstubAllGlobals()
})

const openRegisterModal = async () => {
  const user = userEvent.setup()
  await user.click(screen.getByRole('button', { name: '注册账号' }))
  const dialog = await screen.findByRole('dialog')
  expect(within(dialog).getByText('注册账号')).toBeInTheDocument()
  return user
}

describe('accounts page', () => {
  it('展示页面标题、七列和格式化后的 Mock 账号', () => {
    render(<AccountsPage />)

    expect(
      screen.getByRole('heading', { name: '账号管理' }),
    ).toBeInTheDocument()
    expect(screen.getByText('查询和创建游戏账号')).toBeInTheDocument()
    expect(
      screen.getByRole('columnheader', { name: '账号' }),
    ).toBeInTheDocument()
    expect(
      screen.getByRole('columnheader', { name: '权限' }),
    ).toBeInTheDocument()
    expect(
      screen.getByRole('columnheader', { name: '金币' }),
    ).toBeInTheDocument()
    expect(
      screen.getByRole('columnheader', { name: '银币' }),
    ).toBeInTheDocument()
    expect(
      screen.getByRole('columnheader', { name: '最后登录' }),
    ).toBeInTheDocument()
    expect(
      screen.getByRole('columnheader', { name: '最后登录 IP' }),
    ).toBeInTheDocument()
    expect(
      screen.getByRole('columnheader', { name: '注册时间' }),
    ).toBeInTheDocument()

    const firstAccountRow = screen.getByText('test01').closest('tr')
    if (!firstAccountRow) throw new Error('test01 row not found')
    expect(within(firstAccountRow).getByText('0')).toBeInTheDocument()
    expect(within(firstAccountRow).getByText('100,000')).toBeInTheDocument()
    expect(within(firstAccountRow).getByText('50,000')).toBeInTheDocument()
    expect(
      within(firstAccountRow).getByText('2026-10-01 19:12:00'),
    ).toBeInTheDocument()
    expect(within(firstAccountRow).getByText('192.0.2.1')).toBeInTheDocument()
    expect(
      within(firstAccountRow).getByText('2026-08-01 10:00:00'),
    ).toBeInTheDocument()
  })

  it('账号时间和 IP 为空时显示短横线', () => {
    render(<AccountsPage />)

    const emptyAccountRow = screen.getByText('test06').closest('tr')
    if (!emptyAccountRow) throw new Error('test06 row not found')
    expect(within(emptyAccountRow).getAllByText('-')).toHaveLength(3)
  })

  it('按账号执行本地搜索并处理空结果', async () => {
    const user = userEvent.setup()
    render(<AccountsPage />)
    const search = screen.getByPlaceholderText('搜索账号')

    await user.type(search, '  TEST01  ')
    expect(screen.getByText('test01')).toBeInTheDocument()
    expect(screen.queryByText('test02')).not.toBeInTheDocument()

    await user.clear(search)
    await user.type(search, 'missing-account')
    expect(screen.getByText('暂无匹配账号')).toBeInTheDocument()
  })

  it('默认每页 20 条并可查看第二页', async () => {
    const user = userEvent.setup()
    render(<AccountsPage />)

    expect(screen.getByText('test20')).toBeInTheDocument()
    expect(screen.queryByText('test21')).not.toBeInTheDocument()

    await user.click(screen.getByTitle('2'))
    expect(await screen.findByText('test21')).toBeInTheDocument()
    expect(screen.getByText('test30')).toBeInTheDocument()
  })

  it('点击注册账号打开 Modal', async () => {
    render(<AccountsPage />)

    await openRegisterModal()

    expect(screen.getByRole('dialog')).toBeInTheDocument()
    expect(screen.getByLabelText('账号')).toBeInTheDocument()
  })

  it('成功注册后将完整列表字段加入本地数据且不显示密码', async () => {
    render(<AccountsPage />)
    const user = await openRegisterModal()

    await user.type(screen.getByLabelText('账号'), 'new-player')
    await user.type(screen.getByLabelText('密码'), 'test-password')
    await user.clear(screen.getByLabelText('金币'))
    await user.type(screen.getByLabelText('金币'), '1234567')
    await user.clear(screen.getByLabelText('银币'))
    await user.type(screen.getByLabelText('银币'), '765432')
    await user.clear(screen.getByLabelText('权限'))
    await user.type(screen.getByLabelText('权限'), '100')
    await user.click(screen.getByRole('button', { name: '注册' }))

    expect(await screen.findByText('账号注册成功')).toBeInTheDocument()
    const newAccountRow = screen.getByText('new-player').closest('tr')
    if (!newAccountRow) throw new Error('new account row not found')
    expect(within(newAccountRow).getByText('100')).toBeInTheDocument()
    expect(within(newAccountRow).getByText('1,234,567')).toBeInTheDocument()
    expect(within(newAccountRow).getByText('765,432')).toBeInTheDocument()
    expect(within(newAccountRow).getAllByText('-')).toHaveLength(3)
    expect(screen.queryByText('test-password')).not.toBeInTheDocument()
  })

  it('重复账号保留 Modal 且不会添加记录', async () => {
    render(<AccountsPage />)
    const user = await openRegisterModal()

    await user.type(screen.getByLabelText('账号'), 'TEST01')
    await user.type(screen.getByLabelText('密码'), 'test-password')
    await user.click(screen.getByRole('button', { name: '注册' }))

    expect(await screen.findByText('账号已存在')).toBeInTheDocument()
    expect(screen.getByRole('dialog')).toBeInTheDocument()
    expect(screen.getAllByText('test01')).toHaveLength(1)
  })
})
