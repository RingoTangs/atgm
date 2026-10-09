import type {
  CharacterItem,
  CharacterItemDetailResponse,
} from '@atgm/contracts'
import { parseEmbeddedLpc, parseLpcValue } from '@atgm/lpc'

export class CharacterCarryError extends Error {
  readonly entryKey: number | null

  constructor(message: string, entryKey: number | null = null) {
    super(message)
    this.name = 'CharacterCarryError'
    this.entryKey = entryKey
  }
}

function readCarry(content: string) {
  let root
  try {
    root = parseLpcValue(content)
  } catch {
    throw new CharacterCarryError('Invalid outer LPC')
  }
  if (!(root instanceof Map))
    throw new CharacterCarryError('Carry data root must be a mapping')
  const carry = root.get('carry')
  if (!(carry instanceof Map))
    throw new CharacterCarryError('carry must be a mapping')
  return carry
}

function readItem(key: number, value: unknown): CharacterItemDetailResponse {
  if (typeof value !== 'string')
    throw new CharacterCarryError('Carry entry must be a string', key)
  const embedded = parseEmbeddedLpc(value)
  if (!embedded || !(embedded.value instanceof Map))
    throw new CharacterCarryError(
      'Carry entry must contain an LPC mapping',
      key,
    )
  if (!embedded.prefix.endsWith(':') || embedded.prefix.length === 1)
    throw new CharacterCarryError(
      'Carry entry must have a name followed by a colon',
      key,
    )
  const alias = embedded.value.get('alias')
  if (alias !== undefined && typeof alias !== 'string')
    throw new CharacterCarryError('Carry alias must be a string', key)
  return {
    entryKey: key,
    name: embedded.prefix.slice(0, -1),
    alias: alias || null,
    lpc: embedded.source,
  }
}

export function parseCharacterCarry(content: string): CharacterItem[] {
  const items: CharacterItem[] = []
  for (const [key, value] of readCarry(content)) {
    if (typeof key !== 'number' || !Number.isFinite(key))
      throw new CharacterCarryError('Carry entry key must be a finite number')
    const { lpc: _lpc, ...item } = readItem(key, value)
    items.push(item)
  }
  return items.sort((left, right) => left.entryKey - right.entryKey)
}

export function parseCharacterCarryItem(
  content: string,
  entryKey: number,
): CharacterItemDetailResponse | null {
  const carry = readCarry(content)
  return carry.has(entryKey) ? readItem(entryKey, carry.get(entryKey)) : null
}
