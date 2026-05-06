# Bevy 3D Animation & Physics Player

This is a real-time 3D animation and physics player using the [Bevy](https://bevyengine.org/) engine and [Avian3D](https://github.com/Jondolf/avian) physics engine. It is capable of loading MikuMikuDance (MMD) models (`.pmx` format) and motion data (`.vmd` format) and simulating physics for things like skirts and hair.

## Features

- **PMX Model Loading**: Supports loading bones, vertices, faces, materials, and rigid bodies/joints directly from PMX files.
- **VMD Motion Playback**: Full support for bone animations using VMD data, bringing characters to life.
- **Real-Time Physics**: Uses `avian3d` to automatically simulate physics for character clothing and hair, driven by the PMX model's predefined Rigid Bodies and Spring 6DOF Joints.
- **Compute-Shader-less CPU Skinning**: Performs multi-threaded CPU skinning mapping Bevy `Mesh3d` components with the PMX `AnimBoneTransforms`.

## How to Run

1. Place your PMX model file and its textures into the `assets` folder. Make sure the `.pmx` file is correctly referenced by modifying the constant `PMX_FILE_PATH` in `src/main.rs`.
2. Place your VMD motion file into the `assets` folder and update `VMD_FILE_PATH` in `src/main.rs`.
3. Run the project using cargo:

```bash
cargo run --release
```

## Physics Pipeline Details

The implementation accurately translates predefined MMD physics parameters into Avian3D physics constructs:
- **Kinematic & Dynamic Bodies**: PMX rigid bodies are mapped to `RigidBody::Kinematic` (driven by the animation) and `RigidBody::Dynamic` (driven by physics).
- **Physics Readback System**: Synchronizes simulated rigid bodies back to the animation rig (`AnimBoneTransforms`), affecting vertex skinning so that clothing and hair react organically to motion and gravity.
