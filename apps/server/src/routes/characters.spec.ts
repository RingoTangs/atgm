import type { CompiledQuery } from 'kysely'
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

const character = {
  gid: '0000000000000003',
  name: '女金',
  polar: 1,
  gender: 2,
  time: '20180413155302',
}
const compiler = new MysqlQueryCompiler()
const compileQuery = vi.spyOn(compiler, 'compileQuery')
let total: number | string | bigint
let items: (typeof character)[]
let databaseError: Error | undefined
let ddb: Kysely<AdbDatabase & DdbDatabase>
let app: ReturnType<typeof buildApp>
const transformResult = vi.fn(async ({ queryId }: { queryId: unknown }) => {
  if (databaseError) throw databaseError
  const compiled = compileQuery.mock.results
    .map((result) => result.value as CompiledQuery)
    .find((query) => query.queryId === queryId)
  return { rows: compiled?.sql.includes('count(*)') ? [{ total }] : items }
})

beforeEach(() => {
  vi.clearAllMocks()
  total = '125'
  items = [{ ...character }]
  databaseError = undefined
  ddb = new Kysely<AdbDatabase & DdbDatabase>({
    dialect: {
      createAdapter: () => new MysqlAdapter(),
      createDriver: () => new DummyDriver(),
      createIntrospector: (database) => new MysqlIntrospector(database),
      createQueryCompiler: () => compiler,
    },
    plugins: [{ transformQuery: ({ node }) => node, transformResult }],
  }).withSchema('dl_ddb_1')
  app = buildApp()
  app.decorate('db', {
    ddb: ddb.$pickTables<'data' | 'basic_char_info'>(),
    adb: ddb.$pickTables<'account'>().withSchema('dl_adb_all'),
  })
})

afterEach(async () => {
  await app.close()
  await ddb.destroy()
})

describe('get /characters', () => {
  it('returns default pagination, numeric total and decoded Chinese names', async () => {
    const response = await app.inject('/characters')
    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      page: 1,
      pageSize: 20,
      total: 125,
      items: [character],
    })
    expect(transformResult).toHaveBeenCalledTimes(2)
    const queries = compileQuery.mock.results.map((result) => result.value)
    expect(queries).toEqual(
      expect.arrayContaining([
        expect.objectContaining({
          sql: 'select count(*) as `total` from `dl_ddb_1`.`basic_char_info`',
          parameters: [],
        }),
        expect.objectContaining({
          sql: 'select `gid`, `name`, `polar`, `gender`, `time` from `dl_ddb_1`.`basic_char_info` order by `gid` limit ? offset ?',
          parameters: [20, 0],
        }),
      ]),
    )
  })

  it('uses custom pagination with stable gid ordering', async () => {
    const response = await app.inject('/characters?page=3&pageSize=10')
    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      page: 3,
      pageSize: 10,
      total: 125,
      items: [character],
    })
    expect(compileQuery.mock.results.map((result) => result.value)).toEqual(
      expect.arrayContaining([
        expect.objectContaining({
          sql: 'select `gid`, `name`, `polar`, `gender`, `time` from `dl_ddb_1`.`basic_char_info` order by `gid` limit ? offset ?',
          parameters: [10, 20],
        }),
      ]),
    )
  })

  it('accepts the maximum page size', async () => {
    const response = await app.inject('/characters?pageSize=100')
    expect(response.statusCode).toBe(200)
    expect(response.json().pageSize).toBe(100)
  })

  it.each([
    'page=0',
    'page=-1',
    'page=1.5',
    'page=abc',
    'page=',
    'pageSize=0',
    'pageSize=-1',
    'pageSize=1.5',
    'pageSize=101',
    'pageSize=abc',
    'pageSize=',
  ])('rejects invalid pagination: %s', async (query) => {
    const response = await app.inject(`/characters?${query}`)
    expect(response.statusCode).toBe(400)
    expect(response.json().code).toBe(errorCodes.VALIDATION_ERROR)
    expect(transformResult).not.toHaveBeenCalled()
  })

  it.each([
    { total: 0, page: 1 },
    { total: 125, page: 20 },
  ])('returns an empty list with total $total on page $page', async (input) => {
    total = input.total
    items = []
    const response = await app.inject(`/characters?page=${input.page}`)
    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      page: input.page,
      pageSize: 20,
      total: input.total,
      items: [],
    })
  })

  it.each([125, '125', 125n])(
    'converts database count %s to a number',
    async (count) => {
      total = count
      const response = await app.inject('/characters')
      expect(response.statusCode).toBe(200)
      expect(response.json().total).toBe(125)
    },
  )

  it.each([-1, 'invalid', Number.MAX_SAFE_INTEGER + 1])(
    'rejects invalid database count %s',
    async (count) => {
      total = count
      const response = await app.inject('/characters')
      expect(response.statusCode).toBe(500)
      expect(response.json()).toEqual({
        code: errorCodes.INTERNAL_SERVER_ERROR,
        message: 'Internal Server Error',
      })
    },
  )

  it('returns the unified error response on database failure', async () => {
    databaseError = new Error('database unavailable')
    const response = await app.inject('/characters')
    expect(response.statusCode).toBe(500)
    expect(response.json()).toEqual({
      code: errorCodes.INTERNAL_SERVER_ERROR,
      message: 'Internal Server Error',
    })
  })
})
