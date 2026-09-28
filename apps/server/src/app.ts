import swagger from '@fastify/swagger'
import swaggerUi from '@fastify/swagger-ui'
import Fastify from 'fastify'
import {
  jsonSchemaTransform,
  serializerCompiler,
  validatorCompiler,
} from 'fastify-type-provider-zod'
import pkg from '../package.json' with { type: 'json' }
import { isDevelopment } from './env'
import { accountRoutes } from './routes/accounts'
import { registerAccountRoutes } from './routes/register-account'
import { statusRoutes } from './routes/status'

export function buildApp() {
  const app = Fastify({ logger: true })
  const development = isDevelopment()

  app.setValidatorCompiler(validatorCompiler)
  app.setSerializerCompiler(serializerCompiler)

  if (development) {
    app.register(swagger, {
      openapi: {
        info: {
          title: 'Asktao GM API',
          description: 'AskTao Game Management API',
          version: pkg.version,
        },
      },
      transform: jsonSchemaTransform,
    })
    app.register(swaggerUi, { routePrefix: '/docs' })
  }

  app.register(statusRoutes)
  app.register(accountRoutes, { prefix: '/api' })
  app.register(registerAccountRoutes, { prefix: '/api' })

  return app
}
