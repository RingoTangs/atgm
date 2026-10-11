import type { FastifyInstance } from 'fastify'
import type { ZodTypeProvider } from 'fastify-type-provider-zod'
import {
  errorSchema,
  serversQuerySchema,
  serversResponseSchema,
} from '@atgm/contracts'

export async function serverRoutes(app: FastifyInstance) {
  app.withTypeProvider<ZodTypeProvider>().get(
    '/servers',
    {
      schema: {
        tags: ['Server'],
        summary: '查询游戏服务器配置',
        querystring: serversQuerySchema,
        response: {
          200: serversResponseSchema,
          400: errorSchema,
          500: errorSchema,
          default: errorSchema,
        },
      },
    },
    async (request) => {
      const { page, pageSize } = request.query
      const [countResult, items] = await Promise.all([
        app.db.adb
          .selectFrom('server')
          .select((eb) => eb.fn.countAll().as('total'))
          .executeTakeFirstOrThrow(),
        app.db.adb
          .selectFrom('server')
          .select([
            'id',
            'server',
            'dist',
            'alias',
            'ip',
            'port',
            'max_user',
            'enable',
          ])
          .orderBy('id', 'asc')
          .orderBy('server', 'asc')
          .limit(pageSize)
          .offset((page - 1) * pageSize)
          .execute(),
      ])
      const total = Number(countResult.total)
      if (!Number.isSafeInteger(total) || total < 0) {
        throw new Error('Invalid server count returned by database')
      }
      return {
        page,
        pageSize,
        total,
        items: items.map((item) => ({
          id: item.id,
          server: item.server,
          dist: item.dist,
          alias: item.alias,
          ip: item.ip,
          port: item.port,
          maxUser: item.max_user,
          enable: item.enable,
        })),
      }
    },
  )
}
