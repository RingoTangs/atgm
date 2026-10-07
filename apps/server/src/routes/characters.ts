import type { FastifyInstance } from 'fastify'
import type { ZodTypeProvider } from 'fastify-type-provider-zod'
import {
  charactersQuerySchema,
  charactersResponseSchema,
  errorResponseSchema,
} from '@atgm/contracts'
import { formatDisplayTime } from '../lib/game-time'

export async function characterRoutes(app: FastifyInstance) {
  app.withTypeProvider<ZodTypeProvider>().get(
    '/characters',
    {
      schema: {
        tags: ['Character'],
        summary: '查询角色列表',
        description: '分页查询 dl_ddb_1.basic_char_info',
        querystring: charactersQuerySchema,
        response: {
          200: charactersResponseSchema,
          400: errorResponseSchema,
          500: errorResponseSchema,
          default: errorResponseSchema,
        },
      },
    },
    async (request) => {
      const { page, pageSize } = request.query
      const [countResult, items] = await Promise.all([
        app.db.ddb
          .selectFrom('basic_char_info')
          .select((expressionBuilder) =>
            expressionBuilder.fn.countAll().as('total'),
          )
          .executeTakeFirstOrThrow(),
        app.db.ddb
          .selectFrom('basic_char_info')
          .select(['gid', 'name', 'polar', 'gender', 'time'])
          .orderBy('gid')
          .limit(pageSize)
          .offset((page - 1) * pageSize)
          .execute(),
      ])

      const total = Number(countResult.total)
      if (!Number.isSafeInteger(total) || total < 0) {
        throw new Error('Invalid character count returned by database')
      }

      return {
        page,
        pageSize,
        total,
        items: items.map((item) => ({
          ...item,
          time: formatDisplayTime(item.time),
        })),
      }
    },
  )
}
