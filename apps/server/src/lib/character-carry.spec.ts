import { readFileSync } from 'node:fs'
import { describe, expect, it } from 'vitest'
import {
  CharacterCarryError,
  parseCharacterCarry,
  parseCharacterCarryItem,
} from './character-carry'

const fixture = readFileSync(
  new URL(
    '../../../../packages/lpc/src/fixtures/gid-03-carry.txt',
    import.meta.url,
  ),
  'utf8',
)

describe('character carry', () => {
  it('reads all names and aliases from the real sample in numeric key order', () => {
    expect(parseCharacterCarry(fixture)).toEqual([
      { entryKey: 1, name: '长枪', alias: '被强化的长枪' },
      { entryKey: 2, name: '簪子', alias: '被强化的簪子' },
      { entryKey: 3, name: '布裙', alias: '被强化的布裙' },
      { entryKey: 10, name: '麻鞋', alias: '被强化的麻鞋' },
      { entryKey: 51, name: '布带', alias: '被强化的布带' },
      { entryKey: 101, name: '新手礼包（35级）', alias: null },
      { entryKey: 102, name: '驯兽诀', alias: null },
      { entryKey: 103, name: '中级法玲珑', alias: null },
      { entryKey: 104, name: '特级八卦阴阳令', alias: null },
      { entryKey: 105, name: '中级血玲珑', alias: null },
    ])
  })
  it('returns an empty array for an empty carry mapping', () => {
    expect(parseCharacterCarry('(["carry":([]),])')).toEqual([])
  })
  it('accepts an empty alias and keeps numeric keys without interpreting them', () => {
    expect(
      parseCharacterCarry(
        '(["carry":([-1.5:"测试:([\\"alias\\":\\"\\",])",]),])',
      ),
    ).toEqual([{ entryKey: -1.5, name: '测试', alias: null }])
  })
  it.each([
    { content: 'invalid', key: null },
    { content: '({})', key: null },
    { content: '([])', key: null },
    { content: '(["carry":1,])', key: null },
    { content: '(["carry":(["1":"物品:([])",]),])', key: null },
    { content: '(["carry":([7:1,]),])', key: 7 },
    { content: '(["carry":([7:"物品:([",]),])', key: 7 },
    { content: '(["carry":([7:"物品:({})",]),])', key: 7 },
    { content: '(["carry":([7:":([])",]),])', key: 7 },
    { content: '(["carry":([7:"物品([])",]),])', key: 7 },
    { content: '(["carry":([7:"物品:([\\"alias\\":1,])",]),])', key: 7 },
  ])(
    'rejects malformed data with entry key $key (case %#)',
    ({ content, key }) => {
      try {
        parseCharacterCarry(content)
        expect.fail('Expected malformed carry data to fail')
      } catch (error) {
        expect(error).toBeInstanceOf(CharacterCarryError)
        expect((error as CharacterCarryError).entryKey).toBe(key)
      }
    },
  )
  it('rejects the entire list when one item is damaged', () => {
    expect(() =>
      parseCharacterCarry('(["carry":([1:"长枪:([])",2:"invalid",]),])'),
    ).toThrow(CharacterCarryError)
  })
})

describe('carry item detail', () => {
  it('preserves original nested mappings, numeric keys and special values', () => {
    const item = parseCharacterCarryItem(fixture, 103)!
    expect(item).toMatchObject({
      entryKey: 103,
      name: '中级法玲珑',
      alias: null,
    })
    expect(item.lpc).toContain('233::6ABD337600010147A4F4:')
    expect(item.lpc).toContain('"recover":([12:19999315,])')
    expect(item.lpc.startsWith('([')).toBe(true)
  })
  it.each([0, -1, -1.5])('preserves numeric key %s', (key) => {
    expect(
      parseCharacterCarryItem(`(["carry":([${key}:"测试:([])",]),])`, key),
    ).toEqual({ entryKey: key, name: '测试', alias: null, lpc: '([])' })
  })
  it('only parses the target inner LPC', () => {
    expect(
      parseCharacterCarryItem('(["carry":([1:"长枪:([])",2:"invalid",]),])', 1)
        ?.name,
    ).toBe('长枪')
    expect(() =>
      parseCharacterCarryItem('(["carry":([1:"长枪:([])",2:"invalid",]),])', 2),
    ).toThrow(CharacterCarryError)
  })
  it.each(['(["carry":([]),])', '(["carry":([1:"长枪:([])",]),])'])(
    'returns null for missing keys',
    (content) => {
      expect(parseCharacterCarryItem(content, 99)).toBeNull()
    },
  )
  it.each([
    'invalid',
    '(["carry":1,])',
    '(["carry":([7:1,]),])',
    '(["carry":([7:"测试:({})",]),])',
    '(["carry":([7:"测试:([\\"alias\\":1,])",]),])',
  ])('rejects damaged target data (case %#)', (content) => {
    expect(() => parseCharacterCarryItem(content, 7)).toThrow(
      CharacterCarryError,
    )
  })
})
