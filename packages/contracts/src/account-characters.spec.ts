import type { AccountCharactersResponse, CharacterListItem } from '.'
import { describe, expect, expectTypeOf, it } from 'vitest'
import { accountCharactersResponseSchema } from '.'

const character = {
  gid: '0000000000000003',
  name: '女金',
  polar: 1,
  gender: 2,
  time: '2026-10-02 23:37:54',
}

describe('account characters response', () => {
  it.each([{ items: [] }, { items: [character] }])(
    'accepts character items $items without pagination',
    ({ items }) => {
      expect(accountCharactersResponseSchema.parse({ items })).toEqual({
        items,
      })
    },
  )
  it.each([
    {},
    { items: 'wrong' },
    { items: [{}] },
    { items: [{ ...character, gid: 3 }] },
    { items: [{ ...character, name: 1 }] },
    { items: [{ ...character, polar: 1.5 }] },
    { items: [{ ...character, gender: '2' }] },
    { items: [{ ...character, time: 123 }] },
  ])('rejects invalid response %j', (response) => {
    expect(accountCharactersResponseSchema.safeParse(response).success).toBe(
      false,
    )
  })
  it('reuses the character list item type', () => {
    expectTypeOf<AccountCharactersResponse>().toEqualTypeOf<{
      items: CharacterListItem[]
    }>()
  })
})
