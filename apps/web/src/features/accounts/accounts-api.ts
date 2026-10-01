export interface GetAccountsParams {
  page: number
  pageSize: number
  account?: string
}

const API_PREFIX = '/_api'

interface AccountApiItem {
  account: string
  privilege: number
  gold_coin: number
  silver_coin: number
  last_login_time: string
  last_login_ip: string
  reg_date: string
}

interface AccountsApiResponse {
  page: number
  pageSize: number
  total: number
  items: AccountApiItem[]
}

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

export interface RegisterAccountValues {
  account: string
  rawPassword: string
  goldCoin: number
  silverCoin: number
  privilege: number
}

export class AccountConflictError extends Error {
  constructor() {
    super('账号已存在')
    this.name = 'AccountConflictError'
  }
}

const toAccountListItem = (item: AccountApiItem): AccountListItem => ({
  account: item.account,
  privilege: item.privilege,
  goldCoin: item.gold_coin,
  silverCoin: item.silver_coin,
  lastLoginTime: item.last_login_time,
  lastLoginIp: item.last_login_ip,
  regDate: item.reg_date,
})

export async function getAccounts(
  params: GetAccountsParams,
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

  const data = (await response.json()) as AccountsApiResponse

  return {
    page: data.page,
    pageSize: data.pageSize,
    total: data.total,
    items: data.items.map(toAccountListItem),
  }
}

export async function registerAccount(
  values: RegisterAccountValues,
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
