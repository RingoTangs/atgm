import type {
  CharacterDetailResponse,
  CharacterItemsResponse,
  CharactersQuery,
  CharactersResponse,
} from '@atgm/contracts'
import { API_PREFIX } from '@/lib/apiConfig'
import { checkApiResponse } from '@/lib/apiError'

export async function getCharacters(
  params: CharactersQuery,
): Promise<CharactersResponse> {
  const searchParams = new URLSearchParams({
    page: String(params.page),
    pageSize: String(params.pageSize),
  })
  const response = await fetch(`${API_PREFIX}/characters?${searchParams}`)
  await checkApiResponse(response, '角色列表请求失败')
  return (await response.json()) as CharactersResponse
}

export async function getCharacter(
  gid: string,
): Promise<CharacterDetailResponse> {
  const response = await fetch(
    `${API_PREFIX}/characters/${encodeURIComponent(gid)}`,
  )
  await checkApiResponse(response, '角色详情请求失败')
  return response.json()
}

export async function getCharacterItems(
  gid: string,
): Promise<CharacterItemsResponse> {
  const response = await fetch(
    `${API_PREFIX}/characters/${encodeURIComponent(gid)}/items`,
  )
  await checkApiResponse(response, '物品信息请求失败')
  return response.json()
}
