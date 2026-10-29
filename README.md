# bevy3Danimation

An MMD player: PMX models animated by VMD motions. Hair, skirts and ribbons use
the model's own rigid-body rig, simulated in Jolt Physics. Chest and hips get
inertial jiggle. It runs as a Tauri 2 desktop app and in the browser on WebGPU,
from one Rust code base with Bevy 0.20 and WESL shaders.

## Layout

All source lives under `src/`:

| Path | What |
| --- | --- |
| `src/format` | PMX 2.0/2.1 and VMD parsers (left-handed values, as in the files) |
| `src/anim` | Skeleton, append (inherited) transforms, CCD IK with MMD knee handling, VMD sampling, morphs, soft-tissue jiggle |
| `src/physics` | Jolt bridge (`cpp/mmd_physics.{h,cpp}`), the MMD rigid-body rig, WASI stubs for the browser |
| `src/viewer` | Bevy plugin: loading, skinned meshes, MMD materials (`shader/*.wesl`), camera, UI bridge |
| `src/desktop` | Tauri 2 shell: Bevy draws natively under the transparent webview |
| `src/ui` | React control panels shared by the desktop and the browser |
| `src/web` | Browser page (Trunk), wasm entry point |
| `src/bin/viewer.rs` | The viewer in a plain window, for profiling |
| `src/build.rs` | Builds Jolt and the bridge with the `cc` crate |
| `deps/jolt` | Vendored Jolt Physics 5.6.0 (see `deps/README.md`) |
| `tests/` | Parser, animation, physics, viewer and asset-library tests |

## How it works

- **Animation.** Each frame samples the motion at the real frame time, so playback
  has no fixed-step judder at any refresh rate. Bones are evaluated in MMD's order
  (after-physics flag, layer, index). Inherited transforms and IK are applied as
  each bone is reached. Skinning runs on the GPU: each material is one mesh whose
  joints are only the bones it uses. Vertex and UV morphs update only the parts
  they touch, and only when their weights change.
- **Physics.** The PMX rigid bodies and joints become a Jolt world:
  - Bone-following bodies are kinematic and move with real velocities.
  - Joints are SixDOF constraints that keep MMD's limits, and its springs become
    position motors.
  - Gravity is MMD's (98 units/s²).
  - Each frame is split into equal sub-steps of at most 1/120 s.
  - Three rig conventions are handled as MikuMikuDance does, and each one tore
    cloth when missed:
    - Bodies joined by a joint never collide with each other.
    - Bodies that overlap in the bind pose ignore each other.
    - Boneless helper bodies are simulated, not pinned in place.
- **Jiggle.** A damped spring per soft-tissue bone lags behind the body's
  acceleration and bounces back. It is stiffer front-to-back than up-and-down, and
  its offset is capped so the skin never tears. Models without buttock bones get a
  pair added under `下半身`. Nearby back-of-hip vertices take a falloff share of
  their `下半身` weight, so the skin is unchanged at rest.
- **Rendering.**
  - MikuMikuDance's shading is computed in gamma space: diffuse + ambient,
    texture, sphere map, toon ramp and specular.
  - A pixel-width edge pass draws the outlines.
  - Translucent materials draw in file order with depth writes.
  - Textures are decoded by their content, not their extension (sphere maps are
    BMPs named `.spa`). They are given mipmaps, and a missing one becomes a plain
    stand-in so the material still draws.

## Running

Model files are not part of the repository. Put them under `assets/`; the default
scene is set in `src/viewer/defaults.toml`. You can also drop a PMX model folder
and a VMD motion onto the window, or open them with the panel buttons.

Desktop (Tauri):

```bash
cd src/ui && bun install && bun run build
```

```bash
cargo run --release -p bevy3d-animation-desktop
```

A distributable bundle: run `../ui/node_modules/.bin/tauri build -- --profile dist` in `src/desktop`.

Browser (WebGPU) needs a WASI sysroot with libc++ for Jolt's C++, plus Trunk:

```bash
brew install llvm wasi-libc wasi-runtimes
```

```bash
cd src/web && trunk serve --release
```

Then open http://127.0.0.1:8080. Trunk links the local `assets/` folder into the
served site, so the default scene loads there too. Other toolchains can point the
build at a sysroot with `WASI_SYSROOT` and `WASI_BUILTINS`, and at a compiler with
`CXX_wasm32_unknown_unknown`.

Plain window, for profiling:

```bash
cargo run --release --features standalone --bin viewer -- path/to/model.pmx path/to/motion.vmd
```

## Tests

```bash
cargo test --release --no-default-features
```

```bash
cargo test --release --features desktop --test viewer
```

`tests/assets.rs` plays every PMX under `assets/` with the largest VMD for ten
seconds. It fails if physics tears the mesh: if more triangle edges double in
length than with animation alone. Without a local library it skips itself.

## Controls

Left drag orbits, right or middle drag (or Shift + left drag) pans, the wheel zooms.
The panels hold play/pause, seek, speed, loop, physics, jiggle strength, outline,
and the physics and view resets.
