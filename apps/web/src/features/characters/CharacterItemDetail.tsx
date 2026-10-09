import { formatLpc, parseLpcValue } from '@atgm/lpc'
import { useQuery } from '@tanstack/react-query'
import {
  Alert,
  Button,
  Descriptions,
  Drawer,
  Grid,
  Input,
  message,
  Spin,
  Tabs,
} from 'antd'
import { useMemo } from 'react'
import { buildLpcAnalysisTree } from '@/features/lpc/buildLpcAnalysisTree'
import { LpcAnalysisView } from '@/features/lpc/LpcAnalysisView'
import { characterItemDetailQueryOptions } from './characters-queries'

export function CharacterItemDetail({
  gid,
  entryKey,
  onClose,
}: {
  gid: string
  entryKey: number
  onClose: () => void
}) {
  const query = useQuery(characterItemDetailQueryOptions(gid, entryKey))
  const screens = Grid.useBreakpoint()
  const [messageApi, context] = message.useMessage()
  const detail = query.data
  const analysis = useMemo(
    () =>
      detail
        ? {
            root: buildLpcAnalysisTree(parseLpcValue(detail.lpc)),
            formatted: formatLpc(detail.lpc),
          }
        : null,
    [detail],
  )
  const copy = async () => {
    if (!detail) return
    try {
      await navigator.clipboard.writeText(detail.lpc)
      void messageApi.success('复制成功')
    } catch {
      void messageApi.error('复制失败，请手动复制')
    }
  }
  return (
    <Drawer
      title="物品详情"
      open
      size={screens.md ? 800 : '100%'}
      onClose={onClose}
      closable={{ 'aria-label': '关闭物品详情' }}
    >
      {context}
      {query.isPending && (
        <Spin tip="加载中">
          <div className="h-32" />
        </Spin>
      )}
      {query.isError && (
        <Alert
          type="error"
          showIcon
          title="物品详情加载失败"
          description={query.error.message}
          action={
            <Button aria-label="重试" onClick={() => void query.refetch()}>
              重试
            </Button>
          }
        />
      )}
      {detail && analysis && (
        <div className="space-y-4">
          <Descriptions
            bordered
            column={1}
            items={[
              { key: 'name', label: '物品名称', children: detail.name },
              { key: 'alias', label: '别名', children: detail.alias || '-' },
              { key: 'entryKey', label: '记录 Key', children: detail.entryKey },
            ]}
          />
          <Tabs
            defaultActiveKey="analysis"
            items={[
              {
                key: 'analysis',
                label: '属性解析',
                children: <LpcAnalysisView root={analysis.root} />,
              },
              {
                key: 'raw',
                label: '原始 LPC',
                children: (
                  <div className="space-y-4">
                    <Button onClick={() => void copy()}>复制原始 LPC</Button>
                    <Input.TextArea
                      aria-label="原始 LPC"
                      readOnly
                      value={analysis.formatted}
                      autoSize={{ minRows: 12 }}
                    />
                  </div>
                ),
              },
            ]}
          />
        </div>
      )}
    </Drawer>
  )
}
