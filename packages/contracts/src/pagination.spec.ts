import type { z } from 'zod'
import type {
  AccountListItem,
  AccountsQuery,
  AccountsResponse,
  CharacterListItem,
  CharactersQuery,
  CharactersResponse,
  PaginationQuery,
} from '.'
import { describe, expect, expectTypeOf, it } from 'vitest'
import {
  accountListItemSchema,
  accountsQuerySchema,
  accountsResponseSchema,
  charactersQuerySchema,
  charactersResponseSchema,
  paginatedResponseSchema,
  paginationQuerySchema,
} from '.'

const account: AccountListItem = {
  account: 'test-account',
  online: false,
  privilege: 0,
  goldCoin: 0,
  silverCoin: 0,
  lastLoginTime: '',
  lastLoginIp: '',
  regDate: '',
}
const character: CharacterListItem = {
  gid: 'character-gid',
  name: '中文',
  polar: 1,
  gender: 2,
  time: '20180413155302',
}

describe.each([
  ['pagination', paginationQuerySchema],
  ['accounts', accountsQuerySchema],
  ['characters', charactersQuerySchema],
] as const)('%s query pagination', (_name, schema) => {
  it('uses the existing defaults', () => {
    expect(schema.parse({})).toEqual({ page: 1, pageSize: 20 })
  })

  it('converts query strings to numbers', () => {
    expect(schema.parse({ page: '3', pageSize: '50' })).toEqual({
      page: 3,
      pageSize: 50,
    })
  })

  it.each([1, 100])('accepts page size %s', (pageSize) => {
    expect(schema.parse({ pageSize })).toEqual({ page: 1, pageSize })
  })

  it.each([
    { page: 0 },
    { page: -1 },
    { page: 1.5 },
    { page: 'invalid' },
    { page: '' },
    { pageSize: 0 },
    { pageSize: -1 },
    { pageSize: 1.5 },
    { pageSize: 101 },
    { pageSize: 'invalid' },
    { pageSize: '' },
  ])('rejects invalid pagination: %j', (input) => {
    expect(schema.safeParse(input).success).toBe(false)
  })
})

describe('account query conditions', () => {
  it('retains the optional trimmed account filter', () => {
    expect(accountsQuerySchema.parse({ account: '  test-account  ' })).toEqual({
      page: 1,
      pageSize: 20,
      account: 'test-account',
    })
    expect(accountsQuerySchema.parse({ account: '  ' }).account).toBe('')
    expect(accountsQuerySchema.safeParse({ account: 123 }).success).toBe(false)
  })
})

describe.each([
  ['accounts', accountsResponseSchema, account],
  ['characters', charactersResponseSchema, character],
] as const)('%s paginated response', (_name, schema, item) => {
  it('preserves the response structure and list items', () => {
    const response = { page: 1, pageSize: 20, total: 1, items: [item] }
    expect(schema.parse(response)).toEqual(response)
  })

  it('accepts empty items and zero total', () => {
    const response = { page: 1, pageSize: 20, total: 0, items: [] }
    expect(schema.parse(response)).toEqual(response)
  })

  it.each([
    { total: -1 },
    { total: 1.5 },
    { total: '1' },
    { page: 1.5 },
    { pageSize: 1.5 },
    { items: [{}] },
    { items: 'invalid' },
  ])('rejects invalid response fields: %j', (overrides) => {
    expect(
      schema.safeParse({
        page: 1,
        pageSize: 20,
        total: 1,
        items: [item],
        ...overrides,
      }).success,
    ).toBe(false)
  })

  it('preserves the existing response integer ranges', () => {
    expect(
      schema.safeParse({ page: 0, pageSize: 101, total: 0, items: [] }).success,
    ).toBe(true)
  })
})

it('preserves the exported query and response type inference', () => {
  expectTypeOf<PaginationQuery>().toEqualTypeOf<{
    page: number
    pageSize: number
  }>()
  expectTypeOf<CharactersQuery>().toEqualTypeOf<PaginationQuery>()
  expectTypeOf<AccountsQuery>().toEqualTypeOf<{
    page: number
    pageSize: number
    account?: string | undefined
  }>()
  expectTypeOf<AccountsResponse>().toEqualTypeOf<{
    page: number
    pageSize: number
    total: number
    items: AccountListItem[]
  }>()
  expectTypeOf<CharactersResponse>().toEqualTypeOf<{
    page: number
    pageSize: number
    total: number
    items: CharacterListItem[]
  }>()
  const schema = paginatedResponseSchema(accountListItemSchema)
  expect(
    schema.parse({ page: 1, pageSize: 20, total: 1, items: [account] }).items,
  ).toEqual([account])
  expectTypeOf<z.infer<typeof schema>>().toEqualTypeOf<AccountsResponse>()
})
