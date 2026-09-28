import { afterAll, beforeEach, describe, expect, it, vi } from 'vitest'
import { buildApp } from '../app'
import { registerDatabase } from '../db'
import { parseServerEnv } from '../env'

const mocks = vi.hoisted(() => {
  const execute = vi.fn()
  const offset = vi.fn(() => ({ execute }))
  const limit = vi.fn(() => ({ offset }))
  const orderBy = vi.fn(() => ({ limit }))
  const select = vi.fn(() => ({ orderBy }))
  const selectFrom = vi.fn(() => ({ select }))

  return {
    execute,
    limit,
    offset,
    orderBy,
    select,
    selectFrom,
  }
})

vi.mock('../db', () => ({
  registerDatabase: (app: {
    decorate: (name: string, value: unknown) => void
  }) => {
    app.decorate('db', {
      adb: { selectFrom: mocks.selectFrom },
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

beforeEach(() => {
  vi.clearAllMocks()
  mocks.execute.mockResolvedValue([
    {
      account: 'example_user',
      last_login_time: '20260928120000',
    },
  ])
})

afterAll(async () => {
  await app.close()
})

describe('get /accounts endpoint', () => {
  it('uses the default pagination and returns selected account fields', async () => {
    const response = await app.inject({
      method: 'GET',
      url: '/accounts',
    })

    expect(response.statusCode).toBe(200)
    expect(response.json()).toEqual({
      page: 1,
      pageSize: 20,
      items: [
        {
          account: 'example_user',
          last_login_time: '20260928120000',
        },
      ],
    })
    expect(mocks.selectFrom).toHaveBeenCalledWith('account')
    expect(mocks.select).toHaveBeenCalledWith(['account', 'last_login_time'])
    expect(mocks.orderBy).toHaveBeenCalledWith('account')
    expect(mocks.limit).toHaveBeenCalledWith(20)
    expect(mocks.offset).toHaveBeenCalledWith(0)
    expect(mocks.execute).toHaveBeenCalledOnce()
  })

  it('coerces valid pagination strings and calculates the offset', async () => {
    const response = await app.inject({
      method: 'GET',
      url: '/accounts?page=2&pageSize=10',
    })

    expect(response.statusCode).toBe(200)
    expect(response.json()).toMatchObject({ page: 2, pageSize: 10 })
    expect(mocks.limit).toHaveBeenCalledWith(10)
    expect(mocks.offset).toHaveBeenCalledWith(10)
  })

  it.each([
    ['page=0'],
    ['page=-1'],
    ['page=abc'],
    ['page=1.5'],
    ['page='],
    ['page=%20'],
    ['page=1&page=2'],
    ['pageSize=0'],
    ['pageSize=101'],
    ['pageSize=Infinity'],
    ['pageSize='],
    ['pageSize=%20'],
    ['pageSize=1&pageSize=2'],
  ])(
    'rejects invalid querystring %s before querying the database',
    async (query) => {
      const response = await app.inject({
        method: 'GET',
        url: `/accounts?${query}`,
      })

      expect(response.statusCode).toBe(400)
      expect(mocks.selectFrom).not.toHaveBeenCalled()
      expect(mocks.execute).not.toHaveBeenCalled()
    },
  )
})
