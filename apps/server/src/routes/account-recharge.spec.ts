import { afterAll, beforeEach, describe, expect, it, vi } from 'vitest'
import { buildApp } from '../app'
import { registerDatabase } from '../db'
import { parseServerEnv } from '../env'
import { createAccountChecksum } from '../lib/account-crypto'

const checksumFields = [
  'account',
  'password',
  'privilege',
  'blocked_time',
  'gold_coin',
  'silver_coin',
  'coin_password',
  'unlock_coin_password_time',
  'trade_lock_time',
  'permit_ip',
  'permit_id',
  'checksum',
]

const mocks = vi.hoisted(() => {
  const selectExecuteTakeFirst = vi.fn()
  const selectWhere = vi.fn(() => ({
    executeTakeFirst: selectExecuteTakeFirst,
  }))
  const select = vi.fn(() => ({ where: selectWhere }))
  const selectFrom = vi.fn(() => ({ select }))

  const onlineExecuteTakeFirst = vi.fn()
  const onlineNameWhere = vi.fn(() => ({
    executeTakeFirst: onlineExecuteTakeFirst,
  }))
  const onlinePathWhere = vi.fn(() => ({ where: onlineNameWhere }))
  const onlineSelect = vi.fn(() => ({ where: onlinePathWhere }))
  const ddbSelectFrom = vi.fn(() => ({ select: onlineSelect }))

  const updateExecuteTakeFirst = vi.fn()
  const checksumWhere = vi.fn(() => ({
    executeTakeFirst: updateExecuteTakeFirst,
  }))
  const accountWhere = vi.fn(() => ({ where: checksumWhere }))
  const set = vi.fn(() => ({ where: accountWhere }))
  const updateTable = vi.fn(() => ({ set }))

  return {
    accountWhere,
    checksumWhere,
    ddbSelectFrom,
    onlineExecuteTakeFirst,
    onlineNameWhere,
    onlinePathWhere,
    onlineSelect,
    select,
    selectExecuteTakeFirst,
    selectFrom,
    selectWhere,
    set,
    updateExecuteTakeFirst,
    updateTable,
  }
})

vi.mock('../db', () => ({
  registerDatabase: (app: {
    decorate: (name: string, value: unknown) => void
  }) => {
    app.decorate('db', {
      adb: {
        selectFrom: mocks.selectFrom,
        updateTable: mocks.updateTable,
      },
      ddb: {
        selectFrom: mocks.ddbSelectFrom,
      },
    })
  },
}))

vi.stubEnv('NODE_ENV', 'development')
const app = buildApp()
vi.unstubAllEnvs()

registerDatabase(
  app,
  parseServerEnv({
    MYSQL_HOST: '127.0.0.1',
    MYSQL_USER: 'atgm',
    MYSQL_PASSWORD: 'password',
  }),
)

const accountRow = {
  account: 'example_user',
  password: 'PASSWORD_HASH',
  privilege: 100,
  blocked_time: '20261002153045',
  gold_coin: 10,
  silver_coin: 20,
  coin_password: 'COIN_HASH',
  unlock_coin_password_time: '20261003120000',
  trade_lock_time: '20261004120000',
  permit_ip: '192.0.2.1',
  permit_id: 'device-01',
  checksum: '',
}

accountRow.checksum = createAccountChecksum({
  account: accountRow.account,
  password: accountRow.password,
  privilege: accountRow.privilege,
  blockedTime: accountRow.blocked_time,
  goldCoin: accountRow.gold_coin,
  silverCoin: accountRow.silver_coin,
  coinPassword: accountRow.coin_password,
  unlockCoinPasswordTime: accountRow.unlock_coin_password_time,
  tradeLockTime: accountRow.trade_lock_time,
  permitIp: accountRow.permit_ip,
  permitId: accountRow.permit_id,
})

beforeEach(() => {
  vi.clearAllMocks()
  mocks.selectExecuteTakeFirst.mockResolvedValue(accountRow)
  mocks.onlineExecuteTakeFirst.mockResolvedValue(undefined)
  mocks.updateExecuteTakeFirst.mockResolvedValue({ numUpdatedRows: 1n })
})

afterAll(async () => {
  await app.close()
})

describe('patch /accounts/:account/recharge endpoint', () => {
  it.each([
    'selectExecuteTakeFirst',
    'onlineExecuteTakeFirst',
    'updateExecuteTakeFirst',
  ] as const)(
    'returns a shared internal error when %s fails',
    async (operation) => {
      mocks[operation].mockRejectedValueOnce(new Error('database unavailable'))

      const response = await app.inject({
        method: 'PATCH',
        url: '/accounts/example_user/recharge',
        payload: { goldCoinAmount: 500, silverCoinAmount: 0 },
      })

      expect(response.statusCode).toBe(500)
      expect(response.json()).toEqual({
        code: 'INTERNAL_SERVER_ERROR',
        message: 'Internal Server Error',
      })
    },
  )

  it('recharges only gold coins and updates only balances and checksum', async () => {
    const response = await app.inject({
      method: 'PATCH',
      url: '/accounts/example_user/recharge',
      payload: { goldCoinAmount: 500, silverCoinAmount: 0 },
    })
    const nextChecksum = createAccountChecksum({
      account: accountRow.account,
      password: accountRow.password,
      privilege: accountRow.privilege,
      blockedTime: accountRow.blocked_time,
      goldCoin: 510,
      silverCoin: 20,
      coinPassword: accountRow.coin_password,
      unlockCoinPasswordTime: accountRow.unlock_coin_password_time,
      tradeLockTime: accountRow.trade_lock_time,
      permitIp: accountRow.permit_ip,
      permitId: accountRow.permit_id,
    })

    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      account: 'example_user',
      goldCoin: 510,
      silverCoin: 20,
    })
    expect(mocks.selectFrom).toHaveBeenCalledWith('account')
    expect(mocks.select).toHaveBeenCalledWith(checksumFields)
    expect(mocks.selectWhere).toHaveBeenCalledWith(
      'account',
      '=',
      'example_user',
    )
    expect(mocks.ddbSelectFrom).toHaveBeenCalledWith('data')
    expect(mocks.onlineSelect).toHaveBeenCalledWith('name')
    expect(mocks.onlinePathWhere).toHaveBeenCalledWith('path', '=', 'runtime')
    expect(mocks.onlineNameWhere).toHaveBeenCalledWith(
      'name',
      '=',
      'example_user',
    )
    expect(mocks.set).toHaveBeenCalledWith({
      gold_coin: 510,
      silver_coin: 20,
      checksum: nextChecksum,
    })
    expect(mocks.accountWhere).toHaveBeenCalledWith(
      'account',
      '=',
      'example_user',
    )
    expect(mocks.checksumWhere).toHaveBeenCalledWith(
      'checksum',
      '=',
      accountRow.checksum,
    )
  })

  it('recharges only silver coins', async () => {
    const response = await app.inject({
      method: 'PATCH',
      url: '/accounts/example_user/recharge',
      payload: { goldCoinAmount: 0, silverCoinAmount: 500 },
    })

    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      account: 'example_user',
      goldCoin: 10,
      silverCoin: 520,
    })
  })

  it('recharges gold and silver coins together', async () => {
    const response = await app.inject({
      method: 'PATCH',
      url: '/accounts/example_user/recharge',
      payload: { goldCoinAmount: 500, silverCoinAmount: 600 },
    })

    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      account: 'example_user',
      goldCoin: 510,
      silverCoin: 620,
    })
  })

  it('returns 404 when the account does not exist', async () => {
    mocks.selectExecuteTakeFirst.mockResolvedValue(undefined)

    const response = await app.inject({
      method: 'PATCH',
      url: '/accounts/missing-account/recharge',
      payload: { goldCoinAmount: 1, silverCoinAmount: 0 },
    })

    expect(response.statusCode).toBe(404)
    expect(response.json()).toEqual({
      code: 'ACCOUNT_NOT_FOUND',
      message: '账号不存在',
    })
    expect(mocks.ddbSelectFrom).not.toHaveBeenCalled()
    expect(mocks.updateTable).not.toHaveBeenCalled()
  })

  it('returns 409 when the stored checksum is invalid', async () => {
    mocks.selectExecuteTakeFirst.mockResolvedValue({
      ...accountRow,
      checksum: 'INVALID_CHECKSUM',
    })

    const response = await app.inject({
      method: 'PATCH',
      url: '/accounts/example_user/recharge',
      payload: { goldCoinAmount: 1, silverCoinAmount: 0 },
    })

    expect(response.statusCode).toBe(409)
    expect(response.json()).toEqual({
      code: 'ACCOUNT_CHECKSUM_INVALID',
      message: '账号数据校验失败',
    })
    expect(mocks.ddbSelectFrom).not.toHaveBeenCalled()
    expect(mocks.updateTable).not.toHaveBeenCalled()
  })

  it('returns 409 without updating when the account is online', async () => {
    mocks.onlineExecuteTakeFirst.mockResolvedValue({ name: accountRow.account })

    const response = await app.inject({
      method: 'PATCH',
      url: '/accounts/example_user/recharge',
      payload: { goldCoinAmount: 1, silverCoinAmount: 0 },
    })

    expect(response.statusCode).toBe(409)
    expect(response.json()).toEqual({
      code: 'ACCOUNT_ONLINE',
      message: '账号当前在线，无法修改',
    })
    expect(mocks.onlineExecuteTakeFirst).toHaveBeenCalledOnce()
    expect(mocks.updateTable).not.toHaveBeenCalled()
  })

  it('allows the recharged balance to equal 2 billion', async () => {
    const response = await app.inject({
      method: 'PATCH',
      url: '/accounts/example_user/recharge',
      payload: {
        goldCoinAmount: 1_999_999_990,
        silverCoinAmount: 1_999_999_980,
      },
    })

    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      account: 'example_user',
      goldCoin: 2_000_000_000,
      silverCoin: 2_000_000_000,
    })
  })

  it.each([
    ['gold balance', { goldCoinAmount: 1_999_999_991, silverCoinAmount: 0 }],
    ['silver balance', { goldCoinAmount: 0, silverCoinAmount: 1_999_999_981 }],
  ])(
    'returns 409 when the recharged %s exceeds 2 billion',
    async (_case, body) => {
      const response = await app.inject({
        method: 'PATCH',
        url: '/accounts/example_user/recharge',
        payload: body,
      })

      expect(response.statusCode).toBe(409)
      expect(response.json()).toEqual({
        code: 'ACCOUNT_COIN_LIMIT_EXCEEDED',
        message: '充值后金币或银币不能超过 20 亿',
      })
      expect(mocks.updateTable).not.toHaveBeenCalled()
    },
  )

  it('returns 409 when the compare-and-swap update matches no rows', async () => {
    mocks.updateExecuteTakeFirst.mockResolvedValue({ numUpdatedRows: 0n })

    const response = await app.inject({
      method: 'PATCH',
      url: '/accounts/example_user/recharge',
      payload: { goldCoinAmount: 1, silverCoinAmount: 0 },
    })

    expect(response.statusCode).toBe(409)
    expect(response.json()).toEqual({
      code: 'ACCOUNT_CONCURRENT_MODIFICATION',
      message: '账号数据已发生变化，请重试',
    })
  })

  it.each([
    ['both amounts are zero', { goldCoinAmount: 0, silverCoinAmount: 0 }],
    ['negative gold amount', { goldCoinAmount: -1, silverCoinAmount: 0 }],
    ['negative silver amount', { goldCoinAmount: 0, silverCoinAmount: -1 }],
    ['fractional gold amount', { goldCoinAmount: 1.5, silverCoinAmount: 0 }],
    ['fractional silver amount', { goldCoinAmount: 0, silverCoinAmount: 1.5 }],
    [
      'excessive amount',
      { goldCoinAmount: 2_000_000_001, silverCoinAmount: 0 },
    ],
  ])('rejects %s before querying the database', async (_case, body) => {
    const response = await app.inject({
      method: 'PATCH',
      url: '/accounts/example_user/recharge',
      payload: body,
    })

    expect(response.statusCode).toBe(400)
    expect(response.json()).toEqual({
      code: 'VALIDATION_ERROR',
      message: expect.any(String),
    })
    expect(mocks.selectFrom).not.toHaveBeenCalled()
    expect(mocks.ddbSelectFrom).not.toHaveBeenCalled()
    expect(mocks.updateTable).not.toHaveBeenCalled()
  })
})
