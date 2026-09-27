import { act, cleanup, render } from '@testing-library/react'
import { StrictMode } from 'react'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { useLoaderStore } from './loaderStore'

import { RouterProgress } from './RouterProgress'

const advance = (ms: number) => act(() => vi.advanceTimersByTime(ms))
const container = () => document.querySelector('.router-progress')
const bar = () => container()?.firstElementChild as HTMLElement | undefined

beforeEach(() => {
  vi.useFakeTimers()
  vi.spyOn(Math, 'random').mockReturnValue(0)
  useLoaderStore.setState({ mode: 'idle' })
})

afterEach(() => {
  cleanup()
  useLoaderStore.setState(useLoaderStore.getInitialState(), true)
  act(() => vi.runOnlyPendingTimers())
  vi.useRealTimers()
  vi.restoreAllMocks()
})

describe('路由进度条', () => {
  it('初始空闲不显示进度条，也不启动定时器', () => {
    render(<RouterProgress />)
    advance(2000)
    expect(container()).toBeNull()
    expect(vi.getTimerCount()).toBe(0)
  })

  it('短于 150ms 的导航不显示进度条', () => {
    const { rerender } = render(<RouterProgress />)
    act(() => useLoaderStore.getState().setNavigationLoading())
    rerender(<RouterProgress />)
    advance(149)
    expect(container()).toBeNull()
    act(() => useLoaderStore.getState().clearLoading())
    rerender(<RouterProgress />)
    advance(2000)
    expect(container()).toBeNull()
    expect(vi.getTimerCount()).toBe(0)
  })

  it('持续加载延迟显示，重渲染不重启，完成后移除实例', () => {
    act(() => useLoaderStore.getState().setNavigationLoading())
    const { rerender } = render(<RouterProgress />)
    advance(150)
    expect(bar()?.style.width).toBe('10%')
    advance(1000)
    const width = bar()?.style.width
    rerender(<RouterProgress />)
    expect(bar()?.style.width).toBe(width)
    expect(width).not.toBe('10%')
    act(() => useLoaderStore.getState().clearLoading())
    rerender(<RouterProgress />)
    expect(bar()?.style.width).toBe('100%')
    advance(500)
    advance(1000)
    expect(container()).toBeNull()
  })

  it('150ms 到期后立即结束会正常完成并卸载', () => {
    act(() => useLoaderStore.getState().setNavigationLoading())
    const { rerender } = render(<RouterProgress />)
    advance(150)
    expect(bar()?.style.width).toBe('10%')
    act(() => useLoaderStore.getState().clearLoading())
    rerender(<RouterProgress />)
    expect(bar()?.style.width).toBe('100%')
    advance(500)
    advance(1000)
    expect(container()).toBeNull()
    expect(vi.getTimerCount()).toBe(0)
  })

  it('显示延迟与 idle 更新同时提交时直接清理未启动实例', () => {
    act(() => useLoaderStore.getState().setNavigationLoading())
    const { rerender } = render(<RouterProgress />)
    act(() => {
      vi.advanceTimersByTime(150)
      act(() => useLoaderStore.getState().clearLoading())
      rerender(<RouterProgress />)
    })
    expect(container()).toBeNull()
    expect(vi.getTimerCount()).toBe(0)
    advance(2000)
    expect(container()).toBeNull()
  })

  it('上一轮完成定时器不会隐藏、归零或卸载下一轮', () => {
    act(() => useLoaderStore.getState().setNavigationLoading())
    const { rerender } = render(<RouterProgress />)
    advance(150)
    const first = container()
    act(() => useLoaderStore.getState().clearLoading())
    rerender(<RouterProgress />)
    advance(100)
    act(() => useLoaderStore.getState().setNavigationLoading())
    rerender(<RouterProgress />)
    expect(container()).toBeNull()
    advance(150)
    const second = container()
    expect(second).not.toBe(first)
    expect(bar()?.style.opacity).toBe('1')
    advance(500)
    advance(1000)
    expect(container()).toBe(second)
    expect(bar()?.style.opacity).toBe('1')
    expect(Number.parseFloat(bar()!.style.width)).toBeGreaterThan(0)
    expect(Number.parseFloat(bar()!.style.width)).toBeLessThan(100)
  })

  it.each([50, 150])('加载 %sms 后卸载会清理等待或递增定时器', (ms) => {
    act(() => useLoaderStore.getState().setNavigationLoading())
    const { unmount } = render(<RouterProgress />)
    advance(ms)
    if (ms >= 150) {
      expect(bar()?.style.width).toBe('10%')
    }
    unmount()
    expect(container()).toBeNull()
    expect(vi.getTimerCount()).toBe(0)
  })

  it('在 StrictMode 下正确初始化且重渲染不重启或遗留定时器', () => {
    act(() => useLoaderStore.getState().setNavigationLoading())
    const { rerender, unmount } = render(
      <StrictMode>
        <RouterProgress />
      </StrictMode>,
    )
    expect(vi.getTimerCount()).toBe(1)
    advance(150)
    expect(bar()?.style.width).toBe('10%')
    expect(vi.getTimerCount()).toBe(1)
    advance(1000)
    const width = bar()?.style.width
    rerender(
      <StrictMode>
        <RouterProgress />
      </StrictMode>,
    )
    expect(bar()?.style.width).toBe(width)
    unmount()
    expect(vi.getTimerCount()).toBe(0)
  })
})
