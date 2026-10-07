import { describe, expect, it } from 'vitest'
import { formatAccountPrivilegeLabel } from './accountPrivilege'

describe('formatAccountPrivilegeLabel', () => {
  it('formats a privilege with grant and constant', () => {
    expect(
      formatAccountPrivilegeLabel({
        privilege: 120,
        grant: 'GA',
        constant: 'ADMINISTRATOR',
        description: '管理员',
      }),
    ).toBe('120 - GA - ADMINISTRATOR(管理员)')
  })

  it.each([
    { constant: 'ADMINISTRATOR' },
    { grant: 'GA' },
    { grant: '', constant: 'ADMINISTRATOR' },
    { grant: 'GA', constant: '' },
    {},
  ])('uses the description when metadata is missing: %j', (metadata) => {
    expect(
      formatAccountPrivilegeLabel({
        privilege: 120,
        description: '管理员',
        ...metadata,
      }),
    ).toBe('120 - 管理员')
  })

  it('formats an unknown privilege', () => {
    expect(
      formatAccountPrivilegeLabel({
        privilege: 999,
        description: '未知权限',
      }),
    ).toBe('999 - 未知权限')
  })
})
