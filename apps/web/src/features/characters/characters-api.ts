import type {
  CharacterDetailResponse,
  CharactersQuery,
  CharactersResponse,
} from '@atgm/contracts'
import { checkApiResponse } from '@/lib/apiError'

export async function getCharacters(
  params: CharactersQuery,
): Promise<CharactersResponse> {
  const searchParams = new URLSearchParams({
    page: String(params.page),
    pageSize: String(params.pageSize),
  })
  const response = await fetch(`/_api/characters?${searchParams}`)
  await checkApiResponse(response, '角色列表请求失败')
  return (await response.json()) as CharactersResponse
}

export async function getCharacter(
  gid: string,
): Promise<CharacterDetailResponse> {
  const response = await fetch(`/_api/characters/${encodeURIComponent(gid)}`)
  await checkApiResponse(response, '角色详情请求失败')
  return response.json()
}
