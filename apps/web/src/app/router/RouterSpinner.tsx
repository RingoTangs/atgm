import { useEffect, useRef, useState } from 'react'
import { FadeLoader } from 'react-spinners'
import { useLoaderStore } from './loaderStore'

// 快速加载不显示；显示后至少保留一小段时间，避免闪烁。
const SHOW_DELAY_MS = 150
const MIN_VISIBLE_MS = 300

export const RouterSpinner: React.FC = () => {
  const loading = useLoaderStore((state) => state.mode === 'boot')

  const [visible, setVisible] = useState(false)
  const visibleAtRef = useRef(0)

  useEffect(() => {
    let timer: ReturnType<typeof setTimeout> | undefined

    if (loading && !visible) {
      timer = setTimeout(() => {
        visibleAtRef.current = performance.now()
        setVisible(true)
      }, SHOW_DELAY_MS)
    } else if (!loading && visible) {
      const elapsed = performance.now() - visibleAtRef.current

      const remaining = Math.max(MIN_VISIBLE_MS - elapsed, 0)

      timer = setTimeout(() => {
        setVisible(false)
      }, remaining)
    }

    return () => {
      if (timer !== undefined) {
        clearTimeout(timer)
      }
    }
  }, [loading, visible])

  if (!visible) {
    return null
  }

  return (
    <div
      role="status"
      className="bg-background fixed inset-0 z-50 flex items-center justify-center"
    >
      <span className="sr-only">Loading...</span>
      <div aria-hidden="true">
        <FadeLoader color="var(--color-primary)" />
      </div>
    </div>
  )
}
