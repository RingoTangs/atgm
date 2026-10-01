import type { ConfigType } from 'dayjs'
import $_dayjs from 'dayjs'
import timezone from 'dayjs/plugin/timezone'
import utc from 'dayjs/plugin/utc'

$_dayjs.extend(utc)
$_dayjs.extend(timezone)

/**
 * 已配置 UTC 和时区插件的 Day.js 实例。
 */
export const dayjs = $_dayjs

/**
 * 常用日期格式。
 */
export const dayPatterns = {
  date: 'YYYY-MM-DD',
  datetime: 'YYYY-MM-DD HH:mm:ss',
  time: 'HH:mm:ss',
}

const format = (value: ConfigType, pattern: string): string => {
  // 不把缺失值当成当前时间，也不把有效的时间戳 0 当成空值。
  if (value == null || (typeof value === 'string' && value.trim() === '')) {
    return ''
  }

  const date = dayjs(value)
  return date.isValid() ? date.format(pattern) : ''
}

/**
 * 格式化为 YYYY-MM-DD；空值或解析无效时返回空字符串。
 * 数字按毫秒处理，普通输入使用本地时区，Day.js 对象保留自身时区。
 * 沿用 Day.js 默认解析，不用于严格校验日期。
 */
export const formatDate = (value: ConfigType): string =>
  format(value, dayPatterns.date)

/**
 * 格式化为 YYYY-MM-DD HH:mm:ss；输入及空值处理规则与 formatDate 相同。
 */
export const formatDateTime = (value: ConfigType): string =>
  format(value, dayPatterns.datetime)

/**
 * 格式化为 HH:mm:ss；输入及空值处理规则与 formatDate 相同。
 */
export const formatTime = (value: ConfigType): string =>
  format(value, dayPatterns.time)
