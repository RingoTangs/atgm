import { createFileRoute, Link } from '@tanstack/react-router'
import { Counter } from '@/features/example-counter/ui/Counter'
import { PostsPreview } from '@/features/example-posts/ui/PostsPreview'

const highlights = [
  {
    title: 'Typed Routing',
    description: 'TanStack Router with file-based routes and generated types.',
  },
  {
    title: 'Data Layer',
    description:
      'React Query wired with conservative defaults for team projects.',
  },
  {
    title: 'Quality Gates',
    description: 'TypeScript, Vitest, ESLint, and Prettier aligned for CI use.',
  },
  {
    title: 'App Boundaries',
    description:
      'Providers, monitoring, and runtime config live outside features.',
  },
]

const HomePage: React.FC = () => {
  return (
    <div className="bg-background min-h-screen">
      <div className="mx-auto max-w-6xl px-6 py-20">
        <div className="mb-20 text-center">
          <p className="text-primary mb-4 text-sm font-medium tracking-[0.2em] uppercase">
            React Template
          </p>
          <h1 className="text-foreground mb-6 text-5xl font-bold tracking-tight md:text-7xl">
            Start from a stable baseline, not a demo.
          </h1>
          <p className="text-muted-foreground mx-auto max-w-3xl text-lg leading-relaxed md:text-xl">
            This starter keeps runtime defaults conservative and pushes
            environment config, monitoring, providers, and transport concerns
            into clear boundaries.
          </p>
          <div className="mt-10 flex flex-wrap justify-center gap-4">
            <Link
              to="/loading"
              className="bg-primary text-primary-foreground hover:bg-primary/90 focus-visible:outline-ring rounded-full px-8 py-3 font-semibold shadow-lg transition-all duration-300 hover:-translate-y-0.5 focus-visible:outline-2 focus-visible:outline-offset-2"
            >
              Router Loading
            </Link>
            <Link
              to="/error"
              className="bg-primary text-primary-foreground hover:bg-primary/90 focus-visible:outline-ring rounded-full px-8 py-3 font-semibold shadow-lg transition-all duration-300 hover:-translate-y-0.5 focus-visible:outline-2 focus-visible:outline-offset-2"
            >
              Error Boundary
            </Link>
            <a
              href="https://github.com/RingoTangs/react-app"
              target="_blank"
              rel="noopener noreferrer"
              className="border-border bg-secondary text-secondary-foreground hover:border-muted-foreground hover:bg-secondary/80 focus-visible:outline-ring rounded-full border px-8 py-3 font-semibold transition-all duration-300 focus-visible:outline-2 focus-visible:outline-offset-2"
            >
              Open Repository
            </a>
          </div>
        </div>

        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
          {highlights.map((highlight) => (
            <div
              key={highlight.title}
              className="border-border bg-card text-card-foreground hover:border-primary/40 hover:bg-accent rounded-2xl border p-6 transition-all duration-300"
            >
              <h3 className="text-card-foreground mb-3 text-lg font-semibold">
                {highlight.title}
              </h3>
              <p className="text-muted-foreground text-sm leading-relaxed">
                {highlight.description}
              </p>
            </div>
          ))}
        </div>

        <div className="mt-20">
          <Counter />
        </div>

        <div className="mt-20">
          <PostsPreview />
        </div>

        <div className="text-muted-foreground mt-20 text-center">
          <p>Extend through features, keep app wiring centralized.</p>
        </div>
      </div>
    </div>
  )
}

export const Route = createFileRoute('/')({
  head: () => ({
    meta: [
      { title: `Home - ${import.meta.env.VITE_SITE_NAME}` },
      {
        name: 'description',
        content:
          'Explore Zustand shared state and TanStack Query data examples.',
      },
    ],
  }),
  component: HomePage,
})
