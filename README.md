# ATGM

ATGM 是一个面向 AskTao 游戏管理场景的 full-stack monorepo，使用 pnpm workspace 管理 Web 与 Server 应用。

```text
apps/
  web/       React Web 应用
  server/    Fastify Node.js 服务
```

## 技术栈

- Web：React、Vite、TanStack Router、TanStack Query、Tailwind CSS、Vitest
- Server：Fastify、Zod、Kysely、mysql2、TypeScript、tsx、tsdown、Vitest
- 工程工具：pnpm workspace、ESLint、Prettier、`@ringotangs/tsconfig`

## 环境要求

- Node.js `22.23.2`
- pnpm `10.24.0`

## 安装

```bash
pnpm install
```

## 开发

```bash
pnpm dev          # 同时启动 Web 与 Server
pnpm dev:web      # 仅启动 Web，默认端口 3000
pnpm dev:server   # 仅启动 Server，默认端口 8080
```

## 检查与构建

```bash
pnpm check
pnpm build
```

`pnpm check` 依次执行 ESLint、Prettier check、TypeScript typecheck 和 Vitest tests。Server 构建产物会将 Fastify 保持为外部依赖，因此生产运行前仍需安装 production dependencies。

## Server 环境变量

| 变量               | 默认值    | 说明                                                      |
| ------------------ | --------- | --------------------------------------------------------- |
| `HOST`             | `0.0.0.0` | Server 监听地址                                           |
| `PORT`             | `8080`    | Server 监听端口，必须是 `1` 到 `65535` 的十进制整数字符串 |
| `MYSQL_HOST`       | —         | MySQL Server 地址                                         |
| `MYSQL_PORT`       | `3306`    | MySQL Server 端口                                         |
| `MYSQL_USER`       | —         | MySQL 用户名                                              |
| `MYSQL_PASSWORD`   | —         | MySQL 密码                                                |
| `MYSQL_ACCOUNT_DB` | —         | Account database 名称                                     |
| `MYSQL_GAME_DB`    | —         | Game database 名称                                        |

`apps/server/.env.example` 仅提供配置示例。当前启动命令不会自动加载 `.env`；请通过运行环境或 shell 设置变量。开发时也可以复制为已忽略的 `apps/server/.env.local`，并显式使用 Node.js 22 加载：

```bash
cd apps/server
node --env-file=.env.local --watch --import tsx src/server.ts
```

## Database

Server 使用 Kysely 和 mysql2 访问 MySQL 5.7。同一台 MySQL Server 上的 account database 与 game database 共享一个连接池和一个 Kysely 根实例，`MYSQL_ACCOUNT_DB`、`MYSQL_GAME_DB` 仅指定各自的数据库名称。应用关闭时，Fastify 的 `onClose` hook 会销毁根实例并释放连接池。

如果将来两个数据库使用不同账号、位于不同 MySQL Server，或需要独立的连接池隔离，再拆分为多个 Kysely 和 pool 实例。

## Web 环境变量

公开默认值保存在已跟踪的 `apps/web/.env` 中：

| 变量                     | 默认值    | 说明                                   |
| ------------------------ | --------- | -------------------------------------- |
| `VITE_BASE_PATH`         | `/`       | 部署基础路径                           |
| `VITE_ROUTER_HISTORY`    | `browser` | 路由历史模式，可选 `browser` 或 `hash` |
| `VITE_SITE_NAME`         | `ATGM`    | 页面站点名称                           |
| `VITE_THEME_STORAGE_KEY` | `theme`   | 本地主题设置的存储键                   |

所有 `VITE_` 变量都会暴露给浏览器，不应包含密钥。
