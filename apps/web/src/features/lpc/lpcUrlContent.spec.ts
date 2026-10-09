import { describe, expect, it } from 'vitest'
import { decodeLpcUrlContent, encodeLpcUrlContent } from './lpcUrlContent'

describe('lPC URL content', () => {
  it.each([
    '',
    '123',
    '(["name":"女金",])',
    '中文\n\t😀',
    '长文本😀'.repeat(10000),
  ])('round trips UTF-8 text (case %#)', (content) => {
    const encoded = encodeLpcUrlContent(content)
    expect(encoded).toMatch(/^[\w-]*$/)
    expect(decodeLpcUrlContent(encoded)).toBe(content)
  })
  it.each(['!', 'a', 'YWJj=', 'YW Jj', '_w', 'Zh'])(
    'rejects malformed encoding: %s',
    (content) => {
      expect(() => decodeLpcUrlContent(content)).toThrow()
    },
  )
})
