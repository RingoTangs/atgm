import { Button } from '@/components/Button'
import { useCounterStore } from '../model/counterStore'

const CounterValue: React.FC = () => {
  const count = useCounterStore((state) => state.count)

  return (
    <p
      className="text-card-foreground mt-4 text-xl tabular-nums"
      data-testid="count"
    >
      Current count: {count}
    </p>
  )
}

const CounterActions: React.FC = () => {
  const decrement = useCounterStore((state) => state.decrement)
  const increment = useCounterStore((state) => state.increment)
  const reset = useCounterStore((state) => state.reset)

  return (
    <div className="mt-6 flex flex-wrap gap-3">
      <Button
        type="button"
        size="lg"
        aria-label="Decrease count"
        onClick={decrement}
      >
        -
      </Button>
      <Button
        type="button"
        size="lg"
        aria-label="Increase count"
        onClick={increment}
      >
        +
      </Button>
      <Button type="button" size="lg" aria-label="Reset count" onClick={reset}>
        Reset
      </Button>
    </div>
  )
}

export const Counter: React.FC = () => {
  return (
    <section className="border-border bg-card text-card-foreground rounded-3xl border p-6 sm:p-8">
      <div className="max-w-2xl">
        <p className="text-primary text-sm font-medium tracking-[0.16em] uppercase">
          Zustand
        </p>
        <h2
          className="text-card-foreground mt-3 text-3xl font-semibold"
          data-testid="title"
        >
          Counter
        </h2>
        <p className="text-muted-foreground mt-3 text-sm leading-relaxed">
          Separate display and control components share one feature-owned
          Zustand store without passing state or actions through props.
        </p>
      </div>
      <CounterValue />
      <CounterActions />
    </section>
  )
}
