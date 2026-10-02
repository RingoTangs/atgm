import { createHash } from 'node:crypto'
import { describe, expect, it } from 'vitest'
import {
  createAccountChecksum,
  createAccountPassword,
  hex8,
} from './account-crypto'

describe('account crypto', () => {
  it('calculates the legacy account password', () => {
    expect(createAccountPassword('test', '123123')).toBe(
      'CCE77B0DB6F881BF119A7F14C4FCDE50',
    )
  })

  it.each([
    [0, '00000000'],
    [15, '0000000F'],
    [1000, '000003E8'],
  ])('formats %d as an eight-character hexadecimal value', (value, result) => {
    expect(hex8(value)).toBe(result)
  })

  it('calculates the checksum from fields in legacy protocol order', () => {
    const password = 'CCE77B0DB6F881BF119A7F14C4FCDE50'
    const source = [
      'test',
      password,
      '0000000F',
      '0',
      '000003E8',
      '77359400',
      '',
      '',
      '',
      '',
      '',
      'ABCDEF',
    ].join('')
    const independentlyCalculatedChecksum = createHash('md5')
      .update(source, 'utf8')
      .digest('hex')
      .toUpperCase()

    expect(independentlyCalculatedChecksum).toBe(
      '3B37F70E2DF195DCAA2955D0E2900FC4',
    )
    expect(
      createAccountChecksum({
        account: 'test',
        password,
        blockedTime: '0',
        goldCoin: 1000,
        silverCoin: 2_000_000_000,
        privilege: 15,
        coinPassword: '',
        unlockCoinPasswordTime: '',
        tradeLockTime: '',
        permitIp: '',
        permitId: '',
      }),
    ).toBe(independentlyCalculatedChecksum)
  })

  it('includes every database checksum field in legacy protocol order', () => {
    const input = {
      account: 'legacy-account',
      password: 'PASSWORD_HASH',
      privilege: 120,
      blockedTime: '20261002153045',
      goldCoin: 1_000_000,
      silverCoin: 50_000,
      coinPassword: 'COIN_HASH',
      unlockCoinPasswordTime: '20261003120000',
      tradeLockTime: '20261004120000',
      permitIp: '192.0.2.1',
      permitId: 'device-01',
    }
    const source = [
      input.account,
      input.password,
      '00000078',
      input.blockedTime,
      '000F4240',
      '0000C350',
      input.coinPassword,
      input.unlockCoinPasswordTime,
      input.tradeLockTime,
      input.permitIp,
      input.permitId,
      'ABCDEF',
    ].join('')
    const independentlyCalculatedChecksum = createHash('md5')
      .update(source, 'utf8')
      .digest('hex')
      .toUpperCase()

    expect(createAccountChecksum(input)).toBe(independentlyCalculatedChecksum)
  })
})
