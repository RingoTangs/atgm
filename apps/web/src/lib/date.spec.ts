import { describe, expect, it } from 'vitest'
import {
  dayjs,
  dayPatterns,
  formatDate,
  formatDateTime,
  formatTime,
} from './date'

describe('日期格式化', () => {
  it('保留常用格式常量', () => {
    expect(dayPatterns).toEqual({
      date: 'YYYY-MM-DD',
      datetime: 'YYYY-MM-DD HH:mm:ss',
      time: 'HH:mm:ss',
    })
  })

  it.each([
    ['字符串', '2026-09-16T14:30:05'],
    ['Date 对象', new Date(2026, 8, 16, 14, 30, 5)],
    ['Day.js 对象', dayjs(new Date(2026, 8, 16, 14, 30, 5))],
    ['毫秒时间戳', new Date(2026, 8, 16, 14, 30, 5).getTime()],
  ])('支持%s输入', (_, value) => {
    expect(formatDate(value)).toBe('2026-09-16')
    expect(formatDateTime(value)).toBe('2026-09-16 14:30:05')
    expect(formatTime(value)).toBe('14:30:05')
  })

  it.each([
    undefined,
    null,
    '',
    ' \t\n ',
    'not-a-date',
    new Date(Number.NaN),
    Number.NaN,
    dayjs('not-a-date'),
  ])('空值或无效输入 %s 返回空字符串', (value) => {
    expect(formatDate(value)).toBe('')
    expect(formatDateTime(value)).toBe('')
    expect(formatTime(value)).toBe('')
  })

  it('时间戳 0 是有效值，并使用本地时区', () => {
    const epoch = new Date(0)
    const pad = (value: number) => String(value).padStart(2, '0')
    const date = `${epoch.getFullYear()}-${pad(epoch.getMonth() + 1)}-${pad(epoch.getDate())}`
    const time = `${pad(epoch.getHours())}:${pad(epoch.getMinutes())}:${pad(epoch.getSeconds())}`
    expect(formatDate(0)).toBe(date)
    expect(formatTime(0)).toBe(time)
    expect(formatDateTime(0)).toBe(`${date} ${time}`)
  })

  it.each([
    ['UTC', dayjs.utc('2026-09-16T23:30:05Z'), '2026-09-16', '23:30:05'],
    [
      'Asia/Shanghai',
      dayjs.utc('2026-09-16T23:30:05Z').tz('Asia/Shanghai'),
      '2026-09-17',
      '07:30:05',
    ],
  ])('保留 %s 时区且不修改原对象', (_, value, date, time) => {
    const timestamp = value.valueOf()
    const original = value.format()
    const offset = value.utcOffset()
    expect(formatDate(value)).toBe(date)
    expect(formatTime(value)).toBe(time)
    expect(formatDateTime(value)).toBe(`${date} ${time}`)
    expect(value.valueOf()).toBe(timestamp)
    expect(value.format()).toBe(original)
    expect(value.utcOffset()).toBe(offset)
  })

  it('不修改传入的 Date 对象', () => {
    const value = new Date(2026, 8, 16, 14, 30, 5)
    const timestamp = value.getTime()
    formatDate(value)
    formatDateTime(value)
    formatTime(value)
    expect(value.getTime()).toBe(timestamp)
  })
})
