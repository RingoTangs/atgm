import type { Generated, Kysely } from 'kysely'

export interface UserTable {
  id: Generated<number>
  username: string
}

export interface PlayerTable {
  id: Generated<number>
  account_id: number
  level: number
}

export interface Database {
  users: UserTable
  players: PlayerTable
}

export type AccountDatabase = Pick<Database, 'users'>
export type GameDatabase = Pick<Database, 'players'>

export interface FastifyDatabases {
  account: Kysely<AccountDatabase>
  game: Kysely<GameDatabase>
}
