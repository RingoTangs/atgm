import type { Privilege } from '@atgm/contracts'
import { useQuery } from '@tanstack/react-query'
import { Link } from '@tanstack/react-router'
import { Alert, Button, Descriptions, Skeleton } from 'antd'
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
      <div>
        {value} - {privilege.grant}
      </div>
      <div className="text-muted-foreground text-xs">
        {privilege.description}
      </div>
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

      <Descriptions bordered title="基本信息">
        <Descriptions.Item label="账号">{detail.account}</Descriptions.Item>
        <Descriptions.Item label="权限">
          {renderPrivilege(detail.privilege, privilege)}
        </Descriptions.Item>
        <Descriptions.Item label="注册时间">
          {displayValue(detail.regDate)}
        </Descriptions.Item>
      </Descriptions>

      <Descriptions bordered title="资产">
        <Descriptions.Item label="金币">
          {detail.goldCoin.toLocaleString()}
        </Descriptions.Item>
        <Descriptions.Item label="银币">
          {detail.silverCoin.toLocaleString()}
        </Descriptions.Item>
      </Descriptions>

      <Descriptions bordered title="登录信息">
        <Descriptions.Item label="首次登录">
          {displayValue(detail.firstLoginTime)}
        </Descriptions.Item>
        <Descriptions.Item label="首次登录 MAC">
          {displayValue(detail.firstLoginMac)}
        </Descriptions.Item>
        <Descriptions.Item label="最后登录">
          {displayValue(detail.lastLoginTime)}
        </Descriptions.Item>
        <Descriptions.Item label="最后登录 IP">
          {displayValue(detail.lastLoginIp)}
        </Descriptions.Item>
        <Descriptions.Item label="最后登录 ID">
          {displayValue(detail.lastLoginId)}
        </Descriptions.Item>
      </Descriptions>

      <Descriptions bordered title="封禁信息">
        <Descriptions.Item label="永久封禁时间">
          {displayValue(detail.blockedTime)}
        </Descriptions.Item>
        <Descriptions.Item label="永久封禁原因">
          {displayValue(detail.blockedReason)}
        </Descriptions.Item>
        <Descriptions.Item label="临时封禁时间">
          {displayValue(detail.tempBlockedTime)}
        </Descriptions.Item>
        <Descriptions.Item label="临时封禁原因">
          {displayValue(detail.tempBlockedReason)}
        </Descriptions.Item>
      </Descriptions>

      <AccountEditModal
        account={detail}
        onCancel={() => setEditOpen(false)}
        open={editOpen}
      />
    </div>
  )
}
