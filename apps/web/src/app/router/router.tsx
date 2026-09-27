import {
  createBrowserHistory,
  createHashHistory,
  createRouter,
} from '@tanstack/react-router'
import { queryClient } from '../queryClient'
import { LoaderSync } from './LoaderSync'
import { routeTree } from './routeTree.gen'

const isHashHistory = import.meta.env.VITE_ROUTER_HISTORY === 'hash'
const history = isHashHistory ? createHashHistory() : createBrowserHistory()

// 在模块顶层创建路由，避免组件重新渲染时重复创建。
export const router = createRouter({
  routeTree,
  history,
  // Hash 中的路由从根路径开始，避免和 Hash 外的部署前缀重复。
  basepath: isHashHistory ? '/' : import.meta.env.BASE_URL,
  // 在路由匹配树的 Suspense 外同步状态，覆盖首次加载。
  InnerWrap: ({ children }) => (
    <>
      <LoaderSync />
      {children}
    </>
  ),
  context: {
    queryClient,
  },

  /**
   * 检测到用户跳转意图时，预加载路由代码和 loader 数据
   */
  defaultPreload: 'intent',

  /*
   * 将 Router 的 preload 数据新鲜时间设为 0。
   *
   * 项目使用 TanStack Query 管理服务端数据缓存，因此 Router 不负责判断
   * preload 数据是否仍然 fresh；真正导航时允许再次执行 loader，
   * 再由 QueryClient 根据 query 的 staleTime 决定是否需要重新发起请求。
   *
   * 注意：loader 再次执行不代表一定会再次发送网络请求。
   * 该配置只影响 preload 数据的 freshness，不会关闭缓存。
   */
  defaultPreloadStaleTime: 0,

  /*
   * 启用路由滚动位置恢复。
   *
   * Router 会记录每个 history entry 的滚动位置，
   * 用户通过浏览器 Back / Forward 返回页面时，
   * 自动恢复到离开前的位置。
   *
   * 注意：普通 Link / navigate 创建的新导航默认仍会滚到顶部，
   * 它和“恢复历史页面滚动位置”是两种不同的行为。
   */
  scrollRestoration: true,

  /*
   * 控制已有成功 loader 数据 stale 后的重新加载方式。
   *
   * - 'background'（默认）：
   *   立即复用旧 loader 数据完成导航，并在后台重新执行 loader。
   *   后台刷新不会让 Router 进入 foreground pending 状态。
   *
   * - 'blocking'：
   *   stale 后先重新执行 loader，并等待最新结果完成后再完成导航；
   *   因此可以触发 Router 的 pending 状态、pendingComponent 和导航进度条。
   *
   * 注意：
   * staleReloadMode 只决定“stale 后如何 reload”，
   * 不决定数据什么时候 stale；数据新鲜时间由 staleTime 控制。
   * 'blocking' 也不等于关闭缓存。
   */
  defaultStaleReloadMode: 'blocking',
})
