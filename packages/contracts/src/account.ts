import { z } from 'zod'

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

export const accountNotFoundResponseSchema = z.object({
  message: z.literal('账号不存在'),
})

export type AccountNotFoundResponse = z.infer<
  typeof accountNotFoundResponseSchema
>

export const updateAccountBodySchema = z
  .object({
    privilege: z.number().int().min(0).max(1000),
    goldCoin: z.number().int().min(0).max(2_000_000_000),
    silverCoin: z.number().int().min(0).max(2_000_000_000),
  })
  .strict()

export type UpdateAccountRequest = z.infer<typeof updateAccountBodySchema>

export const updateAccountResponseSchema = z.object({
  account: z.string(),
})

export type UpdateAccountResponse = z.infer<typeof updateAccountResponseSchema>

export const accountUpdateConflictResponseSchema = z.object({
  message: z.enum(['账号数据校验失败', '账号数据已发生变化，请重试']),
})

export type AccountUpdateConflictResponse = z.infer<
  typeof accountUpdateConflictResponseSchema
>

export const registerAccountBodySchema = z
  .object({
    account: z.string().min(1).max(32),
    rawPassword: z.string().min(1),
    goldCoin: z.number().int().min(0).max(2_000_000_000),
    silverCoin: z.number().int().min(0).max(2_000_000_000),
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

export const accountConflictResponseSchema = z.object({
  message: z.literal('账号已存在'),
})

export type AccountConflictResponse = z.infer<
  typeof accountConflictResponseSchema
>
