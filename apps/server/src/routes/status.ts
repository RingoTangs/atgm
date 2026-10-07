import type { FastifyInstance } from 'fastify'
import type { ZodTypeProvider } from 'fastify-type-provider-zod'
import { errorResponseSchema } from '@atgm/contracts'
import { z } from 'zod'

export async function statusRoutes(app: FastifyInstance) {
  app.withTypeProvider<ZodTypeProvider>().get(
    '/_status',
    {
      schema: {
        tags: ['System'],
        summary: '服务状态',
        description: '检查 HTTP 服务是否正常运行',
        response: {
          200: z.object({
            status: z.literal('ok'),
          }),
          400: errorResponseSchema,
          500: errorResponseSchema,
          default: errorResponseSchema,
        },
      },
    },
    async () => ({
      status: 'ok' as const,
    }),
  )
}
