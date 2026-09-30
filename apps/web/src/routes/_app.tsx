import { createFileRoute, Outlet } from '@tanstack/react-router'
import { AppLayout } from '@/components/AppLayout'

const AppRoute: React.FC = () => {
  return (
    <AppLayout>
      <Outlet />
    </AppLayout>
  )
}

export const Route = createFileRoute('/_app')({
  component: AppRoute,
})
