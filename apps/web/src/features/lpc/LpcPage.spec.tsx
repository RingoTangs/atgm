import { LpcParseError, parseLpcValue } from '@atgm/lpc'
import * as lpc from '@atgm/lpc'
import { cleanup, render, screen, within } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { ConfigProvider, theme } from 'antd'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { LpcPage } from './LpcPage'
import { installMatchMedia } from './lpcTestUtils'

const source = '(["name":"测试","items":({1,2,3,})])'
const formatted = `([
  "name": "测试",
  "items": ({
    1,
    2,
    3,
  }),
])`

const expectFormatEmpty = () => {
  const description = screen.getByText(
    '输入 LPC 内容后，点击「执行」查看格式化结果',
  )
  expect(description.closest('.ant-empty')).toHaveStyle({ margin: 'auto' })
  expect(description.closest('.ant-empty')?.parentElement).toHaveClass(
    'flex',
    'min-h-full',
  )
  expect(description.closest('.ant-empty')?.parentElement).toHaveStyle({
    boxSizing: 'border-box',
    borderStyle: 'solid',
    borderWidth: '1px',
  })
  expect(
    screen.queryByRole('textbox', { name: '格式化结果' }),
  ).not.toBeInTheDocument()
  expect(screen.getByRole('button', { name: '复制结果' })).toBeDisabled()
  expect(
    within(screen.getByRole('region', { name: '结果' })).queryByRole('alert'),
  ).not.toBeInTheDocument()
}

const setup = () => {
  const user = userEvent.setup()
  render(<LpcPage />)
  return {
    user,
    input: screen.getByLabelText('原始 LPC'),
    format: screen.getByRole('button', { name: '执行' }),
    copy: screen.getByRole('button', { name: '复制结果' }),
  }
}

beforeEach(() => {
  installMatchMedia()
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
  it.each([
    ['light', theme.defaultAlgorithm],
    ['dark', theme.darkAlgorithm],
  ] as const)(
    'matches the input border and background in the %s theme',
    (_name, algorithm) => {
      render(
        <ConfigProvider theme={{ algorithm }}>
          <LpcPage />
        </ConfigProvider>,
      )
      expectFormatEmpty()
      const placeholder = screen
        .getByText('输入 LPC 内容后，点击「执行」查看格式化结果')
        .closest('.ant-empty')!.parentElement!
      const token = theme.getDesignToken({ algorithm })
      expect(placeholder).toHaveStyle({
        borderColor: token.colorBorder,
        borderRadius: `${token.borderRadius}px`,
        backgroundColor: token.colorBgContainer,
      })
    },
  )

  it('shows an empty placeholder without executing on initial render', () => {
    const formatSpy = vi.spyOn(lpc, 'formatLpc')
    setup()
    expectFormatEmpty()
    expect(formatSpy).not.toHaveBeenCalled()
  })

  it('formats LPC without replacing the input and copies the readonly result', async () => {
    const { user, input, format, copy } = setup()
    expect(copy).toBeDisabled()
    const writeText = vi
      .spyOn(navigator.clipboard, 'writeText')
      .mockResolvedValue()
    await user.click(input)
    await user.paste(source)
    await user.click(format)
    expect(input).toHaveValue(source)
    expect(
      screen.queryByText('输入 LPC 内容后，点击「执行」查看格式化结果'),
    ).not.toBeInTheDocument()
    expect(screen.getByRole('textbox', { name: '格式化结果' })).toHaveStyle({
      overflow: 'auto',
      resize: 'none',
    })
    expect(screen.getByRole('textbox', { name: '格式化结果' })).toHaveValue(
      formatted,
    )
    expect(screen.getByRole('textbox', { name: '格式化结果' })).toHaveAttribute(
      'readonly',
    )
    expect(copy).toBeEnabled()
    await user.click(copy)
    expect(writeText).toHaveBeenCalledWith(formatted)
    expect(await screen.findByText('复制成功')).toBeInTheDocument()
    await user.click(screen.getByRole('button', { name: '清空' }))
    expect(input).toHaveValue('')
    expectFormatEmpty()
    expect(copy).toBeDisabled()
  })

  it('shows the parser message and offset, clears stale output, and clears all state', async () => {
    const { user, input, format, copy } = setup()
    await user.click(input)
    await user.paste(source)
    await user.click(format)
    await user.clear(input)
    expectFormatEmpty()
    expect(copy).toBeDisabled()
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
    expect(
      screen.queryByRole('textbox', { name: '格式化结果' }),
    ).not.toBeInTheDocument()
    expect(
      screen.queryByText('输入 LPC 内容后，点击「执行」查看格式化结果'),
    ).not.toBeInTheDocument()
    expect(screen.getByRole('alert')).toHaveTextContent('格式化失败')
    expect(
      screen.getByRole('alert').querySelector('.ant-result-error'),
    ).toBeInTheDocument()
    expect(copy).toBeDisabled()
    await user.click(screen.getByRole('button', { name: '清空' }))
    expect(input).toHaveValue('')
    expectFormatEmpty()
    expect(screen.queryByRole('alert')).not.toBeInTheDocument()
  })

  it('clears parsing errors when formatting succeeds again', async () => {
    const { user, input, format } = setup()
    await user.click(format)
    expect(screen.getByRole('alert')).toBeInTheDocument()
    await user.click(input)
    await user.paste(source)
    expect(screen.queryByRole('alert')).not.toBeInTheDocument()
    expectFormatEmpty()
    await user.click(format)
    expect(screen.queryByRole('alert')).not.toBeInTheDocument()
    expect(screen.getByLabelText('格式化结果')).toHaveValue(formatted)
  })

  it('reports clipboard failure while preserving the result', async () => {
    const { user, input, format, copy } = setup()
    vi.spyOn(navigator.clipboard, 'writeText').mockRejectedValue(
      new Error('Denied'),
    )
    await user.click(input)
    await user.paste(source)
    await user.click(format)
    await user.click(copy)
    expect(await screen.findByText('复制失败，请手动复制')).toBeInTheDocument()
    expect(screen.getByRole('textbox', { name: '格式化结果' })).toHaveValue(
      formatted,
    )
  })
})

describe('lpc analysis integration', () => {
  it('only executes the selected mode and preserves results when switching modes', async () => {
    const formatSpy = vi.spyOn(lpc, 'formatLpc')
    const parseSpy = vi.spyOn(lpc, 'parseLpcValue')
    const { user, input, format: execute } = setup()
    await user.click(input)
    await user.paste(source)
    await user.click(
      screen.getByRole('radio', { name: '深度解析' }).closest('label')!,
    )
    await user.click(
      screen.getByRole('radio', { name: '格式化' }).closest('label')!,
    )
    expect(formatSpy).not.toHaveBeenCalled()
    expect(parseSpy).not.toHaveBeenCalled()
    await user.click(execute)
    expect(formatSpy).toHaveBeenCalledExactlyOnceWith(source)
    expect(parseSpy).not.toHaveBeenCalled()
    await user.click(
      screen.getByRole('radio', { name: '深度解析' }).closest('label')!,
    )
    expect(screen.queryByRole('tree')).not.toBeInTheDocument()
    expect(parseSpy).not.toHaveBeenCalled()
    await user.click(execute)
    expect(parseSpy).toHaveBeenCalledExactlyOnceWith(source)
    expect(formatSpy).toHaveBeenCalledTimes(1)
    await user.click(
      screen.getByRole('radio', { name: '格式化' }).closest('label')!,
    )
    expect(screen.getByLabelText('格式化结果')).toHaveValue(formatted)
    await user.click(
      screen.getByRole('radio', { name: '深度解析' }).closest('label')!,
    )
    expect(screen.getByRole('tree')).toBeInTheDocument()
    expect(parseSpy).toHaveBeenCalledTimes(1)
    await user.type(input, ' ')
    expect(screen.queryByRole('tree')).not.toBeInTheDocument()
    await user.click(
      screen.getByRole('radio', { name: '格式化' }).closest('label')!,
    )
    expectFormatEmpty()
    expect(screen.getByRole('button', { name: '复制结果' })).toBeDisabled()
    expect(formatSpy).toHaveBeenCalledTimes(1)
    expect(parseSpy).toHaveBeenCalledTimes(1)
  })

  it('clears both cached results while retaining the selected mode', async () => {
    const { user, input, format: execute } = setup()
    await user.click(input)
    await user.paste(source)
    await user.click(execute)
    await user.click(
      screen.getByRole('radio', { name: '深度解析' }).closest('label')!,
    )
    await user.click(execute)
    await user.click(screen.getByRole('button', { name: '清空' }))
    expect(input).toHaveValue('')
    expect(screen.getByRole('radio', { name: '深度解析' })).toBeChecked()
    expect(screen.queryByRole('tree')).not.toBeInTheDocument()
    await user.click(
      screen.getByRole('radio', { name: '格式化' }).closest('label')!,
    )
    expectFormatEmpty()
    expect(screen.getByRole('button', { name: '复制结果' })).toBeDisabled()
  })

  it('executes analysis explicitly, preserves input and clears both results after editing', async () => {
    const { user, input } = setup()
    await user.click(input)
    await user.paste('(["me":(["level":33,]),])')
    await user.click(
      screen.getByRole('radio', { name: '深度解析' }).closest('label')!,
    )
    expect(screen.queryByRole('tree')).not.toBeInTheDocument()
    await user.click(screen.getByRole('button', { name: '执行' }))
    expect(screen.getByRole('tree')).toBeInTheDocument()
    await user.click(screen.getByText('level', { exact: true }))
    expect(screen.getByText('$.me.level')).toBeInTheDocument()
    expect(input).toHaveValue('(["me":(["level":33,]),])')
    await user.clear(input)
    await user.paste('({2,})')
    expect(screen.queryByRole('tree')).not.toBeInTheDocument()
    expect(
      screen.getByText('输入 LPC 内容后，点击「执行」查看解析树'),
    ).toBeInTheDocument()
    await user.click(screen.getByRole('button', { name: '执行' }))
    expect(screen.getByRole('tree')).toBeInTheDocument()
    await user.click(screen.getByText('root', { exact: true }))
    expect(screen.getByText('Array')).toBeInTheDocument()
    await user.click(screen.getByRole('button', { name: '清空' }))
    expect(input).toHaveValue('')
    expect(screen.queryByRole('tree')).not.toBeInTheDocument()
    expect(screen.queryByRole('alert')).not.toBeInTheDocument()
    await user.click(
      screen.getByRole('radio', { name: '格式化' }).closest('label')!,
    )
    expectFormatEmpty()
    expect(screen.getByRole('button', { name: '复制结果' })).toBeDisabled()
  })

  it('shows parsing errors in the analysis tab and clears them on retry', async () => {
    const { user, input } = setup()
    await user.click(input)
    await user.paste('(["name":')
    await user.click(
      screen.getByRole('radio', { name: '深度解析' }).closest('label')!,
    )
    expect(screen.queryByRole('alert')).not.toBeInTheDocument()
    await user.click(screen.getByRole('button', { name: '执行' }))
    expect(screen.getByRole('alert')).toHaveTextContent('解析失败')
    expect(
      screen.getByRole('alert').querySelector('.ant-result-error'),
    ).toBeInTheDocument()
    expect(screen.getByRole('alert')).toHaveTextContent('offset: 9')
    expect(screen.getByRole('alert')).toHaveTextContent('Expected LPC value')
    expect(screen.queryByRole('tree')).not.toBeInTheDocument()
    await user.clear(input)
    expect(screen.queryByRole('alert')).not.toBeInTheDocument()
    await user.paste('([])')
    await user.click(screen.getByRole('button', { name: '执行' }))
    expect(screen.queryByRole('alert')).not.toBeInTheDocument()
    expect(screen.getByRole('tree')).toBeInTheDocument()
  })
})

describe('lpc workspace layout', () => {
  it.each([767, 768, 1599, 1600])(
    'adapts the workspace at width %s',
    (width) => {
      installMatchMedia(width)
      setup()
      expect(screen.getByLabelText('LPC 工作台')).toHaveStyle({
        gridTemplateColumns:
          width >= 768 ? 'minmax(0, 2fr) minmax(0, 3fr)' : 'minmax(0, 1fr)',
      })
      expect(screen.getByRole('region', { name: '输入' })).toHaveClass(
        'h-[60vh]',
        'min-h-0',
        'min-w-0',
      )
      expect(screen.getByRole('region', { name: '结果' })).toHaveClass(
        'h-[60vh]',
        'min-h-0',
        'min-w-0',
      )
      expect(screen.getByRole('textbox', { name: '原始 LPC' })).toHaveStyle({
        overflow: 'auto',
        resize: 'none',
      })
      expectFormatEmpty()
    },
  )

  it('switches between desktop columns and mobile rows on resize', () => {
    const resize = installMatchMedia(768)
    setup()
    resize(767)
    expect(screen.getByLabelText('LPC 工作台')).toHaveStyle({
      gridTemplateColumns: 'minmax(0, 1fr)',
    })
    resize(1600)
    expect(screen.getByLabelText('LPC 工作台')).toHaveStyle({
      gridTemplateColumns: 'minmax(0, 2fr) minmax(0, 3fr)',
    })
  })
})

describe('lpc result states', () => {
  const selectMode = async (
    user: ReturnType<typeof userEvent.setup>,
    name: string,
  ) => {
    await user.click(screen.getByRole('radio', { name }).closest('label')!)
  }
  const expectAnalysisEmpty = () => {
    const description = screen.getByText(
      '输入 LPC 内容后，点击「执行」查看解析树',
    )
    expect(screen.getByRole('heading', { name: '解析树' })).toBeInTheDocument()
    expect(
      description.closest('.ant-card')?.querySelector('.ant-card-head'),
    ).not.toBeInTheDocument()
    expect(description.closest('.ant-empty')).toHaveStyle({ margin: 'auto' })
    expect(description.closest('.ant-card-body')).toHaveStyle({
      display: 'flex',
      flex: '1',
      minHeight: '0',
      overflow: 'auto',
    })
    expect(screen.queryByRole('tree')).not.toBeInTheDocument()
    expect(screen.queryByRole('alert')).not.toBeInTheDocument()
  }

  it('shows a centered Card and Empty before executing analysis', async () => {
    const parseSpy = vi.spyOn(lpc, 'parseLpcValue')
    const { user } = setup()
    await selectMode(user, '深度解析')
    expectAnalysisEmpty()
    expect(parseSpy).not.toHaveBeenCalled()
  })

  it.each(['格式化', '深度解析'])(
    'retains independent errors when %s succeeds',
    async (successfulMode) => {
      const formatSpy = vi
        .spyOn(lpc, 'formatLpc')
        .mockImplementationOnce(() => {
          throw new Error('formatter failure')
        })
      const parseSpy = vi
        .spyOn(lpc, 'parseLpcValue')
        .mockImplementationOnce(() => {
          throw new Error('parser failure')
        })
      const { user, input, format: execute } = setup()
      await user.click(input)
      await user.paste(source)
      await user.click(execute)
      expect(screen.getByRole('alert')).toHaveTextContent('formatter failure')
      await selectMode(user, '深度解析')
      expectAnalysisEmpty()
      await user.click(execute)
      expect(screen.getByRole('alert')).toHaveTextContent('parser failure')
      await selectMode(user, '格式化')
      expect(screen.getByRole('alert')).toHaveTextContent('formatter failure')
      expect(screen.getByRole('alert')).not.toHaveTextContent('parser failure')
      expect(formatSpy).toHaveBeenCalledTimes(1)
      expect(parseSpy).toHaveBeenCalledTimes(1)
      await selectMode(user, successfulMode)
      await user.click(execute)
      expect(screen.queryByRole('alert')).not.toBeInTheDocument()
      if (successfulMode === '格式化') {
        expect(screen.getByLabelText('格式化结果')).toHaveValue(formatted)
        expect(screen.getByRole('button', { name: '复制结果' })).toBeEnabled()
      } else {
        expect(screen.getByRole('tree')).toBeInTheDocument()
      }
      const otherMode = successfulMode === '格式化' ? '深度解析' : '格式化'
      await selectMode(user, otherMode)
      expect(screen.getByRole('alert')).toHaveTextContent(
        otherMode === '格式化' ? 'formatter failure' : 'parser failure',
      )
      await user.type(input, ' ')
      expect(screen.queryByRole('alert')).not.toBeInTheDocument()
      await selectMode(user, '深度解析')
      expectAnalysisEmpty()
      await selectMode(user, '格式化')
      expect(screen.queryByRole('alert')).not.toBeInTheDocument()
      expectFormatEmpty()
      expect(screen.getByRole('button', { name: '复制结果' })).toBeDisabled()
    },
  )

  it('clears both errors and restores empty results', async () => {
    const { user, input, format: execute } = setup()
    await user.click(execute)
    await selectMode(user, '深度解析')
    await user.click(execute)
    expect(screen.getByRole('alert')).toHaveTextContent('解析失败')
    await user.click(screen.getByRole('button', { name: '清空' }))
    expect(input).toHaveValue('')
    expectAnalysisEmpty()
    await selectMode(user, '格式化')
    expect(screen.queryByRole('alert')).not.toBeInTheDocument()
    expectFormatEmpty()
    expect(screen.getByRole('button', { name: '复制结果' })).toBeDisabled()
  })

  it.each([
    [767, '格式化'],
    [768, '格式化'],
    [767, '深度解析'],
    [768, '深度解析'],
  ] as const)(
    'keeps the same result content space across empty, error and success at %s in %s',
    async (width, mode) => {
      installMatchMedia(width)
      vi.spyOn(
        lpc,
        mode === '格式化' ? 'formatLpc' : 'parseLpcValue',
      ).mockImplementationOnce(() => {
        throw new Error('failure with long details '.repeat(100))
      })
      const { user, input, format: execute } = setup()
      await user.click(input)
      await user.paste(source)
      await selectMode(user, mode)
      const region = screen.getByRole('region', { name: '结果' })
      const initialClass = region.className
      const content = region.lastElementChild!
      const contentClass = content.className
      expect(region).toHaveClass('h-[60vh]', 'min-h-0', 'min-w-0')
      expect(content).toHaveClass('min-h-0', 'flex-1', 'overflow-auto')
      await user.click(execute)
      expect(within(region).getByRole('alert')).toHaveTextContent(
        mode === '格式化' ? '格式化失败' : '解析失败',
      )
      expect(region.className).toBe(initialClass)
      expect(region.lastElementChild).toBe(content)
      expect(content.className).toBe(contentClass)
      expect(region.querySelector('.ant-alert')).not.toBeInTheDocument()
      await user.click(execute)
      expect(within(region).queryByRole('alert')).not.toBeInTheDocument()
      expect(region.className).toBe(initialClass)
      expect(region.lastElementChild).toBe(content)
      expect(content.className).toBe(contentClass)
      if (mode === '格式化')
        expect(screen.getByLabelText('格式化结果')).toHaveValue(formatted)
      else expect(screen.getByRole('tree')).toBeInTheDocument()
    },
  )
})

describe('workspace title alignment', () => {
  it.each([
    [767, '格式化'],
    [768, '格式化'],
    [1600, '格式化'],
    [767, '深度解析'],
    [768, '深度解析'],
    [1600, '深度解析'],
  ] as const)(
    'keeps aligned external titles in every state at %s in %s',
    async (width, mode) => {
      installMatchMedia(width)
      const { user, input, format: execute } = setup()
      await user.click(
        screen.getByRole('radio', { name: mode }).closest('label')!,
      )
      const assertTitles = () => {
        const inputTitle = screen.getByText('原始 LPC', { exact: true })
        const resultTitle =
          mode === '格式化'
            ? screen.getByText('格式化结果', { exact: true })
            : screen.getByRole('heading', { name: '解析树' })
        for (const title of [inputTitle, resultTitle]) {
          expect(title).toHaveClass('text-base', 'font-normal', 'leading-6')
          const header = title.tagName === 'H2' ? title : title.parentElement!
          expect(header).toHaveClass('flex', 'h-8', 'shrink-0', 'items-center')
          expect(header.parentElement).toHaveClass('gap-2')
          expect(title.closest('.ant-card')).toBeNull()
        }
        expect(
          screen
            .getByRole('region', { name: '结果' })
            .querySelector('.ant-card-head'),
        ).not.toBeInTheDocument()
        expect(screen.getByRole('region', { name: '结果' })).toHaveClass(
          'h-[60vh]',
        )
      }
      assertTitles()
      await user.click(execute)
      expect(screen.getByRole('alert')).toBeInTheDocument()
      assertTitles()
      await user.click(screen.getByRole('button', { name: '清空' }))
      assertTitles()
      await user.click(input)
      await user.paste(source)
      await user.click(execute)
      expect(screen.queryByRole('alert')).not.toBeInTheDocument()
      assertTitles()
      if (mode === '深度解析' && width === 1600) {
        expect(screen.getByRole('heading', { name: '节点详情' })).toHaveClass(
          'h-8',
          'shrink-0',
          'items-center',
          'text-base',
          'font-normal',
          'leading-6',
        )
      }
    },
  )
})
