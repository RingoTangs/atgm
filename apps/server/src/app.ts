import process from 'node:process'
import Fastify from 'fastify'

const fastify = Fastify({
  logger: true,
})

fastify.get('/', (_, reply) => {
  reply.send({ hello: 'world' })
})

fastify.listen({ port: 8080 }, (err) => {
  if (err) {
    fastify.log.error(err)
    process.exit(1)
  }
})
