import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// One bundle for two hosts: the Tauri webview loads `dist/index.html`; the browser page
// (src/web/index.html) loads `dist/assets/ui.js` and `ui.css` over the Bevy canvas, so
// the file names carry no hash.
export default defineConfig({
  plugins: [react()],
  base: "./",
  clearScreen: false,
  server: { port: 5173, strictPort: true },
  build: {
    target: "es2022",
    outDir: "dist",
    emptyOutDir: true,
    cssCodeSplit: false,
    modulePreload: false,
    rollupOptions: {
      output: {
        entryFileNames: "assets/ui.js",
        chunkFileNames: "assets/[name].js",
        assetFileNames: (asset) =>
          asset.names.some((n) => n.endsWith(".css")) ? "assets/ui.css" : "assets/[name][extname]",
      },
    },
  },
});
