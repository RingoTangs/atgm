import type { LpcArray, LpcMapping, LpcValue } from '.'
import { readFileSync } from 'node:fs'
import { describe, expect, it } from 'vitest'
import { parseLpcValue, serializeLpcValue } from '.'

const special = { type: 'special', value: '6AB6A56F000101C911A4' } as const

describe('serializeLpcValue', () => {
  it.each<[LpcValue, string]>([
    ['中文', '"中文"'],
    ['', '""'],
    [123, '123'],
    [-20, '-20'],
    [12.5, '12.5'],
    [-0, '-0'],
    [[], '({})'],
    [new Map(), '([])'],
    [[1, 2, 3], '({1,2,3,})'],
    [special, ':6AB6A56F000101C911A4:'],
    ['"\\\n\r\t\b\f', String.raw`"\"\\\n\r\t\b\f"`],
    ['\0\x01\x1F', String.raw`"\u0000\u0001\u001f"`],
    [
      new Map<string | number, LpcValue>([
        ['name', '测试'],
        ['level', 100],
        [33, special],
      ]),
      '(["name":"测试","level":100,33::6AB6A56F000101C911A4:,])',
    ],
    [1e-7, '0.0000001'],
    [-1e-7, '-0.0000001'],
    [1.23e21, '1230000000000000000000.0'],
    [Number.MAX_SAFE_INTEGER + 1, '9007199254740992.0'],
  ])('writes %j as %s', (value, text) => {
    expect(serializeLpcValue(value)).toBe(text)
    expect(parseLpcValue(text)).toEqual(value)
  })

  it('preserves map insertion order and distinct numeric and string keys', () => {
    const value: LpcMapping = new Map<string | number, LpcValue>([
      [2, 'second'],
      ['1', 'string'],
      [1, 'number'],
      [-20, 'negative'],
      [12.5, 'decimal'],
    ])
    const before = Array.from(value)
    expect(serializeLpcValue(value)).toBe(
      '([2:"second","1":"string",1:"number",-20:"negative",12.5:"decimal",])',
    )
    expect(Array.from(value)).toEqual(before)
    expect(parseLpcValue(serializeLpcValue(value))).toEqual(value)
  })

  it.each([
    Number.MIN_VALUE,
    Number.MAX_VALUE,
    -Number.MAX_VALUE,
    -9007199254740992,
  ])('round-trips extreme finite number %s and numeric keys', (number) => {
    const text = serializeLpcValue(number)
    expect(text).not.toMatch(/e/i)
    expect(parseLpcValue(text)).toBe(number)
    const mapping: LpcMapping = new Map([[number, 'value']])
    expect(parseLpcValue(serializeLpcValue(mapping))).toEqual(mapping)
  })

  it('round-trips nesting without interpreting strings', () => {
    const value = parseLpcValue(
      String.raw`(["a":({([92:({-20,12.5,:AbC:,}),]),}),"child":"([\"carry\":([]),])",])`,
    )
    expect(parseLpcValue(serializeLpcValue(value))).toEqual(value)
  })

  it.each(['login', 'salary', 'complex-me'])(
    'round-trips the complete %s fixture',
    (name) => {
      const value = parseLpcValue(
        readFileSync(
          new URL(`./fixtures/${name}.txt`, import.meta.url),
          'utf8',
        ),
      )
      expect(parseLpcValue(serializeLpcValue(value))).toEqual(value)
    },
  )

  it.each([Number.NaN, Infinity, -Infinity])(
    'rejects non-finite number %s',
    (value) => {
      expect(() => serializeLpcValue(value)).toThrow(TypeError)
      expect(() => serializeLpcValue(new Map([[value, 1]]))).toThrow(TypeError)
    },
  )

  it.each(['', 'XYZ', 'AB:C', 'AB C'])(
    'rejects special payload %j',
    (value) => {
      expect(() => serializeLpcValue({ type: 'special', value })).toThrow(
        TypeError,
      )
    },
  )

  it('rejects array, mapping and mixed cycles', () => {
    const array: LpcArray = []
    array.push(array)
    const mapping: LpcMapping = new Map()
    mapping.set('self', mapping)
    const mixed: LpcArray = []
    mixed.push(new Map([['back', mixed]]))
    for (const value of [array, mapping, mixed])
      expect(() => serializeLpcValue(value)).toThrow(TypeError)
  })

  it('allows shared containers without mutating them', () => {
    const shared: LpcArray = [1, '中文']
    const mapping: LpcMapping = new Map([['shared', shared]])
    const value: LpcArray = [shared, shared, mapping, mapping]
    expect(parseLpcValue(serializeLpcValue(value))).toEqual(value)
    expect(shared).toEqual([1, '中文'])
    expect(mapping.get('shared')).toBe(shared)
    expect(value[0]).toBe(value[1])
  })
})
