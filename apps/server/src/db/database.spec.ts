import { afterEach, describe, expect, it } from 'vitest'
import { createDatabases, registerDatabase } from '.'
import { buildApp } from '../app'
import { parseServerEnv } from '../env'

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
    const ddbNamespaceProbe = ddbDb.schema
      .createTable('__namespace_probe__')
      .addColumn('id', 'integer')
      .compile()

    expect(db).toBeDefined()
    expect(adbDb).toBeDefined()
    expect(ddbDb).toBeDefined()
    expect(accountQuery.sql).toContain('`dl_adb_all`.`account`')
    expect(ddbNamespaceProbe.sql).toContain('`dl_ddb_1`.`__namespace_probe__`')
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
      app.db.ddb.schema
        .createTable('__namespace_probe__')
        .addColumn('id', 'integer')
        .compile().sql,
    ).toContain('`dl_ddb_1`.`__namespace_probe__`')

    await app.close()
  })
})
