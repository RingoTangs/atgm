import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { ApiError } from '@/lib/apiError'
import { getServers } from './servers-api'

const fetchMock = vi.fn<typeof fetch>()
beforeEach(() => {
  fetchMock.mockReset()
  vi.stubGlobal('fetch', fetchMock)
})
afterEach(() => vi.unstubAllGlobals())

describe('servers API', () => {
  it('encodes pagination and returns the response', async () => {
    const body = { page: 3, pageSize: 20, total: 0, items: [] }
    fetchMock.mockResolvedValue(new Response(JSON.stringify(body)))
    expect(await getServers({ page: 3, pageSize: 20 })).toEqual(body)
    expect(fetchMock).toHaveBeenCalledWith('/_api/servers?page=3&pageSize=20')
  })

  it('preserves shared API errors', async () => {
    fetchMock.mockResolvedValue(
      new Response(
        JSON.stringify({
          code: 'INTERNAL_SERVER_ERROR',
          message: 'Internal Server Error',
        }),
        { status: 500 },
      ),
    )
    const result = getServers({ page: 1, pageSize: 10 })
    await expect(result).rejects.toBeInstanceOf(ApiError)
    await expect(result).rejects.toMatchObject({
      code: 'INTERNAL_SERVER_ERROR',
      status: 500,
    })
  })

  it('uses the list error message for non-JSON errors', async () => {
    fetchMock.mockResolvedValue(new Response('failed', { status: 500 }))
    await expect(getServers({ page: 1, pageSize: 10 })).rejects.toThrow(
      '服务器列表请求失败',
    )
  })
})
