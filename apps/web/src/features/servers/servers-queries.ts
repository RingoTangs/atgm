import type { ServersQuery } from '@atgm/contracts'
import { keepPreviousData, queryOptions } from '@tanstack/react-query'
import { getServers } from './servers-api'

export const serverQueryKeys = {
  all: ['servers'] as const,
  list: (params: ServersQuery) =>
    [...serverQueryKeys.all, 'list', params] as const,
}

export const serversQueryOptions = (params: ServersQuery) =>
  queryOptions({
    queryKey: serverQueryKeys.list(params),
    queryFn: () => getServers(params),
    placeholderData: keepPreviousData,
  })
