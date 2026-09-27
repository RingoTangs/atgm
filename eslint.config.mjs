import antfu from '@antfu/eslint-config'
import prettier from 'eslint-config-prettier'

export default antfu(
  {
    type: 'app',
    react: true,
    typescript: true,
    stylistic: false,
    formatters: false,
    gitignore: true,
    test: true,
    ignores: ['**/pnpm-lock.yaml', '**/routeTree.gen.ts'],
  },
  {
    files: ['./apps/web/**/*.ts', './apps/web/**/*.tsx'],
    rules: {
      'react-refresh/only-export-components': 'off',
    },
  },
).append(prettier)
