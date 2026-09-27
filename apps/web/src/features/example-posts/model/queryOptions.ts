import { queryOptions } from '@tanstack/react-query'
import { getPosts } from '../api/getPosts'
import { postQueryKeys } from './queryKeys'

export const postsQueryOptions = () => {
  return queryOptions({
    queryKey: postQueryKeys.preview(),
    queryFn: getPosts,
  })
}
