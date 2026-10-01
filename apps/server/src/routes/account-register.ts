import type { FastifyInstance } from 'fastify'
import type { ZodTypeProvider } from 'fastify-type-provider-zod'
import {
  accountConflictResponseSchema,
  registerAccountBodySchema,
  registerAccountResponseSchema,
} from '@atgm/contracts'
import { createAccountChecksum, createAccountPassword } from './account-crypto'

function formatGameDateTime(date: Date): string {
  const pad = (value: number) => String(value).padStart(2, '0')

  return [
    date.getFullYear(),
    pad(date.getMonth() + 1),
    pad(date.getDate()),
    pad(date.getHours()),
    pad(date.getMinutes()),
    pad(date.getSeconds()),
  ].join('')
}

function isDuplicateEntryError(error: unknown): boolean {
  return (
    error instanceof Error &&
    (('code' in error && error.code === 'ER_DUP_ENTRY') ||
      ('errno' in error && error.errno === 1062))
  )
}

export async function accountRegisterRoutes(app: FastifyInstance) {
  app.withTypeProvider<ZodTypeProvider>().post(
    '/account',
    {
      schema: {
        tags: ['Account'],
        summary: '注册账号',
        description: '创建 dl_adb_all.account 账号',
        body: registerAccountBodySchema,
        response: {
          201: registerAccountResponseSchema,
          409: accountConflictResponseSchema,
        },
      },
    },
    async (request, reply) => {
      const { account, rawPassword, goldCoin, silverCoin, privilege } =
        request.body
      const regDate = formatGameDateTime(new Date())
      const password = createAccountPassword(account, rawPassword)
      const checksum = createAccountChecksum({
        account,
        password,
        goldCoin,
        silverCoin,
        privilege,
      })

      try {
        await app.db.adb
          .insertInto('account')
          .values({
            account,
            password,
            gold_coin: goldCoin,
            silver_coin: silverCoin,
            privilege,
            reg_date: regDate,
            checksum,
          })
          .executeTakeFirst()
      } catch (error) {
        if (isDuplicateEntryError(error)) {
          return reply.code(409).send({ message: '账号已存在' })
        }

        throw Object.assign(new Error('Internal Server Error'), {
          cause: error,
        })
      }

      return reply.code(201).send({ account })
    },
  )
}
