import type { CharacterListItem } from '@atgm/contracts'
import {
  PAGINATION_DEFAULT_PAGE,
  PAGINATION_DEFAULT_PAGE_SIZE,
} from '@atgm/contracts'
import { useQuery } from '@tanstack/react-query'
import { Alert, Button, Table } from 'antd'
import { useState } from 'react'
import { createCharacterColumns } from './characterColumns'
import { charactersQueryOptions } from './characters-queries'

const columns = createCharacterColumns()

export const CharactersPage: React.FC = () => {
  const [page, setPage] = useState(PAGINATION_DEFAULT_PAGE)
  const [pageSize, setPageSize] = useState(PAGINATION_DEFAULT_PAGE_SIZE)
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
        <Table<CharacterListItem>
          className="mt-4"
          columns={columns}
          dataSource={charactersQuery.data?.items ?? []}
          loading={charactersQuery.isPending || charactersQuery.isFetching}
          locale={{ emptyText: '暂无角色' }}
          pagination={{
            current: page,
            onChange: (nextPage, nextPageSize) => {
              if (nextPageSize !== pageSize) {
                setPage(PAGINATION_DEFAULT_PAGE)
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
