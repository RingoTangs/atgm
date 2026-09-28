import { afterAll, beforeEach, describe, expect, it, vi } from 'vitest'
import { buildApp } from '../app'
import { registerDatabase } from '../db'
import { parseServerEnv } from '../env'

const mocks = vi.hoisted(() => {
  const executeTakeFirst = vi.fn()
  const values = vi.fn(() => ({ executeTakeFirst }))
  const insertInto = vi.fn(() => ({ values }))

  return {
    executeTakeFirst,
    insertInto,
    values,
  }
})

vi.mock('../db', () => ({
  registerDatabase: (app: {
    decorate: (name: string, value: unknown) => void
  }) => {
    app.decorate('db', {
      adb: { insertInto: mocks.insertInto },
      ddb: {},
    })
  },
}))

vi.stubEnv('NODE_ENV', 'development')
const app = buildApp()
vi.unstubAllEnvs()

registerDatabase(
  app,
  parseServerEnv({
    MYSQL_HOST: '127.0.0.1',
    MYSQL_USER: 'atgm',
    MYSQL_PASSWORD: 'password',
  }),
)

const validBody = {
  account: 'test',
  rawPassword: '123123',
  goldCoin: 0,
  silverCoin: 0,
  privilege: 0,
}

beforeEach(() => {
  vi.clearAllMocks()
  mocks.executeTakeFirst.mockResolvedValue({})
})

afterAll(async () => {
  await app.close()
})

describe('post /account endpoint', () => {
  it('creates an account using only the six supported database fields', async () => {
    const response = await app.inject({
      method: 'POST',
      url: '/account',
      payload: validBody,
    })

    expect(response.statusCode).toBe(201)
    expect(response.json()).toEqual({ account: 'test' })
    expect(mocks.insertInto).toHaveBeenCalledWith('account')
    expect(mocks.values).toHaveBeenCalledWith({
      account: 'test',
      password: 'CCE77B0DB6F881BF119A7F14C4FCDE50',
      gold_coin: 0,
      silver_coin: 0,
      privilege: 0,
      checksum: '5780D0EDB96323E1BB6FB2F33614A8B7',
    })
    expect(mocks.executeTakeFirst).toHaveBeenCalledOnce()
    expect(response.body).not.toContain('rawPassword')
    expect(response.body).not.toContain('password')
    expect(response.body).not.toContain('checksum')
  })

  it.each([
    {
      name: 'goldCoin lower bound',
      body: { ...validBody, goldCoin: 0 },
    },
    {
      name: 'goldCoin upper bound',
      body: { ...validBody, goldCoin: 2_000_000_000 },
    },
    {
      name: 'silverCoin lower bound',
      body: { ...validBody, silverCoin: 0 },
    },
    {
      name: 'silverCoin upper bound',
      body: { ...validBody, silverCoin: 2_000_000_000 },
    },
    {
      name: 'privilege lower bound',
      body: { ...validBody, privilege: 0 },
    },
    {
      name: 'privilege upper bound',
      body: { ...validBody, privilege: 1000 },
    },
  ])('accepts the $name', async ({ body }) => {
    const response = await app.inject({
      method: 'POST',
      url: '/account',
      payload: body,
    })

    expect(response.statusCode).toBe(201)
    expect(mocks.executeTakeFirst).toHaveBeenCalledOnce()
  })

  it.each(['account', 'rawPassword', 'goldCoin', 'silverCoin', 'privilege'])(
    'rejects a missing %s field before inserting',
    async (field) => {
      const body: Record<string, unknown> = { ...validBody }
      delete body[field]

      const response = await app.inject({
        method: 'POST',
        url: '/account',
        payload: body,
      })

      expect(response.statusCode).toBe(400)
      expect(mocks.insertInto).not.toHaveBeenCalled()
    },
  )

  it.each([
    { name: 'an empty account', body: { ...validBody, account: '' } },
    {
      name: 'an account longer than 32 characters',
      body: { ...validBody, account: 'a'.repeat(33) },
    },
    { name: 'an empty raw password', body: { ...validBody, rawPassword: '' } },
    { name: 'a string goldCoin', body: { ...validBody, goldCoin: '0' } },
    { name: 'a negative goldCoin', body: { ...validBody, goldCoin: -1 } },
    {
      name: 'an excessive goldCoin',
      body: { ...validBody, goldCoin: 2_000_000_001 },
    },
    { name: 'a fractional goldCoin', body: { ...validBody, goldCoin: 1.5 } },
    {
      name: 'an infinite goldCoin',
      body: { ...validBody, goldCoin: Number.POSITIVE_INFINITY },
    },
    { name: 'a NaN goldCoin', body: { ...validBody, goldCoin: Number.NaN } },
    { name: 'a negative silverCoin', body: { ...validBody, silverCoin: -1 } },
    {
      name: 'an excessive silverCoin',
      body: { ...validBody, silverCoin: 2_000_000_001 },
    },
    {
      name: 'a fractional silverCoin',
      body: { ...validBody, silverCoin: 1.5 },
    },
    { name: 'a negative privilege', body: { ...validBody, privilege: -1 } },
    { name: 'an excessive privilege', body: { ...validBody, privilege: 1001 } },
    { name: 'a fractional privilege', body: { ...validBody, privilege: 1.5 } },
    {
      name: 'an extra password field',
      body: { ...validBody, password: 'client-value' },
    },
    {
      name: 'an extra checksum field',
      body: { ...validBody, checksum: 'client-value' },
    },
  ])('rejects $name before inserting', async ({ body }) => {
    const response = await app.inject({
      method: 'POST',
      url: '/account',
      payload: body,
    })

    expect(response.statusCode).toBe(400)
    expect(mocks.insertInto).not.toHaveBeenCalled()
    expect(mocks.executeTakeFirst).not.toHaveBeenCalled()
  })

  it.each([
    Object.assign(new Error('duplicate'), { code: 'ER_DUP_ENTRY' }),
    Object.assign(new Error('duplicate'), { errno: 1062 }),
  ])('returns a conflict for a duplicate account', async (error) => {
    mocks.executeTakeFirst.mockRejectedValue(error)

    const response = await app.inject({
      method: 'POST',
      url: '/account',
      payload: validBody,
    })

    expect(response.statusCode).toBe(409)
    expect(response.json()).toEqual({ message: '账号已存在' })
  })

  it('does not treat other database failures as duplicate accounts', async () => {
    mocks.executeTakeFirst.mockRejectedValue(new Error('database unavailable'))

    const response = await app.inject({
      method: 'POST',
      url: '/account',
      payload: validBody,
    })

    expect(response.statusCode).toBe(500)
    expect(response.body).not.toContain('账号已存在')
    expect(response.body).not.toContain('database unavailable')
  })
})
