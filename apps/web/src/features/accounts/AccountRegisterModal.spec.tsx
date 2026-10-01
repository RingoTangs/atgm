import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { cleanup, render, screen, waitFor } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { AccountRegisterModal } from './AccountRegisterModal'

const fetchMock = vi.fn<typeof fetch>()
let queryClient: QueryClient

const privileges = [
  {
    privilege: 120,
    grant: 'GA',
    constant: 'ADMINISTRATOR',
    type: '管理特权',
    description: '管理员',
  },
  {
    privilege: 1000,
    grant: 'GD',
    constant: 'DEBUGGER',
    type: '调试特权',
    description: '调试器权限',
  },
]

const jsonResponse = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { 'Content-Type': 'application/json' },
  })

const mockRegistrationResponse = (responseFactory: () => Promise<Response>) => {
  fetchMock.mockImplementation((input) => {
    if (String(input) === '/_api/privileges') {
      return Promise.resolve(jsonResponse(privileges))
    }

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
  option = '120 - 管理员',
) => {
  await user.click(screen.getByLabelText('权限'))
  await user.click(await screen.findByTitle(option))
}

describe('account register modal', () => {
  it('loads privileges and shows a Select without a default value', async () => {
    renderModal()

    expect(screen.getByLabelText('账号')).toBeInTheDocument()
    expect(screen.getByLabelText('密码')).toBeInTheDocument()
    expect(screen.getByLabelText('金币')).toHaveValue('0')
    expect(screen.getByLabelText('银币')).toHaveValue('0')
    expect(screen.getByLabelText('权限')).toHaveAttribute('role', 'combobox')
    expect(screen.getByLabelText('权限')).toHaveValue('')

    await waitFor(() => {
      expect(fetchMock).toHaveBeenCalledWith('/_api/privileges')
    })

    const user = userEvent.setup()
    await user.click(screen.getByLabelText('权限'))
    expect(await screen.findByTitle('120 - 管理员')).toBeInTheDocument()
    expect(screen.getByTitle('1000 - 调试器权限')).toBeInTheDocument()
  })

  it('validates required account, password, and privilege fields', async () => {
    const user = userEvent.setup()
    renderModal()

    await waitFor(() => {
      expect(screen.getByRole('button', { name: '注册' })).toBeEnabled()
    })
    await user.click(screen.getByRole('button', { name: '注册' }))

    expect(await screen.findByText('请输入账号')).toBeInTheDocument()
    expect(await screen.findByText('请输入密码')).toBeInTheDocument()
    expect(
      await screen.findByText('请选择权限', {
        selector: '.ant-form-item-explain-error',
      }),
    ).toBeInTheDocument()
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

  it.each([
    ['金币', '-1', '金币必须是'],
    ['金币', '2000000001', '金币必须是'],
    ['银币', '-1', '银币必须是'],
    ['银币', '2000000001', '银币必须是'],
  ])('validates the integer range for %s', async (label, value, errorText) => {
    renderModal()
    const user = await fillRequiredFields()
    await selectPrivilege(user)
    const input = screen.getByLabelText(label)
    await user.clear(input)
    await user.type(input, value)
    await user.click(screen.getByRole('button', { name: '注册' }))

    expect(await screen.findByText(new RegExp(errorText))).toBeInTheDocument()
    expect(registrationCalls()).toHaveLength(0)
  })

  it('posts correct values, invalidates accounts, resets, and closes', async () => {
    const invalidateQueries = vi.spyOn(queryClient, 'invalidateQueries')
    const { onCancel } = renderModal()
    const user = await fillRequiredFields()

    await user.clear(screen.getByLabelText('金币'))
    await user.type(screen.getByLabelText('金币'), '2000000000')
    await user.clear(screen.getByLabelText('银币'))
    await user.type(screen.getByLabelText('银币'), '15')
    await selectPrivilege(user, '1000 - 调试器权限')
    await user.click(screen.getByRole('button', { name: '注册' }))

    expect(await screen.findByText('账号注册成功')).toBeInTheDocument()
    expect(fetchMock).toHaveBeenCalledWith('/_api/account', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        account: 'new-account',
        rawPassword: 'test-password',
        goldCoin: 2_000_000_000,
        silverCoin: 15,
        privilege: 1000,
      }),
    })
    expect(invalidateQueries).toHaveBeenCalledWith({
      queryKey: ['accounts'],
    })
    expect(onCancel).toHaveBeenCalledOnce()
    expect(screen.getByLabelText('账号')).toHaveValue('')
    expect(screen.getByLabelText('密码')).toHaveValue('')
    expect(screen.getByLabelText('金币')).toHaveValue('0')
  })

  it('shows a field error for HTTP 409 and preserves the form', async () => {
    mockRegistrationResponse(() =>
      Promise.resolve(new Response(null, { status: 409 })),
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
    await user.clear(screen.getByLabelText('金币'))
    await user.type(screen.getByLabelText('金币'), '10')

    await user.click(screen.getByRole('button', { name: '取消' }))

    expect(onCancel).toHaveBeenCalledOnce()
    expect(screen.getByLabelText('账号')).toHaveValue('')
    expect(screen.getByLabelText('密码')).toHaveValue('')
    expect(screen.getByLabelText('金币')).toHaveValue('0')
  })

  it('disables privilege selection and registration when loading fails', async () => {
    fetchMock.mockResolvedValue(new Response(null, { status: 500 }))
    renderModal()

    expect(await screen.findByText('权限列表加载失败')).toBeInTheDocument()
    expect(screen.getByLabelText('权限')).toBeDisabled()
    expect(screen.getByRole('button', { name: '注册' })).toBeDisabled()
    expect(screen.queryByRole('spinbutton', { name: '权限' })).toBeNull()
    expect(registrationCalls()).toHaveLength(0)
  })
})
