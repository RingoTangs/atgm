import type { ZodTypeProvider } from 'fastify-type-provider-zod'
import swagger from '@fastify/swagger'
import swaggerUi from '@fastify/swagger-ui'
import Fastify from 'fastify'
import {
  jsonSchemaTransform,
  serializerCompiler,
  validatorCompiler,
} from 'fastify-type-provider-zod'
import { z } from 'zod'
import { isDevelopment } from './config/runtime-env'
import { accountRoutes } from './routes/accounts'

export function buildApp() {
  const app = Fastify({
    logger: true,
  })
  const development = isDevelopment()

  app.setValidatorCompiler(validatorCompiler)
  app.setSerializerCompiler(serializerCompiler)

  if (development) {
    app.register(swagger, {
      openapi: {
        info: {
          title: 'ATGM API',
          description: 'AskTao Game Management API',
          version: '0.1.0',
        },
      },
      transform: jsonSchemaTransform,
    })
    app.register(swaggerUi, {
      routePrefix: '/docs',
    })
  }

  app.register((routeApp, _options, done) => {
    routeApp.withTypeProvider<ZodTypeProvider>().get(
      '/',
      {
        schema: {
          tags: ['System'],
          summary: '服务状态',
          description: '返回服务状态示例',
          response: {
            200: z.object({
              hello: z.string(),
            }),
          },
        },
      },
      async () => {
        return { hello: 'world' }
      },
    )

    done()
  })

  if (development) {
    app.register(accountRoutes, { prefix: '/api' })
  }

  return app
}
