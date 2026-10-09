import type { LpcMapping } from '@atgm/lpc'
import { parseLpcValue } from '@atgm/lpc'

export function readCharacterMe(content: string): LpcMapping | undefined {
  const root = parseLpcValue(content)
  if (!(root instanceof Map))
    throw new Error('Character data root must be a mapping')
  const me = root.get('me')
  if (me === undefined) return undefined
  if (!(me instanceof Map)) throw new Error('me must be a mapping')
  return me
}

export function readCharacterString(
  me: LpcMapping | undefined,
  key: string,
): string | null {
  const value = me?.get(key)
  if (value === undefined || value === '') return null
  if (typeof value !== 'string') throw new Error(`me.${key} must be a string`)
  return value
}

export function readCharacterNumber(
  me: LpcMapping | undefined,
  key: string,
): number | null {
  const value = me?.get(key)
  if (value === undefined) return null
  if (typeof value !== 'number' || !Number.isFinite(value))
    throw new Error(`me.${key} must be a finite number`)
  return value
}
