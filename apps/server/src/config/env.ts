import { z } from 'zod'

const portSchema = (defaultPort: number) =>
  z
    .string()
    .regex(/^\d+$/, 'must contain only decimal digits')
    .transform(Number)
    .pipe(
      z
        .number()
        .int('must be an integer')
        .min(1, 'must be at least 1')
        .max(65535, 'must be at most 65535'),
    )
    .default(defaultPort)

const serverEnvSchema = z.object({
  HOST: z.string().trim().min(1, 'must not be empty').default('0.0.0.0'),
  PORT: portSchema(8080),
  MYSQL_HOST: z.string().trim().min(1, 'must not be empty'),
  MYSQL_PORT: portSchema(3306),
  MYSQL_USER: z.string().trim().min(1, 'must not be empty'),
  MYSQL_PASSWORD: z.string().min(1, 'must not be empty'),
  MYSQL_ACCOUNT_DB: z
    .string()
    .trim()
    .min(1, 'must not be empty')
    .regex(/^\w+$/, 'must contain only letters, numbers, and underscores'),
  MYSQL_GAME_DB: z
    .string()
    .trim()
    .min(1, 'must not be empty')
    .regex(/^\w+$/, 'must contain only letters, numbers, and underscores'),
})

export type ServerEnv = z.infer<typeof serverEnvSchema>

export function parseServerEnv(input: NodeJS.ProcessEnv): ServerEnv {
  const result = serverEnvSchema.safeParse(input)

  if (!result.success) {
    throw new Error(
      `Invalid server environment:\n${z.prettifyError(result.error)}`,
    )
  }

  return result.data
}
