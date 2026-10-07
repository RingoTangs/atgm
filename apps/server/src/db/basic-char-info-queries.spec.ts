import type { BasicCharInfoRow, DdbDatabase } from '.'
import { Buffer } from 'node:buffer'
import {
  DummyDriver,
  Kysely,
  MysqlAdapter,
  MysqlIntrospector,
  MysqlQueryCompiler,
} from 'kysely'
import {
  afterEach,
  beforeEach,
  describe,
  expect,
  expectTypeOf,
  it,
  vi,
} from 'vitest'
import { getBasicCharInfo, listBasicCharInfos } from './basic-char-info-queries'

const compiler = new MysqlQueryCompiler()
const compileQuery = vi.spyOn(compiler, 'compileQuery')
const character = {
  gid: 'character-gid',
  polar: 1,
  gender: 2,
  tt_weibo_name: 'weibo-name',
  hide_tt_weibo: 0,
  time: '20180413155302',
  nameBytes: Buffer.from([0xd6, 0xd0, 0xce, 0xc4]),
}
let rows: Array<Omit<typeof character, 'nameBytes'> & { nameBytes: unknown }>
let databaseError: Error | undefined
let ddb: Kysely<DdbDatabase>
const transformResult = vi.fn(async () => {
  if (databaseError) throw databaseError
  return { rows }
})

beforeEach(() => {
  vi.clearAllMocks()
  rows = [{ ...character }]
  databaseError = undefined
  ddb = new Kysely<DdbDatabase>({
    dialect: {
      createAdapter: () => new MysqlAdapter(),
      createDriver: () => new DummyDriver(),
      createIntrospector: (database) => new MysqlIntrospector(database),
      createQueryCompiler: () => compiler,
    },
    plugins: [{ transformQuery: ({ node }) => node, transformResult }],
  }).withSchema('dl_ddb_1')
})

afterEach(async () => {
  await ddb.destroy()
})

const expectedCharacter: BasicCharInfoRow = {
  gid: character.gid,
  name: '中文',
  polar: character.polar,
  gender: character.gender,
  tt_weibo_name: character.tt_weibo_name,
  hide_tt_weibo: character.hide_tt_weibo,
  time: character.time,
}

describe('basic char info queries', () => {
  it('reads and decodes multiple characters with one binary SQL query', async () => {
    rows.push({ ...character, gid: 'second-gid' })
    expect(Buffer.isBuffer(rows[0]?.nameBytes)).toBe(true)
    const result = listBasicCharInfos(ddb)
    expectTypeOf(result).toEqualTypeOf<Promise<BasicCharInfoRow[]>>()
    const characters = await result
    expect(characters).toEqual([
      expectedCharacter,
      { ...expectedCharacter, gid: 'second-gid' },
    ])
    expect(typeof characters[0]?.name).toBe('string')
    expect(characters[0]).not.toHaveProperty('nameBytes')
    expect(Object.values(characters[0]!).some(Buffer.isBuffer)).toBe(false)
    expect(transformResult).toHaveBeenCalledOnce()
    expect(compileQuery).toHaveBeenCalledOnce()
    expect(compileQuery.mock.results[0]?.value).toMatchObject({
      sql: 'select `gid`, `polar`, `gender`, `tt_weibo_name`, `hide_tt_weibo`, `time`, CAST(`name` AS BINARY) as `nameBytes` from `dl_ddb_1`.`basic_char_info` order by `gid` asc',
      parameters: [],
    })
  })

  it('reads and decodes a detail with a parameterized gid', async () => {
    const result = getBasicCharInfo(ddb, "gid' OR 1=1")
    expectTypeOf(result).toEqualTypeOf<Promise<BasicCharInfoRow | undefined>>()
    expect(await result).toEqual(expectedCharacter)
    expect(transformResult).toHaveBeenCalledOnce()
    expect(compileQuery.mock.results[0]?.value).toMatchObject({
      sql: 'select `gid`, `polar`, `gender`, `tt_weibo_name`, `hide_tt_weibo`, `time`, CAST(`name` AS BINARY) as `nameBytes` from `dl_ddb_1`.`basic_char_info` where `gid` = ?',
      parameters: ["gid' OR 1=1"],
    })
  })

  it('returns an empty list when no characters exist', async () => {
    rows = []
    await expect(listBasicCharInfos(ddb)).resolves.toEqual([])
  })

  it('returns undefined when a detail does not exist', async () => {
    rows = []
    await expect(getBasicCharInfo(ddb, 'missing')).resolves.toBeUndefined()
  })

  it('decodes an empty name Buffer as an empty string', async () => {
    rows = [{ ...character, nameBytes: Buffer.alloc(0) }]
    await expect(getBasicCharInfo(ddb, character.gid)).resolves.toEqual({
      ...expectedCharacter,
      name: '',
    })
  })

  it.each(['list', 'detail'])(
    'rejects a non-Buffer name in %s results',
    async (kind) => {
      rows = [{ ...character, nameBytes: 'decoded string' }]
      const result =
        kind === 'list'
          ? listBasicCharInfos(ddb)
          : getBasicCharInfo(ddb, character.gid)
      await expect(result).rejects.toThrow(
        new TypeError('Expected character name bytes to be a Buffer'),
      )
    },
  )

  it.each(['list', 'detail'])(
    'propagates %s database errors unchanged',
    async (kind) => {
      databaseError = new Error('database unavailable')
      const result =
        kind === 'list'
          ? listBasicCharInfos(ddb)
          : getBasicCharInfo(ddb, character.gid)
      await expect(result).rejects.toBe(databaseError)
    },
  )
})
