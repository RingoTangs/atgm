import type { FastifyInstance } from 'fastify'

interface AccountsQuery {
  page?: number
  pageSize?: number
}

export async function accountRoutes(app: FastifyInstance) {
  app.get<{ Querystring: AccountsQuery }>(
    '/accounts',
    {
      schema: {
        tags: ['Account'],
        summary: '查询账号列表',
        description: '分页查询 dl_adb_all.account',

        querystring: {
          type: 'object',
          additionalProperties: false,
          properties: {
            page: {
              type: 'integer',
              minimum: 1,
              default: 1,
            },
            pageSize: {
              type: 'integer',
              minimum: 1,
              maximum: 100,
              default: 20,
            },
          },
        },

        response: {
          200: {
            type: 'object',
            required: ['page', 'pageSize', 'items'],
            properties: {
              page: { type: 'integer' },
              pageSize: { type: 'integer' },
              items: {
                type: 'array',
                items: {
                  type: 'object',
                  required: ['account', 'last_login_time'],
                  properties: {
                    account: { type: 'string' },
                    last_login_time: { type: 'string' },
                  },
                },
              },
            },
          },
        },
      },
    },
    async (request) => {
      const { page = 1, pageSize = 20 } = request.query

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
