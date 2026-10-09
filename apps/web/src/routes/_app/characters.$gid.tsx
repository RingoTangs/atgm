import { createFileRoute } from '@tanstack/react-router'
import { CharacterDetailPage } from '@/features/characters/CharacterDetailPage'

export const Route = createFileRoute('/_app/characters/$gid')({
  head: () => ({
    meta: [{ title: `角色详情 - ${import.meta.env.VITE_SITE_NAME}` }],
  }),
  component: CharacterDetailRoute,
})

function CharacterDetailRoute() {
  const { gid } = Route.useParams()
  return <CharacterDetailPage gid={gid} />
}
