# Bevy 3D Animation & Soft Body Physics Player
# Bevy 3D 动画与软体物理播放器

[English](#english) | [中文](#中文)

---

<a id="english"></a>
## 🇬🇧 English

This is an advanced, real-time 3D animation and physics player built with the [Bevy Engine](https://bevyengine.org/) (Rust) and [Jolt Physics](https://github.com/jrouwe/JoltPhysics) (C++ via Zig FFI). It is specifically designed to load MikuMikuDance (MMD) assets (`.pmx` models and `.vmd` motions) and accurately simulate complex cloth and hair dynamics using Soft Body physics.

### ✨ Key Features

- **PMX Model Loading**: Fully parses bones, vertices, faces, textures, materials, and rigid bodies.
- **VMD Motion Playback**: Implements full skeletal animation playback with support for Forward Kinematics (FK) and Inverse Kinematics (IK) via Cyclic Coordinate Descent (CCD).
- **Compute-Shader-less CPU Skinning**: High-performance CPU-side skinning mechanism that bridges raw PMX vertex data directly into Bevy's `Mesh3d` attributes.
- **Advanced Soft Body Physics**: Replaces rigid body proxy chains with true interconnected soft-body physics for skirts, ribbons, sleeves, and hair.

### 🧠 Soft Body Physics Deep Dive

Handling raw PMX meshes in a physics engine presents unique topological challenges. This project implements a robust pipeline to turn static, fragmented rendering meshes into smooth, dynamic fabrics:

1. **Spatial Welding (Vertex Deduplication)**:
   PMX meshes often have disconnected triangles at UV seams or sharp edges. If fed directly into a physics engine, the cloth will instantly shatter into individual triangles. This project maps and welds vertices within a `0.001` spatial distance, converting complex disconnected rendering meshes into a single, unified topological fabric for the physics solver.
2. **Edge Compliance Tuning**:
   Instead of rigidly locking edge lengths (which causes the solver to explode under complex mesh deformations), the system applies a `0.2f` compliance factor to edge constraints. This gives the fabric a natural, slightly stretchable textile quality while preventing Jolt from freezing or exploding.
3. **Soft Shape Matching & Anti-Clipping**:
   Because PMX clothing lacks full volumetric constraints and traditional collision capsules aren't perfectly mapped, we utilize a custom "Soft Shape Matching" algorithm. Free-falling vertices receive a gentle spring-like acceleration (`diff * 5.0f`) towards their intended animated skinning positions. This ensures the cloth organically follows the character's movement, sways with inertia, and inherently resists catastrophic clipping.
4. **Anchor Pinning (Kinematic Roots)**:
   By analyzing bone weights and a comprehensive dictionary of clothing/hair keywords (supporting English, Chinese, and Japanese PMX naming conventions), the system intelligently identifies "root" vertices attached to the torso/head and pins their inverse mass to `0.0`.

### 🚀 How to Run

1. **Install Toolchains**: Ensure you have `Rust` and `Zig` installed (Zig is used as the C/C++ cross-compiler for Jolt Physics).
2. **Prepare Assets**: Place your `.pmx` model and its corresponding textures into the `assets` folder. Place your `.vmd` motion file into the same directory.
3. **Configure Paths**: Update the `PMX_FILE_PATH` and `VMD_FILE_PATH` constants in `src/main.rs` to point to your files.
4. **Build & Run**:
   ```bash
   cargo run --release
   ```

---

<a id="中文"></a>
## 🇨🇳 中文

这是一个高级的实时 3D 动画与物理播放器，基于 [Bevy 引擎](https://bevyengine.org/) (Rust) 和 [Jolt Physics](https://github.com/jrouwe/JoltPhysics) (通过 Zig FFI 调用的 C++ 引擎) 构建。它专为加载 MikuMikuDance (MMD) 资产（`.pmx` 模型和 `.vmd` 动作数据）而设计，并能够使用软体物理（Soft Body）极其精确地模拟复杂的衣物和头发动态。

### ✨ 核心特性

- **PMX 模型加载**：完整解析骨骼、顶点、面、贴图、材质以及刚体等原生数据。
- **VMD 动作回放**：实现完整的骨骼动画播放，支持正向运动学 (FK) 以及基于循环坐标下降 (CCD) 的反向运动学 (IK)。
- **纯 CPU 蒙皮架构**：高性能的 CPU 端蒙皮机制，将 PMX 原始顶点动画数据高效、直接地映射到 Bevy 的 `Mesh3d` 属性中。
- **高级软体物理模拟**：抛弃了传统的刚体碰撞代理链，使用真正相互连接的软体物理来模拟裙摆、丝带、袖子和头发。

### 🧠 软体物理架构深度解析

直接将 PMX 渲染网格丢给物理引擎通常会导致灾难性的拓扑错误。本项目实现了一套健壮的管线，将静态且破碎的渲染网格转化为流畅动态的物理布料：

1. **空间顶点缝合 (Spatial Welding)**：
   PMX 网格在 UV 接缝处通常有大量重叠但相互断开的重复顶点。如果不作处理直接丢进物理引擎，布料会瞬间碎裂成无数个独立的三角形。本项目在传入物理引擎前，会通过哈希表自动“缝合”空间距离在 `0.001` 以内的顶点，将破碎的渲染网格在物理层面上转变为一整块拓扑连通的完美布料。
2. **柔顺度约束回调 (Edge Compliance)**：
   如果强制锁定边缘长度，复杂的衣物网格在角色大幅度运动时极易导致物理求解器计算爆炸或锁死成硬块。系统为边缘约束引入了 `0.2f` 的柔顺度 (Compliance)，使得软体具备类似真实纺织品的微观弹性，极大地增强了物理稳定性。
3. **软性形状匹配与防穿模 (Soft Shape Matching)**：
   由于 PMX 衣服缺乏完整的体积约束，且没有手工包围盒，程序采用了一套自定义的“软性形状匹配”算法。对处于自由落体状态的布料顶点，施加一个朝着其“蒙皮动画目标坐标”的柔和弹簧加速度 (`diff * 5.0f`)。这保证了衣物既能随着角色的运动产生真实的物理惯性与重力下垂，又能在偏离过大时被温柔地拉回，从根本上防止了严重的穿模和衣服脱离模型的问题。
4. **智能根节点锚定 (Anchor Pinning)**：
   通过分析顶点骨骼权重和内置的超大跨语言词典（涵盖中、日、英对衣服和头发的命名习惯），系统能智能识别哪些顶点属于“受力根部”（如发根、腰带），并将其物理质量的倒数设为 `0.0`，将其精准钉死在角色的躯干大骨骼上。

### 🚀 运行指南

1. **安装工具链**：确保你的系统已安装 `Rust` 和 `Zig`（Zig 被用作编译 Jolt Physics C++ 代码的跨平台 C/C++ 编译器）。
2. **准备资源**：将你的 `.pmx` 模型文件及其所有贴图放入 `assets` 文件夹中。将 `.vmd` 动作文件也放入该目录。
3. **配置路径**：修改 `src/main.rs` 中的 `PMX_FILE_PATH` 和 `VMD_FILE_PATH` 常量，将其指向你放入的模型和动作文件。
4. **编译并运行**：
   ```bash
   cargo run --release
   ```
