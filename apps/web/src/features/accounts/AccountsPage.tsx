import type { AccountListItem, Privilege } from '@atgm/contracts'
import type { TableProps } from 'antd'
import { keepPreviousData, useQuery } from '@tanstack/react-query'
import { Alert, Button, Input, Table, Tooltip } from 'antd'
import { useMemo, useState } from 'react'
import { AccountRegisterModal } from './AccountRegisterModal'
import { getAccounts, getPrivileges } from './accounts-api'

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
  const privilegesQuery = useQuery({
    queryKey: ['privileges'],
    queryFn: getPrivileges,
    staleTime: Infinity,
  })
  const privilegeMap = useMemo(
    () =>
      new Map<number, Privilege>(
        (privilegesQuery.data ?? []).map((privilege) => [
          privilege.privilege,
          privilege,
        ]),
      ),
    [privilegesQuery.data],
  )
  const columns = useMemo<TableProps<AccountListItem>['columns']>(
    () => [
      {
        title: '账号',
        dataIndex: 'account',
        key: 'account',
      },
      {
        title: '权限',
        dataIndex: 'privilege',
        key: 'privilege',
        render: (value: number) => {
          const privilege = privilegeMap.get(value)

          if (!privilege) {
            return (
              <div className="whitespace-nowrap">
                <div>{value}</div>
                <div className="text-muted-foreground text-xs">未知权限</div>
              </div>
            )
          }

          return (
            <Tooltip
              title={
                <ul>
                  <li>常量：{privilege.constant}</li>
                  <li>类型：{privilege.type}</li>
                  <li>描述：{privilege.description}</li>
                </ul>
              }
            >
              <div className="whitespace-nowrap">
                {value} - {privilege.grant}
              </div>
            </Tooltip>
          )
        },
      },
      {
        title: '金币',
        dataIndex: 'goldCoin',
        key: 'goldCoin',
        align: 'right',
        render: (value: number) => value.toLocaleString(),
      },
      {
        title: '银币',
        dataIndex: 'silverCoin',
        key: 'silverCoin',
        align: 'right',
        render: (value: number) => value.toLocaleString(),
      },
      {
        title: '最后登录',
        dataIndex: 'lastLoginTime',
        key: 'lastLoginTime',
        className: 'whitespace-nowrap',
        render: (value: string) => value || '-',
      },
      {
        title: '最后登录 IP',
        dataIndex: 'lastLoginIp',
        key: 'lastLoginIp',
        className: 'whitespace-nowrap',
        render: (value: string) => value || '-',
      },
      {
        title: '注册时间',
        dataIndex: 'regDate',
        key: 'regDate',
        className: 'whitespace-nowrap',
        render: (value: string) => value || '-',
      },
    ],
    [privilegeMap],
  )

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
