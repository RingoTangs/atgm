import type { CharacterItem } from '@atgm/contracts'
import type { TableProps } from 'antd'
import { useQuery } from '@tanstack/react-query'
import { Alert, Button, Table } from 'antd'
import { characterItemsQueryOptions } from './characters-queries'

const columns: TableProps<CharacterItem>['columns'] = [
  {
    title: '记录 Key',
    dataIndex: 'entryKey',
    key: 'entryKey',
    align: 'center',
  },
  { title: '物品名称', dataIndex: 'name', key: 'name', align: 'center' },
  {
    title: '别名',
    dataIndex: 'alias',
    key: 'alias',
    align: 'center',
    render: (alias: string | null) => alias || '-',
  },
]

export function CharacterItems({ gid }: { gid: string }) {
  const query = useQuery(characterItemsQueryOptions(gid))
  return (
    <section aria-labelledby="character-items-heading" className="space-y-4">
      <h2 id="character-items-heading" className="text-base font-semibold">
        物品信息
      </h2>
      {query.isError && (
        <Alert
          showIcon
          type="error"
          title="物品信息加载失败"
          action={
            <Button aria-label="重试" onClick={() => void query.refetch()}>
              重试
            </Button>
          }
        />
      )}
      {(!query.isError || query.data) && (
        <Table<CharacterItem>
          columns={columns}
          dataSource={query.data?.items ?? []}
          loading={query.isPending || query.isFetching}
          locale={{ emptyText: query.isPending ? '加载中' : '暂无物品' }}
          bordered
          size="small"
          pagination={false}
          rowKey="entryKey"
          scroll={{ x: 'max-content' }}
        />
      )}
    </section>
  )
}
