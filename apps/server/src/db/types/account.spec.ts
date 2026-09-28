import type { AccountRow, AccountTable, NewAccount } from './account'
import { describe, expectTypeOf, it } from 'vitest'

type IsOptional<T, K extends keyof T> = object extends Pick<T, K> ? true : false
type HasNumericIdPlaceholder = 'id' extends keyof AccountTable ? true : false

describe('account table', () => {
  it('models selected values from the account DDL', () => {
    expectTypeOf<AccountRow['account']>().toEqualTypeOf<string>()
    expectTypeOf<AccountRow['gold_coin']>().toEqualTypeOf<number>()
    expectTypeOf<AccountRow['silver_coin']>().toEqualTypeOf<number>()
    expectTypeOf<AccountRow['memo']>().toEqualTypeOf<string | null>()
    expectTypeOf<AccountRow['update_time']>().toEqualTypeOf<Date>()
    expectTypeOf<HasNumericIdPlaceholder>().toEqualTypeOf<false>()
  })

  it('keeps columns with SQL defaults optional for inserts', () => {
    expectTypeOf<IsOptional<NewAccount, 'account'>>().toEqualTypeOf<true>()
    expectTypeOf<IsOptional<NewAccount, 'gold_coin'>>().toEqualTypeOf<true>()
    expectTypeOf<IsOptional<NewAccount, 'update_time'>>().toEqualTypeOf<true>()
    expectTypeOf<IsOptional<NewAccount, 'memo'>>().toEqualTypeOf<true>()
    expectTypeOf<NewAccount['update_time']>().toEqualTypeOf<
      Date | string | undefined
    >()
  })
})
