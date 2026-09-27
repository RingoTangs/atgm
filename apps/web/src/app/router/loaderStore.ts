import { create } from 'zustand'

type LoadingMode = 'idle' | 'boot' | 'navigation'

interface LoadingState {
  mode: LoadingMode

  setBootLoading: () => void
  setNavigationLoading: () => void
  clearLoading: () => void
}

// 由 LoaderSync 独占同步路由状态；业务请求不写入这个 store。
export const useLoaderStore = create<LoadingState>((set) => ({
  mode: 'boot',

  setBootLoading: () => {
    set({ mode: 'boot' })
  },

  setNavigationLoading: () => {
    set({ mode: 'navigation' })
  },

  clearLoading: () => {
    set({ mode: 'idle' })
  },
}))
