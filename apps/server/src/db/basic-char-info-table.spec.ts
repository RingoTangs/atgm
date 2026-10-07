import type {
  BasicCharInfoRow,
  BasicCharInfoTable,
  BasicCharInfoUpdate,
  NewBasicCharInfo,
} from '.'
import { describe, expectTypeOf, it } from 'vitest'

interface ExpectedRow {
  gid: string
  name: string
  polar: number
  gender: number
  tt_weibo_name: string
  hide_tt_weibo: number
  time: string
}

describe('basic char info table', () => {
  it('models all selected fields from the SQL table', () => {
    expectTypeOf<keyof BasicCharInfoTable>().toEqualTypeOf<keyof ExpectedRow>()
    expectTypeOf<BasicCharInfoRow>().toEqualTypeOf<ExpectedRow>()
  })

  it('keeps all columns with SQL defaults optional for inserts', () => {
    expectTypeOf<NewBasicCharInfo>().toExtend<Partial<ExpectedRow>>()
    expectTypeOf<Partial<ExpectedRow>>().toExtend<NewBasicCharInfo>()
  })

  it('allows partial updates with the SQL value types', () => {
    expectTypeOf<BasicCharInfoUpdate>().toEqualTypeOf<Partial<ExpectedRow>>()
  })
})
