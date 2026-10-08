import { LpcParseError } from '@atgm/lpc'
import { describe, expect, it } from 'vitest'
import { LoginDataError, parseLoginData } from './login-data'

const login =
  '(["create_time":1790613437,"rec_role":"0000000000000003","safe_status":0,"chars":({"0000000000000003","0000000000000004",}),"register_time":0,])'
const fields = [
  ['create_time', '1790613437', '"wrong"'],
  ['rec_role', '"0000000000000003"', '3'],
  ['safe_status', '0', '"wrong"'],
  ['chars', '({"0000000000000003","0000000000000004",})', '([])'],
  ['register_time', '0', '"wrong"'],
] as const

describe('parseLoginData', () => {
  it('parses the complete real login example', () => {
    expect(parseLoginData(login)).toEqual({
      createTime: 1790613437,
      recRole: '0000000000000003',
      safeStatus: 0,
      chars: ['0000000000000003', '0000000000000004'],
      registerTime: 0,
    })
  })

  it('accepts empty chars', () => {
    expect(parseLoginData(login.replace(fields[3][1], '({})')).chars).toEqual(
      [],
    )
  })

  it('allows extra fields', () => {
    expect(parseLoginData(login.replace('([', '(["extra":1,'))).toEqual(
      parseLoginData(login),
    )
  })

  it.each(['123', '"login"', '({})', ':ABC:'])(
    'rejects non-mapping root %s',
    (content) => {
      expect(() => parseLoginData(content)).toThrow(LoginDataError)
    },
  )

  it.each(fields)('rejects missing field %s', (key, value) => {
    expect(() =>
      parseLoginData(login.replace(`"${key}":${value},`, '')),
    ).toThrow(LoginDataError)
    expect(() =>
      parseLoginData(login.replace(`"${key}":${value},`, '')),
    ).toThrow(key)
  })

  it.each(fields)('rejects incorrect type for %s', (key, value, wrong) => {
    const content = login.replace(`"${key}":${value}`, `"${key}":${wrong}`)
    expect(() => parseLoginData(content)).toThrow(LoginDataError)
    expect(() => parseLoginData(content)).toThrow(key)
  })

  it.each([
    '1',
    '"role"',
    '([])',
    '({"role",1,})',
    '({"role",([]),})',
    '({:ABC:,})',
  ])('rejects invalid chars %s', (chars) => {
    expect(() => parseLoginData(login.replace(fields[3][1], chars))).toThrow(
      LoginDataError,
    )
  })

  it.each(['', '(["chars":', 'not lpc'])(
    'preserves LPC errors for %j',
    (content) => {
      expect(() => parseLoginData(content)).toThrow(LpcParseError)
      expect(() => parseLoginData(content)).not.toThrow(LoginDataError)
    },
  )
})
