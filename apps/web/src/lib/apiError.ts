import type { ErrorResponse } from '@atgm/contracts'
import { errorSchema } from '@atgm/contracts'

export class ApiError extends Error {
  readonly code: string
  readonly status: number

  constructor(body: ErrorResponse, status: number) {
    super(body.message)
    this.name = 'ApiError'
    this.code = body.code
    this.status = status
  }
}

export async function checkApiResponse(
  response: Response,
  fallbackMessage: string,
): Promise<void> {
  if (response.ok) return

  const body: unknown = await response.json().catch(() => undefined)
  const result = errorSchema.safeParse(body)

  if (result.success) {
    throw new ApiError(result.data, response.status)
  }

  throw new Error(fallbackMessage)
}
