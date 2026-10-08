export class LpcParseError extends Error {
  readonly offset: number

  constructor(message: string, offset: number) {
    super(message)
    this.name = 'LpcParseError'
    this.offset = offset
  }
}
