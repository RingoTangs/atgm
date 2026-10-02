import type { Privilege } from '@atgm/contracts'
import type { DescriptionsProps } from 'antd'
import { useQuery } from '@tanstack/react-query'
import { Link } from '@tanstack/react-router'
import { Alert, Badge, Button, Descriptions, Skeleton } from 'antd'
import { useState } from 'react'
import { AccountEditModal } from './AccountEditModal'
import { AccountNotFoundError } from './accounts-api'
import {
  accountDetailQueryOptions,
  privilegesQueryOptions,
} from './accounts-queries'

interface AccountDetailPageProps {
  account: string
}

const displayValue = (value: string): string => value || '-'

const renderPrivilege = (value: number, privilege?: Privilege) => {
  if (!privilege) {
    return (
      <div>
        <div>{value}</div>
        <div className="text-muted-foreground text-xs">未知权限</div>
      </div>
    )
  }

  return (
    <div>
      {privilege.grant && privilege.constant
        ? `${privilege.privilege} - ${privilege.grant} - ${privilege.constant}(${privilege.description})`
        : `${privilege.privilege} - ${privilege.description}`}
    </div>
  )
}

export const AccountDetailPage: React.FC<AccountDetailPageProps> = ({
  account,
}) => {
  const [editOpen, setEditOpen] = useState(false)
  const accountQuery = useQuery(accountDetailQueryOptions(account))
  const privilegesQuery = useQuery(privilegesQueryOptions())

  if (accountQuery.isPending) {
    return (
      <div className="space-y-6">
        <h1 className="text-2xl font-semibold">账号详情</h1>
        <Skeleton active />
      </div>
    )
  }

  if (accountQuery.isError) {
    const notFound = accountQuery.error instanceof AccountNotFoundError

    return (
      <div className="space-y-4">
        <h1 className="text-2xl font-semibold">账号详情</h1>
        <Alert
          action={
            notFound ? (
              <Link to="/accounts">返回账号列表</Link>
            ) : (
              <Button
                aria-label="重试"
                onClick={() => void accountQuery.refetch()}
              >
                重试
              </Button>
            )
          }
          showIcon
          title={notFound ? '账号不存在' : '账号详情加载失败'}
          type="error"
        />
      </div>
    )
  }

  const detail = accountQuery.data
  const privilege = privilegesQuery.data?.find(
    (item) => item.privilege === detail.privilege,
  )
  const basicInfoItems: DescriptionsProps['items'] = [
    {
      key: 'account',
      label: '账号',
      children: detail.account,
    },
    {
      key: 'status',
      label: '状态',
      children: detail.online ? (
        <Badge status="success" text="在线" />
      ) : (
        <Badge status="default" text="离线" />
      ),
    },
    {
      key: 'privilege',
      label: '权限',
      children: renderPrivilege(detail.privilege, privilege),
    },
    {
      key: 'regDate',
      label: '注册时间',
      children: displayValue(detail.regDate),
    },
  ]
  const assetItems: DescriptionsProps['items'] = [
    {
      key: 'goldCoin',
      label: '金币',
      children: detail.goldCoin.toLocaleString(),
    },
    {
      key: 'silverCoin',
      label: '银币',
      children: detail.silverCoin.toLocaleString(),
    },
  ]
  const loginInfoItems: DescriptionsProps['items'] = [
    {
      key: 'firstLoginTime',
      label: '首次登录',
      children: displayValue(detail.firstLoginTime),
    },
    {
      key: 'firstLoginMac',
      label: '首次登录 MAC',
      children: displayValue(detail.firstLoginMac),
    },
    {
      key: 'lastLoginTime',
      label: '最后登录',
      children: displayValue(detail.lastLoginTime),
    },
    {
      key: 'lastLoginIp',
      label: '最后登录 IP',
      children: displayValue(detail.lastLoginIp),
    },
    {
      key: 'lastLoginId',
      label: '最后登录 ID',
      children: displayValue(detail.lastLoginId),
    },
  ]
  const blockInfoItems: DescriptionsProps['items'] = [
    {
      key: 'blockedTime',
      label: '永久封禁时间',
      children: displayValue(detail.blockedTime),
    },
    {
      key: 'blockedReason',
      label: '永久封禁原因',
      children: displayValue(detail.blockedReason),
    },
    {
      key: 'tempBlockedTime',
      label: '临时封禁时间',
      children: displayValue(detail.tempBlockedTime),
    },
    {
      key: 'tempBlockedReason',
      label: '临时封禁原因',
      children: displayValue(detail.tempBlockedReason),
    },
  ]

  return (
    <div className="space-y-6">
      <div className="flex items-end justify-between gap-4">
        <div>
          <Link to="/accounts">返回账号列表</Link>
          <h1 className="mt-2 text-2xl font-semibold">账号详情</h1>
        </div>
        <Button
          aria-label="编辑"
          onClick={() => setEditOpen(true)}
          type="primary"
        >
          编辑
        </Button>
      </div>

      <Descriptions
        bordered
        size="small"
        column={2}
        items={basicInfoItems}
        title="基本信息"
      />

      <Descriptions bordered size="small" items={assetItems} title="资产" />

      <Descriptions
        bordered
        size="small"
        items={loginInfoItems}
        title="登录信息"
      />

      <Descriptions
        bordered
        size="small"
        items={blockInfoItems}
        title="封禁信息"
      />

      <AccountEditModal
        account={detail}
        onCancel={() => setEditOpen(false)}
        open={editOpen}
      />
    </div>
  )
}
