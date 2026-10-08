import type { LpcValue } from '@atgm/lpc'
import type { LpcAnalysisNode } from './buildLpcAnalysisTree'
import { parseLpcValue } from '@atgm/lpc'
import { describe, expect, it } from 'vitest'
import { buildLpcAnalysisTree } from './buildLpcAnalysisTree'

function flatten(node: LpcAnalysisNode): LpcAnalysisNode[] {
  return [node, ...(node.children ?? []).flatMap(flatten)]
}

function byPath(root: LpcAnalysisNode, path: string): LpcAnalysisNode {
  const node = flatten(root).find((item) => item.path === path)
  if (!node) throw new Error(`Missing path: ${path}`)
  return node
}

describe('lpc analysis tree', () => {
  it.each([
    ['text', 'string', 'text'],
    ['', 'string', ''],
    [33, 'number', 33],
    [-20, 'number', -20],
    [12.5, 'number', 12.5],
    [
      { type: 'special', value: '6ABD337600010147A4F4' },
      'special',
      ':6ABD337600010147A4F4:',
    ],
  ] as const)('converts scalar %s', (value, kind, expected) => {
    expect(buildLpcAnalysisTree(value)).toEqual({
      id: '$',
      path: '$',
      label: 'root',
      kind,
      value: expected,
    })
  })

  it('preserves mapping order and builds nested paths and labels', () => {
    const value: LpcValue = new Map<string | number, LpcValue>([
      [
        'me',
        new Map<string, LpcValue>([
          ['level', 33],
          ['items', ['item', -20]],
        ]),
      ],
      [103, 'item'],
    ])
    const root = buildLpcAnalysisTree(value)
    expect(root).toMatchObject({
      id: '$',
      path: '$',
      label: 'root',
      kind: 'mapping',
    })
    expect(root.children?.map((node) => node.label)).toEqual(['me', '103'])
    expect(flatten(root).map((node) => node.path)).toEqual([
      '$',
      '$.me',
      '$.me.level',
      '$.me.items',
      '$.me.items[0]',
      '$.me.items[1]',
      '$[103]',
    ])
    expect(byPath(root, '$.me.items')).toMatchObject({ kind: 'array' })
    expect(byPath(root, '$.me.items[0]')).toMatchObject({
      label: '[0]',
      value: 'item',
    })
    expect(byPath(root, '$[103]')).toMatchObject({
      kind: 'string',
      value: 'item',
    })
    expect(byPath(root, '$.me.level')).toMatchObject({
      kind: 'number',
      value: 33,
    })
  })

  it('escapes unusual string keys and distinguishes numeric keys', () => {
    const keys = ['中文-key', '', 'a.b', '103', 'a"b\\c\n', '_key', '$key']
    const value = new Map<string | number, LpcValue>(
      keys.map((key) => [key, 1]),
    )
    value.set(103, 2)
    const root = buildLpcAnalysisTree(value)
    expect(root.children?.map((node) => node.path)).toEqual([
      '$["中文-key"]',
      '$[""]',
      '$["a.b"]',
      '$["103"]',
      String.raw`$["a\"b\\c\n"]`,
      '$._key',
      '$.$key',
      '$[103]',
    ])
    const nodes = flatten(root)
    expect(new Set(nodes.map((node) => node.id)).size).toBe(nodes.length)
    expect(nodes.every((node) => node.id === node.path)).toBe(true)
    expect(buildLpcAnalysisTree(value)).toEqual(root)
  })

  it.each([new Map(), []])('keeps empty container children', (value) => {
    expect(buildLpcAnalysisTree(value).children).toEqual([])
  })

  it('converts carry embedded LPC into a payload root and children', () => {
    const value = parseLpcValue(
      String.raw`(["carry":([103:"中级法玲珑:([255:36,\"type\":8,])",]),])`,
    )
    const root = buildLpcAnalysisTree(value)
    expect(byPath(root, '$.carry[103]')).toMatchObject({
      kind: 'embedded',
      prefix: '中级法玲珑:',
      source: '([255:36,"type":8,])',
      value: '中级法玲珑:([255:36,"type":8,])',
    })
    expect(byPath(root, '$.carry[103].embedded')).toMatchObject({
      label: 'embedded',
      kind: 'mapping',
    })
    expect(byPath(root, '$.carry[103].embedded[255]')).toMatchObject({
      kind: 'number',
      value: 36,
    })
    expect(byPath(root, '$.carry[103].embedded.type')).toMatchObject({
      kind: 'number',
      value: 8,
    })
  })

  it('handles embedded arrays and leaves invalid payloads as strings', () => {
    const root = buildLpcAnalysisTree(['前缀:({1,([]),})', '不是合法:([oops'])
    expect(byPath(root, '$[0].embedded')).toMatchObject({ kind: 'array' })
    expect(byPath(root, '$[0].embedded[0]')).toMatchObject({ value: 1 })
    expect(byPath(root, '$[0].embedded[1]')).toMatchObject({
      kind: 'mapping',
      children: [],
    })
    expect(byPath(root, '$[1]')).toMatchObject({
      kind: 'string',
      value: '不是合法:([oops',
    })
  })

  it('disables embedded parsing throughout the payload but allows other outer strings', () => {
    const nested = '内层:(["a":1,])'
    const payload = String.raw`外层:(["nested":({(["text":"内层:([\"a\":1,])",]),}),])`
    const root = buildLpcAnalysisTree([payload, '另一项:({2,})'])
    expect(byPath(root, '$[0].embedded.nested[0].text')).toMatchObject({
      kind: 'string',
      value: nested,
    })
    expect(byPath(root, '$[1]')).toMatchObject({ kind: 'embedded' })
    expect(
      flatten(root).filter((node) => node.kind === 'embedded'),
    ).toHaveLength(2)
  })

  it('does not modify the original mappings, arrays or special values', () => {
    const source = String.raw`(["data":({-20,:ABC:,"前缀:([1:2,])",}),])`
    const value = parseLpcValue(source)
    const original = parseLpcValue(source)
    const root = buildLpcAnalysisTree(value)
    expect(value).toEqual(original)
    root.children?.splice(0)
    expect(value).toEqual(original)
  })
})
