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
import { handleServerError, registerErrorHandlers } from './lib/errorHandlers'
import { accountPrivilegeRoutes } from './routes/account-privilege'
import { accountRechargeRoutes } from './routes/account-recharge'
import { accountRegisterRoutes } from './routes/account-register'
import { accountRoutes } from './routes/accounts'
import { privilegeRoutes } from './routes/privileges'
import { statusRoutes } from './routes/status'

export function buildApp() {
  const app = Fastify({ logger: true, frameworkErrors: handleServerError })
  const development = isDevelopment()

  app.setValidatorCompiler(validatorCompiler)
  app.setSerializerCompiler(serializerCompiler)
  registerErrorHandlers(app)

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
  app.register(accountRoutes)
  app.register(accountRegisterRoutes)
  app.register(accountRechargeRoutes)
  app.register(accountPrivilegeRoutes)
  app.register(privilegeRoutes)

  return app
}
