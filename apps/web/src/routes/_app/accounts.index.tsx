import { createFileRoute } from '@tanstack/react-router'
import { AccountsPage } from '@/features/accounts/AccountsPage'

export const Route = createFileRoute('/_app/accounts/')({
  head: () => ({
    meta: [{ title: `账号管理 - ${import.meta.env.VITE_SITE_NAME}` }],
  }),
  component: AccountsPage,
})
