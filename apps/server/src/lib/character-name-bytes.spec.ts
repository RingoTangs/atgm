import type { DdbDatabase } from '../db'
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
import { readCharacterNameBytes } from './character-name-bytes'

const compiler = new MysqlQueryCompiler()
const compileQuery = vi.spyOn(compiler, 'compileQuery')
let nameBytes: unknown
let databaseError: Error | undefined
let ddb: Kysely<DdbDatabase>

beforeEach(() => {
  vi.clearAllMocks()
  nameBytes = undefined
  databaseError = undefined
  ddb = new Kysely<DdbDatabase>({
    dialect: {
      createAdapter: () => new MysqlAdapter(),
      createDriver: () => new DummyDriver(),
      createIntrospector: (database) => new MysqlIntrospector(database),
      createQueryCompiler: () => compiler,
    },
    plugins: [
      {
        transformQuery: ({ node }) => node,
        transformResult: async () => {
          if (databaseError) throw databaseError
          return { rows: nameBytes === undefined ? [] : [{ nameBytes }] }
        },
      },
    ],
  }).withSchema('dl_ddb_1')
})

afterEach(async () => {
  await ddb.destroy()
})

describe('readCharacterNameBytes', () => {
  it('uses a binary cast and parameterized gid in the DDB query', async () => {
    await readCharacterNameBytes(ddb, "gid' OR 1=1")
    expect(compileQuery.mock.results[0]?.value).toMatchObject({
      sql: 'select CAST(`name` AS BINARY) as `nameBytes` from `dl_ddb_1`.`basic_char_info` where `gid` = ?',
      parameters: ["gid' OR 1=1"],
    })
  })

  it('returns the same Buffer without decoding invalid UTF-8 bytes', async () => {
    const bytes = Buffer.from([0xd6, 0xd0, 0xce, 0xc4, 0xff])
    nameBytes = bytes
    const result = readCharacterNameBytes(ddb, 'character-gid')
    expectTypeOf(result).toEqualTypeOf<Promise<Buffer | undefined>>()
    const actual = await result
    expect(Buffer.isBuffer(actual)).toBe(true)
    expect(actual).toBe(bytes)
    expect(actual).toEqual(Buffer.from([0xd6, 0xd0, 0xce, 0xc4, 0xff]))
  })

  it('returns undefined when the character does not exist', async () => {
    await expect(
      readCharacterNameBytes(ddb, 'missing'),
    ).resolves.toBeUndefined()
  })

  it('rejects strings instead of reconstructing bytes from decoded text', async () => {
    nameBytes = 'decoded character name'
    await expect(readCharacterNameBytes(ddb, 'character-gid')).rejects.toThrow(
      new TypeError('Expected character name bytes to be a Buffer'),
    )
  })

  it('propagates database errors unchanged', async () => {
    databaseError = new Error('database unavailable')
    await expect(readCharacterNameBytes(ddb, 'character-gid')).rejects.toBe(
      databaseError,
    )
  })
})
