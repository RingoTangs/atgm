import process from 'node:process'
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

const hostPortEnvSchema = z.object({
  HOST: z.string().trim().min(1, 'must not be empty').default('0.0.0.0'),
  PORT: portSchema(8080),
})

const mysqlEnvSchema = z.object({
  MYSQL_HOST: z.string().trim().min(1, 'must not be empty'),
  MYSQL_PORT: portSchema(3306),
  MYSQL_USER: z.string().trim().min(1, 'must not be empty'),
  MYSQL_PASSWORD: z.string().min(1, 'must not be empty'),
  MYSQL_DL_ADB_ALL: z
    .string()
    .trim()
    .min(1, 'must not be empty')
    .regex(/^\w+$/, 'must contain only letters, numbers, and underscores')
    .default('dl_adb_all'),
  MYSQL_DL_DDB_1: z
    .string()
    .trim()
    .min(1, 'must not be empty')
    .regex(/^\w+$/, 'must contain only letters, numbers, and underscores')
    .default('dl_ddb_1'),
})

const serverEnvSchema = z.object({
  ...hostPortEnvSchema.shape,
  ...mysqlEnvSchema.shape,
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

export const isDevelopment = (): boolean =>
  process.env.NODE_ENV === 'development'

export const isProduction = (): boolean => process.env.NODE_ENV === 'production'
