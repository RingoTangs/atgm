import { z } from 'zod'
import { errorCodes, errorResponseSchema } from './error'

export const ACCOUNT_COIN_MIN = 0
export const ACCOUNT_COIN_MAX = 2_000_000_000

export const accountsQuerySchema = z.object({
  page: z.coerce.number().int().min(1).default(1),
  pageSize: z.coerce.number().int().min(1).max(100).default(20),
  account: z.string().trim().optional(),
})

export type AccountsQuery = z.infer<typeof accountsQuerySchema>

export const accountListItemSchema = z.object({
  account: z.string(),
  online: z.boolean(),
  privilege: z.number().int(),
  goldCoin: z.number().int(),
  silverCoin: z.number().int(),
  lastLoginTime: z.string(),
  lastLoginIp: z.string(),
  regDate: z.string(),
})

export type AccountListItem = z.infer<typeof accountListItemSchema>

export const accountsResponseSchema = z.object({
  page: z.number().int(),
  pageSize: z.number().int(),
  total: z.number().int().min(0),
  items: z.array(accountListItemSchema),
})

export type AccountsResponse = z.infer<typeof accountsResponseSchema>

export const accountDetailParamsSchema = z.object({
  account: z.string().min(1).max(32),
})

export type AccountDetailParams = z.infer<typeof accountDetailParamsSchema>

export const accountDetailResponseSchema = z.object({
  account: z.string(),
  online: z.boolean(),
  privilege: z.number().int(),
  goldCoin: z.number().int(),
  silverCoin: z.number().int(),
  blockedTime: z.string(),
  blockedReason: z.string(),
  tempBlockedTime: z.string(),
  tempBlockedReason: z.string(),
  firstLoginTime: z.string(),
  firstLoginMac: z.string(),
  lastLoginTime: z.string(),
  lastLoginIp: z.string(),
  lastLoginId: z.string(),
  regDate: z.string(),
})

export type AccountDetailResponse = z.infer<typeof accountDetailResponseSchema>

export const accountNotFoundResponseSchema = errorResponseSchema.extend({
  code: z.literal(errorCodes.ACCOUNT_NOT_FOUND),
})

export type AccountNotFoundResponse = z.infer<
  typeof accountNotFoundResponseSchema
>

export const updateAccountBodySchema = z
  .object({
    privilege: z.number().int().min(0).max(1000),
    goldCoin: z.number().int().min(ACCOUNT_COIN_MIN).max(ACCOUNT_COIN_MAX),
    silverCoin: z.number().int().min(ACCOUNT_COIN_MIN).max(ACCOUNT_COIN_MAX),
  })
  .strict()

export type UpdateAccountRequest = z.infer<typeof updateAccountBodySchema>

export const updateAccountResponseSchema = z.object({
  account: z.string(),
})

export type UpdateAccountResponse = z.infer<typeof updateAccountResponseSchema>

export const accountUpdateConflictResponseSchema = errorResponseSchema.extend({
  code: z.enum([
    errorCodes.ACCOUNT_CHECKSUM_INVALID,
    errorCodes.ACCOUNT_CONCURRENT_MODIFICATION,
    errorCodes.ACCOUNT_ONLINE,
  ]),
})

export type AccountUpdateConflictResponse = z.infer<
  typeof accountUpdateConflictResponseSchema
>

export const rechargeAccountBodySchema = z
  .object({
    goldCoinAmount: z
      .number()
      .int()
      .min(ACCOUNT_COIN_MIN)
      .max(ACCOUNT_COIN_MAX),
    silverCoinAmount: z
      .number()
      .int()
      .min(ACCOUNT_COIN_MIN)
      .max(ACCOUNT_COIN_MAX),
  })
  .strict()
  .refine(
    ({ goldCoinAmount, silverCoinAmount }) =>
      goldCoinAmount !== 0 || silverCoinAmount !== 0,
    { message: '金币和银币充值数量不能同时为 0' },
  )

export type RechargeAccountRequest = z.infer<typeof rechargeAccountBodySchema>

export const rechargeAccountResponseSchema = z.object({
  account: z.string(),
  goldCoin: z.number().int(),
  silverCoin: z.number().int(),
})

export type RechargeAccountResponse = z.infer<
  typeof rechargeAccountResponseSchema
>

export const accountRechargeConflictResponseSchema = errorResponseSchema.extend(
  {
    code: z.enum([
      errorCodes.ACCOUNT_CHECKSUM_INVALID,
      errorCodes.ACCOUNT_CONCURRENT_MODIFICATION,
      errorCodes.ACCOUNT_ONLINE,
      errorCodes.ACCOUNT_COIN_LIMIT_EXCEEDED,
    ]),
  },
)

export type AccountRechargeConflictResponse = z.infer<
  typeof accountRechargeConflictResponseSchema
>

export const registerAccountBodySchema = z
  .object({
    account: z.string().min(1).max(32),
    rawPassword: z.string().min(1),
    goldCoin: z.number().int().min(ACCOUNT_COIN_MIN).max(ACCOUNT_COIN_MAX),
    silverCoin: z.number().int().min(ACCOUNT_COIN_MIN).max(ACCOUNT_COIN_MAX),
    privilege: z.number().int().min(0).max(1000),
  })
  .strict()

export type RegisterAccountRequest = z.infer<typeof registerAccountBodySchema>

export const registerAccountResponseSchema = z.object({
  account: z.string(),
})

export type RegisterAccountResponse = z.infer<
  typeof registerAccountResponseSchema
>

export const accountConflictResponseSchema = errorResponseSchema.extend({
  code: z.literal(errorCodes.ACCOUNT_ALREADY_EXISTS),
})

export type AccountConflictResponse = z.infer<
  typeof accountConflictResponseSchema
>
