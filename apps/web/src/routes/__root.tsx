import type { QueryClient } from '@tanstack/react-query'
import { createRootRouteWithContext, HeadContent } from '@tanstack/react-router'
import { reportError } from '@/app/reportError'
import { GeneralError } from '@/features/errors/GeneralError'
import { NotFoundError } from '@/features/errors/NotFoundError'

export const Route = createRootRouteWithContext<{
  queryClient: QueryClient
}>()({
  head: () => {
    return {
      meta: [
        {
          title: import.meta.env.VITE_SITE_NAME,
        },
        {
          name: 'description',
          content:
            'A React application template with typed routing, shared state, and async data examples.',
        },
      ],
    }
  },
  shellComponent: ({ children }) => (
    <>
      <HeadContent />
      {children}
    </>
  ),
  errorComponent: GeneralError,
  notFoundComponent: NotFoundError,
  onCatch: (error) => {
    reportError(error)
  },
})
