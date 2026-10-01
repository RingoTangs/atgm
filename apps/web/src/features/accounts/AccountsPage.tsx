import type { TableProps } from 'antd'
import type { RegisterAccountValues } from './AccountRegisterModal'
import { Button, Card, Input, message, Table } from 'antd'
import { useMemo, useState } from 'react'
import { AccountRegisterModal } from './AccountRegisterModal'

interface AccountListItem {
  account: string
  lastLoginTime: string
}

const initialAccounts: AccountListItem[] = Array.from(
  { length: 30 },
  (_, index) => {
    const accountNumber = index + 1

    return {
      account: `test${String(accountNumber).padStart(2, '0')}`,
      lastLoginTime:
        accountNumber % 6 === 0
          ? ''
          : `2026-10-01 18:${String(60 - accountNumber).padStart(2, '0')}`,
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
    title: '最后登录',
    dataIndex: 'lastLoginTime',
    key: 'lastLoginTime',
    render: (value: string) => value || '-',
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
      { account: values.account, lastLoginTime: '' },
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
