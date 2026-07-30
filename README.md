# Bevy MMD: High-Performance 3D Animation and Soft-Body Physics Player

[![Build Status](https://github.com/Tom-Jim/bevy_mmd/actions/workflows/ci.yml/badge.svg)](https://github.com/Tom-Jim/bevy_mmd/actions/workflows/ci.yml)
[![Release Status](https://github.com/Tom-Jim/bevy_mmd/actions/workflows/release.yml/badge.svg)](https://github.com/Tom-Jim/bevy_mmd/actions/workflows/release.yml)

> **Work in Progress.** This project is under active development. The following known limitations apply:
> 1. **Collision detection is not yet implemented.** The engine applies soft-body constraints without collision geometry, so mesh interpenetration is expected at this stage.
> 2. **Soft-body detachment bug.** Skeletal animation and rigid-mesh rendering are fully functional; however, soft-body components (skirts, hair) exhibit occasional detachment from the model due to an unresolved defect in the kinematic root pinning logic.

![Physics Demo](docs/physics_demo_wip.gif)

<img src="assets/records/output.gif" width="100%" alt="Physics Demo">

---

## Overview

This project is a real-time 3D animation and physics player implemented in [Rust](https://www.rust-lang.org/) using the [Bevy Engine](https://bevyengine.org/) and [Jolt Physics](https://github.com/jrouwe/JoltPhysics) (a C++ physics library compiled via a Zig build system and exposed through a C FFI layer). The system is specifically designed to ingest MikuMikuDance (MMD) assets — `.pmx` skeletal models and `.vmd` motion-capture files — and to simulate complex cloth and hair dynamics through a position-based soft-body physics solver.

---

## Key Features

- **PMX Model Loading.** Parses bones, vertices, faces, UV coordinates, materials, texture references, and vertex morph targets from the PMX 2.0 binary format.
- **VMD Motion Playback.** Implements a complete skeletal animation pipeline supporting Forward Kinematics (FK) and Inverse Kinematics (IK) via the Cyclic Coordinate Descent (CCD) algorithm, with per-axis cubic Bézier curve interpolation between keyframes.
- **Single-Pass CPU Skinning.** Transforms all model vertices exactly once per frame and distributes the shared result to each material sub-mesh, eliminating redundant per-mesh skinning computations.
- **Soft-Body Physics Simulation (In Development).** Hair, skirts, and cloth panels are driven by a Jolt Physics position-based soft-body solver rather than the conventional rigid-body proxy chain approach.

---

## Soft-Body Physics: Technical Architecture

Directly submitting a PMX rendering mesh to a physics solver produces catastrophic topological failures. The following pipeline converts the static, fragmented rendering geometry into a physically stable cloth representation.

### 1. Spatial Vertex Welding

PMX meshes commonly contain topologically disconnected duplicate vertices at UV seams and sharp edges. Submitted without preprocessing, the simulated cloth immediately shatters into individual unconnected triangles. The system resolves this by hashing vertex positions quantised to a spatial tolerance of `0.001` units and merging all vertices that fall within this threshold, producing a single topologically connected fabric mesh suitable for constraint-based simulation.

Hair materials are treated as separate topological domains: vertices belonging to distinct hair material groups are deliberately not welded to one another. Cross-material welding causes separate hair strands (e.g., front fringe and posterior strands) to merge into a single body, producing violent simulation instability.

### 2. Edge Compliance

Enforcing strictly inextensible edge-length constraints causes the solver to enter degenerate states under large skeletal deformations, resulting in cloth panels freezing or exhibiting explosive constraint violation. The system assigns a compliance factor of `0.2` to all edge constraints, permitting a small controlled degree of extension. This imparts the elastic quality characteristic of real textile while preserving solver stability across the full range of character motion.

### 3. Soft Shape Matching (Pose Tracking)

Because PMX clothing geometry encodes no volumetric body constraints, an unguided simulation causes cloth to drift away from the character indefinitely. Each simulation step, free-falling vertices receive a spring-like acceleration directed toward their corresponding skinned animation target positions, scaled by a configurable `position_pull` coefficient, along with a proportional velocity contribution scaled by `velocity_pull`. This causes the cloth to organically follow the skeletal animation while retaining physically plausible inertia and gravitational drape.

### 4. Kinematic Root Pinning

The system identifies anchor vertices — those weighted primarily to core torso or limb bones — by evaluating per-vertex bone weights against a curated dictionary of load-bearing bone name patterns (supporting English, Japanese, and Chinese PMX naming conventions). Vertices satisfying the anchor criterion have their inverse mass set to `0.0`, pinning them unconditionally to the skeletal animation position. This prevents cloth from detaching at attachment points.

Accessory meshes (hair ornaments, lining panels, identification tags) are not assigned independent physics particles. Instead, each accessory vertex is attached to the nearest soft-body particle of the matching material type (hair accessories to hair particles; cloth accessories to cloth particles), inheriting the parent particle's dynamics while preserving the accessory's local geometric offset.

### 5. Isolated Fragment Handling

Soft-body meshes occasionally contain topologically disconnected sub-components with no anchor vertices — for example, terminal hair-tip fragments. Small isolated components (fewer than 300 vertices) are unconditionally pinned to prevent uncontrolled free-fall. Pinning large isolated components is deliberately avoided: doing so would freeze an entire cloth panel into a static rigid surface, which is physically incorrect.

---

## Getting Started

### Prerequisites

- [Rust](https://www.rust-lang.org/tools/install) — stable toolchain
- [Zig](https://ziglang.org/download/) — required to compile the Jolt Physics C++ library
- MMD assets: a `.pmx` model file with accompanying textures, and a `.vmd` motion file

### Configuration

Open `src/config.toml` and set the `pmx` and `vmd` fields to the relative paths of your asset files within the `assets/` directory.

### Building and Running

```bash
git clone https://github.com/Tom-Jim/bevy_mmd.git
cd bevy_mmd
chmod +x run.sh
./run.sh
```

To capture an LLDB backtrace automatically on crash (useful for diagnosing soft-body detachment):

```bash
./run.sh --debug
```

---

## Project Goal

The long-term objective of this project is to deliver the most performant, drop-in MMD rendering and physics middleware for the Bevy engine, replacing conventional rigid-body proxy chains with true interconnected soft-body simulation for all secondary motion elements. Pull requests are welcome.
