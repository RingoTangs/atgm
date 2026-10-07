import '@testing-library/jest-dom/vitest' // 提供 toBeInTheDocument 等 DOM 断言。

const originalGetComputedStyle = window.getComputedStyle.bind(window)

// jsdom 不支持滚动条伪元素样式，沿用普通元素样式且避免重复警告。
window.getComputedStyle = (element, pseudoElement) =>
  originalGetComputedStyle(
    element,
    pseudoElement === '::-webkit-scrollbar' ? undefined : pseudoElement,
  )
