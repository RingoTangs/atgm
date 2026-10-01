import { afterAll, describe, expect, it } from 'vitest'
import { buildApp } from '../app'

const app = buildApp()

afterAll(async () => {
  await app.close()
})

describe('get /privileges endpoint', () => {
  it('returns the account privilege dictionary in ascending order', async () => {
    const response = await app.inject({
      method: 'GET',
      url: '/privileges',
    })

    expect(response.statusCode).toBe(200)

    const privileges = response.json()

    expect(Array.isArray(privileges)).toBe(true)
    expect(privileges).toHaveLength(9)
    expect(
      privileges.map((item: { privilege: number }) => item.privilege),
    ).toEqual([0, 120, 130, 140, 150, 200, 300, 400, 1000])
    expect(privileges[0]).toEqual({
      privilege: 0,
      grant: '',
      constant: '',
      type: '普通用户',
      description: '普通用户',
    })
    expect(privileges[1]).toEqual({
      privilege: 120,
      grant: 'GA',
      constant: 'ADMINISTRATOR',
      type: '管理特权',
      description: '管理员',
    })
    expect(privileges[8]).toEqual({
      privilege: 1000,
      grant: 'GD',
      constant: 'DEBUGGER',
      type: '调试特权',
      description: '调试器权限',
    })
    for (const privilege of privileges) {
      expect(privilege).toEqual({
        privilege: expect.any(Number),
        grant: expect.any(String),
        constant: expect.any(String),
        type: expect.any(String),
        description: expect.any(String),
      })
    }
    expect(
      privileges.some(
        (item: { privilege: number }) =>
          item.privilege >= 101 && item.privilege <= 109,
      ),
    ).toBe(false)
  })
})
