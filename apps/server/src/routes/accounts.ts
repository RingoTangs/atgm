import type { FastifyInstance } from 'fastify'
import type { ZodTypeProvider } from 'fastify-type-provider-zod'
import { z } from 'zod'

const accountsQuerySchema = z.object({
  page: z.coerce.number().int().min(1).default(1),
  pageSize: z.coerce.number().int().min(1).max(100).default(20),
})

const accountsResponseSchema = z.object({
  page: z.number().int(),
  pageSize: z.number().int(),
  items: z.array(
    z.object({
      account: z.string(),
      last_login_time: z.string(),
    }),
  ),
})

export async function accountRoutes(app: FastifyInstance) {
  app.withTypeProvider<ZodTypeProvider>().get(
    '/accounts',
    {
      schema: {
        tags: ['Account'],
        summary: '查询账号列表',
        description: '分页查询 dl_adb_all.account',
        querystring: accountsQuerySchema,
        response: {
          200: accountsResponseSchema,
        },
      },
    },
    async (request) => {
      const { page, pageSize } = request.query

      const items = await app.db.adb
        .selectFrom('account')
        .select(['account', 'last_login_time'])
        .orderBy('account')
        .limit(pageSize)
        .offset((page - 1) * pageSize)
        .execute()

      return {
        page,
        pageSize,
        items,
      }
    },
  )
}
