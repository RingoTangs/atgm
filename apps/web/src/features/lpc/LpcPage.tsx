import type { LpcAnalysisNode } from './buildLpcAnalysisTree'
import { formatLpc, LpcParseError, parseLpcValue } from '@atgm/lpc'
import { Alert, Button, Input, message, Tabs } from 'antd'
import { useState } from 'react'
import { buildLpcAnalysisTree } from './buildLpcAnalysisTree'
import { LpcAnalysisView } from './LpcAnalysisView'

export const LpcPage: React.FC = () => {
  const [activeTab, setActiveTab] = useState('format')
  const [analysis, setAnalysis] = useState<LpcAnalysisNode | null>(null)
  const [input, setInput] = useState('')
  const [output, setOutput] = useState('')
  const [error, setError] = useState<string | null>(null)
  const [messageApi, messageContext] = message.useMessage()

  const format = () => {
    try {
      setOutput(formatLpc(input))
      setError(null)
    } catch (cause) {
      setOutput('')
      setError(
        cause instanceof LpcParseError
          ? `${cause.message} (offset: ${cause.offset})`
          : cause instanceof Error
            ? cause.message
            : '格式化失败',
      )
    }
  }

  const analyze = () => {
    try {
      setAnalysis(buildLpcAnalysisTree(parseLpcValue(input)))
      setError(null)
    } catch (cause) {
      setAnalysis(null)
      setError(
        cause instanceof LpcParseError
          ? `${cause.message} (offset: ${cause.offset})`
          : cause instanceof Error
            ? cause.message
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
    <div className="space-y-6">
      {messageContext}
      <h1 className="text-2xl font-semibold">LPC</h1>
      <div className="space-y-2">
        <label htmlFor="lpc-input">原始 LPC</label>
        <Input.TextArea
          id="lpc-input"
          onChange={(event) => {
            setInput(event.target.value)
            setAnalysis(null)
          }}
          rows={10}
          style={{ fontFamily: 'monospace' }}
          value={input}
        />
      </div>
      <div className="flex gap-2">
        <Button
          aria-label={activeTab === 'format' ? '格式化' : '解析'}
          onClick={activeTab === 'format' ? format : analyze}
          type="primary"
        >
          {activeTab === 'format' ? '格式化' : '解析'}
        </Button>
        <Button
          aria-label="清空"
          onClick={() => {
            setInput('')
            setOutput('')
            setAnalysis(null)
            setError(null)
          }}
        >
          清空
        </Button>
      </div>
      {error && <Alert showIcon title={error} type="error" />}
      <Tabs
        activeKey={activeTab}
        onTabClick={(key) => {
          if (key === 'analysis' && key === activeTab) analyze()
        }}
        onChange={(key) => {
          setActiveTab(key)
          if (key === 'analysis') analyze()
        }}
        items={[
          {
            key: 'format',
            label: '格式化',
            children: (
              <div className="space-y-4">
                <div className="space-y-2">
                  <label htmlFor="lpc-output">格式化结果</label>
                  <Input.TextArea
                    id="lpc-output"
                    readOnly
                    rows={10}
                    style={{ fontFamily: 'monospace' }}
                    value={output}
                  />
                </div>
                <Button disabled={!output} onClick={() => void copy()}>
                  复制结果
                </Button>
              </div>
            ),
          },
          {
            key: 'analysis',
            label: '深度解析',
            children: analysis ? (
              <LpcAnalysisView root={analysis} />
            ) : (
              <p>点击解析查看结果</p>
            ),
          },
        ]}
      />
    </div>
  )
}
