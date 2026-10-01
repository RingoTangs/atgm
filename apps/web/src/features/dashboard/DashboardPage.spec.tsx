import { cleanup, render, screen } from '@testing-library/react'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { DashboardPage } from './DashboardPage'

beforeEach(() => {
  vi.stubGlobal(
    'ResizeObserver',
    class ResizeObserver {
      observe = vi.fn()
      unobserve = vi.fn()
      disconnect = vi.fn()
    },
  )
  vi.stubGlobal(
    'matchMedia',
    vi.fn((query: string) => ({
      matches: false,
      media: query,
      onchange: null,
      addEventListener: vi.fn(),
      removeEventListener: vi.fn(),
      addListener: vi.fn(),
      removeListener: vi.fn(),
      dispatchEvent: vi.fn(() => true),
    })),
  )
})

afterEach(() => {
  cleanup()
  vi.unstubAllGlobals()
})

describe('dashboard page', () => {
  it('展示 Dashboard 标题和系统概览', () => {
    render(<DashboardPage />)

    expect(
      screen.getByRole('heading', { name: 'Dashboard' }),
    ).toBeInTheDocument()
    expect(screen.getByText('系统运行概览')).toBeInTheDocument()
  })

  it('展示四个统计指标及其格式化数值', () => {
    render(<DashboardPage />)

    for (const title of ['总账号数', '今日登录', '在线角色', '今日新增']) {
      expect(screen.getByText(title)).toBeInTheDocument()
    }

    for (const value of ['12,580', '1,248', '386', '42']) {
      expect(screen.getByText(value)).toBeInTheDocument()
    }
  })

  it('展示最近登录账号及在线状态', () => {
    render(<DashboardPage />)

    expect(screen.getByText('最近登录账号')).toBeInTheDocument()
    expect(screen.getByText('test01')).toBeInTheDocument()
    expect(screen.getByText('test02')).toBeInTheDocument()
    expect(screen.getAllByText('在线')).not.toHaveLength(0)
    expect(screen.getAllByText('离线')).not.toHaveLength(0)
  })

  it('展示服务状态', () => {
    render(<DashboardPage />)

    for (const service of [
      '登录服务器',
      '游戏服务器',
      '账号数据库',
      '角色数据库',
    ]) {
      expect(screen.getByText(service)).toBeInTheDocument()
    }

    expect(screen.getAllByText('正常')).toHaveLength(3)
    expect(screen.getByText('未检测')).toBeInTheDocument()
  })

  it('展示最近 GM 操作', () => {
    render(<DashboardPage />)

    expect(screen.getByText('最近 GM 操作')).toBeInTheDocument()
    expect(screen.getAllByText(/admin/)).not.toHaveLength(0)
    expect(screen.getByText(/修改账号权限/)).toHaveTextContent('test01')
    expect(screen.getByText(/增加金币/)).toHaveTextContent('test02')
  })
})
