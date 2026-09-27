import type { Post } from '../model/types'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { act, cleanup, render, screen } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { getPosts } from '../api/getPosts'
import { postQueryKeys } from '../model/queryKeys'
import { PostsPreview } from './PostsPreview'

vi.mock('../api/getPosts', () => ({ getPosts: vi.fn() }))
const mockedGetPosts = vi.mocked(getPosts)
const queryClients: QueryClient[] = []
const posts: Post[] = [
  {
    id: 1,
    userId: 1,
    title: 'Architecture boundaries',
    body: 'Keep feature data access inside the owning feature.',
  },
]

const renderPreview = () => {
  const queryClient = new QueryClient({
    defaultOptions: { queries: { retry: false, staleTime: 30_000 } },
  })
  queryClients.push(queryClient)
  render(
    <QueryClientProvider client={queryClient}>
      <PostsPreview />
    </QueryClientProvider>,
  )
  return queryClient
}

beforeEach(() => {
  mockedGetPosts.mockReset()
})
afterEach(() => {
  cleanup()
  queryClients.splice(0).forEach((client) => client.clear())
})

describe('posts preview', () => {
  it('renders loading state', () => {
    mockedGetPosts.mockReturnValue(new Promise(() => {}))
    renderPreview()
    expect(screen.getByText('Loading posts...')).toBeInTheDocument()
  })
  it('renders empty state', async () => {
    mockedGetPosts.mockResolvedValue([])
    renderPreview()
    expect(await screen.findByText('No posts found')).toBeInTheDocument()
  })
  it('renders post cards', async () => {
    mockedGetPosts.mockResolvedValue(posts)
    renderPreview()
    expect(
      await screen.findByText('Architecture boundaries'),
    ).toBeInTheDocument()
    expect(screen.getByText('Post #1')).toBeInTheDocument()
  })
  it('retries an initial failure and disables retry while fetching', async () => {
    mockedGetPosts.mockRejectedValueOnce(new Error('Network unavailable'))
    let resolveRetry!: (value: Post[]) => void
    mockedGetPosts.mockReturnValueOnce(
      new Promise<Post[]>((resolve) => {
        resolveRetry = resolve
      }),
    )
    const user = userEvent.setup()
    renderPreview()
    expect(await screen.findByText('Network unavailable')).toBeInTheDocument()
    await user.click(screen.getByRole('button', { name: 'Try Again' }))
    expect(
      await screen.findByRole('button', { name: 'Retrying...' }),
    ).toBeDisabled()
    await act(async () => resolveRetry(posts))
    expect(
      await screen.findByText('Architecture boundaries'),
    ).toBeInTheDocument()
    expect(screen.queryByText('Failed to load posts')).not.toBeInTheDocument()
    expect(mockedGetPosts).toHaveBeenCalledTimes(2)
  })
  it.each([
    { data: posts, visibleText: 'Architecture boundaries' },
    { data: [], visibleText: 'No posts found' },
  ])(
    'preserves cached $visibleText when a background refresh fails',
    async ({ data, visibleText }) => {
      mockedGetPosts
        .mockResolvedValueOnce(data)
        .mockRejectedValueOnce(new Error('Refresh unavailable'))
      const user = userEvent.setup()
      const queryClient = renderPreview()
      await screen.findByText(visibleText)
      await act(async () => {
        await queryClient.invalidateQueries({
          queryKey: postQueryKeys.preview(),
        })
      })
      expect(await screen.findByRole('alert')).toHaveTextContent(
        'Refresh unavailable',
      )
      expect(screen.getByText(visibleText)).toBeInTheDocument()
      expect(screen.queryByText('Failed to load posts')).not.toBeInTheDocument()
      let resolveRetry!: (value: Post[]) => void
      mockedGetPosts.mockReturnValueOnce(
        new Promise<Post[]>((resolve) => {
          resolveRetry = resolve
        }),
      )
      await user.click(screen.getByRole('button', { name: 'Try Again' }))
      expect(
        await screen.findByRole('button', { name: 'Retrying...' }),
      ).toBeDisabled()
      expect(screen.getByText(visibleText)).toBeInTheDocument()
      await act(async () => resolveRetry(posts))
      expect(
        await screen.findByText('Architecture boundaries'),
      ).toBeInTheDocument()
      expect(screen.queryByRole('alert')).not.toBeInTheDocument()
      expect(mockedGetPosts).toHaveBeenCalledTimes(3)
    },
  )
})
