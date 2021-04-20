/* eslint-env node */

const ERROR = 'error';
const WARN = 'warn';
const OFF = 'off';

module.exports = {
  parser: '@babel/eslint-parser',
  extends: [
    'eslint:recommended',
    'plugin:import/recommended'
  ],
  globals: {
    require: true,
    process: true
  },
  env: {
    es6: true,
    browser: true
  },
  plugins: [
    'import',
    '@babel'
  ],
  rules: {
    '@babel/object-curly-spacing': [ERROR, 'always'],
    '@babel/semi': ERROR,

    'array-bracket-spacing': [ERROR, 'never'],
    'arrow-parens': WARN,
    'arrow-spacing': WARN,
    'brace-style': [ERROR, '1tbs', { allowSingleLine: true }],
    'comma-dangle': [ERROR, 'never'],
    'comma-spacing': ERROR,
    'comma-style': [ERROR, 'last'],
    'curly': [ERROR, 'all'],
    'eqeqeq': [ERROR, 'smart'],
    'id-length': ERROR,
    'indent': [ERROR, 2, { SwitchCase: 1, MemberExpression: 1, FunctionDeclaration: { parameters: 'first' }, FunctionExpression: { parameters: 'first' } }],
    'jsx-quotes': ERROR,
    'key-spacing': ERROR,
    'keyword-spacing': ERROR,
    'linebreak-style': ERROR,
    'no-const-assign': ERROR,
    'no-duplicate-imports': ERROR,
    'no-else-return': WARN,
    'no-eval': ERROR,
    'no-implied-eval': ERROR,
    'no-multi-spaces': ERROR,
    'no-new-require': ERROR,
    'no-trailing-spaces': ERROR,
    'no-unsafe-negation': ERROR,
    'no-unused-vars': [ERROR, { varsIgnorePattern: '^_', argsIgnorePattern: '^_' }],
    'no-useless-rename': WARN,
    'no-var': WARN,
    'one-var': [ERROR, { initialized: 'never' }],
    'one-var-declaration-per-line': ERROR,
    'prefer-const': WARN,
    'radix': WARN,
    'semi-spacing': ERROR,
    'space-before-function-paren': [ERROR, 'never'],
    'space-in-parens': [ERROR, 'never'],
    'space-infix-ops': ERROR,
    'space-unary-ops': ERROR,
    'strict': ERROR,
    'unicode-bom': ERROR,

    'import/extensions': [ERROR, "never", { "css": "always", "png": "always", "svg": "always" }],
    'import/unambiguous': OFF,
    'import/no-unresolved': ERROR
  }
};
