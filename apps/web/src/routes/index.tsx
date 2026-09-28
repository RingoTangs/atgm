import { createFileRoute } from '@tanstack/react-router'

const HomePage: React.FC = () => {
  return <div className="bg-background min-h-screen">Home Page</div>
}

export const Route = createFileRoute('/')({
  head: () => ({
    meta: [{ title: `Home - ${import.meta.env.VITE_SITE_NAME}` }],
  }),
  component: HomePage,
})
