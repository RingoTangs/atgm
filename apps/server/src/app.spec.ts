import { afterAll, describe, expect, it, vi } from 'vitest'
import { buildApp } from './app'

function buildAppFor(nodeEnv: string | undefined) {
  vi.stubEnv('NODE_ENV', nodeEnv)

  try {
    return buildApp()
  } finally {
    vi.unstubAllEnvs()
  }
}

const developmentApp = buildAppFor('development')
const productionApp = buildAppFor('production')
const testApp = buildAppFor('test')
const unspecifiedApp = buildAppFor(undefined)

afterAll(async () => {
  await Promise.all([
    developmentApp.close(),
    productionApp.close(),
    testApp.close(),
    unspecifiedApp.close(),
  ])
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

  it.each([
    { environment: 'production', app: productionApp, url: '/docs' },
    { environment: 'production', app: productionApp, url: '/docs/json' },
    { environment: 'test', app: testApp, url: '/docs' },
    { environment: 'test', app: testApp, url: '/docs/json' },
    { environment: 'unspecified', app: unspecifiedApp, url: '/docs' },
    { environment: 'unspecified', app: unspecifiedApp, url: '/docs/json' },
  ])('does not register $url in $environment', async ({ app, url }) => {
    const response = await app.inject({
      method: 'GET',
      url,
    })

    expect(response.statusCode).toBe(404)
  })
})
