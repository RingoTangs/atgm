import type { Kysely } from 'kysely'
import type { AdbDatabase } from '.'

const DEFAULT_PAGE_SIZE = 20
const MAX_PAGE_SIZE = 100

const accountColumns = [
  'account',
  'gold_coin',
  'silver_coin',
  'last_login_time',
  'update_time',
] as const

export interface AccountPageOptions {
  limit?: number
  offset?: number
}

function normalizeLimit(limit = DEFAULT_PAGE_SIZE): number {
  if (!Number.isInteger(limit) || limit < 1) {
    throw new RangeError('limit must be a positive integer')
  }

  return Math.min(limit, MAX_PAGE_SIZE)
}

function normalizeOffset(offset = 0): number {
  if (!Number.isInteger(offset) || offset < 0) {
    throw new RangeError('offset must be a non-negative integer')
  }

  return offset
}

export function findAccountByAccount(
  adbDb: Kysely<AdbDatabase>,
  account: string,
) {
  return adbDb
    .selectFrom('account')
    .select(accountColumns)
    .where('account', '=', account)
}

export function listAccounts(
  adbDb: Kysely<AdbDatabase>,
  options: AccountPageOptions = {},
) {
  const limit = normalizeLimit(options.limit)
  const offset = normalizeOffset(options.offset)

  return adbDb
    .selectFrom('account')
    .select(accountColumns)
    .orderBy('account')
    .limit(limit)
    .offset(offset)
}

export function listAccountsByLastLoginTime(
  adbDb: Kysely<AdbDatabase>,
  lastLoginTime: string,
  limit = DEFAULT_PAGE_SIZE,
) {
  return adbDb
    .selectFrom('account')
    .select(accountColumns)
    .where('last_login_time', '>=', lastLoginTime)
    .orderBy('last_login_time', 'desc')
    .orderBy('account')
    .limit(normalizeLimit(limit))
}
