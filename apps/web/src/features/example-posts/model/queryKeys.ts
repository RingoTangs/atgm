export const postQueryKeys = {
  all: ['posts'] as const,
  lists: () => [...postQueryKeys.all, 'list'] as const,
  preview: () => [...postQueryKeys.lists(), 'preview'] as const,
}
