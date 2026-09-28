import swagger from '@fastify/swagger'
import swaggerUi from '@fastify/swagger-ui'
import Fastify from 'fastify'
import { isDevelopment } from './config/runtime-env'
import { accountRoutes } from './routes/accounts'

export function buildApp() {
  const app = Fastify({
    logger: true,
  })

  if (isDevelopment()) {
    app.register(swagger, {
      openapi: {
        info: {
          title: 'ATGM API',
          description: 'AskTao Game Management API',
          version: '0.1.0',
        },
      },
    })
    app.register(swaggerUi, {
      routePrefix: '/docs',
    })
  }

  app.register((routeApp, _options, done) => {
    routeApp.get(
      '/',
      {
        schema: {
          tags: ['System'],
          summary: '服务状态',
          description: '返回服务状态示例',
          response: {
            200: {
              type: 'object',
              required: ['hello'],
              properties: {
                hello: { type: 'string' },
              },
            },
          },
        },
      },
      async () => {
        return { hello: 'world' }
      },
    )

    done()
  })

  app.register(accountRoutes, { prefix: '/api' })

  return app
}
