/*use bevy::log::tracing_subscriber::fmt::time;
use bevy::prelude::*;

fn main() {
    App::new()
        .add_plugins(DefaultPlugins)
        .add_systems(Startup, setup)
        .add_systems(Update, (rotate_cube,update_color,apply_color,))
        .run();
}
#[derive(Component)]
struct MyColor(Color);
#[derive(Component)]
struct MaterialHandle(Handle<StandardMaterial>);
fn update_color(mut q: Query<&mut MyColor>, time: Res<Time>) {
    q.iter_mut().for_each(|mut my_color| {
        let t = time.elapsed_secs();
        let r = 0.6 + 0.4 * (t * 0.3).cos();
        let g = 0.5 + 0.5 * (t * 0.5).sin();
        let b = 0.1 + 0.5 * (t * 0.7).cos();
        my_color.0 = Color::srgb(r, g, b);
    });
}
fn apply_color(
    mut materials: ResMut<Assets<StandardMaterial>>,
    q: Query<(&MyColor, &MaterialHandle)>
) {
    for (my_color, mat_handle) in &q {
        if let Some(mat) = materials.get_mut(&mat_handle.0) {
            mat.base_color = my_color.0;   // 🔥 真正改 GPU 颜色的地方
        }
    }
}
fn setup(
    mut commands: Commands,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<StandardMaterial>>,
) {
    // 摄像机
    commands.spawn((
        Camera3d::default(),
        Transform::from_xyz(0.0, 2.0, 6.0).looking_at(Vec3::ZERO, Vec3::Y),
    ));

    // 光源
    commands.spawn((
        PointLight {
            intensity: 200000.0,
            range: 20.0,
            color: Color::WHITE,
            ..default()
        },
        Transform::from_xyz(3.0, 3.0, 3.0),
    ));

    // 创建材质 handle
    let mat_handle = materials.add(StandardMaterial {
        base_color: Color::srgb(0.0, 0.0, 0.0),
        ..default()
    });

    // 实体挂载 Mesh + MaterialHandle + MyColor + Transform + Rotating
    commands.spawn((
        Mesh3d(meshes.add(Mesh::from(Cuboid::from_size(Vec3::splat(1.0))))),
        MeshMaterial3d(mat_handle.clone()),
        MaterialHandle(mat_handle),
        MyColor(Color::srgb(0.0, 0.0, 0.0)), // 这里才是真正热更新的颜色
        Transform::default(),
        Rotating,
    ));
}
#[derive(Component)]
struct Rotating;
// 系统：让带 Rotating 的物体旋转
fn rotate_cube(mut q: Query<&mut Transform, With<Rotating>>, time: Res<Time>) {
    for mut transform in &mut q {

        //方案 ：更通用的方式，显式用四元数（任何版本都适用）
        transform.rotate(Quat::from_rotation_y(time.delta_secs()));
        transform.rotate(Quat::from_rotation_x(time.delta_secs() * 3.0));
        transform.rotate(Quat::from_rotation_z(0.0));
    }
}
*/
/*use bevy::prelude::*;

fn main() {
    App::new()
        .add_plugins(DefaultPlugins)
        .add_systems(Startup, setup)
        .add_systems(Update, update_text)
        .run();
}

fn setup(mut commands: Commands) {
    commands.spawn(Camera2d);

    commands.spawn((
        Node {
            width: Val::Percent(100.0),
            height: Val::Percent(100.0),
            align_items: AlignItems::Center,
            justify_content: JustifyContent::Center,
            ..default()
        },
        children![(
                Text::default(),
                TextFont {
                    font_size: 100.0,
                    ..default()
                },
            )],
    ));
}

fn update_text(mut text: Single<&mut Text>) {
    // 改这里 ↓，保存后就能 hotpatch
    text.0 = "hello hotpatch".to_string();
} */
/*
use bevy::prelude::*;
use bevy::math::primitives::{Sphere, Cuboid};
use bevy_solari::realtime::{SolariLighting, SolariLightingPlugin};
fn main() {
    App::new()
        .add_plugins(DefaultPlugins)
        .add_plugins(SolariLightingPlugin)
        .add_systems(Startup, setup)
        .add_systems(Update, animate_ball) // 新增动画系统
        .run();
}
#[derive(Component)]
struct RotatingBall;

fn setup(
    mut commands: Commands,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<StandardMaterial>>,
) {
    // 球体
    let sphere_mesh = meshes.add(Sphere::new(0.5));
    let sphere_mat = materials.add(StandardMaterial {
        base_color: Color::srgb(0.8, 0.2, 0.2),
        metallic: 0.2,
        perceptual_roughness: 0.4,
        ..default()
    });
    commands.spawn((
        Mesh3d(sphere_mesh),
        MeshMaterial3d(sphere_mat),
        Transform::from_xyz(0.0, 0.5, 0.0),
        RotatingBall,
    ));

    // 地面
    let ground_mesh = meshes.add(Cuboid::from_size(Vec3::new(10.0, 0.05, 10.0)));
    let ground_mat = materials.add(StandardMaterial {
        base_color: Color::srgb(0.6, 0.6, 0.6),
        perceptual_roughness: 0.9,
        ..default()
    });
    commands.spawn((
        Mesh3d(ground_mesh),
        MeshMaterial3d(ground_mat),
        Transform::from_xyz(0.0, 0.0, 0.0),
    ));

    // 光源
    commands.spawn((
        DirectionalLight {
            illuminance: 20_000.0,
            ..default()
        },
        Transform::from_rotation(Quat::from_euler(EulerRot::XYZ, -0.7, 0.5, 0.0)),
    ));

    // 相机 + Solari
    commands.spawn((
        Camera3d::default(),
        Transform::from_xyz(3.0, 2.0, 6.0).looking_at(Vec3::ZERO, Vec3::Y),
        SolariLighting::default(),
    ));
}
// 动画系统：每帧更新球体位置
fn animate_ball(mut query: Query<&mut Transform, With<RotatingBall>>, time: Res<Time>) {
    for mut transform in &mut query {
        transform.translation.x = 0.2 + (time.elapsed_secs().sin() * 3.0);
        transform.translation.z = 0.2 + (time.elapsed_secs().cos() * 3.0);
    }
}
*/
/*
use PMXUtil::reader::ModelInfoStage;
fn main() {
    let loader = ModelInfoStage::open("/Users/macos/Downloads/模型/星穹铁道—遐蝶（含武器）_by_崩坏：星穹铁道_7a0b8ffe5225310880bf35c5b7907c69/星穹铁道—遐蝶3.pmx").unwrap();

    // 文件头
    let header = loader.get_header();
    println!("{:#?}", header);

    // 读取模型信息 + 进入顶点阶段
    let (model_info, ns) = loader.read();   // 注意这里是 read() 而不是 read_pmx_model_info()
    println!("{:#?}", model_info);

    // 顶点
    let (vertices, ns) = ns.read();
    println!("顶点数: {}", vertices.len());

    // 面
    let (faces, ns) = ns.read();
    println!("面数: {}", faces.len());

    // 纹理
    let (textures, ns) = ns.read();
    println!("纹理数: {}", textures.len());

    // 材质
    let (materials, ns) = ns.read();
    println!("材质数: {}", materials.len());

    // 骨骼 (bones)
    let (bones, ns) = ns.read();
    println!("骨骼数: {}", bones.len());

    // Morphs (表情/变形)
    let (morphs, ns) = ns.read();
    println!("Morph 数: {}", morphs.len());

    // Display frames (显示分组)//如果你只是要在 Bevy 或其他引擎里加载并显示 PMX 模型，完全可以忽略 Display Frames
    let (frames, ns) = ns.read();
    println!("显示帧数: {}", frames.len());

    // Rigid bodies (物理刚体)
    let (rigid_bodies, ns) = ns.read();
    println!("刚体数: {}", rigid_bodies.len());

    // Joints (物理关节)
    let (joints, _ns) = ns.read();
    println!("关节数: {}", joints.len());

    // 至此，PMX 文件的主要结构就全部解析完了
}
*/
/*
use bevy::prelude::*;
use bevy::mesh::Indices;
use bevy::asset::RenderAssetUsages;
use bevy::render::render_resource::PrimitiveTopology;
use PMXUtil::reader::ModelInfoStage;
use PMXUtil::types::{Face,Material};
use bevy_panorbit_camera::{PanOrbitCamera, PanOrbitCameraPlugin};
use bevy::render::render_resource::AsBindGroup;
use bevy::reflect::TypePath;
use bevy::shader::ShaderRef;
use bevy::pbr::MaterialPlugin;
#[derive(Asset, TypePath, AsBindGroup, Clone)]
pub struct ShaderMaterial {
    #[texture(1)]
    #[sampler(2)]
    pub base_color: Handle<Image>,
}

impl bevy::pbr::Material for ShaderMaterial {
    fn fragment_shader() -> ShaderRef {
        "shaders.wgsl".into()
    }
}

fn main() {
    App::new()
        .add_plugins(DefaultPlugins.set(AssetPlugin {
            file_path: "assets/模型/星穹铁道—遐蝶（含武器）_by_崩坏：星穹铁道_7a0b8ffe5225310880bf35c5b7907c69".into(),
            watch_for_changes_override: Some(true),
        ..Default::default()
        }))
        .add_plugins(MaterialPlugin::<ShaderMaterial>::default())// 添加自定义材质插件
        .add_plugins(PanOrbitCameraPlugin) // 加载插件
        .add_systems(Startup, setup)
        .add_systems(Update, update_light)
        .run();
}

fn setup(
    mut commands: Commands,
    asset_server: Res<AssetServer>,
    mut meshes: ResMut<Assets<Mesh>>,
    //mut materials: ResMut<Assets<StandardMaterial>>,
    mut materials: ResMut<Assets<ShaderMaterial>>, // 注意这里换成你的材质类型
) {
    // 打开 PMX 文件
    let loader = ModelInfoStage::open("/Users/macos/Desktop/Rust/rustcode/bevy3Danimation/assets/模型/星穹铁道—遐蝶（含武器）_by_崩坏：星穹铁道_7a0b8ffe5225310880bf35c5b7907c69/星穹铁道—遐蝶3.pmx").unwrap();
    // 文件头
    let header = loader.get_header();
    println!("{:#?}", header);

    // 读取模型信息 + 进入顶点阶段
    let (model_info, ns) = loader.read();   // 注意这里是 read() 而不是 read_pmx_model_info()
    println!("{:#?}", model_info);

    // 顶点
    let (vertices, ns) = ns.read();
    println!("顶点数: {}", vertices.len());

    // 面
    let (faces, ns) = ns.read();
    println!("面数: {}", faces.len());

    // 纹理
    let (textures, ns) = ns.read();
    println!("纹理数: {}", textures.len());

    // 材质
    let (materials_pmx, _ns) = ns.read();
    println!("材质数: {}", materials_pmx.len());

    // ----------- 构建 Mesh --------------
    /*
    let mut mesh = Mesh::new(PrimitiveTopology::TriangleList,RenderAssetUsages::default());

    // 顶点位置
    let positions: Vec<[f32; 3]> =
        vertices.iter().map(|v| v.position).collect();
    mesh.insert_attribute(Mesh::ATTRIBUTE_POSITION, positions);

    // 法线
    let normals: Vec<[f32; 3]> =
        vertices.iter().map(|v| v.norm).collect();
    mesh.insert_attribute(Mesh::ATTRIBUTE_NORMAL, normals);

    // UV
    let uvs: Vec<[f32; 2]> =
        vertices.iter().map(|v| v.uv).collect();
    mesh.insert_attribute(Mesh::ATTRIBUTE_UV_0, uvs);

    // 面索引（PMX Face = 3 u32）
    let indices: Vec<u32> = faces
        .iter()
        .flat_map(|f| f.vertices.iter().map(|&i| i as u32))
        .collect();
    mesh.insert_indices(Indices::U32(indices));

    // ------------ 纹理与材质 -----------------

    let texture_handle = if !textures.is_empty() {
        asset_server.load(textures[0].clone())
    } else {
        print!("没有纹理，使用默认纹理/fallback.png");
        asset_server.load("fallback.png")
    };
    */
    /*let material = materials.add(StandardMaterial {
        base_color_texture: Some(texture_handle),
        ..default()
    });*/
    let mut bevy_materials = Vec::new();

    for mat in &materials_pmx {
        // 找到对应纹理
        let tex_handle = if mat.texture_index >= 0 {
            let tex_name = &textures[mat.texture_index as usize];
            //println!("加载材质纹理: {}.", tex_name);
            asset_server.load(tex_name.clone())
        } else {
            println!("mine error:材质没有纹理，使用默认纹理/fallback.png");
            asset_server.load("fallback.png")
        };
        /*
        // 转换成 Bevy 材质
        let bevy_mat = materials.add(StandardMaterial {
            base_color_texture: Some(tex_handle),
            base_color: Color::srgba(
                mat.diffuse[0],
                mat.diffuse[1],
                mat.diffuse[2],
                mat.diffuse[3],
            ),
            perceptual_roughness: 0.5,//表面粗糙度
            metallic: 0.0,//金属度
            emissive: LinearRgba::rgb(0.0, 0.0, 0.0), // 自发光
            ..default()
        });*/
        //println!("Texture handle: {:?}", tex_handle);
        let bevy_mat = materials.add(ShaderMaterial {
            base_color: tex_handle,
        });
        bevy_materials.push(bevy_mat);
    }
    // ----------- 按材质拆分 Mesh -----------------
    let face_groups = group_faces_by_material(&faces,&materials_pmx);

    for (mat_index, face_indices) in face_groups {
        let mut mesh = Mesh::new(PrimitiveTopology::TriangleList, RenderAssetUsages::RENDER_WORLD);

        // 顶点位置
        let positions: Vec<[f32; 3]> = vertices.iter().map(|v| v.position).collect();
        mesh.insert_attribute(Mesh::ATTRIBUTE_POSITION, positions);

        // 法线
        let normals: Vec<[f32; 3]> = vertices.iter().map(|v| v.norm).collect();
        mesh.insert_attribute(Mesh::ATTRIBUTE_NORMAL, normals);

        // UV
        let uvs: Vec<[f32; 2]> = vertices.iter().map(|v| v.uv).collect();
        mesh.insert_attribute(Mesh::ATTRIBUTE_UV_0, uvs);

        // 面索引（只取属于该材质的面）
        mesh.insert_indices(Indices::U32(face_indices));

        // 生成实体
        commands.spawn((
            Mesh3d(meshes.add(mesh)),
            MeshMaterial3d(bevy_materials[mat_index].clone()),
            Transform::default(),
        ));
    }
    /*
    // ----------- 生成实体 -----------------

    commands.spawn((
        Mesh3d(meshes.add(mesh)),
        MeshMaterial3d(material),
        Transform::default(),
    ));
    */
    // 点光源
    commands.spawn((
        PointLight {
            intensity: 100000.0,
            range: 20.0,
            color: Color::WHITE,
            shadows_enabled: true,
            ..default()
        },
        Transform::from_xyz(0.0, 100.0, 0.0),
    ));
    // 环境光
    commands.spawn((
        AmbientLight {
            color: Color::WHITE,
            brightness: 0.5,
            affects_lightmapped_meshes: true,
        },
    ));
    // 方向光
    commands.spawn((
    DirectionalLight {
        illuminance: 0.0, // 提高光照强度
        shadows_enabled: true,
        ..default()
    },
    Transform::from_translation(Vec3::new(0.0, 0.0, -30.0))
        .looking_at(Vec3::ZERO, Vec3::Y),
    ));
    // 相机
    commands.spawn((
        Camera3d::default(),
        Transform::from_xyz(0.0, 15.0, -50.0).looking_at(Vec3::new(0.0, 15.0, 0.0), Vec3::Y),
        PanOrbitCamera::default(),
    ));
}
fn group_faces_by_material(faces: &[Face], materials: &[Material]) -> Vec<(usize, Vec<u32>)> {
    let mut groups = Vec::new();
    let mut cursor = 0;

    for (mat_index, mat) in materials.iter().enumerate() {
        let mut indices = Vec::new();

        // 每个材质覆盖 mat.num_faces 个三角面
        for _ in 0..(mat.num_face_vertices / 3) as usize {
            if cursor >= faces.len() {
                break;
            }
            let face = &faces[cursor];
            for &v in &face.vertices {
                indices.push(v as u32);
            }
            cursor += 1;
        }

        groups.push((mat_index, indices));
    }   groups
}
fn update_light(
    mut query: Query<(&mut Transform, &mut PointLight)>
) {
    for (mut transform, mut light) in &mut query {
        transform.translation = Vec3 { x: 0.0, y: 25.0, z: -2.0 };   // 热更新位置
        light.intensity = 1000000.0;        // 热更新强度
        light.range = 100.0;                  // 热更新范围
        light.color = Color::RED;          // 热更新颜色
        light.shadows_enabled = true;      // 热更新阴影
    }
}
*/
/*
use bevy::prelude::*;
use bevy::mesh::Indices;
use bevy::asset::RenderAssetUsages;
use bevy::render::render_resource::PrimitiveTopology;
use PMXUtil::reader::ModelInfoStage;
use PMXUtil::types::{Face,Material};
use bevy_panorbit_camera::{PanOrbitCamera, PanOrbitCameraPlugin};
use bevy::render::render_resource::AsBindGroup;
use bevy::reflect::TypePath;
use bevy::shader::ShaderRef;
use bevy::pbr::MaterialPlugin;
#[derive(Asset, TypePath, AsBindGroup, Clone)]
pub struct ShaderMaterial {
    #[texture(1)]
    #[sampler(2)]
    pub base_color: Handle<Image>,
}

impl bevy::pbr::Material for ShaderMaterial {
    fn fragment_shader() -> ShaderRef {
        "shaders.wgsl".into()
    }
}
const PMX_FILE_PATH: &str = "assets/模型/星穹铁道—昔涟_by_崩坏：星穹铁道_e41390284d15805b4e4af62d7d4dc2a7/星穹铁道—昔涟5.pmx";
fn main() {
    App::new()
        .add_plugins(DefaultPlugins.set(AssetPlugin {
            file_path: "assets/模型/星穹铁道—昔涟_by_崩坏：星穹铁道_e41390284d15805b4e4af62d7d4dc2a7".into(),
            watch_for_changes_override: Some(true),
        ..Default::default()
        }))
        .add_plugins(MaterialPlugin::<ShaderMaterial>::default())// 添加自定义材质插件
        .add_plugins(PanOrbitCameraPlugin) // 加载插件
        .add_systems(Startup, setup)
        .run();
}

fn setup(
    mut commands: Commands,
    asset_server: Res<AssetServer>,
    mut meshes: ResMut<Assets<Mesh>>,
    //mut materials: ResMut<Assets<StandardMaterial>>,
    mut materials: ResMut<Assets<ShaderMaterial>>, // 注意这里换成你的材质类型
) {
    // 打开 PMX 文件
    let loader = ModelInfoStage::open(PMX_FILE_PATH).unwrap();
    // 文件头
    let header = loader.get_header();
    println!("{:#?}", header);

    // 读取模型信息 + 进入顶点阶段
    let (model_info, ns) = loader.read();   // 注意这里是 read() 而不是 read_pmx_model_info()
    println!("{:#?}", model_info);

    // 顶点
    let (vertices, ns) = ns.read();
    println!("顶点数: {}", vertices.len());

    // 面
    let (faces, ns) = ns.read();
    println!("面数: {}", faces.len());

    // 纹理
    let (textures, ns) = ns.read();
    println!("纹理数: {}", textures.len());

    // 材质
    let (materials_pmx, _ns) = ns.read();
    println!("材质数: {}", materials_pmx.len());
    let mut bevy_materials = Vec::new();

    for mat in &materials_pmx {
        // 找到对应纹理
        let tex_handle = if mat.texture_index >= 0 {
            let tex_name = &textures[mat.texture_index as usize];
            //println!("加载材质纹理: {}.", tex_name);
            asset_server.load(tex_name.clone())
        } else {
            println!("mine error:材质没有纹理，使用默认纹理/fallback.png");
            asset_server.load("fallback.png")
        };
        let bevy_mat = materials.add(ShaderMaterial {
            base_color: tex_handle,
        });
        bevy_materials.push(bevy_mat);
    }
    // ----------- 按材质拆分 Mesh -----------------
    let face_groups = group_faces_by_material(&faces,&materials_pmx);

    for (mat_index, face_indices) in face_groups {
        let mut mesh = Mesh::new(PrimitiveTopology::TriangleList, RenderAssetUsages::RENDER_WORLD);

        // 顶点位置
        let positions: Vec<[f32; 3]> = vertices.iter().map(|v| v.position).collect();
        mesh.insert_attribute(Mesh::ATTRIBUTE_POSITION, positions);

        // 法线
        let normals: Vec<[f32; 3]> = vertices.iter().map(|v| v.norm).collect();
        mesh.insert_attribute(Mesh::ATTRIBUTE_NORMAL, normals);

        // UV
        let uvs: Vec<[f32; 2]> = vertices.iter().map(|v| v.uv).collect();
        mesh.insert_attribute(Mesh::ATTRIBUTE_UV_0, uvs);

        // 面索引（只取属于该材质的面）
        mesh.insert_indices(Indices::U32(face_indices));

        // 生成实体
        commands.spawn((
            Mesh3d(meshes.add(mesh)),
            MeshMaterial3d(bevy_materials[mat_index].clone()),
            Transform::default(),
        ));
    }
    // 点光源
    commands.spawn((
        PointLight {
            intensity: 0.0,
            range: 20.0,
            color: Color::WHITE,
            shadows_enabled: true,
            ..default()
        },
        Transform::from_xyz(0.0, 100.0, 0.0),
    ));
    // 环境光
    commands.spawn((
        AmbientLight {
            color: Color::WHITE,
            brightness: 0.0,
            affects_lightmapped_meshes: true,
        },
    ));
    // 方向光
    commands.spawn((
    DirectionalLight {
        illuminance: 0.0, // 提高光照强度
        shadows_enabled: true,
        ..default()
    },
    Transform::from_translation(Vec3::new(0.0, 0.0, -30.0))
        .looking_at(Vec3::ZERO, Vec3::Y),
    ));
    // 相机
    commands.spawn((
        Camera3d::default(),
        Transform::from_xyz(0.0, 15.0, -50.0).looking_at(Vec3::new(0.0, 15.0, 0.0), Vec3::Y),
        PanOrbitCamera::default(),
    ));
}
fn group_faces_by_material(faces: &[Face], materials: &[Material]) -> Vec<(usize, Vec<u32>)> {
    let mut groups = Vec::new();
    let mut cursor = 0;

    for (mat_index, mat) in materials.iter().enumerate() {
        let mut indices = Vec::new();

        // 该材质覆盖的三角面数量
        let face_count = (mat.num_face_vertices / 3) as usize;

        for _ in 0..face_count {
            if cursor >= faces.len() {
                break;
            }
            let face = &faces[cursor];
            indices.extend(face.vertices.iter().map(|&v| v as u32));
            cursor += 1;
        }

        groups.push((mat_index, indices));
    }

    // 调试：检查总数是否匹配
    let total_face_vertices: i32 = materials.iter().map(|m| m.num_face_vertices).sum();
    if total_face_vertices != (faces.len() * 3) as i32{
        print!("材质顶点数总和和面顶点总数不匹配");
    };
    groups
}
*/
/*
use bevy::prelude::*;
use bevy::mesh::Indices;
use bevy::asset::RenderAssetUsages;
use bevy::render::render_resource::PrimitiveTopology;
use PMXUtil::reader::ModelInfoStage;
use PMXUtil::types::{Face,Material};
use bevy_panorbit_camera::{PanOrbitCamera, PanOrbitCameraPlugin};
use bevy::render::render_resource::AsBindGroup;
use bevy::reflect::TypePath;
use bevy::shader::ShaderRef;
use bevy::pbr::MaterialPlugin;
use std::path::Path;
#[derive(Asset, TypePath, AsBindGroup, Clone)]
pub struct ShaderMaterial {
    #[texture(1)]
    #[sampler(2)]
    pub base_color: Handle<Image>,
}

impl bevy::pbr::Material for ShaderMaterial {
    fn fragment_shader() -> ShaderRef {
        "shaders/shaders.wgsl".into()
    }
}
const PMX_FILE_PATH: &str = "模型/星穹铁道—昔涟_by_崩坏：星穹铁道_e41390284d15805b4e4af62d7d4dc2a7/星穹铁道—昔涟5.pmx";
fn main() {
    App::new()
        .add_plugins(DefaultPlugins.set(AssetPlugin {
            file_path: "assets".into(),
            watch_for_changes_override: Some(true),
        ..Default::default()
        }))
        .add_plugins(MaterialPlugin::<ShaderMaterial>::default())// 添加自定义材质插件
        .add_plugins(PanOrbitCameraPlugin) // 加载插件
        .add_systems(Startup, setup)
        .run();
}

fn setup(
    mut commands: Commands,
    asset_server: Res<AssetServer>,
    mut meshes: ResMut<Assets<Mesh>>,
    //mut materials: ResMut<Assets<StandardMaterial>>,
    mut materials: ResMut<Assets<ShaderMaterial>>, // 注意这里换成你的材质类型
) {
    // 打开 PMX 文件
    let loader = ModelInfoStage::open("assets/".to_string()+PMX_FILE_PATH).unwrap();
    // 文件头
    let header = loader.get_header();
    println!("{:#?}", header);

    // 读取模型信息 + 进入顶点阶段
    let (model_info, ns) = loader.read();   // 注意这里是 read() 而不是 read_pmx_model_info()
    println!("{:#?}", model_info);

    // 顶点
    let (vertices, ns) = ns.read();
    println!("顶点数: {}", vertices.len());

    // 面
    let (faces, ns) = ns.read();
    println!("面数: {}", faces.len());

    // 纹理
    let (textures, ns) = ns.read();
    println!("纹理数: {}", textures.len());

    // 材质
    let (materials_pmx, _ns) = ns.read();
    println!("材质数: {}", materials_pmx.len());
    let mut bevy_materials = Vec::new();
    for mat in &materials_pmx {
        // 找到对应纹理
        let tex_handle = if mat.texture_index >= 0 {
            let tex_name = &textures[mat.texture_index as usize];
            //println!("加载材质纹理: {}.", tex_name);
            asset_server.load(Path::new(PMX_FILE_PATH).parent().unwrap().join(tex_name))
        } else {
            println!("mine error:材质没有纹理，使用默认纹理/fallback.png");
            asset_server.load("fallback.png")
        };
        let bevy_mat = materials.add(ShaderMaterial {
            base_color: tex_handle,
        });
        bevy_materials.push(bevy_mat);
    }
    // ----------- 按材质拆分 Mesh -----------------
    let face_groups = group_faces_by_material(&faces,&materials_pmx);

    for (mat_index, face_indices) in face_groups {
        let mut mesh = Mesh::new(PrimitiveTopology::TriangleList, RenderAssetUsages::RENDER_WORLD);

        // 顶点位置
        let positions: Vec<[f32; 3]> = vertices.iter().map(|v| v.position).collect();
        mesh.insert_attribute(Mesh::ATTRIBUTE_POSITION, positions);

        // 法线
        let normals: Vec<[f32; 3]> = vertices.iter().map(|v| v.norm).collect();
        mesh.insert_attribute(Mesh::ATTRIBUTE_NORMAL, normals);

        // UV
        let uvs: Vec<[f32; 2]> = vertices.iter().map(|v| v.uv).collect();
        mesh.insert_attribute(Mesh::ATTRIBUTE_UV_0, uvs);

        // 面索引（只取属于该材质的面）
        mesh.insert_indices(Indices::U32(face_indices));

        // 生成实体
        commands.spawn((
            Mesh3d(meshes.add(mesh)),
            MeshMaterial3d(bevy_materials[mat_index].clone()),
            Transform::default(),
        ));
    }
    // 点光源
    commands.spawn((
        PointLight {
            intensity: 0.0,
            range: 20.0,
            color: Color::WHITE,
            shadows_enabled: true,
            ..default()
        },
        Transform::from_xyz(0.0, 100.0, 0.0),
    ));
    // 环境光
    commands.spawn((
        AmbientLight {
            color: Color::WHITE,
            brightness: 0.0,
            affects_lightmapped_meshes: true,
        },
    ));
    // 方向光
    commands.spawn((
    DirectionalLight {
        illuminance: 0.0, // 提高光照强度
        shadows_enabled: true,
        ..default()
    },
    Transform::from_translation(Vec3::new(0.0, 0.0, -30.0))
        .looking_at(Vec3::ZERO, Vec3::Y),
    ));
    // 相机
    commands.spawn((
        Camera3d::default(),
        Transform::from_xyz(0.0, 15.0, -50.0).looking_at(Vec3::new(0.0, 15.0, 0.0), Vec3::Y),
        PanOrbitCamera::default(),
    ));
}
fn group_faces_by_material(faces: &[Face], materials: &[Material]) -> Vec<(usize, Vec<u32>)> {
    let mut groups = Vec::new();
    let mut cursor = 0;

    for (mat_index, mat) in materials.iter().enumerate() {
        let mut indices = Vec::new();

        // 该材质覆盖的三角面数量
        let face_count = (mat.num_face_vertices / 3) as usize;

        for _ in 0..face_count {
            if cursor >= faces.len() {
                break;
            }
            let face = &faces[cursor];
            indices.extend(face.vertices.iter().map(|&v| v as u32));
            cursor += 1;
        }

        groups.push((mat_index, indices));
    }

    // 调试：检查总数是否匹配
    let total_face_vertices: i32 = materials.iter().map(|m| m.num_face_vertices).sum();
    if total_face_vertices != (faces.len() * 3) as i32{
        print!("材质顶点数总和和面顶点总数不匹配");
    };
    groups
}
*/
// use std::fs::File;
// use std::io::BufReader;
// use vmd_parser::vmd_read;

// fn main() {
//     let file = File::open("assets/模型/兔兔摇-猫与哈吉雀_by_猫Su（两只猫儿）_3172e6559498645c8ac59628e530d1e1/motion.vmd")
//         .expect("无法打开 VMD 文件");
//     let mut reader = BufReader::new(file);

//     match vmd_read(&mut reader) {
//         Ok(vmd) => {
//             println!("解析成功: {:?}", vmd.header);

//             // Header 信息
//             println!("版本: {:?}", vmd.header.version);
//             println!("模型名称: {}", vmd.header.name);

//             // 打印所有骨骼关键帧
//             for bone in &vmd.bone {
//                 //println!("{:?}", bone);
//             }

//             // 打印所有表情关键帧
//             for morph in &vmd.morph {
//                 println!("{:?}", morph);
//             }

//             // 打印所有摄像机关键帧
//             for cam in &vmd.camera {
//                 println!("{:?}", cam);
//             }

//             // 打印所有光照关键帧
//             for light in &vmd.light {
//                 println!("{:?}", light);
//             }
//         }
//         Err(e) => {
//             println!("解析失败: {:?}", e);
//         }
//     }
// }
