import { Buffer } from 'node:buffer'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import { mysqlTypeCast } from './mysql-type-cast'

const buffer = vi.fn<() => Buffer | null>()
const string = vi.fn<() => string | null>()
const next = vi.fn<() => unknown>()
const field: Parameters<typeof mysqlTypeCast>[0] = {
  type: 'VAR_STRING',
  length: 32,
  db: 'dl_ddb_1',
  table: 'basic_char_info',
  name: 'name',
  buffer,
  string,
  geometry: () => null,
}

beforeEach(() => {
  vi.resetAllMocks()
})

describe('mysqlTypeCast', () => {
  it('decodes the whitelisted name from raw GB18030 bytes', () => {
    buffer.mockReturnValue(Buffer.from([0xd6, 0xd0, 0xce, 0xc4]))
    expect(mysqlTypeCast(field, next)).toBe('中文')
    expect(buffer).toHaveBeenCalledOnce()
    expect(string).not.toHaveBeenCalled()
    expect(next).not.toHaveBeenCalled()
  })

  it('preserves null for a whitelisted field', () => {
    buffer.mockReturnValue(null)
    expect(mysqlTypeCast(field, next)).toBeNull()
    expect(buffer).toHaveBeenCalledOnce()
    expect(next).not.toHaveBeenCalled()
  })

  it('decodes an empty Buffer as an empty string', () => {
    buffer.mockReturnValue(Buffer.alloc(0))
    expect(mysqlTypeCast(field, next)).toBe('')
    expect(next).not.toHaveBeenCalled()
  })

  it.each([
    { table: 'basic_char_info', name: 'gid', type: 'VAR_STRING', value: 'gid' },
    {
      table: 'data',
      name: 'name',
      type: 'VAR_STRING',
      value: 'runtime-account',
    },
    {
      table: 'other_table',
      name: 'name',
      type: 'VAR_STRING',
      value: 'other-name',
    },
    { table: 'basic_char_info', name: 'polar', type: 'TINY', value: 1 },
    { table: 'basic_char_info', name: 'gender', type: 'TINY', value: 2 },
    {
      table: '',
      name: 'nameBytes',
      type: 'VAR_STRING',
      value: Buffer.from([0xff]),
    },
    { table: 'data', name: 'memo', type: 'VAR_STRING', value: null },
  ] as const)(
    'delegates $table.$name to mysql2',
    ({ table, name, type, value }) => {
      next.mockReturnValue(value)
      expect(mysqlTypeCast({ ...field, table, name, type }, next)).toBe(value)
      expect(next).toHaveBeenCalledOnce()
      expect(buffer).not.toHaveBeenCalled()
      expect(string).not.toHaveBeenCalled()
    },
  )
})
