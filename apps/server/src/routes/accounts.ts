import type { FastifyInstance } from 'fastify'
import type { ZodTypeProvider } from 'fastify-type-provider-zod'
import {
  accountCharactersResponseSchema,
  accountDetailParamsSchema,
  accountDetailResponseSchema,
  accountNotFoundResponseSchema,
  accountsQuerySchema,
  accountsResponseSchema,
  errorCodes,
  errorSchema,
} from '@atgm/contracts'
import { sql } from 'kysely'
import { getOnlineAccounts, isAccountOnline } from '../lib/account-status'
import { formatDisplayTime } from '../lib/game-time'
import { parseLoginData } from '../lib/login-data'

const escapeLikePattern = (value: string): string =>
  value.replace(/[!%_]/g, (character) => `!${character}`)

export async function accountRoutes(app: FastifyInstance) {
  app.withTypeProvider<ZodTypeProvider>().get(
    '/accounts/:account/characters',
    {
      schema: {
        tags: ['Account'],
        summary: '查询账号关联角色',
        description: '根据账号 login 数据查询关联角色，保留角色顺序',
        params: accountDetailParamsSchema,
        response: {
          200: accountCharactersResponseSchema,
          400: errorSchema,
          404: accountNotFoundResponseSchema,
          500: errorSchema,
          default: errorSchema,
        },
      },
    },
    async (request, reply) => {
      const { account } = request.params
      const accountRow = await app.db.adb
        .selectFrom('account')
        .select('account')
        .where('account', '=', account)
        .executeTakeFirst()
      if (!accountRow) {
        return reply.code(404).send({
          code: errorCodes.ACCOUNT_NOT_FOUND,
          message: '账号不存在',
        })
      }

      const loginRow = await app.db.ddb
        .selectFrom('data')
        .select('content')
        .where('path', '=', 'login')
        .where('name', '=', account)
        .where('branch', '=', '')
        .executeTakeFirst()
      if (!loginRow) return { recRole: null, chars: [] }

      const loginData = parseLoginData(loginRow.content)
      if (loginData.chars.length === 0)
        return { recRole: loginData.recRole, chars: [] }

      const rows = await app.db.ddb
        .selectFrom('basic_char_info')
        .select(['gid', 'name', 'polar', 'gender', 'time'])
        .where('gid', 'in', loginData.chars)
        .execute()
      const rowsByGid = new Map(rows.map((row) => [row.gid, row]))
      return {
        recRole: loginData.recRole,
        chars: loginData.chars.flatMap((gid) => {
          const row = rowsByGid.get(gid)
          return row ? [{ ...row, time: formatDisplayTime(row.time) }] : []
        }),
      }
    },
  )

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
          400: errorSchema,
          500: errorSchema,
          default: errorSchema,
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

      const onlineAccounts = await getOnlineAccounts(
        app.db.ddb,
        items.map((item) => item.account),
      )

      return {
        page,
        pageSize,
        total,
        items: items.map((item) => ({
          account: item.account,
          online: onlineAccounts.has(item.account),
          privilege: item.privilege,
          goldCoin: item.gold_coin,
          silverCoin: item.silver_coin,
          lastLoginTime: formatDisplayTime(item.last_login_time),
          lastLoginIp: item.last_login_ip,
          regDate: formatDisplayTime(item.reg_date),
        })),
      }
    },
  )

  app.withTypeProvider<ZodTypeProvider>().get(
    '/accounts/:account',
    {
      schema: {
        tags: ['Account'],
        summary: '查询账号详情',
        description: '按账号查询 dl_adb_all.account',
        params: accountDetailParamsSchema,
        response: {
          200: accountDetailResponseSchema,
          404: accountNotFoundResponseSchema,
          400: errorSchema,
          500: errorSchema,
          default: errorSchema,
        },
      },
    },
    async (request, reply) => {
      const item = await app.db.adb
        .selectFrom('account')
        .select([
          'account',
          'privilege',
          'gold_coin',
          'silver_coin',
          'blocked_time',
          'blocked_reason',
          'temp_blocked_time',
          'temp_blocked_reason',
          'first_login_time',
          'first_login_mac',
          'last_login_time',
          'last_login_ip',
          'last_login_id',
          'reg_date',
        ])
        .where('account', '=', request.params.account)
        .executeTakeFirst()

      if (!item) {
        return reply
          .code(404)
          .send({ code: errorCodes.ACCOUNT_NOT_FOUND, message: '账号不存在' })
      }

      const online = await isAccountOnline(app.db.ddb, item.account)

      return {
        account: item.account,
        online,
        privilege: item.privilege,
        goldCoin: item.gold_coin,
        silverCoin: item.silver_coin,
        blockedTime: formatDisplayTime(item.blocked_time),
        blockedReason: item.blocked_reason,
        tempBlockedTime: formatDisplayTime(item.temp_blocked_time),
        tempBlockedReason: item.temp_blocked_reason,
        firstLoginTime: formatDisplayTime(item.first_login_time),
        firstLoginMac: item.first_login_mac,
        lastLoginTime: formatDisplayTime(item.last_login_time),
        lastLoginIp: item.last_login_ip,
        lastLoginId: item.last_login_id,
        regDate: formatDisplayTime(item.reg_date),
      }
    },
  )
}
