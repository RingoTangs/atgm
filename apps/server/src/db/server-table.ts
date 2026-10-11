import type { ColumnType, Insertable, Selectable, Updateable } from 'kysely'

type Defaulted<T> = ColumnType<T, T | undefined, T>
type NullableText = ColumnType<
  string | null,
  string | null | undefined,
  string | null
>

export interface ServerTable {
  server: Defaulted<string>
  alias: Defaulted<string>
  ip: Defaulted<string>
  port: Defaulted<number>
  max_user: Defaulted<number>
  dist: Defaulted<string>
  enable: Defaulted<number>
  server_key: Defaulted<string>
  when_iid_duplicated: Defaulted<string>
  when_challenge_failed: Defaulted<string>
  when_found_cheater: Defaulted<string>
  punish_id: Defaulted<number>
  save_when_coin_cost: Defaulted<number>
  charge_level: Defaulted<number>
  charge_interval: Defaulted<number>
  id: Defaulted<number>
  ahserver: Defaulted<string>
  ip_wt: Defaulted<string>
  ip_dx: Defaulted<string>
  enable_multi_ip: Defaulted<number>
  memo: NullableText
}

export type ServerRow = Selectable<ServerTable>
export type NewServer = Insertable<ServerTable>
export type ServerUpdate = Updateable<ServerTable>
