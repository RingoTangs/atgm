import { createFileRoute } from '@tanstack/react-router'
import { ServersPage } from '@/features/servers/ServersPage'

export const Route = createFileRoute('/_app/servers/')({
  head: () => ({
    meta: [{ title: `服务器管理 - ${import.meta.env.VITE_SITE_NAME}` }],
  }),
  component: ServersPage,
})
