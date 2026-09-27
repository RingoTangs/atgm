import { afterAll, describe, expect, it } from 'vitest'
import { buildApp } from './app'

const app = buildApp()

afterAll(async () => {
  await app.close()
})

describe('app', () => {
  it('returns hello world', async () => {
    const response = await app.inject({
      method: 'GET',
      url: '/',
    })

    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      hello: 'world',
    })
  })
})
