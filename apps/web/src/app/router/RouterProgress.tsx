import type { LoadingBarRef } from 'react-top-loading-bar'
import { useCallback, useEffect, useRef, useState } from 'react'
import LoadingBar from 'react-top-loading-bar'
import { useLoaderStore } from './loaderStore'

// 导航超过这个时间才显示进度条，避免快速导航时闪烁。
const PROGRESS_DELAY_MS = 150

// 进度条外观。
const PROGRESS_COLOR = 'var(--muted-foreground)'
const PROGRESS_HEIGHT_PX = 2

/*
 * RouterProgress 划分加载轮次，ProgressCycle 延迟显示，ActiveBar 控制动画。
 * 每轮使用独立实例，防止第三方库上一轮的完成定时器干扰新导航。
 */

/**
 * 百分比和动画交给第三方组件，不混用受控 progress 属性。
 */
const ActiveBar: React.FC<{
  pending: boolean
  onFinished: () => void
}> = ({ pending, onFinished }) => {
  // 记录本轮是否已开始、已完成，避免重渲染时重复调用动画方法。
  const barRef = useRef<LoadingBarRef>(null)
  const startedRef = useRef(false)
  const completedRef = useRef(false)
  const [initialPending] = useState(pending)

  useEffect(() => {
    // 同步启动，避免显示后还需等待另一个定时器才能开始。
    if (initialPending && barRef.current) {
      barRef.current.start()
      startedRef.current = true
    }
    /*
     * 仅随本轮实例挂载和卸载运行；StrictMode 重放时允许重新初始化。
     * 不依赖 pending，避免加载结束时先清理掉“已经启动”的记录。
     */
    return () => {
      startedRef.current = false
    }
  }, [initialPending])

  useEffect(() => {
    if (pending || completedRef.current) return
    completedRef.current = true
    if (startedRef.current && barRef.current) {
      barRef.current.complete()
    } else {
      // 显示更新与加载结束同时发生时，直接清理未启动实例，不播放完成动画。
      onFinished()
    }
  }, [pending, onFinished])

  return (
    <LoadingBar
      ref={barRef}
      height={PROGRESS_HEIGHT_PX}
      color={PROGRESS_COLOR}
      containerClassName="router-progress"
      onLoaderFinished={onFinished}
    />
  )
}

/**
 * 管理一轮显示：等待、播放完成动画、卸载。
 */
const ProgressCycle: React.FC<{ pending: boolean }> = ({ pending }) => {
  // visible 表示显示延迟已到；finished 表示完成动画已结束。
  const [visible, setVisible] = useState(false)
  const [finished, setFinished] = useState(false)
  const onFinished = useCallback(() => setFinished(true), [])

  useEffect(() => {
    if (!pending) return
    // 延迟显示，避免快速导航闪烁；提前结束或卸载时取消等待。
    const timer = setTimeout(setVisible, PROGRESS_DELAY_MS, true)
    return () => clearTimeout(timer)
  }, [pending])

  if (!visible || finished) return null

  // 加载结束后仍保留实例，等完成动画播放完再卸载。
  return <ActiveBar pending={pending} onFinished={onFinished} />
}

export const RouterProgress: React.FC = () => {
  // 只展示 LoaderSync 同步的前台导航状态。
  const pending = useLoaderStore((state) => state.mode === 'navigation')

  // 保存上一轮状态和 navigation cycle 编号。
  // id 只用于隔离不同 navigation 的 ProgressCycle 实例。
  const [cycle, setCycle] = useState({
    pending,
    id: 0,
  })

  /**
   * 只在进入 pending 时开启一个新的 cycle。
   *
   * pending: false -> true
   *   id + 1，新 navigation 使用新的 ProgressCycle 实例。
   *
   * pending: true -> false
   *   id 不变，让当前 ProgressCycle 播放完成动画。
   */
  if (pending !== cycle.pending) {
    setCycle({
      pending,
      id: cycle.id + (pending ? 1 : 0),
    })
  }

  return <ProgressCycle key={cycle.id} pending={pending} />
}
