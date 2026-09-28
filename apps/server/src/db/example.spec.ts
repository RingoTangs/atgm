import { afterEach, beforeEach, describe, expect, it } from 'vitest'
import {
  createDatabases,
  findAccountByAccount,
  listAccounts,
  listAccountsByLastLoginTime,
} from '.'
import { parseServerEnv } from '../env'

type Databases = ReturnType<typeof createDatabases>

let databases: Databases

beforeEach(() => {
  databases = createDatabases(
    parseServerEnv({
      MYSQL_HOST: '127.0.0.1',
      MYSQL_USER: 'atgm',
      MYSQL_PASSWORD: 'password',
      MYSQL_DL_ADB_ALL: 'dl_adb_all',
      MYSQL_DL_DDB_1: 'dl_ddb_1',
    }),
  )
})

afterEach(async () => {
  await databases.db.destroy()
})

describe('account query examples', () => {
  it('builds a parameterized lookup with only safe columns', () => {
    const query = findAccountByAccount(databases.adbDb, 'example').compile()

    expect(query.sql).toContain('from `dl_adb_all`.`account`')
    expect(query.parameters).toEqual(['example'])
    expect(query.sql).not.toMatch(
      /`password`|`org_password`|`coin_password`|`protect`|`id_num`|`mobile`/,
    )
  })

  it('caps page size and applies offset', () => {
    const query = listAccounts(databases.adbDb, {
      limit: 500,
      offset: 5,
    }).compile()

    expect(query.parameters).toEqual([100, 5])
  })

  it.each([
    [{ limit: 0 }, /limit/],
    [{ limit: 1.5 }, /limit/],
    [{ offset: -1 }, /offset/],
    [{ offset: 1.5 }, /offset/],
  ] as const)('rejects invalid pagination %j', (options, expected) => {
    expect(() => listAccounts(databases.adbDb, options)).toThrow(expected)
  })

  it('builds a bounded last-login-time query', () => {
    const query = listAccountsByLastLoginTime(
      databases.adbDb,
      '20260101000000',
      200,
    ).compile()

    expect(query.sql).toContain('`last_login_time` >= ?')
    expect(query.sql).toContain('order by `last_login_time` desc, `account`')
    expect(query.parameters).toEqual(['20260101000000', 100])
  })
})
