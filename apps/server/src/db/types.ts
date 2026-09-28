import type { Kysely } from 'kysely'
import type { AccountTable } from './types/account'

export type {
  AccountRow,
  AccountTable,
  AccountUpdate,
  NewAccount,
} from './types/account'

export interface AdbDatabase {
  account: AccountTable
}

export type DdbDatabase = Record<never, never>

export interface FastifyDatabases {
  adb: Kysely<AdbDatabase>
  ddb: Kysely<DdbDatabase>
}
