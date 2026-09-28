import { QueryClientProvider } from '@tanstack/react-query'
import { ReactQueryDevtools } from '@tanstack/react-query-devtools'
import { RouterProvider } from '@tanstack/react-router'
import { TanStackRouterDevtools } from '@tanstack/react-router-devtools'
import { ConfigProvider } from 'antd'
import zhCN from 'antd/locale/zh_CN'
import { createAntdTheme } from '@/antd/theme'
import { queryClient } from '@/app/queryClient'
import { router, RouterProgress, RouterSpinner } from '@/app/router'
import { useTheme } from './theme'
import 'dayjs/locale/zh-cn'

const App: React.FC = () => {
  const { resolvedTheme } = useTheme()
  return (
    <ConfigProvider locale={zhCN} theme={createAntdTheme(resolvedTheme)}>
      <QueryClientProvider client={queryClient}>
        <RouterProvider router={router} />
        <RouterProgress />
        <RouterSpinner />
        <TanStackRouterDevtools router={router} position="bottom-left" />
        <ReactQueryDevtools
          initialIsOpen={false}
          position="bottom"
          buttonPosition="bottom-right"
        />
      </QueryClientProvider>
    </ConfigProvider>
  )
}

export default App
