import type { Token } from './tokenizer'
import type { LpcArray, LpcMapping, LpcValue } from './types'
import { LpcParseError } from './error'
import { Tokenizer } from './tokenizer'

class Parser {
  private readonly tokenizer: Tokenizer
  private token: Token

  constructor(source: string) {
    this.tokenizer = new Tokenizer(source)
    this.token = this.tokenizer.next()
  }

  parse(): LpcValue {
    const value = this.readValue()
    this.expect('eof')
    return value
  }

  private advance(): void {
    this.token = this.tokenizer.next()
  }

  private expect(type: Token['type']): void {
    if (this.token.type !== type)
      throw new LpcParseError(
        `Expected ${type}, received ${this.token.type}`,
        this.token.offset,
      )
  }

  private consume(type: Token['type']): void {
    this.expect(type)
    this.advance()
  }

  private readValue(): LpcValue {
    const token = this.token
    if (token.type === 'string' || token.type === 'number') {
      this.advance()
      return token.value
    }
    if (token.type === ':') {
      const value = this.tokenizer.readSpecial()
      this.advance()
      return { type: 'special', value }
    }
    if (token.type === '(') {
      this.advance()
      if (this.token.type === '{') return this.readArray()
      if (this.token.type === '[') return this.readMapping()
    }
    throw new LpcParseError('Expected LPC value', this.token.offset)
  }

  private readArray(): LpcArray {
    this.consume('{')
    const array: LpcArray = []
    while (this.token.type !== '}') {
      array.push(this.readValue())
      if (!this.readSeparator('}')) break
    }
    this.consume('}')
    this.consume(')')
    return array
  }

  private readMapping(): LpcMapping {
    this.consume('[')
    const mapping: LpcMapping = new Map()
    while (this.token.type !== ']') {
      const key = this.token
      if (key.type !== 'string' && key.type !== 'number')
        throw new LpcParseError(
          'Expected string or number mapping key',
          key.offset,
        )
      this.advance()
      this.consume(':')
      mapping.set(key.value, this.readValue())
      if (!this.readSeparator(']')) break
    }
    this.consume(']')
    this.consume(')')
    return mapping
  }

  private readSeparator(close: '}' | ']'): boolean {
    if (this.token.type === close) return false
    this.consume(',')
    return true
  }
}

export function parseLpcValue(source: string): LpcValue {
  return new Parser(source).parse()
}
