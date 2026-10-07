import type { FastifyInstance } from 'fastify'
import type { AdbDatabase, DdbDatabase } from '.'
import type { ServerEnv } from '../env'
import { Kysely, MysqlDialect } from 'kysely'
import { createPool } from 'mysql2'
import { mysqlTypeCast } from './mysql-type-cast'

export function createDatabases(env: ServerEnv) {
  const pool = createPool({
    host: env.MYSQL_HOST,
    port: env.MYSQL_PORT,
    user: env.MYSQL_USER,
    password: env.MYSQL_PASSWORD,
    database: env.MYSQL_DL_ADB_ALL,
    typeCast: mysqlTypeCast,
    // 连接达到上限时等待可用连接
    waitForConnections: true,
    // 连接池最多创建 10 个连接
    connectionLimit: 10,
    // 最多保留 2 个空闲连接
    maxIdle: 2,
    // 空闲连接 30 秒后回收
    idleTimeout: 30_000,
    // 启用 TCP 保活，帮助发现失效连接
    enableKeepAlive: true,
    // 10 秒后开始发送保活探测
    keepAliveInitialDelay: 10_000,
  })

  const db = new Kysely<AdbDatabase & DdbDatabase>({
    dialect: new MysqlDialect({ pool }),
  })

  const adbDb = db.$pickTables<'account'>().withSchema(env.MYSQL_DL_ADB_ALL)
  const ddbDb = db
    .$pickTables<'data' | 'basic_char_info'>()
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
