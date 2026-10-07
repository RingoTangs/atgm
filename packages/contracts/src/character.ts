import { z } from 'zod'
import { paginatedResponseSchema, paginationQuerySchema } from './pagination'

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

export const charactersResponseSchema = paginatedResponseSchema(
  characterListItemSchema,
)

export type CharactersResponse = z.infer<typeof charactersResponseSchema>
