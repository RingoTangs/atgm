import { LpcParseError } from './error'

type Punctuation = '(' | ')' | '[' | ']' | '{' | '}' | ',' | ':'
export type Token =
  | { type: 'string'; value: string; offset: number }
  | { type: 'number'; value: number; offset: number }
  | { type: Punctuation | 'eof'; offset: number }

const escapes = new Map([
  ['"', '"'],
  ['\\', '\\'],
  ['n', '\n'],
  ['r', '\r'],
  ['t', '\t'],
  ['b', '\b'],
  ['f', '\f'],
])

export class Tokenizer {
  private offset = 0
  private readonly source: string

  constructor(source: string) {
    this.source = source
  }

  next(): Token {
    while (
      this.offset < this.source.length &&
      /\s/.test(this.source[this.offset]!)
    )
      this.offset++

    const offset = this.offset
    const char = this.source[offset]
    if (char === undefined) return { type: 'eof', offset }
    if ('()[]{},:'.includes(char)) {
      this.offset++
      return { type: char as Punctuation, offset }
    }
    if (char === '"') return this.readString()
    if (char === '-' || /\d/.test(char)) return this.readNumber()
    throw new LpcParseError('Unknown token', offset)
  }

  readSpecial(): string {
    const start = this.offset
    while (
      this.offset < this.source.length &&
      this.source[this.offset] !== ':'
    ) {
      if (!/[\da-f]/i.test(this.source[this.offset]!))
        throw new LpcParseError('Invalid special value', this.offset)
      this.offset++
    }
    if (this.offset === this.source.length)
      throw new LpcParseError('Unterminated special value', this.offset)
    if (this.offset === start)
      throw new LpcParseError('Empty special value', start)
    const value = this.source.slice(start, this.offset)
    this.offset++
    return value
  }

  private readNumber(): Token {
    const offset = this.offset
    while (this.offset < this.source.length) {
      const char = this.source[this.offset]!
      if (/\s/.test(char) || '()[]{},:'.includes(char)) break
      this.offset++
    }
    const text = this.source.slice(offset, this.offset)
    const value = Number(text)
    if (!/^-?\d+(?:\.\d+)?$/.test(text) || !Number.isFinite(value))
      throw new LpcParseError('Invalid number', offset)
    return { type: 'number', value, offset }
  }

  private readString(): Token {
    const offset = this.offset++
    let value = ''
    while (this.offset < this.source.length) {
      const position = this.offset
      const char = this.source[this.offset++]!
      if (char === '"') return { type: 'string', value, offset }
      if (char.charCodeAt(0) < 32)
        throw new LpcParseError('Unescaped control character', position)
      if (char !== '\\') {
        value += char
        continue
      }
      if (this.offset === this.source.length)
        throw new LpcParseError('Unterminated escape', this.offset)
      const escapeOffset = this.offset
      const escaped = this.source[this.offset++]!
      if (escaped === 'u') {
        for (let index = 0; index < 4; index++) {
          const digitOffset = this.offset + index
          if (!/[\da-f]/i.test(this.source[digitOffset] ?? ''))
            throw new LpcParseError(
              'Invalid Unicode escape',
              Math.min(digitOffset, this.source.length),
            )
        }
        value += String.fromCharCode(
          Number.parseInt(this.source.slice(this.offset, this.offset + 4), 16),
        )
        this.offset += 4
      } else {
        const replacement = escapes.get(escaped)
        if (replacement === undefined)
          throw new LpcParseError('Unknown escape', escapeOffset)
        value += replacement
      }
    }
    throw new LpcParseError('Unterminated string', this.offset)
  }
}
