import process from 'node:process'
import { describe, expect, it, vi } from 'vitest'
import { buildApp } from './app'
import { createShutdownHandler, parsePort } from './server'

describe('parsePort', () => {
  it('uses 8080 when PORT is not set', () => {
    expect(parsePort(undefined)).toBe(8080)
  })

  it.each([
    ['1', 1],
    ['8080', 8080],
    ['65535', 65535],
  ])('accepts %s', (value, expected) => {
    expect(parsePort(value)).toBe(expected)
  })

  it.each(['', '0', '1.5', '65536', 'not-a-number'])(
    'rejects invalid value %j',
    (value) => {
      expect(() => parsePort(value)).toThrow(
        `Invalid PORT "${value}": expected an integer between 1 and 65535`,
      )
    },
  )
})

describe('createShutdownHandler', () => {
  it('closes the app only once when shutdown repeats', async () => {
    const app = buildApp()
    const close = vi.spyOn(app, 'close').mockResolvedValue(undefined)
    const shutdown = createShutdownHandler(app)

    await Promise.all([shutdown('SIGINT'), shutdown('SIGTERM')])

    expect(close).toHaveBeenCalledOnce()
  })

  it('logs close failures and sets a failing exit code', async () => {
    const originalExitCode = process.exitCode
    const app = buildApp()
    const error = new Error('close failed')
    vi.spyOn(app, 'close').mockRejectedValue(error)
    const logError = vi.spyOn(app.log, 'error').mockImplementation(() => {})
    const shutdown = createShutdownHandler(app)

    try {
      await shutdown('SIGTERM')

      expect(logError).toHaveBeenCalledWith(
        { err: error, signal: 'SIGTERM' },
        'Failed to shut down server',
      )
      expect(process.exitCode).toBe(1)
    } finally {
      process.exitCode = originalExitCode
    }
  })
})
