use bevy::prelude::{Quat, Vec3};
use std::collections::HashMap;
use std::fs::File;
use std::io::{BufReader, Write};
use std::path::Path;

// ─────────────────────────────────────────────
// 错误类型
// ─────────────────────────────────────────────
#[derive(Debug)]
pub enum VmdMotionError {
    Io(std::io::Error),
    Parse(String),
    Vmd(vmd_parser::VmdError),
}

impl From<std::io::Error> for VmdMotionError {
    fn from(value: std::io::Error) -> Self {
        Self::Io(value)
    }
}

impl From<vmd_parser::VmdError> for VmdMotionError {
    fn from(value: vmd_parser::VmdError) -> Self {
        Self::Vmd(value)
    }
}

// ─────────────────────────────────────────────
// 插值曲线 (Bezier 控制点)
// ─────────────────────────────────────────────
/// VMD 使用三次贝塞尔曲线对每个轴的插值进行精确控制。
/// 每条曲线由 16 个字节存储，有效控制点为 4 个 u8：
///   x1, y1, x2, y2  (各取 bytes[0], bytes[4], bytes[8], bytes[12])
/// 归一化到 [0,1] 后，P0=(0,0)  P1=(x1/127, y1/127)
///                    P2=(x2/127, y2/127)  P3=(1,1)
/// 当 x1==y1==20 && x2==y2==107 时为线性插值。
#[derive(Debug, Clone, Copy)]
pub struct BezierCurve {
    pub x1: u8, // P1.x * 127
    pub y1: u8, // P1.y * 127
    pub x2: u8, // P2.x * 127
    pub y2: u8, // P2.y * 127
}

impl BezierCurve {
    pub fn from_bytes(b: &[u8; 16]) -> Self {
        Self {
            x1: b[0],
            y1: b[4],
            x2: b[8],
            y2: b[12],
        }
    }

    pub fn is_linear(&self) -> bool {
        self.x1 == 20 && self.y1 == 20 && self.x2 == 107 && self.y2 == 107
    }
}

// ─────────────────────────────────────────────
// 骨骼关键帧
// ─────────────────────────────────────────────
/// 骨骼关键帧：记录某根骨骼在某帧的位姿，以及四轴插值曲线。
#[derive(Debug, Clone, Copy)]
pub struct VmdBoneKeyframe {
    /// 骨骼所属帧号（30 fps 为单位）
    pub frame: u32,
    /// 骨骼的位移（局部坐标，单位 cm，右手系 X-right Y-up Z-back）
    pub translation: Vec3,
    /// 骨骼的旋转四元数（xyzw，需 normalize 后使用）
    pub rotation: Quat,
    /// X 轴平移插值曲线
    pub x_curve: BezierCurve,
    /// Y 轴平移插值曲线
    pub y_curve: BezierCurve,
    /// Z 轴平移插值曲线
    pub z_curve: BezierCurve,
    /// 旋转插值曲线
    pub r_curve: BezierCurve,
}

// ─────────────────────────────────────────────
// 表情关键帧
// ─────────────────────────────────────────────
/// Morph（表情/形态键）关键帧：控制面部变形权重。
/// weight 范围 [0.0, 1.0]，0 = 原始形状，1 = 完全变形。
#[derive(Debug, Clone)]
pub struct VmdMorphKeyframe {
    /// 表情名称（Shift-JIS，最多 15 字节）
    pub name: String,
    /// 帧号
    pub frame: u32,
    /// 变形权重 [0.0, 1.0]
    pub weight: f32,
}

// ─────────────────────────────────────────────
// 摄像机关键帧
// ─────────────────────────────────────────────
/// 摄像机关键帧：定义 MMD 摄像机在某帧的状态。
#[derive(Debug, Clone)]
pub struct VmdCameraKeyframe {
    /// 帧号
    pub frame: u32,
    /// 摄像机到目标点的距离（负值表示从前方看）
    pub distance: f32,
    /// 摄像机目标点的世界位置 [x, y, z]
    pub position: [f32; 3],
    /// 摄像机欧拉角旋转 [rx, ry, rz]（弧度）
    /// rx: 俯仰(pitch)，ry: 偏航(yaw)，rz: 翻滚(roll)
    pub rotation: [f32; 3],
    /// 24 字节插值曲线（6 轴：x/y/z/rot/dist/fov，各 4 字节）
    pub curve: [u8; 24],
    /// 视角（Field of View），单位：度
    pub view_angle: f32,
    /// 是否正交投影：0 = 透视，1 = 正交
    pub orthographic: u8,
}

// ─────────────────────────────────────────────
// 灯光关键帧
// ─────────────────────────────────────────────
/// 灯光关键帧：定义平行光的颜色与方向。
#[derive(Debug, Clone)]
pub struct VmdLightKeyframe {
    /// 帧号
    pub frame: u32,
    /// RGB 颜色 [r, g, b]，范围 [0.0, 1.0]
    pub color: [f32; 3],
    /// 光线方向向量 [x, y, z]（归一化）
    pub direction: [f32; 3],
}

// ─────────────────────────────────────────────
// 运动时采样用的骨骼姿态
// ─────────────────────────────────────────────
#[derive(Debug, Clone, Copy)]
pub struct BonePose {
    pub translation: Vec3,
    pub rotation: Quat,
}

// ─────────────────────────────────────────────
// 完整 VMD 动作片段
// ─────────────────────────────────────────────
#[derive(Debug, Default)]
pub struct VmdMotionClip {
    /// VMD 文件中记录的模型名称
    pub model_name: String,
    /// 动画总帧数（= 所有骨骼关键帧中最大帧号）
    pub duration_frames: u32,
    /// 骨骼名称 → 按帧号升序排列的关键帧列表
    pub bones: HashMap<String, Vec<VmdBoneKeyframe>>,
    /// 所有表情关键帧（按名称分组）
    pub morphs: HashMap<String, Vec<VmdMorphKeyframe>>,
    /// 摄像机关键帧（按帧号升序）
    pub cameras: Vec<VmdCameraKeyframe>,
    /// 灯光关键帧（按帧号升序）
    pub lights: Vec<VmdLightKeyframe>,
}

impl VmdMotionClip {
    pub fn from_file(path: impl AsRef<Path>) -> Result<Self, VmdMotionError> {
        let file = File::open(path)?;
        let mut reader = BufReader::new(file);
        let vmd = vmd_parser::vmd_read(&mut reader)?;

        let mut clip = VmdMotionClip {
            model_name: vmd.header.name.clone(),
            ..Default::default()
        };

        // ── 骨骼关键帧 ──────────────────────────────
        for record in &vmd.bone {
            let dbg = format!("{:?}", record);
            let (bone_name, kf) = parse_bone_record_debug(&dbg).ok_or_else(|| {
                VmdMotionError::Parse(format!("failed to parse bone keyframe: {dbg}"))
            })?;
            clip.duration_frames = clip.duration_frames.max(kf.frame);
            clip.bones.entry(bone_name).or_default().push(kf);
        }
        for keyframes in clip.bones.values_mut() {
            keyframes.sort_by_key(|k| k.frame);
        }

        // ── 表情关键帧 ──────────────────────────────
        for record in &vmd.morph {
            let dbg = format!("{:?}", record);
            if let Some(m) = parse_morph_record_debug(&dbg) {
                clip.morphs.entry(m.name.clone()).or_default().push(m);
            }
        }
        for keyframes in clip.morphs.values_mut() {
            keyframes.sort_by_key(|k| k.frame);
        }

        // ── 摄像机关键帧 ────────────────────────────
        for record in &vmd.camera {
            let dbg = format!("{:?}", record);
            if let Some(c) = parse_camera_record_debug(&dbg) {
                clip.cameras.push(c);
            }
        }
        clip.cameras.sort_by_key(|c| c.frame);

        // ── 灯光关键帧 ──────────────────────────────
        for record in &vmd.light {
            let dbg = format!("{:?}", record);
            if let Some(l) = parse_light_record_debug(&dbg) {
                clip.lights.push(l);
            }
        }
        clip.lights.sort_by_key(|l| l.frame);

        Ok(clip)
    }

    // ── 打印全部解析信息 ────────────────────────────────
    pub fn write_info_to_file(&self, path: impl AsRef<std::path::Path>) {
        let mut file = match File::create(path) {
            Ok(f) => f,
            Err(e) => {
                eprintln!("[write_info_to_file] 无法创建文件: {}", e);
                return;
            }
        };

        macro_rules! wln {
            () => { if let Err(e) = writeln!(file) { eprintln!("[write_info_to_file] 写入失败: {}", e); return; } };
            ($($arg:tt)*) => { if let Err(e) = writeln!(file, $($arg)*) { eprintln!("[write_info_to_file] 写入失败: {}", e); return; } };
        }

        wln!();
        wln!("╔══════════════════════════════════════════════════════════╗");
        wln!("║              VMD 文件完整解析信息                        ║");
        wln!("╚══════════════════════════════════════════════════════════╝");

        // ── 文件头 ──
        wln!();
        wln!("━━━ [文件头] ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
        wln!("  model_name      : {}", self.model_name);
        wln!(
            "  duration_frames : {} 帧 (约 {:.2} 秒 @ 30fps)",
            self.duration_frames,
            self.duration_frames as f32 / 30.0
        );
        wln!("  骨骼轨道数      : {}", self.bones.len());
        wln!("  表情轨道数      : {}", self.morphs.len());
        wln!("  摄像机关键帧数  : {}", self.cameras.len());
        wln!("  灯光关键帧数    : {}", self.lights.len());

        // ── 骨骼关键帧 ──
        wln!();
        wln!("━━━ [骨骼关键帧 Bone Keyframes] ━━━━━━━━━━━━━━━━━━━━━━━━━");
        wln!("  字段说明:");
        wln!("    frame       : 关键帧帧号，以 30fps 为单位");
        wln!("    translation : 骨骼局部位移 (x, y, z)，单位 cm，MMD 右手坐标系");
        wln!("    rotation    : 骨骼旋转四元数 (x, y, z, w)，已归一化");
        wln!("    x/y/z/r_curve: 贝塞尔插值曲线控制点 (x1,y1,x2,y2)，归一化到 [0,127]");
        wln!("                  线性插值时 x1=y1=20, x2=y2=107");
        wln!();

        let mut bone_names: Vec<&String> = self.bones.keys().collect();
        bone_names.sort();
        let total_bone_kf: usize = self.bones.values().map(|v| v.len()).sum();
        wln!("  骨骼总关键帧数: {}", total_bone_kf);
        wln!();

        for name in &bone_names {
            let keyframes = &self.bones[*name];
            wln!("  ┌─ 骨骼: 「{}」 ({} 帧)", name, keyframes.len());
            for kf in keyframes {
                let t = kf.translation;
                let r = kf.rotation;
                let xc = kf.x_curve;
                let yc = kf.y_curve;
                let zc = kf.z_curve;
                let rc = kf.r_curve;
                wln!(
                    "  │  frame={:>5}  pos=({:>9.4}, {:>9.4}, {:>9.4})  quat=({:>8.5}, {:>8.5}, {:>8.5}, {:>8.5})",
                    kf.frame,
                    t.x,
                    t.y,
                    t.z,
                    r.x,
                    r.y,
                    r.z,
                    r.w
                );
                wln!(
                    "  │           x_curve=(x1={},y1={},x2={},y2={}) {}  y_curve=(x1={},y1={},x2={},y2={}) {}",
                    xc.x1,
                    xc.y1,
                    xc.x2,
                    xc.y2,
                    if xc.is_linear() {
                        "[线性]"
                    } else {
                        "       "
                    },
                    yc.x1,
                    yc.y1,
                    yc.x2,
                    yc.y2,
                    if yc.is_linear() {
                        "[线性]"
                    } else {
                        "       "
                    },
                );
                wln!(
                    "  │           z_curve=(x1={},y1={},x2={},y2={}) {}  r_curve=(x1={},y1={},x2={},y2={}) {}",
                    zc.x1,
                    zc.y1,
                    zc.x2,
                    zc.y2,
                    if zc.is_linear() {
                        "[线性]"
                    } else {
                        "       "
                    },
                    rc.x1,
                    rc.y1,
                    rc.x2,
                    rc.y2,
                    if rc.is_linear() {
                        "[线性]"
                    } else {
                        "       "
                    },
                );
            }
            wln!("  └──────────────────────────────────────────────────────");
        }

        // ── 表情关键帧 ──
        wln!();
        wln!("━━━ [表情关键帧 Morph Keyframes] ━━━━━━━━━━━━━━━━━━━━━━━━");
        wln!("  字段说明:");
        wln!("    name   : 表情名称（对应 PMX 中的 Morph 名）");
        wln!("    frame  : 关键帧帧号");
        wln!("    weight : 变形权重 [0.0 = 不变形, 1.0 = 完全变形]");
        wln!();

        let mut morph_names: Vec<&String> = self.morphs.keys().collect();
        morph_names.sort();
        let total_morph_kf: usize = self.morphs.values().map(|v| v.len()).sum();
        wln!("  表情总关键帧数: {}", total_morph_kf);
        wln!();

        for name in &morph_names {
            let keyframes = &self.morphs[*name];
            wln!("  ┌─ 表情: 「{}」 ({} 帧)", name, keyframes.len());
            for kf in keyframes {
                wln!("  │  frame={:>5}  weight={:.4}", kf.frame, kf.weight);
            }
            wln!("  └──────────────────────────────────────────────────────");
        }

        // ── 摄像机关键帧 ──
        wln!();
        wln!("━━━ [摄像机关键帧 Camera Keyframes] ━━━━━━━━━━━━━━━━━━━━━");
        wln!("  字段说明:");
        wln!("    frame        : 关键帧帧号");
        wln!("    distance     : 摄像机到目标点距离（负值=从前方，正值=从后方）");
        wln!("    position     : 目标点世界坐标 [x, y, z]");
        wln!("    rotation     : 欧拉角 [pitch(rx), yaw(ry), roll(rz)]，单位弧度");
        wln!("    curve        : 24字节插值曲线（6段×4字节，顺序: x/y/z/rot/dist/fov）");
        wln!("    view_angle   : 视角 Field of View，单位°（度）");
        wln!("    orthographic : 投影模式  0=透视投影  1=正交投影");
        wln!();
        wln!("  摄像机关键帧数: {}", self.cameras.len());
        wln!();
        for cam in &self.cameras {
            wln!(
                "  frame={:>5}  dist={:>9.4}  pos=({:>9.4},{:>9.4},{:>9.4})  rot=({:>8.5},{:>8.5},{:>8.5})  fov={:>7.2}°  ortho={}",
                cam.frame,
                cam.distance,
                cam.position[0],
                cam.position[1],
                cam.position[2],
                cam.rotation[0],
                cam.rotation[1],
                cam.rotation[2],
                cam.view_angle,
                if cam.orthographic == 0 {
                    "透视"
                } else {
                    "正交"
                }
            );
            // 写入插值曲线原始字节
            let c = &cam.curve;
            wln!(
                "         curve=[{:3},{:3},{:3},{:3} | {:3},{:3},{:3},{:3} | {:3},{:3},{:3},{:3} | {:3},{:3},{:3},{:3} | {:3},{:3},{:3},{:3} | {:3},{:3},{:3},{:3}]",
                c[0],
                c[1],
                c[2],
                c[3],
                c[4],
                c[5],
                c[6],
                c[7],
                c[8],
                c[9],
                c[10],
                c[11],
                c[12],
                c[13],
                c[14],
                c[15],
                c[16],
                c[17],
                c[18],
                c[19],
                c[20],
                c[21],
                c[22],
                c[23]
            );
        }

        // ── 灯光关键帧 ──
        wln!();
        wln!("━━━ [灯光关键帧 Light Keyframes] ━━━━━━━━━━━━━━━━━━━━━━━━");
        wln!("  字段说明:");
        wln!("    frame     : 关键帧帧号");
        wln!("    color     : 平行光 RGB 颜色 [r, g, b]，范围 [0.0, 1.0]");
        wln!("    direction : 光线方向向量 [x, y, z]（归一化，指向光源的反方向）");
        wln!();
        wln!("  灯光关键帧数: {}", self.lights.len());
        wln!();
        for light in &self.lights {
            wln!(
                "  frame={:>5}  color=({:.3},{:.3},{:.3})  direction=({:>8.5},{:>8.5},{:>8.5})",
                light.frame,
                light.color[0],
                light.color[1],
                light.color[2],
                light.direction[0],
                light.direction[1],
                light.direction[2]
            );
        }

        wln!();
        wln!("╔══════════════════════════════════════════════════════════╗");
        wln!("║                  VMD 解析信息打印完毕                    ║");
        wln!("╚══════════════════════════════════════════════════════════╝");
        wln!();
    }

    // ─────────────────────────────────────────
    // 采样接口
    // ─────────────────────────────────────────

        pub fn sample_morph_at_frame(&self, morph_name: &str, frame: f32) -> Option<f32> {
        let keys = self.morphs.get(morph_name)?;
        if keys.is_empty() {
            return None;
        }
        if frame <= keys[0].frame as f32 {
            return Some(keys[0].weight);
        }
        if frame >= keys[keys.len() - 1].frame as f32 {
            return Some(keys[keys.len() - 1].weight);
        }
        let mut i = 0usize;
        while i + 1 < keys.len() {
            let a = &keys[i];
            let b = &keys[i + 1];
            if frame >= a.frame as f32 && frame <= b.frame as f32 {
                let dt = (b.frame - a.frame).max(1) as f32;
                let t = ((frame - a.frame as f32) / dt).clamp(0.0, 1.0);
                // VMD morph doesn't use bezier curves, just linear lerp
                return Some(a.weight + (b.weight - a.weight) * t);
            }
            i += 1;
        }
        None
    }

    pub fn sample_morph_at_seconds(
        &self,
        morph_name: &str,
        seconds: f32,
        fps: f32,
    ) -> Option<f32> {
        self.sample_morph_at_frame(morph_name, seconds.max(0.0) * fps.max(1.0))
    }

    pub fn sample_bone_at_frame(&self, bone_name: &str, frame: f32) -> Option<BonePose> {
        let keys = self.bones.get(bone_name)?;
        if keys.is_empty() {
            return None;
        }
        if frame <= keys[0].frame as f32 {
            return Some(BonePose {
                translation: keys[0].translation,
                rotation: keys[0].rotation,
            });
        }
        if frame >= keys[keys.len() - 1].frame as f32 {
            let last = keys[keys.len() - 1];
            return Some(BonePose {
                translation: last.translation,
                rotation: last.rotation,
            });
        }
        let mut i = 0usize;
        while i + 1 < keys.len() {
            let a = keys[i];
            let b = keys[i + 1];
            if frame >= a.frame as f32 && frame <= b.frame as f32 {
                let dt = (b.frame - a.frame).max(1) as f32;
                let t = ((frame - a.frame as f32) / dt).clamp(0.0, 1.0);
                return Some(BonePose {
                    translation: a.translation.lerp(b.translation, t),
                    rotation: a.rotation.slerp(b.rotation, t),
                });
            }
            i += 1;
        }
        None
    }

    pub fn sample_bone_at_seconds(
        &self,
        bone_name: &str,
        seconds: f32,
        fps: f32,
    ) -> Option<BonePose> {
        self.sample_bone_at_frame(bone_name, seconds.max(0.0) * fps.max(1.0))
    }

    pub fn sample_all_bones_at_seconds(&self, seconds: f32, fps: f32) -> HashMap<String, BonePose> {
        let mut out = HashMap::with_capacity(self.bones.len());
        let frame = seconds.max(0.0) * fps.max(1.0);
        for name in self.bones.keys() {
            if let Some(pose) = self.sample_bone_at_frame(name, frame) {
                out.insert(name.clone(), pose);
            }
        }
        out
    }
}

// ─────────────────────────────────────────────────────────────────────────────
// Debug 字符串解析辅助
// （vmd_parser 0.1.0 的所有关键帧字段均为私有，通过 {:?} 文本解析）
// ─────────────────────────────────────────────────────────────────────────────

fn extract_between<'a>(s: &'a str, start: &str, end: &str) -> Option<&'a str> {
    let a = s.find(start)? + start.len();
    let b = s[a..].find(end)? + a;
    Some(&s[a..b])
}

fn extract_after<'a>(s: &'a str, start: &str) -> Option<&'a str> {
    let a = s.find(start)? + start.len();
    Some(&s[a..])
}

fn extract_bracket_array<'a>(s: &'a str, key: &str) -> Option<&'a str> {
    let start = s.find(key)? + key.len();
    let end = s[start..].find(']')? + start;
    Some(&s[start..end])
}

fn parse_f32_3(src: &str) -> Option<[f32; 3]> {
    let mut vals = src.split(',').map(|v| v.trim().parse::<f32>().ok());
    Some([vals.next()??, vals.next()??, vals.next()??])
}

fn parse_f32_4(src: &str) -> Option<[f32; 4]> {
    let mut vals = src.split(',').map(|v| v.trim().parse::<f32>().ok());
    Some([vals.next()??, vals.next()??, vals.next()??, vals.next()??])
}

// ── 骨骼记录解析 ────────────────────────────────────────────────────────────
// Debug 格式示例：
// BoneKeyFrameRecord { bone_name: "センター", frame_time: 0,
//   translation: [0.0, 0.0, 0.0], rotation: [0.0, 0.0, 0.0, 1.0],
//   x_curve: [20, ...16 bytes...], y_curve: [...], z_curve: [...], r_curve: [...] }
fn parse_bone_record_debug(input: &str) -> Option<(String, VmdBoneKeyframe)> {
    let name = extract_between(input, "bone_name: \"", "\"")?;
    let frame_s = extract_after(input, "frame_time: ")?;
    let frame: u32 = frame_s.split(',').next()?.trim().parse().ok()?;

    let translation_src = extract_bracket_array(input, "translation: [")?;
    let rotation_src = extract_bracket_array(input, "rotation: [")?;

    let t = parse_f32_3(translation_src)?;
    let r = parse_f32_4(rotation_src)?;

    // 解析四条插岝曲线（各 16 字节）
    let x_curve = parse_curve_field(input, "x_curve: ")?;
    let y_curve = parse_curve_field(input, "y_curve: ")?;
    let z_curve = parse_curve_field(input, "z_curve: ")?;
    let r_curve = parse_curve_field(input, "r_curve: ")?;

    Some((
        name.to_string(),
        VmdBoneKeyframe {
            frame,
            translation: Vec3::new(t[0], t[1], t[2]),
            rotation: Quat::from_xyzw(r[0], r[1], r[2], r[3]).normalize(),
            x_curve: BezierCurve::from_bytes(&x_curve),
            y_curve: BezierCurve::from_bytes(&y_curve),
            z_curve: BezierCurve::from_bytes(&z_curve),
            r_curve: BezierCurve::from_bytes(&r_curve),
        },
    ))
}

/// 从 Debug 字符串中定位 `key: [...]` 并提取 16 字节数组
fn parse_curve_field(input: &str, key: &str) -> Option<[u8; 16]> {
    let start_pos = input.find(key)? + key.len();
    let sub = &input[start_pos..];
    // sub 现在以 '[' 开头
    let inner_start = sub.find('[')? + 1;
    let inner_end = sub.find(']')?;
    let inner = &sub[inner_start..inner_end];
    let mut vals = inner.split(',').map(|v| v.trim().parse::<u8>().ok());
    let mut arr = [0u8; 16];
    for item in &mut arr {
        *item = vals.next()??;
    }
    Some(arr)
}

// ── 表情记录解析 ─────────────────────────────────────────────────────────────
// Debug 格式示例：
// MorphKeyFrameRecord { morph_name: "まばたき", frame_time: 0, weight: 0.0 }
fn parse_morph_record_debug(input: &str) -> Option<VmdMorphKeyframe> {
    let name = extract_between(input, "morph_name: \"", "\"")?;
    let frame_s = extract_after(input, "frame_time: ")?;
    let frame: u32 = frame_s.split(',').next()?.trim().parse().ok()?;
    let weight_s = extract_after(input, "weight: ")?;
    let weight: f32 = weight_s.trim_end_matches('}').trim().parse().ok()?;

    Some(VmdMorphKeyframe {
        name: name.to_string(),
        frame,
        weight,
    })
}

// ── 摄像机记录解析 ───────────────────────────────────────────────────────────
// Debug 格式示例：
// CameraKeyFrameRecord { frame_time: 0, distance: -45.0,
//   position: [0.0, 10.0, 0.0], rotation: [0.0, 0.0, 0.0],
//   curve: [20, ...24 bytes...], view_angle: 30.0, orthographic: 0 }
fn parse_camera_record_debug(input: &str) -> Option<VmdCameraKeyframe> {
    let frame_s = extract_after(input, "frame_time: ")?;
    let frame: u32 = frame_s.split(',').next()?.trim().parse().ok()?;

    let dist_s = extract_after(input, "distance: ")?;
    let distance: f32 = dist_s.split(',').next()?.trim().parse().ok()?;

    let position_src = extract_bracket_array(input, "position: [")?;
    let rotation_src = extract_bracket_array(input, "rotation: [")?;

    let position = parse_f32_3(position_src)?;
    let rotation = parse_f32_3(rotation_src)?;

    let curve = parse_camera_curve_field(input)?;

    let va_s = extract_after(input, "view_angle: ")?;
    let view_angle: f32 = va_s.split(',').next()?.trim().parse().ok()?;

    let ortho_s = extract_after(input, "orthographic: ")?;
    let orthographic: u8 = ortho_s.trim_end_matches('}').trim().parse().ok()?;

    Some(VmdCameraKeyframe {
        frame,
        distance,
        position,
        rotation,
        curve,
        view_angle,
        orthographic,
    })
}

fn parse_camera_curve_field(input: &str) -> Option<[u8; 24]> {
    let start_pos = input.find("curve: ")? + "curve: ".len();
    let sub = &input[start_pos..];
    let inner_start = sub.find('[')? + 1;
    let inner_end = sub.find(']')?;
    let inner = &sub[inner_start..inner_end];
    let mut vals = inner.split(',').map(|v| v.trim().parse::<u8>().ok());
    let mut arr = [0u8; 24];
    for item in &mut arr {
        *item = vals.next()??;
    }
    Some(arr)
}

// ── 灯光记录解析 ─────────────────────────────────────────────────────────────
// Debug 格式示例：
// LightKeyFrameRecord { frame_time: 0, color: [0.6, 0.6, 0.6],
//   direction: [0.5, 1.0, -0.5] }
fn parse_light_record_debug(input: &str) -> Option<VmdLightKeyframe> {
    let frame_s = extract_after(input, "frame_time: ")?;
    let frame: u32 = frame_s.split(',').next()?.trim().parse().ok()?;

    let color_src = extract_bracket_array(input, "color: [")?;
    let direction_src = extract_bracket_array(input, "direction: [")?;

    let color = parse_f32_3(color_src)?;
    let direction = parse_f32_3(direction_src)?;

    Some(VmdLightKeyframe {
        frame,
        color,
        direction,
    })
}
