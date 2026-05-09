# 布料和头发物理仿真 - 快速参考

## 📋 概要

本项目已集成物理仿真系统，支持：
- ✅ 布料动态模拟（Verlet积分 + 距离约束）
- ✅ 头发物理约束（骨骼链弹簧系统）
- ✅ 与现有动画系统无缝集成

## 🚀 快速开始

### 1. 启用布料物理

```rust
// 在 setup() 中添加（VMD加载之后）
let cloth_vertices: Vec<usize> = (10000..15000).collect();
let constraints = vec![
    physics::DistanceConstraint {
        v1: 10000,
        v2: 10001,
        rest_distance: 1.0,
    },
    // ... 更多约束
];

commands.spawn((
    physics::ClothPhysics {
        vertices: cloth_vertices,
        constraints,
        damping: 0.95,
    }
));
```

### 2. 启用头发物理

```rust
commands.spawn((
    physics::HairPhysics {
        root_bone_indices: vec![500, 508, 516, 524],  // 4条发束
        chain_length: 8,          // 每条8个骨骼
        stiffness: 0.80,          // 柔软头发
        damping: 0.95,
    }
));
```

## ⚙️ 关键参数

| 参数 | 范围 | 效果 | 推荐 |
|------|------|------|------|
| **布料 - damping** | 0.9-0.99 | 越小越松软 | 0.95 |
| **头发 - stiffness** | 0.5-0.95 | 越小越柔顺 | 0.80 |
| **头发 - damping** | 0.9-0.99 | 越小越易摆动 | 0.95 |

## 📊 系统架构

```
VMD 动画 → 骨骼 FK/IK
                ↓
        apply_cloth_physics()    ← 布料约束求解
        apply_hair_physics()      ← 头发约束求解
                ↓
        apply_skin_to_meshes()    ← 结果写入GPU
                ↓
           渲染输出
```

## 🔧 调试技巧

### 布料太硬 / 不动
```rust
damping: 0.90,  // 降低阻尼，增加摆动
```

### 布料穿透身体
```rust
damping: 0.98,  // 提高阻尼，减少伸展
// 或增加约束迭代次数（改动 apply_cloth_physics 中的 for _ in 0..3）
```

### 头发太直
```rust
stiffness: 0.60,  // 降低刚度
```

### 头发太软
```rust
stiffness: 0.90,  // 提高刚度
```

## 📈 性能指标

- **布料**: 10000顶点 × 3次迭代 ≈ 1-2ms
- **头发**: 100条 × 8骨骼 ≈ 0.5-1ms
- **总计**: ≈ 2-5ms per FixedUpdate (推荐60FPS设定下)

## 📚 文件位置

| 文件 | 内容 | 用途 |
|------|------|------|
| `src/physics.rs` | 组件定义 | 物理数据结构 |
| `src/main.rs` | 系统函数 | 约束求解逻辑 |
| `PHYSICS_UPDATE.md` | 详细文档 | 完整参考 |
| `PHYSICS_EXAMPLES.rs` | 示例代码 | 集成示例 |

## 🎯 常见集成点

### 1. 自动检测PMX中的布料
检查材质名称或顶点权重，自动为"衣服"、"裙子"部分启用物理。

### 2. 动态参数调整
根据运动速度动态调整damping和stiffness。

### 3. 碰撞优化
添加简单的AABB碰撞预检，避免布料与身体穿透。

### 4. 风力模拟
在 `apply_cloth_physics` 中添加风向量：
```rust
let wind = Vec3::new(wind_x, wind_y, wind_z) * 0.1;
cur_pos += wind;
```

## ⚡ 优化建议

### 降低计算量
```rust
// 减少约束数量
constraints = constraints.into_iter().step_by(2).collect();

// 降低迭代次数（改动源码）
for _ in 0..2 {  // 从 3 改为 2
    // ...
}
```

### 采样LOD
```rust
// 远处不计算
if distance_to_camera > 50.0 {
    damping = 0.99;  // 几乎不动
}
```

## 🔗 依赖检查

```bash
# 确保已安装正确版本
cargo tree | grep avian3d  # 应为 0.6.1
cargo tree | grep bevy      # 应为 0.18.1
```

## 📞 故障排除

### 编译错误: `not a Bundle`
→ 确保已使用 `insert_resource` 而非 `spawn` 设置全局重力

### 物理不更新
→ 检查系统调度顺序，确保 `apply_*_physics` 在 `PhysicsSystems::Writeback` 之后

### 性能下降
→ 查看约束数量，使用 `constraints.len()` 打印检查

## 📖 学习资源

- [Verlet积分讲解](https://en.wikipedia.org/wiki/Verlet_integration)
- [距离约束求解](https://www.gdcvault.com/play/1023903)
- [Bevy ECS系统](https://bevy-cheatbook.github.io/programming/ecs_intro.html)

---

**版本**: 1.0  
**最后更新**: 2024  
**维护者**: Bevy3D Animation Project
