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
  it('展示页面标题和 Mock 账号', () => {
    render(<AccountsPage />)

    expect(
      screen.getByRole('heading', { name: '账号管理' }),
    ).toBeInTheDocument()
    expect(screen.getByText('查询和创建游戏账号')).toBeInTheDocument()
    expect(screen.getByText('test01')).toBeInTheDocument()
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

  it('成功注册后将新账号加入列表且不显示密码', async () => {
    render(<AccountsPage />)
    const user = await openRegisterModal()

    await user.type(screen.getByLabelText('账号'), 'new-player')
    await user.type(screen.getByLabelText('密码'), 'test-password')
    await user.click(screen.getByRole('button', { name: '注册' }))

    expect(await screen.findByText('账号注册成功')).toBeInTheDocument()
    expect(screen.getByText('new-player')).toBeInTheDocument()
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
