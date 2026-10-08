import { LpcParseError, parseLpcValue } from '@atgm/lpc'
import { cleanup, render, screen } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { LpcFormatterPage } from './LpcFormatterPage'

const source = '(["name":"测试","items":({1,2,3,})])'
const formatted = `([
  "name": "测试",
  "items": ({
    1,
    2,
    3,
  }),
])`

const setup = () => {
  const user = userEvent.setup()
  render(<LpcFormatterPage />)
  return {
    user,
    input: screen.getByLabelText('原始 LPC'),
    output: screen.getByLabelText('格式化结果'),
    format: screen.getByRole('button', { name: '格式化' }),
    copy: screen.getByRole('button', { name: '复制结果' }),
  }
}

beforeEach(() => {
  vi.stubGlobal(
    'matchMedia',
    vi.fn((query: string) => ({
      matches: false,
      media: query,
      onchange: null,
      addListener: vi.fn(),
      removeListener: vi.fn(),
      addEventListener: vi.fn(),
      removeEventListener: vi.fn(),
      dispatchEvent: vi.fn(),
    })),
  )
  vi.stubGlobal(
    'ResizeObserver',
    class ResizeObserver {
      observe = vi.fn()
      unobserve = vi.fn()
      disconnect = vi.fn()
    },
  )
})

afterEach(() => {
  cleanup()
  vi.restoreAllMocks()
  vi.unstubAllGlobals()
})

describe('lpc formatter', () => {
  it('formats LPC without replacing the input and copies the readonly result', async () => {
    const { user, input, output, format, copy } = setup()
    expect(copy).toBeDisabled()
    const writeText = vi
      .spyOn(navigator.clipboard, 'writeText')
      .mockResolvedValue()
    await user.click(input)
    await user.paste(source)
    await user.click(format)
    expect(input).toHaveValue(source)
    expect(output).toHaveValue(formatted)
    expect(output).toHaveAttribute('readonly')
    expect(copy).toBeEnabled()
    await user.click(copy)
    expect(writeText).toHaveBeenCalledWith(formatted)
    expect(await screen.findByText('复制成功')).toBeInTheDocument()
    await user.click(screen.getByRole('button', { name: '清空' }))
    expect(input).toHaveValue('')
    expect(output).toHaveValue('')
    expect(copy).toBeDisabled()
  })

  it('shows the parser message and offset, clears stale output, and clears all state', async () => {
    const { user, input, output, format, copy } = setup()
    await user.click(input)
    await user.paste(source)
    await user.click(format)
    await user.clear(input)
    const invalid = '(["name":'
    await user.paste(invalid)
    await user.click(format)
    try {
      parseLpcValue(invalid)
      throw new Error('Expected parsing to fail')
    } catch (error) {
      expect(error).toBeInstanceOf(LpcParseError)
      if (!(error instanceof LpcParseError)) throw error
      expect(screen.getByRole('alert')).toHaveTextContent(error.message)
      expect(screen.getByRole('alert')).toHaveTextContent(
        `offset: ${error.offset}`,
      )
    }
    expect(output).toHaveValue('')
    expect(copy).toBeDisabled()
    await user.click(screen.getByRole('button', { name: '清空' }))
    expect(input).toHaveValue('')
    expect(output).toHaveValue('')
    expect(screen.queryByRole('alert')).not.toBeInTheDocument()
  })

  it('clears parsing errors when formatting succeeds again', async () => {
    const { user, input, format, output } = setup()
    await user.click(format)
    expect(screen.getByRole('alert')).toBeInTheDocument()
    await user.click(input)
    await user.paste(source)
    await user.click(format)
    expect(screen.queryByRole('alert')).not.toBeInTheDocument()
    expect(output).toHaveValue(formatted)
  })

  it('reports clipboard failure while preserving the result', async () => {
    const { user, input, format, copy, output } = setup()
    vi.spyOn(navigator.clipboard, 'writeText').mockRejectedValue(
      new Error('Denied'),
    )
    await user.click(input)
    await user.paste(source)
    await user.click(format)
    await user.click(copy)
    expect(await screen.findByText('复制失败，请手动复制')).toBeInTheDocument()
    expect(output).toHaveValue(formatted)
  })
})

describe('lpc analysis integration', () => {
  it('parses on entering the tab, preserves input and manually refreshes after editing', async () => {
    const { user, input } = setup()
    await user.click(input)
    await user.paste('(["me":(["level":33,]),])')
    await user.click(screen.getByRole('tab', { name: '深度解析' }))
    expect(screen.getByRole('tree')).toBeInTheDocument()
    await user.click(screen.getByText('level', { exact: true }))
    expect(screen.getByText('$.me.level')).toBeInTheDocument()
    expect(input).toHaveValue('(["me":(["level":33,]),])')
    await user.clear(input)
    await user.paste('({2,})')
    expect(screen.queryByRole('tree')).not.toBeInTheDocument()
    expect(screen.getByText('点击解析查看结果')).toBeInTheDocument()
    await user.click(screen.getByRole('button', { name: '解析' }))
    expect(screen.getByRole('tree')).toBeInTheDocument()
    expect(screen.getByText('Array')).toBeInTheDocument()
    await user.click(screen.getByRole('button', { name: '清空' }))
    expect(input).toHaveValue('')
    expect(screen.queryByRole('tree')).not.toBeInTheDocument()
    expect(screen.queryByRole('alert')).not.toBeInTheDocument()
    await user.click(screen.getByRole('tab', { name: '格式化' }))
    expect(screen.getByLabelText('格式化结果')).toHaveValue('')
    expect(screen.getByRole('button', { name: '复制结果' })).toBeDisabled()
  })

  it('shows parsing errors in the analysis tab and clears them on retry', async () => {
    const { user, input } = setup()
    await user.click(input)
    await user.paste('(["name":')
    await user.click(screen.getByRole('tab', { name: '深度解析' }))
    expect(screen.getByRole('alert')).toHaveTextContent('offset: 9')
    expect(screen.getByRole('alert')).toHaveTextContent('Expected LPC value')
    expect(screen.queryByRole('tree')).not.toBeInTheDocument()
    await user.clear(input)
    await user.paste('([])')
    await user.click(screen.getByRole('button', { name: '解析' }))
    expect(screen.queryByRole('alert')).not.toBeInTheDocument()
    expect(screen.getByRole('tree')).toBeInTheDocument()
  })
})
