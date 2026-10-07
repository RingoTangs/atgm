import type { Privilege } from '@atgm/contracts'
import type { DescriptionsProps } from 'antd'
import { ACCOUNT_PRIVILEGES, errorCodes } from '@atgm/contracts'
import { useQuery } from '@tanstack/react-query'
import { Link } from '@tanstack/react-router'
import { Alert, Badge, Button, Descriptions, Skeleton, Tooltip } from 'antd'
import { useState } from 'react'
import { ApiError } from '@/lib/apiError'
import { AccountPrivilegeModal } from './AccountPrivilegeModal'
import { AccountRechargeModal } from './AccountRechargeModal'
import { accountDetailQueryOptions } from './accounts-queries'
import './AccountDetailPage.css'

interface AccountDetailPageProps {
  account: string
}

const descriptionStyles: DescriptionsProps['styles'] = {
  label: {
    width: 130,
    textAlign: 'center',
  },
  content: {
    minWidth: 0,
    textAlign: 'center',
  },
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
  const [rechargeOpen, setRechargeOpen] = useState(false)
  const [privilegeOpen, setPrivilegeOpen] = useState(false)
  const accountQuery = useQuery(accountDetailQueryOptions(account))

  if (accountQuery.isPending) {
    return (
      <div className="space-y-6">
        <h1 className="text-2xl font-semibold">账号详情</h1>
        <Skeleton active />
      </div>
    )
  }

  if (accountQuery.isError) {
    const notFound =
      accountQuery.error instanceof ApiError &&
      accountQuery.error.code === errorCodes.ACCOUNT_NOT_FOUND

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
  const privilege = ACCOUNT_PRIVILEGES.find(
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
    <div className="account-detail-page space-y-6">
      <div className="flex items-end justify-between gap-4">
        <div>
          <Link to="/accounts">返回账号列表</Link>
          <h1 className="mt-2 text-2xl font-semibold">账号详情</h1>
        </div>
        <div className="flex gap-2">
          <Tooltip title={detail.online ? '账号在线时无法修改' : undefined}>
            <span>
              <Button
                aria-label="充值"
                disabled={detail.online}
                onClick={() => setRechargeOpen(true)}
                type="primary"
              >
                充值
              </Button>
            </span>
          </Tooltip>
          <Tooltip title={detail.online ? '账号在线时无法修改' : undefined}>
            <span>
              <Button
                aria-label="变更权限"
                disabled={detail.online}
                onClick={() => setPrivilegeOpen(true)}
                type="primary"
              >
                变更权限
              </Button>
            </span>
          </Tooltip>
        </div>
      </div>

      <Descriptions
        bordered
        size="small"
        column={2}
        items={basicInfoItems}
        title="基本信息"
        styles={descriptionStyles}
      />

      <Descriptions
        bordered
        size="small"
        items={assetItems}
        title="资产"
        column={2}
        styles={descriptionStyles}
      />

      <Descriptions
        bordered
        column={3}
        size="small"
        items={loginInfoItems}
        title="登录信息"
        styles={descriptionStyles}
      />

      <Descriptions
        bordered
        column={2}
        size="small"
        items={blockInfoItems}
        title="封禁信息"
        styles={descriptionStyles}
      />

      <AccountRechargeModal
        account={detail}
        onCancel={() => setRechargeOpen(false)}
        open={rechargeOpen}
      />
      <AccountPrivilegeModal
        account={detail}
        onCancel={() => setPrivilegeOpen(false)}
        open={privilegeOpen}
      />
    </div>
  )
}
