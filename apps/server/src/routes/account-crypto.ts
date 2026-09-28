import { createHash } from 'node:crypto'

const PASSWORD_SALT = '20070201'
const CHECKSUM_SALT = 'ABCDEF'

const accountDefaults = {
  blockedTime: '0',
  coinPassword: '',
  unlockCoinPasswordTime: '',
  tradeLockTime: '',
  permitIp: '',
  permitId: '',
} as const

interface AccountChecksumInput {
  account: string
  password: string
  goldCoin: number
  silverCoin: number
  privilege: number
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
  goldCoin,
  silverCoin,
  privilege,
}: AccountChecksumInput): string {
  const source =
    account +
    password +
    hex8(privilege) +
    accountDefaults.blockedTime +
    hex8(goldCoin) +
    hex8(silverCoin) +
    accountDefaults.coinPassword +
    accountDefaults.unlockCoinPasswordTime +
    accountDefaults.tradeLockTime +
    accountDefaults.permitIp +
    accountDefaults.permitId +
    CHECKSUM_SALT

  return md5Upper(source)
}
