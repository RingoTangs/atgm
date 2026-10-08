import { act } from '@testing-library/react'
import { vi } from 'vitest'

// Ant Design subscribes through addListener; keep queries live when resizing.
export function installMatchMedia(initialWidth = 1600) {
  let width = initialWidth
  const queries: Array<{ notify: () => void }> = []
  vi.stubGlobal(
    'matchMedia',
    vi.fn((query: string) => {
      const listeners = new Set<(event: MediaQueryListEvent) => void>()
      const matches = () => {
        const min = query.match(/min-width:\s*(\d+)px/)
        const max = query.match(/max-width:\s*(\d+)px/)
        return (
          (!min || width >= Number(min[1])) && (!max || width <= Number(max[1]))
        )
      }
      let previous = matches()
      const media = {
        get matches() {
          return matches()
        },
        media: query,
        onchange: null,
        addListener: (listener: (event: MediaQueryListEvent) => void) =>
          listeners.add(listener),
        removeListener: (listener: (event: MediaQueryListEvent) => void) =>
          listeners.delete(listener),
        addEventListener: (
          _type: string,
          listener: (event: MediaQueryListEvent) => void,
        ) => listeners.add(listener),
        removeEventListener: (
          _type: string,
          listener: (event: MediaQueryListEvent) => void,
        ) => listeners.delete(listener),
        dispatchEvent: () => true,
      }
      queries.push({
        notify: () => {
          if (previous === matches()) return
          previous = matches()
          listeners.forEach((listener) =>
            listener({
              matches: previous,
              media: query,
            } as MediaQueryListEvent),
          )
        },
      })
      return media as unknown as MediaQueryList
    }),
  )
  return (nextWidth: number) => {
    act(() => {
      width = nextWidth
      queries.forEach((query) => query.notify())
    })
  }
}
