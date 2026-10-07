import type { Kysely } from 'kysely'
import type { BasicCharInfoRow, DdbDatabase } from '.'
import { Buffer } from 'node:buffer'
import { sql } from 'kysely'
import { decodeGb18030 } from '../lib/gb18030'

type RawBasicCharInfo = Omit<BasicCharInfoRow, 'name'> & {
  nameBytes: Buffer
}

const selectBasicCharInfos = (ddb: Kysely<DdbDatabase>) =>
  ddb
    .selectFrom('basic_char_info')
    .select([
      'gid',
      'polar',
      'gender',
      'tt_weibo_name',
      'hide_tt_weibo',
      'time',
      sql<Buffer>`CAST(${sql.ref('name')} AS BINARY)`.as('nameBytes'),
    ])

const decodeBasicCharInfo = (row: RawBasicCharInfo): BasicCharInfoRow => {
  const { nameBytes, ...fields } = row
  if (!Buffer.isBuffer(nameBytes)) {
    throw new TypeError('Expected character name bytes to be a Buffer')
  }

  return { ...fields, name: decodeGb18030(nameBytes) }
}

export async function listBasicCharInfos(
  ddb: Kysely<DdbDatabase>,
): Promise<BasicCharInfoRow[]> {
  const rows = await selectBasicCharInfos(ddb).orderBy('gid', 'asc').execute()
  return rows.map(decodeBasicCharInfo)
}

export async function getBasicCharInfo(
  ddb: Kysely<DdbDatabase>,
  gid: string,
): Promise<BasicCharInfoRow | undefined> {
  const row = await selectBasicCharInfos(ddb)
    .where('gid', '=', gid)
    .executeTakeFirst()
  return row ? decodeBasicCharInfo(row) : undefined
}
