import type { LpcMappingKey, LpcValue } from '@atgm/lpc'
import { parseEmbeddedLpc } from '@atgm/lpc'

export type LpcAnalysisKind =
  'mapping' | 'array' | 'string' | 'number' | 'special' | 'embedded'

export interface LpcAnalysisNode {
  id: string
  path: string
  label: string
  kind: LpcAnalysisKind
  value?: string | number
  prefix?: string
  source?: string
  children?: LpcAnalysisNode[]
}

function mappingPath(path: string, key: LpcMappingKey): string {
  if (typeof key === 'number') return `${path}[${key}]`
  if (/^[a-z_$][\w$]*$/i.test(key)) return `${path}.${key}`
  return `${path}[${JSON.stringify(key)}]`
}

function buildNode(
  value: LpcValue,
  path: string,
  label: string,
  allowEmbedded: boolean,
): LpcAnalysisNode {
  const node = { id: path, path, label }
  if (value instanceof Map) {
    return {
      ...node,
      kind: 'mapping',
      children: Array.from(value, ([key, child]) =>
        buildNode(child, mappingPath(path, key), String(key), allowEmbedded),
      ),
    }
  }
  if (Array.isArray(value)) {
    return {
      ...node,
      kind: 'array',
      children: value.map((child, index) =>
        buildNode(child, `${path}[${index}]`, `[${index}]`, allowEmbedded),
      ),
    }
  }
  if (typeof value === 'string') {
    const embedded = allowEmbedded ? parseEmbeddedLpc(value) : null
    if (embedded) {
      return {
        ...node,
        kind: 'embedded',
        value,
        prefix: embedded.prefix,
        source: embedded.source,
        children: [
          buildNode(embedded.value, `${path}.embedded`, 'embedded', false),
        ],
      }
    }
    return { ...node, kind: 'string', value }
  }
  if (typeof value === 'number') return { ...node, kind: 'number', value }
  return { ...node, kind: 'special', value: `:${value.value}:` }
}

export function buildLpcAnalysisTree(value: LpcValue): LpcAnalysisNode {
  return buildNode(value, '$', 'root', true)
}
