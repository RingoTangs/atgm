import type { FastifyInstance } from 'fastify'
import type { AdbDatabase, DdbDatabase } from '.'
import type { ServerEnv } from '../env'
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
    maxIdle: 2,
    idleTimeout: 30_000,
    enableKeepAlive: true,
    keepAliveInitialDelay: 10_000,
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

export function registerDatabase(app: FastifyInstance, env: ServerEnv): void {
  const { db, adbDb, ddbDb } = createDatabases(env)

  app.decorate('db', {
    adb: adbDb,
    ddb: ddbDb,
  })

  app.addHook('onClose', async () => {
    await db.destroy()
  })
}
