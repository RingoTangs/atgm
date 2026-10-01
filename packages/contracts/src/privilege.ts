import { z } from 'zod'

export const privilegeSchema = z.object({
  privilege: z.number().int(),
  grant: z.string(),
  constant: z.string(),
  type: z.string(),
  description: z.string(),
})

export type Privilege = z.infer<typeof privilegeSchema>

export const privilegesResponseSchema = z.array(privilegeSchema)

export type PrivilegesResponse = z.infer<typeof privilegesResponseSchema>
