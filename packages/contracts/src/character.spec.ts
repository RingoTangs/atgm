import type { CharacterDetailResponse, CharacterWithAccount } from '.'
import { describe, expect, expectTypeOf, it } from 'vitest'
import {
  characterDetailParamsSchema,
  characterDetailResponseSchema,
  characterWithAccountSchema,
} from '.'

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

const detail: CharacterDetailResponse = {
  basicInfo: {
    gid: '0000000000000003',
    name: '女金',
    account: null,
    level: null,
    polar: 1,
    gender: 2,
    createTime: null,
  },
  sectInfo: { family: null, master: null, title: null },
  attributes: {
    strength: null,
    constitution: null,
    dexterity: null,
    wiz: null,
  },
  combat: {
    life: null,
    maxLife: null,
    mana: null,
    maxMana: null,
    speed: null,
    defense: null,
    physicalPower: null,
    magPower: null,
  },
  cultivation: {
    experience: null,
    experienceToNextLevel: null,
    tao: null,
    potential: null,
  },
  assets: { cash: 0, goldCoin: null, silverCoin: null, voucher: null },
}

describe('character detail contract', () => {
  it.each(['0000000000000003', 'character-gid'])(
    'accepts a nonempty GID: %s',
    (gid) => {
      expect(characterDetailParamsSchema.parse({ gid })).toEqual({ gid })
    },
  )
  it.each(['', undefined, 3])('rejects an invalid GID: %s', (gid) => {
    expect(characterDetailParamsSchema.safeParse({ gid }).success).toBe(false)
  })
  it('accepts nullable fields and preserves a real zero', () => {
    expect(characterDetailResponseSchema.parse(detail)).toEqual(detail)
    expectTypeOf<CharacterDetailResponse['assets']['cash']>().toEqualTypeOf<
      number | null
    >()
  })
  it.each([undefined, '0', [], Number.NaN, Number.POSITIVE_INFINITY])(
    'rejects missing or invalid cash: %s',
    (cash) => {
      expect(
        characterDetailResponseSchema.safeParse({
          ...detail,
          assets: { ...detail.assets, cash },
        }).success,
      ).toBe(false)
    },
  )
  it('requires all business modules and rejects invalid string fields', () => {
    expect(
      characterDetailResponseSchema.safeParse({ basicInfo: detail.basicInfo })
        .success,
    ).toBe(false)
    expect(
      characterDetailResponseSchema.safeParse({
        ...detail,
        sectInfo: { ...detail.sectInfo, family: 1 },
      }).success,
    ).toBe(false)
  })
})
