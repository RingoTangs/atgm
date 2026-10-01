import type {
  AccountsQuery,
  AccountsResponse,
  PrivilegesResponse,
  RegisterAccountRequest,
} from '@atgm/contracts'

const API_PREFIX = '/_api'

export class AccountConflictError extends Error {
  constructor() {
    super('账号已存在')
    this.name = 'AccountConflictError'
  }
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

  if (!response.ok) {
    throw new Error('账号列表请求失败')
  }

  return (await response.json()) as AccountsResponse
}

export async function getPrivileges(): Promise<PrivilegesResponse> {
  const response = await fetch(`${API_PREFIX}/privileges`)

  if (!response.ok) {
    throw new Error('权限列表请求失败')
  }

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

  if (response.status === 409) {
    throw new AccountConflictError()
  }

  if (!response.ok) {
    throw new Error('账号注册请求失败')
  }
}
