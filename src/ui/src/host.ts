// The viewer behind the panels: the Tauri shell (IPC) or the browser page (wasm
// bindings that src/web/boot.js publishes on `globalThis.mmd`). Both take the same
// JSON commands (src/viewer/bridge.rs) and send back the same status object.

import type { Command, PickedFile, Status } from "./types";

export interface Host {
  /** The Tauri webview covers the window, so pointer input is forwarded to Bevy. */
  readonly forwardsPointer: boolean;
  /** Drops reach the page (browser) rather than the native window (Tauri). */
  readonly handlesDrops: boolean;
  send(command: Command): void;
  loadFiles(files: PickedFile[]): Promise<void>;
  onStatus(listener: (status: Status) => void): () => void;
}

interface PageBridge {
  command(json: string): void;
  loadFiles(paths: string[], files: Uint8Array[]): void;
  last?: string;
}

declare global {
  interface Window {
    __TAURI_INTERNALS__?: unknown;
    mmd?: Partial<PageBridge>;
  }
}

async function tauriHost(): Promise<Host> {
  const { invoke } = await import("@tauri-apps/api/core");
  const { listen } = await import("@tauri-apps/api/event");
  const send = (command: Command) => {
    invoke("ui_command", { json: JSON.stringify(command) }).catch((err) => console.error("ui_command", err));
  };
  return {
    forwardsPointer: true,
    handlesDrops: false,
    send,
    async loadFiles(files) {
      for (const file of files) {
        // The bytes go as the raw request body; the path rides in a header.
        await invoke("load_file", file.bytes, { headers: { "x-path": encodeURIComponent(file.path) } });
      }
      await invoke("load_commit");
    },
    onStatus(listener) {
      const stop = listen<string>("status", (event) => listener(JSON.parse(event.payload)));
      return () => {
        stop.then((unlisten) => unlisten());
      };
    },
  };
}

function pageHost(): Host {
  const bridge = () => window.mmd as PageBridge;
  return {
    forwardsPointer: false,
    handlesDrops: true,
    send(command) {
      try {
        bridge().command(JSON.stringify(command));
      } catch (err) {
        console.error("command", err);
      }
    },
    async loadFiles(files) {
      bridge().loadFiles(
        files.map((f) => f.path),
        files.map((f) => f.bytes),
      );
    },
    onStatus(listener) {
      const handler = (event: Event) => listener(JSON.parse((event as CustomEvent<string>).detail));
      addEventListener("mmd-status", handler);
      const last = window.mmd?.last;
      if (last) listener(JSON.parse(last));
      return () => removeEventListener("mmd-status", handler);
    },
  };
}

export async function connect(): Promise<Host> {
  return window.__TAURI_INTERNALS__ ? tauriHost() : pageHost();
}
