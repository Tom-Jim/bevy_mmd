//! The WASI calls wasi-libc (under Jolt's C++ runtime) can make, answered in-process so
//! the browser module imports nothing from `wasi_snapshot_preview1`. Jolt does no I/O:
//! writes are dropped, there is no environment or argument list, and the clock reads
//! the page's monotonic time.

#![allow(non_snake_case, clippy::missing_safety_doc)]

const SUCCESS: u16 = 0;
const BADF: u16 = 8;
const NOSYS: u16 = 52;

#[repr(C)]
pub struct CioVec {
    buf: *const u8,
    len: usize,
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn __imported_wasi_snapshot_preview1_fd_write(_fd: i32, iovs: *const CioVec, n: usize, written: *mut usize) -> u16 {
    let mut total = 0;
    for i in 0..n {
        total += unsafe { (*iovs.add(i)).len };
    }
    unsafe { *written = total };
    SUCCESS
}

#[unsafe(no_mangle)]
pub extern "C" fn __imported_wasi_snapshot_preview1_fd_close(_fd: i32) -> u16 {
    SUCCESS
}

#[unsafe(no_mangle)]
pub extern "C" fn __imported_wasi_snapshot_preview1_fd_seek(_fd: i32, _offset: i64, _whence: i32, _out: *mut u64) -> u16 {
    NOSYS
}

#[unsafe(no_mangle)]
pub extern "C" fn __imported_wasi_snapshot_preview1_fd_fdstat_get(_fd: i32, _out: *mut u8) -> u16 {
    BADF
}

#[unsafe(no_mangle)]
pub extern "C" fn __imported_wasi_snapshot_preview1_fd_prestat_get(_fd: i32, _out: *mut u8) -> u16 {
    BADF
}

#[unsafe(no_mangle)]
pub extern "C" fn __imported_wasi_snapshot_preview1_fd_prestat_dir_name(_fd: i32, _path: *mut u8, _len: usize) -> u16 {
    BADF
}

#[unsafe(no_mangle)]
pub extern "C" fn __imported_wasi_snapshot_preview1_fd_read(_fd: i32, _iovs: *const CioVec, _n: usize, read: *mut usize) -> u16 {
    unsafe { *read = 0 };
    SUCCESS
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn __imported_wasi_snapshot_preview1_environ_sizes_get(count: *mut usize, size: *mut usize) -> u16 {
    unsafe {
        *count = 0;
        *size = 0;
    }
    SUCCESS
}

#[unsafe(no_mangle)]
pub extern "C" fn __imported_wasi_snapshot_preview1_environ_get(_environ: *mut *mut u8, _buf: *mut u8) -> u16 {
    SUCCESS
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn __imported_wasi_snapshot_preview1_args_sizes_get(count: *mut usize, size: *mut usize) -> u16 {
    unsafe {
        *count = 0;
        *size = 0;
    }
    SUCCESS
}

#[unsafe(no_mangle)]
pub extern "C" fn __imported_wasi_snapshot_preview1_args_get(_argv: *mut *mut u8, _buf: *mut u8) -> u16 {
    SUCCESS
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn __imported_wasi_snapshot_preview1_clock_time_get(_id: u32, _precision: u64, out: *mut u64) -> u16 {
    let ms = web_sys::window().and_then(|w| w.performance()).map_or(0.0, |p| p.now());
    unsafe { *out = (ms * 1.0e6) as u64 };
    SUCCESS
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn __imported_wasi_snapshot_preview1_random_get(buf: *mut u8, len: usize) -> u16 {
    // Only libc++'s hash seeds ask; determinism is fine.
    for i in 0..len {
        unsafe { *buf.add(i) = (i as u8).wrapping_mul(151).wrapping_add(17) };
    }
    SUCCESS
}

#[unsafe(no_mangle)]
pub extern "C" fn __imported_wasi_snapshot_preview1_sched_yield() -> u16 {
    SUCCESS
}

#[unsafe(no_mangle)]
pub extern "C" fn __imported_wasi_snapshot_preview1_proc_exit(code: i32) -> ! {
    panic!("the physics runtime exited with code {code}");
}
