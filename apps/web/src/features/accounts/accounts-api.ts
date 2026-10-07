import type {
  AccountDetailResponse,
  AccountsQuery,
  AccountsResponse,
  PrivilegesResponse,
  RegisterAccountRequest,
  UpdateAccountRequest,
  UpdateAccountResponse,
} from '@atgm/contracts'
import { checkApiResponse } from '@/lib/apiError'

const API_PREFIX = '/_api'

export async function updateAccount(
  account: string,
  values: UpdateAccountRequest,
): Promise<UpdateAccountResponse> {
  const response = await fetch(
    `${API_PREFIX}/accounts/${encodeURIComponent(account)}`,
    {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(values),
    },
  )

  await checkApiResponse(response, '账号修改请求失败')

  return (await response.json()) as UpdateAccountResponse
}

export async function getAccount(
  account: string,
): Promise<AccountDetailResponse> {
  const response = await fetch(
    `${API_PREFIX}/accounts/${encodeURIComponent(account)}`,
  )

  await checkApiResponse(response, '账号详情请求失败')

  return (await response.json()) as AccountDetailResponse
}

export async function getAccounts(
  params: AccountsQuery,
): Promise<AccountsResponse> {
  const searchParams = new URLSearchParams({
    page: String(params.page),
    pageSize: String(params.pageSize),
  })

  if (params.account) {
    searchParams.set('account', params.account)
  }

  const response = await fetch(`${API_PREFIX}/accounts?${searchParams}`)

  await checkApiResponse(response, '账号列表请求失败')

  return (await response.json()) as AccountsResponse
}

export async function getPrivileges(): Promise<PrivilegesResponse> {
  const response = await fetch(`${API_PREFIX}/privileges`)

  await checkApiResponse(response, '权限列表请求失败')

  return (await response.json()) as PrivilegesResponse
}

export async function registerAccount(
  values: RegisterAccountRequest,
): Promise<void> {
  const response = await fetch(`${API_PREFIX}/account`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(values),
  })

  await checkApiResponse(response, '账号注册请求失败')
}
