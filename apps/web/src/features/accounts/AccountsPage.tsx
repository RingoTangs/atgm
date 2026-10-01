import type { AccountListItem } from '@atgm/contracts'
import type { TableProps } from 'antd'
import { keepPreviousData, useQuery } from '@tanstack/react-query'
import { Alert, Button, Input, Table } from 'antd'
import { useState } from 'react'
import { AccountRegisterModal } from './AccountRegisterModal'
import { getAccounts } from './accounts-api'

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
  },
]

export const AccountsPage: React.FC = () => {
  const [page, setPage] = useState(1)
  const [pageSize, setPageSize] = useState(20)
  const [searchText, setSearchText] = useState('')
  const [account, setAccount] = useState('')
  const [registerOpen, setRegisterOpen] = useState(false)
  const accountsQuery = useQuery({
    queryKey: ['accounts', { page, pageSize, account }],
    queryFn: () =>
      getAccounts({
        page,
        pageSize,
        account: account || undefined,
      }),
    placeholderData: keepPreviousData,
  })

  const submitSearch = (value: string) => {
    setSearchText(value)
    setAccount(value.trim())
    setPage(1)
  }

  return (
    <>
      <div className="space-y-6">
        <div>
          <h1 className="text-2xl font-semibold">账号管理</h1>
          <p className="text-muted-foreground mt-1">查询和创建游戏账号</p>
        </div>

        <div>
          <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
            <Input.Search
              allowClear
              className="w-full sm:max-w-md"
              onChange={(event) => {
                const value = event.target.value

                setSearchText(value)

                if (!value) {
                  setAccount('')
                  setPage(1)
                }
              }}
              onSearch={submitSearch}
              placeholder="搜索账号"
              value={searchText}
            />
            <Button
              className="w-full sm:w-auto"
              onClick={() => setRegisterOpen(true)}
              type="primary"
            >
              注册账号
            </Button>
          </div>

          {accountsQuery.isError && (
            <Alert
              action={
                <Button
                  aria-label="重试"
                  onClick={() => void accountsQuery.refetch()}
                >
                  重试
                </Button>
              }
              className="mt-4"
              showIcon
              title="账号列表加载失败"
              type="error"
            />
          )}

          <Table<AccountListItem>
            className="mt-4"
            columns={columns}
            dataSource={accountsQuery.data?.items ?? []}
            loading={accountsQuery.isPending || accountsQuery.isFetching}
            locale={{ emptyText: '暂无匹配账号' }}
            pagination={{
              current: page,
              onChange: (nextPage, nextPageSize) => {
                if (nextPageSize !== pageSize) {
                  setPage(1)
                  setPageSize(nextPageSize)
                  return
                }

                setPage(nextPage)
                setPageSize(nextPageSize)
              },
              pageSize,
              pageSizeOptions: [10, 20, 50, 100],
              showSizeChanger: true,
              total: accountsQuery.data?.total ?? 0,
            }}
            rowKey="account"
            scroll={{ x: 'max-content' }}
          />
        </div>
      </div>

      <AccountRegisterModal
        onCancel={() => setRegisterOpen(false)}
        open={registerOpen}
      />
    </>
  )
}
