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

const server = {
  id: 1,
  server: '万里长城一线',
  dist: '万里长城',
  alias: '',
  ip: '47.97.104.166',
  port: 8160,
  max_user: 1200,
  enable: 1,
}
const serverResponse = {
  id: 1,
  server: server.server,
  dist: server.dist,
  alias: '',
  ip: server.ip,
  port: 8160,
  maxUser: 1200,
  enable: 1,
}
const compiler = new MysqlQueryCompiler()
const compileQuery = vi.spyOn(compiler, 'compileQuery')
let total: number | string | bigint
let items: (typeof server & { server_key?: string })[]
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
  items = [{ ...server }]
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
    adb: ddb.$pickTables<'account' | 'server'>().withSchema('dl_adb_all'),
  })
})

afterEach(async () => {
  await app.close()
  await ddb.destroy()
})

// eslint-disable-next-line test/prefer-lowercase-title
describe('GET /servers', () => {
  it('returns default pagination, decoded names and only list fields', async () => {
    items = [{ ...server, server_key: 'secret' }]
    const response = await app.inject('/servers')
    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      page: 1,
      pageSize: 10,
      total: 125,
      items: [serverResponse],
    })
    expect(transformResult).toHaveBeenCalledTimes(2)
    expect(compileQuery.mock.results.map((result) => result.value)).toEqual(
      expect.arrayContaining([
        expect.objectContaining({
          sql: 'select count(*) as `total` from `dl_adb_all`.`server`',
          parameters: [],
        }),
        expect.objectContaining({
          sql: 'select `id`, `server`, `dist`, `alias`, `ip`, `port`, `max_user`, `enable` from `dl_adb_all`.`server` order by `id` asc, `server` asc limit ? offset ?',
          parameters: [10, 0],
        }),
      ]),
    )
  })

  it('uses custom pagination and stable ordering', async () => {
    const response = await app.inject('/servers?page=3&pageSize=20')
    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      page: 3,
      pageSize: 20,
      total: 125,
      items: [serverResponse],
    })
    expect(compileQuery.mock.results.map((result) => result.value)).toEqual(
      expect.arrayContaining([
        expect.objectContaining({
          sql: expect.stringContaining(
            'order by `id` asc, `server` asc limit ? offset ?',
          ),
          parameters: [20, 40],
        }),
      ]),
    )
  })

  it.each([0, 2, -1])(
    'preserves enable value %s and duplicate ids',
    async (enable) => {
      items = [server, { ...server, server: '万里长城二线', enable }]
      const response = await app.inject('/servers')
      expect(response.statusCode).toBe(200)
      expect(response.json().items).toEqual([
        serverResponse,
        { ...serverResponse, server: '万里长城二线', enable },
      ])
    },
  )

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
  ])('rejects invalid pagination %s without querying', async (query) => {
    const response = await app.inject(`/servers?${query}`)
    expect(response.statusCode).toBe(400)
    expect(response.json().code).toBe(errorCodes.VALIDATION_ERROR)
    expect(transformResult).not.toHaveBeenCalled()
  })

  it.each([0, 125])('returns empty items with total %s', async (count) => {
    total = count
    items = []
    const response = await app.inject('/servers?page=20')
    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      page: 20,
      pageSize: 10,
      total: count,
      items: [],
    })
  })

  it.each([125, '125', 125n])(
    'converts count %s to a number',
    async (count) => {
      total = count
      expect((await app.inject('/servers')).json().total).toBe(125)
    },
  )

  it.each([-1, 'invalid', Number.MAX_SAFE_INTEGER + 1])(
    'rejects invalid count %s',
    async (count) => {
      total = count
      expect((await app.inject('/servers')).statusCode).toBe(500)
    },
  )

  it('uses the unified error response on database failure', async () => {
    databaseError = new Error('database unavailable')
    const response = await app.inject('/servers')
    expect(response.statusCode).toBe(500)
    expect(response.json()).toEqual({
      code: errorCodes.INTERNAL_SERVER_ERROR,
      message: 'Internal Server Error',
    })
  })

  it('includes the route in development Swagger', async () => {
    vi.stubEnv('NODE_ENV', 'development')
    const developmentApp = buildApp()
    try {
      const response = await developmentApp.inject('/docs/json')
      expect(response.statusCode).toBe(200)
      const route = response.json().paths['/servers'].get
      expect(route.summary).toBe('查询游戏服务器配置')
      expect(
        route.parameters.map((parameter: { name: string }) => parameter.name),
      ).toEqual(['page', 'pageSize'])
      expect(route.responses['200']).toBeDefined()
    } finally {
      await developmentApp.close()
      vi.unstubAllEnvs()
    }
  })
})
