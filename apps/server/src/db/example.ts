import type { Insertable, Kysely } from 'kysely'
import type { AccountDatabase, GameDatabase, PlayerTable } from './types'

export function getExampleUsers(accountDb: Kysely<AccountDatabase>) {
  return accountDb.selectFrom('users').selectAll().limit(10).execute()
}

export function getExamplePlayers(gameDb: Kysely<GameDatabase>) {
  return gameDb.selectFrom('players').selectAll().limit(10).execute()
}

export function createExamplePlayer(
  gameDb: Kysely<GameDatabase>,
  player: Insertable<PlayerTable>,
) {
  return gameDb.insertInto('players').values(player).executeTakeFirst()
}

export function updateExamplePlayerLevel(
  gameDb: Kysely<GameDatabase>,
  id: number,
  level: number,
) {
  return gameDb
    .updateTable('players')
    .set({ level })
    .where('id', '=', id)
    .executeTakeFirst()
}

export function deleteExamplePlayer(gameDb: Kysely<GameDatabase>, id: number) {
  return gameDb.deleteFrom('players').where('id', '=', id).executeTakeFirst()
}
