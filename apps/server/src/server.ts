import process from 'node:process'
import { buildApp } from './app'

const DEFAULT_PORT = 8080

export const parsePort = (value: string | undefined): number => {
  const port = value === undefined ? DEFAULT_PORT : Number(value)

  if (!Number.isInteger(port) || port < 1 || port > 65535) {
    throw new Error(
      `Invalid PORT "${value ?? ''}": expected an integer between 1 and 65535`,
    )
  }

  return port
}

export const createShutdownHandler = (app: ReturnType<typeof buildApp>) => {
  let isShuttingDown = false

  return async (signal: NodeJS.Signals): Promise<void> => {
    if (isShuttingDown) {
      return
    }

    isShuttingDown = true
    app.log.info({ signal }, 'Shutting down server')

    try {
      await app.close()
    } catch (error) {
      app.log.error({ err: error, signal }, 'Failed to shut down server')
      process.exitCode = 1
    }
  }
}

export const startServer = async (): Promise<void> => {
  const app = buildApp()

  try {
    const port = parsePort(process.env.PORT)
    const host = process.env.HOST ?? '0.0.0.0'
    const shutdown = createShutdownHandler(app)

    process.once('SIGINT', shutdown)
    process.once('SIGTERM', shutdown)

    await app.listen({ port, host })
  } catch (error) {
    app.log.error(error)
    process.exitCode = 1
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
