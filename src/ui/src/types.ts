// Mirrors `src/viewer/bridge.rs`.

export type Command =
  | { cmd: "play"; playing: boolean }
  | { cmd: "seek"; time: number }
  | { cmd: "speed"; value: number }
  | { cmd: "loop"; on: boolean }
  | { cmd: "physics"; on: boolean }
  | { cmd: "reset_physics" }
  | { cmd: "jiggle"; on: boolean; strength?: number }
  | { cmd: "outline"; on: boolean }
  | { cmd: "reset_view" }
  | { cmd: "load_paths"; paths: string[] }
  | { cmd: "pointer"; x: number; y: number; button?: number; down?: boolean }
  | { cmd: "wheel"; dy: number };

export interface Status {
  model: string | null;
  motion: string | null;
  loading: boolean;
  playing: boolean;
  time: number;
  duration: number;
  speed: number;
  looping: boolean;
  physics: boolean;
  outline: boolean;
  jiggle: boolean;
  jiggle_strength: number;
  jiggle_bones: number;
  vertices: number;
  bones: number;
  morphs: number;
  bodies: number;
  dynamic_bodies: number;
  missing_bones: number;
  fps: number;
  notice: string | null;
  notice_fault: boolean;
}

/** A picked or dropped file with its path relative to the picked folder. */
export interface PickedFile {
  path: string;
  bytes: Uint8Array;
}
