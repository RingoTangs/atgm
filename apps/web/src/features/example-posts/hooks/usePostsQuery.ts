import { useQuery } from '@tanstack/react-query'
import { postsQueryOptions } from '../model/queryOptions'

export const usePostsQuery = () => {
  return useQuery(postsQueryOptions())
}
