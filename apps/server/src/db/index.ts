import type { Kysely } from 'kysely'
import type { AccountTable } from './account-table'
import type { DataTable } from './data-table'
export type {
  AccountRow,
  AccountTable,
  AccountUpdate,
  NewAccount,
} from './account-table'
export type { DataTable } from './data-table'
export { createDatabases, registerDatabase } from './database'

export interface AdbDatabase {
  account: AccountTable
}

export interface DdbDatabase {
  data: DataTable
}

export interface FastifyDatabases {
  adb: Kysely<AdbDatabase>
  ddb: Kysely<DdbDatabase>
}

declare module 'fastify' {
  interface FastifyInstance {
    db: FastifyDatabases
  }
}
