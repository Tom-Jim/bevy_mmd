# Bevy MMD Player

This project renders PMX models and plays VMD animation in Rust and Bevy. Zig builds the native Jolt soft-body library for hair and cloth simulation. The default model is Robin's Sunny Song from Honkai: Star Rail, with `assets/VMD/贝洛伯格第三节.vmd` as the default motion.

## Build

Requirements: Rust 1.95 or newer, Zig 0.16.0, and a native C/C++ toolchain. macOS also requires Xcode Command Line Tools.

```sh
cargo build --locked
cargo build --release --locked
```

These commands compile only. They do not open the Bevy window or run tests. `run.sh` is also compile-only. The native build uses Zig `ReleaseSafe`; on macOS it repacks static archives so the linker can consume Zig object alignment correctly.

When the player is run interactively, Bevy's frame-time diagnostics log smoothed FPS and frame time once per second. This is intended to make frame pacing regressions visible without adding a debug overlay to the scene.

The native Jolt bridge currently targets host builds and is not configured for Rust cross compilation. Linux builds need the usual graphics, audio, libc++, and development packages.

## Model and Motion Input

Edit `config.toml` to set `paths.pmx` and `paths.vmd`. Paths may be relative to `assets/` or absolute. The default model path is:

```text
assets/模型/星穹铁道—知更鸟·晴歌_by_崩坏：星穹铁道_7add4ed08c748c72b54fc18b0918572f/星穹铁道—知更鸟·晴歌.pmx
```

Drop files onto the application window at runtime:

- A `.pmx` file replaces the model, materials, meshes, skeleton, colliders, and soft body. The active motion restarts.
- A `.vmd` file replaces the motion and resets playback and cloth state.
- UTF-8 paths, case-insensitive extensions, and files outside the project directory are supported.
- If several files of the same type are dropped in one frame, the last one is selected. When both types are dropped, the model is processed first.
- A parse failure keeps the current scene. Drag and drop changes runtime state only and never rewrites `config.toml`.

Textures must retain the relative directory layout expected by the PMX file. Follow the usage terms shipped with each asset; this repository does not relicense them.

## GPU Skinning

Rigid model materials now use Bevy's built-in WGSL skinned-mesh path. PMX joint indices and weights are uploaded as vertex attributes, bone transforms are updated as joint entities, and the Bevy PBR vertex shader performs weighted position and normal transforms in parallel on the GPU. Rigid material meshes are no longer rewritten on the CPU every frame.

Soft-body material meshes intentionally omit joint attributes because their cloth vertices are corrected by the native solver and written through the model-only mesh path. This keeps the render bind group compatible while avoiding a second GPU skinning transform on already-deformed cloth.

CPU work remains where it is required: PMX/VMD parsing, file I/O, FK/IK control flow, Jolt integration, and the small set of cloth vertices that receive physical corrections. This split avoids moving serial or native-library code into WGSL while removing the largest full-mesh CPU copy.

## Physics

Animation, FK/IK control, and physics advance at a fixed 60 Hz step. Cloth vertices are welded by material domain, anchored to load-bearing bones, and driven by time-step-scaled shape matching. Stretch, shear, bend compliance, solver iterations, gravity, damping, and speed limits are configured in `config.toml`.

Rigid PMX surface triangles form a deforming collision shell and use the same four-bone weighted skinning as the visible mesh, so animated collision geometry stays aligned with the rendered model. Static PMX rigid bodies remain available as a fallback sphere, box, or capsule proxy when a model has no usable shell. Contact projection removes inward velocity, handles large shell triangles through a fallback broad phase, and clamps excessive displacement. NaN recovery, loop restart, and model/motion replacement reset the soft-body state. The zphysics allocator uses synchronized access to its allocation map.

The current solver does not provide cloth self-collision, continuous collision detection, or the full PMX dynamic rigid-body and joint chain. Models without useful static collision bodies can still intersect during extreme motion.

## Project Layout

```text
config.toml              Runtime model, motion, physics, and lighting settings
src/main.rs              Plugin registration and schedule setup
src/setup/               Scene, camera, lights, and initial asset loading
src/file_drop.rs         PMX/VMD drag-and-drop replacement
src/pmx/                 PMX conversion, meshes, materials, and colliders
src/vmd/                 VMD parsing and interpolation
src/animation/           FK, IK, GPU joint updates, and cloth synchronization
src/softbody/            Cloth welding, anchors, and accessory mapping
src/physics/             Native physics bindings and shutdown cleanup
src/components/          Shared ECS components and resources
src/api.zig              Jolt initialization, stepping, and shutdown
src/jolt_softbody.cpp    Soft-body creation and collision projection
assets/shaders/          PMX material shaders
deps/                    Vendored native dependency and local build notes
build.rs / build.zig     Rust and native build bridge
```

Unused recording code, demo physics, debug dumps, frame-by-frame prints, and unused VMD camera/light parsing were removed.

## Dependencies

The direct Rust dependencies are Bevy 0.19.1, bevy_panorbit_camera 0.35.1, PMXUtil 0.9.0, vmd_parser 0.1.0, serde 1.0.229, and toml 1.1.5. `Cargo.lock` pins the complete resolved dependency graph.

The native dependency is vendored zphysics with Jolt 5.6.0 and a Zig 0.16 allocator synchronization adjustment. See `deps/README.md` for the upstream revision and local changes.
