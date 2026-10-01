import dayjs from 'dayjs'
import customParseFormat from 'dayjs/plugin/customParseFormat'

dayjs.extend(customParseFormat)

const gameTimePattern = 'YYYYMMDDHHmmss'
const displayTimePattern = 'YYYY-MM-DD HH:mm:ss'

export function formatGameTime(date: Date = new Date()): string {
  return dayjs(date).format(gameTimePattern)
}

export function formatDisplayTime(value: string): string {
  if (value === '') return ''

  const date = dayjs(value, gameTimePattern, true)
  return date.isValid() ? date.format(displayTimePattern) : value
}
