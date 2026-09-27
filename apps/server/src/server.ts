import process from 'node:process'
import { buildApp } from './app'

const port = Number(process.env.PORT ?? 8080)
const host = process.env.HOST ?? '0.0.0.0'

const app = buildApp()

app.listen({ port, host }, (error) => {
  if (error) {
    app.log.error(error)
    process.exit(1)
  }
})
