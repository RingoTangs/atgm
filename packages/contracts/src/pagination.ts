import {
  pageQuerySchema as basePageQuerySchema,
  DEFAULT_PAGE_SIZE,
} from '@ringotangs/api-shapes'
import { z } from 'zod'

export type { PageQuery } from '@ringotangs/api-shapes'
export {
  createPageSchema,
  DEFAULT_PAGE,
  DEFAULT_PAGE_SIZE,
} from '@ringotangs/api-shapes'

export const pageQuerySchema = basePageQuerySchema.extend({
  pageSize: z.coerce.number().int().min(1).max(100).default(DEFAULT_PAGE_SIZE),
})
