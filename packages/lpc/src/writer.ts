import type { LpcValue } from './types'

const escapes = new Map([
  ['"', '\\"'],
  ['\\', '\\\\'],
  ['\n', '\\n'],
  ['\r', '\\r'],
  ['\t', '\\t'],
  ['\b', '\\b'],
  ['\f', '\\f'],
])

function writeString(value: string): string {
  let text = '"'
  for (const char of value) {
    const escaped = escapes.get(char)
    if (escaped !== undefined) text += escaped
    else if (char.charCodeAt(0) < 32)
      text += `\\u${char.charCodeAt(0).toString(16).padStart(4, '0')}`
    else text += char
  }
  return `${text}"`
}

function writeNumber(value: number): string {
  if (!Number.isFinite(value)) throw new TypeError('LPC numbers must be finite')
  if (Object.is(value, -0)) return '-0'
  let text = String(value)
  if (/e/i.test(text)) {
    const negative = text.startsWith('-')
    const [mantissa, exponent] = text.replace(/^-/, '').split('e')
    const [integer, fraction = ''] = mantissa!.split('.')
    const digits = integer! + fraction
    const position = integer!.length + Number(exponent)
    text =
      position <= 0
        ? `0.${'0'.repeat(-position)}${digits}`
        : position >= digits.length
          ? digits + '0'.repeat(position - digits.length)
          : `${digits.slice(0, position)}.${digits.slice(position)}`
    if (negative) text = `-${text}`
  }
  if (Number.isInteger(value) && !Number.isSafeInteger(value)) text += '.0'
  return text
}

export function writeLpcValue(value: LpcValue, indentSize?: number): string {
  const ancestors = new Set<LpcValue>()
  const pretty = indentSize !== undefined
  const indent = (depth: number) => ' '.repeat(depth * (indentSize ?? 0))

  const write = (current: LpcValue, depth: number): string => {
    if (typeof current === 'string') return writeString(current)
    if (typeof current === 'number') return writeNumber(current)
    if (Array.isArray(current) || current instanceof Map) {
      if (ancestors.has(current)) throw new TypeError('Circular LPC value')
      ancestors.add(current)
      try {
        const mapping = current instanceof Map
        const open = mapping ? '([' : '({'
        const close = mapping ? '])' : '})'
        const entries = mapping
          ? Array.from(current, ([key, item]) => {
              if (typeof key !== 'string' && typeof key !== 'number')
                throw new TypeError(
                  'LPC mapping keys must be strings or numbers',
                )
              return `${typeof key === 'string' ? writeString(key) : writeNumber(key)}:${pretty ? ' ' : ''}${write(item, depth + 1)}`
            })
          : current.map((item) => write(item, depth + 1))
        if (entries.length === 0) return open + close
        if (!pretty)
          return open + entries.map((entry) => `${entry},`).join('') + close
        return `${open}\n${entries.map((entry) => `${indent(depth + 1)}${entry},`).join('\n')}\n${indent(depth)}${close}`
      } finally {
        ancestors.delete(current)
      }
    }
    if (
      current &&
      current.type === 'special' &&
      typeof current.value === 'string' &&
      /^[\da-f]+$/i.test(current.value)
    )
      return `:${current.value}:`
    throw new TypeError('Invalid LPC special value')
  }

  return write(value, 0)
}
