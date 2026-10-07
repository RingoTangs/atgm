import type { Kysely } from 'kysely'
import type { DdbDatabase } from '../db'
import { Buffer } from 'node:buffer'
import { sql } from 'kysely'

export async function readCharacterNameBytes(
  ddb: Kysely<DdbDatabase>,
  gid: string,
): Promise<Buffer | undefined> {
  const row = await ddb
    .selectFrom('basic_char_info')
    .select(sql<Buffer>`CAST(${sql.ref('name')} AS BINARY)`.as('nameBytes'))
    .where('gid', '=', gid)
    .executeTakeFirst()

  if (!row) return undefined

  if (!Buffer.isBuffer(row.nameBytes)) {
    throw new TypeError('Expected character name bytes to be a Buffer')
  }

  return row.nameBytes
}
