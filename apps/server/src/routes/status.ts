import type { FastifyInstance } from 'fastify'
import type { ZodTypeProvider } from 'fastify-type-provider-zod'
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
        },
      },
    },
    async () => ({
      status: 'ok' as const,
    }),
  )
}
