import type { ServerListItem, ServersQuery, ServersResponse } from '.'
import { describe, expect, expectTypeOf, it } from 'vitest'
import { serverListItemSchema } from '.'

const server: ServerListItem = {
  id: 1,
  server: '万里长城一线',
  dist: '万里长城',
  alias: '',
  ip: '47.97.104.166',
  port: 8160,
  maxUser: 1200,
  enable: 1,
}

describe('server list contract', () => {
  it('strips private configuration fields', () => {
    expect(
      serverListItemSchema.parse({
        ...server,
        server_key: 'secret',
        memo: 'private',
      }),
    ).toEqual(server)
  })

  it.each(['id', 'port', 'maxUser', 'enable'] as const)(
    'requires integer %s',
    (field) => {
      expect(
        serverListItemSchema.safeParse({ ...server, [field]: '1' }).success,
      ).toBe(false)
      expect(
        serverListItemSchema.safeParse({ ...server, [field]: 1.5 }).success,
      ).toBe(false)
    },
  )

  it.each(['server', 'dist', 'alias', 'ip'] as const)(
    'requires string %s',
    (field) => {
      expect(
        serverListItemSchema.safeParse({ ...server, [field]: null }).success,
      ).toBe(false)
    },
  )

  it('exports the inferred query and response types', () => {
    expectTypeOf<ServersQuery>().toEqualTypeOf<{
      page: number
      pageSize: number
    }>()
    expectTypeOf<ServersResponse>().toEqualTypeOf<{
      page: number
      pageSize: number
      total: number
      items: ServerListItem[]
    }>()
  })
})
