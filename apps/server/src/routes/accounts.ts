import type { FastifyInstance } from 'fastify'
import type { ZodTypeProvider } from 'fastify-type-provider-zod'
import { sql } from 'kysely'
import { z } from 'zod'

const accountsQuerySchema = z.object({
  page: z.coerce.number().int().min(1).default(1),
  pageSize: z.coerce.number().int().min(1).max(100).default(20),
  account: z.string().trim().optional(),
})

const accountsResponseSchema = z.object({
  page: z.number().int(),
  pageSize: z.number().int(),
  total: z.number().int().min(0),
  items: z.array(
    z.object({
      account: z.string(),
      privilege: z.number().int(),
      gold_coin: z.number().int(),
      silver_coin: z.number().int(),
      last_login_time: z.string(),
      last_login_ip: z.string(),
      reg_date: z.string(),
    }),
  ),
})

const escapeLikePattern = (value: string): string =>
  value.replace(/[!%_]/g, (character) => `!${character}`)

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
      const { account, page, pageSize } = request.query

      let itemsQuery = app.db.adb
        .selectFrom('account')
        .select([
          'account',
          'privilege',
          'gold_coin',
          'silver_coin',
          'last_login_time',
          'last_login_ip',
          'reg_date',
        ])

      let countQuery = app.db.adb
        .selectFrom('account')
        .select((expressionBuilder) =>
          expressionBuilder.fn.countAll().as('total'),
        )

      if (account) {
        const pattern = `%${escapeLikePattern(account)}%`
        const accountPredicate = sql<boolean>`${sql.ref('account')} like ${pattern} escape '!'`

        itemsQuery = itemsQuery.where(accountPredicate)
        countQuery = countQuery.where(accountPredicate)
      }

      const [countResult, items] = await Promise.all([
        countQuery.executeTakeFirstOrThrow(),
        itemsQuery
          .orderBy('account')
          .limit(pageSize)
          .offset((page - 1) * pageSize)
          .execute(),
      ])

      const total = Number(countResult.total)

      if (!Number.isSafeInteger(total) || total < 0) {
        throw new Error('Invalid account count returned by database')
      }

      return {
        page,
        pageSize,
        total,
        items,
      }
    },
  )
}
