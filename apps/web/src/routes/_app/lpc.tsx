import type { LpcMode } from '@/features/lpc/LpcPage'
import { createFileRoute } from '@tanstack/react-router'
import { LpcPage } from '@/features/lpc/LpcPage'
import {
  decodeLpcUrlContent,
  encodeLpcUrlContent,
} from '@/features/lpc/lpcUrlContent'

export const Route = createFileRoute('/_app/lpc')({
  validateSearch: (
    search: Record<string, unknown>,
  ): { mode?: LpcMode; content?: string } => ({
    mode: search.mode === 'analysis' ? 'analysis' : 'format',
    content: typeof search.content === 'string' ? search.content : undefined,
  }),
  head: () => ({
    meta: [{ title: `LPC - ${import.meta.env.VITE_SITE_NAME}` }],
  }),
  component: LpcRoute,
})

function LpcRoute() {
  const { mode, content } = Route.useSearch()
  const navigate = Route.useNavigate()
  let initialInput = ''
  let inputError: string | undefined
  if (content !== undefined) {
    try {
      initialInput = decodeLpcUrlContent(content)
    } catch {
      inputError = 'URL 中的 LPC 内容无效'
    }
  }
  return (
    <LpcPage
      mode={mode ?? 'format'}
      initialInput={initialInput}
      inputError={inputError}
      onSaveInput={(input) => {
        void navigate({
          search: (previous) => ({
            ...previous,
            content: encodeLpcUrlContent(input),
          }),
          replace: true,
        })
      }}
      onClearInput={() => {
        void navigate({
          search: (previous) => ({ ...previous, content: undefined }),
          replace: true,
        })
      }}
      onModeChange={(nextMode) => {
        void navigate({
          search: (previous) => ({ ...previous, mode: nextMode }),
          replace: true,
        })
      }}
    />
  )
}
