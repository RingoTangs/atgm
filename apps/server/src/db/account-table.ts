import type { ColumnType, Insertable, Selectable, Updateable } from 'kysely'

type Defaulted<T> = ColumnType<T, T | undefined, T>
type Timestamp = ColumnType<Date, Date | string | undefined, Date | string>
type NullableText = ColumnType<
  string | null,
  string | null | undefined,
  string | null
>

export interface AccountTable {
  account: Defaulted<string>
  blocked_time: Defaulted<string>
  blocked_reason: Defaulted<string>
  temp_blocked_time: Defaulted<string>
  temp_blocked_reason: Defaulted<string>
  password: Defaulted<string>
  protect: Defaulted<string>
  auto_lock: Defaulted<number>
  locked: Defaulted<string>
  gold_coin: Defaulted<number>
  silver_coin: Defaulted<number>
  limit_trade_coin: Defaulted<number>
  trade_lock_time: Defaulted<string>
  name: Defaulted<string>
  birthday: Defaulted<string>
  id_type: Defaulted<string>
  id_num: Defaulted<string>
  tel: Defaulted<string>
  mobile: Defaulted<string>
  email: Defaulted<string>
  time: Defaulted<number>
  active_time: Defaulted<string>
  first_login_time: Defaulted<string>
  first_login_mac: Defaulted<string>
  privilege: Defaulted<number>
  account_id: Defaulted<string>
  permit_ip: Defaulted<string>
  permit_id: Defaulted<string>
  ip: Defaulted<string>
  adult: Defaulted<number>
  checksum: Defaulted<string>
  coin_password: Defaulted<string>
  unlock_coin_password_time: Defaulted<string>
  org_password: Defaulted<string>
  org_permit_ip: Defaulted<string>
  last_login_time: Defaulted<string>
  last_login_ip: Defaulted<string>
  last_login_id: Defaulted<string>
  presentee: Defaulted<number>
  reg_date: Defaulted<string>
  active_path: Defaulted<number>
  trade_coin: Defaulted<number>
  last_trade_coin: Defaulted<string>
  consum_coin: Defaulted<number>
  last_consum_coin: Defaulted<string>
  update_time: Timestamp
  memo: NullableText
}

export type AccountRow = Selectable<AccountTable>
export type NewAccount = Insertable<AccountTable>
export type AccountUpdate = Updateable<AccountTable>
