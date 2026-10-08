import type { CharacterListItem } from '@atgm/contracts'
import type { TableProps } from 'antd'
import {
  CHARACTER_GENDER_LABELS,
  CHARACTER_POLAR_LABELS,
} from '@atgm/contracts'
import { useQuery } from '@tanstack/react-query'
import { Alert, Button, Table, Tag } from 'antd'
import { accountCharactersQueryOptions } from './accounts-queries'

export const AccountCharacters: React.FC<{ account: string }> = ({
  account,
}) => {
  const charactersQuery = useQuery(accountCharactersQueryOptions(account))
  const data = charactersQuery.data
  const columns: TableProps<CharacterListItem>['columns'] = [
    { title: 'GID', dataIndex: 'gid', key: 'gid', align: 'center' },
    {
      title: '角色名',
      dataIndex: 'name',
      key: 'name',
      align: 'center',
      render: (name: string, character: CharacterListItem) => (
        <span>
          {name}
          {character.gid === data?.recRole && (
            <Tag className="ml-2" color="blue">
              最近登陆
            </Tag>
          )}
        </span>
      ),
    },
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
        CHARACTER_GENDER_LABELS[
          value as keyof typeof CHARACTER_GENDER_LABELS
        ] ?? `未知(${value})`,
    },
    {
      title: '创建时间',
      dataIndex: 'time',
      key: 'time',
      align: 'center',
      className: 'whitespace-nowrap',
      render: (value: string) => value || '-',
    },
  ]

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
          columns={columns}
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
