import type { ServerListItem } from '@atgm/contracts'
import type { TableProps } from 'antd'
import { DEFAULT_PAGE, DEFAULT_PAGE_SIZE } from '@atgm/contracts'
import { useQuery } from '@tanstack/react-query'
import { Alert, Button, Table } from 'antd'
import { useState } from 'react'
import { serversQueryOptions } from './servers-queries'

const columns: TableProps<ServerListItem>['columns'] = [
  { title: '线路 ID', dataIndex: 'id', key: 'id', align: 'center' },
  { title: '服务器名称', dataIndex: 'server', key: 'server', align: 'center' },
  { title: '所属区组', dataIndex: 'dist', key: 'dist', align: 'center' },
  { title: '别名', dataIndex: 'alias', key: 'alias', align: 'center' },
  { title: 'IP 地址', dataIndex: 'ip', key: 'ip', align: 'center' },
  { title: '端口', dataIndex: 'port', key: 'port', align: 'center' },
  { title: '最大人数', dataIndex: 'maxUser', key: 'maxUser', align: 'center' },
  {
    title: '启用状态',
    dataIndex: 'enable',
    key: 'enable',
    align: 'center',
    render: (value: number) =>
      value === 1 ? '已启用' : value === 0 ? '已禁用' : `未知状态（${value}）`,
  },
]

export const ServersPage: React.FC = () => {
  const [page, setPage] = useState(DEFAULT_PAGE)
  const [pageSize, setPageSize] = useState(DEFAULT_PAGE_SIZE)
  const serversQuery = useQuery(serversQueryOptions({ page, pageSize }))

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-semibold">服务器管理</h1>
        <p className="text-muted-foreground mt-1">查询游戏服务器配置</p>
      </div>
      <div>
        {serversQuery.isError && (
          <Alert
            action={
              <Button
                aria-label="重试"
                onClick={() => void serversQuery.refetch()}
              >
                重试
              </Button>
            }
            showIcon
            title="服务器列表加载失败"
            type="error"
          />
        )}
        <Table<ServerListItem>
          className="mt-4"
          columns={columns}
          dataSource={serversQuery.data?.items ?? []}
          loading={serversQuery.isPending || serversQuery.isFetching}
          locale={{ emptyText: '暂无服务器' }}
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
            total: serversQuery.data?.total ?? 0,
          }}
          rowKey="server"
          scroll={{ x: 'max-content' }}
        />
      </div>
    </div>
  )
}
