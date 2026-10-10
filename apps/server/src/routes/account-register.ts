import type { FastifyInstance } from 'fastify'
import type { ZodTypeProvider } from 'fastify-type-provider-zod'
import {
  accountConflictResponseSchema,
  errorCodes,
  errorSchema,
  registerAccountBodySchema,
  registerAccountResponseSchema,
} from '@atgm/contracts'
import {
  createAccountChecksum,
  createAccountPassword,
} from '../lib/account-crypto'
import { formatGameTime } from '../lib/game-time'

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
          400: errorSchema,
          500: errorSchema,
          default: errorSchema,
        },
      },
    },
    async (request, reply) => {
      const { account, rawPassword, goldCoin, silverCoin, privilege } =
        request.body
      const regDate = formatGameTime()
      const password = createAccountPassword(account, rawPassword)
      const checksum = createAccountChecksum({
        account,
        password,
        blockedTime: '0',
        goldCoin,
        silverCoin,
        privilege,
        coinPassword: '',
        unlockCoinPasswordTime: '',
        tradeLockTime: '',
        permitIp: '',
        permitId: '',
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
          return reply.code(409).send({
            code: errorCodes.ACCOUNT_ALREADY_EXISTS,
            message: '账号已存在',
          })
        }

        throw error
      }

      return reply.code(201).send({ account })
    },
  )
}
