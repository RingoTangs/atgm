import type { CharactersQuery } from '@atgm/contracts'
import { keepPreviousData, queryOptions } from '@tanstack/react-query'
import { getCharacter, getCharacters } from './characters-api'

export const characterQueryKeys = {
  all: ['characters'] as const,
  detail: (gid: string) => [...characterQueryKeys.all, 'detail', gid] as const,
  list: (params: CharactersQuery) =>
    [...characterQueryKeys.all, 'list', params] as const,
}

export const charactersQueryOptions = (params: CharactersQuery) =>
  queryOptions({
    queryKey: characterQueryKeys.list(params),
    queryFn: () => getCharacters(params),
    placeholderData: keepPreviousData,
  })

export const characterDetailQueryOptions = (gid: string) =>
  queryOptions({
    queryKey: characterQueryKeys.detail(gid),
    queryFn: () => getCharacter(gid),
  })
