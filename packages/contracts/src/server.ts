import { z } from 'zod'
import { createPageSchema, pageQuerySchema } from './pagination'

export const serversQuerySchema = pageQuerySchema
export type ServersQuery = z.infer<typeof serversQuerySchema>

export const serverListItemSchema = z.object({
  id: z.number().int(),
  server: z.string(),
  dist: z.string(),
  alias: z.string(),
  ip: z.string(),
  port: z.number().int(),
  maxUser: z.number().int(),
  enable: z.number().int(),
})
export type ServerListItem = z.infer<typeof serverListItemSchema>

export const serversResponseSchema = createPageSchema(serverListItemSchema)
export type ServersResponse = z.infer<typeof serversResponseSchema>
