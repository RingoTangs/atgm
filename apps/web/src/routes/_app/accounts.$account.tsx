import { createFileRoute } from '@tanstack/react-router'
import { AccountDetailPage } from '@/features/accounts/AccountDetailPage'

export const Route = createFileRoute('/_app/accounts/$account')({
  head: ({ params }) => ({
    meta: [
      {
        title: `${params.account} - 账号详情 - ${import.meta.env.VITE_SITE_NAME}`,
      },
    ],
  }),
  component: AccountDetailRoute,
})

function AccountDetailRoute() {
  const { account } = Route.useParams()

  return <AccountDetailPage account={account} />
}
