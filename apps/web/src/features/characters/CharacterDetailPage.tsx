import type { CharacterDetailResponse } from '@atgm/contracts'
import type { DescriptionsProps } from 'antd'
import {
  CHARACTER_GENDER_LABELS,
  CHARACTER_POLAR_LABELS,
  errorCodes,
} from '@atgm/contracts'
import { useQuery } from '@tanstack/react-query'
import { Link } from '@tanstack/react-router'
import { Alert, Button, Descriptions, Skeleton } from 'antd'
import { ExternalLink } from 'lucide-react'
import { descriptionsTableStyles } from '@/components/descriptionsStyles'
import { ApiError } from '@/lib/apiError'
import { CharacterItems } from './CharacterItems'
import { characterDetailQueryOptions } from './characters-queries'

const labels: Record<keyof CharacterDetailResponse, Record<string, string>> = {
  basicInfo: {
    gid: 'GID',
    name: '角色名',
    account: '关联账号',
    level: '等级',
    polar: '相性',
    gender: '性别',
    createTime: '创建时间',
  },
  sectInfo: { family: '门派', master: '师父', title: '称号' },
  attributes: {
    strength: '力量',
    constitution: '体质',
    dexterity: '敏捷',
    wiz: '灵力',
  },
  combat: {
    life: '气血',
    maxLife: '最大气血',
    mana: '法力',
    maxMana: '最大法力',
    speed: '速度',
    defense: '防御',
    physicalPower: '物伤',
    magPower: '法伤',
  },
  cultivation: {
    experience: '经验',
    experienceToNextLevel: '升级所需经验',
    tao: '道行',
    potential: '潜能',
  },
  assets: {
    cash: '现金',
    goldCoin: '金元宝',
    silverCoin: '银元宝',
    voucher: '代金券',
  },
}
interface ModuleConfig {
  title: string
  column: DescriptionsProps['column']
}

const moduleConfigs: Record<keyof CharacterDetailResponse, ModuleConfig> = {
  basicInfo: { title: '基本信息', column: { xs: 1, sm: 2, md: 3 } },
  sectInfo: { title: '门派信息', column: { xs: 1, sm: 2, md: 3 } },
  attributes: { title: '人物属性', column: { xs: 1, sm: 2, md: 4 } },
  combat: { title: '战斗属性', column: { xs: 1, sm: 2, md: 4 } },
  cultivation: { title: '修炼信息', column: { xs: 1, sm: 2, md: 4 } },
  assets: { title: '资产信息', column: { xs: 1, sm: 2, md: 4 } },
}

function displayValue(key: string, value: string | number | null) {
  if (value === null || value === '') return '-'
  if (key === 'account')
    return (
      <Link
        className="inline-flex items-center space-x-1"
        to="/accounts/$account"
        params={{ account: String(value) }}
      >
        <span className="text-base">{value}</span>
        <ExternalLink size={14} aria-hidden="true" />
      </Link>
    )
  if (key === 'polar')
    return (
      CHARACTER_POLAR_LABELS[value as keyof typeof CHARACTER_POLAR_LABELS] ??
      `未知(${value})`
    )
  if (key === 'gender')
    return (
      CHARACTER_GENDER_LABELS[value as keyof typeof CHARACTER_GENDER_LABELS] ??
      `未知(${value})`
    )
  return typeof value === 'number' ? value.toLocaleString() : value
}

export function CharacterDetailPage({ gid }: { gid: string }) {
  const query = useQuery(characterDetailQueryOptions(gid))
  const notFound =
    query.error instanceof ApiError &&
    query.error.code === errorCodes.CHARACTER_NOT_FOUND
  return (
    <div className="space-y-6" css={descriptionsTableStyles}>
      <div>
        <Link to="/characters">返回角色列表</Link>
        <h1 className="mt-2 text-2xl font-semibold">角色详情</h1>
      </div>
      {query.isPending ? (
        <Skeleton active />
      ) : query.isError ? (
        <Alert
          showIcon
          type="error"
          title={notFound ? '角色不存在' : '角色详情加载失败'}
          description={
            query.error instanceof ApiError &&
            query.error.code === errorCodes.CHARACTER_DATA_INVALID
              ? query.error.message
              : undefined
          }
          action={
            notFound ? undefined : (
              <Button aria-label="重试" onClick={() => void query.refetch()}>
                重试
              </Button>
            )
          }
        />
      ) : (
        <>
          {(Object.keys(labels) as (keyof CharacterDetailResponse)[]).map(
            (group) => {
              const items: DescriptionsProps['items'] = Object.entries(
                query.data[group],
              ).map(([key, value]) => ({
                key,
                label: labels[group][key],
                children: displayValue(key, value),
              }))
              return (
                <Descriptions
                  key={group}
                  title={moduleConfigs[group].title}
                  bordered
                  size="small"
                  column={moduleConfigs[group].column}
                  items={items}
                  styles={{
                    label: {
                      width: 130,
                      textAlign: 'center',
                    },
                    content: {
                      minWidth: 0,
                      textAlign: 'center',
                    },
                  }}
                />
              )
            },
          )}
          <CharacterItems gid={gid} />
        </>
      )}
    </div>
  )
}
