import process from 'node:process'
import { buildApp } from './app'

const app = buildApp()

app.listen({ port: 8080 }, (error) => {
  if (error) {
    app.log.error(error)
    process.exit(1)
  }
})
