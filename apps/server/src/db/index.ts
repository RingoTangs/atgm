import type { ServerEnv } from '../config/env'
import type { AdbDatabase, DdbDatabase } from './types'
import { Kysely, MysqlDialect } from 'kysely'
import { createPool } from 'mysql2'

export function createDatabases(env: ServerEnv) {
  const pool = createPool({
    host: env.MYSQL_HOST,
    port: env.MYSQL_PORT,
    user: env.MYSQL_USER,
    password: env.MYSQL_PASSWORD,
    database: env.MYSQL_DL_ADB_ALL,
    waitForConnections: true,
    connectionLimit: 10,
  })

  const db = new Kysely<AdbDatabase>({
    dialect: new MysqlDialect({ pool }),
  })

  const adbDb = db.$pickTables<'account'>().withSchema(env.MYSQL_DL_ADB_ALL)
  const ddbDb: Kysely<DdbDatabase> = db
    .$pickTables<never>()
    .withSchema(env.MYSQL_DL_DDB_1)

  return { db, adbDb, ddbDb }
}
