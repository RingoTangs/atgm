import type { Insertable } from 'kysely'
import type { PlayerTable } from './types'
import { afterEach, describe, expect, expectTypeOf, it } from 'vitest'
import { createDatabases } from '.'
import { parseServerEnv } from '../config/env'

const databases: Array<{ destroy: () => Promise<void> }> = []

afterEach(async () => {
  await Promise.all(databases.splice(0).map((database) => database.destroy()))
})

describe('createDatabases', () => {
  it('creates database-scoped query entries without connecting to MySQL', () => {
    const env = parseServerEnv({
      MYSQL_HOST: '127.0.0.1',
      MYSQL_USER: 'atgm',
      MYSQL_PASSWORD: 'password',
      MYSQL_ACCOUNT_DB: 'account_db',
      MYSQL_GAME_DB: 'game_db',
    })
    const { db, accountDb, gameDb } = createDatabases(env)
    databases.push(db)

    const accountQuery = accountDb.selectFrom('users').selectAll().compile()
    const gameQuery = gameDb.selectFrom('players').selectAll().compile()

    expect(accountQuery.sql).toContain('`account_db`.`users`')
    expect(gameQuery.sql).toContain('`game_db`.`players`')
  })

  it('keeps generated ids optional for inserts', () => {
    const player = {
      account_id: 1,
      level: 1,
    }

    expectTypeOf(player).toMatchTypeOf<Insertable<PlayerTable>>()
  })
})
