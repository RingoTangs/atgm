import type { LpcMode } from '@/features/lpc/LpcPage'
import { createFileRoute } from '@tanstack/react-router'
import { LpcPage } from '@/features/lpc/LpcPage'

export const Route = createFileRoute('/_app/lpc')({
  validateSearch: (search: Record<string, unknown>): { mode?: LpcMode } => ({
    mode: search.mode === 'analysis' ? 'analysis' : 'format',
  }),
  head: () => ({
    meta: [{ title: `LPC - ${import.meta.env.VITE_SITE_NAME}` }],
  }),
  component: LpcRoute,
})

function LpcRoute() {
  const { mode } = Route.useSearch()
  const navigate = Route.useNavigate()
  return (
    <LpcPage
      mode={mode ?? 'format'}
      onModeChange={(nextMode) => {
        void navigate({
          search: (previous) => ({ ...previous, mode: nextMode }),
          replace: true,
        })
      }}
    />
  )
}
