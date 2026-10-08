import type { LpcValue } from './types'
import { LpcParseError } from './error'
import { parseLpcValue } from './parser'

export interface EmbeddedLpc {
  prefix: string
  source: string
  value: LpcValue
}

export function parseEmbeddedLpc(source: string): EmbeddedLpc | null {
  for (let offset = 0; offset < source.length - 1; offset++) {
    if (
      source[offset] !== '(' ||
      (source[offset + 1] !== '[' && source[offset + 1] !== '{')
    )
      continue

    const payload = source.slice(offset)
    try {
      return {
        prefix: source.slice(0, offset),
        source: payload,
        value: parseLpcValue(payload),
      }
    } catch (error) {
      if (!(error instanceof LpcParseError)) throw error
    }
  }
  return null
}
