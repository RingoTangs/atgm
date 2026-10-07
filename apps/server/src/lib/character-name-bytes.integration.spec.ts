import { Buffer } from 'node:buffer'
import process from 'node:process'
import { sql } from 'kysely'
import { expect, it } from 'vitest'
import { createDatabases } from '../db'
import { parseServerEnv } from '../env'
import { readCharacterNameBytes } from './character-name-bytes'

// Run manually from the repository root using the existing server .env.local:
// pnpm --filter atgm-server exec cross-env CHARACTER_NAME_BYTES_DB_TEST=1 node --env-file=.env.local ../../node_modules/vitest/vitest.mjs run src/lib/character-name-bytes.integration.spec.ts
it.skipIf(process.env.CHARACTER_NAME_BYTES_DB_TEST !== '1')(
  'reads raw binary bytes through the real mysql2 connection',
  async () => {
    const { db, ddbDb } = createDatabases(parseServerEnv(process.env))
    try {
      const probe = await sql<{ bytes: Buffer }>`
        SELECT CAST(X'D6D0CEC4FF' AS BINARY) AS bytes
      `.execute(ddbDb)
      const bytes = probe.rows[0]?.bytes
      expect(Buffer.isBuffer(bytes)).toBe(true)
      expect(bytes).toEqual(Buffer.from([0xd6, 0xd0, 0xce, 0xc4, 0xff]))

      const character = await ddbDb
        .selectFrom('basic_char_info')
        .select(['gid', sql<string>`HEX(${sql.ref('name')})`.as('nameHex')])
        .limit(1)
        .executeTakeFirst()
      if (!character) {
        throw new Error('basic_char_info must contain an existing character')
      }

      const nameBytes = await readCharacterNameBytes(ddbDb, character.gid)
      expect(Buffer.isBuffer(nameBytes)).toBe(true)
      expect(nameBytes).toEqual(Buffer.from(character.nameHex, 'hex'))
    } finally {
      await db.destroy()
    }
  },
  15_000,
)
