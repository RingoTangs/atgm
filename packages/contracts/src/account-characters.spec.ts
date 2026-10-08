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
const recRole = character.gid

describe('account characters response', () => {
  it.each([
    { recRole, chars: [] },
    { recRole, chars: [character] },
    { recRole: null, chars: [] },
    { recRole: null, chars: [character] },
  ])('accepts response %j without pagination', (response) => {
    expect(accountCharactersResponseSchema.parse(response)).toEqual(response)
  })
  it.each([
    {},
    { items: [character] },
    { chars: [] },
    { recRole },
    { recRole: 3, chars: [] },
    { recRole: false, chars: [] },
    { recRole: {}, chars: [] },
    { recRole: [], chars: [] },
    { recRole, chars: null },
    { recRole, chars: 'wrong' },
    { recRole, chars: [{}] },
    { recRole, chars: [{ ...character, gid: 3 }] },
    { recRole, chars: [{ ...character, name: 1 }] },
    { recRole, chars: [{ ...character, polar: 1.5 }] },
    { recRole, chars: [{ ...character, gender: '2' }] },
    { recRole, chars: [{ ...character, time: 123 }] },
  ])('rejects invalid response %j', (response) => {
    expect(accountCharactersResponseSchema.safeParse(response).success).toBe(
      false,
    )
  })
  it('reuses the character list item type', () => {
    expectTypeOf<AccountCharactersResponse>().toEqualTypeOf<{
      recRole: string | null
      chars: CharacterListItem[]
    }>()
  })
})
