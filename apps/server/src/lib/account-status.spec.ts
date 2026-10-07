import type { Kysely } from 'kysely'
import type { DdbDatabase } from '../db'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import { getOnlineAccounts, isAccountOnline } from './account-status'

const execute = vi.fn()
const executeTakeFirst = vi.fn()
const namesWhere = vi.fn(() => ({ execute, executeTakeFirst }))
const pathWhere = vi.fn(() => ({ where: namesWhere }))
const select = vi.fn(() => ({ where: pathWhere }))
const selectFrom = vi.fn(() => ({ select }))
const ddb = { selectFrom } as unknown as Kysely<DdbDatabase>

beforeEach(() => {
  vi.clearAllMocks()
  execute.mockResolvedValue([])
  executeTakeFirst.mockResolvedValue(undefined)
})

describe('account status', () => {
  it.each([
    { row: { name: 'online-account' }, online: true },
    { row: undefined, online: false },
  ])('returns $online for a single account', async ({ row, online }) => {
    executeTakeFirst.mockResolvedValue(row)

    await expect(isAccountOnline(ddb, 'online-account')).resolves.toBe(online)
    expect(selectFrom).toHaveBeenCalledWith('data')
    expect(select).toHaveBeenCalledWith('name')
    expect(pathWhere).toHaveBeenCalledWith('path', '=', 'runtime')
    expect(namesWhere).toHaveBeenCalledWith('name', '=', 'online-account')
    expect(executeTakeFirst).toHaveBeenCalledOnce()
    expect(execute).not.toHaveBeenCalled()
  })

  it('queries accounts once and returns a set of online names', async () => {
    execute.mockResolvedValue([
      { name: 'first' },
      { name: 'third' },
      { name: 'first' },
    ])

    await expect(
      getOnlineAccounts(ddb, ['first', 'second', 'third']),
    ).resolves.toEqual(new Set(['first', 'third']))
    expect(selectFrom).toHaveBeenCalledWith('data')
    expect(select).toHaveBeenCalledWith('name')
    expect(pathWhere).toHaveBeenCalledWith('path', '=', 'runtime')
    expect(namesWhere).toHaveBeenCalledWith('name', 'in', [
      'first',
      'second',
      'third',
    ])
    expect(execute).toHaveBeenCalledOnce()
    expect(executeTakeFirst).not.toHaveBeenCalled()
  })

  it('returns an empty set when all accounts are offline', async () => {
    await expect(getOnlineAccounts(ddb, ['offline'])).resolves.toEqual(
      new Set(),
    )
    expect(execute).toHaveBeenCalledOnce()
  })

  it('skips the database for empty input', async () => {
    await expect(getOnlineAccounts(ddb, [])).resolves.toEqual(new Set())
    expect(selectFrom).not.toHaveBeenCalled()
  })

  it('propagates a single-account database error unchanged', async () => {
    const error = new Error('database unavailable')
    executeTakeFirst.mockRejectedValueOnce(error)
    await expect(isAccountOnline(ddb, 'account')).rejects.toBe(error)
  })

  it('propagates a batch database error unchanged', async () => {
    const error = new Error('database unavailable')
    execute.mockRejectedValueOnce(error)
    await expect(getOnlineAccounts(ddb, ['account'])).rejects.toBe(error)
  })
})
