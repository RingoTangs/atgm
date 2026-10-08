import type { LpcValue } from './types'
import { writeLpcValue } from './writer'

export function serializeLpcValue(value: LpcValue): string {
  return writeLpcValue(value)
}
