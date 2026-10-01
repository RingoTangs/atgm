import type {
  AccountListItemDto,
  AccountsQuery,
  AccountsResponse,
  RegisterAccountRequest,
} from '@atgm/contracts'

const API_PREFIX = '/_api'

export interface AccountListItem {
  account: string
  privilege: number
  goldCoin: number
  silverCoin: number
  lastLoginTime: string
  lastLoginIp: string
  regDate: string
}

export interface AccountsResult {
  page: number
  pageSize: number
  total: number
  items: AccountListItem[]
}

export class AccountConflictError extends Error {
  constructor() {
    super('账号已存在')
    this.name = 'AccountConflictError'
  }
}

const toAccountListItem = (item: AccountListItemDto): AccountListItem => ({
  account: item.account,
  privilege: item.privilege,
  goldCoin: item.gold_coin,
  silverCoin: item.silver_coin,
  lastLoginTime: item.last_login_time,
  lastLoginIp: item.last_login_ip,
  regDate: item.reg_date,
})

export async function getAccounts(
  params: AccountsQuery,
): Promise<AccountsResult> {
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

  const data = (await response.json()) as AccountsResponse

  return {
    page: data.page,
    pageSize: data.pageSize,
    total: data.total,
    items: data.items.map(toAccountListItem),
  }
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
