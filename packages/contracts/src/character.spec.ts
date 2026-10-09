import type { CharacterWithAccount } from '.'
import { describe, expect, expectTypeOf, it } from 'vitest'
import { characterWithAccountSchema } from '.'

const character = {
  gid: '0000000000000003',
  name: '女金',
  polar: 1,
  gender: 2,
  time: '2018-04-13 15:53:02',
}

describe('character with account', () => {
  it.each(['1', '关联账号', null])('accepts account %s', (account) => {
    const item = { ...character, account }
    expect(characterWithAccountSchema.parse(item)).toEqual(item)
  })

  it.each([undefined, 1, {}, []])('rejects invalid account %s', (account) => {
    expect(
      characterWithAccountSchema.safeParse({ ...character, account }).success,
    ).toBe(false)
  })

  it('requires an account string or null in the exported type', () => {
    expectTypeOf<CharacterWithAccount['account']>().toEqualTypeOf<
      string | null
    >()
  })
})
