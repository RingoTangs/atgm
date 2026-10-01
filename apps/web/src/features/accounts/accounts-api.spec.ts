import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import {
  AccountConflictError,
  getAccounts,
  getPrivileges,
  registerAccount,
} from './accounts-api'

const fetchMock = vi.fn<typeof fetch>()

const jsonResponse = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { 'Content-Type': 'application/json' },
  })

beforeEach(() => {
  fetchMock.mockReset()
  vi.stubGlobal('fetch', fetchMock)
})

afterEach(() => {
  vi.clearAllMocks()
  vi.unstubAllGlobals()
})

describe('accounts API', () => {
  it('requests an account page and returns the shared camelCase response', async () => {
    fetchMock.mockResolvedValue(
      jsonResponse({
        page: 2,
        pageSize: 10,
        total: 25,
        items: [
          {
            account: 'test_01',
            privilege: 100,
            goldCoin: 1_000_000,
            silverCoin: 50_000,
            lastLoginTime: '2026-10-01 19:12:00',
            lastLoginIp: '192.0.2.1',
            regDate: '2026-09-01 10:00:00',
          },
        ],
      }),
    )

    await expect(
      getAccounts({ page: 2, pageSize: 10, account: 'test_01' }),
    ).resolves.toEqual({
      page: 2,
      pageSize: 10,
      total: 25,
      items: [
        {
          account: 'test_01',
          privilege: 100,
          goldCoin: 1_000_000,
          silverCoin: 50_000,
          lastLoginTime: '2026-10-01 19:12:00',
          lastLoginIp: '192.0.2.1',
          regDate: '2026-09-01 10:00:00',
        },
      ],
    })

    const [url, init] = fetchMock.mock.calls[0]
    expect(url).toBe('/_api/accounts?page=2&pageSize=10&account=test_01')
    expect(init).toBeUndefined()
  })

  it('encodes account search values with URLSearchParams', async () => {
    fetchMock.mockResolvedValue(
      jsonResponse({ page: 1, pageSize: 20, total: 0, items: [] }),
    )

    await getAccounts({ page: 1, pageSize: 20, account: '100% & test' })

    expect(fetchMock).toHaveBeenCalledWith(
      '/_api/accounts?page=1&pageSize=20&account=100%25+%26+test',
    )
  })

  it('omits an empty account search', async () => {
    fetchMock.mockResolvedValue(
      jsonResponse({ page: 1, pageSize: 20, total: 0, items: [] }),
    )

    await getAccounts({ page: 1, pageSize: 20 })

    expect(fetchMock).toHaveBeenCalledWith('/_api/accounts?page=1&pageSize=20')
  })

  it('throws a generic error when loading accounts fails', async () => {
    fetchMock.mockResolvedValue(new Response(null, { status: 500 }))

    await expect(getAccounts({ page: 1, pageSize: 20 })).rejects.toThrow(
      '账号列表请求失败',
    )
  })

  it('requests and returns the shared privilege dictionary', async () => {
    const privileges = [
      {
        privilege: 120,
        grant: 'GA',
        constant: 'ADMINISTRATOR',
        type: '管理特权',
        description: '管理员',
      },
    ]
    fetchMock.mockResolvedValue(jsonResponse(privileges))

    await expect(getPrivileges()).resolves.toEqual(privileges)
    expect(fetchMock).toHaveBeenCalledWith('/_api/privileges')
  })

  it('throws a generic error when loading privileges fails', async () => {
    fetchMock.mockResolvedValue(new Response(null, { status: 500 }))

    await expect(getPrivileges()).rejects.toThrow('权限列表请求失败')
  })

  it('posts registration values as JSON', async () => {
    fetchMock.mockResolvedValue(jsonResponse({ account: 'new-account' }, 201))
    const values = {
      account: 'new-account',
      rawPassword: 'test-password',
      goldCoin: 100,
      silverCoin: 50,
      privilege: 10,
    }

    await expect(registerAccount(values)).resolves.toBeUndefined()
    expect(fetchMock).toHaveBeenCalledWith('/_api/account', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(values),
    })
  })

  it('maps HTTP 409 to AccountConflictError without parsing the body', async () => {
    fetchMock.mockResolvedValue(new Response(null, { status: 409 }))

    await expect(
      registerAccount({
        account: 'existing-account',
        rawPassword: 'test-password',
        goldCoin: 0,
        silverCoin: 0,
        privilege: 0,
      }),
    ).rejects.toBeInstanceOf(AccountConflictError)
  })

  it('keeps other registration failures as generic errors', async () => {
    fetchMock.mockResolvedValue(new Response(null, { status: 500 }))

    await expect(
      registerAccount({
        account: 'new-account',
        rawPassword: 'test-password',
        goldCoin: 0,
        silverCoin: 0,
        privilege: 0,
      }),
    ).rejects.toThrow('账号注册请求失败')
  })
})
