import type { FastifyInstance } from 'fastify'
import type { ZodTypeProvider } from 'fastify-type-provider-zod'
import {
  charactersQuerySchema,
  charactersResponseSchema,
  errorResponseSchema,
} from '@atgm/contracts'
import { LpcParseError, parseLpcValue } from '@atgm/lpc'
import { formatDisplayTime } from '../lib/game-time'

function readCharacterAccount(content: string): string | null {
  const root = parseLpcValue(content)
  if (!(root instanceof Map))
    throw new Error('Character data root must be a mapping')
  const me = root.get('me')
  if (me === undefined) return null
  if (!(me instanceof Map)) throw new Error('me must be a mapping')
  const account = me.get('account')
  if (account === undefined || account === '') return null
  if (typeof account !== 'string')
    throw new Error('me.account must be a string')
  return account
}

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

      const accounts = new Map<string, string | null>()
      if (items.length > 0) {
        const rows = await app.db.ddb
          .selectFrom('data')
          .select(['name', 'content'])
          .where('path', '=', 'user')
          .where('branch', '=', '')
          .where(
            'name',
            'in',
            items.map((item) => item.gid),
          )
          .execute()
        for (const row of rows) {
          try {
            accounts.set(row.name, readCharacterAccount(row.content))
          } catch (cause) {
            const message =
              cause instanceof Error ? cause.message : String(cause)
            const offset =
              cause instanceof LpcParseError ? ` (offset: ${cause.offset})` : ''
            throw new Error(
              `Invalid character data for GID ${row.name}: ${message}${offset}`,
            )
          }
        }
      }

      return {
        page,
        pageSize,
        total,
        items: items.map((item) => ({
          ...item,
          time: formatDisplayTime(item.time),
          account: accounts.get(item.gid) ?? null,
        })),
      }
    },
  )
}
