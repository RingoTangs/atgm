import type { ServerEnv } from './env'
import { describe, expect, expectTypeOf, it } from 'vitest'
import { parseServerEnv } from './env'

describe('parseServerEnv', () => {
  it('uses defaults when HOST and PORT are not set', () => {
    expect(parseServerEnv({})).toEqual({
      HOST: '0.0.0.0',
      PORT: 8080,
    })
  })

  it('trims HOST and converts PORT to a number', () => {
    const env = parseServerEnv({
      HOST: ' example.test ',
      PORT: '3000',
    })

    expect(env).toEqual({
      HOST: 'example.test',
      PORT: 3000,
    })
    expectTypeOf(env.PORT).toEqualTypeOf<number>()
    expectTypeOf<ServerEnv['PORT']>().toEqualTypeOf<number>()
  })

  it.each([
    ['1', 1],
    ['65535', 65535],
  ])('accepts boundary port %s', (value, expected) => {
    expect(parseServerEnv({ PORT: value }).PORT).toBe(expected)
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
    expect(() => parseServerEnv({ PORT })).toThrow(
      /Invalid server environment:[\s\S]*PORT/,
    )
  })

  it('rejects a whitespace-only HOST', () => {
    expect(() => parseServerEnv({ HOST: '   ' })).toThrow(
      /Invalid server environment:[\s\S]*must not be empty[\s\S]*HOST/,
    )
  })
})
