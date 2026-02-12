const nextJest = require('next/jest');

const createJestConfig = nextJest({
  dir: './',
});

const customJestConfig = {
  rootDir: '..',
  testEnvironment: 'jest-environment-jsdom',
  setupFilesAfterEnv: ['<rootDir>/frontend/jest.setup.js'],
  moduleNameMapper: {
    '^@/(.*)$': '<rootDir>/frontend/src/$1',
  },
  moduleDirectories: ['node_modules', '<rootDir>/frontend/node_modules'],
  collectCoverageFrom: [
    'frontend/src/**/*.{js,jsx,ts,tsx}',
    '!frontend/src/**/*.d.ts',
    '!frontend/src/**/*.stories.{js,jsx,ts,tsx}',
    '!tests/frontend/**',
  ],
  testMatch: ['<rootDir>/tests/frontend/**/*.{spec,test}.{js,jsx,ts,tsx}'],
  transformIgnorePatterns: ['node_modules/(?!(.*\\.mjs$))'],
};

module.exports = createJestConfig(customJestConfig);
