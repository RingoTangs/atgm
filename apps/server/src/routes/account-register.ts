import type { FastifyInstance } from 'fastify'
import type { ZodTypeProvider } from 'fastify-type-provider-zod'
import { z } from 'zod'
import { createAccountChecksum, createAccountPassword } from './account-crypto'

const registerAccountBodySchema = z
  .object({
    account: z.string().min(1).max(32),
    rawPassword: z.string().min(1),
    goldCoin: z.number().int().min(0).max(2_000_000_000),
    silverCoin: z.number().int().min(0).max(2_000_000_000),
    privilege: z.number().int().min(0).max(1000),
  })
  .strict()

const registerAccountResponseSchema = z.object({
  account: z.string(),
})

const accountConflictResponseSchema = z.object({
  message: z.literal('账号已存在'),
})

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
