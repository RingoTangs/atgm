import type { CharactersQuery } from '@atgm/contracts'
import { keepPreviousData, queryOptions } from '@tanstack/react-query'
import {
  getCharacter,
  getCharacterItem,
  getCharacterItems,
  getCharacters,
} from './characters-api'

export const characterQueryKeys = {
  all: ['characters'] as const,
  itemDetail: (gid: string, entryKey: number) =>
    [...characterQueryKeys.all, 'itemDetail', gid, entryKey] as const,
  items: (gid: string) => [...characterQueryKeys.all, 'items', gid] as const,
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

export const characterItemsQueryOptions = (gid: string) =>
  queryOptions({
    queryKey: characterQueryKeys.items(gid),
    queryFn: () => getCharacterItems(gid),
  })

export const characterItemDetailQueryOptions = (
  gid: string,
  entryKey: number,
) =>
  queryOptions({
    queryKey: characterQueryKeys.itemDetail(gid, entryKey),
    queryFn: () => getCharacterItem(gid, entryKey),
  })
