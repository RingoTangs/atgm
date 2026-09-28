# Repository Guidelines

## Project Structure & Module Organization

This repository is a pnpm workspace with two TypeScript applications under `apps/`:

- `apps/web/` is a React 19 + Vite frontend. Routes live in `src/routes/`, reusable UI in `src/components/`, feature code in `src/features/`, and static files in `public/`. The TanStack Router tree at `src/app/router/routeTree.gen.ts` is generated; do not edit it manually.
- `apps/server/` is a Fastify service. Application construction belongs in `src/app.ts`; process startup and environment handling belong in `src/server.ts`.

Keep tests beside the code they exercise as `*.spec.ts` or `*.spec.tsx`. Project-wide tooling is configured at the repository root.

## Build, Test, and Development Commands

Use Node `22.23.2` (see `.nvmrc`) and pnpm `10.24.0`.

- `pnpm install --frozen-lockfile` installs exactly the locked dependencies.
- `pnpm --filter atgm-web dev` starts the frontend on port 3000.
- `pnpm --filter atgm-server dev` starts the API in watch mode (port 8080 by default).
- `pnpm test`, `pnpm typecheck`, and `pnpm build` run the corresponding task across all packages.
- `pnpm check` runs linting, formatting checks, type checks, and tests; run it before submitting changes.
- `pnpm check:fix` applies ESLint and Prettier fixes.

## Coding Style & Naming Conventions

Use two-space indentation, LF endings, single quotes, trailing commas, and no semicolons. ESLint uses Antfu's TypeScript/React rules; Prettier also sorts Tailwind classes. Name React components and their files in PascalCase (`ThemeProvider.tsx`), hooks with a `use` prefix, and ordinary modules in camelCase. Prefer the `@/` alias for imports rooted at each app's `src/` directory.

## Testing Guidelines

Vitest is the test runner. Web tests use jsdom and Testing Library; server tests use Fastify's `app.inject()` in a Node environment. Add focused tests alongside changed behavior and favor user-visible assertions over implementation details. No coverage threshold is currently configured.

## Commit & Pull Request Guidelines

Recent history follows Conventional Commit prefixes such as `feat:`, `fix:`, and `test:`. Write short, imperative summaries and keep each commit focused. Pull requests should explain the change and verification performed, link relevant issues, and include screenshots for visible UI changes. CI must pass `pnpm check` and `pnpm build`.

## Configuration & Security

`apps/web/.env` contains tracked public Vite defaults. Put machine-specific or sensitive values in ignored `*.local` files, and never expose secrets through `VITE_` variables. The server development script loads ignored `apps/server/.env.local`; production reads listener and MySQL settings from the process environment.

<!-- CODEGRAPH_START -->

## CodeGraph

In repositories indexed by CodeGraph (a `.codegraph/` directory exists at the repo root), reach for it BEFORE grep/find or reading files when you need to understand or locate code:

- **MCP tool** (when available): `codegraph_explore` answers most code questions in one call — the relevant symbols' verbatim source plus the call paths between them, including dynamic-dispatch hops grep can't follow. Name a file or symbol in the query to read its current line-numbered source. If it's listed but deferred, load it by name via tool search.
- **Shell** (always works): `codegraph explore "<symbol names or question>"` prints the same output.

If there is no `.codegraph/` directory, skip CodeGraph entirely — indexing is the user's decision.
<!-- CODEGRAPH_END -->
