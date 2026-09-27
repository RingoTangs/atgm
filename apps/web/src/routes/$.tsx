import { createFileRoute } from '@tanstack/react-router'
import { NotFoundError } from '@/features/errors/NotFoundError'

export const Route = createFileRoute('/$')({
  head: () => {
    return {
      meta: [
        {
          title: `404 - Page Not Found | ${import.meta.env.VITE_SITE_NAME}`,
        },
        {
          name: 'description',
          content: 'The page you are looking for does not exist.',
        },
      ],
    }
  },
  component: NotFoundError,
})
