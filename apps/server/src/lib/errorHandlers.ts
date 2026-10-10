import type { FastifyInstance, FastifyReply, FastifyRequest } from 'fastify'
import { errorCodes, errorSchema } from '@atgm/contracts'
import { hasZodFastifySchemaValidationErrors } from 'fastify-type-provider-zod'
import { ZodError } from 'zod'

export function handleServerError(
  error: unknown,
  request: FastifyRequest,
  reply: FastifyReply,
) {
  if (error instanceof ZodError) {
    return reply.code(400).send(
      errorSchema.parse({
        code: errorCodes.VALIDATION_ERROR,
        message: error.issues
          .map((issue) => `${issue.path.join('.')}: ${issue.message}`)
          .join('; '),
      }),
    )
  }

  if (
    hasZodFastifySchemaValidationErrors(error) ||
    (error instanceof Error &&
      'validation' in error &&
      Array.isArray(error.validation))
  ) {
    return reply.code(400).send(
      errorSchema.parse({
        code: errorCodes.VALIDATION_ERROR,
        message: error.message,
      }),
    )
  }

  if (
    error instanceof Error &&
    'statusCode' in error &&
    typeof error.statusCode === 'number' &&
    error.statusCode >= 400 &&
    error.statusCode < 500
  ) {
    return reply.code(error.statusCode).send(
      errorSchema.parse({
        code:
          error.statusCode === 400
            ? errorCodes.VALIDATION_ERROR
            : errorCodes.REQUEST_ERROR,
        message: error.message,
      }),
    )
  }

  request.log.error({ err: error }, 'Unhandled server error')
  return reply.code(500).send(
    errorSchema.parse({
      code: errorCodes.INTERNAL_SERVER_ERROR,
      message: 'Internal Server Error',
    }),
  )
}

export function registerErrorHandlers(app: FastifyInstance) {
  app.setErrorHandler(handleServerError)

  app.setNotFoundHandler((_request, reply) => {
    return reply.code(404).send(
      errorSchema.parse({
        code: errorCodes.ROUTE_NOT_FOUND,
        message: '路由不存在',
      }),
    )
  })
}
