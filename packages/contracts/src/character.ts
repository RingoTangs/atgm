import { z } from 'zod'

export const charactersQuerySchema = z.object({
  page: z.coerce.number().int().min(1).default(1),
  pageSize: z.coerce.number().int().min(1).max(100).default(20),
})

export type CharactersQuery = z.infer<typeof charactersQuerySchema>

export const characterListItemSchema = z.object({
  gid: z.string(),
  name: z.string(),
  polar: z.number().int(),
  gender: z.number().int(),
  time: z.string(),
})

export type CharacterListItem = z.infer<typeof characterListItemSchema>

export const charactersResponseSchema = z.object({
  page: z.number().int(),
  pageSize: z.number().int(),
  total: z.number().int().min(0),
  items: z.array(characterListItemSchema),
})

export type CharactersResponse = z.infer<typeof charactersResponseSchema>
