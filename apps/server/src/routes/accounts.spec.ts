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

const mocks = vi.hoisted(() => {
  const itemsExecute = vi.fn()
  const countExecuteTakeFirstOrThrow = vi.fn()
  const offset = vi.fn(() => ({ execute: itemsExecute }))
  const limit = vi.fn(() => ({ offset }))
  const orderBy = vi.fn(() => ({ limit }))
  const itemsWhere = vi.fn((_predicate: RawBuilder<boolean>) => ({ orderBy }))
  const countWhere = vi.fn((_predicate: RawBuilder<boolean>) => ({
    executeTakeFirstOrThrow: countExecuteTakeFirstOrThrow,
  }))
  const select = vi.fn((selection: unknown) =>
    Array.isArray(selection)
      ? { orderBy, where: itemsWhere }
      : {
          executeTakeFirstOrThrow: countExecuteTakeFirstOrThrow,
          where: countWhere,
        },
  )
  const selectFrom = vi.fn(() => ({ select }))

  return {
    countExecuteTakeFirstOrThrow,
    countWhere,
    itemsExecute,
    itemsWhere,
    limit,
    offset,
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
      ddb: {},
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
  privilege: 100,
  goldCoin: 1_000_000,
  silverCoin: 50_000,
  lastLoginTime: '2026-09-28 12:00:00',
  lastLoginIp: '192.0.2.1',
  regDate: '2026-09-01 10:00:00',
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
    expect(response.payload).not.toContain('password')
    expect(response.payload).not.toContain('checksum')
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
      expect(mocks.itemsExecute).not.toHaveBeenCalled()
      expect(mocks.countExecuteTakeFirstOrThrow).not.toHaveBeenCalled()
    },
  )
})
