import { Buffer } from 'node:buffer'
import { parseLpcValue } from '@atgm/lpc'
import iconv from 'iconv-lite'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import { parseLoginData } from '../lib/login-data'
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

const whitelistedFields = [
  { table: 'basic_char_info', name: 'name' },
  { table: 'data', name: 'name' },
  { table: 'data', name: 'branch' },
  { table: 'data', name: 'content' },
]

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

  it.each(whitelistedFields)('preserves null for $table.$name', (column) => {
    buffer.mockReturnValue(null)
    expect(mysqlTypeCast({ ...field, ...column }, next)).toBeNull()
    expect(buffer).toHaveBeenCalledOnce()
    expect(next).not.toHaveBeenCalled()
  })

  it.each(whitelistedFields)(
    'decodes an empty Buffer for $table.$name',
    (column) => {
      buffer.mockReturnValue(Buffer.alloc(0))
      expect(mysqlTypeCast({ ...field, ...column }, next)).toBe('')
      expect(next).not.toHaveBeenCalled()
    },
  )

  it.each([
    { table: 'basic_char_info', name: 'gid', type: 'VAR_STRING', value: 'gid' },
    { table: 'data', name: 'path', type: 'VAR_STRING', value: 'login' },
    {
      table: 'data',
      name: 'time',
      type: 'VAR_STRING',
      value: '20180413155302',
    },
    { table: 'data', name: 'checksum', type: 'LONG', value: -1512695051 },
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
    { table: 'data', name: 'memo', type: 'BLOB', value: 'existing memo' },
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

  it.each([
    { name: 'name', value: '中文名称' },
    { name: 'branch', value: '第一届' },
    { name: 'name', value: 'runtime-account' },
    { name: 'content', value: '([])' },
  ])('decodes data.$name containing $value', ({ name, value }) => {
    buffer.mockReturnValue(iconv.encode(value, 'gb18030'))
    expect(mysqlTypeCast({ ...field, table: 'data', name }, next)).toBe(value)
    expect(buffer).toHaveBeenCalledOnce()
    expect(string).not.toHaveBeenCalled()
    expect(next).not.toHaveBeenCalled()
  })

  it('preserves Chinese and embedded LPC in decoded content', () => {
    const content =
      '(["name":"中文","items":({1,2,}),"embedded":"前缀:([1:2,])",])'
    buffer.mockReturnValue(iconv.encode(content, 'gb18030'))
    const decoded = mysqlTypeCast(
      { ...field, table: 'data', name: 'content', type: 'BLOB' },
      next,
    )
    expect(decoded).toBe(content)
    expect(parseLpcValue(decoded as string)).toEqual(parseLpcValue(content))
    expect(next).not.toHaveBeenCalled()
  })

  it('preserves login chars and rec_role after decoding', () => {
    const content =
      '(["rec_role":"gid-1","create_time":1,"chars":({"gid-1","gid-2",}),"safe_status":0,"register_time":0,])'
    buffer.mockReturnValue(Buffer.from(content, 'ascii'))
    const decoded = mysqlTypeCast(
      { ...field, table: 'data', name: 'content', type: 'BLOB' },
      next,
    )
    expect(parseLoginData(decoded as string)).toEqual({
      recRole: 'gid-1',
      createTime: 1,
      chars: ['gid-1', 'gid-2'],
      safeStatus: 0,
      registerTime: 0,
    })
    expect(decoded).toBe(content)
    expect(next).not.toHaveBeenCalled()
  })
})
