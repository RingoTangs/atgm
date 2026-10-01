import { createFileRoute } from '@tanstack/react-router'
import { DashboardPage } from '@/features/dashboard/DashboardPage'

export const Route = createFileRoute('/_app/')({
  head: () => ({
    meta: [{ title: `Dashboard - ${import.meta.env.VITE_SITE_NAME}` }],
  }),
  component: DashboardPage,
})
