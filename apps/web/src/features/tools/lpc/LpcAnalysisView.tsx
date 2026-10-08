import type { TreeProps } from 'antd'
import type { LpcAnalysisKind, LpcAnalysisNode } from './buildLpcAnalysisTree'
import {
  Button,
  Card,
  Descriptions,
  message,
  Tag,
  Tree,
  Typography,
} from 'antd'
import { useMemo, useState } from 'react'

interface LpcAnalysisViewProps {
  root: LpcAnalysisNode
}

const kindLabels: Record<LpcAnalysisKind, string> = {
  mapping: 'Mapping',
  array: 'Array',
  string: 'String',
  number: 'Number',
  special: 'Special',
  embedded: 'Embedded LPC',
}

function visibleChildren(node: LpcAnalysisNode): LpcAnalysisNode[] {
  return node.kind === 'embedded'
    ? (node.children?.[0]?.children ?? [])
    : (node.children ?? [])
}

function shortValue(value: string | number): string {
  const text = String(value)
  return text.length > 60 ? `${text.slice(0, 60)}…` : text
}

function nodeTitle(node: LpcAnalysisNode) {
  return (
    <span className="inline-flex items-center gap-2">
      <span>{node.label}</span>
      {node.kind === 'embedded' ? (
        <>
          <Typography.Text type="secondary">
            {shortValue((node.prefix ?? '').replace(/:$/, ''))}
          </Typography.Text>
          <Tag>Embedded</Tag>
        </>
      ) : node.value !== undefined ? (
        <Typography.Text type="secondary">
          {shortValue(node.value)}
        </Typography.Text>
      ) : (
        <Typography.Text type="secondary">
          ({node.children?.length ?? 0})
        </Typography.Text>
      )}
    </span>
  )
}

function treeData(
  node: LpcAnalysisNode,
): NonNullable<TreeProps['treeData']>[number] {
  return {
    key: node.id,
    title: nodeTitle(node),
    children: visibleChildren(node).map(treeData),
  }
}

function initialExpanded(root: LpcAnalysisNode): string[] {
  return [root, ...visibleChildren(root)]
    .filter(
      (node) => node.kind !== 'embedded' && visibleChildren(node).length > 0,
    )
    .map((node) => node.id)
}

export const LpcAnalysisView: React.FC<LpcAnalysisViewProps> = ({ root }) => {
  const [state, setState] = useState(() => ({
    root,
    selected: root,
    expanded: initialExpanded(root),
  }))
  if (state.root !== root) {
    setState({ root, selected: root, expanded: initialExpanded(root) })
  }
  const [messageApi, messageContext] = message.useMessage()
  const nodes = useMemo(() => {
    const result = new Map<string, LpcAnalysisNode>()
    const visit = (node: LpcAnalysisNode) => {
      result.set(node.id, node)
      visibleChildren(node).forEach(visit)
    }
    visit(root)
    return result
  }, [root])
  const data = useMemo(() => [treeData(root)], [root])
  const selected = state.selected
  const text = (value: string | number) => (
    <Typography.Text className="break-all whitespace-pre-wrap">
      {value}
    </Typography.Text>
  )
  const items = [
    { key: 'kind', label: '类型', children: kindLabels[selected.kind] },
    { key: 'path', label: 'Path', children: text(selected.path) },
  ]
  if (selected.kind === 'mapping' || selected.kind === 'array') {
    items.push({
      key: 'count',
      label: selected.kind === 'mapping' ? '条目数' : '元素数',
      children: text(selected.children?.length ?? 0),
    })
  } else if (selected.kind === 'embedded') {
    items.push(
      { key: 'prefix', label: '前缀', children: text(selected.prefix ?? '') },
      { key: 'value', label: '原始值', children: text(selected.value ?? '') },
      {
        key: 'payload',
        label: 'Payload 类型',
        children: kindLabels[selected.children?.[0]?.kind ?? 'mapping'],
      },
      { key: 'source', label: 'Source', children: text(selected.source ?? '') },
    )
  } else {
    items.push({
      key: 'value',
      label: '值',
      children: text(selected.value ?? ''),
    })
  }

  const copy = async (value: string | number) => {
    try {
      await navigator.clipboard.writeText(String(value))
      void messageApi.success('复制成功')
    } catch {
      void messageApi.error('复制失败，请手动复制')
    }
  }

  return (
    <div className="grid min-w-0 gap-4 lg:grid-cols-2">
      {messageContext}
      <Card title="解析树" className="min-w-0">
        <div className="overflow-x-auto">
          <Tree
            treeData={data}
            virtual={false}
            expandedKeys={state.expanded}
            selectedKeys={[selected.id]}
            onExpand={(keys) =>
              setState((previous) => ({
                ...previous,
                expanded: keys.map(String),
              }))
            }
            onSelect={(keys) => {
              const node = nodes.get(String(keys[0]))
              if (node)
                setState((previous) => ({ ...previous, selected: node }))
            }}
          />
        </div>
      </Card>
      <Card title="节点详情" className="min-w-0">
        <Descriptions column={1} items={items} />
        <div className="mt-4 flex gap-2">
          <Button onClick={() => void copy(selected.path)}>复制 Path</Button>
          <Button
            disabled={selected.value === undefined}
            onClick={() => {
              if (selected.value !== undefined) void copy(selected.value)
            }}
          >
            复制值
          </Button>
        </div>
      </Card>
    </div>
  )
}
