import type { AccountDetailResponse } from '@atgm/contracts'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { cleanup, render, screen, waitFor } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { AccountEditModal } from './AccountEditModal'

const fetchMock = vi.fn<typeof fetch>()
let queryClient: QueryClient

const account: AccountDetailResponse = {
  account: 'server-account',
  online: true,
  privilege: 120,
  goldCoin: 1_000_000,
  silverCoin: 50_000,
  blockedTime: '',
  blockedReason: '',
  tempBlockedTime: '',
  tempBlockedReason: '',
  firstLoginTime: '',
  firstLoginMac: '',
  lastLoginTime: '',
  lastLoginIp: '',
  lastLoginId: '',
  regDate: '',
}

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

const mockUpdateResponse = (responseFactory: () => Promise<Response>) => {
  fetchMock.mockImplementation((input) => {
    if (String(input) === '/_api/privileges') {
      return Promise.resolve(jsonResponse(privileges))
    }

    return responseFactory()
  })
}

const updateCalls = () =>
  fetchMock.mock.calls.filter(([, init]) => init?.method === 'PATCH')

beforeEach(() => {
  fetchMock.mockReset()
  queryClient = new QueryClient({
    defaultOptions: {
      queries: { retry: false },
      mutations: { retry: false },
    },
  })
  mockUpdateResponse(() =>
    Promise.resolve(jsonResponse({ account: 'server-account' })),
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

const renderModal = (accountValue = account) => {
  const onCancel = vi.fn()

  render(
    <QueryClientProvider client={queryClient}>
      <AccountEditModal account={accountValue} onCancel={onCancel} open />
    </QueryClientProvider>,
  )

  return { onCancel }
}

describe('account edit modal', () => {
  it('fills the form with current account values', async () => {
    renderModal()

    expect(
      screen.getByRole('dialog', { name: '编辑账号：server-account' }),
    ).toBeInTheDocument()
    expect(screen.queryByLabelText('账号')).toBeNull()
    expect(screen.getByLabelText('金币')).toHaveValue('1000000')
    expect(screen.getByLabelText('银币')).toHaveValue('50000')
    expect(
      await screen.findByTitle('120 - GA - ADMINISTRATOR(管理员)'),
    ).toBeInTheDocument()
  })

  it('preserves an unknown current privilege as a select option', async () => {
    const user = userEvent.setup()
    renderModal({ ...account, privilege: 100 })

    await user.click(screen.getByLabelText('权限'))

    expect(
      (await screen.findAllByTitle('100 - 未知权限')).length,
    ).toBeGreaterThan(0)
    expect(screen.queryByRole('spinbutton', { name: '权限' })).toBeNull()
  })

  it('patches values, invalidates detail and list queries, and closes', async () => {
    const invalidateQueries = vi.spyOn(queryClient, 'invalidateQueries')
    const { onCancel } = renderModal()
    const user = userEvent.setup()

    await waitFor(() => {
      expect(screen.getByRole('button', { name: '保存' })).toBeEnabled()
    })
    await user.click(screen.getByLabelText('权限'))
    await user.click(
      await screen.findByTitle('1000 - GD - DEBUGGER(调试器权限)'),
    )
    await user.clear(screen.getByLabelText('金币'))
    await user.type(screen.getByLabelText('金币'), '2000000000')
    await user.clear(screen.getByLabelText('银币'))
    await user.type(screen.getByLabelText('银币'), '15')
    await user.click(screen.getByRole('button', { name: '保存' }))

    expect(await screen.findByText('账号修改成功')).toBeInTheDocument()
    expect(fetchMock).toHaveBeenCalledWith('/_api/accounts/server-account', {
      method: 'PATCH',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        privilege: 1000,
        goldCoin: 2_000_000_000,
        silverCoin: 15,
      }),
    })
    expect(invalidateQueries).toHaveBeenCalledWith({
      queryKey: ['account', 'server-account'],
    })
    expect(invalidateQueries).toHaveBeenCalledWith({
      queryKey: ['accounts'],
    })
    expect(onCancel).toHaveBeenCalledOnce()
  })

  it('shows a conflict error and keeps the modal open', async () => {
    mockUpdateResponse(() =>
      Promise.resolve(new Response(null, { status: 409 })),
    )
    const { onCancel } = renderModal()
    const user = userEvent.setup()

    await waitFor(() => {
      expect(screen.getByRole('button', { name: '保存' })).toBeEnabled()
    })
    await user.click(screen.getByRole('button', { name: '保存' }))

    expect(
      await screen.findByText('账号数据已发生变化，请刷新后重试'),
    ).toBeInTheDocument()
    expect(screen.getByRole('dialog')).toBeInTheDocument()
    expect(onCancel).not.toHaveBeenCalled()
  })

  it('prevents duplicate submissions while pending', async () => {
    let resolveRequest: (response: Response) => void = () => undefined
    mockUpdateResponse(
      () =>
        new Promise((resolve) => {
          resolveRequest = resolve
        }),
    )
    renderModal()
    const user = userEvent.setup()

    await waitFor(() => {
      expect(screen.getByRole('button', { name: '保存' })).toBeEnabled()
    })
    const saveButton = screen.getByRole('button', { name: '保存' })
    await user.click(saveButton)
    await waitFor(() => expect(updateCalls()).toHaveLength(1))
    expect(saveButton).toBeDisabled()
    await user.click(saveButton)
    expect(updateCalls()).toHaveLength(1)

    resolveRequest(jsonResponse({ account: 'server-account' }))
    expect(await screen.findByText('账号修改成功')).toBeInTheDocument()
  })

  it('cancels without sending an update', async () => {
    const { onCancel } = renderModal()
    const user = userEvent.setup()

    await user.clear(screen.getByLabelText('金币'))
    await user.type(screen.getByLabelText('金币'), '10')
    await user.click(screen.getByRole('button', { name: '取消' }))

    expect(onCancel).toHaveBeenCalledOnce()
    expect(updateCalls()).toHaveLength(0)
  })

  it('disables editing when the privilege dictionary fails', async () => {
    fetchMock.mockResolvedValue(new Response(null, { status: 500 }))
    renderModal()

    expect(await screen.findByText('权限列表加载失败')).toBeInTheDocument()
    expect(screen.getByLabelText('权限')).toBeDisabled()
    expect(screen.getByRole('button', { name: '保存' })).toBeDisabled()
    expect(updateCalls()).toHaveLength(0)
  })
})
