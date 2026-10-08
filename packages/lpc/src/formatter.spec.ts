import type { LpcArray, LpcMapping } from '.'
import { readFileSync } from 'node:fs'
import { describe, expect, it } from 'vitest'
import { formatLpc, formatLpcValue, LpcParseError, parseLpcValue } from '.'

const source = '(["name":"测试","items":({1,2,3,})])'
const formatted = `([
  "name": "测试",
  "items": ({
    1,
    2,
    3,
  }),
])`

/* eslint-disable-next-line test/prefer-lowercase-title */
describe('LPC formatter', () => {
  it('formats the requested example with two-space indentation', () => {
    expect(formatLpc(source)).toBe(formatted)
    expect(formatLpcValue(parseLpcValue(source))).toBe(formatted)
    expect(formatLpc(formatted)).toBe(formatted)
  })

  it.each(['({})', '([])', '"中文"', '-20', '12.5', ':AbC:'])(
    'keeps empty containers and scalar %s inline',
    (text) => {
      expect(formatLpc(text)).toBe(text)
    },
  )

  it('uses four spaces at every level and keeps empty containers inline', () => {
    expect(formatLpc('(["a":({([]),({}),}),])', { indentSize: 4 })).toBe(`([
    "a": ({
        ([]),
        ({}),
    }),
])`)
  })

  it('allows zero indentation while retaining line breaks', () => {
    expect(formatLpc(source, { indentSize: 0 })).toBe(`([
"name": "测试",
"items": ({
1,
2,
3,
}),
])`)
  })

  it('keeps map order, numeric keys, special values and escaped strings', () => {
    const value = parseLpcValue(
      String.raw`([92:([33::AbC:,-20:({"中文","\"\\\n\r\t\b\f",}),]),"child":"([\"carry\":([]),])",])`,
    )
    const text = formatLpcValue(value)
    expect(text).toContain('    33: :AbC:,')
    expect(text).toContain(String.raw`"\"\\\n\r\t\b\f",`)
    expect(parseLpcValue(text)).toEqual(value)
  })

  it.each([
    'login',
    'salary',
    'complex-me',
    'gid-03',
    'gid-03-achieve',
    'gid-03-carry',
    'gid-03-patch',
  ])('round-trips the complete %s fixture', (name) => {
    const text = readFileSync(
      new URL(`./fixtures/${name}.txt`, import.meta.url),
      'utf8',
    )
    const value = parseLpcValue(text)
    const formatted = formatLpc(text)
    expect(parseLpcValue(formatted)).toEqual(value)
    expect(formatLpc(formatted)).toBe(formatted)
    expect(parseLpcValue(formatLpcValue(value, { indentSize: 4 }))).toEqual(
      value,
    )
  })

  it.each([-1, 1.5, Number.NaN, Infinity, -Infinity])(
    'rejects indentSize %s',
    (indentSize) => {
      expect(() => formatLpcValue([], { indentSize })).toThrow(RangeError)
      expect(() => formatLpc('({})', { indentSize })).toThrow(RangeError)
    },
  )

  it('preserves parser errors', () => {
    expect(() => formatLpc('(["a":')).toThrow(LpcParseError)
  })

  it.each([Number.NaN, Infinity, -Infinity])(
    'rejects invalid number %s',
    (number) => {
      expect(() => formatLpcValue(number)).toThrow(TypeError)
    },
  )

  it('rejects invalid special values and cycles', () => {
    expect(() => formatLpcValue({ type: 'special', value: 'XYZ' })).toThrow(
      TypeError,
    )
    const array: LpcArray = []
    const mapping: LpcMapping = new Map([['array', array]])
    array.push(mapping)
    expect(() => formatLpcValue(array)).toThrow(TypeError)
  })

  it('allows shared containers without changing input', () => {
    const child: LpcArray = [1, '中文']
    const value: LpcArray = [child, child]
    expect(formatLpcValue(value)).toBe(`({
  ({
    1,
    "中文",
  }),
  ({
    1,
    "中文",
  }),
})`)
    expect(value).toEqual([
      [1, '中文'],
      [1, '中文'],
    ])
    expect(value[0]).toBe(value[1])
  })
})
