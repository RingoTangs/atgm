import type { FastifyInstance } from 'fastify'
import type { FastifyDatabases } from '../db/types'
import type { ServerEnv } from '../env'
import { createDatabases } from '../db'

declare module 'fastify' {
  interface FastifyInstance {
    db: FastifyDatabases
  }
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
