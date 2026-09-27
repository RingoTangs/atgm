/**
 * 异步等待指定毫秒数，默认等待 1 秒。
 */
export const sleep = (ms: number = 1000) => {
  return new Promise<void>((resolve) => setTimeout(resolve, ms))
}
