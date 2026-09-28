import { QueryClientProvider } from '@tanstack/react-query'
import { ReactQueryDevtools } from '@tanstack/react-query-devtools'
import { RouterProvider } from '@tanstack/react-router'
import { TanStackRouterDevtools } from '@tanstack/react-router-devtools'
import { ConfigProvider } from 'antd'
import zhCN from 'antd/locale/zh_CN'
import { queryClient } from '@/app/queryClient'
import { router, RouterProgress, RouterSpinner } from '@/app/router'
import { ThemeProvider } from '@/theme'
import 'dayjs/locale/zh-cn'

const App: React.FC = () => {
  return (
    <ThemeProvider>
      <ConfigProvider locale={zhCN}>
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
    </ThemeProvider>
  )
}

export default App
