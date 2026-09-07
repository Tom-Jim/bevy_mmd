use std::{env, path::PathBuf, process::Command};

fn main() {
    for path in [
        "src/api.zig",
        "src/jolt_softbody.cpp",
        "build.zig",
        "build.zig.zon",
        "deps/zphysics",
    ] {
        println!("cargo:rerun-if-changed={path}");
    }
    assert_eq!(
        env::var("HOST").unwrap(),
        env::var("TARGET").unwrap(),
        "The native Jolt build currently requires a host build"
    );
    let mut zig = Command::new("zig");
    zig.args(["build", "-Doptimize=ReleaseSafe"]);
    let os = env::var("CARGO_CFG_TARGET_OS").unwrap();
    if os == "macos" {
        println!("cargo:rerun-if-env-changed=MACOSX_DEPLOYMENT_TARGET");
        let deployment = env::var("MACOSX_DEPLOYMENT_TARGET").unwrap_or_else(|_| "11.0".into());
        let arch = env::var("CARGO_CFG_TARGET_ARCH").unwrap();
        zig.arg(format!("-Dtarget={arch}-macos.{deployment}"));
    }
    let status = zig.status().expect("Install Zig 0.16 to compile Jolt");
    assert!(status.success(), "Zig build failed");
    let lib_dir = PathBuf::from(env::var("CARGO_MANIFEST_DIR").unwrap()).join("zig-out/lib");
    println!("cargo:rustc-link-search=native={}", lib_dir.display());
    if os == "macos" {
        // Extract first: Apple's libtool skips some members in unaligned Zig archives.
        let unpacked = PathBuf::from(env::var("OUT_DIR").unwrap()).join("native-objects");
        std::fs::create_dir_all(&unpacked).expect("Cannot create native object directory");
        let mut objects = Vec::new();
        for library in ["zig_physics", "joltc"] {
            let directory = unpacked.join(library);
            if directory.exists() {
                std::fs::remove_dir_all(&directory).expect("Cannot clear stale objects");
            }
            std::fs::create_dir_all(&directory).unwrap();
            let status = Command::new("/usr/bin/ar")
                .arg("-x")
                .arg(lib_dir.join(format!("lib{library}.a")))
                .current_dir(&directory)
                .status()
                .expect("Cannot extract native archive");
            assert!(status.success(), "Cannot extract {library}");
            for entry in std::fs::read_dir(&directory).unwrap() {
                let path = entry.unwrap().path();
                if path.extension().is_some_and(|e| e == "o") {
                    // Zig emits archive members with mode 000; ar preserves that mode.
                    #[cfg(unix)]
                    {
                        use std::os::unix::fs::PermissionsExt;
                        std::fs::set_permissions(&path, std::fs::Permissions::from_mode(0o644))
                            .expect("Cannot make extracted object readable");
                    }
                    objects.push(path);
                }
            }
        }
        objects.sort();
        let status = Command::new("/usr/bin/libtool")
            .args(["-static", "-no_warning_for_no_symbols", "-o"])
            .arg(lib_dir.join("libmmd_physics.a"))
            .args(objects)
            .status()
            .expect("Apple command line tools are required");
        assert!(status.success(), "Cannot repack native archives");
        println!("cargo:rustc-link-lib=static=mmd_physics");
        println!("cargo:rustc-link-arg=-Wl,-no_warn_duplicate_libraries");
    } else {
        println!("cargo:rustc-link-lib=static=zig_physics");
        println!("cargo:rustc-link-lib=static=joltc");
    }
    println!("cargo:rustc-link-lib=c++");
}
