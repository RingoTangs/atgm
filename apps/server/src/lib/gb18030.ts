import type { Buffer } from 'node:buffer'
import iconv from 'iconv-lite'

export function decodeGb18030(bytes: Buffer): string {
  return iconv.decode(bytes, 'gb18030')
}
