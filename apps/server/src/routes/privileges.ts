import type { FastifyInstance } from 'fastify'
import type { ZodTypeProvider } from 'fastify-type-provider-zod'
import { privilegesResponseSchema } from '@atgm/contracts'
import { ACCOUNT_PRIVILEGES } from '../lib/account-privileges'

export async function privilegeRoutes(app: FastifyInstance) {
  app.withTypeProvider<ZodTypeProvider>().get(
    '/privileges',
    {
      schema: {
        tags: ['Account'],
        summary: '查询账号权限列表',
        description: '查询可用于注册账号的管理和调试权限',
        response: {
          200: privilegesResponseSchema,
        },
      },
    },
    async () => ACCOUNT_PRIVILEGES,
  )
}
