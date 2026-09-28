import process from 'node:process'
import { describe, expect, it, vi } from 'vitest'
import { buildApp } from './app'
import { createShutdownHandler, startServer } from './server'

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

describe('startServer', () => {
  it('closes the app when environment validation fails', async () => {
    const originalExitCode = process.exitCode
    const app = buildApp()
    const listen = vi.spyOn(app, 'listen')
    const close = vi.spyOn(app, 'close').mockResolvedValue(undefined)
    const logError = vi.spyOn(app.log, 'error').mockImplementation(() => {})

    try {
      await startServer({ app, env: { PORT: 'invalid' } })

      expect(listen).not.toHaveBeenCalled()
      expect(close).toHaveBeenCalledOnce()
      expect(logError).toHaveBeenCalledWith(
        { err: expect.any(Error) },
        'Failed to start server',
      )
      expect(process.exitCode).toBe(1)
    } finally {
      process.exitCode = originalExitCode
    }
  })

  it('cleans resources and signal listeners when listen fails', async () => {
    const originalExitCode = process.exitCode
    const sigintListeners = process.listenerCount('SIGINT')
    const sigtermListeners = process.listenerCount('SIGTERM')
    const app = buildApp()
    const error = new Error('listen failed')
    vi.spyOn(app, 'listen').mockRejectedValue(error)
    const close = vi.spyOn(app, 'close').mockResolvedValue(undefined)
    const logError = vi.spyOn(app.log, 'error').mockImplementation(() => {})

    try {
      await startServer({ app, env: {} })

      expect(close).toHaveBeenCalledOnce()
      expect(logError).toHaveBeenCalledWith(
        { err: error },
        'Failed to start server',
      )
      expect(process.listenerCount('SIGINT')).toBe(sigintListeners)
      expect(process.listenerCount('SIGTERM')).toBe(sigtermListeners)
      expect(process.exitCode).toBe(1)
    } finally {
      process.exitCode = originalExitCode
    }
  })

  it('logs cleanup failures without replacing the startup error', async () => {
    const originalExitCode = process.exitCode
    const app = buildApp()
    const startupError = new Error('listen failed')
    const closeError = new Error('close failed')
    vi.spyOn(app, 'listen').mockRejectedValue(startupError)
    const close = vi.spyOn(app, 'close').mockRejectedValue(closeError)
    const logError = vi.spyOn(app.log, 'error').mockImplementation(() => {})

    try {
      await startServer({ app, env: {} })

      expect(close).toHaveBeenCalledOnce()
      expect(logError).toHaveBeenNthCalledWith(
        1,
        { err: startupError },
        'Failed to start server',
      )
      expect(logError).toHaveBeenNthCalledWith(
        2,
        { err: closeError },
        'Failed to close server after startup failure',
      )
      expect(process.exitCode).toBe(1)
    } finally {
      process.exitCode = originalExitCode
    }
  })
})
