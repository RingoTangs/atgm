import { act, cleanup, render, screen } from '@testing-library/react'
import { StrictMode } from 'react'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { useLoaderStore } from './loaderStore'
import { RouterSpinner } from './RouterSpinner'

const advance = (ms: number) => act(() => vi.advanceTimersByTime(ms))
const stop = () => act(() => useLoaderStore.getState().clearLoading())

beforeEach(() => {
  vi.useFakeTimers()
  useLoaderStore.setState(useLoaderStore.getInitialState(), true)
})
afterEach(() => {
  cleanup()
  useLoaderStore.setState(useLoaderStore.getInitialState(), true)
  vi.useRealTimers()
})

describe('启动加载遮罩', () => {
  it('快速加载不会显示', () => {
    render(<RouterSpinner />)
    advance(149)
    stop()
    advance(1000)
    expect(screen.queryByRole('status')).toBeNull()
  })

  it('延迟显示后补足最短展示时间', () => {
    render(<RouterSpinner />)
    advance(150)
    expect(screen.getByRole('status')).toHaveTextContent('Loading...')
    expect(screen.getByRole('status')).toHaveClass('fixed', 'inset-0')
    stop()
    advance(299)
    expect(screen.getByRole('status')).toBeInTheDocument()
    advance(1)
    expect(screen.queryByRole('status')).toBeNull()
  })

  it('持续加载不会重置首次显示时间', () => {
    render(<RouterSpinner />)
    advance(150)
    advance(200)
    stop()
    advance(100)
    expect(screen.queryByRole('status')).toBeNull()
  })

  it('重新加载取消隐藏，已显示的遮罩不重新计时', () => {
    render(<RouterSpinner />)
    advance(150)
    stop()
    advance(100)
    act(() => useLoaderStore.getState().setBootLoading())
    advance(300)
    expect(screen.getByRole('status')).toBeInTheDocument()
    stop()
    advance(0)
    expect(screen.queryByRole('status')).toBeNull()
  })

  it.each([50, 150])('strictMode 下在 %sms 卸载会清理定时器', (ms) => {
    const { unmount } = render(
      <StrictMode>
        <RouterSpinner />
      </StrictMode>,
    )
    advance(ms)
    if (ms === 150) {
      expect(screen.getByRole('status')).toBeInTheDocument()
      stop()
    }
    unmount()
    expect(vi.getTimerCount()).toBe(0)
  })
})
