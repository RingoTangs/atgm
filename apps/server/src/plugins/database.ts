import type { FastifyInstance } from 'fastify'
import type { ServerEnv } from '../config/env'
import type { FastifyDatabases } from '../db/types'
import { createDatabases } from '../db'

declare module 'fastify' {
  interface FastifyInstance {
    db: FastifyDatabases
  }
}

export function registerDatabase(app: FastifyInstance, env: ServerEnv): void {
  const { db, accountDb, gameDb } = createDatabases(env)

  app.decorate('db', {
    account: accountDb,
    game: gameDb,
  })

  app.addHook('onClose', async () => {
    await db.destroy()
  })
}
