import swagger from '@fastify/swagger'
import swaggerUi from '@fastify/swagger-ui'
import Fastify from 'fastify'
import {
  jsonSchemaTransform,
  serializerCompiler,
  validatorCompiler,
} from 'fastify-type-provider-zod'
import { isDevelopment } from './env'
import { accountRoutes } from './routes/accounts'
import { statusRoutes } from './routes/status'

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

  app.register(statusRoutes)

  if (development) {
    app.register(accountRoutes, { prefix: '/api' })
  }

  return app
}
