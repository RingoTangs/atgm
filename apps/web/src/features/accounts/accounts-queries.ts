import type { AccountsQuery } from '@atgm/contracts'
import { keepPreviousData, queryOptions } from '@tanstack/react-query'
import { getAccount, getAccounts, getPrivileges } from './accounts-api'

export const accountQueryKeys = {
  all: ['accounts'] as const,
  list: (params: AccountsQuery) =>
    [...accountQueryKeys.all, 'list', params] as const,
  detail: (account: string) => ['account', account] as const,
  privileges: ['privileges'] as const,
}

export const accountsQueryOptions = (params: AccountsQuery) =>
  queryOptions({
    queryKey: accountQueryKeys.list(params),
    queryFn: () => getAccounts(params),
    placeholderData: keepPreviousData,
  })

export const accountDetailQueryOptions = (account: string) =>
  queryOptions({
    queryKey: accountQueryKeys.detail(account),
    queryFn: () => getAccount(account),
  })

export const privilegesQueryOptions = () =>
  queryOptions({
    queryKey: accountQueryKeys.privileges,
    queryFn: getPrivileges,
    staleTime: Infinity,
  })
