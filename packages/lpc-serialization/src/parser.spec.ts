import type {
  LpcArray,
  LpcMapping,
  LpcMappingKey,
  LpcSpecialValue,
  LpcValue,
} from '.'
import { describe, expect, expectTypeOf, it } from 'vitest'
import * as publicApi from '.'
import { LpcParseError, parseLpcValue } from '.'

function mapping(value: LpcValue | undefined): LpcMapping {
  expect(value).toBeInstanceOf(Map)
  if (!(value instanceof Map)) throw new Error('Expected mapping')
  return value
}

function array(value: LpcValue | undefined): LpcArray {
  expect(Array.isArray(value)).toBe(true)
  if (!Array.isArray(value)) throw new Error('Expected array')
  return value
}

const special: LpcSpecialValue = {
  type: 'special',
  value: '6AB6A56F000101C911A4',
}

describe('basic values and strings', () => {
  it.each([
    ['123', 123],
    ['-20', -20],
    ['12.5', 12.5],
    ['-12.5', -12.5],
    ['0', 0],
    ['"hello"', 'hello'],
    ['"中文"', '中文'],
    ['""', ''],
    [String.raw`"hello \"world\""`, 'hello "world"'],
    [String.raw`"foo\\bar"`, 'foo\\bar'],
    [String.raw`"\n\r\t\b\f"`, '\n\r\t\b\f'],
    [String.raw`"\u4e2d\u6587"`, '中文'],
    [String.raw`"\uD83D\uDE00"`, '😀'],
    [' \t\r\n123 \n', 123],
  ])('parses %s', (source, expected) => {
    expect(parseLpcValue(source)).toBe(expected)
  })
})

describe('arrays and mappings', () => {
  it.each(['({1,2,3,})', '({1,2,3})'])('parses %s', (source) => {
    expect(parseLpcValue(source)).toEqual([1, 2, 3])
  })

  it('parses empty containers', () => {
    expect(parseLpcValue('({})')).toEqual([])
    expect(mapping(parseLpcValue('([])'))).toEqual(new Map())
    expect(parseLpcValue('( { } )')).toEqual([])
    expect(mapping(parseLpcValue('( [ ] )')).size).toBe(0)
  })

  it.each([
    '(["name":"东海瑞兽","level":100,])',
    '(["name":"东海瑞兽","level":100])',
    '(\n  [\n    "name" : "东海瑞兽",\n    "level" : 100,\n  ]\n)',
  ])('parses string keys and whitespace: %s', (source) => {
    const result = mapping(parseLpcValue(source))
    expect(result.get('name')).toBe('东海瑞兽')
    expect(result.get('level')).toBe(100)
  })

  it('preserves numeric keys', () => {
    const result = mapping(parseLpcValue('([181:0,179:1,92:20,])'))
    expect(result.get(181)).toBe(0)
    expect(result.get(179)).toBe(1)
    expect(result.get(92)).toBe(20)
    expect(result.has('181')).toBe(false)
  })

  it('keeps key types distinct and replaces duplicate keys', () => {
    const result = mapping(
      parseLpcValue('([1:0,"1":2,1:3,-20:4,12.5:5,"__proto__":6,])'),
    )
    expect(result.get(1)).toBe(3)
    expect(result.get('1')).toBe(2)
    expect(result.get(-20)).toBe(4)
    expect(result.get(12.5)).toBe(5)
    expect(result.get('__proto__')).toBe(6)
  })

  it('parses deeply nested values', () => {
    const result = mapping(
      parseLpcValue('(["a":(["b":({1,2,(["c":"中文",]),}),]),])'),
    )
    const b = array(mapping(result.get('a')).get('b'))
    expect(b.slice(0, 2)).toEqual([1, 2])
    expect(mapping(b[2]).get('c')).toBe('中文')
  })

  it('does not parse LPC inside a string', () => {
    const result = mapping(
      parseLpcValue(String.raw`(["l_child":"([\"carry\":([]),])",])`),
    )
    expect(result.get('l_child')).toBe('(["carry":([]),])')
    expect(typeof result.get('l_child')).toBe('string')
  })
})

describe('special values', () => {
  it('parses a standalone special value', () => {
    expect(parseLpcValue(':6AB6A56F000101C911A4:')).toEqual(special)
  })
  it('parses a special value after a mapping separator', () => {
    expect(
      mapping(parseLpcValue('([33::6AB6A56F000101C911A4:,])')).get(33),
    ).toEqual(special)
  })
  it('preserves case and supports special values in arrays', () => {
    expect(parseLpcValue('({:aBc123:,:0:,})')).toEqual([
      { type: 'special', value: 'aBc123' },
      { type: 'special', value: '0' },
    ])
  })
})

describe('real content', () => {
  it('parses Login Content without converting role identifiers', () => {
    const result = mapping(
      parseLpcValue(
        '(["create_time":1790613437,"rec_role":"0000000000000003","safe_status":0,"chars":({"0000000000000003","0000000000000004",}),"register_time":0,])',
      ),
    )
    expect(result.get('create_time')).toBe(1790613437)
    expect(result.get('rec_role')).toBe('0000000000000003')
    expect(result.get('safe_status')).toBe(0)
    expect(result.get('register_time')).toBe(0)
    expect(result.get('chars')).toEqual([
      '0000000000000003',
      '0000000000000004',
    ])
  })

  it('parses simple me content', () => {
    const me = mapping(
      mapping(
        parseLpcValue(
          '(["me":(["icon":6214,"rank_no":102,"religion":1,"polar":4,"type":4,"level":100,"name":"东海瑞兽",]),])',
        ),
      ).get('me'),
    )
    expect(me.get('icon')).toBe(6214)
    expect(me.get('rank_no')).toBe(102)
    expect(me.get('religion')).toBe(1)
    expect(me.get('polar')).toBe(4)
    expect(me.get('type')).toBe(4)
    expect(me.get('level')).toBe(100)
    expect(me.get('name')).toBe('东海瑞兽')
  })

  it('parses salary configuration with Chinese keys and two-dimensional arrays', () => {
    const result = mapping(
      parseLpcValue(
        '(["last_period":(["时间-工资百分比":(["percent":({({0,-1,100,}),({0,-1,100,}),}),]),"等级-工资":(["salary":({({80,89,2000,5500,}),({90,99,2000,6500,}),}),]),"设置":(["period":({0,7,}),"delay_time":21600,"min_level":50,]),]),])',
      ),
    )
    const period = mapping(result.get('last_period'))
    const percent = array(mapping(period.get('时间-工资百分比')).get('percent'))
    expect(percent).toEqual([
      [0, -1, 100],
      [0, -1, 100],
    ])
    expect(array(percent[0])).toEqual([0, -1, 100])
    expect(mapping(period.get('等级-工资')).get('salary')).toEqual([
      [80, 89, 2000, 5500],
      [90, 99, 2000, 6500],
    ])
    const settings = mapping(period.get('设置'))
    expect(settings.get('period')).toEqual([0, 7])
    expect(settings.get('delay_time')).toBe(21600)
    expect(settings.get('min_level')).toBe(50)
  })

  it('parses complex me content while preserving embedded LPC strings', () => {
    const result = mapping(
      parseLpcValue(
        String.raw`(["me":(["gender":1,"phy_absorb":-20,"name":"龙宫守卫","attrib":([181:0,179:0,92:([52:20,47:300,]),33::6AB6A56F000101C911A4:,39:"海龟",]),"l_child":"([\"carry\":([]),\"name\":\"娃娃\",])",]),])`,
      ),
    )
    const me = mapping(result.get('me'))
    expect(me.get('gender')).toBe(1)
    expect(me.get('phy_absorb')).toBe(-20)
    expect(me.get('name')).toBe('龙宫守卫')
    const attrib = mapping(me.get('attrib'))
    expect(attrib.get(181)).toBe(0)
    expect(attrib.get(179)).toBe(0)
    const nested = mapping(attrib.get(92))
    expect(nested.get(52)).toBe(20)
    expect(nested.get(47)).toBe(300)
    expect(attrib.get(33)).toEqual(special)
    expect(attrib.get(39)).toBe('海龟')
    expect(me.get('l_child')).toBe('(["carry":([]),"name":"娃娃",])')
    expect(typeof me.get('l_child')).toBe('string')
  })

  it('parses deep arrays in complex me content', () => {
    const me = mapping(
      mapping(
        parseLpcValue(
          '(["me":(["attrib":([92:([52:({({-20,"中文",:6AB6A56F000101C911A4:,}),}),]),]),]),])',
        ),
      ).get('me'),
    )
    const values = array(mapping(mapping(me.get('attrib')).get(92)).get(52))
    expect(values).toEqual([[-20, '中文', special]])
  })
})

describe('invalid input', () => {
  it.each([
    '',
    ' \n\t',
    '@',
    'true',
    '"abc',
    '({1,2,',
    '(["a":1,',
    '(["a" 1,])',
    ':ABC',
    '123 abc',
    '123 456',
    '"a""b"',
    '({1 2})',
    '({1,,2})',
    '({,})',
    '([,])',
    '(["a":1,,])',
    '([({}):1])',
    '([:ABC::1])',
    '(["a":])',
    '({1])',
    '(["a":1})',
    '({1}',
    '(["a":1]',
    '()',
    '[]',
    '{}',
    '-',
    '--1',
    '1.2.3',
    '1.',
    '.5',
    '+1',
    '1e3',
    '0x10',
    '12abc',
    '9'.repeat(400),
    '::',
    ':XYZ:',
    ':AB C:',
    ':AB\nC:',
    String.raw`"\q"`,
    String.raw`"\u12"`,
    String.raw`"\u12G4"`,
    '"abc\\',
    '"\n"',
    '"\t"',
  ])('throws a located LpcParseError for %j', (source) => {
    expect(() => parseLpcValue(source)).toThrow(LpcParseError)
    try {
      parseLpcValue(source)
      throw new Error('Expected parse failure')
    } catch (error) {
      expect(error).toBeInstanceOf(LpcParseError)
      if (!(error instanceof LpcParseError)) throw error
      expect(error.name).toBe('LpcParseError')
      expect(error.message.length).toBeGreaterThan(0)
      expect(Number.isInteger(error.offset)).toBe(true)
      expect(error.offset).toBeGreaterThanOrEqual(0)
      expect(error.offset).toBeLessThanOrEqual(source.length)
    }
  })

  it.each([
    ['', 0],
    ['@', 0],
    ['"abc', 4],
    [':ABC', 4],
    ['({1,2,', 6],
    ['(["a" 1,])', 6],
    ['123 abc', 4],
    ['1.2.3', 0],
    [String.raw`"\q"`, 2],
    ['"中文" @', 5],
    ['"😀" @', 5],
  ])('reports UTF-16 offset for %j', (source, offset) => {
    expect(() => parseLpcValue(source)).toThrow(
      expect.objectContaining({ offset }),
    )
  })
})

it('exports only the public API and the required types', () => {
  expect(Object.keys(publicApi).sort()).toEqual([
    'LpcParseError',
    'parseLpcValue',
  ])
  expectTypeOf<LpcMappingKey>().toEqualTypeOf<string | number>()
  expectTypeOf<LpcMapping>().toEqualTypeOf<Map<LpcMappingKey, LpcValue>>()
  expectTypeOf<LpcArray>().toEqualTypeOf<LpcValue[]>()
  expectTypeOf<LpcSpecialValue>().toEqualTypeOf<{
    type: 'special'
    value: string
  }>()
  expectTypeOf<LpcValue>().toEqualTypeOf<
    string | number | LpcArray | LpcMapping | LpcSpecialValue
  >()
  expectTypeOf(parseLpcValue).toEqualTypeOf<(source: string) => LpcValue>()
})
