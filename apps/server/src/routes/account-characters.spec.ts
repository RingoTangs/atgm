import type { AdbDatabase, DdbDatabase } from '../db'
import { errorCodes } from '@atgm/contracts'
import {
  DummyDriver,
  Kysely,
  MysqlAdapter,
  MysqlIntrospector,
  MysqlQueryCompiler,
} from 'kysely'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { buildApp } from '../app'

const login =
  '(["create_time":1790613437,"rec_role":"0000000000000003","safe_status":0,"chars":({"0000000000000003","0000000000000004",}),"register_time":0,])'
const first = {
  gid: '0000000000000003',
  name: '女金',
  polar: 1,
  gender: 2,
  time: '20261002233754',
}
const second = {
  gid: '0000000000000004',
  name: '龙宫守卫',
  polar: 5,
  gender: 1,
  time: '20261003010203',
}
const firstResponse = { ...first, time: '2026-10-02 23:37:54' }
const secondResponse = { ...second, time: '2026-10-03 01:02:03' }
const compiler = new MysqlQueryCompiler()
const compileQuery = vi.spyOn(compiler, 'compileQuery')
let accountExists: boolean
let content: string | undefined
let rows: (typeof first)[]
let failureTable: string | undefined
let db: Kysely<AdbDatabase & DdbDatabase>
let app: ReturnType<typeof buildApp>

const transformResult = vi.fn(async ({ queryId }: { queryId: unknown }) => {
  const compiled = compileQuery.mock.results
    .map((result) => result.value)
    .find((query) => query.queryId === queryId)
  if (!compiled) throw new Error('Missing compiled query')
  if (failureTable && compiled.sql.includes(`\`${failureTable}\``))
    throw new Error('database unavailable')
  if (compiled.sql.includes('`dl_adb_all`.`account`'))
    return { rows: accountExists ? [{ account: 'example_user' }] : [] }
  if (compiled.sql.includes('`dl_ddb_1`.`data`'))
    return { rows: content === undefined ? [] : [{ content }] }
  if (compiled.sql.includes('`dl_ddb_1`.`basic_char_info`')) return { rows }
  throw new Error(`Unexpected query: ${compiled.sql}`)
})

beforeEach(() => {
  vi.clearAllMocks()
  accountExists = true
  content = login
  rows = [{ ...second }, { ...first }]
  failureTable = undefined
  db = new Kysely<AdbDatabase & DdbDatabase>({
    dialect: {
      createAdapter: () => new MysqlAdapter(),
      createDriver: () => new DummyDriver(),
      createIntrospector: (database) => new MysqlIntrospector(database),
      createQueryCompiler: () => compiler,
    },
    plugins: [{ transformQuery: ({ node }) => node, transformResult }],
  })
  app = buildApp()
  app.decorate('db', {
    adb: db.$pickTables<'account'>().withSchema('dl_adb_all'),
    ddb: db.$pickTables<'data' | 'basic_char_info'>().withSchema('dl_ddb_1'),
  })
})

afterEach(async () => {
  await app.close()
  await db.destroy()
})

// eslint-disable-next-line test/prefer-lowercase-title
describe('GET /accounts/:account/characters', () => {
  it('returns ACCOUNT_NOT_FOUND and does not query login data for a missing account', async () => {
    accountExists = false
    const response = await app.inject('/accounts/missing/characters')
    expect(response.statusCode).toBe(404)
    expect(response.json()).toEqual({
      code: errorCodes.ACCOUNT_NOT_FOUND,
      message: '账号不存在',
    })
    expect(transformResult).toHaveBeenCalledTimes(1)
    expect(compileQuery.mock.results[0]?.value).toMatchObject({
      sql: 'select `account` from `dl_adb_all`.`account` where `account` = ?',
      parameters: ['missing'],
    })
  })

  it.each([
    { value: undefined, recRole: null },
    {
      value: login.replace(
        '({"0000000000000003","0000000000000004",})',
        '({})',
      ),
      recRole: first.gid,
    },
  ])(
    'returns empty chars and recRole $recRole without querying characters for login content $value',
    async ({ value, recRole }) => {
      content = value
      const response = await app.inject('/accounts/example_user/characters')
      expect(response.statusCode).toBe(200)
      expect(response.json()).toEqual({ recRole, chars: [] })
      expect(transformResult).toHaveBeenCalledTimes(2)
      expect(
        compileQuery.mock.results.map((result) => result.value.sql),
      ).not.toEqual(
        expect.arrayContaining([expect.stringContaining('basic_char_info')]),
      )
    },
  )

  it('queries only required fields and returns real login roles in chars order with formatted times', async () => {
    const response = await app.inject('/accounts/example_user/characters')
    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      recRole: first.gid,
      chars: [firstResponse, secondResponse],
    })
    expect(transformResult).toHaveBeenCalledTimes(3)
    expect(
      compileQuery.mock.results.map((result) => result.value),
    ).toMatchObject([
      {
        sql: 'select `account` from `dl_adb_all`.`account` where `account` = ?',
        parameters: ['example_user'],
      },
      {
        sql: 'select `content` from `dl_ddb_1`.`data` where `path` = ? and `name` = ? and `branch` = ?',
        parameters: ['login', 'example_user', ''],
      },
      {
        sql: 'select `gid`, `name`, `polar`, `gender`, `time` from `dl_ddb_1`.`basic_char_info` where `gid` in (?, ?)',
        parameters: [first.gid, second.gid],
      },
    ])
  })

  it.each([{ available: [first] }, { available: [second] }, { available: [] }])(
    'skips missing gids with available rows $available',
    async ({ available }) => {
      rows = available
      const response = await app.inject('/accounts/example_user/characters')
      expect(response.statusCode).toBe(200)
      expect(response.json()).toEqual({
        recRole: first.gid,
        chars: available.map((row) =>
          row.gid === first.gid ? firstResponse : secondResponse,
        ),
      })
    },
  )

  it('preserves repeated gids in chars', async () => {
    content = login.replace(
      '"0000000000000004",})',
      '"0000000000000004","0000000000000003",})',
    )
    const response = await app.inject('/accounts/example_user/characters')
    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      recRole: first.gid,
      chars: [firstResponse, secondResponse, firstResponse],
    })
  })

  it.each(['', 'invalid', '20260230233754'])(
    'preserves empty or invalid time %j',
    async (time) => {
      rows = [{ ...first, time }]
      const response = await app.inject('/accounts/example_user/characters')
      expect(response.statusCode).toBe(200)
      expect(response.json()).toEqual({
        recRole: first.gid,
        chars: [{ ...first, time }],
      })
    },
  )

  it('preserves recRole even when it is not in chars or the character query result', async () => {
    content = login.replace(
      '"rec_role":"0000000000000003"',
      '"rec_role":"0000000000000005"',
    )
    const response = await app.inject('/accounts/example_user/characters')
    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      recRole: '0000000000000005',
      chars: [firstResponse, secondResponse],
    })
  })

  it.each([
    '(["chars":',
    '([])',
    login.replace('"safe_status":0', '"safe_status":"wrong"'),
  ])(
    'returns INTERNAL_SERVER_ERROR for invalid login content %j',
    async (value) => {
      content = value
      const response = await app.inject('/accounts/example_user/characters')
      expect(response.statusCode).toBe(500)
      expect(response.json()).toEqual({
        code: errorCodes.INTERNAL_SERVER_ERROR,
        message: 'Internal Server Error',
      })
      expect(transformResult).toHaveBeenCalledTimes(2)
    },
  )

  it.each([
    ['account', 1],
    ['data', 2],
    ['basic_char_info', 3],
  ] as const)(
    'returns INTERNAL_SERVER_ERROR on %s database failure',
    async (table, calls) => {
      failureTable = table
      const response = await app.inject('/accounts/example_user/characters')
      expect(response.statusCode).toBe(500)
      expect(response.json()).toEqual({
        code: errorCodes.INTERNAL_SERVER_ERROR,
        message: 'Internal Server Error',
      })
      expect(transformResult).toHaveBeenCalledTimes(calls)
    },
  )

  it('rejects an invalid account parameter before querying', async () => {
    const response = await app.inject(`/accounts/${'a'.repeat(33)}/characters`)
    expect(response.statusCode).toBe(400)
    expect(response.json().code).toBe(errorCodes.VALIDATION_ERROR)
    expect(transformResult).not.toHaveBeenCalled()
  })
})
