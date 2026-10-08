import type { CharacterListItem } from '@atgm/contracts'
import type { TableProps } from 'antd'
import {
  CHARACTER_GENDER_LABELS,
  CHARACTER_POLAR_LABELS,
} from '@atgm/contracts'
import { Tag } from 'antd'

export const createCharacterColumns = ({
  recRole,
  timeTitle = '时间',
}: {
  recRole?: string | null
  timeTitle?: string
} = {}): TableProps<CharacterListItem>['columns'] => [
  { title: 'GID', dataIndex: 'gid', key: 'gid', align: 'center' },
  {
    title: '角色名',
    dataIndex: 'name',
    key: 'name',
    align: 'center',
    render: (name: string, character: CharacterListItem) => (
      <span>
        {name}
        {character.gid === recRole && (
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
      CHARACTER_GENDER_LABELS[value as keyof typeof CHARACTER_GENDER_LABELS] ??
      `未知(${value})`,
  },
  {
    title: timeTitle,
    dataIndex: 'time',
    key: 'time',
    align: 'center',
    className: 'whitespace-nowrap',
    render: (value: string) => value || '-',
  },
]
