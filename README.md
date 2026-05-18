# Bevy MMD: High-Performance Animation & Soft Body Physics
# 🚧 [WIP] Bevy 3D 动画与软体物理播放器

[![Build Status](https://github.com/Tom-Jim/bevy_mmd/actions/workflows/ci.yml/badge.svg)](https://github.com/Tom-Jim/bevy_mmd/actions/workflows/ci.yml)
[![Release Status](https://github.com/Tom-Jim/bevy_mmd/actions/workflows/release.yml/badge.svg)](https://github.com/Tom-Jim/bevy_mmd/actions/workflows/release.yml)

[English](#english) | [中文](#中文) | [日本語](#日本語)

![Physics Demo](docs/physics_demo_wip.gif)

### Program Effect Demo / 程序效果演示

<img src="assets/records/output.gif" width="100%" alt="Physics Demo">

> 🚧 **Current WIP (Work In Progress) & Known Issues:**
> 1. **No Collision Detection Yet:** The engine currently implements pure soft-body constraints but does **not** yet have collision detection enabled. Mesh clipping is expected at this stage.
> 2. **Soft Body Detachment Bug:** While the non-soft body parts and skeletal animations work perfectly, the soft body parts (e.g., skirts, hair) currently suffer from a bug where they occasionally detach and fall off the main model. I am actively working on fixing the kinematic root pinning logic in the upcoming commits. 

> 🚧 **当前开发状态与已知问题 (WIP):**
> 1. **尚未实现碰撞检测：** 目前引擎仅实现了纯软体约束系统，**尚未**加入碰撞检测，因此会出现穿模现象。
> 2. **软体掉落 Bug：** 模型的非软体部分和基础骨骼动作播放完全正常。但由于锚点绑定逻辑存在 Bug，软体部分（如裙摆、头发）目前会出现脱离模型并掉落虚空的现象。我正在集中精力修复这些软体根节点的绑定问题。

> 🚧 **現在の開発状況と既知の問題 (WIP):**
> 1. **衝突判定（未実装）：** 現在は純粋なソフトボディ制約システムのみを実装しており、衝突判定（コリジョン）は**未実装**です。そのため、貫通（クリッピング）が発生します。
> 2. **ソフトボディ脱落バグ：** 非ソフトボディ部分とスケルタルアニメーションは完全に正常に動作しています。しかし、アンカー固定ロジックのバグにより、ソフトボディ部分（スカートや髪など）がモデルから脱落・落下する現象が発生しています。現在、これらのルート固定問題の修正に注力しています。

### 🎯 Goal / 我们的愿景
**To build the most performant, plug-and-play MMD rendering & physics middleware for the Bevy Engine using JoltPhysics.** We are moving away from traditional rigid-body proxy chains to true interconnected soft-body physics for skirts, hair, and clothing. **PRs are super welcome!**

---

<a id="english"></a>
## 🇬🇧 English

This is an advanced, real-time 3D animation and physics player built with the [Bevy Engine](https://bevyengine.org/) (Rust) and [Jolt Physics](https://github.com/jrouwe/JoltPhysics) (C++ via Zig FFI). It is specifically designed to load MikuMikuDance (MMD) assets (`.pmx` models and `.vmd` motions) and accurately simulate complex cloth and hair dynamics using Soft Body physics.

### ✨ Key Features

* **PMX Model Loading**: Fully parses bones, vertices, faces, textures, materials, and rigid bodies.
* **VMD Motion Playback**: Implements full skeletal animation playback with support for Forward Kinematics (FK) and Inverse Kinematics (IK) via Cyclic Coordinate Descent (CCD).
* **Compute-Shader-less CPU Skinning**: High-performance CPU-side skinning mechanism that bridges raw PMX vertex data directly into Bevy's `Mesh3d` attributes.
* **Advanced Soft Body Physics (In Development)**: Replaces rigid body proxy chains with true interconnected soft-body physics for skirts, ribbons, sleeves, and hair.

### 🧠 Soft Body Physics Deep Dive

Handling raw PMX meshes in a physics engine presents unique topological challenges. This project implements a robust pipeline to turn static, fragmented rendering meshes into smooth, dynamic fabrics:

1.  **Spatial Welding (Vertex Deduplication)**:
    PMX meshes often have disconnected triangles at UV seams or sharp edges. If fed directly into a physics engine, the cloth will instantly shatter into individual triangles. This project maps and welds vertices within a `0.001` spatial distance, converting complex disconnected rendering meshes into a single, unified topological fabric for the physics solver.
2.  **Edge Compliance Tuning**:
    Instead of rigidly locking edge lengths (which causes the solver to explode under complex mesh deformations), the system applies a `0.2f` compliance factor to edge constraints. This gives the fabric a natural, slightly stretchable textile quality while preventing Jolt from freezing or exploding.
3.  **Soft Shape Matching (Pose Tracking)**:
    Because PMX clothing lacks full volumetric constraints, we utilize a custom "Soft Shape Matching" algorithm. Free-falling vertices receive a gentle spring-like acceleration (`diff * 5.0f`) towards their intended animated skinning positions. This ensures the cloth organically follows the character's movement and sways with inertia.
4.  **Anchor Pinning (Kinematic Roots)**:
    By analyzing bone weights and a comprehensive dictionary of clothing/hair keywords (supporting English, Chinese, and Japanese PMX naming conventions), the system intelligently identifies "root" vertices attached to the torso/head and pins their inverse mass to `0.0` (Currently debugging detachment issues).

### 🚀 How to Run

1.  **Clone the Repository**: 
    ```bash
    git clone [https://github.com/Tom-Jim/bevy_mmd.git](https://github.com/Tom-Jim/bevy_mmd.git)
    cd bevy_mmd
    ```
2.  **Install Toolchains**: Ensure your system has `Rust` and `Zig` installed (Zig is used to compile the C++ Jolt Physics engine).
3.  **Prepare Assets**: Place your `.pmx` model (and its textures) and `.vmd` motion files into the `assets` folder.
4.  **Configure Paths**: Open the `src/config.toml` file and update the `pmx` and `vmd` fields to match your asset paths.
5.  **Build & Run**: Grant execution permissions to the script and run it:
    ```bash
    chmod +x run.sh
    ./run.sh
    ```
    *(Note: If you encounter memory crashes like soft-body detaching, run `./run.sh --debug` to automatically capture LLDB backtraces).*

---

<a id="中文"></a>
## 🇨🇳 中文

这是一个高级的实时 3D 动画与物理播放器，基于 [Bevy 引擎](https://bevyengine.org/) (Rust) 和 [Jolt Physics](https://github.com/jrouwe/JoltPhysics) (通过 Zig FFI 调用的 C++ 引擎) 构建。它专为加载 MikuMikuDance (MMD) 资产（`.pmx` 模型和 `.vmd` 动作数据）而设计，并能够使用软体物理（Soft Body）极其精确地模拟复杂的衣物和头发动态。

### ✨ 核心特性

* **PMX 模型加载**：完整解析骨骼、顶点、面、贴图、材质以及刚体等原生数据。
* **VMD 动作回放**：实现完整的骨骼动画播放，支持正向运动学 (FK) 以及基于循环坐标下降 (CCD) 的反向运动学 (IK)。
* **纯 CPU 蒙皮架构**：高性能的 CPU 端蒙皮机制，将 PMX 原始顶点动画数据高效、直接地映射到 Bevy 的 `Mesh3d` 属性中。
* **高级软体物理模拟 (开发中)**：抛弃了传统的刚体碰撞代理链，使用真正相互连接的软体物理来模拟裙摆、丝带、袖子和头发。

### 🧠 软体物理架构深度解析

直接将 PMX 渲染网格丢给物理引擎通常会导致灾难性的拓扑错误。本项目实现了一套健壮的管线，将静态且破碎的渲染网格转化为流畅动态的物理布料：

1.  **空间顶点缝合 (Spatial Welding)**：
    PMX 网格在 UV 接缝处通常有大量重叠但相互断开的重复顶点。如果不作处理直接丢进物理引擎，布料会瞬间碎裂成无数个独立的三角形。本项目在传入物理引擎前，会通过哈希表自动“缝合”空间距离在 `0.001` 以内的顶点，将破碎的渲染网格在物理层面上转变为一整块拓扑连通的完美布料。
2.  **柔顺度约束回调 (Edge Compliance)**：
    如果强制锁定边缘长度，复杂的衣物网格在角色大幅度运动时极易导致物理求解器计算爆炸或锁死成硬块。系统为边缘约束引入了 `0.2f` 的柔顺度 (Compliance)，使得软体具备类似真实纺织品的微观弹性，极大地增强了物理稳定性。
3.  **软性形状匹配 (Pose Tracking)**：
    由于 PMX 衣服缺乏完整的体积约束，程序采用了一套自定义的“软性形状匹配”算法。对处于自由落体状态的布料顶点，施加一个朝着其“蒙皮动画目标坐标”的柔和弹簧加速度 (`diff * 5.0f`)。这保证了衣物既能随着角色的运动产生真实的物理惯性与重力下垂。
4.  **智能根节点锚定 (Anchor Pinning)**：
    通过分析顶点骨骼权重和内置的超大跨语言词典（涵盖中、日、英对衣服和头发的命名习惯），系统能智能识别哪些顶点属于“受力根部”（如发根、腰带），并将其物理质量的倒数设为 `0.0`，将其精准钉死在角色的躯干大骨骼上（当前正在 Debug 偶发的掉落脱离问题）。

### 🚀 运行指南

1.  **克隆源码**：
    ```bash
    git clone [https://github.com/Tom-Jim/bevy_mmd.git](https://github.com/Tom-Jim/bevy_mmd.git)
    cd bevy_mmd
    ```
2.  **安装工具链**：确保你的系统已安装 `Rust` 和 `Zig`（Zig 用于交叉编译 Jolt Physics 的 C++ 底层）。
3.  **准备资源**：将你的 `.pmx` 模型文件及其所有贴图，以及 `.vmd` 动作文件放入 `assets` 文件夹中。
4.  **配置路径**：打开 `src/config.toml` 配置文件，在对应字段填入你的模型和动作文件路径。
5.  **一键运行**：赋予脚本执行权限并启动程序：
    ```bash
    chmod +x run.sh
    ./run.sh
    ```
    *（提示：如果遇到软体掉落等内存闪退问题，请使用 `./run.sh --debug` 启动，脚本会自动抓取 LLDB 错误堆栈）。*

---

<a id="日本語"></a>
## 🇯🇵 日本語

本プロジェクトは、[Bevy Engine](https://bevyengine.org/) (Rust) と [Jolt Physics](https://github.com/jrouwe/JoltPhysics) (Zig FFI を介した C++ エンジン) を用いて構築された、高度なリアルタイム 3D アニメーションおよび物理プレイヤーです。MikuMikuDance (MMD) アセット（`.pmx` モデルおよび `.vmd` モーションデータ）の読み込みに特化しており、ソフトボディ（Soft Body）物理演算を用いて複雑な衣服や髪の毛のダイナミクスを極めて正確にシミュレートします。

### ✨ 主な機能

* **PMX モデル読み込み**: ボーン、頂点、面、テクスチャ、マテリアル、剛体などのネイティブデータを完全に解析します。
* **VMD モーション再生**: フルスケルタルアニメーション再生を実装し、フォワードキネマティクス (FK) および Cyclic Coordinate Descent (CCD) ベースのインバースキネマティクス (IK) をサポートします。
* **CPU スキニングアーキテクチャ**: PMX の生頂点データを Bevy の `Mesh3d` 属性に直接かつ効率的にマッピングする、高性能な CPU サイドスキニングメカニズム。
* **高度なソフトボディ物理演算 (開発中)**: 従来の剛体プロキシチェーンを廃止し、真に相互接続されたソフトボディ物理を用いて、スカート、リボン、袖、髪の毛をシミュレートします。

### 🧠 ソフトボディ物理演算の深掘り

生の PMX レンダリングメッシュをそのまま物理エンジンに渡すと、致命的なトポロジーエラーが発生します。本プロジェクトでは、静的で断片化されたレンダリングメッシュを滑らかで動的な物理クロス（布）に変換するための堅牢なパイプラインを実装しています。

1.  **空間頂点結合 (Spatial Welding)**:
    PMX メッシュは多くの場合、UV シームで重なり合いながらも切り離された頂点を持っています。そのまま物理エンジンに入れると、布は即座に無数の独立した三角形に粉砕されます。本プロジェクトでは、空間距離が `0.001` 以内の頂点をハッシュテーブルで自動的に結合し、断片化されたレンダリングメッシュを物理ソルバー用の単一の統合されたトポロジーに変換します。
2.  **エッジコンプライアンス調整 (Edge Compliance)**:
    エッジの長さを強制的にロックすると、キャラクターの激しい動きによって物理ソルバーの計算が爆発（破綻）しやすくなります。システムはエッジ制約に `0.2f` のコンプライアンス係数を導入し、実際の織物のような微視的な伸縮性をソフトボディに持たせることで、物理的な安定性を大幅に向上させています。
3.  **ソフトシェイプマッチング (Pose Tracking)**:
    PMX の衣服には完全な体積制約がないため、独自の「ソフトシェイプマッチング」アルゴリズムを採用しています。自由落下状態にある布の頂点に対し、本来のアニメーションスキン位置に向かうバネのような穏やかな加速度 (`diff * 5.0f`) を適用します。これにより、布はキャラクターの動きに追従して自然な慣性を生み出します。
4.  **アンカーピン留め (Kinematic Roots)**:
    ボーンウェイトと、衣服や髪の毛に関する多言語キーワード辞書（日・英・中の PMX 命名規則に対応）を分析することで、システムは胴体や頭部に付着している「ルート（根元）」頂点をインテリジェントに特定し、その逆質量 (Inverse Mass) を `0.0` に設定して正確にピン留めします（現在、脱落問題のデバッグ中）。

### 🚀 実行方法

1.  **リポジトリのクローン**:
    ```bash
    git clone [https://github.com/Tom-Jim/bevy_mmd.git](https://github.com/Tom-Jim/bevy_mmd.git)
    cd bevy_mmd
    ```
2.  **ツールチェーンのインストール**: システムに `Rust` と `Zig` がインストールされていることを確認してください。
3.  **アセットの準備**: `.pmx` モデルファイルとすべてのテクスチャ、および `.vmd` モーションファイルを `assets` フォルダに配置します。
4.  **パスの設定**: `src/config.toml` ファイルを開き、`pmx` および `vmd` フィールドにアセットのパスを記入します。
5.  **実行**: スクリプトに実行権限を付与し、起動します。
    ```bash
    chmod +x run.sh
    ./run.sh
    ```
    *（注：ソフトボディの脱落などのメモリクラッシュが発生した場合は、`./run.sh --debug` を実行して LLDB のバックトレースを自動的に取得してください）。*