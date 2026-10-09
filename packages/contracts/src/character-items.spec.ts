import type { CharacterItem, CharacterItemsResponse } from '.'
import { describe, expect, expectTypeOf, it } from 'vitest'
import { characterItemSchema, characterItemsResponseSchema } from '.'

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
