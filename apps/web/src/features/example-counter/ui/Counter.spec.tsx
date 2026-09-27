import { cleanup, fireEvent, render, screen } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { afterEach, beforeEach, describe, expect, it } from 'vitest'
import { useCounterStore } from '../model/counterStore'
import { Counter } from './Counter'

beforeEach(() => {
  useCounterStore.setState(useCounterStore.getInitialState(), true)
})

afterEach(() => {
  cleanup()
  useCounterStore.setState(useCounterStore.getInitialState(), true)
})

describe('counter 组件', () => {
  it('默认从 0 开始', () => {
    render(<Counter />)
    expect(screen.getByTestId('count')).toHaveTextContent('Current count: 0')
  })

  it('点击 + 按钮计数加 1', () => {
    render(<Counter />)
    const incrementBtn = screen.getByText('+')
    fireEvent.click(incrementBtn)
    expect(screen.getByTestId('count')).toHaveTextContent('Current count: 1')
  })

  it('点击 - 按钮计数减 1', () => {
    render(<Counter />)
    fireEvent.click(screen.getByText('-'))
    expect(screen.getByTestId('count')).toHaveTextContent('Current count: -1')
  })

  it('点击重置按钮恢复为 0', () => {
    render(<Counter />)
    fireEvent.click(screen.getByText('+'))
    fireEvent.click(screen.getByText('+'))
    fireEvent.click(screen.getByText('Reset'))
    expect(screen.getByTestId('count')).toHaveTextContent('Current count: 0')
  })

  it('多个组件共享计数及重置操作', () => {
    render(
      <>
        <Counter />
        <Counter />
      </>,
    )
    fireEvent.click(
      screen.getAllByRole('button', { name: 'Increase count' })[0],
    )
    screen.getAllByTestId('count').forEach((count) => {
      expect(count).toHaveTextContent('Current count: 1')
    })
    fireEvent.click(screen.getAllByRole('button', { name: 'Reset count' })[1])
    screen.getAllByTestId('count').forEach((count) => {
      expect(count).toHaveTextContent('Current count: 0')
    })
  })

  it('卸载后重新挂载保留计数', () => {
    const { unmount } = render(<Counter />)
    fireEvent.click(screen.getByRole('button', { name: 'Increase count' }))
    unmount()
    render(<Counter />)
    expect(screen.getByTestId('count')).toHaveTextContent('Current count: 1')
  })

  it('标题正确渲染并可以使用 jest-dom 扩展断言', () => {
    render(<Counter />)
    const title = screen.getByRole('heading', { name: 'Counter', level: 2 })
    expect(title).toBeInTheDocument()
    expect(title).toHaveTextContent('Counter')
    expect(
      screen.getByRole('button', { name: 'Decrease count' }),
    ).toBeInTheDocument()
    expect(
      screen.getByRole('button', { name: 'Increase count' }),
    ).toBeInTheDocument()
    expect(
      screen.getByRole('button', { name: 'Reset count' }),
    ).toBeInTheDocument()
  })

  it('支持 Tab 切换焦点和键盘操作', async () => {
    const user = userEvent.setup()
    render(<Counter />)
    await user.tab()
    expect(screen.getByRole('button', { name: 'Decrease count' })).toHaveFocus()
    await user.keyboard('{Enter}')
    expect(screen.getByTestId('count')).toHaveTextContent('Current count: -1')
    await user.tab()
    expect(screen.getByRole('button', { name: 'Increase count' })).toHaveFocus()
    await user.keyboard(' ')
    expect(screen.getByTestId('count')).toHaveTextContent('Current count: 0')
    await user.keyboard('{Enter}')
    await user.tab()
    expect(screen.getByRole('button', { name: 'Reset count' })).toHaveFocus()
    await user.keyboard('{Enter}')
    expect(screen.getByTestId('count')).toHaveTextContent('Current count: 0')
  })
})
