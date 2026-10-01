import type { Privilege } from '@atgm/contracts'

export const ACCOUNT_PRIVILEGES = [
  {
    privilege: 0,
    grant: 'USER',
    constant: 'COMMON_USER',
    type: '用户权限',
    description: '普通用户',
  },
  {
    privilege: 120,
    grant: 'GA',
    constant: 'ADMINISTRATOR',
    type: '管理特权',
    description: '管理员',
  },
  {
    privilege: 130,
    grant: 'GA1',
    constant: 'OBSERVER',
    type: '管理特权',
    description: '观察员',
  },
  {
    privilege: 140,
    grant: 'GA2',
    constant: 'CUSTOMER_SERVICE_1',
    type: '管理特权',
    description: '一级客服',
  },
  {
    privilege: 150,
    grant: 'GA3',
    constant: 'CUSTOMER_SERVICE_2',
    type: '管理特权',
    description: '二级客服',
  },
  {
    privilege: 200,
    grant: 'GB',
    constant: 'BEHOLDER',
    type: '管理特权',
    description: 'Beholder / 监管类权限',
  },
  {
    privilege: 300,
    grant: 'GC',
    constant: 'CONTROLLER',
    type: '管理特权',
    description: 'Controller / 控制类权限',
  },
  {
    privilege: 400,
    grant: 'GC1',
    constant: 'CONTROLLER_1',
    type: '管理特权',
    description: 'Controller 1 / 控制类权限',
  },
  {
    privilege: 1000,
    grant: 'GD',
    constant: 'DEBUGGER',
    type: '调试特权',
    description: '调试器权限',
  },
] satisfies Privilege[]
