import type { LpcValue } from './types'
import { parseLpcValue } from './parser'
import { writeLpcValue } from './writer'

export function formatLpcValue(
  value: LpcValue,
  options?: { indentSize?: number },
): string {
  const indentSize = options?.indentSize ?? 2
  if (!Number.isSafeInteger(indentSize) || indentSize < 0)
    throw new RangeError('indentSize must be a non-negative safe integer')
  return writeLpcValue(value, indentSize)
}

export function formatLpc(
  source: string,
  options?: { indentSize?: number },
): string {
  return formatLpcValue(parseLpcValue(source), options)
}
