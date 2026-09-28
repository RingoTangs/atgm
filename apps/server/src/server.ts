import process from 'node:process'
import { buildApp } from './app'
import { parseServerEnv } from './config/env'

interface ShutdownHandlerOptions {
  closeApp?: () => Promise<unknown>
  onShutdownStart?: () => void
}

interface StartServerOptions {
  app?: ReturnType<typeof buildApp>
  env?: NodeJS.ProcessEnv
}

export const createShutdownHandler = (
  app: ReturnType<typeof buildApp>,
  options: ShutdownHandlerOptions = {},
) => {
  let isShuttingDown = false
  const closeApp = options.closeApp ?? (() => app.close())

  return async (signal: NodeJS.Signals): Promise<void> => {
    if (isShuttingDown) {
      return
    }

    isShuttingDown = true
    options.onShutdownStart?.()
    app.log.info({ signal }, 'Shutting down server')

    try {
      await closeApp()
    } catch (error) {
      app.log.error({ err: error, signal }, 'Failed to shut down server')
      process.exitCode = 1
    }
  }
}

export const startServer = async (
  options: StartServerOptions = {},
): Promise<void> => {
  const app = options.app ?? buildApp()
  const env = options.env ?? process.env
  let closePromise: Promise<unknown> | undefined
  let listenersRegistered = false
  let shutdownStarted = false
  let shutdown: ReturnType<typeof createShutdownHandler>

  const closeApp = (): Promise<unknown> => {
    closePromise ??= app.close()
    return closePromise
  }

  const removeSignalListeners = (): void => {
    if (!listenersRegistered) {
      return
    }

    process.off('SIGINT', shutdown)
    process.off('SIGTERM', shutdown)
    listenersRegistered = false
  }

  shutdown = createShutdownHandler(app, {
    closeApp,
    onShutdownStart: () => {
      shutdownStarted = true
      removeSignalListeners()
    },
  })

  try {
    const { HOST, PORT } = parseServerEnv(env)

    process.once('SIGINT', shutdown)
    process.once('SIGTERM', shutdown)
    listenersRegistered = true

    await app.listen({ host: HOST, port: PORT })
  } catch (error) {
    removeSignalListeners()

    if (shutdownStarted) {
      try {
        await closeApp()
      } catch {
        // The shutdown handler logs close failures and sets the exit code.
      }
      return
    }

    app.log.error({ err: error }, 'Failed to start server')
    process.exitCode = 1

    try {
      await closeApp()
    } catch (closeError) {
      app.log.error(
        { err: closeError },
        'Failed to close server after startup failure',
      )
    }
  }
}

if (import.meta.main) {
  void startServer().catch((error: unknown) => {
    const message =
      error instanceof Error ? (error.stack ?? error.message) : String(error)

    process.stderr.write(`${message}\n`)
    process.exitCode = 1
  })
}
