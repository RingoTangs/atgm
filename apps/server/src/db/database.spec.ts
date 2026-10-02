import { afterEach, describe, expect, it, vi } from 'vitest'
import { createDatabases, registerDatabase } from '.'
import { buildApp } from '../app'
import { parseServerEnv } from '../env'

const mocks = vi.hoisted(() => ({
  createPool: vi.fn(),
}))

vi.mock('mysql2', async (importOriginal) => {
  const actual = await importOriginal<typeof import('mysql2')>()
  mocks.createPool.mockImplementation(actual.createPool)

  return {
    ...actual,
    createPool: mocks.createPool,
  }
})

const databases: Array<{ destroy: () => Promise<void> }> = []

afterEach(async () => {
  await Promise.all(databases.splice(0).map((database) => database.destroy()))
})

describe('createDatabases', () => {
  it('creates ADB and DDB entries on one root instance', () => {
    const env = parseServerEnv({
      MYSQL_HOST: '127.0.0.1',
      MYSQL_USER: 'atgm',
      MYSQL_PASSWORD: 'password',
      MYSQL_DL_ADB_ALL: 'dl_adb_all',
      MYSQL_DL_DDB_1: 'dl_ddb_1',
    })
    const { db, adbDb, ddbDb } = createDatabases(env)
    databases.push(db)

    const accountQuery = adbDb.selectFrom('account').select('account').compile()
    const dataQuery = ddbDb.selectFrom('data').select('name').compile()

    expect(db).toBeDefined()
    expect(adbDb).toBeDefined()
    expect(ddbDb).toBeDefined()
    expect(mocks.createPool).toHaveBeenCalledWith({
      host: '127.0.0.1',
      port: 3306,
      user: 'atgm',
      password: 'password',
      database: 'dl_adb_all',
      waitForConnections: true,
      connectionLimit: 10,
      maxIdle: 2,
      idleTimeout: 30_000,
      enableKeepAlive: true,
      keepAliveInitialDelay: 10_000,
    })
    expect(accountQuery.sql).toContain('`dl_adb_all`.`account`')
    expect(dataQuery.sql).toContain('`dl_ddb_1`.`data`')
  })
})

describe('registerDatabase', () => {
  it('decorates Fastify with scoped databases and closes without connecting', async () => {
    const app = buildApp()
    const env = parseServerEnv({
      MYSQL_HOST: '127.0.0.1',
      MYSQL_USER: 'atgm',
      MYSQL_PASSWORD: 'password',
      MYSQL_DL_ADB_ALL: 'dl_adb_all',
      MYSQL_DL_DDB_1: 'dl_ddb_1',
    })

    registerDatabase(app, env)

    expect(
      app.db.adb.selectFrom('account').select('account').compile().sql,
    ).toContain('`dl_adb_all`.`account`')
    expect(
      app.db.ddb.selectFrom('data').select('name').compile().sql,
    ).toContain('`dl_ddb_1`.`data`')

    await app.close()
  })
})
