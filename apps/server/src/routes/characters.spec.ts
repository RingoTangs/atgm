import type { CompiledQuery } from 'kysely'
import type { AdbDatabase, DdbDatabase } from '../db'
import { readFileSync } from 'node:fs'
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
const characterResponse = {
  ...character,
  time: '2018-04-13 15:53:02',
  account: null,
}
const compiler = new MysqlQueryCompiler()
const compileQuery = vi.spyOn(compiler, 'compileQuery')
let total: number | string | bigint
let items: (typeof character)[]
let dataRows: { name: string; content: string }[]
let dataError: Error | undefined
let databaseError: Error | undefined
let ddb: Kysely<AdbDatabase & DdbDatabase>
let app: ReturnType<typeof buildApp>
const transformResult = vi.fn(async ({ queryId }: { queryId: unknown }) => {
  if (databaseError) throw databaseError
  const compiled = compileQuery.mock.results
    .map((result) => result.value as CompiledQuery)
    .find((query) => query.queryId === queryId)
  if (compiled?.sql.includes('`.`data`')) {
    if (dataError) throw dataError
    return { rows: dataRows }
  }
  return { rows: compiled?.sql.includes('count(*)') ? [{ total }] : items }
})

beforeEach(() => {
  vi.clearAllMocks()
  total = '125'
  items = [{ ...character }]
  dataRows = []
  dataError = undefined
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

// eslint-disable-next-line test/prefer-lowercase-title
describe('GET /characters', () => {
  it('returns default pagination, numeric total and decoded Chinese names', async () => {
    const response = await app.inject('/characters')
    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      page: 1,
      pageSize: 10,
      total: 125,
      items: [characterResponse],
    })
    expect(transformResult).toHaveBeenCalledTimes(3)
    const queries = compileQuery.mock.results.map((result) => result.value)
    expect(queries).toEqual(
      expect.arrayContaining([
        expect.objectContaining({
          sql: 'select count(*) as `total` from `dl_ddb_1`.`basic_char_info`',
          parameters: [],
        }),
        expect.objectContaining({
          sql: 'select `gid`, `name`, `polar`, `gender`, `time` from `dl_ddb_1`.`basic_char_info` order by `gid` limit ? offset ?',
          parameters: [10, 0],
        }),
        expect.objectContaining({
          sql: 'select `name`, `content` from `dl_ddb_1`.`data` where `path` = ? and `branch` = ? and `name` in (?)',
          parameters: ['user', '', character.gid],
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
      items: [characterResponse],
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

  it.each(['', 'invalid', '20180230155302'])(
    'preserves empty or invalid time: %s',
    async (time) => {
      items = [{ ...character, time }]
      const response = await app.inject('/characters')
      expect(response.statusCode).toBe(200)
      expect(response.json().items).toEqual([
        { ...character, time, account: null },
      ])
    },
  )

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
      pageSize: 10,
      total: input.total,
      items: [],
    })
    expect(transformResult).toHaveBeenCalledTimes(2)
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

  it('reads the account string from the real character content fixture', async () => {
    dataRows = [
      {
        name: character.gid,
        content: readFileSync(
          new URL(
            '../../../../packages/lpc/src/fixtures/gid-03.txt',
            import.meta.url,
          ),
          'utf8',
        ),
      },
    ]
    const response = await app.inject('/characters')
    expect(response.statusCode).toBe(200)
    expect(response.json().items).toEqual([
      { ...characterResponse, account: '1' },
    ])
  })

  it('batches accounts for all page gids and preserves character order', async () => {
    items = [
      character,
      { ...character, gid: 'second-gid' },
      { ...character, gid: 'third-gid' },
      { ...character, gid: 'fourth-gid' },
    ]
    dataRows = [
      {
        name: 'second-gid',
        content: '(["me":(["account":"other-account",]),])',
      },
      {
        name: 'third-gid',
        content: '(["me":(["account":"shared-account",]),])',
      },
      {
        name: character.gid,
        content: '(["me":(["account":"shared-account",]),])',
      },
    ]
    const response = await app.inject('/characters')
    expect(response.statusCode).toBe(200)
    expect(response.json().items).toEqual([
      { ...characterResponse, account: 'shared-account' },
      { ...characterResponse, gid: 'second-gid', account: 'other-account' },
      { ...characterResponse, gid: 'third-gid', account: 'shared-account' },
      { ...characterResponse, gid: 'fourth-gid' },
    ])
    expect(transformResult).toHaveBeenCalledTimes(3)
    expect(
      compileQuery.mock.results.map((result) => result.value),
    ).toContainEqual(
      expect.objectContaining({
        sql: 'select `name`, `content` from `dl_ddb_1`.`data` where `path` = ? and `branch` = ? and `name` in (?, ?, ?, ?)',
        parameters: [
          'user',
          '',
          character.gid,
          'second-gid',
          'third-gid',
          'fourth-gid',
        ],
      }),
    )
  })

  it.each(['([])', '(["me":([]),])', '(["me":(["account":"",]),])'])(
    'returns null for a missing account in %s',
    async (content) => {
      dataRows = [{ name: character.gid, content }]
      const response = await app.inject('/characters')
      expect(response.statusCode).toBe(200)
      expect(response.json().items[0].account).toBeNull()
    },
  )

  it.each([
    { content: 'invalid', message: 'Unknown token (offset: 0)' },
    { content: '', message: 'Expected LPC value (offset: 0)' },
    { content: '({})', message: 'Character data root must be a mapping' },
    { content: '(["me":1,])', message: 'me must be a mapping' },
    {
      content: '(["me":(["account":1,]),])',
      message: 'me.account must be a string',
    },
  ])(
    'fails and logs the gid for invalid character data: $content',
    async ({ content, message }) => {
      const errorLog = vi.fn()
      app.addHook('onRequest', async (request) => {
        vi.spyOn(request.log, 'error').mockImplementation(errorLog)
      })
      dataRows = [{ name: character.gid, content }]
      const response = await app.inject('/characters')
      expect(response.statusCode).toBe(500)
      expect(response.json()).toEqual({
        code: errorCodes.INTERNAL_SERVER_ERROR,
        message: 'Internal Server Error',
      })
      expect(errorLog).toHaveBeenCalledWith(
        {
          err: expect.objectContaining({
            message: `Invalid character data for GID ${character.gid}: ${message}`,
          }),
        },
        'Unhandled server error',
      )
    },
  )

  it('fails the whole page when one character has invalid LPC', async () => {
    items = [character, { ...character, gid: 'second-gid' }]
    dataRows = [
      { name: character.gid, content: '(["me":(["account":"valid",]),])' },
      { name: 'second-gid', content: 'invalid' },
    ]
    const response = await app.inject('/characters')
    expect(response.statusCode).toBe(500)
    expect(response.json().code).toBe(errorCodes.INTERNAL_SERVER_ERROR)
  })

  it('returns a server error when the account batch query fails', async () => {
    dataError = new Error('account query unavailable')
    const response = await app.inject('/characters')
    expect(response.statusCode).toBe(500)
    expect(response.json().code).toBe(errorCodes.INTERNAL_SERVER_ERROR)
    expect(transformResult).toHaveBeenCalledTimes(3)
  })
})
