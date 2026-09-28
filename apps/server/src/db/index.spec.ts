import { afterEach, describe, expect, it } from 'vitest'
import { createDatabases } from '.'
import { parseServerEnv } from '../config/env'

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
