import { QueryClientProvider } from '@tanstack/react-query'
import { ReactQueryDevtools } from '@tanstack/react-query-devtools'
import { RouterProvider } from '@tanstack/react-router'
import { TanStackRouterDevtools } from '@tanstack/react-router-devtools'
import { queryClient } from '@/app/queryClient'
import { router, RouterProgress, RouterSpinner } from '@/app/router'
import { ThemeProvider } from '@/theme'

const App: React.FC = () => {
  return (
    <ThemeProvider>
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
    </ThemeProvider>
  )
}

export default App
