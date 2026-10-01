import { describe, expect, it } from 'vitest'
import { formatDisplayTime, formatGameTime } from './game-time'

describe('game time', () => {
  it('formats a date for the game database', () => {
    expect(formatGameTime(new Date(2026, 9, 2, 15, 30, 45))).toBe(
      '20261002153045',
    )
  })

  it('formats a game database time for display', () => {
    expect(formatDisplayTime('20261002153045')).toBe('2026-10-02 15:30:45')
  })

  it('preserves empty and invalid values without returning Invalid Date', () => {
    expect(formatDisplayTime('')).toBe('')
    expect(formatDisplayTime('invalid')).toBe('invalid')
  })
})
