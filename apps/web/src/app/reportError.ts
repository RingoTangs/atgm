export const reportError = (error: unknown) => {
  // 错误上报接入点：模板尚未配置生产环境监控。
  if (import.meta.env.DEV) {
    console.error('Unhandled application error', error)
  }
}
