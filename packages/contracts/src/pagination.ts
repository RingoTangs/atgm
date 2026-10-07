import { z } from 'zod'

export const PAGINATION_DEFAULT_PAGE = 1
export const PAGINATION_DEFAULT_PAGE_SIZE = 20

export const paginationQuerySchema = z.object({
  page: z.coerce.number().int().min(1).default(PAGINATION_DEFAULT_PAGE),
  pageSize: z.coerce
    .number()
    .int()
    .min(1)
    .max(100)
    .default(PAGINATION_DEFAULT_PAGE_SIZE),
})

export type PaginationQuery = z.infer<typeof paginationQuerySchema>

export const paginatedResponseSchema = <T extends z.ZodType>(itemSchema: T) =>
  z.object({
    page: z.number().int(),
    pageSize: z.number().int(),
    total: z.number().int().min(0),
    items: z.array(itemSchema),
  })
