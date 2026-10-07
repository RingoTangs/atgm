import { createFileRoute } from '@tanstack/react-router'
import { CharactersPage } from '@/features/characters/CharactersPage'

export const Route = createFileRoute('/_app/characters/')({
  head: () => ({
    meta: [{ title: `角色管理 - ${import.meta.env.VITE_SITE_NAME}` }],
  }),
  component: CharactersPage,
})
