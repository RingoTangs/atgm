import type { LpcAnalysisNode } from './buildLpcAnalysisTree'
import { formatLpc, LpcParseError, parseLpcValue } from '@atgm/lpc'
import {
  Button,
  Card,
  Empty,
  Grid,
  Input,
  message,
  Radio,
  Result,
  theme,
} from 'antd'
import { useState } from 'react'
import { buildLpcAnalysisTree } from './buildLpcAnalysisTree'
import { LpcAnalysisView } from './LpcAnalysisView'

type LpcMode = 'format' | 'analysis'

interface LpcError {
  mode: LpcMode
  message: string
}

export const LpcPage: React.FC = () => {
  const [mode, setMode] = useState<LpcMode>('format')
  const [analysis, setAnalysis] = useState<LpcAnalysisNode | null>(null)
  const [input, setInput] = useState('')
  const [output, setOutput] = useState('')
  const [errors, setErrors] = useState<Partial<Record<LpcMode, LpcError>>>({})
  const [messageApi, messageContext] = message.useMessage()
  const screens = Grid.useBreakpoint()
  const { token } = theme.useToken()
  const error = errors[mode]

  const resetResults = () => {
    setOutput('')
    setAnalysis(null)
    setErrors({})
  }

  const execute = () => {
    try {
      if (mode === 'format') setOutput(formatLpc(input))
      else setAnalysis(buildLpcAnalysisTree(parseLpcValue(input)))
      setErrors((previous) => ({ ...previous, [mode]: undefined }))
    } catch (cause) {
      if (mode === 'format') setOutput('')
      else setAnalysis(null)
      const errorMessage =
        cause instanceof LpcParseError
          ? `${cause.message} (offset: ${cause.offset})`
          : cause instanceof Error
            ? cause.message
            : mode === 'format'
              ? '格式化失败'
              : '解析失败'
      setErrors((previous) => ({
        ...previous,
        [mode]: { mode, message: errorMessage },
      }))
    }
  }

  const copy = async () => {
    try {
      await navigator.clipboard.writeText(output)
      void messageApi.success('复制成功')
    } catch {
      void messageApi.error('复制失败，请手动复制')
    }
  }

  const errorResult = error && (
    <div role="alert" className="flex min-h-full w-full min-w-0">
      <Result
        className="m-auto w-full min-w-0 shrink-0"
        status="error"
        title={error.mode === 'format' ? '格式化失败' : '解析失败'}
        subTitle={
          <p className="break-all whitespace-pre-wrap">{error.message}</p>
        }
      />
    </div>
  )

  return (
    <div className="space-y-4">
      {messageContext}
      <h1 className="text-2xl font-semibold">LPC</h1>
      <div className="flex flex-wrap items-center gap-2">
        <Radio.Group
          aria-label="执行模式"
          value={mode}
          onChange={(event) => setMode(event.target.value as LpcMode)}
        >
          <Radio.Button value="format">格式化</Radio.Button>
          <Radio.Button value="analysis">深度解析</Radio.Button>
        </Radio.Group>
        <Button aria-label="执行" onClick={execute} type="primary">
          执行
        </Button>
        <Button
          aria-label="清空"
          onClick={() => {
            setInput('')
            resetResults()
          }}
        >
          清空
        </Button>
      </div>
      <div
        aria-label="LPC 工作台"
        className="grid min-w-0 gap-4"
        style={{
          gridTemplateColumns: screens.md
            ? 'minmax(0, 2fr) minmax(0, 3fr)'
            : 'minmax(0, 1fr)',
        }}
      >
        <section
          aria-label="输入"
          className="flex h-[60vh] min-h-0 min-w-0 flex-col gap-2"
        >
          <div className="flex h-8 shrink-0 items-center">
            <label
              htmlFor="lpc-input"
              className="text-base leading-6 font-normal"
            >
              原始 LPC
            </label>
          </div>
          <Input.TextArea
            id="lpc-input"
            className="min-h-0 flex-1"
            onChange={(event) => {
              setInput(event.target.value)
              resetResults()
            }}
            style={{
              fontFamily: 'monospace',
              resize: 'none',
              overflow: 'auto',
            }}
            value={input}
          />
        </section>
        <section
          aria-label="结果"
          className="flex h-[60vh] min-h-0 min-w-0 flex-col gap-2"
        >
          {mode === 'format' ? (
            <>
              <div className="flex h-8 shrink-0 items-center justify-between gap-2">
                <label
                  className="text-base leading-6 font-normal"
                  htmlFor={!error && output ? 'lpc-output' : undefined}
                >
                  格式化结果
                </label>
                <Button disabled={!output} onClick={() => void copy()}>
                  复制结果
                </Button>
              </div>
              <div className="min-h-0 flex-1 overflow-auto">
                {error ? (
                  errorResult
                ) : output ? (
                  <Input.TextArea
                    id="lpc-output"
                    className="h-full min-h-0"
                    readOnly
                    style={{
                      fontFamily: 'monospace',
                      resize: 'none',
                      overflow: 'auto',
                    }}
                    value={output}
                  />
                ) : (
                  <div
                    className="flex min-h-full min-w-0"
                    style={{
                      boxSizing: 'border-box',
                      borderWidth: token.lineWidth,
                      borderStyle: token.lineType,
                      borderColor: token.colorBorder,
                      borderRadius: token.borderRadius,
                      backgroundColor: token.colorBgContainer,
                    }}
                  >
                    <Empty
                      style={{ margin: 'auto' }}
                      description="输入 LPC 内容后，点击「执行」查看格式化结果"
                    />
                  </div>
                )}
              </div>
            </>
          ) : (
            <div className="min-h-0 flex-1 overflow-auto">
              {!error && analysis ? (
                <LpcAnalysisView root={analysis} />
              ) : (
                <div className="flex h-full min-h-0 min-w-0 flex-col gap-2">
                  <h2 className="flex h-8 shrink-0 items-center text-base leading-6 font-normal">
                    解析树
                  </h2>
                  <Card
                    className="flex min-h-0 min-w-0 flex-1 flex-col"
                    styles={{
                      body: {
                        display: 'flex',
                        flex: 1,
                        minHeight: 0,
                        overflow: 'auto',
                      },
                    }}
                  >
                    {error ? (
                      errorResult
                    ) : (
                      <Empty
                        style={{ margin: 'auto' }}
                        description="输入 LPC 内容后，点击「执行」查看解析树"
                      />
                    )}
                  </Card>
                </div>
              )}
            </div>
          )}
        </section>
      </div>
    </div>
  )
}
