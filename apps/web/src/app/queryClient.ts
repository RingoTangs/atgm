import { QueryClient } from '@tanstack/react-query'

// 应用共用一个缓存实例，Provider 和 Router context 都引用它。
export const queryClient = new QueryClient({
  defaultOptions: {
    // 全局默认配置保持保守，不包含业务策略。
    // 各功能模块的查询策略放在自身的 queryOptions() 中。
    queries: {
      // 短时间内复用新鲜数据，减少组件重新挂载时的重复请求。
      staleTime: 30_000,
      // 无订阅的缓存保留 5 分钟，与 TanStack Query 默认值一致。
      gcTime: 5 * 60 * 1000,
      // 读取失败后重试一次，避免过多重试增加后端负担。
      retry: 1,
      // 切换浏览器标签页或开发工具时，不自动重新请求。
      refetchOnWindowFocus: false,
      // 网络恢复连接后，自动刷新过期数据。
      refetchOnReconnect: true,
    },
    mutations: {
      // 写入操作默认不重试，避免重复提交。
      retry: 0,
    },
  },
})
