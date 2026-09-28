import type { ServerEnv } from './env'
import { afterEach, describe, expect, expectTypeOf, it, vi } from 'vitest'
import { isDevelopment, isProduction, parseServerEnv } from './env'

const validRequiredEnv = {
  MYSQL_HOST: '127.0.0.1',
  MYSQL_USER: 'root',
  MYSQL_PASSWORD: 'password',
}

const parseEnv = (input: NodeJS.ProcessEnv = {}) =>
  parseServerEnv({ ...validRequiredEnv, ...input })

afterEach(() => {
  vi.unstubAllEnvs()
})

describe('parseServerEnv', () => {
  it('uses defaults when optional server settings are not set', () => {
    expect(parseEnv()).toEqual({
      HOST: '0.0.0.0',
      PORT: 8080,
      MYSQL_HOST: '127.0.0.1',
      MYSQL_PORT: 3306,
      MYSQL_USER: 'root',
      MYSQL_PASSWORD: 'password',
      MYSQL_DL_ADB_ALL: 'dl_adb_all',
      MYSQL_DL_DDB_1: 'dl_ddb_1',
    })
  })

  it('trims HOST and converts PORT to a number', () => {
    const env = parseEnv({
      HOST: ' example.test ',
      PORT: '3000',
    })

    expect(env.HOST).toBe('example.test')
    expect(env.PORT).toBe(3000)
    expectTypeOf(env.PORT).toEqualTypeOf<number>()
    expectTypeOf<ServerEnv['PORT']>().toEqualTypeOf<number>()
  })

  it.each([
    ['1', 1],
    ['65535', 65535],
  ])('accepts boundary port %s', (value, expected) => {
    expect(parseEnv({ PORT: value }).PORT).toBe(expected)
  })

  it.each([
    '',
    ' ',
    '0',
    '65536',
    '1.5',
    'abc',
    '0x1f90',
    '8e3',
    'Infinity',
    'NaN',
  ])('rejects invalid PORT %j', (PORT) => {
    expect(() => parseEnv({ PORT })).toThrow(
      /Invalid server environment:[\s\S]*PORT/,
    )
  })

  it('rejects a whitespace-only HOST', () => {
    expect(() => parseEnv({ HOST: '   ' })).toThrow(
      /Invalid server environment:[\s\S]*must not be empty[\s\S]*HOST/,
    )
  })

  it('parses and trims a complete MySQL configuration', () => {
    const env = parseEnv({
      MYSQL_HOST: ' mysql.internal ',
      MYSQL_PORT: '3307',
      MYSQL_USER: ' atgm ',
      MYSQL_PASSWORD: ' password with spaces ',
      MYSQL_DL_ADB_ALL: ' dl_adb_all ',
      MYSQL_DL_DDB_1: ' dl_ddb_1 ',
    })

    expect(env).toMatchObject({
      MYSQL_HOST: 'mysql.internal',
      MYSQL_PORT: 3307,
      MYSQL_USER: 'atgm',
      MYSQL_PASSWORD: ' password with spaces ',
      MYSQL_DL_ADB_ALL: 'dl_adb_all',
      MYSQL_DL_DDB_1: 'dl_ddb_1',
    })
    expectTypeOf(env.MYSQL_PORT).toEqualTypeOf<number>()
    expectTypeOf<ServerEnv['MYSQL_PORT']>().toEqualTypeOf<number>()
  })

  it.each(['MYSQL_HOST', 'MYSQL_USER', 'MYSQL_PASSWORD'] as const)(
    'rejects an empty %s',
    (name) => {
      expect(() => parseEnv({ [name]: '' })).toThrow(
        new RegExp(`Invalid server environment:[\\s\\S]*${name}`),
      )
    },
  )

  it.each([
    [
      { MYSQL_DL_ADB_ALL: 'custom_adb' },
      { MYSQL_DL_ADB_ALL: 'custom_adb', MYSQL_DL_DDB_1: 'dl_ddb_1' },
    ],
    [
      { MYSQL_DL_DDB_1: 'custom_ddb' },
      { MYSQL_DL_ADB_ALL: 'dl_adb_all', MYSQL_DL_DDB_1: 'custom_ddb' },
    ],
  ])('defaults the database name omitted from %j', (input, expected) => {
    expect(parseEnv(input)).toMatchObject(expected)
  })

  it.each(['MYSQL_DL_ADB_ALL', 'MYSQL_DL_DDB_1'] as const)(
    'rejects an empty %s',
    (name) => {
      expect(() => parseEnv({ [name]: '   ' })).toThrow(
        new RegExp(`Invalid server environment:[\\s\\S]*${name}`),
      )
    },
  )

  it.each([
    ['MYSQL_DL_ADB_ALL', 'dl-adb-all'],
    ['MYSQL_DL_DDB_1', 'dl.ddb.1'],
    ['MYSQL_DL_ADB_ALL', 'dl adb all'],
    ['MYSQL_DL_DDB_1', '数据库'],
  ] as const)('rejects invalid %s value %j', (name, databaseName) => {
    expect(() => parseEnv({ [name]: databaseName })).toThrow(
      new RegExp(`Invalid server environment:[\\s\\S]*${name}`),
    )
  })

  it.each(['0', '65536', '1.5', 'abc', '0xcea', '3.3e3', 'Infinity', 'NaN'])(
    'rejects invalid MYSQL_PORT %j',
    (MYSQL_PORT) => {
      expect(() => parseEnv({ MYSQL_PORT })).toThrow(
        /Invalid server environment:[\s\S]*MYSQL_PORT/,
      )
    },
  )
})

describe('runtime environment', () => {
  it('reads NODE_ENV each time it checks the runtime environment', () => {
    vi.stubEnv('NODE_ENV', 'development')

    expect(isDevelopment()).toBe(true)
    expect(isProduction()).toBe(false)

    vi.stubEnv('NODE_ENV', 'production')

    expect(isDevelopment()).toBe(false)
    expect(isProduction()).toBe(true)
  })

  it.each([['test'], [undefined]])(
    'does not identify NODE_ENV=%s as development or production',
    (nodeEnv) => {
      vi.stubEnv('NODE_ENV', nodeEnv)

      expect(isDevelopment()).toBe(false)
      expect(isProduction()).toBe(false)
    },
  )
})
