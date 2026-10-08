import type { LpcMapping, LpcValue } from '@atgm/lpc-serialization'
import { parseLpcValue } from '@atgm/lpc-serialization'

export interface LoginData {
  createTime: number
  recRole: string
  safeStatus: number
  chars: string[]
  registerTime: number
}

export class LoginDataError extends Error {
  constructor(message: string) {
    super(message)
    this.name = 'LoginDataError'
  }
}

function readNumber(mapping: LpcMapping, key: string): number {
  const value = mapping.get(key)
  if (typeof value !== 'number')
    throw new LoginDataError(`${key} must be a number`)
  return value
}

function readString(mapping: LpcMapping, key: string): string {
  const value = mapping.get(key)
  if (typeof value !== 'string')
    throw new LoginDataError(`${key} must be a string`)
  return value
}

function isStringArray(value: LpcValue | undefined): value is string[] {
  return Array.isArray(value) && value.every((item) => typeof item === 'string')
}

export function parseLoginData(content: string): LoginData {
  const root = parseLpcValue(content)
  if (!(root instanceof Map))
    throw new LoginDataError('Login data root must be a mapping')

  const createTime = readNumber(root, 'create_time')
  const recRole = readString(root, 'rec_role')
  const safeStatus = readNumber(root, 'safe_status')
  const chars = root.get('chars')
  if (!isStringArray(chars))
    throw new LoginDataError('chars must be an array of strings')
  const registerTime = readNumber(root, 'register_time')

  return { createTime, recRole, safeStatus, chars, registerTime }
}
