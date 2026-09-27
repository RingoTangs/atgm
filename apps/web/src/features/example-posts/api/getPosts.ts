import type { Post } from '../model/types'
import { sleep } from '@/lib/sleep'

const POSTS_PREVIEW_DATA: Post[] = [
  {
    id: 1,
    userId: 1,
    title: 'Architecture boundaries stay explicit',
    body: 'Keep route orchestration, feature queries, and shared utilities in their own layers.',
  },
  {
    id: 2,
    userId: 1,
    title: 'Query options belong to the feature',
    body: 'Loaders and hooks should share the same feature-owned queryOptions helper.',
  },
  {
    id: 3,
    userId: 2,
    title: 'App composes infrastructure',
    body: 'Providers, router setup, and monitoring stay in app so features remain portable.',
  },
  {
    id: 4,
    userId: 2,
    title: 'Shared code stays environment-agnostic',
    body: 'Pass config-derived values from callers instead of reading runtime env in shared utilities.',
  },
  {
    id: 5,
    userId: 3,
    title: 'Template examples should work offline',
    body: 'Use local async sample data by default so the starter is reliable in demos and internal networks.',
  },
]

export const getPosts = async (): Promise<Post[]> => {
  await sleep(150)
  return POSTS_PREVIEW_DATA
}
