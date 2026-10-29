# Vendored dependencies

## Jolt Physics 5.6.0

`jolt/Jolt` is Jolt Physics 5.6.0 (`e77f175595e64cb44218cc9d9d56fc365ad0e36a`,
https://github.com/jrouwe/JoltPhysics), MIT licensed (`jolt/LICENSE`). `src/build.rs`
compiles it with the `cc` crate together with the MMD bridge in `src/physics/cpp`.

Local changes, for the browser build (`wasm32-wasip1` objects linked into the
`wasm32-unknown-unknown` module):

- `Core/Core.h`: `__wasm__` selects Jolt's existing WASM platform path, which upstream
  enables only for Emscripten.
- `Core/Semaphore.{h,cpp}`: without Emscripten pthreads the semaphore is the atomic
  counter alone. The viewer runs Jolt with `JobSystemSingleThreaded`, so nothing waits.

Directories the build skips: `Compute/{CPU,DX12,MTL,VK}`, `Renderer`, `Shaders`,
`Physics/Hair` (GPU back ends, debug drawing and GPU hair).
