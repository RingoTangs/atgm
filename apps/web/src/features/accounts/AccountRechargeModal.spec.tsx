import type { AccountDetailResponse } from '@atgm/contracts'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { cleanup, render, screen, waitFor } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { AccountRechargeModal } from './AccountRechargeModal'

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
      <AccountRechargeModal account={accountValue} onCancel={onCancel} open />
    </QueryClientProvider>,
  )

  return { onCancel }
}

describe('account recharge modal', () => {
  it('starts with zero amounts and shows current balances', () => {
    renderModal()
    expect(screen.getByLabelText('金币充值数量')).toHaveValue('0')
    expect(screen.getByLabelText('银币充值数量')).toHaveValue('0')
    expect(
      screen.getByText('当前金币：1,000,000，当前银币：50,000'),
    ).toBeInTheDocument()
    expect(screen.getByLabelText('金币充值数量')).toHaveAttribute(
      'aria-valuemin',
      '0',
    )
    expect(screen.getByLabelText('金币充值数量')).toHaveAttribute(
      'aria-valuemax',
      '2000000000',
    )
  })

  it('rejects two zero amounts without sending a request', async () => {
    renderModal()
    const user = userEvent.setup()
    await user.click(screen.getByRole('button', { name: '充值' }))
    expect(
      await screen.findByText('金币和银币充值数量不能同时为 0'),
    ).toBeInTheDocument()
    expect(updateCalls()).toHaveLength(0)
  })

  it.each(['金币充值数量', '银币充值数量'])(
    'rejects fractional %s',
    async (label) => {
      renderModal()
      const user = userEvent.setup()
      await user.clear(screen.getByLabelText(label))
      await user.type(screen.getByLabelText(label), '1.5')
      await user.click(screen.getByRole('button', { name: '充值' }))
      expect(
        await screen.findByText(`${label}必须是 0～2,000,000,000 的整数`),
      ).toBeInTheDocument()
      expect(updateCalls()).toHaveLength(0)
    },
  )

  it('patches an amount without checking the resulting balance, refreshes queries and closes', async () => {
    const invalidateQueries = vi.spyOn(queryClient, 'invalidateQueries')
    const { onCancel } = renderModal()
    const user = userEvent.setup()
    await user.clear(screen.getByLabelText('金币充值数量'))
    await user.type(screen.getByLabelText('金币充值数量'), '2000000000')
    await user.click(screen.getByRole('button', { name: '充值' }))
    expect(await screen.findByText('充值成功')).toBeInTheDocument()
    expect(fetchMock).toHaveBeenCalledWith(
      '/_api/accounts/server-account/recharge',
      {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          goldCoinAmount: 2_000_000_000,
          silverCoinAmount: 0,
        }),
      },
    )
    expect(invalidateQueries).toHaveBeenCalledWith({
      queryKey: ['account', 'server-account'],
    })
    expect(invalidateQueries).toHaveBeenCalledWith({ queryKey: ['accounts'] })
    expect(onCancel).toHaveBeenCalledOnce()
  })

  it.each([
    ['ACCOUNT_COIN_LIMIT_EXCEEDED', '充值后金币或银币不能超过 20 亿', 409],
    ['ACCOUNT_ONLINE', '账号当前在线，无法修改', 409],
    ['ACCOUNT_CHECKSUM_INVALID', '账号数据校验失败', 409],
    ['ACCOUNT_CONCURRENT_MODIFICATION', '账号数据已发生变化，请重试', 409],
    ['ACCOUNT_NOT_FOUND', '新的账号不存在提示', 404],
    ['INTERNAL_SERVER_ERROR', 'Internal Server Error', 500],
  ])(
    'shows the server message for %s and retains input',
    async (code, message, status) => {
      mockUpdateResponse(() =>
        Promise.resolve(jsonResponse({ code, message }, status)),
      )
      const { onCancel } = renderModal()
      const user = userEvent.setup()
      await user.clear(screen.getByLabelText('银币充值数量'))
      await user.type(screen.getByLabelText('银币充值数量'), '10')
      await user.click(screen.getByRole('button', { name: '充值' }))
      expect(await screen.findByText(message)).toBeInTheDocument()
      expect(screen.getByLabelText('银币充值数量')).toHaveValue('10')
      expect(onCancel).not.toHaveBeenCalled()
    },
  )

  it('blocks repeated submission and cancellation while pending', async () => {
    let resolveRequest: (response: Response) => void = () => undefined
    mockUpdateResponse(
      () =>
        new Promise((resolve) => {
          resolveRequest = resolve
        }),
    )
    const { onCancel } = renderModal()
    const user = userEvent.setup()
    await user.clear(screen.getByLabelText('金币充值数量'))
    await user.type(screen.getByLabelText('金币充值数量'), '10')
    const submit = screen.getByRole('button', { name: '充值' })
    await user.click(submit)
    await waitFor(() => expect(updateCalls()).toHaveLength(1))
    expect(submit).toBeDisabled()
    expect(screen.getByRole('button', { name: '取消' })).toBeDisabled()
    await user.click(submit)
    expect(updateCalls()).toHaveLength(1)
    expect(onCancel).not.toHaveBeenCalled()
    resolveRequest(
      jsonResponse({
        account: account.account,
        goldCoin: 1000010,
        silverCoin: 50000,
      }),
    )
    expect(await screen.findByText('充值成功')).toBeInTheDocument()
  })
})
