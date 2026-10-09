import type { CharacterWithAccount } from '@atgm/contracts'
import type { TableProps } from 'antd'
import {
  CHARACTER_GENDER_LABELS,
  CHARACTER_POLAR_LABELS,
  DEFAULT_PAGE,
  DEFAULT_PAGE_SIZE,
} from '@atgm/contracts'
import { useQuery } from '@tanstack/react-query'
import { Link } from '@tanstack/react-router'
import { Alert, Button, Table } from 'antd'
import { ExternalLink } from 'lucide-react'
import { useState } from 'react'
import { charactersQueryOptions } from './characters-queries'

const columns: TableProps<CharacterWithAccount>['columns'] = [
  { title: 'GID', dataIndex: 'gid', key: 'gid', align: 'center' },
  { title: '角色名', dataIndex: 'name', key: 'name', align: 'center' },
  {
    title: '相性',
    dataIndex: 'polar',
    key: 'polar',
    align: 'center',
    render: (value: number) =>
      CHARACTER_POLAR_LABELS[value as keyof typeof CHARACTER_POLAR_LABELS] ??
      `未知(${value})`,
  },
  {
    title: '性别',
    dataIndex: 'gender',
    key: 'gender',
    align: 'center',
    render: (value: number) =>
      CHARACTER_GENDER_LABELS[value as keyof typeof CHARACTER_GENDER_LABELS] ??
      `未知(${value})`,
  },
  {
    title: '创建时间',
    dataIndex: 'time',
    key: 'time',
    align: 'center',
    className: 'whitespace-nowrap',
    render: (value: string) => value || '-',
  },
  {
    title: '关联账号',
    dataIndex: 'account',
    key: 'account',
    align: 'center',
    render: (account: string | null) =>
      account ? (
        <Link
          className="inline-flex items-center space-x-1"
          to="/accounts/$account"
          params={{ account }}
        >
          <span className="text-base">{account}</span>
          <ExternalLink size={14} aria-hidden="true" />
        </Link>
      ) : (
        '-'
      ),
  },
]

export const CharactersPage: React.FC = () => {
  const [page, setPage] = useState(DEFAULT_PAGE)
  const [pageSize, setPageSize] = useState(DEFAULT_PAGE_SIZE)
  const charactersQuery = useQuery(charactersQueryOptions({ page, pageSize }))

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-semibold">角色管理</h1>
        <p className="text-muted-foreground mt-1">查询游戏角色</p>
      </div>
      <div>
        {charactersQuery.isError && (
          <Alert
            action={
              <Button
                aria-label="重试"
                onClick={() => void charactersQuery.refetch()}
              >
                重试
              </Button>
            }
            showIcon
            title="角色列表加载失败"
            type="error"
          />
        )}
        <Table<CharacterWithAccount>
          className="mt-4"
          columns={columns}
          dataSource={charactersQuery.data?.items ?? []}
          loading={charactersQuery.isPending || charactersQuery.isFetching}
          locale={{ emptyText: '暂无角色' }}
          pagination={{
            current: page,
            onChange: (nextPage, nextPageSize) => {
              if (nextPageSize !== pageSize) {
                setPage(DEFAULT_PAGE)
                setPageSize(nextPageSize)
                return
              }
              setPage(nextPage)
            },
            pageSize,
            pageSizeOptions: [10, 20, 50, 100],
            showSizeChanger: true,
            total: charactersQuery.data?.total ?? 0,
          }}
          rowKey="gid"
          scroll={{ x: 'max-content' }}
        />
      </div>
    </div>
  )
}
