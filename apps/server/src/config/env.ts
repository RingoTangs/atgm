import { z } from 'zod'

const serverEnvSchema = z.object({
  HOST: z.string().trim().min(1, 'must not be empty').default('0.0.0.0'),
  PORT: z
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
    .default(8080),
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
