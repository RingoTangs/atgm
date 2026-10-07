import type { PoolOptions } from 'mysql2'
import { decodeGb18030 } from '../lib/gb18030'

const GB18030_FIELDS = new Set(['basic_char_info.name'])

export const mysqlTypeCast: Exclude<
  NonNullable<PoolOptions['typeCast']>,
  boolean
> = (field, next) => {
  if (!GB18030_FIELDS.has(`${field.table}.${field.name}`)) return next()

  const bytes = field.buffer()
  return bytes === null ? null : decodeGb18030(bytes)
}
