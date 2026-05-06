use avian3d::prelude::*;
use bevy::prelude::*;
use PMXUtil::types::{Joint, JointType, Rigid, RigidCalcMethod, RigidForm};

#[derive(Component)]
pub struct PmxRigidInfo {
    pub bone_index: i32,
    pub is_dynamic: bool,
    pub offset_pos: Vec3,
    pub offset_rot: Quat,
}

#[derive(Component)]
pub struct PhysicsVertex {
    pub rest_position: Vec3,
    pub current_position: Vec3,
    pub previous_position: Vec3,
    pub is_pinned: bool,
}

#[derive(Component)]
pub struct ClothPhysics {
    pub vertices: Vec<usize>, // 全局顶点索引
    pub constraints: Vec<DistanceConstraint>,
    pub damping: f32,
}

#[derive(Clone, Copy)]
pub struct DistanceConstraint {
    pub v1: usize,
    pub v2: usize,
    pub rest_distance: f32,
}

#[derive(Component)]
pub struct HairPhysics {
    pub root_bone_indices: Vec<usize>, // 头发根骨骼
    pub chain_length: usize,           // 每条发束的骨骼数
    pub stiffness: f32,
    pub damping: f32,
}

pub fn spawn_physics(
    commands: &mut Commands,
    rigids: &[Rigid],
    joints: &[Joint],
    bones: &[crate::PmxBoneData],
) -> Vec<Entity> {
    let mut rigid_entities = Vec::new();
    // 全局重力设置
    commands.insert_resource(Gravity(Vec3::new(0.0, -98.1, 0.0)));

    for rigid in rigids {
        let pos = Vec3::new(rigid.position[0], rigid.position[1], -rigid.position[2]);
        let rot_euler = Vec3::new(rigid.rotation[0], rigid.rotation[1], -rigid.rotation[2]);
        let rot = crate::euler_xyz_to_quat(rot_euler);

        let sx = rigid.size[0].max(0.01);
        let sy = rigid.size[1].max(0.01);
        let sz = rigid.size[2].max(0.01);

        let collider = match rigid.form {
            RigidForm::Sphere => Collider::sphere(sx),
            RigidForm::Box => Collider::cuboid(sx * 2.0, sy * 2.0, sz * 2.0),
            RigidForm::Capsule => Collider::capsule(sx, sy),
        };

        let is_dynamic = rigid.calc_method != RigidCalcMethod::Static;
        let rb = if is_dynamic {
            RigidBody::Dynamic
        } else {
            RigidBody::Kinematic
        };

        let bone_pos = if rigid.bone_index >= 0 && rigid.bone_index < bones.len() as i32 {
            bones[rigid.bone_index as usize].rest_position
        } else {
            Vec3::ZERO
        };

        let memberships = 1 << rigid.group;
        let filter = !rigid.un_collision_group_flag as u32;

        let entity = commands
            .spawn((
                rb,
                collider.clone(),
                Position(pos),
                Rotation(rot),
                CollisionLayers::new(memberships, filter),
                LinearDamping(rigid.move_resist),
                AngularDamping(rigid.rotation_resist),
                Friction::new(rigid.friction),
                Restitution::new(rigid.repulsion),
                MassPropertiesBundle::from_shape(&collider.clone(), rigid.mass),
                PmxRigidInfo {
                    bone_index: rigid.bone_index,
                    is_dynamic,
                    offset_pos: pos - bone_pos,
                    offset_rot: rot,
                },
            ))
            .id();
        rigid_entities.push(entity);
    }
    for joint in joints {
        if let JointType::Spring6DOF {
            a_rigid_index,
            b_rigid_index,
            position,
            rotation,
            rotation_limit_down,
            rotation_limit_up,
            spring_const_rotation,
            ..
        } = &joint.joint_type
        {
            if *a_rigid_index >= 0
                && *b_rigid_index >= 0
                && *a_rigid_index < rigid_entities.len() as i32
                && *b_rigid_index < rigid_entities.len() as i32
            {
                let ent_a = rigid_entities[*a_rigid_index as usize];
                let ent_b = rigid_entities[*b_rigid_index as usize];

                let j_pos = Vec3::new(position[0], position[1], -position[2]);
                let rb_a = &rigids[*a_rigid_index as usize];
                let rb_b = &rigids[*b_rigid_index as usize];
                let pos_a = Vec3::new(rb_a.position[0], rb_a.position[1], -rb_a.position[2]);
                let pos_b = Vec3::new(rb_b.position[0], rb_b.position[1], -rb_b.position[2]);

                let rot_a_euler = Vec3::new(rb_a.rotation[0], rb_a.rotation[1], -rb_a.rotation[2]);
                let rot_a = crate::euler_xyz_to_quat(rot_a_euler);
                let rot_b_euler = Vec3::new(rb_b.rotation[0], rb_b.rotation[1], -rb_b.rotation[2]);
                let rot_b = crate::euler_xyz_to_quat(rot_b_euler);

                let local_anchor_a = rot_a.inverse() * (j_pos - pos_a);
                let local_anchor_b = rot_b.inverse() * (j_pos - pos_b);

                //let j_rot_euler = Vec3::new(rotation[0], rotation[1], -rotation[2]);
                let mut j = SphericalJoint::new(ent_a, ent_b)
                    .with_local_anchor1(local_anchor_a)
                    .with_local_anchor2(local_anchor_b)
                    .with_point_compliance(0.0) // Keeps them attached tightly
                    .with_swing_compliance(if spring_const_rotation[0] > 0.001 { 1.0 / spring_const_rotation[0] } else { 0.0 })
                    .with_twist_compliance(if spring_const_rotation[1] > 0.001 { 1.0 / spring_const_rotation[1] } else { 0.0 });
                //     .with_compliance(compliance);
                let mut j = SphericalJoint::new(ent_a, ent_b)
                    .with_local_anchor1(local_anchor_a)
                    .with_local_anchor2(local_anchor_b)
                    .with_compliance(0.0); // 必须是 0.0，否则头发裙子会断开掉地上！

                // MMD limits can be applied to swing limits. Since Avian doesn't support 3D euler limits exactly:
                // We map MMD cone limits roughly.
                let max_swing = rotation_limit_up[0]
                    .max(rotation_limit_up[1])
                    .max(rotation_limit_up[2]);
                if max_swing < 3.14 {
                    j = j.with_swing_limits(0.0, max_swing);
                }
                commands.spawn(j);
            }
        }
    }
    rigid_entities
}
