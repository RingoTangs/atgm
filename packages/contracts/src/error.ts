import { z } from 'zod'

export const errorCodes = {
  VALIDATION_ERROR: 'VALIDATION_ERROR',
  ACCOUNT_NOT_FOUND: 'ACCOUNT_NOT_FOUND',
  ACCOUNT_ALREADY_EXISTS: 'ACCOUNT_ALREADY_EXISTS',
  ACCOUNT_ONLINE: 'ACCOUNT_ONLINE',
  ACCOUNT_CHECKSUM_INVALID: 'ACCOUNT_CHECKSUM_INVALID',
  ACCOUNT_CONCURRENT_MODIFICATION: 'ACCOUNT_CONCURRENT_MODIFICATION',
  ACCOUNT_COIN_LIMIT_EXCEEDED: 'ACCOUNT_COIN_LIMIT_EXCEEDED',
  ROUTE_NOT_FOUND: 'ROUTE_NOT_FOUND',
  REQUEST_ERROR: 'REQUEST_ERROR',
  INTERNAL_SERVER_ERROR: 'INTERNAL_SERVER_ERROR',
} as const

export type ErrorCode = (typeof errorCodes)[keyof typeof errorCodes]

export const errorResponseSchema = z.object({
  code: z.string(),
  message: z.string(),
})

export type ErrorResponse = z.infer<typeof errorResponseSchema>
