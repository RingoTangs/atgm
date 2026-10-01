import { z } from 'zod'

export const accountsQuerySchema = z.object({
  page: z.coerce.number().int().min(1).default(1),
  pageSize: z.coerce.number().int().min(1).max(100).default(20),
  account: z.string().trim().optional(),
})

export type AccountsQuery = z.infer<typeof accountsQuerySchema>

export const accountListItemSchema = z.object({
  account: z.string(),
  privilege: z.number().int(),
  gold_coin: z.number().int(),
  silver_coin: z.number().int(),
  last_login_time: z.string(),
  last_login_ip: z.string(),
  reg_date: z.string(),
})

export type AccountListItemDto = z.infer<typeof accountListItemSchema>

export const accountsResponseSchema = z.object({
  page: z.number().int(),
  pageSize: z.number().int(),
  total: z.number().int().min(0),
  items: z.array(accountListItemSchema),
})

export type AccountsResponse = z.infer<typeof accountsResponseSchema>

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
