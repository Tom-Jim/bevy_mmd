//! Builds Jolt Physics and the MMD physics bridge (`src/physics/cpp`) with the `cc` crate.
//!
//! * Native targets use the platform C++ compiler and its standard library.
//! * `wasm32-unknown-unknown` compiles the C++ for `wasm32-wasip1` with LLVM clang and
//!   links wasi-libc, libc++ and compiler-rt from a WASI sysroot. The few WASI calls that
//!   libc can make are answered by `src/physics/wasi.rs`, so the module imports nothing
//!   from `wasi_snapshot_preview1`.
//!
//! The WASI sysroot is found through `WASI_SYSROOT` (and `WASI_BUILTINS` for
//! `libclang_rt.builtins.a`), falling back to the Homebrew `wasi-libc` and
//! `wasi-runtimes` layout. The compiler is `CXX_wasm32_unknown_unknown`, else Homebrew
//! LLVM's clang++.

use std::env;
use std::path::{Path, PathBuf};

const JOLT: &str = "deps/jolt";
const BRIDGE: &str = "src/physics/cpp/mmd_physics.cpp";

/// Graphics back ends, debug drawing and GPU hair: none of it is used here.
const SKIP_DIRS: &[&str] = &[
    "Compute/CPU",
    "Compute/DX12",
    "Compute/MTL",
    "Compute/VK",
    "Renderer",
    "Shaders",
    "Physics/Hair",
];

fn main() {
    let root = PathBuf::from(env::var("CARGO_MANIFEST_DIR").unwrap());
    let target = env::var("TARGET").unwrap();
    let wasm = target.starts_with("wasm32");
    println!("cargo::rerun-if-changed=src/build.rs");
    println!("cargo::rerun-if-changed=src/physics/cpp");
    println!("cargo::rerun-if-changed={JOLT}");
    println!("cargo::rerun-if-env-changed=WASI_SYSROOT");
    println!("cargo::rerun-if-env-changed=WASI_BUILTINS");

    let jolt_root = root.join(JOLT).join("Jolt");
    let mut sources = Vec::new();
    collect(&jolt_root, &jolt_root, &mut sources);
    sources.sort();
    sources.push(root.join(BRIDGE));

    let mut build = cc::Build::new();
    build
        .cpp(true)
        .std("c++17")
        .include(root.join(JOLT))
        .include(root.join("src/physics/cpp"))
        .files(&sources)
        .warnings(false)
        // The bridge and Jolt agree on every configuration define.
        .define("JPH_CROSS_PLATFORM_DETERMINISTIC", None)
        .define("JPH_OBJECT_LAYER_BITS", "16")
        .opt_level(3)
        .debug(false);
    // Jolt asserts and profiles only when these are defined; keep release behaviour
    // in debug builds so the frame time of a debug run is representative.
    build.define("NDEBUG", None);

    if wasm {
        let sysroot = wasi_sysroot();
        let clang = env::var("CXX_wasm32_unknown_unknown")
            .unwrap_or_else(|_| "/opt/homebrew/opt/llvm/bin/clang++".into());
        build
            .compiler(clang)
            .target("wasm32-wasip1")
            .flag(format!("--sysroot={}", sysroot.display()))
            .flag("-fno-exceptions")
            .flag("-fno-rtti")
            // Jolt's WASM SIMD path is written against Emscripten's SSE emulation
            // headers; with plain clang it takes its portable scalar path.
            .flag("-mbulk-memory")
            .flag("-mnontrapping-fptoint")
            .flag("-msign-ext")
            .flag("-mmutable-globals");
        // cc passes the Rust target to clang; the C++ target is WASI.
        build.no_default_flags(true).flag("-O3").flag("--target=wasm32-wasip1");
    } else {
        build.flag_if_supported("-fno-exceptions").flag_if_supported("-fno-rtti");
        if target.contains("apple") {
            build.flag("-mmacosx-version-min=11.0");
        }
    }
    build.compile("mmd_physics");

    if wasm {
        link_wasi_runtime();
    } else if target.contains("apple") {
        println!("cargo::rustc-link-lib=c++");
    } else if target.contains("windows") {
        // MSVC links its C++ runtime on its own.
    } else {
        println!("cargo::rustc-link-lib=stdc++");
    }
}

fn collect(dir: &Path, root: &Path, out: &mut Vec<PathBuf>) {
    for entry in std::fs::read_dir(dir).unwrap() {
        let path = entry.unwrap().path();
        let rel = path.strip_prefix(root).unwrap().to_string_lossy().replace('\\', "/");
        if path.is_dir() {
            if !SKIP_DIRS.iter().any(|skip| rel == *skip) {
                collect(&path, root, out);
            }
        } else if path.extension().is_some_and(|e| e == "cpp") {
            out.push(path);
        }
    }
}

fn wasi_sysroot() -> PathBuf {
    if let Ok(path) = env::var("WASI_SYSROOT") {
        return PathBuf::from(path);
    }
    let brew = PathBuf::from("/opt/homebrew/share/wasi-sysroot");
    assert!(
        brew.join("lib/wasm32-wasip1/libc.a").exists(),
        "The browser build needs a WASI sysroot with libc++: `brew install wasi-libc wasi-runtimes`, \
         or set WASI_SYSROOT (wasi-sdk's share/wasi-sysroot)"
    );
    brew
}

fn link_wasi_runtime() {
    let sysroot = wasi_sysroot();
    let lib = sysroot.join("lib/wasm32-wasip1");
    println!("cargo::rustc-link-search=native={}", lib.display());
    for name in ["c++", "c++abi", "c"] {
        println!("cargo::rustc-link-lib=static={name}");
    }
    let builtins = env::var("WASI_BUILTINS").map(PathBuf::from).unwrap_or_else(|_| {
        PathBuf::from("/opt/homebrew/opt/wasi-runtimes/share/wasi-runtimes/lib/wasm32-unknown-wasip1")
    });
    println!("cargo::rustc-link-search=native={}", builtins.display());
    println!("cargo::rustc-link-lib=static=clang_rt.builtins");
}
