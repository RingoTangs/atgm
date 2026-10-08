import type { EmbeddedLpc, LpcMapping, LpcValue } from '.'
import { readFileSync } from 'node:fs'
import { describe, expect, expectTypeOf, it } from 'vitest'
import { parseEmbeddedLpc, parseLpcValue } from '.'

function mapping(value: LpcValue | undefined): LpcMapping {
  expect(value).toBeInstanceOf(Map)
  if (!(value instanceof Map)) throw new Error('Expected mapping')
  return value
}

function embedded(source: string): EmbeddedLpc {
  const result = parseEmbeddedLpc(source)
  expect(result).not.toBeNull()
  if (!result) throw new Error('Expected embedded LPC')
  return result
}

function fixtureString(name: string, container: string, key: number): string {
  const root = mapping(
    parseLpcValue(
      readFileSync(new URL(`./fixtures/${name}.txt`, import.meta.url), 'utf8'),
    ),
  )
  const value = mapping(root.get(container)).get(key)
  expect(typeof value).toBe('string')
  if (typeof value !== 'string') throw new Error('Expected string')
  return value
}

describe('embedded LPC', () => {
  it.each([
    '',
    '这只是普通文本',
    '文本包含 ([ 但不是合法 LPC',
    '123',
    '前缀:123',
    '"普通字符串"',
    '前缀:"普通字符串"',
    '前缀:(["a":1,]) 多余内容',
  ])('returns null for %s', (source) => {
    expect(parseEmbeddedLpc(source)).toBeNull()
  })

  it.each([
    ['中级法玲珑:', '([255:36,"type":8,])'],
    ['中文前缀:', '({1,2,3,})'],
    ['', '([])'],
    ['', '({})'],
    ['', '(["a":1,])'],
    [' 前缀: ', '({1,}) \n\t'],
  ])('preserves prefix %s and payload %s', (prefix, payload) => {
    const source = prefix + payload
    expect(parseEmbeddedLpc(source)).toEqual({
      prefix,
      source: payload,
      value: parseLpcValue(payload),
    })
    expect(source).toBe(prefix + payload)
  })

  it('selects the earliest successful candidate including nested containers', () => {
    const payload = '(["nested":({([]),}),])'
    expect(embedded(`前缀:${payload}`).source).toBe(payload)
  })

  it('continues past invalid candidates to the first valid suffix', () => {
    const prefix = '失败:([不是LPC; 另一个:({错误; 成功:'
    expect(embedded(`${prefix}({1,2,})`)).toEqual({
      prefix,
      source: '({1,2,})',
      value: [1, 2],
    })
  })

  it('requires parsing to the end rather than selecting the first complete container', () => {
    expect(embedded('第一个:([]) 第二个:({2,})')).toEqual({
      prefix: '第一个:([]) 第二个:',
      source: '({2,})',
      value: [2],
    })
  })

  it('keeps embedded LPC inside payload strings as strings', () => {
    const result = embedded(String.raw`前缀:(["child":"([\"a\":1,])",])`)
    expect(mapping(result.value).get('child')).toBe('(["a":1,])')
  })

  it('parses the actual carry item with numeric keys and a special value', () => {
    const source = fixtureString('gid-03-carry', 'carry', 103)
    const result = embedded(source)
    expect(result.prefix).toBe('中级法玲珑:')
    expect(result.source.startsWith('([255:36,')).toBe(true)
    expect(result.prefix + result.source).toBe(source)
    const value = mapping(result.value)
    expect(value.get(255)).toBe(36)
    expect(value.get(233)).toEqual({
      type: 'special',
      value: '6ABD337600010147A4F4',
    })
  })

  it('parses the actual patch pet and its attrib mapping', () => {
    const source = fixtureString('gid-03-patch', 'pets', 1)
    const result = embedded(source)
    expect(result.prefix).toBe('松鼠:1:0:')
    expect(result.prefix + result.source).toBe(source)
    expect(parseLpcValue(result.source)).toEqual(result.value)
    const attrib = mapping(mapping(result.value).get('attrib'))
    expect(attrib.get(39)).toBe('松鼠')
  })

  it('exports the API and result type', () => {
    expectTypeOf(parseEmbeddedLpc).toEqualTypeOf<
      (source: string) => EmbeddedLpc | null
    >()
    expectTypeOf<EmbeddedLpc>().toEqualTypeOf<{
      prefix: string
      source: string
      value: LpcValue
    }>()
  })
})
