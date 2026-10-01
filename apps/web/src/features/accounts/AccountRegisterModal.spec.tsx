import { cleanup, render, screen } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { AccountRegisterModal } from './AccountRegisterModal'

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

const renderModal = (existingAccounts: string[] = []) => {
  const onCancel = vi.fn()
  const onRegister = vi.fn()

  render(
    <AccountRegisterModal
      existingAccounts={existingAccounts}
      onCancel={onCancel}
      onRegister={onRegister}
      open
    />,
  )

  return { onCancel, onRegister }
}

const fillRequiredFields = async (account = 'new-account') => {
  const user = userEvent.setup()
  await user.type(screen.getByLabelText('账号'), account)
  await user.type(screen.getByLabelText('密码'), 'test-password')
  return user
}

describe('account register modal', () => {
  it('展示五个字段和数字默认值', () => {
    renderModal()

    expect(screen.getByLabelText('账号')).toBeInTheDocument()
    expect(screen.getByLabelText('密码')).toBeInTheDocument()
    expect(screen.getByLabelText('金币')).toHaveValue('0')
    expect(screen.getByLabelText('银币')).toHaveValue('0')
    expect(screen.getByLabelText('权限')).toHaveValue('0')
  })

  it('校验账号和密码必填', async () => {
    const user = userEvent.setup()
    renderModal()

    await user.click(screen.getByRole('button', { name: '注册' }))

    expect(await screen.findByText('请输入账号')).toBeInTheDocument()
    expect(await screen.findByText('请输入密码')).toBeInTheDocument()
  })

  it('校验账号最大长度', async () => {
    const user = userEvent.setup()
    renderModal()

    await user.type(screen.getByLabelText('账号'), 'a'.repeat(33))

    expect(
      await screen.findByText('账号不能超过 32 个字符'),
    ).toBeInTheDocument()
  })

  it.each([
    ['金币', '-1', '金币必须是'],
    ['金币', '2000000001', '金币必须是'],
    ['银币', '-1', '银币必须是'],
    ['银币', '2000000001', '银币必须是'],
    ['权限', '-1', '权限必须是'],
    ['权限', '1001', '权限必须是'],
    ['权限', '1.5', '权限必须是'],
  ])('校验%s的整数范围', async (label, value, errorText) => {
    renderModal()
    const user = await fillRequiredFields()
    const input = screen.getByLabelText(label)
    await user.clear(input)
    await user.type(input, value)
    await user.click(screen.getByRole('button', { name: '注册' }))

    expect(await screen.findByText(new RegExp(errorText))).toBeInTheDocument()
  })

  it('提交正确的注册值', async () => {
    const { onRegister } = renderModal()
    const user = await fillRequiredFields()

    await user.clear(screen.getByLabelText('金币'))
    await user.type(screen.getByLabelText('金币'), '2000000000')
    await user.clear(screen.getByLabelText('银币'))
    await user.type(screen.getByLabelText('银币'), '15')
    await user.clear(screen.getByLabelText('权限'))
    await user.type(screen.getByLabelText('权限'), '1000')
    await user.click(screen.getByRole('button', { name: '注册' }))

    expect(onRegister).toHaveBeenCalledWith({
      account: 'new-account',
      rawPassword: 'test-password',
      goldCoin: 2_000_000_000,
      silverCoin: 15,
      privilege: 1000,
    })
  })

  it('重复账号显示字段错误且不提交', async () => {
    const { onRegister } = renderModal(['test01'])
    const user = await fillRequiredFields('TEST01')

    await user.click(screen.getByRole('button', { name: '注册' }))

    expect(await screen.findByText('账号已存在')).toBeInTheDocument()
    expect(onRegister).not.toHaveBeenCalled()
    expect(screen.getByLabelText('密码')).toHaveValue('test-password')
  })

  it('取消时关闭并重置表单', async () => {
    const { onCancel } = renderModal()
    const user = await fillRequiredFields()
    await user.clear(screen.getByLabelText('金币'))
    await user.type(screen.getByLabelText('金币'), '10')

    await user.click(screen.getByRole('button', { name: '取消' }))

    expect(onCancel).toHaveBeenCalledOnce()
    expect(screen.getByLabelText('账号')).toHaveValue('')
    expect(screen.getByLabelText('密码')).toHaveValue('')
    expect(screen.getByLabelText('金币')).toHaveValue('0')
  })
})
