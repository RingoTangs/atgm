import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { ApiError } from '@/lib/apiError'
import {
  getAccount,
  getAccountCharacters,
  getAccounts,
  rechargeAccount,
  registerAccount,
  updateAccountPrivilege,
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
  it.each([
    [
      'privilege update',
      () => updateAccountPrivilege('test', { privilege: 0 }),
    ],
    [
      'recharge',
      () => rechargeAccount('test', { goldCoinAmount: 1, silverCoinAmount: 0 }),
    ],
    ['detail', () => getAccount('test')],
    ['characters', () => getAccountCharacters('test')],
    ['list', () => getAccounts({ page: 1, pageSize: 20 })],
    [
      'registration',
      () =>
        registerAccount({
          account: 'test',
          rawPassword: 'password',
          goldCoin: 0,
          silverCoin: 0,
          privilege: 0,
        }),
    ],
  ])('preserves the shared error for %s requests', async (_name, request) => {
    fetchMock.mockResolvedValue(
      jsonResponse(
        { code: 'INTERNAL_SERVER_ERROR', message: 'Internal Server Error' },
        500,
      ),
    )

    const result = request()
    await expect(result).rejects.toBeInstanceOf(ApiError)
    await expect(result).rejects.toMatchObject({
      code: 'INTERNAL_SERVER_ERROR',
      message: 'Internal Server Error',
      status: 500,
    })
  })

  it.each([
    { code: 'ACCOUNT_NOT_FOUND', message: '新的账号不存在提示', status: 404 },
    { code: 'ROUTE_NOT_FOUND', message: '账号不存在', status: 404 },
    { code: 'ACCOUNT_ONLINE', message: '账号已存在', status: 409 },
    { code: 'FUTURE_ERROR', message: '新错误提示', status: 409 },
    { code: 'VALIDATION_ERROR', message: '参数错误', status: 400 },
  ])(
    'preserves $code independently of message and HTTP status',
    async ({ code, message, status }) => {
      fetchMock.mockResolvedValue(jsonResponse({ code, message }, status))

      await expect(getAccount('test')).rejects.toMatchObject({
        code,
        message,
        status,
      })
    },
  )

  it.each([
    ['empty body', () => new Response(null, { status: 404 })],
    [
      'non-JSON body',
      () => new Response('<html>error</html>', { status: 409 }),
    ],
    ['missing code', () => jsonResponse({ message: '账号不存在' }, 404)],
    [
      'invalid message',
      () => jsonResponse({ code: 'ACCOUNT_NOT_FOUND', message: null }, 404),
    ],
  ])('uses the existing fallback for %s', async (_name, createResponse) => {
    fetchMock.mockImplementation(async () => createResponse())

    await expect(getAccount('test')).rejects.toThrow('账号详情请求失败')
    await expect(getAccount('test')).rejects.not.toBeInstanceOf(ApiError)
  })

  it('does not classify network failures as business errors', async () => {
    const error = new TypeError('Failed to fetch')
    fetchMock.mockRejectedValue(error)

    await expect(getAccount('test')).rejects.toBe(error)
  })

  it.each([
    {
      name: 'recharge',
      request: () =>
        rechargeAccount('test/user', {
          goldCoinAmount: 10,
          silverCoinAmount: 0,
        }),
      values: { goldCoinAmount: 10, silverCoinAmount: 0 },
      response: { account: 'test/user', goldCoin: 20, silverCoin: 30 },
      fallback: '账号充值请求失败',
    },
    {
      name: 'privilege',
      request: () => updateAccountPrivilege('test/user', { privilege: 120 }),
      values: { privilege: 120 },
      response: { account: 'test/user', privilege: 120 },
      fallback: '权限变更请求失败',
    },
  ])(
    'patches encoded $name values and preserves errors',
    async ({ name, request, values, response, fallback }) => {
      fetchMock.mockResolvedValue(jsonResponse(response))
      await expect(request()).resolves.toEqual(response)
      expect(fetchMock).toHaveBeenCalledWith(
        `/_api/accounts/test%2Fuser/${name}`,
        {
          method: 'PATCH',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(values),
        },
      )
      for (const status of [404, 409, 500]) {
        fetchMock.mockResolvedValue(
          jsonResponse(
            { code: 'ACCOUNT_NOT_FOUND', message: '服务端错误提示' },
            status,
          ),
        )
        await expect(request()).rejects.toMatchObject({
          code: 'ACCOUNT_NOT_FOUND',
          message: '服务端错误提示',
          status,
        })
      }
      fetchMock.mockResolvedValue(new Response(null, { status: 500 }))
      await expect(request()).rejects.toThrow(fallback)
    },
  )

  it('requests an encoded account detail and returns the shared response', async () => {
    const account = {
      account: 'test/user',
      privilege: 120,
      goldCoin: 1_000_000,
      silverCoin: 50_000,
      blockedTime: '',
      blockedReason: '',
      tempBlockedTime: '',
      tempBlockedReason: '',
      firstLoginTime: '2026-09-01 11:00:00',
      firstLoginMac: '00:11:22:33:44:55',
      lastLoginTime: '2026-10-01 19:12:00',
      lastLoginIp: '192.0.2.1',
      lastLoginId: 'device-01',
      regDate: '2026-09-01 10:00:00',
    }
    fetchMock.mockResolvedValue(jsonResponse(account))

    await expect(getAccount('test/user')).resolves.toEqual(account)
    expect(fetchMock).toHaveBeenCalledWith('/_api/accounts/test%2Fuser')
  })

  it('preserves the account-not-found code for a detail request', async () => {
    fetchMock.mockResolvedValue(
      jsonResponse({ code: 'ACCOUNT_NOT_FOUND', message: '账号不存在' }, 404),
    )

    await expect(getAccount('missing-account')).rejects.toMatchObject({
      code: 'ACCOUNT_NOT_FOUND',
      status: 404,
    })
  })

  it('keeps other account detail failures as generic errors', async () => {
    fetchMock.mockResolvedValue(new Response(null, { status: 500 }))

    await expect(getAccount('test')).rejects.toThrow('账号详情请求失败')
  })

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

  it('preserves the duplicate-account code for registration', async () => {
    fetchMock.mockResolvedValue(
      jsonResponse(
        { code: 'ACCOUNT_ALREADY_EXISTS', message: '账号已存在' },
        409,
      ),
    )

    await expect(
      registerAccount({
        account: 'existing-account',
        rawPassword: 'test-password',
        goldCoin: 0,
        silverCoin: 0,
        privilege: 0,
      }),
    ).rejects.toMatchObject({ code: 'ACCOUNT_ALREADY_EXISTS', status: 409 })
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

describe('account characters API', () => {
  it('requests encoded accounts and returns recRole and chars', async () => {
    const response = {
      recRole: '0000000000000003',
      chars: [
        {
          gid: '0000000000000003',
          name: '女金',
          polar: 1,
          gender: 2,
          time: '',
        },
      ],
    }
    fetchMock.mockResolvedValue(jsonResponse(response))
    await expect(getAccountCharacters('server/account')).resolves.toEqual(
      response,
    )
    expect(fetchMock).toHaveBeenCalledWith(
      '/_api/accounts/server%2Faccount/characters',
    )
  })
  it.each([404, 500])(
    'uses the characters fallback for HTTP %s',
    async (status) => {
      fetchMock.mockResolvedValue(new Response(null, { status }))
      await expect(getAccountCharacters('test')).rejects.toThrow(
        '账号关联角色请求失败',
      )
    },
  )
})
