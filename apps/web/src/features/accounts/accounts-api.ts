import type {
  AccountDetailResponse,
  AccountsQuery,
  AccountsResponse,
  PrivilegesResponse,
  RegisterAccountRequest,
  UpdateAccountRequest,
  UpdateAccountResponse,
} from '@atgm/contracts'

const API_PREFIX = '/_api'

export class AccountConflictError extends Error {
  constructor() {
    super('账号已存在')
    this.name = 'AccountConflictError'
  }
}

export class AccountNotFoundError extends Error {
  constructor() {
    super('账号不存在')
    this.name = 'AccountNotFoundError'
  }
}

export class AccountUpdateConflictError extends Error {
  constructor() {
    super('账号数据已发生变化，请刷新后重试')
    this.name = 'AccountUpdateConflictError'
  }
}

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

  if (response.status === 404) {
    throw new AccountNotFoundError()
  }

  if (response.status === 409) {
    throw new AccountUpdateConflictError()
  }

  if (!response.ok) {
    throw new Error('账号修改请求失败')
  }

  return (await response.json()) as UpdateAccountResponse
}

export async function getAccount(
  account: string,
): Promise<AccountDetailResponse> {
  const response = await fetch(
    `${API_PREFIX}/accounts/${encodeURIComponent(account)}`,
  )

  if (response.status === 404) {
    throw new AccountNotFoundError()
  }

  if (!response.ok) {
    throw new Error('账号详情请求失败')
  }

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
