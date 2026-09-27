import { createFileRoute, useNavigate } from '@tanstack/react-router'
import { Button } from '@/components/Button'
import { sleep } from '@/lib/sleep'

const LoadingDemoPage: React.FC = () => {
  const navigate = useNavigate()

  const handleReload = () => {
    // 保留当前完整 URL，避免整页导航丢失 hash history 的部署前缀。
    window.location.reload()
  }

  return (
    <div className="bg-background flex min-h-screen flex-col items-center justify-center p-8 text-center font-sans">
      <h1 className="text-foreground mb-4 text-4xl leading-tight font-bold">
        Router Loading Demo
      </h1>
      <p className="text-muted-foreground mb-8 max-w-[500px] text-lg">
        Client-side navigation to this route displays the top progress bar while
        its loader waits. Reload the page to display the full-screen spinner
        during initial route resolution.
      </p>
      <div className="flex flex-wrap justify-center gap-4">
        <Button size="lg" onClick={handleReload}>
          Reload Spinner
        </Button>
        <Button
          size="lg"
          variant="outline"
          onClick={() => navigate({ to: '/' })}
        >
          Back to Home
        </Button>
      </div>
    </div>
  )
}

export const Route = createFileRoute('/loading')({
  loader: () => sleep(1500),
  head: () => ({
    meta: [
      {
        title: `Router Loading Demo - ${import.meta.env.VITE_SITE_NAME}`,
      },
      {
        name: 'description',
        content: 'Demonstrates initial and navigation loading feedback.',
      },
    ],
  }),
  component: LoadingDemoPage,
})
