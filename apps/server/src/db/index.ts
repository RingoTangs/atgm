import type { Kysely } from 'kysely'
import type { AccountTable } from './account-table'
import type { BasicCharInfoTable } from './basic-char-info-table'
import type { DataTable } from './data-table'
import type { ServerTable } from './server-table'
export type {
  AccountRow,
  AccountTable,
  AccountUpdate,
  NewAccount,
} from './account-table'
export type {
  BasicCharInfoRow,
  BasicCharInfoTable,
  BasicCharInfoUpdate,
  NewBasicCharInfo,
} from './basic-char-info-table'
export type { DataTable } from './data-table'
export { createDatabases, registerDatabase } from './database'
export type {
  NewServer,
  ServerRow,
  ServerTable,
  ServerUpdate,
} from './server-table'

export interface AdbDatabase {
  account: AccountTable
  server: ServerTable
}

export interface DdbDatabase {
  basic_char_info: BasicCharInfoTable
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
