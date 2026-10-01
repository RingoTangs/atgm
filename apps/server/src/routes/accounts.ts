import type { FastifyInstance } from 'fastify'
import type { ZodTypeProvider } from 'fastify-type-provider-zod'
import { accountsQuerySchema, accountsResponseSchema } from '@atgm/contracts'
import { sql } from 'kysely'

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
