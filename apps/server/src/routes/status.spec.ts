import { afterAll, describe, expect, it } from 'vitest'
import { buildApp } from '../app'

const app = buildApp()

afterAll(async () => {
  await app.close()
})

describe('status routes', () => {
  it('reports that the HTTP service is alive', async () => {
    const response = await app.inject({
      method: 'GET',
      url: '/_status',
    })

    expect(response.statusCode).toBe(200)
    expect(response.headers['content-type']).toContain('application/json')
    expect(response.json()).toEqual({
      status: 'ok',
    })
  })
})
