import type { Dialect, RawBuilder } from 'kysely'
import {
  DummyDriver,
  Kysely,
  MysqlAdapter,
  MysqlIntrospector,
  MysqlQueryCompiler,
} from 'kysely'
import { afterAll, beforeEach, describe, expect, it, vi } from 'vitest'
import { buildApp } from '../app'
import { registerDatabase } from '../db'
import { parseServerEnv } from '../env'

const accountFields = [
  'account',
  'privilege',
  'gold_coin',
  'silver_coin',
  'last_login_time',
  'last_login_ip',
  'reg_date',
]

const accountDetailFields = [
  'account',
  'privilege',
  'gold_coin',
  'silver_coin',
  'blocked_time',
  'blocked_reason',
  'temp_blocked_time',
  'temp_blocked_reason',
  'first_login_time',
  'first_login_mac',
  'last_login_time',
  'last_login_ip',
  'last_login_id',
  'reg_date',
]

const privateAccountFields = [
  'password',
  'org_password',
  'coin_password',
  'checksum',
  'id_num',
  'tel',
  'mobile',
  'email',
]

const mocks = vi.hoisted(() => {
  const itemsExecute = vi.fn()
  const countExecuteTakeFirstOrThrow = vi.fn()
  const detailExecuteTakeFirst = vi.fn()
  const onlineExecute = vi.fn()
  const offset = vi.fn(() => ({ execute: itemsExecute }))
  const limit = vi.fn(() => ({ offset }))
  const orderBy = vi.fn(() => ({ limit }))
  const itemsWhere = vi.fn((_predicate: RawBuilder<boolean>) => ({ orderBy }))
  const countWhere = vi.fn((_predicate: RawBuilder<boolean>) => ({
    executeTakeFirstOrThrow: countExecuteTakeFirstOrThrow,
  }))
  const detailWhere = vi.fn(() => ({
    executeTakeFirst: detailExecuteTakeFirst,
  }))
  const select = vi.fn((selection: unknown) =>
    Array.isArray(selection)
      ? selection.includes('blocked_time')
        ? { where: detailWhere }
        : { orderBy, where: itemsWhere }
      : {
          executeTakeFirstOrThrow: countExecuteTakeFirstOrThrow,
          where: countWhere,
        },
  )
  const selectFrom = vi.fn(() => ({ select }))
  const onlineNamesWhere = vi.fn(() => ({ execute: onlineExecute }))
  const onlinePathWhere = vi.fn(() => ({ where: onlineNamesWhere }))
  const onlineSelect = vi.fn(() => ({ where: onlinePathWhere }))
  const ddbSelectFrom = vi.fn(() => ({ select: onlineSelect }))

  return {
    countExecuteTakeFirstOrThrow,
    countWhere,
    detailExecuteTakeFirst,
    detailWhere,
    ddbSelectFrom,
    itemsExecute,
    itemsWhere,
    limit,
    offset,
    onlineExecute,
    onlineNamesWhere,
    onlinePathWhere,
    onlineSelect,
    orderBy,
    select,
    selectFrom,
  }
})

vi.mock('../db', () => ({
  registerDatabase: (app: {
    decorate: (name: string, value: unknown) => void
  }) => {
    app.decorate('db', {
      adb: { selectFrom: mocks.selectFrom },
      ddb: { selectFrom: mocks.ddbSelectFrom },
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

const accountItem = {
  account: 'example_user',
  privilege: 100,
  gold_coin: 1_000_000,
  silver_coin: 50_000,
  last_login_time: '20260928120000',
  last_login_ip: '192.0.2.1',
  reg_date: '20260901100000',
}

const accountResponseItem = {
  account: 'example_user',
  online: true,
  privilege: 100,
  goldCoin: 1_000_000,
  silverCoin: 50_000,
  lastLoginTime: '2026-09-28 12:00:00',
  lastLoginIp: '192.0.2.1',
  regDate: '2026-09-01 10:00:00',
}

const accountDetailItem = {
  account: 'example_user',
  privilege: 120,
  gold_coin: 1_000_000,
  silver_coin: 50_000,
  blocked_time: '20261002153045',
  blocked_reason: '违规行为',
  temp_blocked_time: '20261003120000',
  temp_blocked_reason: '临时限制',
  first_login_time: '20260901110000',
  first_login_mac: '00:11:22:33:44:55',
  last_login_time: '20261001191200',
  last_login_ip: '192.0.2.1',
  last_login_id: 'device-01',
  reg_date: '20260901100000',
}

interface LikeTestDatabase {
  account: {
    account: string
  }
}

const mysqlCompileDialect: Dialect = {
  createAdapter: () => new MysqlAdapter(),
  createDriver: () => new DummyDriver(),
  createIntrospector: (database) => new MysqlIntrospector(database),
  createQueryCompiler: () => new MysqlQueryCompiler(),
}

const compileDatabase = new Kysely<LikeTestDatabase>({
  dialect: mysqlCompileDialect,
})

beforeEach(() => {
  vi.clearAllMocks()
  mocks.countExecuteTakeFirstOrThrow.mockResolvedValue({ total: '125' })
  mocks.itemsExecute.mockResolvedValue([accountItem])
  mocks.detailExecuteTakeFirst.mockResolvedValue(accountDetailItem)
  mocks.onlineExecute.mockResolvedValue([{ name: accountItem.account }])
})

afterAll(async () => {
  await app.close()
  await compileDatabase.destroy()
})

describe('get /accounts endpoint', () => {
  it('uses default pagination and returns the public account fields', async () => {
    const response = await app.inject({
      method: 'GET',
      url: '/accounts',
    })

    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      page: 1,
      pageSize: 20,
      total: 125,
      items: [accountResponseItem],
    })
    expect(mocks.selectFrom).toHaveBeenCalledTimes(2)
    expect(mocks.selectFrom).toHaveBeenCalledWith('account')
    expect(mocks.select).toHaveBeenCalledWith(accountFields)
    expect(mocks.select).toHaveBeenCalledWith(expect.any(Function))
    expect(mocks.orderBy).toHaveBeenCalledWith('account')
    expect(mocks.limit).toHaveBeenCalledWith(20)
    expect(mocks.offset).toHaveBeenCalledWith(0)
    expect(mocks.itemsExecute).toHaveBeenCalledOnce()
    expect(mocks.countExecuteTakeFirstOrThrow).toHaveBeenCalledOnce()
    expect(mocks.ddbSelectFrom).toHaveBeenCalledOnce()
    expect(mocks.ddbSelectFrom).toHaveBeenCalledWith('data')
    expect(mocks.onlineSelect).toHaveBeenCalledWith('name')
    expect(mocks.onlinePathWhere).toHaveBeenCalledWith('path', '=', 'runtime')
    expect(mocks.onlineNamesWhere).toHaveBeenCalledWith('name', 'in', [
      'example_user',
    ])
    expect(mocks.onlineExecute).toHaveBeenCalledOnce()
    for (const privateField of privateAccountFields) {
      expect(response.payload).not.toContain(privateField)
    }
  })

  it('returns offline when no runtime record exists', async () => {
    mocks.onlineExecute.mockResolvedValue([])

    const response = await app.inject({
      method: 'GET',
      url: '/accounts',
    })

    expect(response.statusCode).toBe(200)
    expect(response.json().items[0]).toMatchObject({
      account: 'example_user',
      online: false,
    })
  })

  it('queries online status once for all accounts on the current page', async () => {
    const offlineAccount = {
      ...accountItem,
      account: 'offline_user',
    }
    mocks.itemsExecute.mockResolvedValue([accountItem, offlineAccount])

    const response = await app.inject({
      method: 'GET',
      url: '/accounts',
    })

    expect(response.statusCode).toBe(200)
    expect(response.json().items).toEqual([
      accountResponseItem,
      {
        ...accountResponseItem,
        account: 'offline_user',
        online: false,
      },
    ])
    expect(mocks.ddbSelectFrom).toHaveBeenCalledOnce()
    expect(mocks.onlineNamesWhere).toHaveBeenCalledOnce()
    expect(mocks.onlineNamesWhere).toHaveBeenCalledWith('name', 'in', [
      'example_user',
      'offline_user',
    ])
    expect(mocks.onlineExecute).toHaveBeenCalledOnce()
  })

  it('skips the DDB query when the current page is empty', async () => {
    mocks.countExecuteTakeFirstOrThrow.mockResolvedValue({ total: '0' })
    mocks.itemsExecute.mockResolvedValue([])

    const response = await app.inject({
      method: 'GET',
      url: '/accounts',
    })

    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      page: 1,
      pageSize: 20,
      total: 0,
      items: [],
    })
    expect(mocks.ddbSelectFrom).not.toHaveBeenCalled()
    expect(mocks.onlineExecute).not.toHaveBeenCalled()
  })

  it('coerces valid pagination strings and calculates the offset', async () => {
    const response = await app.inject({
      method: 'GET',
      url: '/accounts?page=2&pageSize=10',
    })

    expect(response.statusCode).toBe(200)
    expect(response.json()).toMatchObject({ page: 2, pageSize: 10 })
    expect(mocks.limit).toHaveBeenCalledWith(10)
    expect(mocks.offset).toHaveBeenCalledWith(10)
  })

  it('accepts the maximum page size', async () => {
    const response = await app.inject({
      method: 'GET',
      url: '/accounts?pageSize=100',
    })

    expect(response.statusCode).toBe(200)
    expect(mocks.limit).toHaveBeenCalledWith(100)
  })

  it('preserves empty account times in the response', async () => {
    mocks.itemsExecute.mockResolvedValue([
      { ...accountItem, last_login_time: '', reg_date: '' },
    ])

    const response = await app.inject({
      method: 'GET',
      url: '/accounts',
    })

    expect(response.statusCode).toBe(200)
    expect(response.json().items[0]).toMatchObject({
      lastLoginTime: '',
      regDate: '',
    })
  })

  it.each([
    ['普通文本', '%20test%20', '%test%'],
    ['下划线', 'test_01', '%test!_01%'],
    ['百分号', '100%25', '%100!%%'],
    ['感叹号', 'abc!def', '%abc!!def%'],
    ['反斜杠', 'abc%5Cdef', '%abc\\def%'],
  ])(
    'escapes LIKE special characters for %s searches',
    async (_case, account, expectedPattern) => {
      const response = await app.inject({
        method: 'GET',
        url: `/accounts?account=${account}`,
      })

      expect(response.statusCode).toBe(200)
      const itemsPredicate = mocks.itemsWhere.mock.calls[0]?.[0]

      expect(itemsPredicate).toBeDefined()
      expect(mocks.countWhere).toHaveBeenCalledWith(itemsPredicate)

      const compiledQuery = compileDatabase
        .selectFrom('account')
        .select('account')
        .where(itemsPredicate)
        .compile()

      expect(compiledQuery.sql).toContain("where `account` like ? escape '!'")
      expect(compiledQuery.parameters).toEqual([expectedPattern])
    },
  )

  it('treats a blank account search as no filter', async () => {
    const response = await app.inject({
      method: 'GET',
      url: '/accounts?account=%20',
    })

    expect(response.statusCode).toBe(200)
    expect(mocks.itemsWhere).not.toHaveBeenCalled()
    expect(mocks.countWhere).not.toHaveBeenCalled()
  })

  it.each([
    ['page=0'],
    ['page=-1'],
    ['page=abc'],
    ['page=1.5'],
    ['page='],
    ['page=%20'],
    ['page=1&page=2'],
    ['pageSize=0'],
    ['pageSize=101'],
    ['pageSize=Infinity'],
    ['pageSize='],
    ['pageSize=%20'],
    ['pageSize=1&pageSize=2'],
  ])(
    'rejects invalid querystring %s before querying the database',
    async (query) => {
      const response = await app.inject({
        method: 'GET',
        url: `/accounts?${query}`,
      })

      expect(response.statusCode).toBe(400)
      expect(mocks.selectFrom).not.toHaveBeenCalled()
      expect(mocks.ddbSelectFrom).not.toHaveBeenCalled()
      expect(mocks.itemsExecute).not.toHaveBeenCalled()
      expect(mocks.countExecuteTakeFirstOrThrow).not.toHaveBeenCalled()
    },
  )
})

describe('get /accounts/:account endpoint', () => {
  it('returns the public account details with display-formatted times', async () => {
    const response = await app.inject({
      method: 'GET',
      url: '/accounts/example_user',
    })

    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      account: 'example_user',
      privilege: 120,
      goldCoin: 1_000_000,
      silverCoin: 50_000,
      blockedTime: '2026-10-02 15:30:45',
      blockedReason: '违规行为',
      tempBlockedTime: '2026-10-03 12:00:00',
      tempBlockedReason: '临时限制',
      firstLoginTime: '2026-09-01 11:00:00',
      firstLoginMac: '00:11:22:33:44:55',
      lastLoginTime: '2026-10-01 19:12:00',
      lastLoginIp: '192.0.2.1',
      lastLoginId: 'device-01',
      regDate: '2026-09-01 10:00:00',
    })
    expect(mocks.select).toHaveBeenCalledWith(accountDetailFields)
    expect(mocks.detailWhere).toHaveBeenCalledWith(
      'account',
      '=',
      'example_user',
    )
    for (const privateField of privateAccountFields) {
      expect(response.payload).not.toContain(privateField)
    }
  })

  it('preserves empty account detail times', async () => {
    mocks.detailExecuteTakeFirst.mockResolvedValue({
      ...accountDetailItem,
      blocked_time: '',
      temp_blocked_time: '',
      first_login_time: '',
      last_login_time: '',
      reg_date: '',
    })

    const response = await app.inject({
      method: 'GET',
      url: '/accounts/example_user',
    })

    expect(response.statusCode).toBe(200)
    expect(response.json()).toMatchObject({
      blockedTime: '',
      tempBlockedTime: '',
      firstLoginTime: '',
      lastLoginTime: '',
      regDate: '',
    })
  })

  it('returns 404 when the account does not exist', async () => {
    mocks.detailExecuteTakeFirst.mockResolvedValue(undefined)

    const response = await app.inject({
      method: 'GET',
      url: '/accounts/missing-account',
    })

    expect(response.statusCode).toBe(404)
    expect(response.json()).toEqual({ message: '账号不存在' })
  })
})
