import type { FastifyInstance } from 'fastify'
import type { ZodTypeProvider } from 'fastify-type-provider-zod'
import { errorResponseSchema } from '@atgm/contracts'
import { afterEach, describe, expect, it } from 'vitest'
import { z } from 'zod'
import { buildApp } from './app'

let app: FastifyInstance

afterEach(async () => {
  await app.close()
})

describe('global error responses', () => {
  it.each([
    { url: '/accounts?page=0', method: 'GET' as const },
    { url: `/accounts/${'a'.repeat(33)}`, method: 'GET' as const },
    { url: '/account', method: 'POST' as const, payload: {} },
  ])('returns a shared validation error for $url', async (request) => {
    app = buildApp()
    const response = await app.inject(request)

    expect(response.statusCode).toBe(400)
    expect(response.json()).toEqual({
      code: 'VALIDATION_ERROR',
      message: expect.any(String),
    })
    expect(errorResponseSchema.safeParse(response.json()).success).toBe(true)
    expect(response.json().message.length).toBeGreaterThan(0)
  })

  it('returns a validation error for invalid JSON', async () => {
    app = buildApp()
    const response = await app.inject({
      method: 'POST',
      url: '/account',
      headers: { 'content-type': 'application/json' },
      payload: '{',
    })

    expect(response.statusCode).toBe(400)
    expect(response.json()).toEqual({
      code: 'VALIDATION_ERROR',
      message: expect.any(String),
    })
  })

  it('returns a validation error for a malformed URL', async () => {
    app = buildApp()
    const response = await app.inject('/accounts/%ZZ')

    expect(response.statusCode).toBe(400)
    expect(response.json()).toEqual({
      code: 'VALIDATION_ERROR',
      message: expect.any(String),
    })
  })

  it('preserves the status for parameters exceeding the router limit', async () => {
    app = buildApp()
    const response = await app.inject(`/accounts/${'a'.repeat(101)}`)

    expect(response.statusCode).toBe(414)
    expect(response.json()).toEqual({
      code: 'REQUEST_ERROR',
      message: expect.any(String),
    })
  })

  it('preserves unsupported media type status with the shared format', async () => {
    app = buildApp()
    const response = await app.inject({
      method: 'POST',
      url: '/account',
      headers: { 'content-type': 'application/unsupported' },
      payload: 'body',
    })

    expect(response.statusCode).toBe(415)
    expect(response.json()).toEqual({
      code: 'REQUEST_ERROR',
      message: expect.any(String),
    })
  })

  it('returns a route-not-found error', async () => {
    app = buildApp()
    const response = await app.inject('/missing-route')

    expect(response.statusCode).toBe(404)
    expect(response.json()).toEqual({
      code: 'ROUTE_NOT_FOUND',
      message: '路由不存在',
    })
  })

  it('returns readable details for a thrown Zod validation error', async () => {
    app = buildApp()
    app.get('/zod-error', async () => z.object({ value: z.string() }).parse({}))
    const response = await app.inject('/zod-error')

    expect(response.statusCode).toBe(400)
    expect(response.json()).toEqual({
      code: 'VALIDATION_ERROR',
      message: expect.stringContaining('value'),
    })
  })

  it('hides unexpected exception details', async () => {
    app = buildApp()
    app.get('/unexpected-error', async () => {
      throw new Error('database password and internal SQL')
    })
    const response = await app.inject('/unexpected-error')

    expect(response.statusCode).toBe(500)
    expect(response.json()).toEqual({
      code: 'INTERNAL_SERVER_ERROR',
      message: 'Internal Server Error',
    })
  })

  it('treats invalid response serialization as a server error', async () => {
    app = buildApp()
    app.withTypeProvider<ZodTypeProvider>().get(
      '/serialization-error',
      {
        schema: {
          response: {
            200: z.object({ value: z.string().min(1) }),
            500: errorResponseSchema,
          },
        },
      },
      async () => ({ value: '' }),
    )
    const response = await app.inject('/serialization-error')

    expect(response.statusCode).toBe(500)
    expect(response.json()).toEqual({
      code: 'INTERNAL_SERVER_ERROR',
      message: 'Internal Server Error',
    })
  })
})
