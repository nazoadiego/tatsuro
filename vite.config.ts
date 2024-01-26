import { defineConfig } from "vite";
import RubyPlugin from "vite-plugin-ruby";

export default defineConfig({
  clearScreen: false,
  plugins: [
    RubyPlugin(),
  ],
  root: "./app/assets",
  build: {
    manifest: true,
    rollupOptions: {
      input: "/app/javascript/entrypoints/application.js",
    },
  },
});
