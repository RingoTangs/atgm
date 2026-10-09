import { z } from 'zod'
import { paginatedResponseSchema, paginationQuerySchema } from './pagination'

export const CHARACTER_POLAR_LABELS = {
  1: '金',
  2: '木',
  3: '水',
  4: '火',
  5: '土',
} as const

export const CHARACTER_GENDER_LABELS = {
  1: '男',
  2: '女',
} as const

export const charactersQuerySchema = paginationQuerySchema

export type CharactersQuery = z.infer<typeof charactersQuerySchema>

export const characterListItemSchema = z.object({
  gid: z.string(),
  name: z.string(),
  polar: z.number().int(),
  gender: z.number().int(),
  time: z.string(),
})

export type CharacterListItem = z.infer<typeof characterListItemSchema>

export const characterWithAccountSchema = characterListItemSchema.extend({
  account: z.string().nullable(),
})

export type CharacterWithAccount = z.infer<typeof characterWithAccountSchema>

export const charactersResponseSchema = paginatedResponseSchema(
  characterWithAccountSchema,
)

export type CharactersResponse = z.infer<typeof charactersResponseSchema>
