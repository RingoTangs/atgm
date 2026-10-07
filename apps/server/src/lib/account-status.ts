import type { Kysely } from 'kysely'
import type { DdbDatabase } from '../db'

export async function isAccountOnline(
  ddb: Kysely<DdbDatabase>,
  account: string,
): Promise<boolean> {
  const row = await ddb
    .selectFrom('data')
    .select('name')
    .where('path', '=', 'runtime')
    .where('name', '=', account)
    .executeTakeFirst()

  return Boolean(row)
}

export async function getOnlineAccounts(
  ddb: Kysely<DdbDatabase>,
  accounts: readonly string[],
): Promise<Set<string>> {
  if (accounts.length === 0) return new Set<string>()

  const rows = await ddb
    .selectFrom('data')
    .select('name')
    .where('path', '=', 'runtime')
    .where('name', 'in', accounts)
    .execute()

  return new Set(rows.map((row) => row.name))
}
