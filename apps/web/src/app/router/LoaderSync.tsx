import { useRouterState } from '@tanstack/react-router'
import { useEffect } from 'react'
import { useLoaderStore } from './loaderStore'

export const LoaderSync: React.FC = () => {
  const routerState = useRouterState({
    select: (state) => ({
      pending: state.status === 'pending',
      resolved: state.resolvedLocation !== undefined,
    }),
  })

  const setBootLoading = useLoaderStore((state) => state.setBootLoading)

  const setNavigationLoading = useLoaderStore(
    (state) => state.setNavigationLoading,
  )

  const clearLoading = useLoaderStore((state) => state.clearLoading)

  useEffect(() => {
    if (!routerState.resolved) {
      setBootLoading()
      return
    }

    if (routerState.pending) setNavigationLoading()
    else clearLoading()
  }, [
    routerState.pending,
    routerState.resolved,
    setBootLoading,
    setNavigationLoading,
    clearLoading,
  ])

  // 独立于状态同步，只有卸载（或 StrictMode 重放）时清理。
  useEffect(() => clearLoading, [clearLoading])

  return null
}
