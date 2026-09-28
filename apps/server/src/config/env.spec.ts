import type { ServerEnv } from './env'
import { describe, expect, expectTypeOf, it } from 'vitest'
import { parseServerEnv } from './env'

const validDatabaseEnv = {
  MYSQL_HOST: '127.0.0.1',
  MYSQL_USER: 'root',
  MYSQL_PASSWORD: 'password',
  MYSQL_ACCOUNT_DB: 'account_db',
  MYSQL_GAME_DB: 'game_db',
}

const parseEnv = (input: NodeJS.ProcessEnv = {}) =>
  parseServerEnv({ ...validDatabaseEnv, ...input })

describe('parseServerEnv', () => {
  it('uses defaults when HOST, PORT, and MYSQL_PORT are not set', () => {
    expect(parseEnv()).toEqual({
      HOST: '0.0.0.0',
      PORT: 8080,
      MYSQL_HOST: '127.0.0.1',
      MYSQL_PORT: 3306,
      MYSQL_USER: 'root',
      MYSQL_PASSWORD: 'password',
      MYSQL_ACCOUNT_DB: 'account_db',
      MYSQL_GAME_DB: 'game_db',
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
      MYSQL_ACCOUNT_DB: ' account_db ',
      MYSQL_GAME_DB: ' game_db ',
    })

    expect(env).toMatchObject({
      MYSQL_HOST: 'mysql.internal',
      MYSQL_PORT: 3307,
      MYSQL_USER: 'atgm',
      MYSQL_PASSWORD: ' password with spaces ',
      MYSQL_ACCOUNT_DB: 'account_db',
      MYSQL_GAME_DB: 'game_db',
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

  it.each(['MYSQL_ACCOUNT_DB', 'MYSQL_GAME_DB'] as const)(
    'rejects an empty %s',
    (name) => {
      expect(() => parseEnv({ [name]: '   ' })).toThrow(
        new RegExp(`Invalid server environment:[\\s\\S]*${name}`),
      )
    },
  )

  it.each(['account-db', 'game.db', 'game db', '游戏库'])(
    'rejects invalid database name %j',
    (databaseName) => {
      expect(() => parseEnv({ MYSQL_GAME_DB: databaseName })).toThrow(
        /Invalid server environment:[\s\S]*MYSQL_GAME_DB/,
      )
    },
  )

  it.each(['0', '65536', '1.5', 'abc', '0xcea', '3.3e3', 'Infinity', 'NaN'])(
    'rejects invalid MYSQL_PORT %j',
    (MYSQL_PORT) => {
      expect(() => parseEnv({ MYSQL_PORT })).toThrow(
        /Invalid server environment:[\s\S]*MYSQL_PORT/,
      )
    },
  )
})
