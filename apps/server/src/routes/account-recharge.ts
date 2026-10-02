import type { FastifyInstance } from 'fastify'
import type { ZodTypeProvider } from 'fastify-type-provider-zod'
import {
  accountDetailParamsSchema,
  accountNotFoundResponseSchema,
  accountRechargeConflictResponseSchema,
  rechargeAccountBodySchema,
  rechargeAccountResponseSchema,
} from '@atgm/contracts'
import { createAccountChecksum } from '../lib/account-crypto'

const COIN_MAX = 2_000_000_000

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

export async function accountRechargeRoutes(app: FastifyInstance) {
  app.withTypeProvider<ZodTypeProvider>().patch(
    '/accounts/:account/recharge',
    {
      schema: {
        tags: ['Account'],
        summary: '充值账号金币和银币',
        description: '增加账号金币和银币，并重新计算 checksum',
        params: accountDetailParamsSchema,
        body: rechargeAccountBodySchema,
        response: {
          200: rechargeAccountResponseSchema,
          404: accountNotFoundResponseSchema,
          409: accountRechargeConflictResponseSchema,
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

      const onlineRow = await app.db.ddb
        .selectFrom('data')
        .select('name')
        .where('path', '=', 'runtime')
        .where('name', '=', item.account)
        .executeTakeFirst()

      if (onlineRow) {
        return reply.code(409).send({ message: '账号当前在线，无法修改' })
      }

      const nextGoldCoin = item.gold_coin + request.body.goldCoinAmount
      const nextSilverCoin = item.silver_coin + request.body.silverCoinAmount

      if (nextGoldCoin > COIN_MAX || nextSilverCoin > COIN_MAX) {
        return reply
          .code(409)
          .send({ message: '充值后金币或银币不能超过 20 亿' })
      }

      const nextChecksum = createAccountChecksum({
        account: item.account,
        password: item.password,
        privilege: item.privilege,
        blockedTime: item.blocked_time,
        goldCoin: nextGoldCoin,
        silverCoin: nextSilverCoin,
        coinPassword: item.coin_password,
        unlockCoinPasswordTime: item.unlock_coin_password_time,
        tradeLockTime: item.trade_lock_time,
        permitIp: item.permit_ip,
        permitId: item.permit_id,
      })

      const result = await app.db.adb
        .updateTable('account')
        .set({
          gold_coin: nextGoldCoin,
          silver_coin: nextSilverCoin,
          checksum: nextChecksum,
        })
        .where('account', '=', item.account)
        .where('checksum', '=', item.checksum)
        .executeTakeFirst()

      if (result.numUpdatedRows === 0n) {
        return reply.code(409).send({ message: '账号数据已发生变化，请重试' })
      }

      return {
        account: item.account,
        goldCoin: nextGoldCoin,
        silverCoin: nextSilverCoin,
      }
    },
  )
}
