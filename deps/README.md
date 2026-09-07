# Native physics dependency

zphysics is based on upstream commit `9797d7bd08e4341410104876eb1896a71714277d` (latest HEAD checked 2026-09-07), with Jolt upgraded to 5.6.0 (`e77f175595e64cb44218cc9d9d56fc365ad0e36a`).
Source: https://github.com/zig-gamedev/zphysics

Local changes: Zig 0.16 allocator synchronization uses `std.atomic.Mutex` with acquire/release semantics; removed unused test targets and test source. Upstream ABI size assertions remain enabled. Do not disable allocation locking: Jolt worker threads share the allocation map.
