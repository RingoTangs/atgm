import type { Kysely } from 'kysely'
import type { AccountTable } from './account-table'
export type {
  AccountRow,
  AccountTable,
  AccountUpdate,
  NewAccount,
} from './account-table'
export { createDatabases, registerDatabase } from './database'

export interface AdbDatabase {
  account: AccountTable
}

export type DdbDatabase = Record<never, never>

export interface FastifyDatabases {
  adb: Kysely<AdbDatabase>
  ddb: Kysely<DdbDatabase>
}

declare module 'fastify' {
  interface FastifyInstance {
    db: FastifyDatabases
  }
}
