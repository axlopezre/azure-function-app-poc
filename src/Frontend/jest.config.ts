import type { Config } from "jest";
import nextJest from "next/jest.js";

const createJestConfig = nextJest({
  dir: "./",
});

const config: Config = {
  coverageProvider: "v8",
  testEnvironment: "jsdom",
  setupFilesAfterEnv: ["<rootDir>/jest.setup.ts"],
  moduleNameMapper: {
    //TODO: PUT YOUR ALIASSES HERE
    // "^@/components/(.*)$": "<rootDir>/components/$1",
    // "^@/app/(.*)$": "<rootDir>/app/$1",
    // "^@/lib/(.*)$": "<rootDir>/lib/$1",
    // "^@/hooks/(.*)$": "<rootDir>/hooks/$1",
  },
};

export default createJestConfig(config);