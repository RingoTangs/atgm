import type { LpcAnalysisNode } from './buildLpcAnalysisTree'
import { formatLpc, LpcParseError, parseLpcValue } from '@atgm/lpc'
import { Alert, Button, Grid, Input, message, Radio } from 'antd'
import { useState } from 'react'
import { buildLpcAnalysisTree } from './buildLpcAnalysisTree'
import { LpcAnalysisView } from './LpcAnalysisView'

type LpcMode = 'format' | 'analysis'

export const LpcPage: React.FC = () => {
  const [mode, setMode] = useState<LpcMode>('format')
  const [analysis, setAnalysis] = useState<LpcAnalysisNode | null>(null)
  const [input, setInput] = useState('')
  const [output, setOutput] = useState('')
  const [error, setError] = useState<string | null>(null)
  const [messageApi, messageContext] = message.useMessage()
  const screens = Grid.useBreakpoint()

  const resetResults = () => {
    setOutput('')
    setAnalysis(null)
    setError(null)
  }

  const execute = () => {
    try {
      if (mode === 'format') setOutput(formatLpc(input))
      else setAnalysis(buildLpcAnalysisTree(parseLpcValue(input)))
      setError(null)
    } catch (cause) {
      if (mode === 'format') setOutput('')
      else setAnalysis(null)
      setError(
        cause instanceof LpcParseError
          ? `${cause.message} (offset: ${cause.offset})`
          : cause instanceof Error
            ? cause.message
            : mode === 'format'
              ? '格式化失败'
              : '解析失败',
      )
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
          <label htmlFor="lpc-input">原始 LPC</label>
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
          {error && (
            <div className="max-h-[20vh] shrink-0 overflow-auto">
              <Alert showIcon title={error} type="error" />
            </div>
          )}
          {mode === 'format' ? (
            <>
              <div className="flex items-center justify-between gap-2">
                <label htmlFor="lpc-output">格式化结果</label>
                <Button disabled={!output} onClick={() => void copy()}>
                  复制结果
                </Button>
              </div>
              <Input.TextArea
                id="lpc-output"
                className="min-h-0 flex-1"
                readOnly
                style={{
                  fontFamily: 'monospace',
                  resize: 'none',
                  overflow: 'auto',
                }}
                value={output}
              />
            </>
          ) : (
            <div className="min-h-0 flex-1 overflow-auto">
              {analysis ? (
                <LpcAnalysisView root={analysis} />
              ) : (
                <p>点击执行查看结果</p>
              )}
            </div>
          )}
        </section>
      </div>
    </div>
  )
}
