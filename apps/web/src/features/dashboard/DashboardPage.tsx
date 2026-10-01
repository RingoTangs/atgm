import type { BadgeProps, TableProps } from 'antd'
import type { LucideIcon } from 'lucide-react'
import { Badge, Card, Statistic, Table, Tag, Timeline } from 'antd'
import { LogIn, UserPlus, UserRoundCheck, Users } from 'lucide-react'

interface DashboardStatistic {
  key: string
  title: string
  value: number
  icon: LucideIcon
}

interface RecentAccount {
  key: string
  account: string
  lastLoginTime: string
  online: boolean
}

type ServiceStatus = 'online' | 'offline' | 'unknown'

interface Service {
  key: string
  name: string
  status: ServiceStatus
}

interface RecentOperation {
  id: string
  operator: string
  action: string
  target: string
  time: string
}

const statistics: DashboardStatistic[] = [
  { key: 'accounts', title: '总账号数', value: 12580, icon: Users },
  { key: 'logins', title: '今日登录', value: 1248, icon: LogIn },
  {
    key: 'online-characters',
    title: '在线角色',
    value: 386,
    icon: UserRoundCheck,
  },
  { key: 'new-accounts', title: '今日新增', value: 42, icon: UserPlus },
]

const recentAccounts: RecentAccount[] = [
  {
    key: 'test01',
    account: 'test01',
    lastLoginTime: '2026-10-01 19:12',
    online: true,
  },
  {
    key: 'test02',
    account: 'test02',
    lastLoginTime: '2026-10-01 19:06',
    online: false,
  },
  {
    key: 'test03',
    account: 'test03',
    lastLoginTime: '2026-10-01 18:58',
    online: false,
  },
  {
    key: 'test04',
    account: 'test04',
    lastLoginTime: '2026-10-01 18:42',
    online: true,
  },
  {
    key: 'test05',
    account: 'test05',
    lastLoginTime: '2026-10-01 18:31',
    online: false,
  },
]

const services: Service[] = [
  { key: 'login', name: '登录服务器', status: 'online' },
  { key: 'game', name: '游戏服务器', status: 'online' },
  { key: 'account-database', name: '账号数据库', status: 'online' },
  { key: 'character-database', name: '角色数据库', status: 'unknown' },
]

const recentOperations: RecentOperation[] = [
  {
    id: 'permission-test01',
    operator: 'admin',
    action: '修改账号权限',
    target: 'test01',
    time: '2026-10-01 19:20',
  },
  {
    id: 'gold-test02',
    operator: 'admin',
    action: '增加金币',
    target: 'test02',
    time: '2026-10-01 19:10',
  },
  {
    id: 'create-test03',
    operator: 'admin',
    action: '创建账号',
    target: 'test03',
    time: '2026-10-01 18:55',
  },
  {
    id: 'unlock-test04',
    operator: 'gm01',
    action: '解除封禁',
    target: 'test04',
    time: '2026-10-01 18:40',
  },
]

const accountColumns: TableProps<RecentAccount>['columns'] = [
  {
    title: '账号',
    dataIndex: 'account',
    key: 'account',
  },
  {
    title: '最后登录',
    dataIndex: 'lastLoginTime',
    key: 'lastLoginTime',
  },
  {
    title: '状态',
    dataIndex: 'online',
    key: 'online',
    render: (online: boolean) =>
      online ? <Tag color="success">在线</Tag> : <Tag>离线</Tag>,
  },
]

const serviceStatus: Record<
  ServiceStatus,
  { badge: BadgeProps['status']; label: string }
> = {
  online: { badge: 'success', label: '正常' },
  offline: { badge: 'error', label: '异常' },
  unknown: { badge: 'default', label: '未检测' },
}

export const DashboardPage: React.FC = () => {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-semibold">Dashboard</h1>
        <p className="text-muted-foreground mt-1">系统运行概览</p>
      </div>

      <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
        {statistics.map(({ key, title, value, icon: Icon }) => (
          <Card key={key}>
            <Statistic
              groupSeparator=","
              prefix={<Icon aria-hidden="true" size={22} />}
              title={title}
              value={value}
            />
          </Card>
        ))}
      </div>

      <div className="grid min-w-0 gap-4 xl:grid-cols-3">
        <Card className="min-w-0 xl:col-span-2" title="最近登录账号">
          <Table<RecentAccount>
            columns={accountColumns}
            dataSource={recentAccounts}
            pagination={false}
            scroll={{ x: 'max-content' }}
            size="middle"
          />
        </Card>

        <Card title="服务状态">
          <div className="space-y-4">
            {services.map((service) => {
              const status = serviceStatus[service.status]

              return (
                <div
                  className="flex items-center justify-between gap-4"
                  key={service.key}
                >
                  <span>{service.name}</span>
                  <Badge status={status.badge} text={status.label} />
                </div>
              )
            })}
          </div>
        </Card>
      </div>

      <Card title="最近 GM 操作">
        <Timeline
          items={recentOperations.map((operation) => ({
            key: operation.id,
            title: (
              <span>
                {operation.operator} · {operation.action} · {operation.target}
              </span>
            ),
            content: (
              <span className="text-muted-foreground">{operation.time}</span>
            ),
          }))}
        />
      </Card>
    </div>
  )
}
