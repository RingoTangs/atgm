import type { FastifyInstance } from 'fastify'
import type { ZodTypeProvider } from 'fastify-type-provider-zod'
import {
  accountDetailParamsSchema,
  accountNotFoundResponseSchema,
  accountUpdateConflictResponseSchema,
  updateAccountBodySchema,
  updateAccountResponseSchema,
} from '@atgm/contracts'
import { createAccountChecksum } from '../lib/account-crypto'

const checksumFields = [
  'account',
  'password',
  'privilege',
  'blocked_time',
  'gold_coin',
  'silver_coin',
  'coin_password',
  'unlock_coin_password_time',
  'trade_lock_time',
  'permit_ip',
  'permit_id',
  'checksum',
] as const

export async function accountUpdateRoutes(app: FastifyInstance) {
  app.withTypeProvider<ZodTypeProvider>().patch(
    '/accounts/:account',
    {
      schema: {
        tags: ['Account'],
        summary: '修改账号核心信息',
        description: '修改账号权限、金币和银币，并重新计算 checksum',
        params: accountDetailParamsSchema,
        body: updateAccountBodySchema,
        response: {
          200: updateAccountResponseSchema,
          404: accountNotFoundResponseSchema,
          409: accountUpdateConflictResponseSchema,
        },
      },
    },
    async (request, reply) => {
      const item = await app.db.adb
        .selectFrom('account')
        .select(checksumFields)
        .where('account', '=', request.params.account)
        .executeTakeFirst()

      if (!item) {
        return reply.code(404).send({ message: '账号不存在' })
      }

      const currentChecksum = createAccountChecksum({
        account: item.account,
        password: item.password,
        privilege: item.privilege,
        blockedTime: item.blocked_time,
        goldCoin: item.gold_coin,
        silverCoin: item.silver_coin,
        coinPassword: item.coin_password,
        unlockCoinPasswordTime: item.unlock_coin_password_time,
        tradeLockTime: item.trade_lock_time,
        permitIp: item.permit_ip,
        permitId: item.permit_id,
      })

      if (currentChecksum !== item.checksum) {
        return reply.code(409).send({ message: '账号数据校验失败' })
      }

      const { privilege, goldCoin, silverCoin } = request.body
      const unchanged =
        privilege === item.privilege &&
        goldCoin === item.gold_coin &&
        silverCoin === item.silver_coin

      if (unchanged) {
        return { account: item.account }
      }

      const nextChecksum = createAccountChecksum({
        account: item.account,
        password: item.password,
        privilege,
        blockedTime: item.blocked_time,
        goldCoin,
        silverCoin,
        coinPassword: item.coin_password,
        unlockCoinPasswordTime: item.unlock_coin_password_time,
        tradeLockTime: item.trade_lock_time,
        permitIp: item.permit_ip,
        permitId: item.permit_id,
      })

      const result = await app.db.adb
        .updateTable('account')
        .set({
          privilege,
          gold_coin: goldCoin,
          silver_coin: silverCoin,
          checksum: nextChecksum,
        })
        .where('account', '=', item.account)
        .where('checksum', '=', item.checksum)
        .executeTakeFirst()

      if (result.numUpdatedRows === 0n) {
        return reply.code(409).send({ message: '账号数据已发生变化，请重试' })
      }

      return { account: item.account }
    },
  )
}
