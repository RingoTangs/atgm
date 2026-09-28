import process from 'node:process'
import { buildApp } from './app'
import { parseServerEnv } from './config/env'

const main = async (): Promise<void> => {
  const app = buildApp()
  let shuttingDown = false

  const shutdown = async (): Promise<void> => {
    if (shuttingDown) {
      return
    }

    shuttingDown = true

    try {
      await app.close()
    } catch (error) {
      app.log.error(error)
      process.exitCode = 1
    }
  }

  try {
    const { HOST, PORT } = parseServerEnv(process.env)

    await app.listen({ host: HOST, port: PORT })
    process.on('SIGINT', shutdown)
    process.on('SIGTERM', shutdown)
  } catch (error) {
    app.log.error(error)
    process.exitCode = 1

    try {
      await app.close()
    } catch (closeError) {
      app.log.error(closeError)
    }
  }
}

if (import.meta.main) {
  void main().catch((error: unknown) => {
    const message =
      error instanceof Error ? (error.stack ?? error.message) : String(error)

    process.stderr.write(`${message}\n`)
    process.exitCode = 1
  })
}
