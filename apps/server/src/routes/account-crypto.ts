import { createHash } from 'node:crypto'

const PASSWORD_SALT = '20070201'
const CHECKSUM_SALT = 'ABCDEF'

interface AccountChecksumInput {
  account: string
  password: string
  privilege: number
  blockedTime: string
  goldCoin: number
  silverCoin: number
  coinPassword: string
  unlockCoinPasswordTime: string
  tradeLockTime: string
  permitIp: string
  permitId: string
}

export function md5Upper(value: string): string {
  return createHash('md5').update(value, 'utf8').digest('hex').toUpperCase()
}

export function hex8(value: number): string {
  return value.toString(16).toUpperCase().padStart(8, '0')
}

export function createAccountPassword(
  account: string,
  rawPassword: string,
): string {
  return md5Upper(`${account}${md5Upper(rawPassword)}${PASSWORD_SALT}`)
}

export function createAccountChecksum({
  account,
  password,
  blockedTime,
  goldCoin,
  silverCoin,
  privilege,
  coinPassword,
  unlockCoinPasswordTime,
  tradeLockTime,
  permitIp,
  permitId,
}: AccountChecksumInput): string {
  const source =
    account +
    password +
    hex8(privilege) +
    blockedTime +
    hex8(goldCoin) +
    hex8(silverCoin) +
    coinPassword +
    unlockCoinPasswordTime +
    tradeLockTime +
    permitIp +
    permitId +
    CHECKSUM_SALT

  return md5Upper(source)
}
