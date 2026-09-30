import { createFileRoute } from '@tanstack/react-router'

const DashboardPage: React.FC = () => {
  return (
    <div>
      <h1 className="text-2xl font-semibold">Dashboard</h1>
      <p className="text-muted-foreground mt-2">欢迎使用 ATGM</p>
    </div>
  )
}

export const Route = createFileRoute('/_app/')({
  head: () => ({
    meta: [{ title: `Dashboard - ${import.meta.env.VITE_SITE_NAME}` }],
  }),
  component: DashboardPage,
})
