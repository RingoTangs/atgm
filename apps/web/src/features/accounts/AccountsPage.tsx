import type { TableProps } from 'antd'
import type { RegisterAccountValues } from './AccountRegisterModal'
import { Button, Card, Input, message, Table } from 'antd'
import { useMemo, useState } from 'react'
import { formatGameDateTime } from '@/lib/date'
import { AccountRegisterModal } from './AccountRegisterModal'

interface AccountListItem {
  account: string
  privilege: number
  goldCoin: number
  silverCoin: number
  lastLoginTime: string
  lastLoginIp: string
  regDate: string
}

const initialAccounts: AccountListItem[] = Array.from(
  { length: 30 },
  (_, index) => {
    const accountNumber = index + 1

    return {
      account: `test${String(accountNumber).padStart(2, '0')}`,
      privilege: accountNumber % 10 === 0 ? 100 : 0,
      goldCoin: accountNumber * 100_000,
      silverCoin: accountNumber * 50_000,
      lastLoginTime:
        accountNumber % 6 === 0
          ? ''
          : accountNumber === 1
            ? '20261001191200'
            : `202609${String(accountNumber).padStart(2, '0')}120000`,
      lastLoginIp: accountNumber % 6 === 0 ? '' : `192.0.2.${accountNumber}`,
      regDate:
        accountNumber % 6 === 0
          ? ''
          : `202608${String(accountNumber).padStart(2, '0')}100000`,
    }
  },
)

const columns: TableProps<AccountListItem>['columns'] = [
  {
    title: '账号',
    dataIndex: 'account',
    key: 'account',
  },
  {
    title: '权限',
    dataIndex: 'privilege',
    key: 'privilege',
  },
  {
    title: '金币',
    dataIndex: 'goldCoin',
    key: 'goldCoin',
    render: (value: number) => value.toLocaleString(),
  },
  {
    title: '银币',
    dataIndex: 'silverCoin',
    key: 'silverCoin',
    render: (value: number) => value.toLocaleString(),
  },
  {
    title: '最后登录',
    dataIndex: 'lastLoginTime',
    key: 'lastLoginTime',
    render: formatGameDateTime,
  },
  {
    title: '最后登录 IP',
    dataIndex: 'lastLoginIp',
    key: 'lastLoginIp',
    render: (value: string) => value || '-',
  },
  {
    title: '注册时间',
    dataIndex: 'regDate',
    key: 'regDate',
    render: formatGameDateTime,
  },
]

export const AccountsPage: React.FC = () => {
  const [accounts, setAccounts] = useState(initialAccounts)
  const [keyword, setKeyword] = useState('')
  const [page, setPage] = useState(1)
  const [pageSize, setPageSize] = useState(20)
  const [registerOpen, setRegisterOpen] = useState(false)
  const [messageApi, messageContext] = message.useMessage()

  const filteredAccounts = useMemo(() => {
    const normalizedKeyword = keyword.trim().toLowerCase()

    if (!normalizedKeyword) return accounts

    return accounts.filter((account) =>
      account.account.toLowerCase().includes(normalizedKeyword),
    )
  }, [accounts, keyword])

  const handleRegister = (values: RegisterAccountValues) => {
    setAccounts((current) => [
      {
        account: values.account,
        privilege: values.privilege,
        goldCoin: values.goldCoin,
        silverCoin: values.silverCoin,
        lastLoginTime: '',
        lastLoginIp: '',
        regDate: '',
      },
      ...current,
    ])
    setPage(1)
    setRegisterOpen(false)
    void messageApi.success('账号注册成功')
  }

  return (
    <>
      {messageContext}
      <div className="space-y-6">
        <div>
          <h1 className="text-2xl font-semibold">账号管理</h1>
          <p className="text-muted-foreground mt-1">查询和创建游戏账号</p>
        </div>

        <Card>
          <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
            <Input.Search
              allowClear
              className="w-full sm:max-w-md"
              onChange={(event) => {
                setKeyword(event.target.value)
                setPage(1)
              }}
              placeholder="搜索账号"
              value={keyword}
            />
            <Button
              className="w-full sm:w-auto"
              onClick={() => setRegisterOpen(true)}
              type="primary"
            >
              注册账号
            </Button>
          </div>

          <Table<AccountListItem>
            className="mt-4"
            columns={columns}
            dataSource={filteredAccounts}
            locale={{ emptyText: '暂无匹配账号' }}
            pagination={{
              current: page,
              onChange: (nextPage, nextPageSize) => {
                const lastPage = Math.max(
                  1,
                  Math.ceil(filteredAccounts.length / nextPageSize),
                )
                setPage(Math.min(nextPage, lastPage))
                setPageSize(nextPageSize)
              },
              pageSize,
              pageSizeOptions: [10, 20, 50, 100],
              showSizeChanger: true,
              total: filteredAccounts.length,
            }}
            rowKey="account"
            scroll={{ x: 'max-content' }}
          />
        </Card>
      </div>

      <AccountRegisterModal
        existingAccounts={accounts.map((account) => account.account)}
        onCancel={() => setRegisterOpen(false)}
        onRegister={handleRegister}
        open={registerOpen}
      />
    </>
  )
}
