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

const validBody = {
  privilege: 120,
  goldCoin: 1_000_000,
  silverCoin: 50_000,
}

beforeEach(() => {
  vi.clearAllMocks()
  mocks.selectExecuteTakeFirst.mockResolvedValue(accountRow)
  mocks.onlineExecuteTakeFirst.mockResolvedValue(undefined)
  mocks.updateExecuteTakeFirst.mockResolvedValue({ numUpdatedRows: 1n })
})

afterAll(async () => {
  await app.close()
})

describe('patch /accounts/:account endpoint', () => {
  it('updates core fields and checksum using database values', async () => {
    const response = await app.inject({
      method: 'PATCH',
      url: '/accounts/example_user',
      payload: validBody,
    })
    const nextChecksum = createAccountChecksum({
      account: accountRow.account,
      password: accountRow.password,
      privilege: validBody.privilege,
      blockedTime: accountRow.blocked_time,
      goldCoin: validBody.goldCoin,
      silverCoin: validBody.silverCoin,
      coinPassword: accountRow.coin_password,
      unlockCoinPasswordTime: accountRow.unlock_coin_password_time,
      tradeLockTime: accountRow.trade_lock_time,
      permitIp: accountRow.permit_ip,
      permitId: accountRow.permit_id,
    })

    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({ account: 'example_user' })
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
    expect(mocks.onlineExecuteTakeFirst).toHaveBeenCalledOnce()
    expect(mocks.updateTable).toHaveBeenCalledWith('account')
    expect(mocks.set).toHaveBeenCalledWith({
      privilege: 120,
      gold_coin: 1_000_000,
      silver_coin: 50_000,
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
    expect(response.payload).not.toContain('password')
    expect(response.payload).not.toContain('checksum')
  })

  it('returns success without updating when core fields are unchanged', async () => {
    const response = await app.inject({
      method: 'PATCH',
      url: '/accounts/example_user',
      payload: {
        privilege: accountRow.privilege,
        goldCoin: accountRow.gold_coin,
        silverCoin: accountRow.silver_coin,
      },
    })

    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({ account: 'example_user' })
    expect(mocks.ddbSelectFrom).not.toHaveBeenCalled()
    expect(mocks.updateTable).not.toHaveBeenCalled()
    expect(mocks.updateExecuteTakeFirst).not.toHaveBeenCalled()
  })

  it('returns 404 when the account does not exist', async () => {
    mocks.selectExecuteTakeFirst.mockResolvedValue(undefined)

    const response = await app.inject({
      method: 'PATCH',
      url: '/accounts/missing-account',
      payload: validBody,
    })

    expect(response.statusCode).toBe(404)
    expect(response.json()).toEqual({ message: '账号不存在' })
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
      url: '/accounts/example_user',
      payload: validBody,
    })

    expect(response.statusCode).toBe(409)
    expect(response.json()).toEqual({ message: '账号数据校验失败' })
    expect(mocks.ddbSelectFrom).not.toHaveBeenCalled()
    expect(mocks.updateTable).not.toHaveBeenCalled()
  })

  it('returns 409 without updating when the account is online', async () => {
    mocks.onlineExecuteTakeFirst.mockResolvedValue({ name: accountRow.account })

    const response = await app.inject({
      method: 'PATCH',
      url: '/accounts/example_user',
      payload: validBody,
    })

    expect(response.statusCode).toBe(409)
    expect(response.json()).toEqual({
      message: '账号当前在线，无法修改',
    })
    expect(mocks.onlineExecuteTakeFirst).toHaveBeenCalledOnce()
    expect(mocks.updateTable).not.toHaveBeenCalled()
    expect(mocks.updateExecuteTakeFirst).not.toHaveBeenCalled()
  })

  it('returns 409 when the compare-and-swap update matches no rows', async () => {
    mocks.updateExecuteTakeFirst.mockResolvedValue({ numUpdatedRows: 0n })

    const response = await app.inject({
      method: 'PATCH',
      url: '/accounts/example_user',
      payload: validBody,
    })

    expect(response.statusCode).toBe(409)
    expect(response.json()).toEqual({
      message: '账号数据已发生变化，请重试',
    })
    expect(mocks.onlineExecuteTakeFirst).toHaveBeenCalledOnce()
  })

  it.each([
    ['missing privilege', { goldCoin: 1, silverCoin: 1 }],
    ['negative privilege', { ...validBody, privilege: -1 }],
    ['fractional privilege', { ...validBody, privilege: 1.5 }],
    ['excessive privilege', { ...validBody, privilege: 1001 }],
    ['negative goldCoin', { ...validBody, goldCoin: -1 }],
    ['excessive goldCoin', { ...validBody, goldCoin: 2_000_000_001 }],
    ['fractional silverCoin', { ...validBody, silverCoin: 1.5 }],
    ['extra field', { ...validBody, password: 'client-value' }],
  ])('rejects %s before querying the database', async (_case, body) => {
    const response = await app.inject({
      method: 'PATCH',
      url: '/accounts/example_user',
      payload: body,
    })

    expect(response.statusCode).toBe(400)
    expect(mocks.selectFrom).not.toHaveBeenCalled()
    expect(mocks.ddbSelectFrom).not.toHaveBeenCalled()
    expect(mocks.updateTable).not.toHaveBeenCalled()
  })
})
