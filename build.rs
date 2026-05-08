use std::env;
use std::path::PathBuf;
use std::process::Command;

fn main() {
    println!("cargo:rerun-if-changed=src/api.zig");
    println!("cargo:rerun-if-changed=build.zig");
    // 监控整个 build.zig 文件
    println!("cargo:rerun-if-changed=build.zig");
    // 监控整个存放 Zig 和 C++ 源码的目录 (假设都在 src 目录下)
    println!("cargo:rerun-if-changed=src");
    let mut zig_args = vec![
        "build",
        if env::var("PROFILE").unwrap_or_default() == "release" {
            "-Doptimize=ReleaseFast"
        } else {
            "-Doptimize=ReleaseFast"
        },
    ];
    // 只有在 macOS 下，才强制指定 aarch64-macos
    #[cfg(target_os = "macos")]
    zig_args.push("-Dtarget=aarch64-macos.26.4");
    // 运行 Zig 编译
    let status = Command::new("zig")
        .args(&zig_args)
        .status()
        .expect("Failed to execute zig build.");
    assert!(status.success(), "Zig build failed!");

    let manifest_dir = env::var("CARGO_MANIFEST_DIR").unwrap();
    let lib_dir = PathBuf::from(&manifest_dir).join("zig-out/lib");

    println!("cargo:rustc-link-search=native={}", lib_dir.display());

    #[cfg(target_os = "macos")]
    {
        // 3. 🍎 使用 libtool 将两个库熔炼，并明确告诉 Rust 链接目标版本
        let combined_path = lib_dir.join("libcombined_physics.a");
        let zig_lib = lib_dir.join("libzig_physics.a");
        let jolt_lib = lib_dir.join("libjoltc.a");

        let _ = Command::new("libtool")
            .args([
                "-static",
                "-o",
                combined_path.to_str().unwrap(),
                zig_lib.to_str().unwrap(),
                jolt_lib.to_str().unwrap(),
            ])
            .status();

        //println!("cargo:rustc-link-lib=static=combined_physics");
        // 强制要求 Rust 链接器也使用 26.4 版本协议
        println!("cargo:rustc-link-arg=-mmacosx-version-min=26.4");
        println!("cargo:rustc-link-lib=c++");
        println!("cargo:rustc-link-lib=framework=CoreFoundation");
        println!("cargo:rustc-link-search=native=zig-out/lib");
        println!("cargo:rustc-link-lib=static=zig_physics");
        println!("cargo:rustc-link-lib=static=joltc");
        println!("cargo:rustc-link-search=native={}", lib_dir.display());
    }

    #[cfg(not(target_os = "macos"))]
    {
        println!("cargo:rustc-link-lib=static=zig_physics");
        println!("cargo:rustc-link-lib=static=joltc");
    }
    Command::new("ranlib")
        .arg(lib_dir.join("libjoltc.a"))
        .status()
        .ok();
    Command::new("ranlib")
        .arg(lib_dir.join("libzig_physics.a"))
        .status()
        .ok();
}
