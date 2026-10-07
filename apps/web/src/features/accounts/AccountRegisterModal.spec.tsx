import { ACCOUNT_PRIVILEGES } from '@atgm/contracts'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
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
import { AccountRegisterModal } from './AccountRegisterModal'

const fetchMock = vi.fn<typeof fetch>()
let queryClient: QueryClient

const jsonResponse = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { 'Content-Type': 'application/json' },
  })

const mockRegistrationResponse = (responseFactory: () => Promise<Response>) => {
  fetchMock.mockImplementation(() => {
    return responseFactory()
  })
}

const registrationCalls = () =>
  fetchMock.mock.calls.filter(([, init]) => init?.method === 'POST')

beforeEach(() => {
  fetchMock.mockReset()
  queryClient = new QueryClient({
    defaultOptions: {
      queries: { retry: false },
      mutations: { retry: false },
    },
  })
  mockRegistrationResponse(() =>
    Promise.resolve(jsonResponse({ account: 'new-account' }, 201)),
  )
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

const renderModal = () => {
  const onCancel = vi.fn()

  render(
    <QueryClientProvider client={queryClient}>
      <AccountRegisterModal onCancel={onCancel} open />
    </QueryClientProvider>,
  )

  return { onCancel }
}

const fillRequiredFields = async (account = 'new-account') => {
  const user = userEvent.setup()
  await user.type(screen.getByLabelText('账号'), account)
  await user.type(screen.getByLabelText('密码'), 'test-password')
  return user
}

const selectPrivilege = async (
  user: ReturnType<typeof userEvent.setup>,
  option = '120 - GA - ADMINISTRATOR(管理员)',
) => {
  await user.click(screen.getByLabelText('权限'))
  await user.click(await screen.findByTitle(option))
}

describe('account register modal', () => {
  it('preserves the shared privilege dictionary values and order', () => {
    expect(ACCOUNT_PRIVILEGES.map(({ privilege }) => privilege)).toEqual([
      0, 120, 130, 140, 150, 200, 300, 400, 1000,
    ])
    expect(ACCOUNT_PRIVILEGES[0]).toEqual({
      privilege: 0,
      grant: 'USER',
      constant: 'COMMON_USER',
      type: '用户权限',
      description: '普通用户',
    })
    expect(ACCOUNT_PRIVILEGES[8]).toEqual({
      privilege: 1000,
      grant: 'GD',
      constant: 'DEBUGGER',
      type: '调试特权',
      description: '调试器权限',
    })
  })

  it('uses shared privileges without a request and selects the default user', async () => {
    renderModal()

    expect(screen.getByLabelText('账号')).toBeInTheDocument()
    expect(screen.getByLabelText('密码')).toBeInTheDocument()
    expect(screen.getByLabelText('金元宝')).toHaveValue('0')
    expect(screen.getByLabelText('银元宝')).toHaveValue('0')
    expect(screen.getByLabelText('权限')).toHaveAttribute('role', 'combobox')
    expect(
      screen.getByTitle('0 - USER - COMMON_USER(普通用户)'),
    ).toBeInTheDocument()

    expect(fetchMock).not.toHaveBeenCalled()

    const user = userEvent.setup()
    await user.click(screen.getByLabelText('权限'))
    expect(
      (await screen.findAllByTitle('0 - USER - COMMON_USER(普通用户)'))[0],
    ).toBeInTheDocument()
    expect(
      await screen.findByTitle('120 - GA - ADMINISTRATOR(管理员)'),
    ).toBeInTheDocument()
    expect(
      screen.getByTitle('1000 - GD - DEBUGGER(调试器权限)'),
    ).toBeInTheDocument()
  })

  it('submits the numeric default privilege without a manual selection', async () => {
    renderModal()
    const user = await fillRequiredFields()
    await user.click(screen.getByRole('button', { name: '注册' }))
    expect(await screen.findByText('账号注册成功')).toBeInTheDocument()
    expect(fetchMock).toHaveBeenCalledWith('/_api/account', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        account: 'new-account',
        rawPassword: 'test-password',
        goldCoin: 0,
        silverCoin: 0,
        privilege: 0,
      }),
    })
  })

  it('restores the default privilege after closing and reopening', async () => {
    const onCancel = vi.fn()
    const modal = (open: boolean) => (
      <QueryClientProvider client={queryClient}>
        <ConfigProvider theme={{ token: { motion: false } }}>
          <AccountRegisterModal open={open} onCancel={onCancel} />
        </ConfigProvider>
      </QueryClientProvider>
    )
    const { rerender } = render(modal(true))
    const user = userEvent.setup()
    await selectPrivilege(user)
    expect(
      within(screen.getByRole('dialog')).getByTitle(
        '120 - GA - ADMINISTRATOR(管理员)',
      ),
    ).toBeInTheDocument()
    rerender(modal(false))
    await waitFor(() => expect(screen.queryByRole('dialog')).toBeNull())
    rerender(modal(true))
    expect(
      await screen.findByTitle('0 - USER - COMMON_USER(普通用户)'),
    ).toBeInTheDocument()
  })

  it('validates account and password while accepting the default privilege', async () => {
    const user = userEvent.setup()
    renderModal()

    await waitFor(() => {
      expect(screen.getByRole('button', { name: '注册' })).toBeEnabled()
    })
    await user.click(screen.getByRole('button', { name: '注册' }))

    expect(await screen.findByText('请输入账号')).toBeInTheDocument()
    expect(await screen.findByText('请输入密码')).toBeInTheDocument()
    expect(
      screen.queryByText('请选择权限', {
        selector: '.ant-form-item-explain-error',
      }),
    ).toBeNull()
    expect(registrationCalls()).toHaveLength(0)
  })

  it('validates the maximum account length', async () => {
    const user = userEvent.setup()
    renderModal()

    await user.type(screen.getByLabelText('账号'), 'a'.repeat(33))

    expect(
      await screen.findByText('账号不能超过 32 个字符'),
    ).toBeInTheDocument()
  })

  it.each(['金元宝', '银元宝'])('limits the integer range for %s', (label) => {
    renderModal()
    const input = screen.getByLabelText(label)

    expect(input).toHaveAttribute('aria-valuemin', '0')
    expect(input).toHaveAttribute('aria-valuemax', '2000000000')
  })

  it.each(['金元宝', '银元宝'])(
    'sets %s to its minimum and maximum values',
    async (label) => {
      renderModal()
      const user = userEvent.setup()
      const input = screen.getByLabelText(label)
      const labelRow = screen.getByText(label, {
        selector: 'label',
      }).parentElement

      expect(labelRow).not.toBeNull()
      await user.clear(input)
      await user.type(input, '25')
      await user.click(
        within(labelRow as HTMLElement).getByRole('button', { name: '最小' }),
      )
      expect(input).toHaveValue('0')

      await user.click(
        within(labelRow as HTMLElement).getByRole('button', { name: '最大' }),
      )
      expect(input).toHaveValue('2,000,000,000')
    },
  )

  it.each(['金元宝', '银元宝'])(
    'formats %s with thousands separators and preserves empty input',
    async (label) => {
      renderModal()
      const user = userEvent.setup()
      const input = screen.getByLabelText(label)
      for (const [value, display] of [
        ['1000', '1,000'],
        ['100000000', '100,000,000'],
        ['100,000,000', '100,000,000'],
      ]) {
        await user.clear(input)
        expect(input).toHaveValue('')
        await user.type(input, value)
        await user.tab()
        expect(input).toHaveValue(display)
      }
      await user.clear(input)
      await user.tab()
      expect(input).toHaveValue('')
      await user.type(input, '1000')
      expect(input).toHaveValue('1,000')
    },
  )

  it('posts correct values, invalidates accounts, resets, and closes', async () => {
    const invalidateQueries = vi.spyOn(queryClient, 'invalidateQueries')
    const { onCancel } = renderModal()
    const user = await fillRequiredFields()

    await user.clear(screen.getByLabelText('金元宝'))
    await user.type(screen.getByLabelText('金元宝'), '2,000,000,000')
    await user.clear(screen.getByLabelText('银元宝'))
    await user.type(screen.getByLabelText('银元宝'), '100,000,000')
    await selectPrivilege(user, '1000 - GD - DEBUGGER(调试器权限)')
    await user.click(screen.getByRole('button', { name: '注册' }))

    expect(await screen.findByText('账号注册成功')).toBeInTheDocument()
    expect(fetchMock).toHaveBeenCalledWith('/_api/account', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        account: 'new-account',
        rawPassword: 'test-password',
        goldCoin: 2_000_000_000,
        silverCoin: 100_000_000,
        privilege: 1000,
      }),
    })
    expect(invalidateQueries).toHaveBeenCalledWith({
      queryKey: ['accounts'],
    })
    expect(onCancel).toHaveBeenCalledOnce()
    expect(screen.getByLabelText('账号')).toHaveValue('')
    expect(screen.getByLabelText('密码')).toHaveValue('')
    expect(screen.getByLabelText('金元宝')).toHaveValue('0')
    expect(
      screen.getByTitle('0 - USER - COMMON_USER(普通用户)'),
    ).toBeInTheDocument()
  })

  it('shows a field error for ACCOUNT_ALREADY_EXISTS and preserves the form', async () => {
    mockRegistrationResponse(() =>
      Promise.resolve(
        jsonResponse(
          { code: 'ACCOUNT_ALREADY_EXISTS', message: 'Account exists' },
          409,
        ),
      ),
    )
    const { onCancel } = renderModal()
    const user = await fillRequiredFields('existing-account')
    await selectPrivilege(user)

    await user.click(screen.getByRole('button', { name: '注册' }))

    expect(await screen.findByText('账号已存在')).toBeInTheDocument()
    expect(screen.getByLabelText('密码')).toHaveValue('test-password')
    expect(screen.getByRole('dialog')).toBeInTheDocument()
    expect(onCancel).not.toHaveBeenCalled()
  })

  it.each([
    [
      'different 409 code with duplicate message',
      () =>
        Promise.resolve(
          jsonResponse({ code: 'ACCOUNT_ONLINE', message: '账号已存在' }, 409),
        ),
    ],
    [
      'missing code',
      () => Promise.resolve(jsonResponse({ message: '账号已存在' }, 409)),
    ],
    ['HTTP 500', () => Promise.resolve(new Response(null, { status: 500 }))],
    ['network error', () => Promise.reject(new Error('network unavailable'))],
  ])('shows a generic error for %s', async (_case, responseFactory) => {
    mockRegistrationResponse(responseFactory)
    const { onCancel } = renderModal()
    const user = await fillRequiredFields()
    await selectPrivilege(user)

    await user.click(screen.getByRole('button', { name: '注册' }))

    expect(
      await screen.findByText('账号注册失败，请稍后重试'),
    ).toBeInTheDocument()
    expect(screen.getByLabelText('密码')).toHaveValue('test-password')
    expect(onCancel).not.toHaveBeenCalled()
  })

  it('prevents duplicate submissions while the mutation is pending', async () => {
    let resolveRequest: (response: Response) => void = () => undefined
    mockRegistrationResponse(
      () =>
        new Promise((resolve) => {
          resolveRequest = resolve
        }),
    )
    renderModal()
    const user = await fillRequiredFields()
    await selectPrivilege(user)
    const registerButton = screen.getByRole('button', { name: '注册' })

    await user.click(registerButton)
    await waitFor(() => expect(registrationCalls()).toHaveLength(1))
    expect(registerButton).toBeDisabled()
    await user.click(registerButton)
    expect(registrationCalls()).toHaveLength(1)

    resolveRequest(
      new Response(JSON.stringify({ account: 'new-account' }), { status: 201 }),
    )
    expect(await screen.findByText('账号注册成功')).toBeInTheDocument()
  })

  it('resets the form when cancelled', async () => {
    const { onCancel } = renderModal()
    const user = await fillRequiredFields()
    await selectPrivilege(user)
    await user.clear(screen.getByLabelText('金元宝'))
    await user.type(screen.getByLabelText('金元宝'), '10')

    await user.click(screen.getByRole('button', { name: '取消' }))

    expect(onCancel).toHaveBeenCalledOnce()
    expect(screen.getByLabelText('账号')).toHaveValue('')
    expect(screen.getByLabelText('密码')).toHaveValue('')
    expect(screen.getByLabelText('金元宝')).toHaveValue('0')
    expect(
      screen.getByTitle('0 - USER - COMMON_USER(普通用户)'),
    ).toBeInTheDocument()
  })
})
