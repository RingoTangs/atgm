import { DEFAULT_PAGE_SIZE, pageQuerySchema } from '@ringotangs/api-shapes'
import { z } from 'zod'

export type { PageQuery as PaginationQuery } from '@ringotangs/api-shapes'
export {
  DEFAULT_PAGE,
  DEFAULT_PAGE_SIZE,
  createPageSchema as paginatedResponseSchema,
} from '@ringotangs/api-shapes'

export const paginationQuerySchema = pageQuerySchema.extend({
  pageSize: z.coerce.number().int().min(1).max(100).default(DEFAULT_PAGE_SIZE),
})
