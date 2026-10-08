import { formatLpc, LpcParseError } from '@atgm/lpc'
import { Alert, Button, Input, message } from 'antd'
import { useState } from 'react'

export const LpcFormatterPage: React.FC = () => {
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
      <h1 className="text-2xl font-semibold">LPC 格式化</h1>
      <div className="space-y-2">
        <label htmlFor="lpc-input">原始 LPC</label>
        <Input.TextArea
          id="lpc-input"
          onChange={(event) => setInput(event.target.value)}
          rows={10}
          style={{ fontFamily: 'monospace' }}
          value={input}
        />
      </div>
      <div className="flex gap-2">
        <Button onClick={format} type="primary">
          格式化
        </Button>
        <Button
          aria-label="清空"
          onClick={() => {
            setInput('')
            setOutput('')
            setError(null)
          }}
        >
          清空
        </Button>
      </div>
      {error && <Alert showIcon title={error} type="error" />}
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
  )
}
