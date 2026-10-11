import type { ServersQuery, ServersResponse } from '@atgm/contracts'
import { API_PREFIX } from '@/lib/apiConfig'
import { checkApiResponse } from '@/lib/apiError'

export async function getServers(
  params: ServersQuery,
): Promise<ServersResponse> {
  const searchParams = new URLSearchParams({
    page: String(params.page),
    pageSize: String(params.pageSize),
  })
  const response = await fetch(`${API_PREFIX}/servers?${searchParams}`)
  await checkApiResponse(response, '服务器列表请求失败')
  return (await response.json()) as ServersResponse
}
