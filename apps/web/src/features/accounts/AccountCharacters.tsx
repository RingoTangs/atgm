import type { CharacterListItem } from '@atgm/contracts'
import { useQuery } from '@tanstack/react-query'
import { Alert, Button, Table } from 'antd'
import { createCharacterColumns } from '@/features/characters/characterColumns'
import { accountCharactersQueryOptions } from './accounts-queries'

export const AccountCharacters: React.FC<{ account: string }> = ({
  account,
}) => {
  const charactersQuery = useQuery(accountCharactersQueryOptions(account))
  const data = charactersQuery.data

  return (
    <section aria-labelledby="account-characters-heading" className="space-y-4">
      <h2 id="account-characters-heading" className="text-base font-semibold">
        关联角色
      </h2>
      {charactersQuery.isError && (
        <Alert
          showIcon
          title="关联角色加载失败"
          type="error"
          action={
            <Button
              aria-label="重试"
              onClick={() => void charactersQuery.refetch()}
            >
              重试
            </Button>
          }
        />
      )}
      {data && <p>最近登陆角色 GID：{data.recRole ?? '-'}</p>}
      {(!charactersQuery.isError || data) && (
        <Table<CharacterListItem>
          columns={createCharacterColumns({ recRole: data?.recRole })}
          dataSource={data?.chars ?? []}
          loading={charactersQuery.isPending || charactersQuery.isFetching}
          locale={{
            emptyText: charactersQuery.isPending ? '加载中' : '暂无角色',
          }}
          bordered
          size="small"
          pagination={false}
          rowKey={(record, index) => `${record.gid}-${index}`}
          scroll={{ x: 'max-content' }}
        />
      )}
    </section>
  )
}
