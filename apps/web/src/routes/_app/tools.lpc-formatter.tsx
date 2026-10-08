import { createFileRoute } from '@tanstack/react-router'
import { LpcFormatterPage } from '@/features/tools/lpc/LpcFormatterPage'

export const Route = createFileRoute('/_app/tools/lpc-formatter')({
  head: () => ({
    meta: [{ title: `LPC 格式化 - ${import.meta.env.VITE_SITE_NAME}` }],
  }),
  component: LpcFormatterPage,
})
