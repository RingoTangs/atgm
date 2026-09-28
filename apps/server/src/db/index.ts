import type { ServerEnv } from '../config/env'
import type { Database } from './types'
import { Kysely, MysqlDialect } from 'kysely'
import { createPool } from 'mysql2'

export function createDatabases(env: ServerEnv) {
  const pool = createPool({
    host: env.MYSQL_HOST,
    port: env.MYSQL_PORT,
    user: env.MYSQL_USER,
    password: env.MYSQL_PASSWORD,
    database: env.MYSQL_ACCOUNT_DB,
    waitForConnections: true,
    connectionLimit: 10,
  })

  const db = new Kysely<Database>({
    dialect: new MysqlDialect({ pool }),
  })

  const accountDb = db.$pickTables<'users'>().withSchema(env.MYSQL_ACCOUNT_DB)
  const gameDb = db.$pickTables<'players'>().withSchema(env.MYSQL_GAME_DB)

  return { db, accountDb, gameDb }
}
