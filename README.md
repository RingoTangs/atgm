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

先创建 Server 的本地配置并填写本机 MySQL 连接信息：

```bash
cp apps/server/.env.example apps/server/.env.local
```

`MYSQL_DL_ADB_ALL` 和 `MYSQL_DL_DDB_1` 已有 Zod 默认值，通常可以从 `.env.local` 省略；需要连接其他数据库时仍可覆盖。`.env.local` 包含本地凭据，不应提交到 Git。

```bash
pnpm dev          # 同时启动 Web 与 Server
pnpm dev:web      # 仅启动 Web，默认端口 3000
pnpm dev:server   # 仅启动 Server，默认端口 8080
```

`pnpm dev` 和 `pnpm dev:server` 会通过 Node.js 22 原生 `--env-file` 自动加载 `apps/server/.env.local`，并使用原生 watch 模式热重启 Server。生产环境使用 `pnpm --filter atgm-server start`，不会加载该开发配置文件；请由部署平台或进程管理器提供环境变量。

## 检查与构建

```bash
pnpm check
pnpm build
```

`pnpm check` 依次执行 ESLint、Prettier check、TypeScript typecheck 和 Vitest tests。Server 构建产物会将 Fastify 保持为外部依赖，因此生产运行前仍需安装 production dependencies。

## Server 环境变量

| 变量               | 默认值       | 说明                                                      |
| ------------------ | ------------ | --------------------------------------------------------- |
| `HOST`             | `0.0.0.0`    | Server 监听地址                                           |
| `PORT`             | `8080`       | Server 监听端口，必须是 `1` 到 `65535` 的十进制整数字符串 |
| `MYSQL_HOST`       | —            | MySQL Server 地址                                         |
| `MYSQL_PORT`       | `3306`       | MySQL Server 端口                                         |
| `MYSQL_USER`       | —            | MySQL 用户名                                              |
| `MYSQL_PASSWORD`   | —            | MySQL 密码                                                |
| `MYSQL_DL_ADB_ALL` | `dl_adb_all` | 可选，ADB database 名称                                   |
| `MYSQL_DL_DDB_1`   | `dl_ddb_1`   | 可选，DDB database 名称                                   |

`apps/server/.env.example` 仅提供配置示例。开发命令只自动加载 `.env.local`；生产环境仍通过系统环境变量传入配置。

## API 文档

开发环境启动 `pnpm dev:server` 后，可访问 Swagger UI：

```text
http://localhost:8080/docs
```

OpenAPI JSON 位于 `http://localhost:8080/docs/json`。Swagger 会自动收集带 Schema 的 Fastify 路由，生产环境默认不注册文档路由。Swagger UI 的 Try it out 会实际发送 HTTP 请求；业务接口仍需独立实现认证、授权和输入校验。

## Database

Server 使用 Kysely 和 mysql2 访问同一台 MySQL 5.7 Server 上的 `dl_adb_all` 与 `dl_ddb_1`。两个数据库共享一个连接池和一个 Kysely 根实例，并分别通过 `app.db.adb`、`app.db.ddb` 提供查询入口。`MYSQL_DL_ADB_ALL`、`MYSQL_DL_DDB_1` 仅指定数据库名称；Fastify 的 `onClose` hook 会销毁根实例并释放连接池。

当前仅定义了真实的 `dl_adb_all.account` 表类型。`dl_ddb_1` 的表类型将在实际需要时按对应 DDL 添加。

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
