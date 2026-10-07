import type { AccountDetailResponse } from '@atgm/contracts'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { cleanup, render, screen, waitFor } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { AccountPrivilegeModal } from './AccountPrivilegeModal'

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

const jsonResponse = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { 'Content-Type': 'application/json' },
  })

const mockUpdateResponse = (responseFactory: () => Promise<Response>) => {
  fetchMock.mockImplementation(() => {
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
      <AccountPrivilegeModal account={accountValue} onCancel={onCancel} open />
    </QueryClientProvider>,
  )

  return { onCancel }
}

describe('account privilege modal', () => {
  it('fills the form with current account values', async () => {
    renderModal()

    expect(
      screen.getByRole('dialog', { name: '变更权限：server-account' }),
    ).toBeInTheDocument()
    expect(screen.queryByLabelText('账号')).toBeNull()
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
    await user.click(screen.getByRole('button', { name: '保存' }))

    expect(await screen.findByText('权限变更成功')).toBeInTheDocument()
    expect(fetchMock).toHaveBeenCalledWith(
      '/_api/accounts/server-account/privilege',
      {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          privilege: 1000,
        }),
      },
    )
    expect(invalidateQueries).toHaveBeenCalledWith({
      queryKey: ['account', 'server-account'],
    })
    expect(invalidateQueries).toHaveBeenCalledWith({
      queryKey: ['accounts'],
    })
    expect(onCancel).toHaveBeenCalledOnce()
  })

  it.each([
    ['ACCOUNT_ONLINE', '账号当前在线，无法修改'],
    ['ACCOUNT_CHECKSUM_INVALID', '账号数据校验失败'],
    ['ACCOUNT_CONCURRENT_MODIFICATION', '账号数据已发生变化，请重试'],
  ])(
    'shows the server conflict message and keeps the modal open: %s',
    async (code, message) => {
      mockUpdateResponse(() =>
        Promise.resolve(jsonResponse({ code, message }, 409)),
      )
      const { onCancel } = renderModal()
      const user = userEvent.setup()

      await waitFor(() => {
        expect(screen.getByRole('button', { name: '保存' })).toBeEnabled()
      })
      await user.click(screen.getByRole('button', { name: '保存' }))

      expect(await screen.findByText(message)).toBeInTheDocument()
      expect(screen.getByRole('dialog')).toBeInTheDocument()
      expect(onCancel).not.toHaveBeenCalled()
    },
  )

  it('shows the not-found message and keeps the modal open', async () => {
    mockUpdateResponse(() =>
      Promise.resolve(
        jsonResponse({ code: 'ACCOUNT_NOT_FOUND', message: '账号不存在' }, 404),
      ),
    )
    const { onCancel } = renderModal()
    const user = userEvent.setup()

    await waitFor(() => {
      expect(screen.getByRole('button', { name: '保存' })).toBeEnabled()
    })
    await user.click(screen.getByRole('button', { name: '保存' }))

    expect(await screen.findByText('账号不存在')).toBeInTheDocument()
    expect(screen.getByRole('dialog')).toBeInTheDocument()
    expect(onCancel).not.toHaveBeenCalled()
  })

  it('shows the generic API error message and keeps the modal open', async () => {
    mockUpdateResponse(() =>
      Promise.resolve(new Response(null, { status: 500 })),
    )
    const { onCancel } = renderModal()
    const user = userEvent.setup()

    await waitFor(() => {
      expect(screen.getByRole('button', { name: '保存' })).toBeEnabled()
    })
    await user.click(screen.getByRole('button', { name: '保存' }))

    expect(await screen.findByText('权限变更请求失败')).toBeInTheDocument()
    expect(screen.getByRole('dialog')).toBeInTheDocument()
    expect(onCancel).not.toHaveBeenCalled()
  })

  it('shows the fallback message for an unknown error', async () => {
    const unknownError: unknown = undefined
    mockUpdateResponse(() => Promise.reject(unknownError))
    const { onCancel } = renderModal()
    const user = userEvent.setup()

    await waitFor(() => {
      expect(screen.getByRole('button', { name: '保存' })).toBeEnabled()
    })
    await user.click(screen.getByRole('button', { name: '保存' }))

    expect(
      await screen.findByText('权限变更失败，请稍后重试'),
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
    expect(await screen.findByText('权限变更成功')).toBeInTheDocument()
  })

  it('cancels without sending an update', async () => {
    const { onCancel } = renderModal()
    const user = userEvent.setup()

    await user.click(screen.getByRole('button', { name: '取消' }))

    expect(onCancel).toHaveBeenCalledOnce()
    expect(updateCalls()).toHaveLength(0)
  })
})
