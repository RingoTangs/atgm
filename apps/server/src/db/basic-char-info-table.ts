import type { ColumnType, Insertable, Selectable, Updateable } from 'kysely'

type Defaulted<T> = ColumnType<T, T | undefined, T>

export interface BasicCharInfoTable {
  gid: Defaulted<string>
  name: Defaulted<string>
  polar: Defaulted<number>
  gender: Defaulted<number>
  tt_weibo_name: Defaulted<string>
  hide_tt_weibo: Defaulted<number>
  time: Defaulted<string>
}

export type BasicCharInfoRow = Selectable<BasicCharInfoTable>
export type NewBasicCharInfo = Insertable<BasicCharInfoTable>
export type BasicCharInfoUpdate = Updateable<BasicCharInfoTable>
