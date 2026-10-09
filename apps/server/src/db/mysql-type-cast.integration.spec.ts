import type { RowDataPacket } from 'mysql2'
import type { Connection } from 'mysql2/promise'
import { Buffer } from 'node:buffer'
import process from 'node:process'
import { sql } from 'kysely'
import { createConnection } from 'mysql2/promise'
import { expect, it } from 'vitest'
import { createDatabases } from '.'
import { parseServerEnv } from '../env'
import { decodeGb18030 } from '../lib/gb18030'

// Run from the repository root with an existing character gid:
// pnpm --filter atgm-server exec cross-env MYSQL_TYPE_CAST_DB_TEST=1 MYSQL_TYPE_CAST_TEST_GID=<gid> node --env-file=.env.local ../../node_modules/vitest/vitest.mjs run src/db/mysql-type-cast.integration.spec.ts
it.skipIf(process.env.MYSQL_TYPE_CAST_DB_TEST !== '1')(
  'decodes whitelisted fields through a real mysql2 connection',
  async () => {
    const gid = process.env.MYSQL_TYPE_CAST_TEST_GID
    if (!gid)
      throw new Error(
        'MYSQL_TYPE_CAST_TEST_GID must specify an existing character',
      )

    const env = parseServerEnv(process.env)
    const { db, ddbDb } = createDatabases(env)
    let baseline: Connection | undefined
    try {
      baseline = await createConnection({
        host: env.MYSQL_HOST,
        port: env.MYSQL_PORT,
        user: env.MYSQL_USER,
        password: env.MYSQL_PASSWORD,
        database: env.MYSQL_DL_ADB_ALL,
      })

      const session = await sql<{ resultCharset: string | null }>`
        SELECT @@SESSION.character_set_results AS resultCharset
      `.execute(ddbDb)
      expect(session.rows[0]?.resultCharset).toBeNull()

      const query = ddbDb
        .selectFrom('basic_char_info')
        .select(['gid', 'name', 'polar', 'gender'])
        .select(sql<string>`HEX(${sql.ref('name')})`.as('nameHex'))
        .select(sql<Buffer>`CAST(${sql.ref('name')} AS BINARY)`.as('nameBytes'))
        .where('gid', '=', gid)
      const character = await query.executeTakeFirst()
      if (!character)
        throw new Error(
          'The specified basic_char_info character does not exist',
        )

      expect(typeof character.name).toBe('string')
      expect(typeof character.polar).toBe('number')
      expect(typeof character.gender).toBe('number')
      const bytes = Buffer.from(character.nameHex, 'hex')
      expect(Buffer.isBuffer(character.nameBytes)).toBe(true)
      expect(character.nameBytes).toEqual(bytes)
      expect(character.name).toBe(decodeGb18030(bytes))

      const compiled = query.compile()
      const [defaultCharacters] = await baseline.query<RowDataPacket[]>(
        compiled.sql,
        [...compiled.parameters],
      )
      expect(defaultCharacters[0]).toMatchObject({
        gid: character.gid,
        polar: character.polar,
        gender: character.gender,
        nameHex: character.nameHex,
      })

      const dataQuery = ddbDb
        .selectFrom('data')
        .select([
          'path',
          'name',
          'branch',
          'content',
          'memo',
          'time',
          'checksum',
        ])
        .select(sql<string>`HEX(${sql.ref('name')})`.as('nameHex'))
        .select(sql<string>`HEX(${sql.ref('branch')})`.as('branchHex'))
        .select(sql<string>`HEX(${sql.ref('content')})`.as('contentHex'))
        .orderBy('path')
        .orderBy('name')
        .orderBy('branch')
        .limit(1)
      const data = await dataQuery.executeTakeFirst()
      if (!data)
        throw new Error(
          'data must contain an existing record for the raw bytes comparison',
        )
      const dataCompiled = dataQuery.compile()
      const [defaultData] = await baseline.query<RowDataPacket[]>(
        dataCompiled.sql,
        [...dataCompiled.parameters],
      )
      for (const [value, hex] of [
        [data.name, data.nameHex],
        [data.branch, data.branchHex],
        [data.content, data.contentHex],
      ]) {
        expect(typeof value).toBe('string')
        expect(value).toBe(decodeGb18030(Buffer.from(hex!, 'hex')))
      }
      expect(defaultData[0]).toMatchObject({
        path: data.path,
        memo: data.memo,
        time: data.time,
        checksum: data.checksum,
        nameHex: data.nameHex,
        branchHex: data.branchHex,
        contentHex: data.contentHex,
      })
    } finally {
      await Promise.all([db.destroy(), baseline?.end()])
    }
  },
  15_000,
)
