import { afterAll, describe, expect, it, vi } from 'vitest'
import { buildApp } from './app'

function buildAppFor(nodeEnv: string) {
  vi.stubEnv('NODE_ENV', nodeEnv)

  try {
    return buildApp()
  } finally {
    vi.unstubAllEnvs()
  }
}

const developmentApp = buildAppFor('test')
const productionApp = buildAppFor('production')

afterAll(async () => {
  await Promise.all([developmentApp.close(), productionApp.close()])
})

describe('app', () => {
  it.each([
    ['development', developmentApp],
    ['production', productionApp],
  ])('returns hello world in %s', async (_environment, app) => {
    const response = await app.inject({
      method: 'GET',
      url: '/',
    })

    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      hello: 'world',
    })
  })

  it('serves an OpenAPI document with the root route in development', async () => {
    const response = await developmentApp.inject({
      method: 'GET',
      url: '/docs/json',
    })

    expect(response.statusCode).toBe(200)
    expect(response.json()).toMatchObject({
      info: {
        title: 'ATGM API',
        description: 'AskTao Game Management API',
        version: '0.1.0',
      },
      paths: {
        '/': {
          get: {
            tags: ['System'],
            summary: '服务状态',
            description: '返回服务状态示例',
            responses: {
              200: {
                content: {
                  'application/json': {
                    schema: {
                      type: 'object',
                      required: ['hello'],
                      properties: {
                        hello: { type: 'string' },
                      },
                    },
                  },
                },
              },
            },
          },
        },
      },
    })
  })

  it('serves Swagger UI in development', async () => {
    const response = await developmentApp.inject({
      method: 'GET',
      url: '/docs',
    })

    expect(response.statusCode).toBe(200)
    expect(response.headers['content-type']).toContain('text/html')
  })

  it.each(['/docs', '/docs/json'])(
    'does not register %s in production',
    async (url) => {
      const response = await productionApp.inject({
        method: 'GET',
        url,
      })

      expect(response.statusCode).toBe(404)
    },
  )
})
