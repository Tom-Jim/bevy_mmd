/// 本示例展示如何为角色模型的布料和头发启用物理仿真
///
/// 注意：这是伪代码示例，需要根据实际的PMX模型结构进行调整
/// 建议在 setup() 函数中的 VMD 加载部分之后添加这段代码
use crate::physics::{ClothPhysics, DistanceConstraint, HairPhysics};

/// 为特定部位启用布料物理
pub fn setup_cloth_physics(
    commands: &mut bevy::prelude::Commands,
    // 布料顶点范围：例如模型中第 10000-20000 号顶点属于衣服
    cloth_vertex_start: usize,
    cloth_vertex_end: usize,
) {
    // 1. 收集布料顶点
    let cloth_vertices: Vec<usize> = (cloth_vertex_start..cloth_vertex_end).collect();

    // 2. 构建约束（这里使用简单的相邻顶点约束）
    // 实际应用中应该根据 PMX 的面信息构建更合理的约束图
    let mut constraints = Vec::new();

    // 示例：为每个顶点与相邻顶点建立约束
    for i in (cloth_vertex_start..cloth_vertex_end - 1).step_by(1) {
        constraints.push(DistanceConstraint {
            v1: i,
            v2: i + 1,
            rest_distance: 1.0, // 根据模型单位（通常 cm）调整
        });
    }

    // 3. 生成网格化约束（可选，用于增加稳定性）
    for i in (cloth_vertex_start..cloth_vertex_end - 10).step_by(10) {
        if i + 10 <= cloth_vertex_end {
            constraints.push(DistanceConstraint {
                v1: i,
                v2: i + 10,
                rest_distance: 10.0,
            });
        }
    }

    // 4. 添加布料物理组件
    commands.spawn((ClothPhysics {
        vertices: cloth_vertices,
        constraints,
        damping: 0.95, // 推荐范围 0.9-0.99
    },));

    println!(
        "[Physics] 布料物理已启用 - 顶点范围: {}..{}",
        cloth_vertex_start, cloth_vertex_end
    );
}

/// 为头发启用物理
pub fn setup_hair_physics(
    commands: &mut bevy::prelude::Commands,
    // 头发的根骨骼索引数组
    // 例如：[100, 108, 116, 124, ...] 表示有多条发束，每条从这些索引开始
    hair_root_bones: Vec<usize>,
    // 每条发束的骨骼数（包括根）
    chain_length: usize,
) {
    commands.spawn((HairPhysics {
        root_bone_indices: hair_root_bones.clone(),
        chain_length,
        stiffness: 0.80, // 头发的硬度：0.5=柔顺，0.9=挺立
        damping: 0.95,   // 能量衰减速率
    },));

    println!(
        "[Physics] 头发物理已启用 - {} 条发束，每条 {} 个骨骼",
        hair_root_bones.len(),
        chain_length
    );
}

/// 实际应用示例：在 setup() 中调用
///
/// 伪代码：
/// ```
/// // 在 setup() 的 VMD 加载之后添加：
///
/// // 为模型的衣服启用布料物理
/// setup_cloth_physics(&mut commands, 10000, 20000);
///
/// // 为模型的头发启用物理（假设有4条发束，每条20个骨骼）
/// let hair_roots = vec![500, 520, 540, 560];
/// setup_hair_physics(&mut commands, hair_roots, 20);
/// ```

/// 高级：动态调整物理参数的系统
pub fn physics_params_update_system(
    keyboard: bevy::prelude::Res<bevy::input::ButtonInput<bevy::input::keyboard::KeyCode>>,
    mut cloth_query: bevy::prelude::Query<&mut ClothPhysics>,
    mut hair_query: bevy::prelude::Query<&mut HairPhysics>,
) {
    // 按 C 键增加布料阻尼
    if keyboard.just_pressed(bevy::input::keyboard::KeyCode::KeyC) {
        for mut cloth in &mut cloth_query {
            cloth.damping = (cloth.damping + 0.01).min(0.99);
            println!("[Physics] 布料阻尼提高到: {:.2}", cloth.damping);
        }
    }

    // 按 H 键调整头发刚度
    if keyboard.just_pressed(bevy::input::keyboard::KeyCode::KeyH) {
        for mut hair in &mut hair_query {
            hair.stiffness = (hair.stiffness + 0.05).min(0.99);
            println!("[Physics] 头发刚度提高到: {:.2}", hair.stiffness);
        }
    }
}

// ═══════════════════════════════════════════════════════════════════════════
// 参数预设值参考
// ═══════════════════════════════════════════════════════════════════════════

pub mod presets {
    /// 松软的衣服（容易摆动）
    pub const CLOTH_SOFT: (f32, &str) = (0.90, "soft");
    /// 中等衣服（推荐）
    pub const CLOTH_NORMAL: (f32, &str) = (0.95, "normal");
    /// 硬的衣服（摆动少）
    pub const CLOTH_STIFF: (f32, &str) = (0.98, "stiff");

    /// 蓬松头发（容易摆动）
    pub const HAIR_FLUFFY: ((f32, f32), &str) = ((0.60, 0.92), "fluffy");
    /// 自然头发（推荐）
    pub const HAIR_NATURAL: ((f32, f32), &str) = ((0.80, 0.95), "natural");
    /// 硬发型（不易摆动）
    pub const HAIR_STIFF: ((f32, f32), &str) = ((0.95, 0.98), "stiff");

    pub fn apply_cloth_preset(cloth: &mut super::ClothPhysics, preset: (f32, &str)) {
        cloth.damping = preset.0;
        println!("[Physics] 应用布料预设: {}", preset.1);
    }

    pub fn apply_hair_preset(hair: &mut super::HairPhysics, preset: ((f32, f32), &str)) {
        hair.stiffness = preset.0.0;
        hair.damping = preset.0.1;
        println!("[Physics] 应用头发预设: {}", preset.1);
    }
}
