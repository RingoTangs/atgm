import type { CharacterItem, CharacterItemsResponse } from '.'
import { readFileSync } from 'node:fs'
import { describe, expect, expectTypeOf, it } from 'vitest'
import {
  characterItemDetailParamsSchema,
  characterItemDetailResponseSchema,
  characterItemSchema,
  characterItemsResponseSchema,
} from '.'

const item = { entryKey: 1, name: '长枪', alias: '被强化的长枪' }

describe('character items contract', () => {
  it.each([null, '被强化的长枪'])('accepts alias %s', (alias) => {
    const response = { branchExists: true, items: [{ ...item, alias }] }
    expect(characterItemsResponseSchema.parse(response)).toEqual(response)
  })
  it.each([false, true])(
    'accepts an empty list with branchExists %s',
    (branchExists) => {
      expect(
        characterItemsResponseSchema.parse({ branchExists, items: [] }),
      ).toEqual({ branchExists, items: [] })
    },
  )
  it.each([
    { ...item, entryKey: '1' },
    { ...item, entryKey: Number.POSITIVE_INFINITY },
    { ...item, name: '' },
    { ...item, name: 1 },
    { ...item, alias: undefined },
    { ...item, alias: 1 },
  ])('rejects invalid item fields (case %#)', (value) => {
    expect(characterItemSchema.safeParse(value).success).toBe(false)
  })
  it('requires the branch flag and item array', () => {
    expect(characterItemsResponseSchema.safeParse({ items: [] }).success).toBe(
      false,
    )
    expect(
      characterItemsResponseSchema.safeParse({ branchExists: false }).success,
    ).toBe(false)
    expect(
      characterItemsResponseSchema.safeParse({
        branchExists: 'true',
        items: [],
      }).success,
    ).toBe(false)
  })
  it('exports nullable aliases and the response type', () => {
    expectTypeOf<CharacterItem['alias']>().toEqualTypeOf<string | null>()
    expectTypeOf<CharacterItemsResponse['items']>().toEqualTypeOf<
      CharacterItem[]
    >()
  })
})

describe('character item detail contract', () => {
  it('preserves the real fixture inner LPC without interpreting properties', () => {
    const fixture = readFileSync(
      new URL('../../lpc/src/fixtures/gid-03-carry.txt', import.meta.url),
      'utf8',
    )
    const embedded: string = JSON.parse(
      fixture.match(/103:("(?:\\.|[^"\\])*")/)![1],
    )
    const detail = {
      entryKey: 103,
      name: '中级法玲珑',
      alias: null,
      lpc: embedded.slice(embedded.indexOf('([')),
    }
    expect(characterItemDetailResponseSchema.parse(detail)).toEqual(detail)
    expect(detail.lpc).toContain('233::6ABD337600010147A4F4:')
    expect(detail.lpc).toContain('"recover":([12:19999315,])')
  })

  it.each(['0', '-1', '-1.5', '103', '1e2'])(
    'accepts finite numeric params %s',
    (entryKey) => {
      expect(
        characterItemDetailParamsSchema.parse({ gid: 'gid', entryKey }),
      ).toEqual({ gid: 'gid', entryKey: Number(entryKey) })
    },
  )
  it.each(['', ' ', 'abc', 'NaN', 'Infinity', '1e999'])(
    'rejects invalid params %s',
    (entryKey) => {
      expect(
        characterItemDetailParamsSchema.safeParse({ gid: 'gid', entryKey })
          .success,
      ).toBe(false)
    },
  )
  it('requires complete detail fields and original LPC', () => {
    const detail = { ...item, lpc: '([233::special:,12:([1:2,]),])' }
    expect(characterItemDetailResponseSchema.parse(detail)).toEqual(detail)
    for (const lpc of [undefined, null, '', 1])
      expect(
        characterItemDetailResponseSchema.safeParse({ ...detail, lpc }).success,
      ).toBe(false)
  })
})
