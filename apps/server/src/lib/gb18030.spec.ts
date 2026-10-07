import { Buffer } from 'node:buffer'
import { describe, expect, it } from 'vitest'
import { decodeGb18030 } from './gb18030'

describe('decodeGb18030', () => {
  it('decodes known GB18030 bytes as Chinese text', () => {
    expect(decodeGb18030(Buffer.from([0xd6, 0xd0, 0xce, 0xc4]))).toBe('中文')
  })

  it('decodes ASCII bytes', () => {
    expect(decodeGb18030(Buffer.from([0x41, 0x42, 0x43]))).toBe('ABC')
  })

  it('returns an empty string for an empty Buffer', () => {
    expect(decodeGb18030(Buffer.alloc(0))).toBe('')
  })
})
