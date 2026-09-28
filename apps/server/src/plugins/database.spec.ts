import { describe, expect, it } from 'vitest'
import { buildApp } from '../app'
import { parseServerEnv } from '../config/env'
import { registerDatabase } from './database'

describe('registerDatabase', () => {
  it('decorates Fastify with scoped databases and closes without connecting', async () => {
    const app = buildApp()
    const env = parseServerEnv({
      MYSQL_HOST: '127.0.0.1',
      MYSQL_USER: 'atgm',
      MYSQL_PASSWORD: 'password',
      MYSQL_ACCOUNT_DB: 'account_db',
      MYSQL_GAME_DB: 'game_db',
    })

    registerDatabase(app, env)

    expect(
      app.db.account.selectFrom('users').selectAll().compile().sql,
    ).toContain('`account_db`.`users`')
    expect(
      app.db.game.selectFrom('players').selectAll().compile().sql,
    ).toContain('`game_db`.`players`')

    await app.close()
  })
})
