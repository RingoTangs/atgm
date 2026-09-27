import antfu from '@antfu/eslint-config'
import prettier from 'eslint-config-prettier'

export default antfu(
  {
    type: 'app',
    typescript: true,
    react: true,
    test: true,
    stylistic: false,
    formatters: false,
    gitignore: true,
    ignores: ['**/pnpm-lock.yaml', '**/routeTree.gen.ts'],
  },

  // Web-specific rules
  {
    name: 'atgm/web',
    files: ['apps/web/**/*.{ts,tsx}'],
    rules: {
      'react-refresh/only-export-components': 'off',
    },
  },
).append(prettier)
