import { createFileRoute } from '@tanstack/react-router'
import { LpcPage } from '@/features/lpc/LpcPage'

export const Route = createFileRoute('/_app/lpc')({
  head: () => ({
    meta: [{ title: `LPC - ${import.meta.env.VITE_SITE_NAME}` }],
  }),
  component: LpcPage,
})
