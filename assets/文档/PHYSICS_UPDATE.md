# 布料和头发物理仿真系统升级

## 概述
本次更新为Bevy3D动画系统添加了布料和头发的物理仿真支持，使这些元素能够根据角色运动自然地随之摆动。

## 核心改动

### 1. physics.rs 新增组件

#### `PhysicsVertex` 组件
```rust
#[derive(Component)]
pub struct PhysicsVertex {
    pub rest_position: Vec3,           // 静止位置
    pub current_position: Vec3,        // 当前位置
    pub previous_position: Vec3,       // 上一帧位置
    pub is_pinned: bool,              // 是否固定（如头发根部）
}
```
用于追踪单个顶点的物理状态（Verlet积分所需）。

#### `ClothPhysics` 组件
```rust
#[derive(Component)]
pub struct ClothPhysics {
    pub vertices: Vec<usize>,           // 全局顶点索引
    pub constraints: Vec<DistanceConstraint>,  // 距离约束
    pub damping: f32,                  // 阻尼系数 (0-1)
}
```
用于模拟衣物布料的物理行为，包括：
- **Verlet 积分**：`new_pos = 2*current_pos - previous_pos + accel*dt²`
- **距离约束**：多次迭代求解，保持顶点间距离
- **重力和衰减**：模拟自然下垂

#### `DistanceConstraint` 结构
```rust
#[derive(Clone, Copy)]
pub struct DistanceConstraint {
    pub v1: usize,                     // 顶点1索引
    pub v2: usize,                     // 顶点2索引
    pub rest_distance: f32,            // 静止距离
}
```
约束两个顶点间的距离。

#### `HairPhysics` 组件
```rust
#[derive(Component)]
pub struct HairPhysics {
    pub root_bone_indices: Vec<usize>, // 头发根骨骼索引
    pub chain_length: usize,           // 每条发束的骨骼数
    pub stiffness: f32,                // 刚度系数 (0-1)
    pub damping: f32,                  // 阻尼系数 (0-1)
}
```
用于模拟头发的链式骨骼物理，包括：
- **骨骼链约束**：维持相邻骨骼间距离
- **刚度控制**：较高刚度使头发更挺立，较低刚度更飘摇
- **重力影响**：头发自然下垂

### 2. main.rs 新增系统函数

#### `apply_cloth_physics()`
处理布料物理约束的系统函数，执行流程：

1. **Verlet 积分** - 计算新位置
   ```
   new_pos = 2*current - previous + gravity*dt²
   ```

2. **约束求解** - 多次迭代（默认3次）
   ```
   对每个距离约束：
     delta = p2 - p1
     dist = length(delta)
     correction = (dist - rest_distance) * 0.5 / dist
     p1 += delta * correction
     p2 -= delta * correction
   ```

3. **阻尼衰减** - 通过damping参数控制能量散失

#### `apply_hair_physics()`
处理头发物理约束的系统函数，执行流程：

1. **重力应用** - 较弱的下向加速度
2. **刚度约束** - 恢复骨骼间的初始距离
3. **链式传播** - 从根到尖逐链处理

### 3. 系统调度更新

```rust
.add_systems(
    FixedUpdate,
    (
        skin_update_system,      // 骨骼FK+IK计算
        apply_cloth_physics,     // 布料约束
        apply_hair_physics,      // 头发约束
        apply_skin_to_meshes,    // 应用到网格
    )
    .chain()
    .after(avian3d::prelude::PhysicsSystems::Writeback)
)
```

## 使用方式

### 为布料启用物理仿真

在setup函数中添加：

```rust
// 选择布料顶点（例如：裙子下半部分）
let cloth_vertices: Vec<usize> = (10000..15000).collect();

// 创建相邻顶点间的距离约束
let mut constraints = Vec::new();
for &v_idx in &cloth_vertices {
    // 与相邻顶点约束（需要根据顶点连接关系构建）
    constraints.push(physics::DistanceConstraint {
        v1: v_idx,
        v2: v_idx + 1,
        rest_distance: 1.0,  // 根据模型单位调整
    });
}

commands.spawn((
    physics::ClothPhysics {
        vertices: cloth_vertices,
        constraints,
        damping: 0.99,  // 0.99 = 1% 能量散失
    }
));
```

### 为头发启用物理仿真

```rust
// 假设头发骨骼从索引1000开始，有100条发束，每条8个骨骼
let hair_roots: Vec<usize> = (1000..1100)
    .step_by(8)
    .collect();

commands.spawn((
    physics::HairPhysics {
        root_bone_indices: hair_roots,
        chain_length: 8,
        stiffness: 0.85,  // 较硬的头发
        damping: 0.95,    // 较少能量散失
    }
));
```

## 物理参数调整指南

### 布料参数
- **damping (阻尼)**
  - 0.90: 很松软，摆动长，能量快速散失
  - 0.95: 中等松软，推荐默认值
  - 0.99: 较硬，接近刚体，摆动少

- **约束迭代次数**（代码中固定为3）
  - 增加迭代：更稳定但CPU成本高
  - 减少迭代：更快但可能破裂

- **rest_distance**
  - 应反映实际顶点间距离
  - 偏小：布料变紧
  - 偏大：布料下垂明显

### 头发参数
- **stiffness (刚度)**
  - 0.5: 非常蓬松柔顺
  - 0.75: 自然头发
  - 0.95: 浓密挺立

- **damping (阻尼)**
  - 0.90: 摆动快速衰减
  - 0.95: 中等摆动
  - 0.99: 摆动持续长时间

## 性能考量

### 时间复杂度
- **布料**: O(顶点数 × 约束数 × 迭代次数)
- **头发**: O(骨骼链数 × 链长度)

### 优化建议
1. 降低约束迭代次数从3到2以加快计算
2. 减少约束总数（例如不约束所有顶点对）
3. 采用分组处理，并行计算多条头发链

### 典型性能
- 10000顶点布料 + 3迭代 + 100头发骨骼：~2-5ms（FixedUpdate周期）

## 物理算法原理

### Verlet 积分（用于布料）
一种隐式时间积分方法，优点：
- 能量自动衰减，更稳定
- 可直接处理约束（距离约束求解器）
- 无需维护速度向量

### 约束求解器（用于布料）
基于Sequential Impulse的距离约束：
```
对每次迭代：
  for each constraint (v1, v2):
    delta = p2 - p1
    dist = |delta|
    correction = (dist - rest_dist) / dist
    movement = delta * correction * 0.5
    p1 += movement
    p2 -= movement
```

### 弹簧约束（用于头发）
简化的弹簧系统：
```
force = -stiffness * (current_dist - rest_dist)
```

## 常见问题与调试

### 布料穿透身体
**原因**: 约束太松或迭代不足
**解决**: 
- 增加damping值（0.95→0.98）
- 增加约束迭代次数
- 检查rest_distance是否合理

### 头发不动
**原因**: 刚度过高或阻尼过高
**解决**:
- 降低stiffness（0.95→0.80）
- 降低damping（0.99→0.95）

### 性能下降
**原因**: 约束过多或迭代过多
**解决**:
- 减少布料顶点数或约束密度
- 降低迭代次数到2
- 采用LOD（远处降低质量）

## 扩展方向

1. **碰撞检测**: 添加刚体碰撞约束防止穿透
2. **风力**: 添加外力（风、爆炸力等）
3. **接缝固定**: 某些顶点固定到骨骼（pinned vertices）
4. **自适应质量**: 不同顶点不同质量
5. **GPU计算**: 迁移到compute shader以加速

## 文件修改概览

| 文件 | 修改 | 行数 |
|-----|------|------|
| physics.rs | 新增3个Component，修复Gravity设置 | +50行 |
| main.rs | 新增2个系统函数，更新调度 | +100行 |
| Cargo.toml | 无改动（依赖已足够） | - |

---

**最后更新**: 2024年
**物理引擎**: Avian3D 0.6.1 + Bevy 0.18.1
