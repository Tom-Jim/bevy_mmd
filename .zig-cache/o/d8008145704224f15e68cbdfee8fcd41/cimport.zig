const __root = @This();
pub const __builtin = @import("std").zig.c_translation.builtins;
pub const __helpers = @import("std").zig.c_translation.helpers;
pub const __int8_t = i8;
pub const __uint8_t = u8;
pub const __int16_t = c_short;
pub const __uint16_t = c_ushort;
pub const __int32_t = c_int;
pub const __uint32_t = c_uint;
pub const __int64_t = c_longlong;
pub const __uint64_t = c_ulonglong;
pub const __darwin_intptr_t = c_long;
pub const __darwin_natural_t = c_uint;
pub const __darwin_ct_rune_t = c_int;
pub const __mbstate_t = extern union {
    __mbstate8: [128]u8,
    _mbstateL: c_longlong,
};
pub const __darwin_mbstate_t = __mbstate_t;
pub const __darwin_ptrdiff_t = c_long;
pub const __darwin_size_t = c_ulong;
pub const __builtin_va_list = [*c]u8;
pub const __darwin_va_list = __builtin_va_list;
pub const __darwin_wchar_t = c_int;
pub const __darwin_rune_t = __darwin_wchar_t;
pub const __darwin_wint_t = c_int;
pub const __darwin_clock_t = c_ulong;
pub const __darwin_socklen_t = __uint32_t;
pub const __darwin_ssize_t = c_long;
pub const __darwin_time_t = c_long;
pub const __darwin_blkcnt_t = __int64_t;
pub const __darwin_blksize_t = __int32_t;
pub const __darwin_dev_t = __int32_t;
pub const __darwin_fsblkcnt_t = c_uint;
pub const __darwin_fsfilcnt_t = c_uint;
pub const __darwin_gid_t = __uint32_t;
pub const __darwin_id_t = __uint32_t;
pub const __darwin_ino64_t = __uint64_t;
pub const __darwin_ino_t = __darwin_ino64_t;
pub const __darwin_mach_port_name_t = __darwin_natural_t;
pub const __darwin_mach_port_t = __darwin_mach_port_name_t;
pub const __darwin_mode_t = __uint16_t;
pub const __darwin_off_t = __int64_t;
pub const __darwin_pid_t = __int32_t;
pub const __darwin_sigset_t = __uint32_t;
pub const __darwin_suseconds_t = __int32_t;
pub const __darwin_uid_t = __uint32_t;
pub const __darwin_useconds_t = __uint32_t;
pub const __darwin_uuid_t = [16]u8;
pub const __darwin_uuid_string_t = [37]u8;
pub const struct___darwin_pthread_handler_rec = extern struct {
    __routine: ?*const fn (?*anyopaque) callconv(.c) void = null,
    __arg: ?*anyopaque = null,
    __next: [*c]struct___darwin_pthread_handler_rec = null,
};
pub const struct__opaque_pthread_attr_t = extern struct {
    __sig: c_long = 0,
    __opaque: [56]u8 = @import("std").mem.zeroes([56]u8),
};
pub const struct__opaque_pthread_cond_t = extern struct {
    __sig: c_long = 0,
    __opaque: [40]u8 = @import("std").mem.zeroes([40]u8),
};
pub const struct__opaque_pthread_condattr_t = extern struct {
    __sig: c_long = 0,
    __opaque: [8]u8 = @import("std").mem.zeroes([8]u8),
};
pub const struct__opaque_pthread_mutex_t = extern struct {
    __sig: c_long = 0,
    __opaque: [56]u8 = @import("std").mem.zeroes([56]u8),
};
pub const struct__opaque_pthread_mutexattr_t = extern struct {
    __sig: c_long = 0,
    __opaque: [8]u8 = @import("std").mem.zeroes([8]u8),
};
pub const struct__opaque_pthread_once_t = extern struct {
    __sig: c_long = 0,
    __opaque: [8]u8 = @import("std").mem.zeroes([8]u8),
};
pub const struct__opaque_pthread_rwlock_t = extern struct {
    __sig: c_long = 0,
    __opaque: [192]u8 = @import("std").mem.zeroes([192]u8),
};
pub const struct__opaque_pthread_rwlockattr_t = extern struct {
    __sig: c_long = 0,
    __opaque: [16]u8 = @import("std").mem.zeroes([16]u8),
};
pub const struct__opaque_pthread_t = extern struct {
    __sig: c_long = 0,
    __cleanup_stack: [*c]struct___darwin_pthread_handler_rec = null,
    __opaque: [8176]u8 = @import("std").mem.zeroes([8176]u8),
};
pub const __darwin_pthread_attr_t = struct__opaque_pthread_attr_t;
pub const __darwin_pthread_cond_t = struct__opaque_pthread_cond_t;
pub const __darwin_pthread_condattr_t = struct__opaque_pthread_condattr_t;
pub const __darwin_pthread_key_t = c_ulong;
pub const __darwin_pthread_mutex_t = struct__opaque_pthread_mutex_t;
pub const __darwin_pthread_mutexattr_t = struct__opaque_pthread_mutexattr_t;
pub const __darwin_pthread_once_t = struct__opaque_pthread_once_t;
pub const __darwin_pthread_rwlock_t = struct__opaque_pthread_rwlock_t;
pub const __darwin_pthread_rwlockattr_t = struct__opaque_pthread_rwlockattr_t;
pub const __darwin_pthread_t = [*c]struct__opaque_pthread_t;
pub const __darwin_nl_item = c_int;
pub const __darwin_wctrans_t = c_int;
pub const __darwin_wctype_t = __uint32_t;
pub const P_ALL: c_int = 0;
pub const P_PID: c_int = 1;
pub const P_PGID: c_int = 2;
pub const idtype_t = c_uint;
pub const pid_t = __darwin_pid_t;
pub const id_t = __darwin_id_t;
pub const sig_atomic_t = c_int;
pub const u_int8_t = u8;
pub const u_int16_t = c_ushort;
pub const u_int32_t = c_uint;
pub const u_int64_t = c_ulonglong;
pub const register_t = i64;
pub const user_addr_t = u_int64_t;
pub const user_size_t = u_int64_t;
pub const user_ssize_t = i64;
pub const user_long_t = i64;
pub const user_ulong_t = u_int64_t;
pub const user_time_t = i64;
pub const user_off_t = i64;
pub const syscall_arg_t = u_int64_t;
pub const struct___darwin_arm_exception_state = extern struct {
    __exception: __uint32_t = 0,
    __fsr: __uint32_t = 0,
    __far: __uint32_t = 0,
};
pub const struct___darwin_arm_exception_state64 = extern struct {
    __far: __uint64_t = 0,
    __esr: __uint32_t = 0,
    __exception: __uint32_t = 0,
};
pub const struct___darwin_arm_exception_state64_v2 = extern struct {
    __far: __uint64_t = 0,
    __esr: __uint64_t = 0,
};
pub const struct___darwin_arm_thread_state = extern struct {
    __r: [13]__uint32_t = @import("std").mem.zeroes([13]__uint32_t),
    __sp: __uint32_t = 0,
    __lr: __uint32_t = 0,
    __pc: __uint32_t = 0,
    __cpsr: __uint32_t = 0,
};
pub const struct___darwin_arm_thread_state64 = extern struct {
    __x: [29]__uint64_t = @import("std").mem.zeroes([29]__uint64_t),
    __fp: __uint64_t = 0,
    __lr: __uint64_t = 0,
    __sp: __uint64_t = 0,
    __pc: __uint64_t = 0,
    __cpsr: __uint32_t = 0,
    __pad: __uint32_t = 0,
};
pub const struct___darwin_arm_vfp_state = extern struct {
    __r: [64]__uint32_t = @import("std").mem.zeroes([64]__uint32_t),
    __fpscr: __uint32_t = 0,
};
pub const __uint128_t = u128;
pub const struct___darwin_arm_neon_state64 = extern struct {
    __v: [32]__uint128_t = @import("std").mem.zeroes([32]__uint128_t),
    __fpsr: __uint32_t = 0,
    __fpcr: __uint32_t = 0,
};
pub const struct___darwin_arm_neon_state = extern struct {
    __v: [16]__uint128_t = @import("std").mem.zeroes([16]__uint128_t),
    __fpsr: __uint32_t = 0,
    __fpcr: __uint32_t = 0,
};
pub const struct___arm_pagein_state = extern struct {
    __pagein_error: c_int = 0,
};
pub const struct___darwin_arm_sme_state = extern struct {
    __svcr: __uint64_t = 0,
    __tpidr2_el0: __uint64_t = 0,
    __svl_b: __uint16_t = 0,
};
pub const struct___darwin_arm_sve_z_state = extern struct {
    __z: [16][256]u8 align(4) = @import("std").mem.zeroes([16][256]u8),
};
pub const struct___darwin_arm_sve_p_state = extern struct {
    __p: [16][32]u8 align(4) = @import("std").mem.zeroes([16][32]u8),
};
pub const struct___darwin_arm_sme_za_state = extern struct {
    __za: [4096]u8 align(4) = @import("std").mem.zeroes([4096]u8),
};
pub const struct___darwin_arm_sme2_state = extern struct {
    __zt0: [64]u8 align(4) = @import("std").mem.zeroes([64]u8),
};
pub const struct___arm_legacy_debug_state = extern struct {
    __bvr: [16]__uint32_t = @import("std").mem.zeroes([16]__uint32_t),
    __bcr: [16]__uint32_t = @import("std").mem.zeroes([16]__uint32_t),
    __wvr: [16]__uint32_t = @import("std").mem.zeroes([16]__uint32_t),
    __wcr: [16]__uint32_t = @import("std").mem.zeroes([16]__uint32_t),
};
pub const struct___darwin_arm_debug_state32 = extern struct {
    __bvr: [16]__uint32_t = @import("std").mem.zeroes([16]__uint32_t),
    __bcr: [16]__uint32_t = @import("std").mem.zeroes([16]__uint32_t),
    __wvr: [16]__uint32_t = @import("std").mem.zeroes([16]__uint32_t),
    __wcr: [16]__uint32_t = @import("std").mem.zeroes([16]__uint32_t),
    __mdscr_el1: __uint64_t = 0,
};
pub const struct___darwin_arm_debug_state64 = extern struct {
    __bvr: [16]__uint64_t = @import("std").mem.zeroes([16]__uint64_t),
    __bcr: [16]__uint64_t = @import("std").mem.zeroes([16]__uint64_t),
    __wvr: [16]__uint64_t = @import("std").mem.zeroes([16]__uint64_t),
    __wcr: [16]__uint64_t = @import("std").mem.zeroes([16]__uint64_t),
    __mdscr_el1: __uint64_t = 0,
};
pub const struct___darwin_arm_cpmu_state64 = extern struct {
    __ctrs: [16]__uint64_t = @import("std").mem.zeroes([16]__uint64_t),
};
pub const struct___darwin_mcontext32 = extern struct {
    __es: struct___darwin_arm_exception_state = @import("std").mem.zeroes(struct___darwin_arm_exception_state),
    __ss: struct___darwin_arm_thread_state = @import("std").mem.zeroes(struct___darwin_arm_thread_state),
    __fs: struct___darwin_arm_vfp_state = @import("std").mem.zeroes(struct___darwin_arm_vfp_state),
};
pub const struct___darwin_mcontext64 = extern struct {
    __es: struct___darwin_arm_exception_state64 = @import("std").mem.zeroes(struct___darwin_arm_exception_state64),
    __ss: struct___darwin_arm_thread_state64 = @import("std").mem.zeroes(struct___darwin_arm_thread_state64),
    __ns: struct___darwin_arm_neon_state64 = @import("std").mem.zeroes(struct___darwin_arm_neon_state64),
};
pub const mcontext_t = [*c]struct___darwin_mcontext64;
pub const pthread_attr_t = __darwin_pthread_attr_t;
pub const struct___darwin_sigaltstack = extern struct {
    ss_sp: ?*anyopaque = null,
    ss_size: __darwin_size_t = 0,
    ss_flags: c_int = 0,
};
pub const stack_t = struct___darwin_sigaltstack;
pub const struct___darwin_ucontext = extern struct {
    uc_onstack: c_int = 0,
    uc_sigmask: __darwin_sigset_t = 0,
    uc_stack: struct___darwin_sigaltstack = @import("std").mem.zeroes(struct___darwin_sigaltstack),
    uc_link: [*c]struct___darwin_ucontext = null,
    uc_mcsize: __darwin_size_t = 0,
    uc_mcontext: [*c]struct___darwin_mcontext64 = null,
};
pub const ucontext_t = struct___darwin_ucontext;
pub const sigset_t = __darwin_sigset_t;
pub const uid_t = __darwin_uid_t;
pub const union_sigval = extern union {
    sival_int: c_int,
    sival_ptr: ?*anyopaque,
};
pub const struct_sigevent = extern struct {
    sigev_notify: c_int = 0,
    sigev_signo: c_int = 0,
    sigev_value: union_sigval = @import("std").mem.zeroes(union_sigval),
    sigev_notify_function: ?*const fn (union_sigval) callconv(.c) void = null,
    sigev_notify_attributes: [*c]pthread_attr_t = null,
};
pub const struct___siginfo = extern struct {
    si_signo: c_int = 0,
    si_errno: c_int = 0,
    si_code: c_int = 0,
    si_pid: pid_t = 0,
    si_uid: uid_t = 0,
    si_status: c_int = 0,
    si_addr: ?*anyopaque = null,
    si_value: union_sigval = @import("std").mem.zeroes(union_sigval),
    si_band: c_long = 0,
    __pad: [7]c_ulong = @import("std").mem.zeroes([7]c_ulong),
};
pub const siginfo_t = struct___siginfo;
pub const union___sigaction_u = extern union {
    __sa_handler: ?*const fn (c_int) callconv(.c) void,
    __sa_sigaction: ?*const fn (c_int, [*c]struct___siginfo, ?*anyopaque) callconv(.c) void,
};
pub const struct___sigaction = extern struct {
    __sigaction_u: union___sigaction_u = @import("std").mem.zeroes(union___sigaction_u),
    sa_tramp: ?*const fn (?*anyopaque, c_int, c_int, [*c]siginfo_t, ?*anyopaque) callconv(.c) void = null,
    sa_mask: sigset_t = 0,
    sa_flags: c_int = 0,
};
pub const struct_sigaction = extern struct {
    __sigaction_u: union___sigaction_u = @import("std").mem.zeroes(union___sigaction_u),
    sa_mask: sigset_t = 0,
    sa_flags: c_int = 0,
};
pub const sig_t = ?*const fn (c_int) callconv(.c) void;
pub const struct_sigvec = extern struct {
    sv_handler: ?*const fn (c_int) callconv(.c) void = null,
    sv_mask: c_int = 0,
    sv_flags: c_int = 0,
};
pub const struct_sigstack = extern struct {
    ss_sp: [*c]u8 = null,
    ss_onstack: c_int = 0,
};
pub extern fn signal(c_int, ?*const fn (c_int) callconv(.c) void) ?*const fn (c_int) callconv(.c) void;
pub const int_least8_t = i8;
pub const int_least16_t = i16;
pub const int_least32_t = i32;
pub const int_least64_t = i64;
pub const uint_least8_t = u8;
pub const uint_least16_t = u16;
pub const uint_least32_t = u32;
pub const uint_least64_t = u64;
pub const int_fast8_t = i8;
pub const int_fast16_t = i16;
pub const int_fast32_t = i32;
pub const int_fast64_t = i64;
pub const uint_fast8_t = u8;
pub const uint_fast16_t = u16;
pub const uint_fast32_t = u32;
pub const uint_fast64_t = u64;
pub const intmax_t = c_long;
pub const uintmax_t = c_ulong;
pub const struct_timeval = extern struct {
    tv_sec: __darwin_time_t = 0,
    tv_usec: __darwin_suseconds_t = 0,
};
pub const rlim_t = __uint64_t;
pub const struct_rusage = extern struct {
    ru_utime: struct_timeval = @import("std").mem.zeroes(struct_timeval),
    ru_stime: struct_timeval = @import("std").mem.zeroes(struct_timeval),
    ru_maxrss: c_long = 0,
    ru_ixrss: c_long = 0,
    ru_idrss: c_long = 0,
    ru_isrss: c_long = 0,
    ru_minflt: c_long = 0,
    ru_majflt: c_long = 0,
    ru_nswap: c_long = 0,
    ru_inblock: c_long = 0,
    ru_oublock: c_long = 0,
    ru_msgsnd: c_long = 0,
    ru_msgrcv: c_long = 0,
    ru_nsignals: c_long = 0,
    ru_nvcsw: c_long = 0,
    ru_nivcsw: c_long = 0,
};
pub const rusage_info_t = ?*anyopaque;
pub const struct_rusage_info_v0 = extern struct {
    ri_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
    ri_user_time: u64 = 0,
    ri_system_time: u64 = 0,
    ri_pkg_idle_wkups: u64 = 0,
    ri_interrupt_wkups: u64 = 0,
    ri_pageins: u64 = 0,
    ri_wired_size: u64 = 0,
    ri_resident_size: u64 = 0,
    ri_phys_footprint: u64 = 0,
    ri_proc_start_abstime: u64 = 0,
    ri_proc_exit_abstime: u64 = 0,
};
pub const struct_rusage_info_v1 = extern struct {
    ri_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
    ri_user_time: u64 = 0,
    ri_system_time: u64 = 0,
    ri_pkg_idle_wkups: u64 = 0,
    ri_interrupt_wkups: u64 = 0,
    ri_pageins: u64 = 0,
    ri_wired_size: u64 = 0,
    ri_resident_size: u64 = 0,
    ri_phys_footprint: u64 = 0,
    ri_proc_start_abstime: u64 = 0,
    ri_proc_exit_abstime: u64 = 0,
    ri_child_user_time: u64 = 0,
    ri_child_system_time: u64 = 0,
    ri_child_pkg_idle_wkups: u64 = 0,
    ri_child_interrupt_wkups: u64 = 0,
    ri_child_pageins: u64 = 0,
    ri_child_elapsed_abstime: u64 = 0,
};
pub const struct_rusage_info_v2 = extern struct {
    ri_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
    ri_user_time: u64 = 0,
    ri_system_time: u64 = 0,
    ri_pkg_idle_wkups: u64 = 0,
    ri_interrupt_wkups: u64 = 0,
    ri_pageins: u64 = 0,
    ri_wired_size: u64 = 0,
    ri_resident_size: u64 = 0,
    ri_phys_footprint: u64 = 0,
    ri_proc_start_abstime: u64 = 0,
    ri_proc_exit_abstime: u64 = 0,
    ri_child_user_time: u64 = 0,
    ri_child_system_time: u64 = 0,
    ri_child_pkg_idle_wkups: u64 = 0,
    ri_child_interrupt_wkups: u64 = 0,
    ri_child_pageins: u64 = 0,
    ri_child_elapsed_abstime: u64 = 0,
    ri_diskio_bytesread: u64 = 0,
    ri_diskio_byteswritten: u64 = 0,
};
pub const struct_rusage_info_v3 = extern struct {
    ri_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
    ri_user_time: u64 = 0,
    ri_system_time: u64 = 0,
    ri_pkg_idle_wkups: u64 = 0,
    ri_interrupt_wkups: u64 = 0,
    ri_pageins: u64 = 0,
    ri_wired_size: u64 = 0,
    ri_resident_size: u64 = 0,
    ri_phys_footprint: u64 = 0,
    ri_proc_start_abstime: u64 = 0,
    ri_proc_exit_abstime: u64 = 0,
    ri_child_user_time: u64 = 0,
    ri_child_system_time: u64 = 0,
    ri_child_pkg_idle_wkups: u64 = 0,
    ri_child_interrupt_wkups: u64 = 0,
    ri_child_pageins: u64 = 0,
    ri_child_elapsed_abstime: u64 = 0,
    ri_diskio_bytesread: u64 = 0,
    ri_diskio_byteswritten: u64 = 0,
    ri_cpu_time_qos_default: u64 = 0,
    ri_cpu_time_qos_maintenance: u64 = 0,
    ri_cpu_time_qos_background: u64 = 0,
    ri_cpu_time_qos_utility: u64 = 0,
    ri_cpu_time_qos_legacy: u64 = 0,
    ri_cpu_time_qos_user_initiated: u64 = 0,
    ri_cpu_time_qos_user_interactive: u64 = 0,
    ri_billed_system_time: u64 = 0,
    ri_serviced_system_time: u64 = 0,
};
pub const struct_rusage_info_v4 = extern struct {
    ri_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
    ri_user_time: u64 = 0,
    ri_system_time: u64 = 0,
    ri_pkg_idle_wkups: u64 = 0,
    ri_interrupt_wkups: u64 = 0,
    ri_pageins: u64 = 0,
    ri_wired_size: u64 = 0,
    ri_resident_size: u64 = 0,
    ri_phys_footprint: u64 = 0,
    ri_proc_start_abstime: u64 = 0,
    ri_proc_exit_abstime: u64 = 0,
    ri_child_user_time: u64 = 0,
    ri_child_system_time: u64 = 0,
    ri_child_pkg_idle_wkups: u64 = 0,
    ri_child_interrupt_wkups: u64 = 0,
    ri_child_pageins: u64 = 0,
    ri_child_elapsed_abstime: u64 = 0,
    ri_diskio_bytesread: u64 = 0,
    ri_diskio_byteswritten: u64 = 0,
    ri_cpu_time_qos_default: u64 = 0,
    ri_cpu_time_qos_maintenance: u64 = 0,
    ri_cpu_time_qos_background: u64 = 0,
    ri_cpu_time_qos_utility: u64 = 0,
    ri_cpu_time_qos_legacy: u64 = 0,
    ri_cpu_time_qos_user_initiated: u64 = 0,
    ri_cpu_time_qos_user_interactive: u64 = 0,
    ri_billed_system_time: u64 = 0,
    ri_serviced_system_time: u64 = 0,
    ri_logical_writes: u64 = 0,
    ri_lifetime_max_phys_footprint: u64 = 0,
    ri_instructions: u64 = 0,
    ri_cycles: u64 = 0,
    ri_billed_energy: u64 = 0,
    ri_serviced_energy: u64 = 0,
    ri_interval_max_phys_footprint: u64 = 0,
    ri_runnable_time: u64 = 0,
};
pub const struct_rusage_info_v5 = extern struct {
    ri_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
    ri_user_time: u64 = 0,
    ri_system_time: u64 = 0,
    ri_pkg_idle_wkups: u64 = 0,
    ri_interrupt_wkups: u64 = 0,
    ri_pageins: u64 = 0,
    ri_wired_size: u64 = 0,
    ri_resident_size: u64 = 0,
    ri_phys_footprint: u64 = 0,
    ri_proc_start_abstime: u64 = 0,
    ri_proc_exit_abstime: u64 = 0,
    ri_child_user_time: u64 = 0,
    ri_child_system_time: u64 = 0,
    ri_child_pkg_idle_wkups: u64 = 0,
    ri_child_interrupt_wkups: u64 = 0,
    ri_child_pageins: u64 = 0,
    ri_child_elapsed_abstime: u64 = 0,
    ri_diskio_bytesread: u64 = 0,
    ri_diskio_byteswritten: u64 = 0,
    ri_cpu_time_qos_default: u64 = 0,
    ri_cpu_time_qos_maintenance: u64 = 0,
    ri_cpu_time_qos_background: u64 = 0,
    ri_cpu_time_qos_utility: u64 = 0,
    ri_cpu_time_qos_legacy: u64 = 0,
    ri_cpu_time_qos_user_initiated: u64 = 0,
    ri_cpu_time_qos_user_interactive: u64 = 0,
    ri_billed_system_time: u64 = 0,
    ri_serviced_system_time: u64 = 0,
    ri_logical_writes: u64 = 0,
    ri_lifetime_max_phys_footprint: u64 = 0,
    ri_instructions: u64 = 0,
    ri_cycles: u64 = 0,
    ri_billed_energy: u64 = 0,
    ri_serviced_energy: u64 = 0,
    ri_interval_max_phys_footprint: u64 = 0,
    ri_runnable_time: u64 = 0,
    ri_flags: u64 = 0,
};
pub const struct_rusage_info_v6 = extern struct {
    ri_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
    ri_user_time: u64 = 0,
    ri_system_time: u64 = 0,
    ri_pkg_idle_wkups: u64 = 0,
    ri_interrupt_wkups: u64 = 0,
    ri_pageins: u64 = 0,
    ri_wired_size: u64 = 0,
    ri_resident_size: u64 = 0,
    ri_phys_footprint: u64 = 0,
    ri_proc_start_abstime: u64 = 0,
    ri_proc_exit_abstime: u64 = 0,
    ri_child_user_time: u64 = 0,
    ri_child_system_time: u64 = 0,
    ri_child_pkg_idle_wkups: u64 = 0,
    ri_child_interrupt_wkups: u64 = 0,
    ri_child_pageins: u64 = 0,
    ri_child_elapsed_abstime: u64 = 0,
    ri_diskio_bytesread: u64 = 0,
    ri_diskio_byteswritten: u64 = 0,
    ri_cpu_time_qos_default: u64 = 0,
    ri_cpu_time_qos_maintenance: u64 = 0,
    ri_cpu_time_qos_background: u64 = 0,
    ri_cpu_time_qos_utility: u64 = 0,
    ri_cpu_time_qos_legacy: u64 = 0,
    ri_cpu_time_qos_user_initiated: u64 = 0,
    ri_cpu_time_qos_user_interactive: u64 = 0,
    ri_billed_system_time: u64 = 0,
    ri_serviced_system_time: u64 = 0,
    ri_logical_writes: u64 = 0,
    ri_lifetime_max_phys_footprint: u64 = 0,
    ri_instructions: u64 = 0,
    ri_cycles: u64 = 0,
    ri_billed_energy: u64 = 0,
    ri_serviced_energy: u64 = 0,
    ri_interval_max_phys_footprint: u64 = 0,
    ri_runnable_time: u64 = 0,
    ri_flags: u64 = 0,
    ri_user_ptime: u64 = 0,
    ri_system_ptime: u64 = 0,
    ri_pinstructions: u64 = 0,
    ri_pcycles: u64 = 0,
    ri_energy_nj: u64 = 0,
    ri_penergy_nj: u64 = 0,
    ri_secure_time_in_system: u64 = 0,
    ri_secure_ptime_in_system: u64 = 0,
    ri_neural_footprint: u64 = 0,
    ri_lifetime_max_neural_footprint: u64 = 0,
    ri_interval_max_neural_footprint: u64 = 0,
    ri_reserved: [9]u64 = @import("std").mem.zeroes([9]u64),
};
pub const rusage_info_current = struct_rusage_info_v6;
pub const struct_rlimit = extern struct {
    rlim_cur: rlim_t = 0,
    rlim_max: rlim_t = 0,
};
pub const struct_proc_rlimit_control_wakeupmon = extern struct {
    wm_flags: u32 = 0,
    wm_rate: i32 = 0,
};
pub extern fn getpriority(c_int, id_t) c_int;
pub extern fn getiopolicy_np(c_int, c_int) c_int;
pub extern fn getrlimit(c_int, [*c]struct_rlimit) c_int;
pub extern fn getrusage(c_int, [*c]struct_rusage) c_int;
pub extern fn setpriority(c_int, id_t, c_int) c_int;
pub extern fn setiopolicy_np(c_int, c_int, c_int) c_int;
pub extern fn setrlimit(c_int, [*c]const struct_rlimit) c_int;
pub fn _OSSwapInt16(arg__data: __uint16_t) callconv(.c) __uint16_t {
    var _data = arg__data;
    _ = &_data;
    return @bitCast(@as(c_short, @truncate((@as(c_int, _data) << @intCast(@as(c_int, 8))) | (@as(c_int, _data) >> @intCast(@as(c_int, 8))))));
}
pub fn _OSSwapInt32(arg__data: __uint32_t) callconv(.c) __uint32_t {
    var _data = arg__data;
    _ = &_data;
    _data = (((_data ^ ((_data >> @intCast(@as(__uint32_t, 16))) | (_data << @intCast(@as(__uint32_t, 16))))) & @as(c_uint, 4278255615)) >> @intCast(@as(__uint32_t, 8))) ^ ((_data >> @intCast(@as(__uint32_t, 8))) | (_data << @intCast(@as(__uint32_t, 24))));
    return _data;
}
pub fn _OSSwapInt64(arg__data: __uint64_t) callconv(.c) __uint64_t {
    var _data = arg__data;
    _ = &_data;
    const union_unnamed_1 = extern union {
        _ull: __uint64_t,
        _ul: [2]__uint32_t,
    };
    _ = &union_unnamed_1;
    var _u: union_unnamed_1 = undefined;
    _ = &_u;
    _u._ul[@as(c_int, 0)] = @truncate(_data >> @intCast(@as(__uint64_t, 32)));
    _u._ul[@as(c_int, 1)] = @truncate(_data & @as(__uint64_t, 4294967295));
    _u._ul[@as(c_int, 0)] = _OSSwapInt32(_u._ul[@as(c_int, 0)]);
    _u._ul[@as(c_int, 1)] = _OSSwapInt32(_u._ul[@as(c_int, 1)]);
    return _u._ull;
} // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/wait.h:201:19: warning: struct demoted to opaque type - has bitfield
const struct_unnamed_2 = opaque {}; // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/wait.h:211:4: warning: union demoted to opaque type - has opaque field
pub const union_wait = opaque {};
pub extern fn wait([*c]c_int) pid_t;
pub extern fn waitpid(pid_t, [*c]c_int, c_int) pid_t;
pub extern fn waitid(idtype_t, id_t, [*c]siginfo_t, c_int) c_int;
pub extern fn wait3([*c]c_int, c_int, [*c]struct_rusage) pid_t;
pub extern fn wait4(pid_t, [*c]c_int, c_int, [*c]struct_rusage) pid_t;
pub extern fn alloca(__size: usize) ?*anyopaque;
pub const ct_rune_t = __darwin_ct_rune_t;
pub const rune_t = __darwin_rune_t;
pub const wchar_t = __darwin_wchar_t;
pub const div_t = extern struct {
    quot: c_int = 0,
    rem: c_int = 0,
};
pub const ldiv_t = extern struct {
    quot: c_long = 0,
    rem: c_long = 0,
};
pub const lldiv_t = extern struct {
    quot: c_longlong = 0,
    rem: c_longlong = 0,
};
pub extern var __mb_cur_max: c_int;
pub const malloc_type_id_t = c_ulonglong;
pub extern fn malloc_type_malloc(size: usize, type_id: malloc_type_id_t) ?*anyopaque;
pub extern fn malloc_type_calloc(count: usize, size: usize, type_id: malloc_type_id_t) ?*anyopaque;
pub extern fn malloc_type_free(ptr: ?*anyopaque, type_id: malloc_type_id_t) void;
pub extern fn malloc_type_realloc(ptr: ?*anyopaque, size: usize, type_id: malloc_type_id_t) ?*anyopaque;
pub extern fn malloc_type_valloc(size: usize, type_id: malloc_type_id_t) ?*anyopaque;
pub extern fn malloc_type_aligned_alloc(alignment: usize, size: usize, type_id: malloc_type_id_t) ?*anyopaque;
pub extern fn malloc_type_posix_memalign(memptr: [*c]?*anyopaque, alignment: usize, size: usize, type_id: malloc_type_id_t) c_int;
pub const struct__malloc_zone_t = opaque {
    pub const malloc_type_zone_malloc = __root.malloc_type_zone_malloc;
    pub const malloc_type_zone_calloc = __root.malloc_type_zone_calloc;
    pub const malloc_type_zone_free = __root.malloc_type_zone_free;
    pub const malloc_type_zone_realloc = __root.malloc_type_zone_realloc;
    pub const malloc_type_zone_valloc = __root.malloc_type_zone_valloc;
    pub const malloc_type_zone_memalign = __root.malloc_type_zone_memalign;
    pub const memalign = __root.malloc_type_zone_memalign;
};
pub const malloc_zone_t = struct__malloc_zone_t;
pub extern fn malloc_type_zone_malloc(zone: ?*malloc_zone_t, size: usize, type_id: malloc_type_id_t) ?*anyopaque;
pub extern fn malloc_type_zone_calloc(zone: ?*malloc_zone_t, count: usize, size: usize, type_id: malloc_type_id_t) ?*anyopaque;
pub extern fn malloc_type_zone_free(zone: ?*malloc_zone_t, ptr: ?*anyopaque, type_id: malloc_type_id_t) void;
pub extern fn malloc_type_zone_realloc(zone: ?*malloc_zone_t, ptr: ?*anyopaque, size: usize, type_id: malloc_type_id_t) ?*anyopaque;
pub extern fn malloc_type_zone_valloc(zone: ?*malloc_zone_t, size: usize, type_id: malloc_type_id_t) ?*anyopaque;
pub extern fn malloc_type_zone_memalign(zone: ?*malloc_zone_t, alignment: usize, size: usize, type_id: malloc_type_id_t) ?*anyopaque;
pub extern fn malloc(__size: usize) ?*anyopaque;
pub extern fn calloc(__count: usize, __size: usize) ?*anyopaque;
pub extern fn free(?*anyopaque) void;
pub extern fn realloc(__ptr: ?*anyopaque, __size: usize) ?*anyopaque;
pub extern fn reallocf(__ptr: ?*anyopaque, __size: usize) ?*anyopaque;
pub extern fn valloc(__size: usize) ?*anyopaque;
pub extern fn aligned_alloc(__alignment: usize, __size: usize) ?*anyopaque;
pub extern fn posix_memalign(__memptr: [*c]?*anyopaque, __alignment: usize, __size: usize) c_int;
pub extern fn abort() noreturn;
pub extern fn abs(c_int) c_int;
pub extern fn atexit(?*const fn () callconv(.c) void) c_int;
pub extern fn at_quick_exit(?*const fn () callconv(.c) void) c_int;
pub extern fn atof([*c]const u8) f64;
pub extern fn atoi([*c]const u8) c_int;
pub extern fn atol([*c]const u8) c_long;
pub extern fn atoll([*c]const u8) c_longlong;
pub extern fn bsearch(__key: ?*const anyopaque, __base: ?*const anyopaque, __nel: usize, __width: usize, __compar: ?*const fn (?*const anyopaque, ?*const anyopaque) callconv(.c) c_int) ?*anyopaque;
pub extern fn div(c_int, c_int) div_t;
pub extern fn exit(c_int) noreturn;
pub extern fn getenv([*c]const u8) [*c]u8;
pub extern fn labs(c_long) c_long;
pub extern fn ldiv(c_long, c_long) ldiv_t;
pub extern fn llabs(c_longlong) c_longlong;
pub extern fn lldiv(c_longlong, c_longlong) lldiv_t;
pub extern fn mblen(__s: [*c]const u8, __n: usize) c_int;
pub extern fn mbstowcs(noalias [*c]wchar_t, noalias [*c]const u8, __n: usize) usize;
pub extern fn mbtowc(noalias [*c]wchar_t, noalias [*c]const u8, __n: usize) c_int;
pub extern fn qsort(__base: ?*anyopaque, __nel: usize, __width: usize, __compar: ?*const fn (?*const anyopaque, ?*const anyopaque) callconv(.c) c_int) void;
pub extern fn quick_exit(c_int) noreturn;
pub extern fn rand() c_int;
pub extern fn srand(c_uint) void;
pub extern fn strtod([*c]const u8, [*c][*c]u8) f64;
pub extern fn strtof([*c]const u8, [*c][*c]u8) f32;
pub extern fn strtol(__str: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_long;
pub extern fn strtold([*c]const u8, [*c][*c]u8) c_longdouble;
pub extern fn strtoll(__str: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_longlong;
pub extern fn strtoul(__str: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_ulong;
pub extern fn strtoull(__str: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_ulonglong;
pub extern fn system([*c]const u8) c_int;
pub extern fn wcstombs(noalias [*c]u8, noalias [*c]const wchar_t, __n: usize) usize;
pub extern fn wctomb([*c]u8, wchar_t) c_int;
pub extern fn _Exit(c_int) noreturn;
pub extern fn a64l([*c]const u8) c_long;
pub extern fn drand48() f64;
pub extern fn ecvt(f64, c_int, noalias [*c]c_int, noalias [*c]c_int) [*c]u8;
pub extern fn erand48([*c]c_ushort) f64;
pub extern fn fcvt(f64, c_int, noalias [*c]c_int, noalias [*c]c_int) [*c]u8;
pub extern fn gcvt(f64, c_int, [*c]u8) [*c]u8;
pub extern fn getsubopt([*c][*c]u8, [*c]const [*c]u8, [*c][*c]u8) c_int;
pub extern fn grantpt(c_int) c_int;
pub extern fn initstate(c_uint, [*c]u8, __size: usize) [*c]u8;
pub extern fn jrand48([*c]c_ushort) c_long;
pub extern fn l64a(c_long) [*c]u8;
pub extern fn lcong48([*c]c_ushort) void;
pub extern fn lrand48() c_long;
pub extern fn mktemp([*c]u8) [*c]u8;
pub extern fn mkstemp([*c]u8) c_int;
pub extern fn mrand48() c_long;
pub extern fn nrand48([*c]c_ushort) c_long;
pub extern fn posix_openpt(c_int) c_int;
pub extern fn ptsname(c_int) [*c]u8;
pub extern fn ptsname_r(fildes: c_int, buffer: [*c]u8, buflen: usize) c_int;
pub extern fn putenv([*c]u8) c_int;
pub extern fn random() c_long;
pub extern fn rand_r([*c]c_uint) c_int;
pub extern fn realpath(noalias [*c]const u8, noalias [*c]u8) [*c]u8;
pub extern fn seed48([*c]c_ushort) [*c]c_ushort;
pub extern fn setenv(__name: [*c]const u8, __value: [*c]const u8, __overwrite: c_int) c_int;
pub extern fn setkey([*c]const u8) void;
pub extern fn setstate([*c]const u8) [*c]u8;
pub extern fn srand48(c_long) void;
pub extern fn srandom(c_uint) void;
pub extern fn unlockpt(c_int) c_int;
pub extern fn unsetenv([*c]const u8) c_int;
pub const dev_t = __darwin_dev_t;
pub const mode_t = __darwin_mode_t;
pub extern fn arc4random() u32;
pub extern fn arc4random_addrandom([*c]u8, __datlen: c_int) void;
pub extern fn arc4random_buf(__buf: ?*anyopaque, __nbytes: usize) void;
pub extern fn arc4random_stir() void;
pub extern fn arc4random_uniform(__upper_bound: u32) u32;
pub extern fn cgetcap([*c]u8, [*c]const u8, c_int) [*c]u8;
pub extern fn cgetclose() c_int;
pub extern fn cgetent([*c][*c]u8, [*c][*c]u8, [*c]const u8) c_int;
pub extern fn cgetfirst([*c][*c]u8, [*c][*c]u8) c_int;
pub extern fn cgetmatch([*c]const u8, [*c]const u8) c_int;
pub extern fn cgetnext([*c][*c]u8, [*c][*c]u8) c_int;
pub extern fn cgetnum([*c]u8, [*c]const u8, [*c]c_long) c_int;
pub extern fn cgetset([*c]const u8) c_int;
pub extern fn cgetstr([*c]u8, [*c]const u8, [*c][*c]u8) c_int;
pub extern fn cgetustr([*c]u8, [*c]const u8, [*c][*c]u8) c_int;
pub extern fn daemon(c_int, c_int) c_int;
pub extern fn devname(dev_t, mode_t) [*c]u8;
pub extern fn devname_r(dev_t, mode_t, buf: [*c]u8, len: c_int) [*c]u8;
pub extern fn getbsize([*c]c_int, [*c]c_long) [*c]u8;
pub extern fn getloadavg([*c]f64, __nelem: c_int) c_int;
pub extern fn getprogname() [*c]const u8;
pub extern fn setprogname([*c]const u8) void;
pub extern fn heapsort(__base: ?*anyopaque, __nel: usize, __width: usize, __compar: ?*const fn (?*const anyopaque, ?*const anyopaque) callconv(.c) c_int) c_int;
pub extern fn mergesort(__base: ?*anyopaque, __nel: usize, __width: usize, __compar: ?*const fn (?*const anyopaque, ?*const anyopaque) callconv(.c) c_int) c_int;
pub extern fn psort(__base: ?*anyopaque, __nel: usize, __width: usize, __compar: ?*const fn (?*const anyopaque, ?*const anyopaque) callconv(.c) c_int) void;
pub extern fn psort_r(__base: ?*anyopaque, __nel: usize, __width: usize, ?*anyopaque, __compar: ?*const fn (?*anyopaque, ?*const anyopaque, ?*const anyopaque) callconv(.c) c_int) void;
pub extern fn qsort_r(__base: ?*anyopaque, __nel: usize, __width: usize, ?*anyopaque, __compar: ?*const fn (?*anyopaque, ?*const anyopaque, ?*const anyopaque) callconv(.c) c_int) void;
pub extern fn radixsort(__base: [*c][*c]const u8, __nel: c_int, __table: [*c]const u8, __endbyte: c_uint) c_int;
pub extern fn rpmatch([*c]const u8) c_int;
pub extern fn sradixsort(__base: [*c][*c]const u8, __nel: c_int, __table: [*c]const u8, __endbyte: c_uint) c_int;
pub extern fn sranddev() void;
pub extern fn srandomdev() void;
pub extern fn strtonum(__numstr: [*c]const u8, __minval: c_longlong, __maxval: c_longlong, __errstrp: [*c][*c]const u8) c_longlong;
pub extern fn strtoq(__str: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_longlong;
pub extern fn strtouq(__str: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_ulonglong;
pub extern var suboptarg: [*c]u8;
pub const JPC_Real = f32;
pub const JPC_MAX_PHYSICS_JOBS: c_int = 2048;
pub const JPC_MAX_PHYSICS_BARRIERS: c_int = 8;
const enum_unnamed_3 = c_uint;
pub const JPC_PhysicsUpdateError = u8;
pub const JPC_PHYSICS_UPDATE_NO_ERROR: c_int = 0;
pub const JPC_PHYSICS_UPDATE_MANIFOLD_CACHE_FULL: c_int = 1;
pub const JPC_PHYSICS_UPDATE_BODY_PAIR_CACHE_FULL: c_int = 2;
pub const JPC_PHYSICS_UPDATE_CONTACT_CONSTRAINTS_FULL: c_int = 4;
const enum_unnamed_4 = c_uint;
pub const JPC_ShapeType = u8;
pub const JPC_SHAPE_TYPE_CONVEX: c_int = 0;
pub const JPC_SHAPE_TYPE_COMPOUND: c_int = 1;
pub const JPC_SHAPE_TYPE_DECORATED: c_int = 2;
pub const JPC_SHAPE_TYPE_MESH: c_int = 3;
pub const JPC_SHAPE_TYPE_HEIGHT_FIELD: c_int = 4;
pub const JPC_SHAPE_TYPE_SOFT_BODY: c_int = 5;
pub const JPC_SHAPE_TYPE_USER1: c_int = 6;
pub const JPC_SHAPE_TYPE_USER2: c_int = 7;
pub const JPC_SHAPE_TYPE_USER3: c_int = 8;
pub const JPC_SHAPE_TYPE_USER4: c_int = 9;
const enum_unnamed_5 = c_uint;
pub const JPC_ShapeSubType = u8;
pub const JPC_SHAPE_SUB_TYPE_SPHERE: c_int = 0;
pub const JPC_SHAPE_SUB_TYPE_BOX: c_int = 1;
pub const JPC_SHAPE_SUB_TYPE_TRIANGLE: c_int = 2;
pub const JPC_SHAPE_SUB_TYPE_CAPSULE: c_int = 3;
pub const JPC_SHAPE_SUB_TYPE_TAPERED_CAPSULE: c_int = 4;
pub const JPC_SHAPE_SUB_TYPE_CYLINDER: c_int = 5;
pub const JPC_SHAPE_SUB_TYPE_CONVEX_HULL: c_int = 6;
pub const JPC_SHAPE_SUB_TYPE_STATIC_COMPOUND: c_int = 7;
pub const JPC_SHAPE_SUB_TYPE_MUTABLE_COMPOUND: c_int = 8;
pub const JPC_SHAPE_SUB_TYPE_ROTATED_TRANSLATED: c_int = 9;
pub const JPC_SHAPE_SUB_TYPE_SCALED: c_int = 10;
pub const JPC_SHAPE_SUB_TYPE_OFFSET_CENTER_OF_MASS: c_int = 11;
pub const JPC_SHAPE_SUB_TYPE_MESH: c_int = 12;
pub const JPC_SHAPE_SUB_TYPE_HEIGHT_FIELD: c_int = 13;
pub const JPC_SHAPE_SUB_TYPE_SOFT_BODY: c_int = 14;
pub const JPC_SHAPE_SUB_TYPE_USER1: c_int = 15;
pub const JPC_SHAPE_SUB_TYPE_USER2: c_int = 16;
pub const JPC_SHAPE_SUB_TYPE_USER3: c_int = 17;
pub const JPC_SHAPE_SUB_TYPE_USER4: c_int = 18;
pub const JPC_SHAPE_SUB_TYPE_USER5: c_int = 19;
pub const JPC_SHAPE_SUB_TYPE_USER6: c_int = 20;
pub const JPC_SHAPE_SUB_TYPE_USER7: c_int = 21;
pub const JPC_SHAPE_SUB_TYPE_USER8: c_int = 22;
pub const JPC_SHAPE_SUB_TYPE_USER_CONVEX1: c_int = 23;
pub const JPC_SHAPE_SUB_TYPE_USER_CONVEX2: c_int = 24;
pub const JPC_SHAPE_SUB_TYPE_USER_CONVEX3: c_int = 25;
pub const JPC_SHAPE_SUB_TYPE_USER_CONVEX4: c_int = 26;
pub const JPC_SHAPE_SUB_TYPE_USER_CONVEX5: c_int = 27;
pub const JPC_SHAPE_SUB_TYPE_USER_CONVEX6: c_int = 28;
pub const JPC_SHAPE_SUB_TYPE_USER_CONVEX7: c_int = 29;
pub const JPC_SHAPE_SUB_TYPE_USER_CONVEX8: c_int = 30;
const enum_unnamed_6 = c_uint;
pub const JPC_CONSTRAINT_TYPE_CONSTRAINT: c_int = 0;
pub const JPC_CONSTRAINT_TYPE_TWO_BODY_CONSTRAINT: c_int = 1;
pub const _JPC_CONSTRAINT_TYPE_FORCEU32: c_int = 2147483647;
pub const enum_JPC_ConstraintType = c_uint;
pub const JPC_ConstraintType = enum_JPC_ConstraintType;
pub const JPC_CONSTRAINT_SUB_TYPE_FIXED: c_int = 0;
pub const JPC_CONSTRAINT_SUB_TYPE_POINT: c_int = 1;
pub const JPC_CONSTRAINT_SUB_TYPE_HINGE: c_int = 2;
pub const JPC_CONSTRAINT_SUB_TYPE_SLIDER: c_int = 3;
pub const JPC_CONSTRAINT_SUB_TYPE_DISTANCE: c_int = 4;
pub const JPC_CONSTRAINT_SUB_TYPE_CONE: c_int = 5;
pub const JPC_CONSTRAINT_SUB_TYPE_SWING_TWIST: c_int = 6;
pub const JPC_CONSTRAINT_SUB_TYPE_SIX_DOF: c_int = 7;
pub const JPC_CONSTRAINT_SUB_TYPE_PATH: c_int = 8;
pub const JPC_CONSTRAINT_SUB_TYPE_VEHICLE: c_int = 9;
pub const JPC_CONSTRAINT_SUB_TYPE_RACK_AND_PINION: c_int = 10;
pub const JPC_CONSTRAINT_SUB_TYPE_GEAR: c_int = 11;
pub const JPC_CONSTRAINT_SUB_TYPE_PULLEY: c_int = 12;
pub const JPC_CONSTRAINT_SUB_TYPE_USER1: c_int = 13;
pub const JPC_CONSTRAINT_SUB_TYPE_USER2: c_int = 14;
pub const JPC_CONSTRAINT_SUB_TYPE_USER3: c_int = 15;
pub const JPC_CONSTRAINT_SUB_TYPE_USER4: c_int = 16;
pub const _JPC_CONSTRAINT_SUB_TYPE_FORCEU32: c_int = 2147483647;
pub const enum_JPC_ConstraintSubType = c_uint;
pub const JPC_ConstraintSubType = enum_JPC_ConstraintSubType;
pub const JPC_CONSTRAINT_SPACE_LOCAL_TO_BODY_COM: c_int = 0;
pub const JPC_CONSTRAINT_SPACE_WORLD_SPACE: c_int = 1;
pub const _JPC_CONSTRAINT_SPACE_FORCEU32: c_int = 2147483647;
pub const enum_JPC_ConstraintSpace = c_uint;
pub const JPC_ConstraintSpace = enum_JPC_ConstraintSpace;
pub const JPC_MotionType = u8;
pub const JPC_MOTION_TYPE_STATIC: c_int = 0;
pub const JPC_MOTION_TYPE_KINEMATIC: c_int = 1;
pub const JPC_MOTION_TYPE_DYNAMIC: c_int = 2;
const enum_unnamed_7 = c_uint;
pub const JPC_MotionQuality = u8;
pub const JPC_MOTION_QUALITY_DISCRETE: c_int = 0;
pub const JPC_MOTION_QUALITY_LINEAR_CAST: c_int = 1;
const enum_unnamed_8 = c_uint;
pub const JPC_AllowedDOFs = u8;
pub const JPC_ALLOWED_DOFS_NONE: c_int = 0;
pub const JPC_ALLOWED_DOFS_ALL: c_int = 63;
pub const JPC_ALLOWED_DOFS_TRANSLATION_X: c_int = 1;
pub const JPC_ALLOWED_DOFS_TRANSLATION_Y: c_int = 2;
pub const JPC_ALLOWED_DOFS_TRANSLATION_Z: c_int = 4;
pub const JPC_ALLOWED_DOFS_ROTATION_X: c_int = 8;
pub const JPC_ALLOWED_DOFS_ROTATION_Y: c_int = 16;
pub const JPC_ALLOWED_DOFS_ROTATION_Z: c_int = 32;
const enum_unnamed_9 = c_uint;
pub const JPC_OverrideMassProperties = u8;
pub const JPC_OVERRIDE_MASS_PROPS_CALC_MASS_INERTIA: c_int = 0;
pub const JPC_OVERRIDE_MASS_PROPS_CALC_INERTIA: c_int = 1;
pub const JPC_OVERRIDE_MASS_PROPS_MASS_INERTIA_PROVIDED: c_int = 2;
const enum_unnamed_10 = c_uint;
pub const JPC_CHARACTER_GROUND_STATE_ON_GROUND: c_int = 0;
pub const JPC_CHARACTER_GROUND_STATE_ON_STEEP_GROUND: c_int = 1;
pub const JPC_CHARACTER_GROUND_STATE_NOT_SUPPORTED: c_int = 2;
pub const JPC_CHARACTER_GROUND_STATE_IN_AIR: c_int = 3;
pub const _JPC_CHARACTER_GROUND_FORCEU32: c_int = 2147483647;
pub const enum_JPC_CharacterGroundState = c_uint;
pub const JPC_CharacterGroundState = enum_JPC_CharacterGroundState;
pub const JPC_ACTIVATION_ACTIVATE: c_int = 0;
pub const JPC_ACTIVATION_DONT_ACTIVATE: c_int = 1;
pub const _JPC_ACTIVATION_FORCEU32: c_int = 2147483647;
pub const enum_JPC_Activation = c_uint;
pub const JPC_Activation = enum_JPC_Activation;
pub const JPC_VALIDATE_RESULT_ACCEPT_ALL_CONTACTS: c_int = 0;
pub const JPC_VALIDATE_RESULT_ACCEPT_CONTACT: c_int = 1;
pub const JPC_VALIDATE_RESULT_REJECT_CONTACT: c_int = 2;
pub const JPC_VALIDATE_RESULT_REJECT_ALL_CONTACTS: c_int = 3;
pub const _JPC_VALIDATE_RESULT_FORCEU32: c_int = 2147483647;
pub const enum_JPC_ValidateResult = c_uint;
pub const JPC_ValidateResult = enum_JPC_ValidateResult;
pub const JPC_BackFaceMode = u8;
pub const JPC_BACK_FACE_IGNORE: c_int = 0;
pub const JPC_BACK_FACE_COLLIDE: c_int = 1;
const enum_unnamed_11 = c_uint;
pub const JPC_BodyType = u8;
pub const JPC_BODY_TYPE_RIGID_BODY: c_int = 0;
pub const JPC_BODY_TYPE_SOFT_BODY: c_int = 1;
const enum_unnamed_12 = c_uint;
pub const JPC_ObjectLayer = u16;
pub const JPC_BroadPhaseLayer = u8;
pub const struct_JPC_BodyID = extern struct {
    id: u32 = 0,
    pub const JPC_BodyID_GetIndex = __root.JPC_BodyID_GetIndex;
    pub const JPC_BodyID_GetSequenceNumber = __root.JPC_BodyID_GetSequenceNumber;
    pub const JPC_BodyID_IsInvalid = __root.JPC_BodyID_IsInvalid;
    pub const GetIndex = __root.JPC_BodyID_GetIndex;
    pub const GetSequenceNumber = __root.JPC_BodyID_GetSequenceNumber;
    pub const IsInvalid = __root.JPC_BodyID_IsInvalid;
};
pub const JPC_BodyID = struct_JPC_BodyID;
pub const struct_JPC_SubShapeID = extern struct {
    id: u32 = 0,
};
pub const JPC_SubShapeID = struct_JPC_SubShapeID;
pub const JPC_CollisionGroupID = u32;
pub const JPC_CollisionSubGroupID = u32;
pub const JPC_AllocateFunction = ?*const fn (in_size: usize) callconv(.c) ?*anyopaque;
pub const JPC_ReallocateFunction = ?*const fn (in_block: ?*anyopaque, old_size: usize, new_size: usize) callconv(.c) ?*anyopaque;
pub const JPC_FreeFunction = ?*const fn (in_block: ?*anyopaque) callconv(.c) void;
pub const JPC_AlignedAllocateFunction = ?*const fn (in_size: usize, in_alignment: usize) callconv(.c) ?*anyopaque;
pub const JPC_AlignedFreeFunction = ?*const fn (in_block: ?*anyopaque) callconv(.c) void;
pub const JPC_TraceFunction = ?*const fn (inFMT: [*c]const u8, ...) callconv(.c) void;
pub const JPC_AssertFailedFunction = ?*const fn (in_expression: [*c]const u8, in_message: [*c]const u8, in_file: [*c]const u8, in_line: u32) callconv(.c) bool;
pub const struct_JPC_TempAllocator = opaque {
    pub const JPC_TempAllocator_Destroy = __root.JPC_TempAllocator_Destroy;
    pub const Destroy = __root.JPC_TempAllocator_Destroy;
};
pub const JPC_TempAllocator = struct_JPC_TempAllocator;
pub const struct_JPC_JobSystem = opaque {
    pub const JPC_JobSystem_Destroy = __root.JPC_JobSystem_Destroy;
    pub const Destroy = __root.JPC_JobSystem_Destroy;
};
pub const JPC_JobSystem = struct_JPC_JobSystem;
pub const struct_JPC_BodyInterface = opaque {
    pub const JPC_BodyInterface_CreateBody = __root.JPC_BodyInterface_CreateBody;
    pub const JPC_BodyInterface_CreateBodyWithID = __root.JPC_BodyInterface_CreateBodyWithID;
    pub const JPC_BodyInterface_DestroyBody = __root.JPC_BodyInterface_DestroyBody;
    pub const JPC_BodyInterface_DestroyBodies = __root.JPC_BodyInterface_DestroyBodies;
    pub const JPC_BodyInterface_AddBodiesAbort = __root.JPC_BodyInterface_AddBodiesAbort;
    pub const JPC_BodyInterface_AddBodiesFinalize = __root.JPC_BodyInterface_AddBodiesFinalize;
    pub const JPC_BodyInterface_AddBodiesPrepare = __root.JPC_BodyInterface_AddBodiesPrepare;
    pub const JPC_BodyInterface_AddBody = __root.JPC_BodyInterface_AddBody;
    pub const JPC_BodyInterface_RemoveBody = __root.JPC_BodyInterface_RemoveBody;
    pub const JPC_BodyInterface_RemoveBodies = __root.JPC_BodyInterface_RemoveBodies;
    pub const JPC_BodyInterface_CreateAndAddBody = __root.JPC_BodyInterface_CreateAndAddBody;
    pub const JPC_BodyInterface_IsAdded = __root.JPC_BodyInterface_IsAdded;
    pub const JPC_BodyInterface_SetLinearAndAngularVelocity = __root.JPC_BodyInterface_SetLinearAndAngularVelocity;
    pub const JPC_BodyInterface_GetLinearAndAngularVelocity = __root.JPC_BodyInterface_GetLinearAndAngularVelocity;
    pub const JPC_BodyInterface_SetLinearVelocity = __root.JPC_BodyInterface_SetLinearVelocity;
    pub const JPC_BodyInterface_GetLinearVelocity = __root.JPC_BodyInterface_GetLinearVelocity;
    pub const JPC_BodyInterface_AddLinearVelocity = __root.JPC_BodyInterface_AddLinearVelocity;
    pub const JPC_BodyInterface_AddLinearAndAngularVelocity = __root.JPC_BodyInterface_AddLinearAndAngularVelocity;
    pub const JPC_BodyInterface_SetAngularVelocity = __root.JPC_BodyInterface_SetAngularVelocity;
    pub const JPC_BodyInterface_GetAngularVelocity = __root.JPC_BodyInterface_GetAngularVelocity;
    pub const JPC_BodyInterface_GetPointVelocity = __root.JPC_BodyInterface_GetPointVelocity;
    pub const JPC_BodyInterface_GetPosition = __root.JPC_BodyInterface_GetPosition;
    pub const JPC_BodyInterface_SetPosition = __root.JPC_BodyInterface_SetPosition;
    pub const JPC_BodyInterface_GetCenterOfMassPosition = __root.JPC_BodyInterface_GetCenterOfMassPosition;
    pub const JPC_BodyInterface_GetRotation = __root.JPC_BodyInterface_GetRotation;
    pub const JPC_BodyInterface_SetRotation = __root.JPC_BodyInterface_SetRotation;
    pub const JPC_BodyInterface_ActivateBody = __root.JPC_BodyInterface_ActivateBody;
    pub const JPC_BodyInterface_ActivateBodies = __root.JPC_BodyInterface_ActivateBodies;
    pub const JPC_BodyInterface_DeactivateBody = __root.JPC_BodyInterface_DeactivateBody;
    pub const JPC_BodyInterface_DeactivateBodies = __root.JPC_BodyInterface_DeactivateBodies;
    pub const JPC_BodyInterface_IsActive = __root.JPC_BodyInterface_IsActive;
    pub const JPC_BodyInterface_SetShape = __root.JPC_BodyInterface_SetShape;
    pub const JPC_BodyInterface_SetPositionRotationAndVelocity = __root.JPC_BodyInterface_SetPositionRotationAndVelocity;
    pub const JPC_BodyInterface_AddForce = __root.JPC_BodyInterface_AddForce;
    pub const JPC_BodyInterface_AddForceAtPosition = __root.JPC_BodyInterface_AddForceAtPosition;
    pub const JPC_BodyInterface_AddTorque = __root.JPC_BodyInterface_AddTorque;
    pub const JPC_BodyInterface_AddForceAndTorque = __root.JPC_BodyInterface_AddForceAndTorque;
    pub const JPC_BodyInterface_AddImpulse = __root.JPC_BodyInterface_AddImpulse;
    pub const JPC_BodyInterface_AddImpulseAtPosition = __root.JPC_BodyInterface_AddImpulseAtPosition;
    pub const JPC_BodyInterface_AddAngularImpulse = __root.JPC_BodyInterface_AddAngularImpulse;
    pub const JPC_BodyInterface_GetMotionType = __root.JPC_BodyInterface_GetMotionType;
    pub const JPC_BodyInterface_SetMotionType = __root.JPC_BodyInterface_SetMotionType;
    pub const JPC_BodyInterface_GetObjectLayer = __root.JPC_BodyInterface_GetObjectLayer;
    pub const JPC_BodyInterface_SetObjectLayer = __root.JPC_BodyInterface_SetObjectLayer;
    pub const CreateBody = __root.JPC_BodyInterface_CreateBody;
    pub const CreateBodyWithID = __root.JPC_BodyInterface_CreateBodyWithID;
    pub const DestroyBody = __root.JPC_BodyInterface_DestroyBody;
    pub const DestroyBodies = __root.JPC_BodyInterface_DestroyBodies;
    pub const AddBodiesAbort = __root.JPC_BodyInterface_AddBodiesAbort;
    pub const AddBodiesFinalize = __root.JPC_BodyInterface_AddBodiesFinalize;
    pub const AddBodiesPrepare = __root.JPC_BodyInterface_AddBodiesPrepare;
    pub const AddBody = __root.JPC_BodyInterface_AddBody;
    pub const RemoveBody = __root.JPC_BodyInterface_RemoveBody;
    pub const RemoveBodies = __root.JPC_BodyInterface_RemoveBodies;
    pub const CreateAndAddBody = __root.JPC_BodyInterface_CreateAndAddBody;
    pub const IsAdded = __root.JPC_BodyInterface_IsAdded;
    pub const SetLinearAndAngularVelocity = __root.JPC_BodyInterface_SetLinearAndAngularVelocity;
    pub const GetLinearAndAngularVelocity = __root.JPC_BodyInterface_GetLinearAndAngularVelocity;
    pub const SetLinearVelocity = __root.JPC_BodyInterface_SetLinearVelocity;
    pub const GetLinearVelocity = __root.JPC_BodyInterface_GetLinearVelocity;
    pub const AddLinearVelocity = __root.JPC_BodyInterface_AddLinearVelocity;
    pub const AddLinearAndAngularVelocity = __root.JPC_BodyInterface_AddLinearAndAngularVelocity;
    pub const SetAngularVelocity = __root.JPC_BodyInterface_SetAngularVelocity;
    pub const GetAngularVelocity = __root.JPC_BodyInterface_GetAngularVelocity;
    pub const GetPointVelocity = __root.JPC_BodyInterface_GetPointVelocity;
    pub const GetPosition = __root.JPC_BodyInterface_GetPosition;
    pub const SetPosition = __root.JPC_BodyInterface_SetPosition;
    pub const GetCenterOfMassPosition = __root.JPC_BodyInterface_GetCenterOfMassPosition;
    pub const GetRotation = __root.JPC_BodyInterface_GetRotation;
    pub const SetRotation = __root.JPC_BodyInterface_SetRotation;
    pub const ActivateBody = __root.JPC_BodyInterface_ActivateBody;
    pub const ActivateBodies = __root.JPC_BodyInterface_ActivateBodies;
    pub const DeactivateBody = __root.JPC_BodyInterface_DeactivateBody;
    pub const DeactivateBodies = __root.JPC_BodyInterface_DeactivateBodies;
    pub const IsActive = __root.JPC_BodyInterface_IsActive;
    pub const SetShape = __root.JPC_BodyInterface_SetShape;
    pub const SetPositionRotationAndVelocity = __root.JPC_BodyInterface_SetPositionRotationAndVelocity;
    pub const AddForce = __root.JPC_BodyInterface_AddForce;
    pub const AddForceAtPosition = __root.JPC_BodyInterface_AddForceAtPosition;
    pub const AddTorque = __root.JPC_BodyInterface_AddTorque;
    pub const AddForceAndTorque = __root.JPC_BodyInterface_AddForceAndTorque;
    pub const AddImpulse = __root.JPC_BodyInterface_AddImpulse;
    pub const AddImpulseAtPosition = __root.JPC_BodyInterface_AddImpulseAtPosition;
    pub const AddAngularImpulse = __root.JPC_BodyInterface_AddAngularImpulse;
    pub const GetMotionType = __root.JPC_BodyInterface_GetMotionType;
    pub const SetMotionType = __root.JPC_BodyInterface_SetMotionType;
    pub const GetObjectLayer = __root.JPC_BodyInterface_GetObjectLayer;
    pub const SetObjectLayer = __root.JPC_BodyInterface_SetObjectLayer;
};
pub const JPC_BodyInterface = struct_JPC_BodyInterface;
pub const struct_JPC_BodyInterface_AddState = opaque {};
pub const JPC_BodyInterface_AddState = struct_JPC_BodyInterface_AddState;
pub const struct_JPC_BodyLockInterface = opaque {
    pub const JPC_BodyLockInterface_LockRead = __root.JPC_BodyLockInterface_LockRead;
    pub const JPC_BodyLockInterface_UnlockRead = __root.JPC_BodyLockInterface_UnlockRead;
    pub const JPC_BodyLockInterface_LockWrite = __root.JPC_BodyLockInterface_LockWrite;
    pub const JPC_BodyLockInterface_UnlockWrite = __root.JPC_BodyLockInterface_UnlockWrite;
    pub const LockRead = __root.JPC_BodyLockInterface_LockRead;
    pub const UnlockRead = __root.JPC_BodyLockInterface_UnlockRead;
    pub const LockWrite = __root.JPC_BodyLockInterface_LockWrite;
    pub const UnlockWrite = __root.JPC_BodyLockInterface_UnlockWrite;
};
pub const JPC_BodyLockInterface = struct_JPC_BodyLockInterface;
pub const struct_JPC_NarrowPhaseQuery = opaque {
    pub const JPC_NarrowPhaseQuery_CastRay = __root.JPC_NarrowPhaseQuery_CastRay;
    pub const CastRay = __root.JPC_NarrowPhaseQuery_CastRay;
};
pub const JPC_NarrowPhaseQuery = struct_JPC_NarrowPhaseQuery;
pub const struct_JPC_ShapeSettings = opaque {
    pub const JPC_ShapeSettings_AddRef = __root.JPC_ShapeSettings_AddRef;
    pub const JPC_ShapeSettings_Release = __root.JPC_ShapeSettings_Release;
    pub const JPC_ShapeSettings_GetRefCount = __root.JPC_ShapeSettings_GetRefCount;
    pub const JPC_ShapeSettings_CreateShape = __root.JPC_ShapeSettings_CreateShape;
    pub const JPC_ShapeSettings_GetUserData = __root.JPC_ShapeSettings_GetUserData;
    pub const JPC_ShapeSettings_SetUserData = __root.JPC_ShapeSettings_SetUserData;
    pub const JPC_RotatedTranslatedShapeSettings_Create = __root.JPC_RotatedTranslatedShapeSettings_Create;
    pub const JPC_ScaledShapeSettings_Create = __root.JPC_ScaledShapeSettings_Create;
    pub const JPC_OffsetCenterOfMassShapeSettings_Create = __root.JPC_OffsetCenterOfMassShapeSettings_Create;
    pub const AddRef = __root.JPC_ShapeSettings_AddRef;
    pub const Release = __root.JPC_ShapeSettings_Release;
    pub const GetRefCount = __root.JPC_ShapeSettings_GetRefCount;
    pub const CreateShape = __root.JPC_ShapeSettings_CreateShape;
    pub const GetUserData = __root.JPC_ShapeSettings_GetUserData;
    pub const SetUserData = __root.JPC_ShapeSettings_SetUserData;
    pub const Create = __root.JPC_RotatedTranslatedShapeSettings_Create;
};
pub const JPC_ShapeSettings = struct_JPC_ShapeSettings;
pub const struct_JPC_ConvexShapeSettings = opaque {
    pub const JPC_ConvexShapeSettings_GetMaterial = __root.JPC_ConvexShapeSettings_GetMaterial;
    pub const JPC_ConvexShapeSettings_SetMaterial = __root.JPC_ConvexShapeSettings_SetMaterial;
    pub const JPC_ConvexShapeSettings_GetDensity = __root.JPC_ConvexShapeSettings_GetDensity;
    pub const JPC_ConvexShapeSettings_SetDensity = __root.JPC_ConvexShapeSettings_SetDensity;
    pub const GetMaterial = __root.JPC_ConvexShapeSettings_GetMaterial;
    pub const SetMaterial = __root.JPC_ConvexShapeSettings_SetMaterial;
    pub const GetDensity = __root.JPC_ConvexShapeSettings_GetDensity;
    pub const SetDensity = __root.JPC_ConvexShapeSettings_SetDensity;
};
pub const JPC_ConvexShapeSettings = struct_JPC_ConvexShapeSettings;
pub const struct_JPC_BoxShapeSettings = opaque {
    pub const JPC_BoxShapeSettings_GetHalfExtent = __root.JPC_BoxShapeSettings_GetHalfExtent;
    pub const JPC_BoxShapeSettings_SetHalfExtent = __root.JPC_BoxShapeSettings_SetHalfExtent;
    pub const JPC_BoxShapeSettings_GetConvexRadius = __root.JPC_BoxShapeSettings_GetConvexRadius;
    pub const JPC_BoxShapeSettings_SetConvexRadius = __root.JPC_BoxShapeSettings_SetConvexRadius;
    pub const GetHalfExtent = __root.JPC_BoxShapeSettings_GetHalfExtent;
    pub const SetHalfExtent = __root.JPC_BoxShapeSettings_SetHalfExtent;
    pub const GetConvexRadius = __root.JPC_BoxShapeSettings_GetConvexRadius;
    pub const SetConvexRadius = __root.JPC_BoxShapeSettings_SetConvexRadius;
};
pub const JPC_BoxShapeSettings = struct_JPC_BoxShapeSettings;
pub const struct_JPC_SphereShapeSettings = opaque {
    pub const JPC_SphereShapeSettings_GetRadius = __root.JPC_SphereShapeSettings_GetRadius;
    pub const JPC_SphereShapeSettings_SetRadius = __root.JPC_SphereShapeSettings_SetRadius;
    pub const GetRadius = __root.JPC_SphereShapeSettings_GetRadius;
    pub const SetRadius = __root.JPC_SphereShapeSettings_SetRadius;
};
pub const JPC_SphereShapeSettings = struct_JPC_SphereShapeSettings;
pub const struct_JPC_TriangleShapeSettings = opaque {
    pub const JPC_TriangleShapeSettings_SetVertices = __root.JPC_TriangleShapeSettings_SetVertices;
    pub const JPC_TriangleShapeSettings_GetVertices = __root.JPC_TriangleShapeSettings_GetVertices;
    pub const JPC_TriangleShapeSettings_GetConvexRadius = __root.JPC_TriangleShapeSettings_GetConvexRadius;
    pub const JPC_TriangleShapeSettings_SetConvexRadius = __root.JPC_TriangleShapeSettings_SetConvexRadius;
    pub const SetVertices = __root.JPC_TriangleShapeSettings_SetVertices;
    pub const GetVertices = __root.JPC_TriangleShapeSettings_GetVertices;
    pub const GetConvexRadius = __root.JPC_TriangleShapeSettings_GetConvexRadius;
    pub const SetConvexRadius = __root.JPC_TriangleShapeSettings_SetConvexRadius;
};
pub const JPC_TriangleShapeSettings = struct_JPC_TriangleShapeSettings;
pub const struct_JPC_CapsuleShapeSettings = opaque {
    pub const JPC_CapsuleShapeSettings_GetHalfHeight = __root.JPC_CapsuleShapeSettings_GetHalfHeight;
    pub const JPC_CapsuleShapeSettings_SetHalfHeight = __root.JPC_CapsuleShapeSettings_SetHalfHeight;
    pub const JPC_CapsuleShapeSettings_GetRadius = __root.JPC_CapsuleShapeSettings_GetRadius;
    pub const JPC_CapsuleShapeSettings_SetRadius = __root.JPC_CapsuleShapeSettings_SetRadius;
    pub const GetHalfHeight = __root.JPC_CapsuleShapeSettings_GetHalfHeight;
    pub const SetHalfHeight = __root.JPC_CapsuleShapeSettings_SetHalfHeight;
    pub const GetRadius = __root.JPC_CapsuleShapeSettings_GetRadius;
    pub const SetRadius = __root.JPC_CapsuleShapeSettings_SetRadius;
};
pub const JPC_CapsuleShapeSettings = struct_JPC_CapsuleShapeSettings;
pub const struct_JPC_TaperedCapsuleShapeSettings = opaque {
    pub const JPC_TaperedCapsuleShapeSettings_GetHalfHeight = __root.JPC_TaperedCapsuleShapeSettings_GetHalfHeight;
    pub const JPC_TaperedCapsuleShapeSettings_SetHalfHeight = __root.JPC_TaperedCapsuleShapeSettings_SetHalfHeight;
    pub const JPC_TaperedCapsuleShapeSettings_GetTopRadius = __root.JPC_TaperedCapsuleShapeSettings_GetTopRadius;
    pub const JPC_TaperedCapsuleShapeSettings_SetTopRadius = __root.JPC_TaperedCapsuleShapeSettings_SetTopRadius;
    pub const JPC_TaperedCapsuleShapeSettings_GetBottomRadius = __root.JPC_TaperedCapsuleShapeSettings_GetBottomRadius;
    pub const JPC_TaperedCapsuleShapeSettings_SetBottomRadius = __root.JPC_TaperedCapsuleShapeSettings_SetBottomRadius;
    pub const GetHalfHeight = __root.JPC_TaperedCapsuleShapeSettings_GetHalfHeight;
    pub const SetHalfHeight = __root.JPC_TaperedCapsuleShapeSettings_SetHalfHeight;
    pub const GetTopRadius = __root.JPC_TaperedCapsuleShapeSettings_GetTopRadius;
    pub const SetTopRadius = __root.JPC_TaperedCapsuleShapeSettings_SetTopRadius;
    pub const GetBottomRadius = __root.JPC_TaperedCapsuleShapeSettings_GetBottomRadius;
    pub const SetBottomRadius = __root.JPC_TaperedCapsuleShapeSettings_SetBottomRadius;
};
pub const JPC_TaperedCapsuleShapeSettings = struct_JPC_TaperedCapsuleShapeSettings;
pub const struct_JPC_CylinderShapeSettings = opaque {
    pub const JPC_CylinderShapeSettings_GetConvexRadius = __root.JPC_CylinderShapeSettings_GetConvexRadius;
    pub const JPC_CylinderShapeSettings_SetConvexRadius = __root.JPC_CylinderShapeSettings_SetConvexRadius;
    pub const JPC_CylinderShapeSettings_GetHalfHeight = __root.JPC_CylinderShapeSettings_GetHalfHeight;
    pub const JPC_CylinderShapeSettings_SetHalfHeight = __root.JPC_CylinderShapeSettings_SetHalfHeight;
    pub const JPC_CylinderShapeSettings_GetRadius = __root.JPC_CylinderShapeSettings_GetRadius;
    pub const JPC_CylinderShapeSettings_SetRadius = __root.JPC_CylinderShapeSettings_SetRadius;
    pub const GetConvexRadius = __root.JPC_CylinderShapeSettings_GetConvexRadius;
    pub const SetConvexRadius = __root.JPC_CylinderShapeSettings_SetConvexRadius;
    pub const GetHalfHeight = __root.JPC_CylinderShapeSettings_GetHalfHeight;
    pub const SetHalfHeight = __root.JPC_CylinderShapeSettings_SetHalfHeight;
    pub const GetRadius = __root.JPC_CylinderShapeSettings_GetRadius;
    pub const SetRadius = __root.JPC_CylinderShapeSettings_SetRadius;
};
pub const JPC_CylinderShapeSettings = struct_JPC_CylinderShapeSettings;
pub const struct_JPC_ConvexHullShapeSettings = opaque {
    pub const JPC_ConvexHullShapeSettings_GetMaxConvexRadius = __root.JPC_ConvexHullShapeSettings_GetMaxConvexRadius;
    pub const JPC_ConvexHullShapeSettings_SetMaxConvexRadius = __root.JPC_ConvexHullShapeSettings_SetMaxConvexRadius;
    pub const JPC_ConvexHullShapeSettings_GetMaxErrorConvexRadius = __root.JPC_ConvexHullShapeSettings_GetMaxErrorConvexRadius;
    pub const JPC_ConvexHullShapeSettings_SetMaxErrorConvexRadius = __root.JPC_ConvexHullShapeSettings_SetMaxErrorConvexRadius;
    pub const JPC_ConvexHullShapeSettings_GetHullTolerance = __root.JPC_ConvexHullShapeSettings_GetHullTolerance;
    pub const JPC_ConvexHullShapeSettings_SetHullTolerance = __root.JPC_ConvexHullShapeSettings_SetHullTolerance;
    pub const GetMaxConvexRadius = __root.JPC_ConvexHullShapeSettings_GetMaxConvexRadius;
    pub const SetMaxConvexRadius = __root.JPC_ConvexHullShapeSettings_SetMaxConvexRadius;
    pub const GetMaxErrorConvexRadius = __root.JPC_ConvexHullShapeSettings_GetMaxErrorConvexRadius;
    pub const SetMaxErrorConvexRadius = __root.JPC_ConvexHullShapeSettings_SetMaxErrorConvexRadius;
    pub const GetHullTolerance = __root.JPC_ConvexHullShapeSettings_GetHullTolerance;
    pub const SetHullTolerance = __root.JPC_ConvexHullShapeSettings_SetHullTolerance;
};
pub const JPC_ConvexHullShapeSettings = struct_JPC_ConvexHullShapeSettings;
pub const struct_JPC_HeightFieldShapeSettings = opaque {
    pub const JPC_HeightFieldShapeSettings_GetOffset = __root.JPC_HeightFieldShapeSettings_GetOffset;
    pub const JPC_HeightFieldShapeSettings_SetOffset = __root.JPC_HeightFieldShapeSettings_SetOffset;
    pub const JPC_HeightFieldShapeSettings_GetScale = __root.JPC_HeightFieldShapeSettings_GetScale;
    pub const JPC_HeightFieldShapeSettings_SetScale = __root.JPC_HeightFieldShapeSettings_SetScale;
    pub const JPC_HeightFieldShapeSettings_GetBlockSize = __root.JPC_HeightFieldShapeSettings_GetBlockSize;
    pub const JPC_HeightFieldShapeSettings_SetBlockSize = __root.JPC_HeightFieldShapeSettings_SetBlockSize;
    pub const JPC_HeightFieldShapeSettings_GetBitsPerSample = __root.JPC_HeightFieldShapeSettings_GetBitsPerSample;
    pub const JPC_HeightFieldShapeSettings_SetBitsPerSample = __root.JPC_HeightFieldShapeSettings_SetBitsPerSample;
    pub const GetOffset = __root.JPC_HeightFieldShapeSettings_GetOffset;
    pub const SetOffset = __root.JPC_HeightFieldShapeSettings_SetOffset;
    pub const GetScale = __root.JPC_HeightFieldShapeSettings_GetScale;
    pub const SetScale = __root.JPC_HeightFieldShapeSettings_SetScale;
    pub const GetBlockSize = __root.JPC_HeightFieldShapeSettings_GetBlockSize;
    pub const SetBlockSize = __root.JPC_HeightFieldShapeSettings_SetBlockSize;
    pub const GetBitsPerSample = __root.JPC_HeightFieldShapeSettings_GetBitsPerSample;
    pub const SetBitsPerSample = __root.JPC_HeightFieldShapeSettings_SetBitsPerSample;
};
pub const JPC_HeightFieldShapeSettings = struct_JPC_HeightFieldShapeSettings;
pub const struct_JPC_MeshShapeSettings = opaque {
    pub const JPC_MeshShapeSettings_GetMaxTrianglesPerLeaf = __root.JPC_MeshShapeSettings_GetMaxTrianglesPerLeaf;
    pub const JPC_MeshShapeSettings_SetMaxTrianglesPerLeaf = __root.JPC_MeshShapeSettings_SetMaxTrianglesPerLeaf;
    pub const JPC_MeshShapeSettings_Sanitize = __root.JPC_MeshShapeSettings_Sanitize;
    pub const GetMaxTrianglesPerLeaf = __root.JPC_MeshShapeSettings_GetMaxTrianglesPerLeaf;
    pub const SetMaxTrianglesPerLeaf = __root.JPC_MeshShapeSettings_SetMaxTrianglesPerLeaf;
    pub const Sanitize = __root.JPC_MeshShapeSettings_Sanitize;
};
pub const JPC_MeshShapeSettings = struct_JPC_MeshShapeSettings;
pub const struct_JPC_DecoratedShapeSettings = opaque {};
pub const JPC_DecoratedShapeSettings = struct_JPC_DecoratedShapeSettings;
pub const struct_JPC_CompoundShapeSettings = opaque {
    pub const JPC_CompoundShapeSettings_AddShape = __root.JPC_CompoundShapeSettings_AddShape;
    pub const AddShape = __root.JPC_CompoundShapeSettings_AddShape;
};
pub const JPC_CompoundShapeSettings = struct_JPC_CompoundShapeSettings;
pub const struct_JPC_CharacterContactSettings = opaque {};
pub const JPC_CharacterContactSettings = struct_JPC_CharacterContactSettings;
pub const struct_JPC_ConstraintSettings = opaque {
    pub const JPC_ConstraintSettings_AddRef = __root.JPC_ConstraintSettings_AddRef;
    pub const JPC_ConstraintSettings_Release = __root.JPC_ConstraintSettings_Release;
    pub const JPC_ConstraintSettings_GetRefCount = __root.JPC_ConstraintSettings_GetRefCount;
    pub const JPC_ConstraintSettings_GetUserData = __root.JPC_ConstraintSettings_GetUserData;
    pub const JPC_ConstraintSettings_SetUserData = __root.JPC_ConstraintSettings_SetUserData;
    pub const AddRef = __root.JPC_ConstraintSettings_AddRef;
    pub const Release = __root.JPC_ConstraintSettings_Release;
    pub const GetRefCount = __root.JPC_ConstraintSettings_GetRefCount;
    pub const GetUserData = __root.JPC_ConstraintSettings_GetUserData;
    pub const SetUserData = __root.JPC_ConstraintSettings_SetUserData;
};
pub const JPC_ConstraintSettings = struct_JPC_ConstraintSettings;
pub const struct_JPC_TwoBodyConstraintSettings = opaque {
    pub const JPC_TwoBodyConstraintSettings_CreateConstraint = __root.JPC_TwoBodyConstraintSettings_CreateConstraint;
    pub const CreateConstraint = __root.JPC_TwoBodyConstraintSettings_CreateConstraint;
};
pub const JPC_TwoBodyConstraintSettings = struct_JPC_TwoBodyConstraintSettings;
pub const struct_JPC_FixedConstraintSettings = opaque {
    pub const JPC_FixedConstraintSettings_SetSpace = __root.JPC_FixedConstraintSettings_SetSpace;
    pub const JPC_FixedConstraintSettings_SetAutoDetectPoint = __root.JPC_FixedConstraintSettings_SetAutoDetectPoint;
    pub const SetSpace = __root.JPC_FixedConstraintSettings_SetSpace;
    pub const SetAutoDetectPoint = __root.JPC_FixedConstraintSettings_SetAutoDetectPoint;
};
pub const JPC_FixedConstraintSettings = struct_JPC_FixedConstraintSettings;
pub const struct_JPC_PhysicsSystem = opaque {
    pub const JPC_PhysicsSystem_Destroy = __root.JPC_PhysicsSystem_Destroy;
    pub const JPC_PhysicsSystem_SetBodyActivationListener = __root.JPC_PhysicsSystem_SetBodyActivationListener;
    pub const JPC_PhysicsSystem_GetBodyActivationListener = __root.JPC_PhysicsSystem_GetBodyActivationListener;
    pub const JPC_PhysicsSystem_SetContactListener = __root.JPC_PhysicsSystem_SetContactListener;
    pub const JPC_PhysicsSystem_GetContactListener = __root.JPC_PhysicsSystem_GetContactListener;
    pub const JPC_PhysicsSystem_GetNumBodies = __root.JPC_PhysicsSystem_GetNumBodies;
    pub const JPC_PhysicsSystem_GetNumActiveBodies = __root.JPC_PhysicsSystem_GetNumActiveBodies;
    pub const JPC_PhysicsSystem_GetMaxBodies = __root.JPC_PhysicsSystem_GetMaxBodies;
    pub const JPC_PhysicsSystem_GetGravity = __root.JPC_PhysicsSystem_GetGravity;
    pub const JPC_PhysicsSystem_SetGravity = __root.JPC_PhysicsSystem_SetGravity;
    pub const JPC_PhysicsSystem_GetBodyInterface = __root.JPC_PhysicsSystem_GetBodyInterface;
    pub const JPC_PhysicsSystem_GetBodyInterfaceNoLock = __root.JPC_PhysicsSystem_GetBodyInterfaceNoLock;
    pub const JPC_PhysicsSystem_OptimizeBroadPhase = __root.JPC_PhysicsSystem_OptimizeBroadPhase;
    pub const JPC_PhysicsSystem_AddStepListener = __root.JPC_PhysicsSystem_AddStepListener;
    pub const JPC_PhysicsSystem_RemoveStepListener = __root.JPC_PhysicsSystem_RemoveStepListener;
    pub const JPC_PhysicsSystem_AddConstraint = __root.JPC_PhysicsSystem_AddConstraint;
    pub const JPC_PhysicsSystem_RemoveConstraint = __root.JPC_PhysicsSystem_RemoveConstraint;
    pub const JPC_PhysicsSystem_Update = __root.JPC_PhysicsSystem_Update;
    pub const JPC_PhysicsSystem_GetBodyLockInterface = __root.JPC_PhysicsSystem_GetBodyLockInterface;
    pub const JPC_PhysicsSystem_GetBodyLockInterfaceNoLock = __root.JPC_PhysicsSystem_GetBodyLockInterfaceNoLock;
    pub const JPC_PhysicsSystem_GetNarrowPhaseQuery = __root.JPC_PhysicsSystem_GetNarrowPhaseQuery;
    pub const JPC_PhysicsSystem_GetNarrowPhaseQueryNoLock = __root.JPC_PhysicsSystem_GetNarrowPhaseQueryNoLock;
    pub const JPC_PhysicsSystem_GetBodyIDs = __root.JPC_PhysicsSystem_GetBodyIDs;
    pub const JPC_PhysicsSystem_GetActiveBodyIDs = __root.JPC_PhysicsSystem_GetActiveBodyIDs;
    pub const JPC_PhysicsSystem_GetBodiesUnsafe = __root.JPC_PhysicsSystem_GetBodiesUnsafe;
    pub const Destroy = __root.JPC_PhysicsSystem_Destroy;
    pub const SetBodyActivationListener = __root.JPC_PhysicsSystem_SetBodyActivationListener;
    pub const GetBodyActivationListener = __root.JPC_PhysicsSystem_GetBodyActivationListener;
    pub const SetContactListener = __root.JPC_PhysicsSystem_SetContactListener;
    pub const GetContactListener = __root.JPC_PhysicsSystem_GetContactListener;
    pub const GetNumBodies = __root.JPC_PhysicsSystem_GetNumBodies;
    pub const GetNumActiveBodies = __root.JPC_PhysicsSystem_GetNumActiveBodies;
    pub const GetMaxBodies = __root.JPC_PhysicsSystem_GetMaxBodies;
    pub const GetGravity = __root.JPC_PhysicsSystem_GetGravity;
    pub const SetGravity = __root.JPC_PhysicsSystem_SetGravity;
    pub const GetBodyInterface = __root.JPC_PhysicsSystem_GetBodyInterface;
    pub const GetBodyInterfaceNoLock = __root.JPC_PhysicsSystem_GetBodyInterfaceNoLock;
    pub const OptimizeBroadPhase = __root.JPC_PhysicsSystem_OptimizeBroadPhase;
    pub const AddStepListener = __root.JPC_PhysicsSystem_AddStepListener;
    pub const RemoveStepListener = __root.JPC_PhysicsSystem_RemoveStepListener;
    pub const AddConstraint = __root.JPC_PhysicsSystem_AddConstraint;
    pub const RemoveConstraint = __root.JPC_PhysicsSystem_RemoveConstraint;
    pub const Update = __root.JPC_PhysicsSystem_Update;
    pub const GetBodyLockInterface = __root.JPC_PhysicsSystem_GetBodyLockInterface;
    pub const GetBodyLockInterfaceNoLock = __root.JPC_PhysicsSystem_GetBodyLockInterfaceNoLock;
    pub const GetNarrowPhaseQuery = __root.JPC_PhysicsSystem_GetNarrowPhaseQuery;
    pub const GetNarrowPhaseQueryNoLock = __root.JPC_PhysicsSystem_GetNarrowPhaseQueryNoLock;
    pub const GetBodyIDs = __root.JPC_PhysicsSystem_GetBodyIDs;
    pub const GetActiveBodyIDs = __root.JPC_PhysicsSystem_GetActiveBodyIDs;
    pub const GetBodiesUnsafe = __root.JPC_PhysicsSystem_GetBodiesUnsafe;
};
pub const JPC_PhysicsSystem = struct_JPC_PhysicsSystem;
pub const struct_JPC_SharedMutex = opaque {};
pub const JPC_SharedMutex = struct_JPC_SharedMutex;
pub const struct_JPC_Shape = opaque {
    pub const JPC_Shape_AddRef = __root.JPC_Shape_AddRef;
    pub const JPC_Shape_Release = __root.JPC_Shape_Release;
    pub const JPC_Shape_GetRefCount = __root.JPC_Shape_GetRefCount;
    pub const JPC_Shape_GetType = __root.JPC_Shape_GetType;
    pub const JPC_Shape_GetSubType = __root.JPC_Shape_GetSubType;
    pub const JPC_Shape_GetUserData = __root.JPC_Shape_GetUserData;
    pub const JPC_Shape_SetUserData = __root.JPC_Shape_SetUserData;
    pub const JPC_Shape_GetVolume = __root.JPC_Shape_GetVolume;
    pub const JPC_Shape_GetCenterOfMass = __root.JPC_Shape_GetCenterOfMass;
    pub const JPC_Shape_GetLocalBounds = __root.JPC_Shape_GetLocalBounds;
    pub const JPC_Shape_GetSurfaceNormal = __root.JPC_Shape_GetSurfaceNormal;
    pub const JPC_Shape_GetSupportingFace = __root.JPC_Shape_GetSupportingFace;
    pub const JPC_Shape_CastRay = __root.JPC_Shape_CastRay;
    pub const JPC_Shape_SaveBinaryState = __root.JPC_Shape_SaveBinaryState;
    pub const JPC_Shape_SaveWithChildren = __root.JPC_Shape_SaveWithChildren;
    pub const JPC_Shape_SaveWithChildren_All = __root.JPC_Shape_SaveWithChildren_All;
    pub const AddRef = __root.JPC_Shape_AddRef;
    pub const Release = __root.JPC_Shape_Release;
    pub const GetRefCount = __root.JPC_Shape_GetRefCount;
    pub const GetType = __root.JPC_Shape_GetType;
    pub const GetSubType = __root.JPC_Shape_GetSubType;
    pub const GetUserData = __root.JPC_Shape_GetUserData;
    pub const SetUserData = __root.JPC_Shape_SetUserData;
    pub const GetVolume = __root.JPC_Shape_GetVolume;
    pub const GetCenterOfMass = __root.JPC_Shape_GetCenterOfMass;
    pub const GetLocalBounds = __root.JPC_Shape_GetLocalBounds;
    pub const GetSurfaceNormal = __root.JPC_Shape_GetSurfaceNormal;
    pub const GetSupportingFace = __root.JPC_Shape_GetSupportingFace;
    pub const CastRay = __root.JPC_Shape_CastRay;
    pub const SaveBinaryState = __root.JPC_Shape_SaveBinaryState;
    pub const SaveWithChildren = __root.JPC_Shape_SaveWithChildren;
    pub const SaveWithChildren_All = __root.JPC_Shape_SaveWithChildren_All;
};
pub const JPC_Shape = struct_JPC_Shape;
pub const struct_JPC_BoxShape = opaque {
    pub const JPC_BoxShape_GetHalfExtent = __root.JPC_BoxShape_GetHalfExtent;
    pub const GetHalfExtent = __root.JPC_BoxShape_GetHalfExtent;
};
pub const JPC_BoxShape = struct_JPC_BoxShape;
pub const struct_JPC_ConvexHullShape = opaque {
    pub const JPC_ConvexHullShape_GetNumPoints = __root.JPC_ConvexHullShape_GetNumPoints;
    pub const JPC_ConvexHullShape_GetPoint = __root.JPC_ConvexHullShape_GetPoint;
    pub const JPC_ConvexHullShape_GetNumFaces = __root.JPC_ConvexHullShape_GetNumFaces;
    pub const JPC_ConvexHullShape_GetNumVerticesInFace = __root.JPC_ConvexHullShape_GetNumVerticesInFace;
    pub const JPC_ConvexHullShape_GetFaceVertices = __root.JPC_ConvexHullShape_GetFaceVertices;
    pub const GetNumPoints = __root.JPC_ConvexHullShape_GetNumPoints;
    pub const GetPoint = __root.JPC_ConvexHullShape_GetPoint;
    pub const GetNumFaces = __root.JPC_ConvexHullShape_GetNumFaces;
    pub const GetNumVerticesInFace = __root.JPC_ConvexHullShape_GetNumVerticesInFace;
    pub const GetFaceVertices = __root.JPC_ConvexHullShape_GetFaceVertices;
};
pub const JPC_ConvexHullShape = struct_JPC_ConvexHullShape;
pub const struct_JPC_DecoratedShape = opaque {
    pub const JPC_DecoratedShape_GetInnerShape = __root.JPC_DecoratedShape_GetInnerShape;
    pub const GetInnerShape = __root.JPC_DecoratedShape_GetInnerShape;
};
pub const JPC_DecoratedShape = struct_JPC_DecoratedShape;
pub const struct_JPC_RotatedTranslatedShape = opaque {
    pub const JPC_RotatedTranslatedShape_GetRotation = __root.JPC_RotatedTranslatedShape_GetRotation;
    pub const JPC_RotatedTranslatedShape_GetPosition = __root.JPC_RotatedTranslatedShape_GetPosition;
    pub const GetRotation = __root.JPC_RotatedTranslatedShape_GetRotation;
    pub const GetPosition = __root.JPC_RotatedTranslatedShape_GetPosition;
};
pub const JPC_RotatedTranslatedShape = struct_JPC_RotatedTranslatedShape;
pub const struct_JPC_ShapeToIDMap = opaque {
    pub const JPC_ShapeToIDMap_Add = __root.JPC_ShapeToIDMap_Add;
    pub const JPC_ShapeToIDMap_Destroy = __root.JPC_ShapeToIDMap_Destroy;
    pub const JPC_IDToShapeMap_Destroy = __root.JPC_IDToShapeMap_Destroy;
    pub const Add = __root.JPC_ShapeToIDMap_Add;
    pub const Destroy = __root.JPC_ShapeToIDMap_Destroy;
};
pub const JPC_ShapeToIDMap = struct_JPC_ShapeToIDMap;
pub const struct_JPC_MaterialToIDMap = opaque {
    pub const JPC_MaterialToIDMap_Add = __root.JPC_MaterialToIDMap_Add;
    pub const JPC_MaterialToIDMap_Destroy = __root.JPC_MaterialToIDMap_Destroy;
    pub const Add = __root.JPC_MaterialToIDMap_Add;
    pub const Destroy = __root.JPC_MaterialToIDMap_Destroy;
};
pub const JPC_MaterialToIDMap = struct_JPC_MaterialToIDMap;
pub const struct_JPC_IDToShapeMap = opaque {
    pub const JPC_IDToShapeMap_Add = __root.JPC_IDToShapeMap_Add;
    pub const Add = __root.JPC_IDToShapeMap_Add;
};
pub const JPC_IDToShapeMap = struct_JPC_IDToShapeMap;
pub const struct_JPC_IDToMaterialMap = opaque {
    pub const JPC_IDToMaterialMap_Add = __root.JPC_IDToMaterialMap_Add;
    pub const JPC_IDToMaterialMap_Destroy = __root.JPC_IDToMaterialMap_Destroy;
    pub const Add = __root.JPC_IDToMaterialMap_Add;
    pub const Destroy = __root.JPC_IDToMaterialMap_Destroy;
};
pub const JPC_IDToMaterialMap = struct_JPC_IDToMaterialMap;
pub const struct_JPC_Constraint = opaque {
    pub const JPC_Constraint_AddRef = __root.JPC_Constraint_AddRef;
    pub const JPC_Constraint_Release = __root.JPC_Constraint_Release;
    pub const JPC_Constraint_GetRefCount = __root.JPC_Constraint_GetRefCount;
    pub const JPC_Constraint_GetType = __root.JPC_Constraint_GetType;
    pub const JPC_Constraint_GetSubType = __root.JPC_Constraint_GetSubType;
    pub const JPC_Constraint_GetUserData = __root.JPC_Constraint_GetUserData;
    pub const JPC_Constraint_SetUserData = __root.JPC_Constraint_SetUserData;
    pub const AddRef = __root.JPC_Constraint_AddRef;
    pub const Release = __root.JPC_Constraint_Release;
    pub const GetRefCount = __root.JPC_Constraint_GetRefCount;
    pub const GetType = __root.JPC_Constraint_GetType;
    pub const GetSubType = __root.JPC_Constraint_GetSubType;
    pub const GetUserData = __root.JPC_Constraint_GetUserData;
    pub const SetUserData = __root.JPC_Constraint_SetUserData;
};
pub const JPC_Constraint = struct_JPC_Constraint;
pub const struct_JPC_PhysicsMaterial = opaque {};
pub const JPC_PhysicsMaterial = struct_JPC_PhysicsMaterial;
pub const struct_JPC_GroupFilter = opaque {};
pub const JPC_GroupFilter = struct_JPC_GroupFilter;
pub const struct_JPC_Character = opaque {
    pub const JPC_Character_Destroy = __root.JPC_Character_Destroy;
    pub const JPC_Character_AddToPhysicsSystem = __root.JPC_Character_AddToPhysicsSystem;
    pub const JPC_Character_RemoveFromPhysicsSystem = __root.JPC_Character_RemoveFromPhysicsSystem;
    pub const JPC_Character_GetPosition = __root.JPC_Character_GetPosition;
    pub const JPC_Character_SetPosition = __root.JPC_Character_SetPosition;
    pub const JPC_Character_GetLinearVelocity = __root.JPC_Character_GetLinearVelocity;
    pub const JPC_Character_SetLinearVelocity = __root.JPC_Character_SetLinearVelocity;
    pub const Destroy = __root.JPC_Character_Destroy;
    pub const AddToPhysicsSystem = __root.JPC_Character_AddToPhysicsSystem;
    pub const RemoveFromPhysicsSystem = __root.JPC_Character_RemoveFromPhysicsSystem;
    pub const GetPosition = __root.JPC_Character_GetPosition;
    pub const SetPosition = __root.JPC_Character_SetPosition;
    pub const GetLinearVelocity = __root.JPC_Character_GetLinearVelocity;
    pub const SetLinearVelocity = __root.JPC_Character_SetLinearVelocity;
};
pub const JPC_Character = struct_JPC_Character;
pub const struct_JPC_CharacterVirtual = opaque {
    pub const JPC_CharacterVirtual_Destroy = __root.JPC_CharacterVirtual_Destroy;
    pub const JPC_CharacterVirtual_Update = __root.JPC_CharacterVirtual_Update;
    pub const JPC_CharacterVirtual_ExtendedUpdate = __root.JPC_CharacterVirtual_ExtendedUpdate;
    pub const JPC_CharacterVirtual_SetListener = __root.JPC_CharacterVirtual_SetListener;
    pub const JPC_CharacterVirtual_UpdateGroundVelocity = __root.JPC_CharacterVirtual_UpdateGroundVelocity;
    pub const JPC_CharacterVirtual_GetGroundVelocity = __root.JPC_CharacterVirtual_GetGroundVelocity;
    pub const JPC_CharacterVirtual_GetGroundState = __root.JPC_CharacterVirtual_GetGroundState;
    pub const JPC_CharacterVirtual_GetPosition = __root.JPC_CharacterVirtual_GetPosition;
    pub const JPC_CharacterVirtual_SetPosition = __root.JPC_CharacterVirtual_SetPosition;
    pub const JPC_CharacterVirtual_GetRotation = __root.JPC_CharacterVirtual_GetRotation;
    pub const JPC_CharacterVirtual_SetRotation = __root.JPC_CharacterVirtual_SetRotation;
    pub const JPC_CharacterVirtual_GetLinearVelocity = __root.JPC_CharacterVirtual_GetLinearVelocity;
    pub const JPC_CharacterVirtual_SetLinearVelocity = __root.JPC_CharacterVirtual_SetLinearVelocity;
    pub const Destroy = __root.JPC_CharacterVirtual_Destroy;
    pub const Update = __root.JPC_CharacterVirtual_Update;
    pub const ExtendedUpdate = __root.JPC_CharacterVirtual_ExtendedUpdate;
    pub const SetListener = __root.JPC_CharacterVirtual_SetListener;
    pub const UpdateGroundVelocity = __root.JPC_CharacterVirtual_UpdateGroundVelocity;
    pub const GetGroundVelocity = __root.JPC_CharacterVirtual_GetGroundVelocity;
    pub const GetGroundState = __root.JPC_CharacterVirtual_GetGroundState;
    pub const GetPosition = __root.JPC_CharacterVirtual_GetPosition;
    pub const SetPosition = __root.JPC_CharacterVirtual_SetPosition;
    pub const GetRotation = __root.JPC_CharacterVirtual_GetRotation;
    pub const SetRotation = __root.JPC_CharacterVirtual_SetRotation;
    pub const GetLinearVelocity = __root.JPC_CharacterVirtual_GetLinearVelocity;
    pub const SetLinearVelocity = __root.JPC_CharacterVirtual_SetLinearVelocity;
};
pub const JPC_CharacterVirtual = struct_JPC_CharacterVirtual;
pub const struct_JPC_MassProperties = extern struct {
    mass: f32 align(16) = 0,
    inertia: [16]f32 align(16) = @import("std").mem.zeroes([16]f32),
};
pub const JPC_MassProperties = struct_JPC_MassProperties;
pub const struct_JPC_MotionProperties = extern struct {
    linear_velocity: [4]f32 align(16) = @import("std").mem.zeroes([4]f32),
    angular_velocity: [4]f32 = @import("std").mem.zeroes([4]f32),
    inv_inertia_diagonal: [4]f32 = @import("std").mem.zeroes([4]f32),
    inertia_rotation: [4]f32 = @import("std").mem.zeroes([4]f32),
    force: [3]f32 = @import("std").mem.zeroes([3]f32),
    torque: [3]f32 = @import("std").mem.zeroes([3]f32),
    inv_mass: f32 = 0,
    linear_damping: f32 = 0,
    angular_damping: f32 = 0,
    max_linear_velocity: f32 = 0,
    max_angular_velocity: f32 = 0,
    gravity_factor: f32 = 0,
    index_in_active_bodies: u32 = 0,
    island_index: u32 = 0,
    motion_quality: JPC_MotionQuality = 0,
    allow_sleeping: bool = false,
    allowed_DOFs: JPC_AllowedDOFs = 0,
    num_velocity_steps_override: u8 = 0,
    num_position_steps_override: u8 = 0,
    reserved: [53]u8 align(16) = @import("std").mem.zeroes([53]u8),
    cached_motion_type: JPC_MotionType = 0,
    pub const JPC_MotionProperties_GetMotionQuality = __root.JPC_MotionProperties_GetMotionQuality;
    pub const JPC_MotionProperties_GetLinearVelocity = __root.JPC_MotionProperties_GetLinearVelocity;
    pub const JPC_MotionProperties_SetLinearVelocity = __root.JPC_MotionProperties_SetLinearVelocity;
    pub const JPC_MotionProperties_SetLinearVelocityClamped = __root.JPC_MotionProperties_SetLinearVelocityClamped;
    pub const JPC_MotionProperties_GetAngularVelocity = __root.JPC_MotionProperties_GetAngularVelocity;
    pub const JPC_MotionProperties_SetAngularVelocity = __root.JPC_MotionProperties_SetAngularVelocity;
    pub const JPC_MotionProperties_SetAngularVelocityClamped = __root.JPC_MotionProperties_SetAngularVelocityClamped;
    pub const JPC_MotionProperties_MoveKinematic = __root.JPC_MotionProperties_MoveKinematic;
    pub const JPC_MotionProperties_ClampLinearVelocity = __root.JPC_MotionProperties_ClampLinearVelocity;
    pub const JPC_MotionProperties_ClampAngularVelocity = __root.JPC_MotionProperties_ClampAngularVelocity;
    pub const JPC_MotionProperties_GetLinearDamping = __root.JPC_MotionProperties_GetLinearDamping;
    pub const JPC_MotionProperties_SetLinearDamping = __root.JPC_MotionProperties_SetLinearDamping;
    pub const JPC_MotionProperties_GetAngularDamping = __root.JPC_MotionProperties_GetAngularDamping;
    pub const JPC_MotionProperties_SetAngularDamping = __root.JPC_MotionProperties_SetAngularDamping;
    pub const JPC_MotionProperties_GetGravityFactor = __root.JPC_MotionProperties_GetGravityFactor;
    pub const JPC_MotionProperties_SetGravityFactor = __root.JPC_MotionProperties_SetGravityFactor;
    pub const JPC_MotionProperties_SetMassProperties = __root.JPC_MotionProperties_SetMassProperties;
    pub const JPC_MotionProperties_GetInverseMass = __root.JPC_MotionProperties_GetInverseMass;
    pub const JPC_MotionProperties_SetInverseMass = __root.JPC_MotionProperties_SetInverseMass;
    pub const JPC_MotionProperties_GetInverseInertiaDiagonal = __root.JPC_MotionProperties_GetInverseInertiaDiagonal;
    pub const JPC_MotionProperties_GetInertiaRotation = __root.JPC_MotionProperties_GetInertiaRotation;
    pub const JPC_MotionProperties_SetInverseInertia = __root.JPC_MotionProperties_SetInverseInertia;
    pub const JPC_MotionProperties_GetLocalSpaceInverseInertia = __root.JPC_MotionProperties_GetLocalSpaceInverseInertia;
    pub const JPC_MotionProperties_GetInverseInertiaForRotation = __root.JPC_MotionProperties_GetInverseInertiaForRotation;
    pub const JPC_MotionProperties_MultiplyWorldSpaceInverseInertiaByVector = __root.JPC_MotionProperties_MultiplyWorldSpaceInverseInertiaByVector;
    pub const JPC_MotionProperties_GetPointVelocityCOM = __root.JPC_MotionProperties_GetPointVelocityCOM;
    pub const JPC_MotionProperties_GetMaxLinearVelocity = __root.JPC_MotionProperties_GetMaxLinearVelocity;
    pub const JPC_MotionProperties_SetMaxLinearVelocity = __root.JPC_MotionProperties_SetMaxLinearVelocity;
    pub const JPC_MotionProperties_GetMaxAngularVelocity = __root.JPC_MotionProperties_GetMaxAngularVelocity;
    pub const JPC_MotionProperties_SetMaxAngularVelocity = __root.JPC_MotionProperties_SetMaxAngularVelocity;
    pub const GetMotionQuality = __root.JPC_MotionProperties_GetMotionQuality;
    pub const GetLinearVelocity = __root.JPC_MotionProperties_GetLinearVelocity;
    pub const SetLinearVelocity = __root.JPC_MotionProperties_SetLinearVelocity;
    pub const SetLinearVelocityClamped = __root.JPC_MotionProperties_SetLinearVelocityClamped;
    pub const GetAngularVelocity = __root.JPC_MotionProperties_GetAngularVelocity;
    pub const SetAngularVelocity = __root.JPC_MotionProperties_SetAngularVelocity;
    pub const SetAngularVelocityClamped = __root.JPC_MotionProperties_SetAngularVelocityClamped;
    pub const MoveKinematic = __root.JPC_MotionProperties_MoveKinematic;
    pub const ClampLinearVelocity = __root.JPC_MotionProperties_ClampLinearVelocity;
    pub const ClampAngularVelocity = __root.JPC_MotionProperties_ClampAngularVelocity;
    pub const GetLinearDamping = __root.JPC_MotionProperties_GetLinearDamping;
    pub const SetLinearDamping = __root.JPC_MotionProperties_SetLinearDamping;
    pub const GetAngularDamping = __root.JPC_MotionProperties_GetAngularDamping;
    pub const SetAngularDamping = __root.JPC_MotionProperties_SetAngularDamping;
    pub const GetGravityFactor = __root.JPC_MotionProperties_GetGravityFactor;
    pub const SetGravityFactor = __root.JPC_MotionProperties_SetGravityFactor;
    pub const SetMassProperties = __root.JPC_MotionProperties_SetMassProperties;
    pub const GetInverseMass = __root.JPC_MotionProperties_GetInverseMass;
    pub const SetInverseMass = __root.JPC_MotionProperties_SetInverseMass;
    pub const GetInverseInertiaDiagonal = __root.JPC_MotionProperties_GetInverseInertiaDiagonal;
    pub const GetInertiaRotation = __root.JPC_MotionProperties_GetInertiaRotation;
    pub const SetInverseInertia = __root.JPC_MotionProperties_SetInverseInertia;
    pub const GetLocalSpaceInverseInertia = __root.JPC_MotionProperties_GetLocalSpaceInverseInertia;
    pub const GetInverseInertiaForRotation = __root.JPC_MotionProperties_GetInverseInertiaForRotation;
    pub const MultiplyWorldSpaceInverseInertiaByVector = __root.JPC_MotionProperties_MultiplyWorldSpaceInverseInertiaByVector;
    pub const GetPointVelocityCOM = __root.JPC_MotionProperties_GetPointVelocityCOM;
    pub const GetMaxLinearVelocity = __root.JPC_MotionProperties_GetMaxLinearVelocity;
    pub const SetMaxLinearVelocity = __root.JPC_MotionProperties_SetMaxLinearVelocity;
    pub const GetMaxAngularVelocity = __root.JPC_MotionProperties_GetMaxAngularVelocity;
    pub const SetMaxAngularVelocity = __root.JPC_MotionProperties_SetMaxAngularVelocity;
};
pub const JPC_MotionProperties = struct_JPC_MotionProperties;
pub const struct_JPC_CollisionGroup = extern struct {
    filter: ?*const JPC_GroupFilter = null,
    group_id: JPC_CollisionGroupID = 0,
    sub_group_id: JPC_CollisionSubGroupID = 0,
};
pub const JPC_CollisionGroup = struct_JPC_CollisionGroup;
pub const struct_JPC_BodyCreationSettings = extern struct {
    position: [4]JPC_Real = @import("std").mem.zeroes([4]JPC_Real),
    rotation: [4]f32 = @import("std").mem.zeroes([4]f32),
    linear_velocity: [4]f32 = @import("std").mem.zeroes([4]f32),
    angular_velocity: [4]f32 = @import("std").mem.zeroes([4]f32),
    user_data: u64 = 0,
    object_layer: JPC_ObjectLayer = 0,
    collision_group: JPC_CollisionGroup = @import("std").mem.zeroes(JPC_CollisionGroup),
    motion_type: JPC_MotionType = 0,
    allowed_DOFs: JPC_AllowedDOFs = 0,
    allow_dynamic_or_kinematic: bool = false,
    is_sensor: bool = false,
    collide_kinematic_vs_non_dynamic: bool = false,
    use_manifold_reduction: bool = false,
    apply_gyroscopic_force: bool = false,
    motion_quality: JPC_MotionQuality = 0,
    enhanced_internal_edge_removal: bool = false,
    allow_sleeping: bool = false,
    friction: f32 = 0,
    restitution: f32 = 0,
    linear_damping: f32 = 0,
    angular_damping: f32 = 0,
    max_linear_velocity: f32 = 0,
    max_angular_velocity: f32 = 0,
    gravity_factor: f32 = 0,
    num_velocity_steps_override: u32 = 0,
    num_position_steps_override: u32 = 0,
    override_mass_properties: JPC_OverrideMassProperties = 0,
    inertia_multiplier: f32 = 0,
    mass_properties_override: JPC_MassProperties = @import("std").mem.zeroes(JPC_MassProperties),
    reserved: ?*const anyopaque = null,
    shape: ?*const JPC_Shape = null,
    pub const JPC_BodyCreationSettings_SetDefault = __root.JPC_BodyCreationSettings_SetDefault;
    pub const JPC_BodyCreationSettings_Set = __root.JPC_BodyCreationSettings_Set;
    pub const SetDefault = __root.JPC_BodyCreationSettings_SetDefault;
    pub const Set = __root.JPC_BodyCreationSettings_Set;
};
pub const JPC_BodyCreationSettings = struct_JPC_BodyCreationSettings;
pub const struct_JPC_Body = extern struct {
    position: [4]JPC_Real align(16) = @import("std").mem.zeroes([4]JPC_Real),
    rotation: [4]f32 = @import("std").mem.zeroes([4]f32),
    bounds_min: [4]f32 = @import("std").mem.zeroes([4]f32),
    bounds_max: [4]f32 = @import("std").mem.zeroes([4]f32),
    shape: ?*const JPC_Shape = null,
    motion_properties: [*c]JPC_MotionProperties = null,
    user_data: u64 = 0,
    collision_group: JPC_CollisionGroup = @import("std").mem.zeroes(JPC_CollisionGroup),
    friction: f32 = 0,
    restitution: f32 = 0,
    id: JPC_BodyID = @import("std").mem.zeroes(JPC_BodyID),
    object_layer: JPC_ObjectLayer = 0,
    body_type: JPC_BodyType = 0,
    broad_phase_layer: JPC_BroadPhaseLayer = 0,
    motion_type: JPC_MotionType = 0,
    flags: u8 = 0,
    pub const JPC_Body_GetID = __root.JPC_Body_GetID;
    pub const JPC_Body_IsActive = __root.JPC_Body_IsActive;
    pub const JPC_Body_IsStatic = __root.JPC_Body_IsStatic;
    pub const JPC_Body_IsKinematic = __root.JPC_Body_IsKinematic;
    pub const JPC_Body_IsDynamic = __root.JPC_Body_IsDynamic;
    pub const JPC_Body_CanBeKinematicOrDynamic = __root.JPC_Body_CanBeKinematicOrDynamic;
    pub const JPC_Body_SetIsSensor = __root.JPC_Body_SetIsSensor;
    pub const JPC_Body_IsSensor = __root.JPC_Body_IsSensor;
    pub const JPC_Body_GetMotionType = __root.JPC_Body_GetMotionType;
    pub const JPC_Body_SetMotionType = __root.JPC_Body_SetMotionType;
    pub const JPC_Body_GetBroadPhaseLayer = __root.JPC_Body_GetBroadPhaseLayer;
    pub const JPC_Body_GetObjectLayer = __root.JPC_Body_GetObjectLayer;
    pub const JPC_Body_GetCollisionGroup = __root.JPC_Body_GetCollisionGroup;
    pub const JPC_Body_SetCollisionGroup = __root.JPC_Body_SetCollisionGroup;
    pub const JPC_Body_GetAllowSleeping = __root.JPC_Body_GetAllowSleeping;
    pub const JPC_Body_SetAllowSleeping = __root.JPC_Body_SetAllowSleeping;
    pub const JPC_Body_GetFriction = __root.JPC_Body_GetFriction;
    pub const JPC_Body_SetFriction = __root.JPC_Body_SetFriction;
    pub const JPC_Body_GetRestitution = __root.JPC_Body_GetRestitution;
    pub const JPC_Body_SetRestitution = __root.JPC_Body_SetRestitution;
    pub const JPC_Body_GetLinearVelocity = __root.JPC_Body_GetLinearVelocity;
    pub const JPC_Body_SetLinearVelocity = __root.JPC_Body_SetLinearVelocity;
    pub const JPC_Body_SetLinearVelocityClamped = __root.JPC_Body_SetLinearVelocityClamped;
    pub const JPC_Body_GetAngularVelocity = __root.JPC_Body_GetAngularVelocity;
    pub const JPC_Body_SetAngularVelocity = __root.JPC_Body_SetAngularVelocity;
    pub const JPC_Body_SetAngularVelocityClamped = __root.JPC_Body_SetAngularVelocityClamped;
    pub const JPC_Body_GetPointVelocityCOM = __root.JPC_Body_GetPointVelocityCOM;
    pub const JPC_Body_GetPointVelocity = __root.JPC_Body_GetPointVelocity;
    pub const JPC_Body_AddForce = __root.JPC_Body_AddForce;
    pub const JPC_Body_AddForceAtPosition = __root.JPC_Body_AddForceAtPosition;
    pub const JPC_Body_AddTorque = __root.JPC_Body_AddTorque;
    pub const JPC_Body_GetInverseInertia = __root.JPC_Body_GetInverseInertia;
    pub const JPC_Body_AddImpulse = __root.JPC_Body_AddImpulse;
    pub const JPC_Body_AddImpulseAtPosition = __root.JPC_Body_AddImpulseAtPosition;
    pub const JPC_Body_AddAngularImpulse = __root.JPC_Body_AddAngularImpulse;
    pub const JPC_Body_MoveKinematic = __root.JPC_Body_MoveKinematic;
    pub const JPC_Body_ApplyBuoyancyImpulse = __root.JPC_Body_ApplyBuoyancyImpulse;
    pub const JPC_Body_IsInBroadPhase = __root.JPC_Body_IsInBroadPhase;
    pub const JPC_Body_IsCollisionCacheInvalid = __root.JPC_Body_IsCollisionCacheInvalid;
    pub const JPC_Body_GetShape = __root.JPC_Body_GetShape;
    pub const JPC_Body_GetPosition = __root.JPC_Body_GetPosition;
    pub const JPC_Body_GetRotation = __root.JPC_Body_GetRotation;
    pub const JPC_Body_GetWorldTransform = __root.JPC_Body_GetWorldTransform;
    pub const JPC_Body_GetCenterOfMassPosition = __root.JPC_Body_GetCenterOfMassPosition;
    pub const JPC_Body_GetCenterOfMassTransform = __root.JPC_Body_GetCenterOfMassTransform;
    pub const JPC_Body_GetInverseCenterOfMassTransform = __root.JPC_Body_GetInverseCenterOfMassTransform;
    pub const JPC_Body_GetWorldSpaceBounds = __root.JPC_Body_GetWorldSpaceBounds;
    pub const JPC_Body_GetMotionProperties = __root.JPC_Body_GetMotionProperties;
    pub const JPC_Body_GetUserData = __root.JPC_Body_GetUserData;
    pub const JPC_Body_SetUserData = __root.JPC_Body_SetUserData;
    pub const JPC_Body_GetWorldSpaceSurfaceNormal = __root.JPC_Body_GetWorldSpaceSurfaceNormal;
    pub const GetID = __root.JPC_Body_GetID;
    pub const IsActive = __root.JPC_Body_IsActive;
    pub const IsStatic = __root.JPC_Body_IsStatic;
    pub const IsKinematic = __root.JPC_Body_IsKinematic;
    pub const IsDynamic = __root.JPC_Body_IsDynamic;
    pub const CanBeKinematicOrDynamic = __root.JPC_Body_CanBeKinematicOrDynamic;
    pub const SetIsSensor = __root.JPC_Body_SetIsSensor;
    pub const IsSensor = __root.JPC_Body_IsSensor;
    pub const GetMotionType = __root.JPC_Body_GetMotionType;
    pub const SetMotionType = __root.JPC_Body_SetMotionType;
    pub const GetBroadPhaseLayer = __root.JPC_Body_GetBroadPhaseLayer;
    pub const GetObjectLayer = __root.JPC_Body_GetObjectLayer;
    pub const GetCollisionGroup = __root.JPC_Body_GetCollisionGroup;
    pub const SetCollisionGroup = __root.JPC_Body_SetCollisionGroup;
    pub const GetAllowSleeping = __root.JPC_Body_GetAllowSleeping;
    pub const SetAllowSleeping = __root.JPC_Body_SetAllowSleeping;
    pub const GetFriction = __root.JPC_Body_GetFriction;
    pub const SetFriction = __root.JPC_Body_SetFriction;
    pub const GetRestitution = __root.JPC_Body_GetRestitution;
    pub const SetRestitution = __root.JPC_Body_SetRestitution;
    pub const GetLinearVelocity = __root.JPC_Body_GetLinearVelocity;
    pub const SetLinearVelocity = __root.JPC_Body_SetLinearVelocity;
    pub const SetLinearVelocityClamped = __root.JPC_Body_SetLinearVelocityClamped;
    pub const GetAngularVelocity = __root.JPC_Body_GetAngularVelocity;
    pub const SetAngularVelocity = __root.JPC_Body_SetAngularVelocity;
    pub const SetAngularVelocityClamped = __root.JPC_Body_SetAngularVelocityClamped;
    pub const GetPointVelocityCOM = __root.JPC_Body_GetPointVelocityCOM;
    pub const GetPointVelocity = __root.JPC_Body_GetPointVelocity;
    pub const AddForce = __root.JPC_Body_AddForce;
    pub const AddForceAtPosition = __root.JPC_Body_AddForceAtPosition;
    pub const AddTorque = __root.JPC_Body_AddTorque;
    pub const GetInverseInertia = __root.JPC_Body_GetInverseInertia;
    pub const AddImpulse = __root.JPC_Body_AddImpulse;
    pub const AddImpulseAtPosition = __root.JPC_Body_AddImpulseAtPosition;
    pub const AddAngularImpulse = __root.JPC_Body_AddAngularImpulse;
    pub const MoveKinematic = __root.JPC_Body_MoveKinematic;
    pub const ApplyBuoyancyImpulse = __root.JPC_Body_ApplyBuoyancyImpulse;
    pub const IsInBroadPhase = __root.JPC_Body_IsInBroadPhase;
    pub const IsCollisionCacheInvalid = __root.JPC_Body_IsCollisionCacheInvalid;
    pub const GetShape = __root.JPC_Body_GetShape;
    pub const GetPosition = __root.JPC_Body_GetPosition;
    pub const GetRotation = __root.JPC_Body_GetRotation;
    pub const GetWorldTransform = __root.JPC_Body_GetWorldTransform;
    pub const GetCenterOfMassPosition = __root.JPC_Body_GetCenterOfMassPosition;
    pub const GetCenterOfMassTransform = __root.JPC_Body_GetCenterOfMassTransform;
    pub const GetInverseCenterOfMassTransform = __root.JPC_Body_GetInverseCenterOfMassTransform;
    pub const GetWorldSpaceBounds = __root.JPC_Body_GetWorldSpaceBounds;
    pub const GetMotionProperties = __root.JPC_Body_GetMotionProperties;
    pub const GetUserData = __root.JPC_Body_GetUserData;
    pub const SetUserData = __root.JPC_Body_SetUserData;
    pub const GetWorldSpaceSurfaceNormal = __root.JPC_Body_GetWorldSpaceSurfaceNormal;
};
pub const JPC_Body = struct_JPC_Body;
const struct_unnamed_13 = extern struct {
    __vfptr_header: [1]?*const anyopaque = @import("std").mem.zeroes([1]?*const anyopaque),
    ref_count: u32 = 0,
};
pub const struct_JPC_CharacterBaseSettings = extern struct {
    unnamed_0: struct_unnamed_13 align(16) = @import("std").mem.zeroes(struct_unnamed_13),
    up: [4]f32 = @import("std").mem.zeroes([4]f32),
    supporting_volume: [4]f32 = @import("std").mem.zeroes([4]f32),
    max_slope_angle: f32 = 0,
    enhanced_internal_edge_removal: bool = false,
    shape: ?*const JPC_Shape = null,
};
pub const JPC_CharacterBaseSettings = struct_JPC_CharacterBaseSettings;
pub const struct_JPC_CharacterSettings = extern struct {
    base: JPC_CharacterBaseSettings = @import("std").mem.zeroes(JPC_CharacterBaseSettings),
    layer: JPC_ObjectLayer = 0,
    mass: f32 = 0,
    friction: f32 = 0,
    gravity_factor: f32 = 0,
    allowed_dofs: JPC_AllowedDOFs = 0,
    pub const JPC_CharacterSettings_Release = __root.JPC_CharacterSettings_Release;
    pub const JPC_CharacterSettings_AddRef = __root.JPC_CharacterSettings_AddRef;
    pub const JPC_Character_Create = __root.JPC_Character_Create;
    pub const Release = __root.JPC_CharacterSettings_Release;
    pub const AddRef = __root.JPC_CharacterSettings_AddRef;
    pub const Create = __root.JPC_Character_Create;
};
pub const JPC_CharacterSettings = struct_JPC_CharacterSettings;
pub const struct_JPC_CharacterVirtualSettings = extern struct {
    base: JPC_CharacterBaseSettings = @import("std").mem.zeroes(JPC_CharacterBaseSettings),
    mass: f32 = 0,
    max_strength: f32 = 0,
    shape_offset: [4]f32 align(16) = @import("std").mem.zeroes([4]f32),
    back_face_mode: JPC_BackFaceMode = 0,
    predictive_contact_distance: f32 = 0,
    max_collision_iterations: u32 = 0,
    max_constraint_iterations: u32 = 0,
    min_time_remaining: f32 = 0,
    collision_tolerance: f32 = 0,
    character_padding: f32 = 0,
    max_num_hits: u32 = 0,
    hit_reduction_cos_max_angle: f32 = 0,
    penetration_recovery_speed: f32 = 0,
    inner_body_shape: ?*const JPC_Shape = null,
    inner_body_layer: JPC_ObjectLayer = 0,
    pub const JPC_CharacterVirtualSettings_Release = __root.JPC_CharacterVirtualSettings_Release;
    pub const JPC_CharacterVirtual_Create = __root.JPC_CharacterVirtual_Create;
    pub const Release = __root.JPC_CharacterVirtualSettings_Release;
    pub const Create = __root.JPC_CharacterVirtual_Create;
};
pub const JPC_CharacterVirtualSettings = struct_JPC_CharacterVirtualSettings;
pub const struct_JPC_SubShapeIDCreator = extern struct {
    id: JPC_SubShapeID = @import("std").mem.zeroes(JPC_SubShapeID),
    current_bit: u32 = 0,
};
pub const JPC_SubShapeIDCreator = struct_JPC_SubShapeIDCreator;
const struct_unnamed_14 = extern struct {
    body_id: JPC_BodyID = @import("std").mem.zeroes(JPC_BodyID),
    sub_shape_id: JPC_SubShapeID = @import("std").mem.zeroes(JPC_SubShapeID),
};
const struct_unnamed_15 = extern struct {
    body_id: JPC_BodyID = @import("std").mem.zeroes(JPC_BodyID),
    sub_shape_id: JPC_SubShapeID = @import("std").mem.zeroes(JPC_SubShapeID),
};
pub const struct_JPC_SubShapeIDPair = extern struct {
    first: struct_unnamed_14 = @import("std").mem.zeroes(struct_unnamed_14),
    second: struct_unnamed_15 = @import("std").mem.zeroes(struct_unnamed_15),
};
pub const JPC_SubShapeIDPair = struct_JPC_SubShapeIDPair;
const struct_unnamed_16 = extern struct {
    num_points: u32 align(16) = 0,
    points: [64][4]f32 align(16) = @import("std").mem.zeroes([64][4]f32),
};
const struct_unnamed_17 = extern struct {
    num_points: u32 align(16) = 0,
    points: [64][4]f32 align(16) = @import("std").mem.zeroes([64][4]f32),
};
pub const struct_JPC_ContactManifold = extern struct {
    base_offset: [4]JPC_Real = @import("std").mem.zeroes([4]JPC_Real),
    normal: [4]f32 = @import("std").mem.zeroes([4]f32),
    penetration_depth: f32 = 0,
    shape1_sub_shape_id: JPC_SubShapeID = @import("std").mem.zeroes(JPC_SubShapeID),
    shape2_sub_shape_id: JPC_SubShapeID = @import("std").mem.zeroes(JPC_SubShapeID),
    shape1_relative_contact: struct_unnamed_16 = @import("std").mem.zeroes(struct_unnamed_16),
    shape2_relative_contact: struct_unnamed_17 = @import("std").mem.zeroes(struct_unnamed_17),
};
pub const JPC_ContactManifold = struct_JPC_ContactManifold;
pub const struct_JPC_ContactSettings = extern struct {
    combined_friction: f32 align(16) = 0,
    combined_restitution: f32 = 0,
    inv_mass_scale_1: f32 = 0,
    inv_inertia_scale_1: f32 = 0,
    inv_mass_scale_2: f32 = 0,
    inv_inertia_scale_2: f32 = 0,
    is_sensor: bool = false,
    relative_linear_surface_velocity: [4]f32 align(16) = @import("std").mem.zeroes([4]f32),
    relative_angular_surface_velocity: [4]f32 = @import("std").mem.zeroes([4]f32),
};
pub const JPC_ContactSettings = struct_JPC_ContactSettings;
const struct_unnamed_18 = extern struct {
    num_points: u32 align(16) = 0,
    points: [32][4]f32 align(16) = @import("std").mem.zeroes([32][4]f32),
};
const struct_unnamed_19 = extern struct {
    num_points: u32 align(16) = 0,
    points: [32][4]f32 align(16) = @import("std").mem.zeroes([32][4]f32),
};
pub const struct_JPC_CollideShapeResult = extern struct {
    shape1_contact_point: [4]f32 = @import("std").mem.zeroes([4]f32),
    shape2_contact_point: [4]f32 = @import("std").mem.zeroes([4]f32),
    penetration_axis: [4]f32 = @import("std").mem.zeroes([4]f32),
    penetration_depth: f32 = 0,
    shape1_sub_shape_id: JPC_SubShapeID = @import("std").mem.zeroes(JPC_SubShapeID),
    shape2_sub_shape_id: JPC_SubShapeID = @import("std").mem.zeroes(JPC_SubShapeID),
    body2_id: JPC_BodyID = @import("std").mem.zeroes(JPC_BodyID),
    shape1_face: struct_unnamed_18 = @import("std").mem.zeroes(struct_unnamed_18),
    shape2_face: struct_unnamed_19 = @import("std").mem.zeroes(struct_unnamed_19),
};
pub const JPC_CollideShapeResult = struct_JPC_CollideShapeResult;
pub const struct_JPC_TransformedShape = extern struct {
    shape_position_com: [4]JPC_Real align(16) = @import("std").mem.zeroes([4]JPC_Real),
    shape_rotation: [4]f32 = @import("std").mem.zeroes([4]f32),
    shape: ?*const JPC_Shape = null,
    shape_scale: [3]f32 = @import("std").mem.zeroes([3]f32),
    body_id: JPC_BodyID = @import("std").mem.zeroes(JPC_BodyID),
    sub_shape_id_creator: JPC_SubShapeIDCreator = @import("std").mem.zeroes(JPC_SubShapeIDCreator),
};
pub const JPC_TransformedShape = struct_JPC_TransformedShape;
pub const struct_JPC_BodyLockRead = extern struct {
    lock_interface: ?*const JPC_BodyLockInterface = null,
    mutex: ?*JPC_SharedMutex = null,
    body: [*c]const JPC_Body = null,
};
pub const JPC_BodyLockRead = struct_JPC_BodyLockRead;
pub const struct_JPC_BodyLockWrite = extern struct {
    lock_interface: ?*const JPC_BodyLockInterface = null,
    mutex: ?*JPC_SharedMutex = null,
    body: [*c]JPC_Body = null,
};
pub const JPC_BodyLockWrite = struct_JPC_BodyLockWrite;
pub const struct_JPC_RayCast = extern struct {
    origin: [4]f32 align(16) = @import("std").mem.zeroes([4]f32),
    direction: [4]f32 = @import("std").mem.zeroes([4]f32),
};
pub const JPC_RayCast = struct_JPC_RayCast;
pub const struct_JPC_RRayCast = extern struct {
    origin: [4]JPC_Real align(16) = @import("std").mem.zeroes([4]JPC_Real),
    direction: [4]f32 = @import("std").mem.zeroes([4]f32),
};
pub const JPC_RRayCast = struct_JPC_RRayCast;
pub const struct_JPC_RayCastResult = extern struct {
    body_id: JPC_BodyID = @import("std").mem.zeroes(JPC_BodyID),
    fraction: f32 = 0,
    sub_shape_id: JPC_SubShapeID = @import("std").mem.zeroes(JPC_SubShapeID),
};
pub const JPC_RayCastResult = struct_JPC_RayCastResult;
pub const struct_JPC_RayCastSettings = extern struct {
    back_face_mode_triangles: JPC_BackFaceMode = 0,
    back_face_mode_convex: JPC_BackFaceMode = 0,
    treat_convex_as_solid: bool = false,
};
pub const JPC_RayCastSettings = struct_JPC_RayCastSettings;
pub const struct_JPC_AABox = extern struct {
    min: [3]f32 align(16) = @import("std").mem.zeroes([3]f32),
    max: [3]f32 align(16) = @import("std").mem.zeroes([3]f32),
};
pub const JPC_AABox = struct_JPC_AABox;
pub const struct_JPC_RMatrix = extern struct {
    column_0: [4]f32 align(16) = @import("std").mem.zeroes([4]f32),
    column_1: [4]f32 = @import("std").mem.zeroes([4]f32),
    column_2: [4]f32 = @import("std").mem.zeroes([4]f32),
    column_3: [4]JPC_Real = @import("std").mem.zeroes([4]JPC_Real),
};
pub const JPC_RMatrix = struct_JPC_RMatrix;
pub const struct_JPC_Shape_SupportingFace = extern struct {
    num_points: u32 align(16) = 0,
    points: [32][4]f32 align(16) = @import("std").mem.zeroes([32][4]f32),
};
pub const JPC_Shape_SupportingFace = struct_JPC_Shape_SupportingFace;
pub const struct_JPC_CharacterVirtual_ExtendedUpdateSettings = extern struct {
    stick_to_floor_step_down: [4]f32 align(16) = @import("std").mem.zeroes([4]f32),
    walk_stairs_step_up: [4]f32 = @import("std").mem.zeroes([4]f32),
    walk_stairs_min_step_forward: f32 = 0,
    walk_stairs_step_forward_test: f32 = 0,
    walk_stairs_cos_angle_forward_contact: f32 = 0,
    walk_stairs_step_down_extra: [4]f32 align(16) = @import("std").mem.zeroes([4]f32),
};
pub const JPC_CharacterVirtual_ExtendedUpdateSettings = struct_JPC_CharacterVirtual_ExtendedUpdateSettings;
pub const struct_JPC_StreamOutVTable = extern struct {
    __vtable_header: [2]?*const anyopaque = @import("std").mem.zeroes([2]?*const anyopaque),
    WriteBytes: ?*const fn (in_self: ?*anyopaque, in_data: ?*const anyopaque, in_num_bytes: usize) callconv(.c) void = null,
    IsFailed: ?*const fn (in_self: ?*const anyopaque) callconv(.c) bool = null,
};
pub const JPC_StreamOutVTable = struct_JPC_StreamOutVTable;
pub const struct_JPC_StreamInVTable = extern struct {
    __vtable_header: [2]?*const anyopaque = @import("std").mem.zeroes([2]?*const anyopaque),
    ReadBytes: ?*const fn (in_self: ?*anyopaque, out_data: ?*anyopaque, in_num_bytes: usize) callconv(.c) void = null,
    IsEOF: ?*const fn (in_self: ?*const anyopaque) callconv(.c) bool = null,
    IsFailed: ?*const fn (in_self: ?*const anyopaque) callconv(.c) bool = null,
};
pub const JPC_StreamInVTable = struct_JPC_StreamInVTable;
pub const struct_JPC_BroadPhaseLayerInterfaceVTable = extern struct {
    __vtable_header: [2]?*const anyopaque = @import("std").mem.zeroes([2]?*const anyopaque),
    GetNumBroadPhaseLayers: ?*const fn (in_self: ?*const anyopaque) callconv(.c) u32 = null,
    GetBroadPhaseLayer: ?*const fn (in_self: ?*const anyopaque, in_layer: JPC_ObjectLayer) callconv(.c) JPC_BroadPhaseLayer = null,
};
pub const JPC_BroadPhaseLayerInterfaceVTable = struct_JPC_BroadPhaseLayerInterfaceVTable;
pub const struct_JPC_ObjectVsBroadPhaseLayerFilterVTable = extern struct {
    __vtable_header: [2]?*const anyopaque = @import("std").mem.zeroes([2]?*const anyopaque),
    ShouldCollide: ?*const fn (in_self: ?*const anyopaque, in_layer1: JPC_ObjectLayer, in_layer2: JPC_BroadPhaseLayer) callconv(.c) bool = null,
};
pub const JPC_ObjectVsBroadPhaseLayerFilterVTable = struct_JPC_ObjectVsBroadPhaseLayerFilterVTable;
pub const struct_JPC_BroadPhaseLayerFilterVTable = extern struct {
    __vtable_header: [2]?*const anyopaque = @import("std").mem.zeroes([2]?*const anyopaque),
    ShouldCollide: ?*const fn (in_self: ?*const anyopaque, in_layer: JPC_BroadPhaseLayer) callconv(.c) bool = null,
};
pub const JPC_BroadPhaseLayerFilterVTable = struct_JPC_BroadPhaseLayerFilterVTable;
pub const struct_JPC_ObjectLayerPairFilterVTable = extern struct {
    __vtable_header: [2]?*const anyopaque = @import("std").mem.zeroes([2]?*const anyopaque),
    ShouldCollide: ?*const fn (in_self: ?*const anyopaque, in_layer1: JPC_ObjectLayer, in_layer2: JPC_ObjectLayer) callconv(.c) bool = null,
};
pub const JPC_ObjectLayerPairFilterVTable = struct_JPC_ObjectLayerPairFilterVTable;
pub const struct_JPC_ObjectLayerFilterVTable = extern struct {
    __vtable_header: [2]?*const anyopaque = @import("std").mem.zeroes([2]?*const anyopaque),
    ShouldCollide: ?*const fn (in_self: ?*const anyopaque, in_layer: JPC_ObjectLayer) callconv(.c) bool = null,
};
pub const JPC_ObjectLayerFilterVTable = struct_JPC_ObjectLayerFilterVTable;
pub const struct_JPC_BodyActivationListenerVTable = extern struct {
    __vtable_header: [2]?*const anyopaque = @import("std").mem.zeroes([2]?*const anyopaque),
    OnBodyActivated: ?*const fn (in_self: ?*anyopaque, in_body_id: [*c]const JPC_BodyID, in_user_data: u64) callconv(.c) void = null,
    OnBodyDeactivated: ?*const fn (in_self: ?*anyopaque, in_body_id: [*c]const JPC_BodyID, in_user_data: u64) callconv(.c) void = null,
};
pub const JPC_BodyActivationListenerVTable = struct_JPC_BodyActivationListenerVTable;
pub const struct_JPC_BodyFilterVTable = extern struct {
    __vtable_header: [2]?*const anyopaque = @import("std").mem.zeroes([2]?*const anyopaque),
    ShouldCollide: ?*const fn (in_self: ?*const anyopaque, in_body_id: [*c]const JPC_BodyID) callconv(.c) bool = null,
    ShouldCollideLocked: ?*const fn (in_self: ?*const anyopaque, in_body: [*c]const JPC_Body) callconv(.c) bool = null,
};
pub const JPC_BodyFilterVTable = struct_JPC_BodyFilterVTable;
pub const struct_JPC_ShapeFilterVTable = extern struct {
    __vtable_header: [2]?*const anyopaque = @import("std").mem.zeroes([2]?*const anyopaque),
    ShouldCollide: ?*const fn (in_self: ?*const anyopaque, in_shape: ?*const JPC_Shape, in_sub_shape_id: [*c]const JPC_SubShapeID) callconv(.c) bool = null,
    PairShouldCollide: ?*const fn (in_self: ?*const anyopaque, in_shape1: ?*const JPC_Shape, in_sub_shape_id1: [*c]const JPC_SubShapeID, in_shape2: ?*const JPC_Shape, in_sub_shape_id2: [*c]const JPC_SubShapeID) callconv(.c) bool = null,
    bodyId2: u32 = 0,
};
pub const JPC_ShapeFilterVTable = struct_JPC_ShapeFilterVTable;
pub const struct_JPC_PhysicsStepListenerContext = extern struct {
    delta_time: f32 = 0,
    is_first_step: bool = false,
    is_last_step: bool = false,
    physics_system: ?*JPC_PhysicsSystem = null,
};
pub const JPC_PhysicsStepListenerContext = struct_JPC_PhysicsStepListenerContext;
pub const struct_JPC_PhysicsStepListenerVTable = extern struct {
    __vtable_header: [2]?*const anyopaque = @import("std").mem.zeroes([2]?*const anyopaque),
    OnStep: ?*const fn ([*c]JPC_PhysicsStepListenerContext) callconv(.c) void = null,
};
pub const JPC_PhysicsStepListener = struct_JPC_PhysicsStepListenerVTable;
pub const struct_JPC_CharacterContactListenerVTable = extern struct {
    __vtable_header: [2]?*const anyopaque = @import("std").mem.zeroes([2]?*const anyopaque),
    OnAdjustBodyVelocity: ?*const fn (in_self: ?*anyopaque, in_character: ?*const JPC_CharacterVirtual, in_body2: [*c]const JPC_Body, io_linear_velocity: [*c]const f32, io_angular_velocity: [*c]const f32) callconv(.c) void = null,
    OnContactValidate: ?*const fn (in_self: ?*anyopaque, in_character: ?*const JPC_CharacterVirtual, in_body2: [*c]const JPC_Body, sub_shape_id: [*c]const JPC_SubShapeID) callconv(.c) bool = null,
    OnCharacterContactValidate: ?*const fn (in_self: ?*anyopaque, in_character: ?*const JPC_CharacterVirtual, in_other_character: ?*const JPC_CharacterVirtual, sub_shape_id: [*c]const JPC_SubShapeID) callconv(.c) bool = null,
    OnContactAdded: ?*const fn (in_self: ?*anyopaque, in_character: ?*const JPC_CharacterVirtual, in_body2: [*c]const JPC_Body, sub_shape_id: [*c]const JPC_SubShapeID, contact_position: [*c]const JPC_Real, contact_normal: [*c]const f32, io_settings: ?*JPC_CharacterContactSettings) callconv(.c) void = null,
    OnContactPersisted: ?*const fn (in_self: ?*anyopaque, in_character: ?*const JPC_CharacterVirtual, in_body2: [*c]const JPC_Body, sub_shape_id: [*c]const JPC_SubShapeID, contact_position: [*c]const JPC_Real, contact_normal: [*c]const f32, io_settings: ?*JPC_CharacterContactSettings) callconv(.c) void = null,
    OnContactRemoved: ?*const fn (in_self: ?*anyopaque, in_character: ?*const JPC_CharacterVirtual, in_body2: [*c]const JPC_Body, sub_shape_id: [*c]const JPC_SubShapeID) callconv(.c) void = null,
    OnCharacterContactAdded: ?*const fn (in_self: ?*anyopaque, in_character: ?*const JPC_CharacterVirtual, in_other_character: ?*const JPC_CharacterVirtual, sub_shape_id: [*c]const JPC_SubShapeID, contact_position: [*c]const JPC_Real, contact_normal: [*c]const f32, io_settings: ?*JPC_CharacterContactSettings) callconv(.c) void = null,
    OnCharacterContactPersisted: ?*const fn (in_self: ?*anyopaque, in_character: ?*const JPC_CharacterVirtual, in_other_character: ?*const JPC_CharacterVirtual, sub_shape_id: [*c]const JPC_SubShapeID, contact_position: [*c]const JPC_Real, contact_normal: [*c]const f32, io_settings: ?*JPC_CharacterContactSettings) callconv(.c) void = null,
    OnCharacterContactRemoved: ?*const fn (in_self: ?*anyopaque, in_character: ?*const JPC_CharacterVirtual, in_other_character: ?*const JPC_CharacterVirtual, sub_shape_id: [*c]const JPC_SubShapeID) callconv(.c) void = null,
    OnContactSolve: ?*const fn (in_self: ?*anyopaque, in_character: ?*const JPC_CharacterVirtual, in_body2: [*c]const JPC_Body, sub_shape_id: [*c]const JPC_SubShapeID, contact_position: [*c]const JPC_Real, contact_normal: [*c]const f32, contact_velocity: [*c]const f32, contact_material: ?*const JPC_PhysicsMaterial, character_velocity_in: [*c]const f32, character_velocity_out: [*c]f32) callconv(.c) void = null,
    OnCharacterContactSolve: ?*const fn (in_self: ?*anyopaque, in_character: ?*const JPC_CharacterVirtual, in_other_character: ?*const JPC_CharacterVirtual, sub_shape_id: [*c]const JPC_SubShapeID, contact_position: [*c]const JPC_Real, contact_normal: [*c]const f32, contact_velocity: [*c]const f32, contact_material: ?*const JPC_PhysicsMaterial, character_velocity_in: [*c]const f32, character_velocity_out: [*c]f32) callconv(.c) void = null,
};
pub const JPC_CharacterContactListenerVTable = struct_JPC_CharacterContactListenerVTable;
pub const struct_JPC_ContactListenerVTable = extern struct {
    OnContactValidate: ?*const fn (in_self: ?*anyopaque, in_body1: [*c]const JPC_Body, in_body2: [*c]const JPC_Body, in_base_offset: [*c]const JPC_Real, in_collision_result: [*c]const JPC_CollideShapeResult) callconv(.c) JPC_ValidateResult = null,
    OnContactAdded: ?*const fn (in_self: ?*anyopaque, in_body1: [*c]const JPC_Body, in_body2: [*c]const JPC_Body, in_manifold: [*c]const JPC_ContactManifold, io_settings: [*c]JPC_ContactSettings) callconv(.c) void = null,
    OnContactPersisted: ?*const fn (in_self: ?*anyopaque, in_body1: [*c]const JPC_Body, in_body2: [*c]const JPC_Body, in_manifold: [*c]const JPC_ContactManifold, io_settings: [*c]JPC_ContactSettings) callconv(.c) void = null,
    OnContactRemoved: ?*const fn (in_self: ?*anyopaque, in_sub_shape_pair: [*c]const JPC_SubShapeIDPair) callconv(.c) void = null,
};
pub const JPC_ContactListenerVTable = struct_JPC_ContactListenerVTable;
pub extern fn JPC_RegisterDefaultAllocator() void;
pub extern fn JPC_RegisterCustomAllocator(in_alloc: JPC_AllocateFunction, in_realloc: JPC_ReallocateFunction, in_free: JPC_FreeFunction, in_aligned_alloc: JPC_AlignedAllocateFunction, in_aligned_free: JPC_AlignedFreeFunction) void;
pub extern fn JPC_RegisterTrace(in_trace: JPC_TraceFunction) void;
pub extern fn JPC_RegisterAssertFailed(in_assert_failed: JPC_AssertFailedFunction) void;
pub extern fn JPC_CreateFactory() void;
pub extern fn JPC_DestroyFactory() void;
pub extern fn JPC_RegisterTypes() void;
pub extern fn JPC_BodyCreationSettings_SetDefault(out_settings: [*c]JPC_BodyCreationSettings) void;
pub extern fn JPC_BodyCreationSettings_Set(out_settings: [*c]JPC_BodyCreationSettings, in_shape: ?*const JPC_Shape, in_position: [*c]const JPC_Real, in_rotation: [*c]const f32, in_motion_type: JPC_MotionType, in_layer: JPC_ObjectLayer) void;
pub extern fn JPC_MotionProperties_GetMotionQuality(in_properties: [*c]const JPC_MotionProperties) JPC_MotionQuality;
pub extern fn JPC_MotionProperties_GetLinearVelocity(in_properties: [*c]const JPC_MotionProperties, out_linear_velocity: [*c]f32) void;
pub extern fn JPC_MotionProperties_SetLinearVelocity(in_properties: [*c]JPC_MotionProperties, in_linear_velocity: [*c]const f32) void;
pub extern fn JPC_MotionProperties_SetLinearVelocityClamped(in_properties: [*c]JPC_MotionProperties, in_linear_velocity: [*c]const f32) void;
pub extern fn JPC_MotionProperties_GetAngularVelocity(in_properties: [*c]const JPC_MotionProperties, out_angular_velocity: [*c]f32) void;
pub extern fn JPC_MotionProperties_SetAngularVelocity(in_properties: [*c]JPC_MotionProperties, in_angular_velocity: [*c]const f32) void;
pub extern fn JPC_MotionProperties_SetAngularVelocityClamped(in_properties: [*c]JPC_MotionProperties, in_angular_velocity: [*c]const f32) void;
pub extern fn JPC_MotionProperties_MoveKinematic(in_properties: [*c]JPC_MotionProperties, in_delta_position: [*c]const f32, in_delta_rotation: [*c]const f32, in_delta_time: f32) void;
pub extern fn JPC_MotionProperties_ClampLinearVelocity(in_properties: [*c]JPC_MotionProperties) void;
pub extern fn JPC_MotionProperties_ClampAngularVelocity(in_properties: [*c]JPC_MotionProperties) void;
pub extern fn JPC_MotionProperties_GetLinearDamping(in_properties: [*c]const JPC_MotionProperties) f32;
pub extern fn JPC_MotionProperties_SetLinearDamping(in_properties: [*c]JPC_MotionProperties, in_linear_damping: f32) void;
pub extern fn JPC_MotionProperties_GetAngularDamping(in_properties: [*c]const JPC_MotionProperties) f32;
pub extern fn JPC_MotionProperties_SetAngularDamping(in_properties: [*c]JPC_MotionProperties, in_angular_damping: f32) void;
pub extern fn JPC_MotionProperties_GetGravityFactor(in_properties: [*c]const JPC_MotionProperties) f32;
pub extern fn JPC_MotionProperties_SetGravityFactor(in_properties: [*c]JPC_MotionProperties, in_gravity_factor: f32) void;
pub extern fn JPC_MotionProperties_SetMassProperties(in_properties: [*c]JPC_MotionProperties, in_allowed_DOFs: JPC_AllowedDOFs, in_mass_properties: [*c]const JPC_MassProperties) void;
pub extern fn JPC_MotionProperties_GetInverseMass(in_properties: [*c]const JPC_MotionProperties) f32;
pub extern fn JPC_MotionProperties_SetInverseMass(in_properties: [*c]JPC_MotionProperties, in_inv_mass: f32) void;
pub extern fn JPC_MotionProperties_GetInverseInertiaDiagonal(in_properties: [*c]const JPC_MotionProperties, out_inverse_inertia_diagonal: [*c]f32) void;
pub extern fn JPC_MotionProperties_GetInertiaRotation(in_properties: [*c]const JPC_MotionProperties, out_inertia_rotation: [*c]f32) void;
pub extern fn JPC_MotionProperties_SetInverseInertia(in_properties: [*c]JPC_MotionProperties, in_diagonal: [*c]const f32, in_rotation: [*c]const f32) void;
pub extern fn JPC_MotionProperties_GetLocalSpaceInverseInertia(in_properties: [*c]const JPC_MotionProperties, out_matrix: [*c]f32) void;
pub extern fn JPC_MotionProperties_GetInverseInertiaForRotation(in_properties: [*c]const JPC_MotionProperties, in_rotation_matrix: [*c]const f32, out_matrix: [*c]f32) void;
pub extern fn JPC_MotionProperties_MultiplyWorldSpaceInverseInertiaByVector(in_properties: [*c]const JPC_MotionProperties, in_body_rotation: [*c]const f32, in_vector: [*c]const f32, out_vector: [*c]f32) void;
pub extern fn JPC_MotionProperties_GetPointVelocityCOM(in_properties: [*c]const JPC_MotionProperties, in_point_relative_to_com: [*c]const f32, out_point: [*c]f32) void;
pub extern fn JPC_MotionProperties_GetMaxLinearVelocity(in_properties: [*c]const JPC_MotionProperties) f32;
pub extern fn JPC_MotionProperties_SetMaxLinearVelocity(in_properties: [*c]JPC_MotionProperties, in_max_linear_velocity: f32) void;
pub extern fn JPC_MotionProperties_GetMaxAngularVelocity(in_properties: [*c]const JPC_MotionProperties) f32;
pub extern fn JPC_MotionProperties_SetMaxAngularVelocity(in_properties: [*c]JPC_MotionProperties, in_max_angular_velocity: f32) void;
pub extern fn JPC_TempAllocator_Create(in_size: u32) ?*JPC_TempAllocator;
pub extern fn JPC_TempAllocator_Destroy(in_allocator: ?*JPC_TempAllocator) void;
pub extern fn JPC_JobSystem_Create(in_max_jobs: u32, in_max_barriers: u32, in_num_threads: c_int) ?*JPC_JobSystem;
pub extern fn JPC_JobSystem_Destroy(in_job_system: ?*JPC_JobSystem) void;
pub extern fn JPC_PhysicsSystem_Create(in_max_bodies: u32, in_num_body_mutexes: u32, in_max_body_pairs: u32, in_max_contact_constraints: u32, in_broad_phase_layer_interface: ?*const anyopaque, in_object_vs_broad_phase_layer_filter: ?*const anyopaque, in_object_layer_pair_filter: ?*const anyopaque) ?*JPC_PhysicsSystem;
pub extern fn JPC_PhysicsSystem_Destroy(in_physics_system: ?*JPC_PhysicsSystem) void;
pub extern fn JPC_PhysicsSystem_SetBodyActivationListener(in_physics_system: ?*JPC_PhysicsSystem, in_listener: ?*anyopaque) void;
pub extern fn JPC_PhysicsSystem_GetBodyActivationListener(in_physics_system: ?*const JPC_PhysicsSystem) ?*anyopaque;
pub extern fn JPC_PhysicsSystem_SetContactListener(in_physics_system: ?*JPC_PhysicsSystem, in_listener: ?*anyopaque) void;
pub extern fn JPC_PhysicsSystem_GetContactListener(in_physics_system: ?*const JPC_PhysicsSystem) ?*anyopaque;
pub extern fn JPC_PhysicsSystem_GetNumBodies(in_physics_system: ?*const JPC_PhysicsSystem) u32;
pub extern fn JPC_PhysicsSystem_GetNumActiveBodies(in_physics_system: ?*const JPC_PhysicsSystem, in_type: JPC_BodyType) u32;
pub extern fn JPC_PhysicsSystem_GetMaxBodies(in_physics_system: ?*const JPC_PhysicsSystem) u32;
pub extern fn JPC_PhysicsSystem_GetGravity(in_physics_system: ?*const JPC_PhysicsSystem, out_gravity: [*c]f32) void;
pub extern fn JPC_PhysicsSystem_SetGravity(in_physics_system: ?*JPC_PhysicsSystem, in_gravity: [*c]const f32) void;
pub extern fn JPC_PhysicsSystem_GetBodyInterface(in_physics_system: ?*JPC_PhysicsSystem) ?*JPC_BodyInterface;
pub extern fn JPC_PhysicsSystem_GetBodyInterfaceNoLock(in_physics_system: ?*JPC_PhysicsSystem) ?*JPC_BodyInterface;
pub extern fn JPC_PhysicsSystem_OptimizeBroadPhase(in_physics_system: ?*JPC_PhysicsSystem) void;
pub extern fn JPC_PhysicsSystem_AddStepListener(in_physics_system: ?*JPC_PhysicsSystem, in_listener: ?*anyopaque) void;
pub extern fn JPC_PhysicsSystem_RemoveStepListener(in_physics_system: ?*JPC_PhysicsSystem, in_listener: ?*anyopaque) void;
pub extern fn JPC_PhysicsSystem_AddConstraint(in_physics_system: ?*JPC_PhysicsSystem, in_constraint: ?*JPC_Constraint) void;
pub extern fn JPC_PhysicsSystem_RemoveConstraint(in_physics_system: ?*JPC_PhysicsSystem, in_constraint: ?*JPC_Constraint) void;
pub extern fn JPC_PhysicsSystem_Update(in_physics_system: ?*JPC_PhysicsSystem, in_delta_time: f32, in_collision_steps: c_int, in_temp_allocator: ?*JPC_TempAllocator, in_job_system: ?*JPC_JobSystem) JPC_PhysicsUpdateError;
pub extern fn JPC_PhysicsSystem_GetBodyLockInterface(in_physics_system: ?*const JPC_PhysicsSystem) ?*const JPC_BodyLockInterface;
pub extern fn JPC_PhysicsSystem_GetBodyLockInterfaceNoLock(in_physics_system: ?*const JPC_PhysicsSystem) ?*const JPC_BodyLockInterface;
pub extern fn JPC_PhysicsSystem_GetNarrowPhaseQuery(in_physics_system: ?*const JPC_PhysicsSystem) ?*const JPC_NarrowPhaseQuery;
pub extern fn JPC_PhysicsSystem_GetNarrowPhaseQueryNoLock(in_physics_system: ?*const JPC_PhysicsSystem) ?*const JPC_NarrowPhaseQuery;
pub extern fn JPC_PhysicsSystem_GetBodyIDs(in_physics_system: ?*const JPC_PhysicsSystem, in_max_body_ids: u32, out_num_body_ids: [*c]u32, out_body_ids: [*c]JPC_BodyID) void;
pub extern fn JPC_PhysicsSystem_GetActiveBodyIDs(in_physics_system: ?*const JPC_PhysicsSystem, in_max_body_ids: u32, out_num_body_ids: [*c]u32, out_body_ids: [*c]JPC_BodyID) void;
pub extern fn JPC_PhysicsSystem_GetBodiesUnsafe(in_physics_system: ?*JPC_PhysicsSystem) [*c][*c]JPC_Body;
pub extern fn JPC_BodyLockInterface_LockRead(in_lock_interface: ?*const JPC_BodyLockInterface, in_body_id: JPC_BodyID, out_lock: [*c]JPC_BodyLockRead) void;
pub extern fn JPC_BodyLockInterface_UnlockRead(in_lock_interface: ?*const JPC_BodyLockInterface, io_lock: [*c]JPC_BodyLockRead) void;
pub extern fn JPC_BodyLockInterface_LockWrite(in_lock_interface: ?*const JPC_BodyLockInterface, in_body_id: JPC_BodyID, out_lock: [*c]JPC_BodyLockWrite) void;
pub extern fn JPC_BodyLockInterface_UnlockWrite(in_lock_interface: ?*const JPC_BodyLockInterface, io_lock: [*c]JPC_BodyLockWrite) void;
pub extern fn JPC_NarrowPhaseQuery_CastRay(in_query: ?*const JPC_NarrowPhaseQuery, in_ray: [*c]const JPC_RRayCast, io_hit: [*c]JPC_RayCastResult, in_broad_phase_layer_filter: ?*const anyopaque, in_object_layer_filter: ?*const anyopaque, in_body_filter: ?*const anyopaque) bool;
pub extern fn JPC_ShapeSettings_AddRef(in_settings: ?*JPC_ShapeSettings) void;
pub extern fn JPC_ShapeSettings_Release(in_settings: ?*JPC_ShapeSettings) void;
pub extern fn JPC_ShapeSettings_GetRefCount(in_settings: ?*const JPC_ShapeSettings) u32;
pub extern fn JPC_ShapeSettings_CreateShape(in_settings: ?*const JPC_ShapeSettings) ?*JPC_Shape;
pub extern fn JPC_ShapeSettings_GetUserData(in_settings: ?*const JPC_ShapeSettings) u64;
pub extern fn JPC_ShapeSettings_SetUserData(in_settings: ?*JPC_ShapeSettings, in_user_data: u64) void;
pub extern fn JPC_ConvexShapeSettings_GetMaterial(in_settings: ?*const JPC_ConvexShapeSettings) ?*const JPC_PhysicsMaterial;
pub extern fn JPC_ConvexShapeSettings_SetMaterial(in_settings: ?*JPC_ConvexShapeSettings, in_material: ?*const JPC_PhysicsMaterial) void;
pub extern fn JPC_ConvexShapeSettings_GetDensity(in_settings: ?*const JPC_ConvexShapeSettings) f32;
pub extern fn JPC_ConvexShapeSettings_SetDensity(in_settings: ?*JPC_ConvexShapeSettings, in_density: f32) void;
pub extern fn JPC_BoxShapeSettings_Create(in_half_extent: [*c]const f32) ?*JPC_BoxShapeSettings;
pub extern fn JPC_BoxShapeSettings_GetHalfExtent(in_settings: ?*const JPC_BoxShapeSettings, out_half_extent: [*c]f32) void;
pub extern fn JPC_BoxShapeSettings_SetHalfExtent(in_settings: ?*JPC_BoxShapeSettings, in_half_extent: [*c]const f32) void;
pub extern fn JPC_BoxShapeSettings_GetConvexRadius(in_settings: ?*const JPC_BoxShapeSettings) f32;
pub extern fn JPC_BoxShapeSettings_SetConvexRadius(in_settings: ?*JPC_BoxShapeSettings, in_convex_radius: f32) void;
pub extern fn JPC_SphereShapeSettings_Create(in_radius: f32) ?*JPC_SphereShapeSettings;
pub extern fn JPC_SphereShapeSettings_GetRadius(in_settings: ?*const JPC_SphereShapeSettings) f32;
pub extern fn JPC_SphereShapeSettings_SetRadius(in_settings: ?*JPC_SphereShapeSettings, in_radius: f32) void;
pub extern fn JPC_TriangleShapeSettings_Create(in_v1: [*c]const f32, in_v2: [*c]const f32, in_v3: [*c]const f32) ?*JPC_TriangleShapeSettings;
pub extern fn JPC_TriangleShapeSettings_SetVertices(in_settings: ?*JPC_TriangleShapeSettings, in_v1: [*c]const f32, in_v2: [*c]const f32, in_v3: [*c]const f32) void;
pub extern fn JPC_TriangleShapeSettings_GetVertices(in_settings: ?*const JPC_TriangleShapeSettings, out_v1: [*c]f32, out_v2: [*c]f32, out_v3: [*c]f32) void;
pub extern fn JPC_TriangleShapeSettings_GetConvexRadius(in_settings: ?*const JPC_TriangleShapeSettings) f32;
pub extern fn JPC_TriangleShapeSettings_SetConvexRadius(in_settings: ?*JPC_TriangleShapeSettings, in_convex_radius: f32) void;
pub extern fn JPC_CapsuleShapeSettings_Create(in_half_height_of_cylinder: f32, in_radius: f32) ?*JPC_CapsuleShapeSettings;
pub extern fn JPC_CapsuleShapeSettings_GetHalfHeight(in_settings: ?*const JPC_CapsuleShapeSettings) f32;
pub extern fn JPC_CapsuleShapeSettings_SetHalfHeight(in_settings: ?*JPC_CapsuleShapeSettings, in_half_height_of_cylinder: f32) void;
pub extern fn JPC_CapsuleShapeSettings_GetRadius(in_settings: ?*const JPC_CapsuleShapeSettings) f32;
pub extern fn JPC_CapsuleShapeSettings_SetRadius(in_settings: ?*JPC_CapsuleShapeSettings, in_radius: f32) void;
pub extern fn JPC_TaperedCapsuleShapeSettings_Create(in_half_height: f32, in_top_radius: f32, in_bottom_radius: f32) ?*JPC_TaperedCapsuleShapeSettings;
pub extern fn JPC_TaperedCapsuleShapeSettings_GetHalfHeight(in_settings: ?*const JPC_TaperedCapsuleShapeSettings) f32;
pub extern fn JPC_TaperedCapsuleShapeSettings_SetHalfHeight(in_settings: ?*JPC_TaperedCapsuleShapeSettings, in_half_height: f32) void;
pub extern fn JPC_TaperedCapsuleShapeSettings_GetTopRadius(in_settings: ?*const JPC_TaperedCapsuleShapeSettings) f32;
pub extern fn JPC_TaperedCapsuleShapeSettings_SetTopRadius(in_settings: ?*JPC_TaperedCapsuleShapeSettings, in_top_radius: f32) void;
pub extern fn JPC_TaperedCapsuleShapeSettings_GetBottomRadius(in_settings: ?*const JPC_TaperedCapsuleShapeSettings) f32;
pub extern fn JPC_TaperedCapsuleShapeSettings_SetBottomRadius(in_settings: ?*JPC_TaperedCapsuleShapeSettings, in_bottom_radius: f32) void;
pub extern fn JPC_CylinderShapeSettings_Create(in_half_height: f32, in_radius: f32) ?*JPC_CylinderShapeSettings;
pub extern fn JPC_CylinderShapeSettings_GetConvexRadius(in_settings: ?*const JPC_CylinderShapeSettings) f32;
pub extern fn JPC_CylinderShapeSettings_SetConvexRadius(in_settings: ?*JPC_CylinderShapeSettings, in_convex_radius: f32) void;
pub extern fn JPC_CylinderShapeSettings_GetHalfHeight(in_settings: ?*const JPC_CylinderShapeSettings) f32;
pub extern fn JPC_CylinderShapeSettings_SetHalfHeight(in_settings: ?*JPC_CylinderShapeSettings, in_half_height: f32) void;
pub extern fn JPC_CylinderShapeSettings_GetRadius(in_settings: ?*const JPC_CylinderShapeSettings) f32;
pub extern fn JPC_CylinderShapeSettings_SetRadius(in_settings: ?*JPC_CylinderShapeSettings, in_radius: f32) void;
pub extern fn JPC_ConvexHullShapeSettings_Create(in_vertices: ?*const anyopaque, in_num_vertices: u32, in_vertex_size: u32) ?*JPC_ConvexHullShapeSettings;
pub extern fn JPC_ConvexHullShapeSettings_GetMaxConvexRadius(in_settings: ?*const JPC_ConvexHullShapeSettings) f32;
pub extern fn JPC_ConvexHullShapeSettings_SetMaxConvexRadius(in_settings: ?*JPC_ConvexHullShapeSettings, in_max_convex_radius: f32) void;
pub extern fn JPC_ConvexHullShapeSettings_GetMaxErrorConvexRadius(in_settings: ?*const JPC_ConvexHullShapeSettings) f32;
pub extern fn JPC_ConvexHullShapeSettings_SetMaxErrorConvexRadius(in_settings: ?*JPC_ConvexHullShapeSettings, in_max_err_convex_radius: f32) void;
pub extern fn JPC_ConvexHullShapeSettings_GetHullTolerance(in_settings: ?*const JPC_ConvexHullShapeSettings) f32;
pub extern fn JPC_ConvexHullShapeSettings_SetHullTolerance(in_settings: ?*JPC_ConvexHullShapeSettings, in_hull_tolerance: f32) void;
pub extern fn JPC_HeightFieldShapeSettings_Create(in_samples: [*c]const f32, in_height_field_size: u32) ?*JPC_HeightFieldShapeSettings;
pub extern fn JPC_HeightFieldShapeSettings_GetOffset(in_settings: ?*const JPC_HeightFieldShapeSettings, out_offset: [*c]f32) void;
pub extern fn JPC_HeightFieldShapeSettings_SetOffset(in_settings: ?*JPC_HeightFieldShapeSettings, in_offset: [*c]const f32) void;
pub extern fn JPC_HeightFieldShapeSettings_GetScale(in_settings: ?*const JPC_HeightFieldShapeSettings, out_scale: [*c]f32) void;
pub extern fn JPC_HeightFieldShapeSettings_SetScale(in_settings: ?*JPC_HeightFieldShapeSettings, in_scale: [*c]const f32) void;
pub extern fn JPC_HeightFieldShapeSettings_GetBlockSize(in_settings: ?*const JPC_HeightFieldShapeSettings) u32;
pub extern fn JPC_HeightFieldShapeSettings_SetBlockSize(in_settings: ?*JPC_HeightFieldShapeSettings, in_block_size: u32) void;
pub extern fn JPC_HeightFieldShapeSettings_GetBitsPerSample(in_settings: ?*const JPC_HeightFieldShapeSettings) u32;
pub extern fn JPC_HeightFieldShapeSettings_SetBitsPerSample(in_settings: ?*JPC_HeightFieldShapeSettings, in_num_bits: u32) void;
pub extern fn JPC_MeshShapeSettings_Create(in_vertices: ?*const anyopaque, in_num_vertices: u32, in_vertex_size: u32, in_indices: [*c]const u32, in_num_indices: u32) ?*JPC_MeshShapeSettings;
pub extern fn JPC_MeshShapeSettings_GetMaxTrianglesPerLeaf(in_settings: ?*const JPC_MeshShapeSettings) u32;
pub extern fn JPC_MeshShapeSettings_SetMaxTrianglesPerLeaf(in_settings: ?*JPC_MeshShapeSettings, in_max_triangles: u32) void;
pub extern fn JPC_MeshShapeSettings_Sanitize(in_settings: ?*JPC_MeshShapeSettings) void;
pub extern fn JPC_RotatedTranslatedShapeSettings_Create(in_inner_shape_settings: ?*const JPC_ShapeSettings, in_rotated: [*c]const f32, in_translated: [*c]const f32) ?*JPC_DecoratedShapeSettings;
pub extern fn JPC_ScaledShapeSettings_Create(in_inner_shape_settings: ?*const JPC_ShapeSettings, in_scale: [*c]const f32) ?*JPC_DecoratedShapeSettings;
pub extern fn JPC_OffsetCenterOfMassShapeSettings_Create(in_inner_shape_settings: ?*const JPC_ShapeSettings, in_center_of_mass: [*c]const f32) ?*JPC_DecoratedShapeSettings;
pub extern fn JPC_StaticCompoundShapeSettings_Create(...) ?*JPC_CompoundShapeSettings;
pub extern fn JPC_MutableCompoundShapeSettings_Create(...) ?*JPC_CompoundShapeSettings;
pub extern fn JPC_CompoundShapeSettings_AddShape(in_settings: ?*JPC_CompoundShapeSettings, in_position: [*c]const f32, in_rotation: [*c]const f32, in_shape: ?*const JPC_ShapeSettings, in_user_data: u32) void;
pub extern fn JPC_Shape_AddRef(in_shape: ?*JPC_Shape) void;
pub extern fn JPC_Shape_Release(in_shape: ?*JPC_Shape) void;
pub extern fn JPC_Shape_GetRefCount(in_shape: ?*const JPC_Shape) u32;
pub extern fn JPC_Shape_GetType(in_shape: ?*const JPC_Shape) JPC_ShapeType;
pub extern fn JPC_Shape_GetSubType(in_shape: ?*const JPC_Shape) JPC_ShapeSubType;
pub extern fn JPC_Shape_GetUserData(in_shape: ?*const JPC_Shape) u64;
pub extern fn JPC_Shape_SetUserData(in_shape: ?*JPC_Shape, in_user_data: u64) void;
pub extern fn JPC_Shape_GetVolume(in_shape: ?*const JPC_Shape) f32;
pub extern fn JPC_Shape_GetCenterOfMass(in_shape: ?*const JPC_Shape, out_position: [*c]f32) void;
pub extern fn JPC_Shape_GetLocalBounds(in_shape: ?*const JPC_Shape) JPC_AABox;
pub extern fn JPC_Shape_GetSurfaceNormal(in_shape: ?*const JPC_Shape, in_sub_shape_id: JPC_SubShapeID, in_point: [*c]const f32, out_normal: [*c]f32) void;
pub extern fn JPC_Shape_GetSupportingFace(in_shape: ?*const JPC_Shape, in_sub_shape_id: JPC_SubShapeID, in_direction: [*c]const f32, in_scale: [*c]const f32, in_transform: [*c]const f32) JPC_Shape_SupportingFace;
pub extern fn JPC_Shape_CastRay(in_shape: ?*const JPC_Shape, in_ray: [*c]const JPC_RayCast, in_id_creator: [*c]const JPC_SubShapeIDCreator, io_hit: [*c]JPC_RayCastResult) bool;
pub extern fn JPC_Shape_SaveBinaryState(in_shape: ?*const JPC_Shape, in_stream_out: ?*anyopaque) void;
pub extern fn JPC_Shape_SaveWithChildren(in_shape: ?*const JPC_Shape, in_stream_out: ?*anyopaque, io_shape_map: ?*JPC_ShapeToIDMap, io_material_map: ?*JPC_MaterialToIDMap) void;
pub extern fn JPC_Shape_SaveWithChildren_All(in_shape: ?*const JPC_Shape, in_stream_out: ?*anyopaque) void;
pub extern fn JPC_Shape_sRestoreFromBinaryState(in_stream_in: ?*anyopaque) ?*JPC_Shape;
pub extern fn JPC_Shape_sRestoreWithChildren(in_stream_in: ?*anyopaque, io_shape_map: ?*JPC_IDToShapeMap, io_material_map: ?*JPC_IDToMaterialMap) ?*JPC_Shape;
pub extern fn JPC_Shape_sRestoreWithChildren_All(in_stream_in: ?*anyopaque) ?*JPC_Shape;
pub extern fn JPC_ShapeToIDMap_Create(...) ?*JPC_ShapeToIDMap;
pub extern fn JPC_ShapeToIDMap_Add(in_map: ?*JPC_ShapeToIDMap, in_shapes: [*c]const ?*const JPC_Shape, in_num_shapes: u32) void;
pub extern fn JPC_ShapeToIDMap_Destroy(in_map: ?*JPC_ShapeToIDMap) void;
pub extern fn JPC_MaterialToIDMap_Create(...) ?*JPC_MaterialToIDMap;
pub extern fn JPC_MaterialToIDMap_Add(in_map: ?*JPC_MaterialToIDMap, in_materials: [*c]const ?*const JPC_PhysicsMaterial, in_num_materials: u32) void;
pub extern fn JPC_MaterialToIDMap_Destroy(in_map: ?*JPC_MaterialToIDMap) void;
pub extern fn JPC_IDToShapeMap_Create(...) ?*JPC_IDToShapeMap;
pub extern fn JPC_IDToShapeMap_Add(in_map: ?*JPC_IDToShapeMap, in_shapes: [*c]const ?*JPC_Shape, in_num_shapes: u32) void;
pub extern fn JPC_IDToShapeMap_Destroy(in_map: ?*JPC_ShapeToIDMap) void;
pub extern fn JPC_IDToMaterialMap_Create(...) ?*JPC_IDToMaterialMap;
pub extern fn JPC_IDToMaterialMap_Add(in_map: ?*JPC_IDToMaterialMap, in_materials: [*c]const ?*JPC_PhysicsMaterial, in_num_materials: u32) void;
pub extern fn JPC_IDToMaterialMap_Destroy(in_map: ?*JPC_IDToMaterialMap) void;
pub extern fn JPC_BoxShape_GetHalfExtent(in_shape: ?*const JPC_BoxShape, out_half_extent: [*c]f32) void;
pub extern fn JPC_ConvexHullShape_GetNumPoints(in_shape: ?*const JPC_ConvexHullShape) u32;
pub extern fn JPC_ConvexHullShape_GetPoint(in_shape: ?*const JPC_ConvexHullShape, in_point_index: u32, out_point: [*c]f32) void;
pub extern fn JPC_ConvexHullShape_GetNumFaces(in_shape: ?*const JPC_ConvexHullShape) u32;
pub extern fn JPC_ConvexHullShape_GetNumVerticesInFace(in_shape: ?*const JPC_ConvexHullShape, in_face_index: u32) u32;
pub extern fn JPC_ConvexHullShape_GetFaceVertices(in_shape: ?*const JPC_ConvexHullShape, in_face_index: u32, in_max_vertices: u32, out_vertices: [*c]u32) u32;
pub extern fn JPC_DecoratedShape_GetInnerShape(in_shape: ?*const JPC_DecoratedShape) ?*const JPC_Shape;
pub extern fn JPC_RotatedTranslatedShape_GetRotation(in_shape: ?*const JPC_RotatedTranslatedShape, out_rotation: [*c]f32) void;
pub extern fn JPC_RotatedTranslatedShape_GetPosition(in_shape: ?*const JPC_RotatedTranslatedShape, out_position: [*c]f32) void;
pub extern fn JPC_ConstraintSettings_AddRef(in_settings: ?*JPC_ConstraintSettings) void;
pub extern fn JPC_ConstraintSettings_Release(in_settings: ?*JPC_ConstraintSettings) void;
pub extern fn JPC_ConstraintSettings_GetRefCount(in_settings: ?*const JPC_ConstraintSettings) u32;
pub extern fn JPC_ConstraintSettings_GetUserData(in_settings: ?*const JPC_ConstraintSettings) u64;
pub extern fn JPC_ConstraintSettings_SetUserData(in_settings: ?*JPC_ConstraintSettings, in_user_data: u64) void;
pub extern fn JPC_TwoBodyConstraintSettings_CreateConstraint(in_settings: ?*const JPC_TwoBodyConstraintSettings, in_body1: [*c]JPC_Body, in_body2: [*c]JPC_Body) ?*JPC_Constraint;
pub extern fn JPC_FixedConstraintSettings_Create(...) ?*JPC_FixedConstraintSettings;
pub extern fn JPC_FixedConstraintSettings_SetSpace(in_settings: ?*JPC_FixedConstraintSettings, in_space: JPC_ConstraintSpace) void;
pub extern fn JPC_FixedConstraintSettings_SetAutoDetectPoint(in_settings: ?*JPC_FixedConstraintSettings, in_enabled: bool) void;
pub extern fn JPC_Constraint_AddRef(in_shape: ?*JPC_Constraint) void;
pub extern fn JPC_Constraint_Release(in_shape: ?*JPC_Constraint) void;
pub extern fn JPC_Constraint_GetRefCount(in_shape: ?*const JPC_Constraint) u32;
pub extern fn JPC_Constraint_GetType(in_shape: ?*const JPC_Constraint) JPC_ConstraintType;
pub extern fn JPC_Constraint_GetSubType(in_shape: ?*const JPC_Constraint) JPC_ConstraintSubType;
pub extern fn JPC_Constraint_GetUserData(in_shape: ?*const JPC_Constraint) u64;
pub extern fn JPC_Constraint_SetUserData(in_shape: ?*JPC_Constraint, in_user_data: u64) void;
pub extern fn JPC_BodyInterface_CreateBody(in_iface: ?*JPC_BodyInterface, in_setting: [*c]const JPC_BodyCreationSettings) [*c]JPC_Body;
pub extern fn JPC_BodyInterface_CreateBodyWithID(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_settings: [*c]const JPC_BodyCreationSettings) [*c]JPC_Body;
pub extern fn JPC_BodyInterface_DestroyBody(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID) void;
pub extern fn JPC_BodyInterface_DestroyBodies(in_iface: ?*JPC_BodyInterface, in_body_ids: [*c]const JPC_BodyID, in_num_bodies: c_int) void;
pub extern fn JPC_BodyInterface_AddBodiesAbort(in_iface: ?*JPC_BodyInterface, in_body_ids: [*c]JPC_BodyID, in_num_bodies: c_int, add_state: ?*JPC_BodyInterface_AddState) void;
pub extern fn JPC_BodyInterface_AddBodiesFinalize(in_iface: ?*JPC_BodyInterface, in_body_ids: [*c]JPC_BodyID, in_num_bodies: c_int, add_state: ?*JPC_BodyInterface_AddState, in_mode: JPC_Activation) void;
pub extern fn JPC_BodyInterface_AddBodiesPrepare(in_iface: ?*JPC_BodyInterface, in_body_ids: [*c]JPC_BodyID, in_num_bodies: c_int) ?*JPC_BodyInterface_AddState;
pub extern fn JPC_BodyInterface_AddBody(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_mode: JPC_Activation) void;
pub extern fn JPC_BodyInterface_RemoveBody(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID) void;
pub extern fn JPC_BodyInterface_RemoveBodies(in_iface: ?*JPC_BodyInterface, in_body_ids: [*c]JPC_BodyID, in_num_bodies: c_int) void;
pub extern fn JPC_BodyInterface_CreateAndAddBody(in_iface: ?*JPC_BodyInterface, in_settings: [*c]const JPC_BodyCreationSettings, in_mode: JPC_Activation) JPC_BodyID;
pub extern fn JPC_BodyInterface_IsAdded(in_iface: ?*const JPC_BodyInterface, in_body_id: JPC_BodyID) bool;
pub extern fn JPC_BodyInterface_SetLinearAndAngularVelocity(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_linear_velocity: [*c]const f32, in_angular_velocity: [*c]const f32) void;
pub extern fn JPC_BodyInterface_GetLinearAndAngularVelocity(in_iface: ?*const JPC_BodyInterface, in_body_id: JPC_BodyID, out_linear_velocity: [*c]f32, out_angular_velocity: [*c]f32) void;
pub extern fn JPC_BodyInterface_SetLinearVelocity(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_velocity: [*c]const f32) void;
pub extern fn JPC_BodyInterface_GetLinearVelocity(in_iface: ?*const JPC_BodyInterface, in_body_id: JPC_BodyID, out_velocity: [*c]f32) void;
pub extern fn JPC_BodyInterface_AddLinearVelocity(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_velocity: [*c]const f32) void;
pub extern fn JPC_BodyInterface_AddLinearAndAngularVelocity(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_linear_velocity: [*c]const f32, in_angular_velocity: [*c]const f32) void;
pub extern fn JPC_BodyInterface_SetAngularVelocity(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_velocity: [*c]const f32) void;
pub extern fn JPC_BodyInterface_GetAngularVelocity(in_iface: ?*const JPC_BodyInterface, in_body_id: JPC_BodyID, out_velocity: [*c]f32) void;
pub extern fn JPC_BodyInterface_GetPointVelocity(in_iface: ?*const JPC_BodyInterface, in_body_id: JPC_BodyID, in_point: [*c]const JPC_Real, out_velocity: [*c]f32) void;
pub extern fn JPC_BodyInterface_GetPosition(in_iface: ?*const JPC_BodyInterface, in_body_id: JPC_BodyID, out_position: [*c]JPC_Real) void;
pub extern fn JPC_BodyInterface_SetPosition(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_position: [*c]const JPC_Real, in_activation: JPC_Activation) void;
pub extern fn JPC_BodyInterface_GetCenterOfMassPosition(in_iface: ?*const JPC_BodyInterface, in_body_id: JPC_BodyID, out_position: [*c]JPC_Real) void;
pub extern fn JPC_BodyInterface_GetRotation(in_iface: ?*const JPC_BodyInterface, in_body_id: JPC_BodyID, out_rotation: [*c]f32) void;
pub extern fn JPC_BodyInterface_SetRotation(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_rotation: [*c]const f32, in_activation: JPC_Activation) void;
pub extern fn JPC_BodyInterface_ActivateBody(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID) void;
pub extern fn JPC_BodyInterface_ActivateBodies(in_iface: ?*JPC_BodyInterface, in_body_ids: [*c]const JPC_BodyID, in_num_bodies: c_int) void;
pub extern fn JPC_BodyInterface_DeactivateBody(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID) void;
pub extern fn JPC_BodyInterface_DeactivateBodies(in_iface: ?*JPC_BodyInterface, in_body_ids: [*c]const JPC_BodyID, in_num_bodies: c_int) void;
pub extern fn JPC_BodyInterface_IsActive(in_iface: ?*const JPC_BodyInterface, in_body_id: JPC_BodyID) bool;
pub extern fn JPC_BodyInterface_SetShape(in_iface: ?*const JPC_BodyInterface, in_body_id: JPC_BodyID, in_shape: ?*const JPC_Shape, in_update_mass_properties: bool, in_activation_mode: JPC_Activation) void;
pub extern fn JPC_BodyInterface_SetPositionRotationAndVelocity(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_position: [*c]const JPC_Real, in_rotation: [*c]const f32, in_linear_velocity: [*c]const f32, in_angular_velocity: [*c]const f32) void;
pub extern fn JPC_BodyInterface_AddForce(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_force: [*c]const f32) void;
pub extern fn JPC_BodyInterface_AddForceAtPosition(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_force: [*c]const f32, in_position: [*c]const JPC_Real) void;
pub extern fn JPC_BodyInterface_AddTorque(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_torque: [*c]const f32) void;
pub extern fn JPC_BodyInterface_AddForceAndTorque(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_force: [*c]const f32, in_torque: [*c]const f32) void;
pub extern fn JPC_BodyInterface_AddImpulse(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_impulse: [*c]const f32) void;
pub extern fn JPC_BodyInterface_AddImpulseAtPosition(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_impulse: [*c]const f32, in_position: [*c]const JPC_Real) void;
pub extern fn JPC_BodyInterface_AddAngularImpulse(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_impulse: [*c]const f32) void;
pub extern fn JPC_BodyInterface_GetMotionType(in_iface: ?*const JPC_BodyInterface, in_body_id: JPC_BodyID) JPC_MotionType;
pub extern fn JPC_BodyInterface_SetMotionType(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, motion_type: JPC_MotionType, activation: JPC_Activation) void;
pub extern fn JPC_BodyInterface_GetObjectLayer(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID) JPC_ObjectLayer;
pub extern fn JPC_BodyInterface_SetObjectLayer(in_iface: ?*JPC_BodyInterface, in_body_id: JPC_BodyID, in_layer: JPC_ObjectLayer) void;
pub extern fn JPC_Body_GetID(in_body: [*c]const JPC_Body) JPC_BodyID;
pub extern fn JPC_Body_IsActive(in_body: [*c]const JPC_Body) bool;
pub extern fn JPC_Body_IsStatic(in_body: [*c]const JPC_Body) bool;
pub extern fn JPC_Body_IsKinematic(in_body: [*c]const JPC_Body) bool;
pub extern fn JPC_Body_IsDynamic(in_body: [*c]const JPC_Body) bool;
pub extern fn JPC_Body_CanBeKinematicOrDynamic(in_body: [*c]const JPC_Body) bool;
pub extern fn JPC_Body_SetIsSensor(in_body: [*c]JPC_Body, in_is_sensor: bool) void;
pub extern fn JPC_Body_IsSensor(in_body: [*c]const JPC_Body) bool;
pub extern fn JPC_Body_GetMotionType(in_body: [*c]const JPC_Body) JPC_MotionType;
pub extern fn JPC_Body_SetMotionType(in_body: [*c]JPC_Body, in_motion_type: JPC_MotionType) void;
pub extern fn JPC_Body_GetBroadPhaseLayer(in_body: [*c]const JPC_Body) JPC_BroadPhaseLayer;
pub extern fn JPC_Body_GetObjectLayer(in_body: [*c]const JPC_Body) JPC_ObjectLayer;
pub extern fn JPC_Body_GetCollisionGroup(in_body: [*c]JPC_Body) [*c]JPC_CollisionGroup;
pub extern fn JPC_Body_SetCollisionGroup(in_body: [*c]JPC_Body, in_group: [*c]const JPC_CollisionGroup) void;
pub extern fn JPC_Body_GetAllowSleeping(in_body: [*c]const JPC_Body) bool;
pub extern fn JPC_Body_SetAllowSleeping(in_body: [*c]JPC_Body, in_allow_sleeping: bool) void;
pub extern fn JPC_Body_GetFriction(in_body: [*c]const JPC_Body) f32;
pub extern fn JPC_Body_SetFriction(in_body: [*c]JPC_Body, in_friction: f32) void;
pub extern fn JPC_Body_GetRestitution(in_body: [*c]const JPC_Body) f32;
pub extern fn JPC_Body_SetRestitution(in_body: [*c]JPC_Body, in_restitution: f32) void;
pub extern fn JPC_Body_GetLinearVelocity(in_body: [*c]const JPC_Body, out_linear_velocity: [*c]f32) void;
pub extern fn JPC_Body_SetLinearVelocity(in_body: [*c]JPC_Body, in_linear_velocity: [*c]const f32) void;
pub extern fn JPC_Body_SetLinearVelocityClamped(in_body: [*c]JPC_Body, in_linear_velocity: [*c]const f32) void;
pub extern fn JPC_Body_GetAngularVelocity(in_body: [*c]const JPC_Body, out_angular_velocity: [*c]f32) void;
pub extern fn JPC_Body_SetAngularVelocity(in_body: [*c]JPC_Body, in_angular_velocity: [*c]const f32) void;
pub extern fn JPC_Body_SetAngularVelocityClamped(in_body: [*c]JPC_Body, in_angular_velocity: [*c]const f32) void;
pub extern fn JPC_Body_GetPointVelocityCOM(in_body: [*c]const JPC_Body, in_point_relative_to_com: [*c]const f32, out_velocity: [*c]f32) void;
pub extern fn JPC_Body_GetPointVelocity(in_body: [*c]const JPC_Body, in_point: [*c]const JPC_Real, out_velocity: [*c]f32) void;
pub extern fn JPC_Body_AddForce(in_body: [*c]JPC_Body, in_force: [*c]const f32) void;
pub extern fn JPC_Body_AddForceAtPosition(in_body: [*c]JPC_Body, in_force: [*c]const f32, in_position: [*c]const JPC_Real) void;
pub extern fn JPC_Body_AddTorque(in_body: [*c]JPC_Body, in_torque: [*c]const f32) void;
pub extern fn JPC_Body_GetInverseInertia(in_body: [*c]const JPC_Body, out_inverse_inertia: [*c]f32) void;
pub extern fn JPC_Body_AddImpulse(in_body: [*c]JPC_Body, in_impulse: [*c]const f32) void;
pub extern fn JPC_Body_AddImpulseAtPosition(in_body: [*c]JPC_Body, in_impulse: [*c]const f32, in_position: [*c]const JPC_Real) void;
pub extern fn JPC_Body_AddAngularImpulse(in_body: [*c]JPC_Body, in_angular_impulse: [*c]const f32) void;
pub extern fn JPC_Body_MoveKinematic(in_body: [*c]JPC_Body, in_target_position: [*c]const JPC_Real, in_target_rotation: [*c]const f32, in_delta_time: f32) void;
pub extern fn JPC_Body_ApplyBuoyancyImpulse(in_body: [*c]JPC_Body, in_surface_position: [*c]const JPC_Real, in_surface_normal: [*c]const f32, in_buoyancy: f32, in_linear_drag: f32, in_angular_drag: f32, in_fluid_velocity: [*c]const f32, in_gravity: [*c]const f32, in_delta_time: f32) void;
pub extern fn JPC_Body_IsInBroadPhase(in_body: [*c]const JPC_Body) bool;
pub extern fn JPC_Body_IsCollisionCacheInvalid(in_body: [*c]const JPC_Body) bool;
pub extern fn JPC_Body_GetShape(in_body: [*c]const JPC_Body) ?*const JPC_Shape;
pub extern fn JPC_Body_GetPosition(in_body: [*c]const JPC_Body, out_position: [*c]JPC_Real) void;
pub extern fn JPC_Body_GetRotation(in_body: [*c]const JPC_Body, out_rotation: [*c]f32) void;
pub extern fn JPC_Body_GetWorldTransform(in_body: [*c]const JPC_Body, out_rotation: [*c]f32, out_translation: [*c]JPC_Real) void;
pub extern fn JPC_Body_GetCenterOfMassPosition(in_body: [*c]const JPC_Body, out_position: [*c]JPC_Real) void;
pub extern fn JPC_Body_GetCenterOfMassTransform(in_body: [*c]const JPC_Body, out_rotation: [*c]f32, out_translation: [*c]JPC_Real) void;
pub extern fn JPC_Body_GetInverseCenterOfMassTransform(in_body: [*c]const JPC_Body, out_rotation: [*c]f32, out_translation: [*c]JPC_Real) void;
pub extern fn JPC_Body_GetWorldSpaceBounds(in_body: [*c]const JPC_Body, out_min: [*c]f32, out_max: [*c]f32) void;
pub extern fn JPC_Body_GetMotionProperties(in_body: [*c]JPC_Body) [*c]JPC_MotionProperties;
pub extern fn JPC_Body_GetUserData(in_body: [*c]const JPC_Body) u64;
pub extern fn JPC_Body_SetUserData(in_body: [*c]JPC_Body, in_user_data: u64) void;
pub extern fn JPC_Body_GetWorldSpaceSurfaceNormal(in_body: [*c]const JPC_Body, in_sub_shape_id: JPC_SubShapeID, in_position: [*c]const JPC_Real, out_normal_vector: [*c]f32) void;
pub extern fn JPC_Body_GetFixedToWorld(...) [*c]JPC_Body;
pub extern fn JPC_BodyID_GetIndex(in_body_id: JPC_BodyID) u32;
pub extern fn JPC_BodyID_GetSequenceNumber(in_body_id: JPC_BodyID) u8;
pub extern fn JPC_BodyID_IsInvalid(in_body_id: JPC_BodyID) bool;
pub extern fn JPC_CharacterSettings_Create(...) [*c]JPC_CharacterSettings;
pub extern fn JPC_CharacterSettings_Release(in_settings: [*c]JPC_CharacterSettings) void;
pub extern fn JPC_CharacterSettings_AddRef(in_settings: [*c]JPC_CharacterSettings) void;
pub extern fn JPC_Character_Create(in_settings: [*c]const JPC_CharacterSettings, in_position: [*c]const JPC_Real, in_rotation: [*c]const f32, in_user_data: u64, in_physics_system: ?*JPC_PhysicsSystem) ?*JPC_Character;
pub extern fn JPC_Character_Destroy(in_character: ?*JPC_Character) void;
pub extern fn JPC_Character_AddToPhysicsSystem(in_character: ?*JPC_Character, in_activation: JPC_Activation, in_lock_bodies: bool) void;
pub extern fn JPC_Character_RemoveFromPhysicsSystem(in_character: ?*JPC_Character, in_lock_bodies: bool) void;
pub extern fn JPC_Character_GetPosition(in_character: ?*const JPC_Character, out_position: [*c]JPC_Real) void;
pub extern fn JPC_Character_SetPosition(in_character: ?*JPC_Character, in_position: [*c]const JPC_Real) void;
pub extern fn JPC_Character_GetLinearVelocity(in_character: ?*const JPC_Character, out_linear_velocity: [*c]f32) void;
pub extern fn JPC_Character_SetLinearVelocity(in_character: ?*JPC_Character, in_linear_velocity: [*c]const f32) void;
pub extern fn JPC_CharacterVirtualSettings_Create(...) [*c]JPC_CharacterVirtualSettings;
pub extern fn JPC_CharacterVirtualSettings_Release(in_settings: [*c]JPC_CharacterVirtualSettings) void;
pub extern fn JPC_CharacterVirtual_Create(in_settings: [*c]const JPC_CharacterVirtualSettings, in_position: [*c]const JPC_Real, in_rotation: [*c]const f32, in_physics_system: ?*JPC_PhysicsSystem) ?*JPC_CharacterVirtual;
pub extern fn JPC_CharacterVirtual_Destroy(in_character: ?*JPC_CharacterVirtual) void;
pub extern fn JPC_CharacterVirtual_Update(in_character: ?*JPC_CharacterVirtual, in_delta_time: f32, in_gravity: [*c]const f32, in_broad_phase_layer_filter: ?*const anyopaque, in_object_layer_filter: ?*const anyopaque, in_body_filter: ?*const anyopaque, in_shape_filter: ?*const anyopaque, in_temp_allocator: ?*JPC_TempAllocator) void;
pub extern fn JPC_CharacterVirtual_ExtendedUpdate(in_character: ?*JPC_CharacterVirtual, in_delta_time: f32, in_gravity: [*c]const f32, in_settings: ?*const anyopaque, in_broad_phase_layer_filter: ?*const anyopaque, in_object_layer_filter: ?*const anyopaque, in_body_filter: ?*const anyopaque, in_shape_filter: ?*const anyopaque, in_temp_allocator: ?*JPC_TempAllocator) void;
pub extern fn JPC_CharacterVirtual_SetListener(in_character: ?*JPC_CharacterVirtual, in_listener: ?*anyopaque) void;
pub extern fn JPC_CharacterVirtual_UpdateGroundVelocity(in_character: ?*JPC_CharacterVirtual) void;
pub extern fn JPC_CharacterVirtual_GetGroundVelocity(in_character: ?*const JPC_CharacterVirtual, out_ground_velocity: [*c]f32) void;
pub extern fn JPC_CharacterVirtual_GetGroundState(in_character: ?*JPC_CharacterVirtual) JPC_CharacterGroundState;
pub extern fn JPC_CharacterVirtual_GetPosition(in_character: ?*const JPC_CharacterVirtual, out_position: [*c]JPC_Real) void;
pub extern fn JPC_CharacterVirtual_SetPosition(in_character: ?*JPC_CharacterVirtual, in_position: [*c]const JPC_Real) void;
pub extern fn JPC_CharacterVirtual_GetRotation(in_character: ?*const JPC_CharacterVirtual, out_rotation: [*c]f32) void;
pub extern fn JPC_CharacterVirtual_SetRotation(in_character: ?*JPC_CharacterVirtual, in_rotation: [*c]const f32) void;
pub extern fn JPC_CharacterVirtual_GetLinearVelocity(in_character: ?*const JPC_CharacterVirtual, out_linear_velocity: [*c]f32) void;
pub extern fn JPC_CharacterVirtual_SetLinearVelocity(in_character: ?*JPC_CharacterVirtual, in_linear_velocity: [*c]const f32) void;

pub const __VERSION__ = "Aro aro-zig";
pub const __Aro__ = "";
pub const __STDC__ = @as(c_int, 1);
pub const __STDC_HOSTED__ = @as(c_int, 1);
pub const __STDC_UTF_16__ = @as(c_int, 1);
pub const __STDC_UTF_32__ = @as(c_int, 1);
pub const __STDC_EMBED_NOT_FOUND__ = @as(c_int, 0);
pub const __STDC_EMBED_FOUND__ = @as(c_int, 1);
pub const __STDC_EMBED_EMPTY__ = @as(c_int, 2);
pub const __STDC_NO_THREADS__ = @as(c_int, 1);
pub const __STDC_VERSION__ = @as(c_long, 201710);
pub const __GNUC__ = @as(c_int, 4);
pub const __GNUC_MINOR__ = @as(c_int, 2);
pub const __GNUC_PATCHLEVEL__ = @as(c_int, 1);
pub const __ARO_EMULATE_NO__ = @as(c_int, 0);
pub const __ARO_EMULATE_CLANG__ = @as(c_int, 1);
pub const __ARO_EMULATE_GCC__ = @as(c_int, 2);
pub const __ARO_EMULATE_MSVC__ = @as(c_int, 3);
pub const __ARO_EMULATE__ = __ARO_EMULATE_CLANG__;
pub inline fn __building_module(x: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &x;
    return @as(c_int, 0);
}
pub const __APPLE__ = @as(c_int, 1);
pub const __APPLE_CC__ = @as(c_int, 6000);
pub const __ENVIRONMENT_MAC_OS_X_VERSION_MIN_REQUIRED__ = __helpers.promoteIntLiteral(c_int, 260400, .decimal);
pub const __ENVIRONMENT_OS_VERSION_MIN_REQUIRED__ = __helpers.promoteIntLiteral(c_int, 260400, .decimal);
pub const __aarch64__ = @as(c_int, 1);
pub const __AARCH64EL__ = @as(c_int, 1);
pub const __AARCH64_SIMD__ = @as(c_int, 1);
pub const __ARM64_ARCH_8__ = @as(c_int, 1);
pub const __ARM_NEON__ = @as(c_int, 1);
pub const __arm64 = @as(c_int, 1);
pub const __arm64__ = @as(c_int, 1);
pub const __AARCH64_CMODEL_SMALL__ = @as(c_int, 1);
pub const __ARM_FP = @as(c_int, 0xE);
pub const __ARM_NEON = @as(c_int, 1);
pub const __ARM_NEON_FP = @as(c_int, 0xE);
pub const __ARM_FEATURE_SHA3 = @as(c_int, 1);
pub const __ARM_FEATURE_SHA512 = @as(c_int, 1);
pub const __ARM_FEATURE_UNALIGNED = @as(c_int, 1);
pub const __ARM_FEATURE_FP16_VECTOR_ARITHMETIC = @as(c_int, 1);
pub const __ARM_FEATURE_RCPC = @as(c_int, 1);
pub const __ARM_FEATURE_CRC32 = @as(c_int, 1);
pub const __ARM_FEATURE_AES = @as(c_int, 1);
pub const __ARM_FEATURE_SHA2 = @as(c_int, 1);
pub const __ARM_FEATURE_PAUTH = @as(c_int, 1);
pub const __ARM_FEATURE_FP16_SCALAR_ARITHMETIC = @as(c_int, 1);
pub const __ARM_FEATURE_DOTPROD = @as(c_int, 1);
pub const __ARM_FEATURE_ATOMICS = @as(c_int, 1);
pub const __ARM_FEATURE_FP16_FML = @as(c_int, 1);
pub const _LP64 = @as(c_int, 1);
pub const __LP64__ = @as(c_int, 1);
pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
pub const __MACH__ = @as(c_int, 1);
pub const __nonnull = @compileError("unable to translate C expr: unexpected token '_Nonnull'"); // <builtin>:57:9
pub const __null_unspecified = @compileError("unable to translate C expr: unexpected token '_Null_unspecified'"); // <builtin>:58:9
pub const __nullable = @compileError("unable to translate C expr: unexpected token '_Nullable'"); // <builtin>:59:9
pub const __ATOMIC_RELAXED = @as(c_int, 0);
pub const __ATOMIC_CONSUME = @as(c_int, 1);
pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
pub const __ATOMIC_RELEASE = @as(c_int, 3);
pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
pub const __ATOMIC_BOOL_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_WINT_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_SHORT_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_INT_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_LONG_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_LLONG_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_POINTER_LOCK_FREE = @as(c_int, 1);
pub const __CHAR_BIT__ = @as(c_int, 8);
pub const __BOOL_WIDTH__ = @as(c_int, 8);
pub const __SCHAR_MAX__ = @as(c_int, 127);
pub const __SCHAR_WIDTH__ = @as(c_int, 8);
pub const __SHRT_MAX__ = @as(c_int, 32767);
pub const __SHRT_WIDTH__ = @as(c_int, 16);
pub const __INT_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_WIDTH__ = @as(c_int, 32);
pub const __LONG_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __LONG_WIDTH__ = @as(c_int, 64);
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __LONG_LONG_WIDTH__ = @as(c_int, 64);
pub const __WCHAR_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WCHAR_WIDTH__ = @as(c_int, 32);
pub const __WINT_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WINT_WIDTH__ = @as(c_int, 32);
pub const __INTMAX_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTMAX_WIDTH__ = @as(c_int, 64);
pub const __SIZE_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __SIZE_WIDTH__ = @as(c_int, 64);
pub const __UINTMAX_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
pub const __PTRDIFF_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __PTRDIFF_WIDTH__ = @as(c_int, 64);
pub const __INTPTR_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTPTR_WIDTH__ = @as(c_int, 64);
pub const __UINTPTR_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTPTR_WIDTH__ = @as(c_int, 64);
pub const __SIG_ATOMIC_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
pub const __BITINT_MAXWIDTH__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_SHORT__ = @as(c_int, 2);
pub const __SIZEOF_INT__ = @as(c_int, 4);
pub const __SIZEOF_LONG__ = @as(c_int, 8);
pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
pub const __SIZEOF_POINTER__ = @as(c_int, 8);
pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 8);
pub const __SIZEOF_SIZE_T__ = @as(c_int, 8);
pub const __SIZEOF_WCHAR_T__ = @as(c_int, 4);
pub const __SIZEOF_WINT_T__ = @as(c_int, 4);
pub const __SIZEOF_INT128__ = @as(c_int, 16);
pub const __INTPTR_TYPE__ = c_long;
pub const __UINTPTR_TYPE__ = c_ulong;
pub const __INTMAX_TYPE__ = c_long;
pub const __INTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`"); // <builtin>:124:9
pub const __INTMAX_C = __helpers.L_SUFFIX;
pub const __UINTMAX_TYPE__ = c_ulong;
pub const __UINTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`"); // <builtin>:127:9
pub const __UINTMAX_C = __helpers.UL_SUFFIX;
pub const __PTRDIFF_TYPE__ = c_long;
pub const __SIZE_TYPE__ = c_ulong;
pub const __WCHAR_TYPE__ = c_int;
pub const __WINT_TYPE__ = c_int;
pub const __CHAR16_TYPE__ = c_ushort;
pub const __CHAR32_TYPE__ = c_uint;
pub const __INT8_TYPE__ = i8;
pub const __INT8_FMTd__ = "hhd";
pub const __INT8_FMTi__ = "hhi";
pub const __INT8_C_SUFFIX__ = "";
pub inline fn __INT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT16_TYPE__ = c_short;
pub const __INT16_FMTd__ = "hd";
pub const __INT16_FMTi__ = "hi";
pub const __INT16_C_SUFFIX__ = "";
pub inline fn __INT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT32_TYPE__ = c_int;
pub const __INT32_FMTd__ = "d";
pub const __INT32_FMTi__ = "i";
pub const __INT32_C_SUFFIX__ = "";
pub inline fn __INT32_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT64_TYPE__ = c_longlong;
pub const __INT64_FMTd__ = "lld";
pub const __INT64_FMTi__ = "lli";
pub const __INT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `LL`"); // <builtin>:153:9
pub const __INT64_C = __helpers.LL_SUFFIX;
pub const __UINT8_TYPE__ = u8;
pub const __UINT8_FMTo__ = "hho";
pub const __UINT8_FMTu__ = "hhu";
pub const __UINT8_FMTx__ = "hhx";
pub const __UINT8_FMTX__ = "hhX";
pub const __UINT8_C_SUFFIX__ = "";
pub inline fn __UINT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __UINT8_MAX__ = @as(c_int, 255);
pub const __INT8_MAX__ = @as(c_int, 127);
pub const __UINT16_TYPE__ = c_ushort;
pub const __UINT16_FMTo__ = "ho";
pub const __UINT16_FMTu__ = "hu";
pub const __UINT16_FMTx__ = "hx";
pub const __UINT16_FMTX__ = "hX";
pub const __UINT16_C_SUFFIX__ = "";
pub inline fn __UINT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __UINT16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const __INT16_MAX__ = @as(c_int, 32767);
pub const __UINT32_TYPE__ = c_uint;
pub const __UINT32_FMTo__ = "o";
pub const __UINT32_FMTu__ = "u";
pub const __UINT32_FMTx__ = "x";
pub const __UINT32_FMTX__ = "X";
pub const __UINT32_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `U`"); // <builtin>:178:9
pub const __UINT32_C = __helpers.U_SUFFIX;
pub const __UINT32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __INT32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __UINT64_TYPE__ = c_ulonglong;
pub const __UINT64_FMTo__ = "llo";
pub const __UINT64_FMTu__ = "llu";
pub const __UINT64_FMTx__ = "llx";
pub const __UINT64_FMTX__ = "llX";
pub const __UINT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `ULL`"); // <builtin>:187:9
pub const __UINT64_C = __helpers.ULL_SUFFIX;
pub const __UINT64_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __INT64_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INT_LEAST8_TYPE__ = i8;
pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
pub const __INT_LEAST8_WIDTH__ = @as(c_int, 8);
pub const INT_LEAST8_FMTd__ = "hhd";
pub const INT_LEAST8_FMTi__ = "hhi";
pub const __UINT_LEAST8_TYPE__ = u8;
pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
pub const UINT_LEAST8_FMTo__ = "hho";
pub const UINT_LEAST8_FMTu__ = "hhu";
pub const UINT_LEAST8_FMTx__ = "hhx";
pub const UINT_LEAST8_FMTX__ = "hhX";
pub const __INT_FAST8_TYPE__ = i8;
pub const __INT_FAST8_MAX__ = @as(c_int, 127);
pub const __INT_FAST8_WIDTH__ = @as(c_int, 8);
pub const INT_FAST8_FMTd__ = "hhd";
pub const INT_FAST8_FMTi__ = "hhi";
pub const __UINT_FAST8_TYPE__ = u8;
pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
pub const UINT_FAST8_FMTo__ = "hho";
pub const UINT_FAST8_FMTu__ = "hhu";
pub const UINT_FAST8_FMTx__ = "hhx";
pub const UINT_FAST8_FMTX__ = "hhX";
pub const __INT_LEAST16_TYPE__ = c_short;
pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
pub const __INT_LEAST16_WIDTH__ = @as(c_int, 16);
pub const INT_LEAST16_FMTd__ = "hd";
pub const INT_LEAST16_FMTi__ = "hi";
pub const __UINT_LEAST16_TYPE__ = c_ushort;
pub const __UINT_LEAST16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_LEAST16_FMTo__ = "ho";
pub const UINT_LEAST16_FMTu__ = "hu";
pub const UINT_LEAST16_FMTx__ = "hx";
pub const UINT_LEAST16_FMTX__ = "hX";
pub const __INT_FAST16_TYPE__ = c_short;
pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
pub const __INT_FAST16_WIDTH__ = @as(c_int, 16);
pub const INT_FAST16_FMTd__ = "hd";
pub const INT_FAST16_FMTi__ = "hi";
pub const __UINT_FAST16_TYPE__ = c_ushort;
pub const __UINT_FAST16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_FAST16_FMTo__ = "ho";
pub const UINT_FAST16_FMTu__ = "hu";
pub const UINT_FAST16_FMTx__ = "hx";
pub const UINT_FAST16_FMTX__ = "hX";
pub const __INT_LEAST32_TYPE__ = c_int;
pub const __INT_LEAST32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_LEAST32_WIDTH__ = @as(c_int, 32);
pub const INT_LEAST32_FMTd__ = "d";
pub const INT_LEAST32_FMTi__ = "i";
pub const __UINT_LEAST32_TYPE__ = c_uint;
pub const __UINT_LEAST32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_LEAST32_FMTo__ = "o";
pub const UINT_LEAST32_FMTu__ = "u";
pub const UINT_LEAST32_FMTx__ = "x";
pub const UINT_LEAST32_FMTX__ = "X";
pub const __INT_FAST32_TYPE__ = c_int;
pub const __INT_FAST32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_FAST32_WIDTH__ = @as(c_int, 32);
pub const INT_FAST32_FMTd__ = "d";
pub const INT_FAST32_FMTi__ = "i";
pub const __UINT_FAST32_TYPE__ = c_uint;
pub const __UINT_FAST32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_FAST32_FMTo__ = "o";
pub const UINT_FAST32_FMTu__ = "u";
pub const UINT_FAST32_FMTx__ = "x";
pub const UINT_FAST32_FMTX__ = "X";
pub const __INT_LEAST64_TYPE__ = c_longlong;
pub const __INT_LEAST64_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INT_LEAST64_WIDTH__ = @as(c_int, 64);
pub const INT_LEAST64_FMTd__ = "lld";
pub const INT_LEAST64_FMTi__ = "lli";
pub const __UINT_LEAST64_TYPE__ = c_ulonglong;
pub const __UINT_LEAST64_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const UINT_LEAST64_FMTo__ = "llo";
pub const UINT_LEAST64_FMTu__ = "llu";
pub const UINT_LEAST64_FMTx__ = "llx";
pub const UINT_LEAST64_FMTX__ = "llX";
pub const __INT_FAST64_TYPE__ = c_longlong;
pub const __INT_FAST64_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INT_FAST64_WIDTH__ = @as(c_int, 64);
pub const INT_FAST64_FMTd__ = "lld";
pub const INT_FAST64_FMTi__ = "lli";
pub const __UINT_FAST64_TYPE__ = c_ulonglong;
pub const __UINT_FAST64_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const UINT_FAST64_FMTo__ = "llo";
pub const UINT_FAST64_FMTu__ = "llu";
pub const UINT_FAST64_FMTx__ = "llx";
pub const UINT_FAST64_FMTX__ = "llX";
pub const __FLT16_DENORM_MIN__ = @as(f16, 5.9604644775390625e-8);
pub const __FLT16_HAS_DENORM__ = "";
pub const __FLT16_DIG__ = @as(c_int, 3);
pub const __FLT16_DECIMAL_DIG__ = @as(c_int, 5);
pub const __FLT16_EPSILON__ = @as(f16, 9.765625e-4);
pub const __FLT16_HAS_INFINITY__ = "";
pub const __FLT16_HAS_QUIET_NAN__ = "";
pub const __FLT16_MANT_DIG__ = @as(c_int, 11);
pub const __FLT16_MAX_10_EXP__ = @as(c_int, 4);
pub const __FLT16_MAX_EXP__ = @as(c_int, 16);
pub const __FLT16_MAX__ = @as(f16, 6.5504e+4);
pub const __FLT16_MIN_10_EXP__ = -@as(c_int, 4);
pub const __FLT16_MIN_EXP__ = -@as(c_int, 13);
pub const __FLT16_MIN__ = @as(f16, 6.103515625e-5);
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub const __FLT_HAS_DENORM__ = "";
pub const __FLT_DIG__ = @as(c_int, 6);
pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FLT_HAS_INFINITY__ = "";
pub const __FLT_HAS_QUIET_NAN__ = "";
pub const __FLT_MANT_DIG__ = @as(c_int, 24);
pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
pub const __FLT_MAX_EXP__ = @as(c_int, 128);
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __DBL_DENORM_MIN__ = @as(f64, 4.9406564584124654e-324);
pub const __DBL_HAS_DENORM__ = "";
pub const __DBL_DIG__ = @as(c_int, 15);
pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __DBL_EPSILON__ = @as(f64, 2.2204460492503131e-16);
pub const __DBL_HAS_INFINITY__ = "";
pub const __DBL_HAS_QUIET_NAN__ = "";
pub const __DBL_MANT_DIG__ = @as(c_int, 53);
pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
pub const __DBL_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __DBL_MIN__ = @as(f64, 2.2250738585072014e-308);
pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 4.9406564584124654e-324);
pub const __LDBL_HAS_DENORM__ = "";
pub const __LDBL_DIG__ = @as(c_int, 15);
pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __LDBL_EPSILON__ = @as(c_longdouble, 2.2204460492503131e-16);
pub const __LDBL_HAS_INFINITY__ = "";
pub const __LDBL_HAS_QUIET_NAN__ = "";
pub const __LDBL_MANT_DIG__ = @as(c_int, 53);
pub const __LDBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __LDBL_MAX_EXP__ = @as(c_int, 1024);
pub const __LDBL_MAX__ = @as(c_longdouble, 1.7976931348623157e+308);
pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __LDBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __LDBL_MIN__ = @as(c_longdouble, 2.2250738585072014e-308);
pub const __FLT_EVAL_METHOD__ = @as(c_int, 0);
pub const __FLT_RADIX__ = @as(c_int, 2);
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const __pic__ = @as(c_int, 2);
pub const __PIC__ = @as(c_int, 2);
pub const _LIBCPP_ABI_VERSION = @as(c_int, 1);
pub const _LIBCPP_ABI_NAMESPACE = @compileError("unable to translate macro: undefined identifier `__1`"); // <command line>:2:9
pub const _LIBCPP_HAS_THREADS = @as(c_int, 1);
pub const _LIBCPP_HAS_MONOTONIC_CLOCK = @as(c_int, 1);
pub const _LIBCPP_HAS_TERMINAL = @as(c_int, 1);
pub const _LIBCPP_HAS_MUSL_LIBC = @as(c_int, 0);
pub const _LIBCXXABI_DISABLE_VISIBILITY_ANNOTATIONS = @as(c_int, 1);
pub const _LIBCPP_DISABLE_VISIBILITY_ANNOTATIONS = @as(c_int, 1);
pub const _LIBCPP_HAS_FILESYSTEM = @as(c_int, 1);
pub const _LIBCPP_HAS_RANDOM_DEVICE = @as(c_int, 1);
pub const _LIBCPP_HAS_LOCALIZATION = @as(c_int, 1);
pub const _LIBCPP_HAS_UNICODE = @as(c_int, 1);
pub const _LIBCPP_HAS_WIDE_CHARACTERS = @as(c_int, 1);
pub const _LIBCPP_HAS_NO_STD_MODULES = @as(c_int, 1);
pub const _LIBCPP_PSTL_BACKEND_SERIAL = @as(c_int, 1);
pub const _LIBCPP_HARDENING_MODE = @compileError("unable to translate macro: undefined identifier `_LIBCPP_HARDENING_MODE_NONE`"); // <command line>:17:9
pub const JPH_ENABLE_ASSERTS = "";
pub const JPH_CROSS_PLATFORM_DETERMINISTIC = "";
pub const _LIBCPP___CONFIG = "";
pub const _LIBCPP___CONFIGURATION_ABI_H = "";
pub const _LIBCPP___CONFIGURATION_COMPILER_H = "";
pub const _LIBCPP_COMPILER_GCC = "";
pub const _LIBCPP_GCC_VER = (__GNUC__ * @as(c_int, 100)) + __GNUC_MINOR__;
pub const _LIBCPP___CONFIGURATION_PLATFORM_H = "";
pub const _LIBCPP_OBJECT_FORMAT_MACHO = @as(c_int, 1);
pub const _LIBCPP_LITTLE_ENDIAN = "";
pub const _LIBCPP_ABI_ITANIUM_WITH_ARM_DIFFERENCES = "";
pub const _LIBCPP_DEPRECATED_ABI_LEGACY_LIBRARY_DEFINITIONS_FOR_INLINE_FUNCTIONS = "";
pub const _LIBCPP_ABI_LLVM18_NO_UNIQUE_ADDRESS = @compileError("unable to translate macro: undefined identifier `__abi_tag__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libcxx/include/__configuration/abi.h:121:9
pub const _LIBCPP___CONFIGURATION_AVAILABILITY_H = "";
pub const _LIBCPP___CONFIGURATION_LANGUAGE_H = "";
pub const _LIBCPP_HAS_RTTI = @as(c_int, 0);
pub const _LIBCPP_HAS_EXCEPTIONS = @as(c_int, 0);
pub const _LIBCPP_HAS_VENDOR_AVAILABILITY_ANNOTATIONS = @as(c_int, 0);
pub const _LIBCPP_INTRODUCED_IN_LLVM_21 = @as(c_int, 1);
pub const _LIBCPP_INTRODUCED_IN_LLVM_21_ATTRIBUTE = "";
pub const _LIBCPP_INTRODUCED_IN_LLVM_20 = @as(c_int, 1);
pub const _LIBCPP_INTRODUCED_IN_LLVM_20_ATTRIBUTE = "";
pub const _LIBCPP_INTRODUCED_IN_LLVM_19 = @as(c_int, 1);
pub const _LIBCPP_INTRODUCED_IN_LLVM_19_ATTRIBUTE = "";
pub const _LIBCPP_INTRODUCED_IN_LLVM_18 = @as(c_int, 1);
pub const _LIBCPP_INTRODUCED_IN_LLVM_18_ATTRIBUTE = "";
pub const _LIBCPP_INTRODUCED_IN_LLVM_16 = @as(c_int, 1);
pub const _LIBCPP_INTRODUCED_IN_LLVM_16_ATTRIBUTE = "";
pub const _LIBCPP_INTRODUCED_IN_LLVM_15 = @as(c_int, 1);
pub const _LIBCPP_INTRODUCED_IN_LLVM_15_ATTRIBUTE = "";
pub const _LIBCPP_INTRODUCED_IN_LLVM_14 = @as(c_int, 1);
pub const _LIBCPP_INTRODUCED_IN_LLVM_14_ATTRIBUTE = "";
pub const _LIBCPP_INTRODUCED_IN_LLVM_12 = @as(c_int, 1);
pub const _LIBCPP_INTRODUCED_IN_LLVM_12_ATTRIBUTE = "";
pub const _LIBCPP_INTRODUCED_IN_LLVM_11 = @as(c_int, 1);
pub const _LIBCPP_INTRODUCED_IN_LLVM_11_ATTRIBUTE = "";
pub const _LIBCPP_INTRODUCED_IN_LLVM_9 = @as(c_int, 1);
pub const _LIBCPP_INTRODUCED_IN_LLVM_9_ATTRIBUTE = "";
pub const _LIBCPP_INTRODUCED_IN_LLVM_9_ATTRIBUTE_PUSH = "";
pub const _LIBCPP_INTRODUCED_IN_LLVM_9_ATTRIBUTE_POP = "";
pub const _LIBCPP_AVAILABILITY_HAS_FILESYSTEM_LIBRARY = _LIBCPP_INTRODUCED_IN_LLVM_9;
pub const _LIBCPP_AVAILABILITY_FILESYSTEM_LIBRARY = "";
pub const _LIBCPP_AVAILABILITY_FILESYSTEM_LIBRARY_PUSH = "";
pub const _LIBCPP_AVAILABILITY_FILESYSTEM_LIBRARY_POP = "";
pub const _LIBCPP_AVAILABILITY_HAS_SYNC = _LIBCPP_INTRODUCED_IN_LLVM_11;
pub const _LIBCPP_AVAILABILITY_SYNC = "";
pub const _LIBCPP_AVAILABILITY_HAS_ADDITIONAL_IOSTREAM_EXPLICIT_INSTANTIATIONS_1 = @as(c_int, 0);
pub const _LIBCPP_AVAILABILITY_HAS_TO_CHARS_FLOATING_POINT = _LIBCPP_INTRODUCED_IN_LLVM_14;
pub const _LIBCPP_AVAILABILITY_TO_CHARS_FLOATING_POINT = "";
pub const _LIBCPP_AVAILABILITY_HAS_VERBOSE_ABORT = _LIBCPP_INTRODUCED_IN_LLVM_15;
pub const _LIBCPP_AVAILABILITY_VERBOSE_ABORT = "";
pub const _LIBCPP_AVAILABILITY_HAS_PMR = _LIBCPP_INTRODUCED_IN_LLVM_16;
pub const _LIBCPP_AVAILABILITY_PMR = "";
pub const _LIBCPP_AVAILABILITY_HAS_PRINT = _LIBCPP_INTRODUCED_IN_LLVM_18;
pub const _LIBCPP_AVAILABILITY_PRINT = "";
pub const _LIBCPP_AVAILABILITY_HAS_TZDB = _LIBCPP_INTRODUCED_IN_LLVM_19;
pub const _LIBCPP_AVAILABILITY_TZDB = "";
pub const _LIBCPP_AVAILABILITY_HAS_BAD_FUNCTION_CALL_KEY_FUNCTION = _LIBCPP_INTRODUCED_IN_LLVM_19;
pub const _LIBCPP_AVAILABILITY_BAD_FUNCTION_CALL_KEY_FUNCTION = "";
pub const _LIBCPP_AVAILABILITY_HAS_BAD_EXPECTED_ACCESS_KEY_FUNCTION = _LIBCPP_INTRODUCED_IN_LLVM_19;
pub const _LIBCPP_AVAILABILITY_BAD_EXPECTED_ACCESS_KEY_FUNCTION = "";
pub const _LIBCPP_AVAILABILITY_HAS_FROM_CHARS_FLOATING_POINT = _LIBCPP_INTRODUCED_IN_LLVM_20;
pub const _LIBCPP_AVAILABILITY_FROM_CHARS_FLOATING_POINT = "";
pub const _LIBCPP_AVAILABILITY_HAS_HASH_MEMORY = _LIBCPP_INTRODUCED_IN_LLVM_21;
pub const _LIBCPP_AVAILABILITY_HAS_BAD_FUNCTION_CALL_GOOD_WHAT_MESSAGE = _LIBCPP_INTRODUCED_IN_LLVM_21;
pub const _LIBCPP_AVAILABILITY_HAS_INIT_PRIMARY_EXCEPTION = @as(c_int, 0);
pub const _LIBCPP_AVAILABILITY_INIT_PRIMARY_EXCEPTION = "";
pub const _STDLIB_H_ = "";
pub const _LIBC_COUNT__MB_LEN_MAX = _LIBC_UNSAFE_INDEXABLE;
pub const _LIBC_COUNT__PATH_MAX = _LIBC_UNSAFE_INDEXABLE;
pub const __AVAILABILITY__ = "";
pub const __API_TO_BE_DEPRECATED = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_MACOS = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_MACOSAPPLICATIONEXTENSION = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_IOS = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_IOSAPPLICATIONEXTENSION = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_MACCATALYST = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_MACCATALYSTAPPLICATIONEXTENSION = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_WATCHOS = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_WATCHOSAPPLICATIONEXTENSION = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_TVOS = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_TVOSAPPLICATIONEXTENSION = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_DRIVERKIT = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_VISIONOS = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_VISIONOSAPPLICATIONEXTENSION = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __API_TO_BE_DEPRECATED_KERNELKIT = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __AVAILABILITY_VERSIONS__ = "";
pub const __MAC_10_0 = @as(c_int, 1000);
pub const __MAC_10_1 = @as(c_int, 1010);
pub const __MAC_10_2 = @as(c_int, 1020);
pub const __MAC_10_3 = @as(c_int, 1030);
pub const __MAC_10_4 = @as(c_int, 1040);
pub const __MAC_10_5 = @as(c_int, 1050);
pub const __MAC_10_6 = @as(c_int, 1060);
pub const __MAC_10_7 = @as(c_int, 1070);
pub const __MAC_10_8 = @as(c_int, 1080);
pub const __MAC_10_9 = @as(c_int, 1090);
pub const __MAC_10_10 = __helpers.promoteIntLiteral(c_int, 101000, .decimal);
pub const __MAC_10_10_2 = __helpers.promoteIntLiteral(c_int, 101002, .decimal);
pub const __MAC_10_10_3 = __helpers.promoteIntLiteral(c_int, 101003, .decimal);
pub const __MAC_10_11 = __helpers.promoteIntLiteral(c_int, 101100, .decimal);
pub const __MAC_10_11_2 = __helpers.promoteIntLiteral(c_int, 101102, .decimal);
pub const __MAC_10_11_3 = __helpers.promoteIntLiteral(c_int, 101103, .decimal);
pub const __MAC_10_11_4 = __helpers.promoteIntLiteral(c_int, 101104, .decimal);
pub const __MAC_10_12 = __helpers.promoteIntLiteral(c_int, 101200, .decimal);
pub const __MAC_10_12_1 = __helpers.promoteIntLiteral(c_int, 101201, .decimal);
pub const __MAC_10_12_2 = __helpers.promoteIntLiteral(c_int, 101202, .decimal);
pub const __MAC_10_12_4 = __helpers.promoteIntLiteral(c_int, 101204, .decimal);
pub const __MAC_10_13 = __helpers.promoteIntLiteral(c_int, 101300, .decimal);
pub const __MAC_10_13_1 = __helpers.promoteIntLiteral(c_int, 101301, .decimal);
pub const __MAC_10_13_2 = __helpers.promoteIntLiteral(c_int, 101302, .decimal);
pub const __MAC_10_13_4 = __helpers.promoteIntLiteral(c_int, 101304, .decimal);
pub const __MAC_10_14 = __helpers.promoteIntLiteral(c_int, 101400, .decimal);
pub const __MAC_10_14_1 = __helpers.promoteIntLiteral(c_int, 101401, .decimal);
pub const __MAC_10_14_4 = __helpers.promoteIntLiteral(c_int, 101404, .decimal);
pub const __MAC_10_14_5 = __helpers.promoteIntLiteral(c_int, 101405, .decimal);
pub const __MAC_10_14_6 = __helpers.promoteIntLiteral(c_int, 101406, .decimal);
pub const __MAC_10_15 = __helpers.promoteIntLiteral(c_int, 101500, .decimal);
pub const __MAC_10_15_1 = __helpers.promoteIntLiteral(c_int, 101501, .decimal);
pub const __MAC_10_15_4 = __helpers.promoteIntLiteral(c_int, 101504, .decimal);
pub const __MAC_10_16 = __helpers.promoteIntLiteral(c_int, 101600, .decimal);
pub const __MAC_11_0 = __helpers.promoteIntLiteral(c_int, 110000, .decimal);
pub const __MAC_11_1 = __helpers.promoteIntLiteral(c_int, 110100, .decimal);
pub const __MAC_11_3 = __helpers.promoteIntLiteral(c_int, 110300, .decimal);
pub const __MAC_11_4 = __helpers.promoteIntLiteral(c_int, 110400, .decimal);
pub const __MAC_11_5 = __helpers.promoteIntLiteral(c_int, 110500, .decimal);
pub const __MAC_11_6 = __helpers.promoteIntLiteral(c_int, 110600, .decimal);
pub const __MAC_12_0 = __helpers.promoteIntLiteral(c_int, 120000, .decimal);
pub const __MAC_12_1 = __helpers.promoteIntLiteral(c_int, 120100, .decimal);
pub const __MAC_12_2 = __helpers.promoteIntLiteral(c_int, 120200, .decimal);
pub const __MAC_12_3 = __helpers.promoteIntLiteral(c_int, 120300, .decimal);
pub const __MAC_12_4 = __helpers.promoteIntLiteral(c_int, 120400, .decimal);
pub const __MAC_12_5 = __helpers.promoteIntLiteral(c_int, 120500, .decimal);
pub const __MAC_12_6 = __helpers.promoteIntLiteral(c_int, 120600, .decimal);
pub const __MAC_12_7 = __helpers.promoteIntLiteral(c_int, 120700, .decimal);
pub const __MAC_13_0 = __helpers.promoteIntLiteral(c_int, 130000, .decimal);
pub const __MAC_13_1 = __helpers.promoteIntLiteral(c_int, 130100, .decimal);
pub const __MAC_13_2 = __helpers.promoteIntLiteral(c_int, 130200, .decimal);
pub const __MAC_13_3 = __helpers.promoteIntLiteral(c_int, 130300, .decimal);
pub const __MAC_13_4 = __helpers.promoteIntLiteral(c_int, 130400, .decimal);
pub const __MAC_13_5 = __helpers.promoteIntLiteral(c_int, 130500, .decimal);
pub const __MAC_13_6 = __helpers.promoteIntLiteral(c_int, 130600, .decimal);
pub const __MAC_13_7 = __helpers.promoteIntLiteral(c_int, 130700, .decimal);
pub const __MAC_14_0 = __helpers.promoteIntLiteral(c_int, 140000, .decimal);
pub const __MAC_14_1 = __helpers.promoteIntLiteral(c_int, 140100, .decimal);
pub const __MAC_14_2 = __helpers.promoteIntLiteral(c_int, 140200, .decimal);
pub const __MAC_14_3 = __helpers.promoteIntLiteral(c_int, 140300, .decimal);
pub const __MAC_14_4 = __helpers.promoteIntLiteral(c_int, 140400, .decimal);
pub const __MAC_14_5 = __helpers.promoteIntLiteral(c_int, 140500, .decimal);
pub const __MAC_14_6 = __helpers.promoteIntLiteral(c_int, 140600, .decimal);
pub const __MAC_14_7 = __helpers.promoteIntLiteral(c_int, 140700, .decimal);
pub const __MAC_15_0 = __helpers.promoteIntLiteral(c_int, 150000, .decimal);
pub const __MAC_15_1 = __helpers.promoteIntLiteral(c_int, 150100, .decimal);
pub const __MAC_15_2 = __helpers.promoteIntLiteral(c_int, 150200, .decimal);
pub const __MAC_15_3 = __helpers.promoteIntLiteral(c_int, 150300, .decimal);
pub const __MAC_15_4 = __helpers.promoteIntLiteral(c_int, 150400, .decimal);
pub const __MAC_15_5 = __helpers.promoteIntLiteral(c_int, 150500, .decimal);
pub const __MAC_15_6 = __helpers.promoteIntLiteral(c_int, 150600, .decimal);
pub const __MAC_16_0 = __helpers.promoteIntLiteral(c_int, 160000, .decimal);
pub const __MAC_26_0 = __helpers.promoteIntLiteral(c_int, 260000, .decimal);
pub const __MAC_26_1 = __helpers.promoteIntLiteral(c_int, 260100, .decimal);
pub const __MAC_26_2 = __helpers.promoteIntLiteral(c_int, 260200, .decimal);
pub const __MAC_26_3 = __helpers.promoteIntLiteral(c_int, 260300, .decimal);
pub const __MAC_26_4 = __helpers.promoteIntLiteral(c_int, 260400, .decimal);
pub const __IPHONE_2_0 = @as(c_int, 20000);
pub const __IPHONE_2_1 = @as(c_int, 20100);
pub const __IPHONE_2_2 = @as(c_int, 20200);
pub const __IPHONE_3_0 = @as(c_int, 30000);
pub const __IPHONE_3_1 = @as(c_int, 30100);
pub const __IPHONE_3_2 = @as(c_int, 30200);
pub const __IPHONE_4_0 = __helpers.promoteIntLiteral(c_int, 40000, .decimal);
pub const __IPHONE_4_1 = __helpers.promoteIntLiteral(c_int, 40100, .decimal);
pub const __IPHONE_4_2 = __helpers.promoteIntLiteral(c_int, 40200, .decimal);
pub const __IPHONE_4_3 = __helpers.promoteIntLiteral(c_int, 40300, .decimal);
pub const __IPHONE_5_0 = __helpers.promoteIntLiteral(c_int, 50000, .decimal);
pub const __IPHONE_5_1 = __helpers.promoteIntLiteral(c_int, 50100, .decimal);
pub const __IPHONE_6_0 = __helpers.promoteIntLiteral(c_int, 60000, .decimal);
pub const __IPHONE_6_1 = __helpers.promoteIntLiteral(c_int, 60100, .decimal);
pub const __IPHONE_7_0 = __helpers.promoteIntLiteral(c_int, 70000, .decimal);
pub const __IPHONE_7_1 = __helpers.promoteIntLiteral(c_int, 70100, .decimal);
pub const __IPHONE_8_0 = __helpers.promoteIntLiteral(c_int, 80000, .decimal);
pub const __IPHONE_8_1 = __helpers.promoteIntLiteral(c_int, 80100, .decimal);
pub const __IPHONE_8_2 = __helpers.promoteIntLiteral(c_int, 80200, .decimal);
pub const __IPHONE_8_3 = __helpers.promoteIntLiteral(c_int, 80300, .decimal);
pub const __IPHONE_8_4 = __helpers.promoteIntLiteral(c_int, 80400, .decimal);
pub const __IPHONE_9_0 = __helpers.promoteIntLiteral(c_int, 90000, .decimal);
pub const __IPHONE_9_1 = __helpers.promoteIntLiteral(c_int, 90100, .decimal);
pub const __IPHONE_9_2 = __helpers.promoteIntLiteral(c_int, 90200, .decimal);
pub const __IPHONE_9_3 = __helpers.promoteIntLiteral(c_int, 90300, .decimal);
pub const __IPHONE_10_0 = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __IPHONE_10_1 = __helpers.promoteIntLiteral(c_int, 100100, .decimal);
pub const __IPHONE_10_2 = __helpers.promoteIntLiteral(c_int, 100200, .decimal);
pub const __IPHONE_10_3 = __helpers.promoteIntLiteral(c_int, 100300, .decimal);
pub const __IPHONE_11_0 = __helpers.promoteIntLiteral(c_int, 110000, .decimal);
pub const __IPHONE_11_1 = __helpers.promoteIntLiteral(c_int, 110100, .decimal);
pub const __IPHONE_11_2 = __helpers.promoteIntLiteral(c_int, 110200, .decimal);
pub const __IPHONE_11_3 = __helpers.promoteIntLiteral(c_int, 110300, .decimal);
pub const __IPHONE_11_4 = __helpers.promoteIntLiteral(c_int, 110400, .decimal);
pub const __IPHONE_12_0 = __helpers.promoteIntLiteral(c_int, 120000, .decimal);
pub const __IPHONE_12_1 = __helpers.promoteIntLiteral(c_int, 120100, .decimal);
pub const __IPHONE_12_2 = __helpers.promoteIntLiteral(c_int, 120200, .decimal);
pub const __IPHONE_12_3 = __helpers.promoteIntLiteral(c_int, 120300, .decimal);
pub const __IPHONE_12_4 = __helpers.promoteIntLiteral(c_int, 120400, .decimal);
pub const __IPHONE_13_0 = __helpers.promoteIntLiteral(c_int, 130000, .decimal);
pub const __IPHONE_13_1 = __helpers.promoteIntLiteral(c_int, 130100, .decimal);
pub const __IPHONE_13_2 = __helpers.promoteIntLiteral(c_int, 130200, .decimal);
pub const __IPHONE_13_3 = __helpers.promoteIntLiteral(c_int, 130300, .decimal);
pub const __IPHONE_13_4 = __helpers.promoteIntLiteral(c_int, 130400, .decimal);
pub const __IPHONE_13_5 = __helpers.promoteIntLiteral(c_int, 130500, .decimal);
pub const __IPHONE_13_6 = __helpers.promoteIntLiteral(c_int, 130600, .decimal);
pub const __IPHONE_13_7 = __helpers.promoteIntLiteral(c_int, 130700, .decimal);
pub const __IPHONE_14_0 = __helpers.promoteIntLiteral(c_int, 140000, .decimal);
pub const __IPHONE_14_1 = __helpers.promoteIntLiteral(c_int, 140100, .decimal);
pub const __IPHONE_14_2 = __helpers.promoteIntLiteral(c_int, 140200, .decimal);
pub const __IPHONE_14_3 = __helpers.promoteIntLiteral(c_int, 140300, .decimal);
pub const __IPHONE_14_5 = __helpers.promoteIntLiteral(c_int, 140500, .decimal);
pub const __IPHONE_14_6 = __helpers.promoteIntLiteral(c_int, 140600, .decimal);
pub const __IPHONE_14_7 = __helpers.promoteIntLiteral(c_int, 140700, .decimal);
pub const __IPHONE_14_8 = __helpers.promoteIntLiteral(c_int, 140800, .decimal);
pub const __IPHONE_15_0 = __helpers.promoteIntLiteral(c_int, 150000, .decimal);
pub const __IPHONE_15_1 = __helpers.promoteIntLiteral(c_int, 150100, .decimal);
pub const __IPHONE_15_2 = __helpers.promoteIntLiteral(c_int, 150200, .decimal);
pub const __IPHONE_15_3 = __helpers.promoteIntLiteral(c_int, 150300, .decimal);
pub const __IPHONE_15_4 = __helpers.promoteIntLiteral(c_int, 150400, .decimal);
pub const __IPHONE_15_5 = __helpers.promoteIntLiteral(c_int, 150500, .decimal);
pub const __IPHONE_15_6 = __helpers.promoteIntLiteral(c_int, 150600, .decimal);
pub const __IPHONE_15_7 = __helpers.promoteIntLiteral(c_int, 150700, .decimal);
pub const __IPHONE_15_8 = __helpers.promoteIntLiteral(c_int, 150800, .decimal);
pub const __IPHONE_16_0 = __helpers.promoteIntLiteral(c_int, 160000, .decimal);
pub const __IPHONE_16_1 = __helpers.promoteIntLiteral(c_int, 160100, .decimal);
pub const __IPHONE_16_2 = __helpers.promoteIntLiteral(c_int, 160200, .decimal);
pub const __IPHONE_16_3 = __helpers.promoteIntLiteral(c_int, 160300, .decimal);
pub const __IPHONE_16_4 = __helpers.promoteIntLiteral(c_int, 160400, .decimal);
pub const __IPHONE_16_5 = __helpers.promoteIntLiteral(c_int, 160500, .decimal);
pub const __IPHONE_16_6 = __helpers.promoteIntLiteral(c_int, 160600, .decimal);
pub const __IPHONE_16_7 = __helpers.promoteIntLiteral(c_int, 160700, .decimal);
pub const __IPHONE_17_0 = __helpers.promoteIntLiteral(c_int, 170000, .decimal);
pub const __IPHONE_17_1 = __helpers.promoteIntLiteral(c_int, 170100, .decimal);
pub const __IPHONE_17_2 = __helpers.promoteIntLiteral(c_int, 170200, .decimal);
pub const __IPHONE_17_3 = __helpers.promoteIntLiteral(c_int, 170300, .decimal);
pub const __IPHONE_17_4 = __helpers.promoteIntLiteral(c_int, 170400, .decimal);
pub const __IPHONE_17_5 = __helpers.promoteIntLiteral(c_int, 170500, .decimal);
pub const __IPHONE_17_6 = __helpers.promoteIntLiteral(c_int, 170600, .decimal);
pub const __IPHONE_17_7 = __helpers.promoteIntLiteral(c_int, 170700, .decimal);
pub const __IPHONE_18_0 = __helpers.promoteIntLiteral(c_int, 180000, .decimal);
pub const __IPHONE_18_1 = __helpers.promoteIntLiteral(c_int, 180100, .decimal);
pub const __IPHONE_18_2 = __helpers.promoteIntLiteral(c_int, 180200, .decimal);
pub const __IPHONE_18_3 = __helpers.promoteIntLiteral(c_int, 180300, .decimal);
pub const __IPHONE_18_4 = __helpers.promoteIntLiteral(c_int, 180400, .decimal);
pub const __IPHONE_18_5 = __helpers.promoteIntLiteral(c_int, 180500, .decimal);
pub const __IPHONE_18_6 = __helpers.promoteIntLiteral(c_int, 180600, .decimal);
pub const __IPHONE_19_0 = __helpers.promoteIntLiteral(c_int, 190000, .decimal);
pub const __IPHONE_26_0 = __helpers.promoteIntLiteral(c_int, 260000, .decimal);
pub const __IPHONE_26_1 = __helpers.promoteIntLiteral(c_int, 260100, .decimal);
pub const __IPHONE_26_2 = __helpers.promoteIntLiteral(c_int, 260200, .decimal);
pub const __IPHONE_26_3 = __helpers.promoteIntLiteral(c_int, 260300, .decimal);
pub const __IPHONE_26_4 = __helpers.promoteIntLiteral(c_int, 260400, .decimal);
pub const __WATCHOS_1_0 = @as(c_int, 10000);
pub const __WATCHOS_2_0 = @as(c_int, 20000);
pub const __WATCHOS_2_1 = @as(c_int, 20100);
pub const __WATCHOS_2_2 = @as(c_int, 20200);
pub const __WATCHOS_3_0 = @as(c_int, 30000);
pub const __WATCHOS_3_1 = @as(c_int, 30100);
pub const __WATCHOS_3_1_1 = @as(c_int, 30101);
pub const __WATCHOS_3_2 = @as(c_int, 30200);
pub const __WATCHOS_4_0 = __helpers.promoteIntLiteral(c_int, 40000, .decimal);
pub const __WATCHOS_4_1 = __helpers.promoteIntLiteral(c_int, 40100, .decimal);
pub const __WATCHOS_4_2 = __helpers.promoteIntLiteral(c_int, 40200, .decimal);
pub const __WATCHOS_4_3 = __helpers.promoteIntLiteral(c_int, 40300, .decimal);
pub const __WATCHOS_5_0 = __helpers.promoteIntLiteral(c_int, 50000, .decimal);
pub const __WATCHOS_5_1 = __helpers.promoteIntLiteral(c_int, 50100, .decimal);
pub const __WATCHOS_5_2 = __helpers.promoteIntLiteral(c_int, 50200, .decimal);
pub const __WATCHOS_5_3 = __helpers.promoteIntLiteral(c_int, 50300, .decimal);
pub const __WATCHOS_6_0 = __helpers.promoteIntLiteral(c_int, 60000, .decimal);
pub const __WATCHOS_6_1 = __helpers.promoteIntLiteral(c_int, 60100, .decimal);
pub const __WATCHOS_6_2 = __helpers.promoteIntLiteral(c_int, 60200, .decimal);
pub const __WATCHOS_7_0 = __helpers.promoteIntLiteral(c_int, 70000, .decimal);
pub const __WATCHOS_7_1 = __helpers.promoteIntLiteral(c_int, 70100, .decimal);
pub const __WATCHOS_7_2 = __helpers.promoteIntLiteral(c_int, 70200, .decimal);
pub const __WATCHOS_7_3 = __helpers.promoteIntLiteral(c_int, 70300, .decimal);
pub const __WATCHOS_7_4 = __helpers.promoteIntLiteral(c_int, 70400, .decimal);
pub const __WATCHOS_7_5 = __helpers.promoteIntLiteral(c_int, 70500, .decimal);
pub const __WATCHOS_7_6 = __helpers.promoteIntLiteral(c_int, 70600, .decimal);
pub const __WATCHOS_8_0 = __helpers.promoteIntLiteral(c_int, 80000, .decimal);
pub const __WATCHOS_8_1 = __helpers.promoteIntLiteral(c_int, 80100, .decimal);
pub const __WATCHOS_8_3 = __helpers.promoteIntLiteral(c_int, 80300, .decimal);
pub const __WATCHOS_8_4 = __helpers.promoteIntLiteral(c_int, 80400, .decimal);
pub const __WATCHOS_8_5 = __helpers.promoteIntLiteral(c_int, 80500, .decimal);
pub const __WATCHOS_8_6 = __helpers.promoteIntLiteral(c_int, 80600, .decimal);
pub const __WATCHOS_8_7 = __helpers.promoteIntLiteral(c_int, 80700, .decimal);
pub const __WATCHOS_8_8 = __helpers.promoteIntLiteral(c_int, 80800, .decimal);
pub const __WATCHOS_9_0 = __helpers.promoteIntLiteral(c_int, 90000, .decimal);
pub const __WATCHOS_9_1 = __helpers.promoteIntLiteral(c_int, 90100, .decimal);
pub const __WATCHOS_9_2 = __helpers.promoteIntLiteral(c_int, 90200, .decimal);
pub const __WATCHOS_9_3 = __helpers.promoteIntLiteral(c_int, 90300, .decimal);
pub const __WATCHOS_9_4 = __helpers.promoteIntLiteral(c_int, 90400, .decimal);
pub const __WATCHOS_9_5 = __helpers.promoteIntLiteral(c_int, 90500, .decimal);
pub const __WATCHOS_9_6 = __helpers.promoteIntLiteral(c_int, 90600, .decimal);
pub const __WATCHOS_10_0 = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __WATCHOS_10_1 = __helpers.promoteIntLiteral(c_int, 100100, .decimal);
pub const __WATCHOS_10_2 = __helpers.promoteIntLiteral(c_int, 100200, .decimal);
pub const __WATCHOS_10_3 = __helpers.promoteIntLiteral(c_int, 100300, .decimal);
pub const __WATCHOS_10_4 = __helpers.promoteIntLiteral(c_int, 100400, .decimal);
pub const __WATCHOS_10_5 = __helpers.promoteIntLiteral(c_int, 100500, .decimal);
pub const __WATCHOS_10_6 = __helpers.promoteIntLiteral(c_int, 100600, .decimal);
pub const __WATCHOS_10_7 = __helpers.promoteIntLiteral(c_int, 100700, .decimal);
pub const __WATCHOS_11_0 = __helpers.promoteIntLiteral(c_int, 110000, .decimal);
pub const __WATCHOS_11_1 = __helpers.promoteIntLiteral(c_int, 110100, .decimal);
pub const __WATCHOS_11_2 = __helpers.promoteIntLiteral(c_int, 110200, .decimal);
pub const __WATCHOS_11_3 = __helpers.promoteIntLiteral(c_int, 110300, .decimal);
pub const __WATCHOS_11_4 = __helpers.promoteIntLiteral(c_int, 110400, .decimal);
pub const __WATCHOS_11_5 = __helpers.promoteIntLiteral(c_int, 110500, .decimal);
pub const __WATCHOS_11_6 = __helpers.promoteIntLiteral(c_int, 110600, .decimal);
pub const __WATCHOS_12_0 = __helpers.promoteIntLiteral(c_int, 120000, .decimal);
pub const __WATCHOS_26_0 = __helpers.promoteIntLiteral(c_int, 260000, .decimal);
pub const __WATCHOS_26_1 = __helpers.promoteIntLiteral(c_int, 260100, .decimal);
pub const __WATCHOS_26_2 = __helpers.promoteIntLiteral(c_int, 260200, .decimal);
pub const __WATCHOS_26_3 = __helpers.promoteIntLiteral(c_int, 260300, .decimal);
pub const __WATCHOS_26_4 = __helpers.promoteIntLiteral(c_int, 260400, .decimal);
pub const __TVOS_9_0 = __helpers.promoteIntLiteral(c_int, 90000, .decimal);
pub const __TVOS_9_1 = __helpers.promoteIntLiteral(c_int, 90100, .decimal);
pub const __TVOS_9_2 = __helpers.promoteIntLiteral(c_int, 90200, .decimal);
pub const __TVOS_10_0 = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __TVOS_10_0_1 = __helpers.promoteIntLiteral(c_int, 100001, .decimal);
pub const __TVOS_10_1 = __helpers.promoteIntLiteral(c_int, 100100, .decimal);
pub const __TVOS_10_2 = __helpers.promoteIntLiteral(c_int, 100200, .decimal);
pub const __TVOS_11_0 = __helpers.promoteIntLiteral(c_int, 110000, .decimal);
pub const __TVOS_11_1 = __helpers.promoteIntLiteral(c_int, 110100, .decimal);
pub const __TVOS_11_2 = __helpers.promoteIntLiteral(c_int, 110200, .decimal);
pub const __TVOS_11_3 = __helpers.promoteIntLiteral(c_int, 110300, .decimal);
pub const __TVOS_11_4 = __helpers.promoteIntLiteral(c_int, 110400, .decimal);
pub const __TVOS_12_0 = __helpers.promoteIntLiteral(c_int, 120000, .decimal);
pub const __TVOS_12_1 = __helpers.promoteIntLiteral(c_int, 120100, .decimal);
pub const __TVOS_12_2 = __helpers.promoteIntLiteral(c_int, 120200, .decimal);
pub const __TVOS_12_3 = __helpers.promoteIntLiteral(c_int, 120300, .decimal);
pub const __TVOS_12_4 = __helpers.promoteIntLiteral(c_int, 120400, .decimal);
pub const __TVOS_13_0 = __helpers.promoteIntLiteral(c_int, 130000, .decimal);
pub const __TVOS_13_2 = __helpers.promoteIntLiteral(c_int, 130200, .decimal);
pub const __TVOS_13_3 = __helpers.promoteIntLiteral(c_int, 130300, .decimal);
pub const __TVOS_13_4 = __helpers.promoteIntLiteral(c_int, 130400, .decimal);
pub const __TVOS_14_0 = __helpers.promoteIntLiteral(c_int, 140000, .decimal);
pub const __TVOS_14_1 = __helpers.promoteIntLiteral(c_int, 140100, .decimal);
pub const __TVOS_14_2 = __helpers.promoteIntLiteral(c_int, 140200, .decimal);
pub const __TVOS_14_3 = __helpers.promoteIntLiteral(c_int, 140300, .decimal);
pub const __TVOS_14_5 = __helpers.promoteIntLiteral(c_int, 140500, .decimal);
pub const __TVOS_14_6 = __helpers.promoteIntLiteral(c_int, 140600, .decimal);
pub const __TVOS_14_7 = __helpers.promoteIntLiteral(c_int, 140700, .decimal);
pub const __TVOS_15_0 = __helpers.promoteIntLiteral(c_int, 150000, .decimal);
pub const __TVOS_15_1 = __helpers.promoteIntLiteral(c_int, 150100, .decimal);
pub const __TVOS_15_2 = __helpers.promoteIntLiteral(c_int, 150200, .decimal);
pub const __TVOS_15_3 = __helpers.promoteIntLiteral(c_int, 150300, .decimal);
pub const __TVOS_15_4 = __helpers.promoteIntLiteral(c_int, 150400, .decimal);
pub const __TVOS_15_5 = __helpers.promoteIntLiteral(c_int, 150500, .decimal);
pub const __TVOS_15_6 = __helpers.promoteIntLiteral(c_int, 150600, .decimal);
pub const __TVOS_16_0 = __helpers.promoteIntLiteral(c_int, 160000, .decimal);
pub const __TVOS_16_1 = __helpers.promoteIntLiteral(c_int, 160100, .decimal);
pub const __TVOS_16_2 = __helpers.promoteIntLiteral(c_int, 160200, .decimal);
pub const __TVOS_16_3 = __helpers.promoteIntLiteral(c_int, 160300, .decimal);
pub const __TVOS_16_4 = __helpers.promoteIntLiteral(c_int, 160400, .decimal);
pub const __TVOS_16_5 = __helpers.promoteIntLiteral(c_int, 160500, .decimal);
pub const __TVOS_16_6 = __helpers.promoteIntLiteral(c_int, 160600, .decimal);
pub const __TVOS_17_0 = __helpers.promoteIntLiteral(c_int, 170000, .decimal);
pub const __TVOS_17_1 = __helpers.promoteIntLiteral(c_int, 170100, .decimal);
pub const __TVOS_17_2 = __helpers.promoteIntLiteral(c_int, 170200, .decimal);
pub const __TVOS_17_3 = __helpers.promoteIntLiteral(c_int, 170300, .decimal);
pub const __TVOS_17_4 = __helpers.promoteIntLiteral(c_int, 170400, .decimal);
pub const __TVOS_17_5 = __helpers.promoteIntLiteral(c_int, 170500, .decimal);
pub const __TVOS_17_6 = __helpers.promoteIntLiteral(c_int, 170600, .decimal);
pub const __TVOS_18_0 = __helpers.promoteIntLiteral(c_int, 180000, .decimal);
pub const __TVOS_18_1 = __helpers.promoteIntLiteral(c_int, 180100, .decimal);
pub const __TVOS_18_2 = __helpers.promoteIntLiteral(c_int, 180200, .decimal);
pub const __TVOS_18_3 = __helpers.promoteIntLiteral(c_int, 180300, .decimal);
pub const __TVOS_18_4 = __helpers.promoteIntLiteral(c_int, 180400, .decimal);
pub const __TVOS_18_5 = __helpers.promoteIntLiteral(c_int, 180500, .decimal);
pub const __TVOS_18_6 = __helpers.promoteIntLiteral(c_int, 180600, .decimal);
pub const __TVOS_19_0 = __helpers.promoteIntLiteral(c_int, 190000, .decimal);
pub const __TVOS_26_0 = __helpers.promoteIntLiteral(c_int, 260000, .decimal);
pub const __TVOS_26_1 = __helpers.promoteIntLiteral(c_int, 260100, .decimal);
pub const __TVOS_26_2 = __helpers.promoteIntLiteral(c_int, 260200, .decimal);
pub const __TVOS_26_3 = __helpers.promoteIntLiteral(c_int, 260300, .decimal);
pub const __TVOS_26_4 = __helpers.promoteIntLiteral(c_int, 260400, .decimal);
pub const __BRIDGEOS_2_0 = @as(c_int, 20000);
pub const __BRIDGEOS_3_0 = @as(c_int, 30000);
pub const __BRIDGEOS_3_1 = @as(c_int, 30100);
pub const __BRIDGEOS_3_4 = @as(c_int, 30400);
pub const __BRIDGEOS_4_0 = __helpers.promoteIntLiteral(c_int, 40000, .decimal);
pub const __BRIDGEOS_4_1 = __helpers.promoteIntLiteral(c_int, 40100, .decimal);
pub const __BRIDGEOS_5_0 = __helpers.promoteIntLiteral(c_int, 50000, .decimal);
pub const __BRIDGEOS_5_1 = __helpers.promoteIntLiteral(c_int, 50100, .decimal);
pub const __BRIDGEOS_5_3 = __helpers.promoteIntLiteral(c_int, 50300, .decimal);
pub const __BRIDGEOS_6_0 = __helpers.promoteIntLiteral(c_int, 60000, .decimal);
pub const __BRIDGEOS_6_2 = __helpers.promoteIntLiteral(c_int, 60200, .decimal);
pub const __BRIDGEOS_6_4 = __helpers.promoteIntLiteral(c_int, 60400, .decimal);
pub const __BRIDGEOS_6_5 = __helpers.promoteIntLiteral(c_int, 60500, .decimal);
pub const __BRIDGEOS_6_6 = __helpers.promoteIntLiteral(c_int, 60600, .decimal);
pub const __BRIDGEOS_7_0 = __helpers.promoteIntLiteral(c_int, 70000, .decimal);
pub const __BRIDGEOS_7_1 = __helpers.promoteIntLiteral(c_int, 70100, .decimal);
pub const __BRIDGEOS_7_2 = __helpers.promoteIntLiteral(c_int, 70200, .decimal);
pub const __BRIDGEOS_7_3 = __helpers.promoteIntLiteral(c_int, 70300, .decimal);
pub const __BRIDGEOS_7_4 = __helpers.promoteIntLiteral(c_int, 70400, .decimal);
pub const __BRIDGEOS_7_6 = __helpers.promoteIntLiteral(c_int, 70600, .decimal);
pub const __BRIDGEOS_8_0 = __helpers.promoteIntLiteral(c_int, 80000, .decimal);
pub const __BRIDGEOS_8_1 = __helpers.promoteIntLiteral(c_int, 80100, .decimal);
pub const __BRIDGEOS_8_2 = __helpers.promoteIntLiteral(c_int, 80200, .decimal);
pub const __BRIDGEOS_8_3 = __helpers.promoteIntLiteral(c_int, 80300, .decimal);
pub const __BRIDGEOS_8_4 = __helpers.promoteIntLiteral(c_int, 80400, .decimal);
pub const __BRIDGEOS_8_5 = __helpers.promoteIntLiteral(c_int, 80500, .decimal);
pub const __BRIDGEOS_8_6 = __helpers.promoteIntLiteral(c_int, 80600, .decimal);
pub const __BRIDGEOS_9_0 = __helpers.promoteIntLiteral(c_int, 90000, .decimal);
pub const __BRIDGEOS_9_1 = __helpers.promoteIntLiteral(c_int, 90100, .decimal);
pub const __BRIDGEOS_9_2 = __helpers.promoteIntLiteral(c_int, 90200, .decimal);
pub const __BRIDGEOS_9_3 = __helpers.promoteIntLiteral(c_int, 90300, .decimal);
pub const __BRIDGEOS_9_4 = __helpers.promoteIntLiteral(c_int, 90400, .decimal);
pub const __BRIDGEOS_9_5 = __helpers.promoteIntLiteral(c_int, 90500, .decimal);
pub const __BRIDGEOS_9_6 = __helpers.promoteIntLiteral(c_int, 90600, .decimal);
pub const __BRIDGEOS_10_0 = __helpers.promoteIntLiteral(c_int, 100000, .decimal);
pub const __BRIDGEOS_10_1 = __helpers.promoteIntLiteral(c_int, 100100, .decimal);
pub const __BRIDGEOS_10_2 = __helpers.promoteIntLiteral(c_int, 100200, .decimal);
pub const __BRIDGEOS_10_3 = __helpers.promoteIntLiteral(c_int, 100300, .decimal);
pub const __BRIDGEOS_10_4 = __helpers.promoteIntLiteral(c_int, 100400, .decimal);
pub const __DRIVERKIT_19_0 = __helpers.promoteIntLiteral(c_int, 190000, .decimal);
pub const __DRIVERKIT_20_0 = __helpers.promoteIntLiteral(c_int, 200000, .decimal);
pub const __DRIVERKIT_21_0 = __helpers.promoteIntLiteral(c_int, 210000, .decimal);
pub const __DRIVERKIT_22_0 = __helpers.promoteIntLiteral(c_int, 220000, .decimal);
pub const __DRIVERKIT_22_4 = __helpers.promoteIntLiteral(c_int, 220400, .decimal);
pub const __DRIVERKIT_22_5 = __helpers.promoteIntLiteral(c_int, 220500, .decimal);
pub const __DRIVERKIT_22_6 = __helpers.promoteIntLiteral(c_int, 220600, .decimal);
pub const __DRIVERKIT_23_0 = __helpers.promoteIntLiteral(c_int, 230000, .decimal);
pub const __DRIVERKIT_23_1 = __helpers.promoteIntLiteral(c_int, 230100, .decimal);
pub const __DRIVERKIT_23_2 = __helpers.promoteIntLiteral(c_int, 230200, .decimal);
pub const __DRIVERKIT_23_3 = __helpers.promoteIntLiteral(c_int, 230300, .decimal);
pub const __DRIVERKIT_23_4 = __helpers.promoteIntLiteral(c_int, 230400, .decimal);
pub const __DRIVERKIT_23_5 = __helpers.promoteIntLiteral(c_int, 230500, .decimal);
pub const __DRIVERKIT_23_6 = __helpers.promoteIntLiteral(c_int, 230600, .decimal);
pub const __DRIVERKIT_24_0 = __helpers.promoteIntLiteral(c_int, 240000, .decimal);
pub const __DRIVERKIT_24_1 = __helpers.promoteIntLiteral(c_int, 240100, .decimal);
pub const __DRIVERKIT_24_2 = __helpers.promoteIntLiteral(c_int, 240200, .decimal);
pub const __DRIVERKIT_24_3 = __helpers.promoteIntLiteral(c_int, 240300, .decimal);
pub const __DRIVERKIT_24_4 = __helpers.promoteIntLiteral(c_int, 240400, .decimal);
pub const __DRIVERKIT_24_5 = __helpers.promoteIntLiteral(c_int, 240500, .decimal);
pub const __DRIVERKIT_24_6 = __helpers.promoteIntLiteral(c_int, 240600, .decimal);
pub const __DRIVERKIT_25_0 = __helpers.promoteIntLiteral(c_int, 250000, .decimal);
pub const __DRIVERKIT_25_1 = __helpers.promoteIntLiteral(c_int, 250100, .decimal);
pub const __DRIVERKIT_25_2 = __helpers.promoteIntLiteral(c_int, 250200, .decimal);
pub const __DRIVERKIT_25_3 = __helpers.promoteIntLiteral(c_int, 250300, .decimal);
pub const __DRIVERKIT_25_4 = __helpers.promoteIntLiteral(c_int, 250400, .decimal);
pub const __VISIONOS_1_0 = @as(c_int, 10000);
pub const __VISIONOS_1_1 = @as(c_int, 10100);
pub const __VISIONOS_1_2 = @as(c_int, 10200);
pub const __VISIONOS_1_3 = @as(c_int, 10300);
pub const __VISIONOS_2_0 = @as(c_int, 20000);
pub const __VISIONOS_2_1 = @as(c_int, 20100);
pub const __VISIONOS_2_2 = @as(c_int, 20200);
pub const __VISIONOS_2_3 = @as(c_int, 20300);
pub const __VISIONOS_2_4 = @as(c_int, 20400);
pub const __VISIONOS_2_5 = @as(c_int, 20500);
pub const __VISIONOS_2_6 = @as(c_int, 20600);
pub const __VISIONOS_3_0 = @as(c_int, 30000);
pub const __VISIONOS_26_0 = __helpers.promoteIntLiteral(c_int, 260000, .decimal);
pub const __VISIONOS_26_1 = __helpers.promoteIntLiteral(c_int, 260100, .decimal);
pub const __VISIONOS_26_2 = __helpers.promoteIntLiteral(c_int, 260200, .decimal);
pub const __VISIONOS_26_3 = __helpers.promoteIntLiteral(c_int, 260300, .decimal);
pub const __VISIONOS_26_4 = __helpers.promoteIntLiteral(c_int, 260400, .decimal);
pub const MAC_OS_X_VERSION_10_0 = __MAC_10_0;
pub const MAC_OS_X_VERSION_10_1 = __MAC_10_1;
pub const MAC_OS_X_VERSION_10_2 = __MAC_10_2;
pub const MAC_OS_X_VERSION_10_3 = __MAC_10_3;
pub const MAC_OS_X_VERSION_10_4 = __MAC_10_4;
pub const MAC_OS_X_VERSION_10_5 = __MAC_10_5;
pub const MAC_OS_X_VERSION_10_6 = __MAC_10_6;
pub const MAC_OS_X_VERSION_10_7 = __MAC_10_7;
pub const MAC_OS_X_VERSION_10_8 = __MAC_10_8;
pub const MAC_OS_X_VERSION_10_9 = __MAC_10_9;
pub const MAC_OS_X_VERSION_10_10 = __MAC_10_10;
pub const MAC_OS_X_VERSION_10_10_2 = __MAC_10_10_2;
pub const MAC_OS_X_VERSION_10_10_3 = __MAC_10_10_3;
pub const MAC_OS_X_VERSION_10_11 = __MAC_10_11;
pub const MAC_OS_X_VERSION_10_11_2 = __MAC_10_11_2;
pub const MAC_OS_X_VERSION_10_11_3 = __MAC_10_11_3;
pub const MAC_OS_X_VERSION_10_11_4 = __MAC_10_11_4;
pub const MAC_OS_X_VERSION_10_12 = __MAC_10_12;
pub const MAC_OS_X_VERSION_10_12_1 = __MAC_10_12_1;
pub const MAC_OS_X_VERSION_10_12_2 = __MAC_10_12_2;
pub const MAC_OS_X_VERSION_10_12_4 = __MAC_10_12_4;
pub const MAC_OS_X_VERSION_10_13 = __MAC_10_13;
pub const MAC_OS_X_VERSION_10_13_1 = __MAC_10_13_1;
pub const MAC_OS_X_VERSION_10_13_2 = __MAC_10_13_2;
pub const MAC_OS_X_VERSION_10_13_4 = __MAC_10_13_4;
pub const MAC_OS_X_VERSION_10_14 = __MAC_10_14;
pub const MAC_OS_X_VERSION_10_14_1 = __MAC_10_14_1;
pub const MAC_OS_X_VERSION_10_14_4 = __MAC_10_14_4;
pub const MAC_OS_X_VERSION_10_14_5 = __MAC_10_14_5;
pub const MAC_OS_X_VERSION_10_14_6 = __MAC_10_14_6;
pub const MAC_OS_X_VERSION_10_15 = __MAC_10_15;
pub const MAC_OS_X_VERSION_10_15_1 = __MAC_10_15_1;
pub const MAC_OS_X_VERSION_10_15_4 = __MAC_10_15_4;
pub const MAC_OS_X_VERSION_10_16 = __MAC_10_16;
pub const MAC_OS_VERSION_11_0 = __MAC_11_0;
pub const MAC_OS_VERSION_11_1 = __MAC_11_1;
pub const MAC_OS_VERSION_11_3 = __MAC_11_3;
pub const MAC_OS_VERSION_11_4 = __MAC_11_4;
pub const MAC_OS_VERSION_11_5 = __MAC_11_5;
pub const MAC_OS_VERSION_11_6 = __MAC_11_6;
pub const MAC_OS_VERSION_12_0 = __MAC_12_0;
pub const MAC_OS_VERSION_12_1 = __MAC_12_1;
pub const MAC_OS_VERSION_12_2 = __MAC_12_2;
pub const MAC_OS_VERSION_12_3 = __MAC_12_3;
pub const MAC_OS_VERSION_12_4 = __MAC_12_4;
pub const MAC_OS_VERSION_12_5 = __MAC_12_5;
pub const MAC_OS_VERSION_12_6 = __MAC_12_6;
pub const MAC_OS_VERSION_12_7 = __MAC_12_7;
pub const MAC_OS_VERSION_13_0 = __MAC_13_0;
pub const MAC_OS_VERSION_13_1 = __MAC_13_1;
pub const MAC_OS_VERSION_13_2 = __MAC_13_2;
pub const MAC_OS_VERSION_13_3 = __MAC_13_3;
pub const MAC_OS_VERSION_13_4 = __MAC_13_4;
pub const MAC_OS_VERSION_13_5 = __MAC_13_5;
pub const MAC_OS_VERSION_13_6 = __MAC_13_6;
pub const MAC_OS_VERSION_13_7 = __MAC_13_7;
pub const MAC_OS_VERSION_14_0 = __MAC_14_0;
pub const MAC_OS_VERSION_14_1 = __MAC_14_1;
pub const MAC_OS_VERSION_14_2 = __MAC_14_2;
pub const MAC_OS_VERSION_14_3 = __MAC_14_3;
pub const MAC_OS_VERSION_14_4 = __MAC_14_4;
pub const MAC_OS_VERSION_14_5 = __MAC_14_5;
pub const MAC_OS_VERSION_14_6 = __MAC_14_6;
pub const MAC_OS_VERSION_14_7 = __MAC_14_7;
pub const MAC_OS_VERSION_15_0 = __MAC_15_0;
pub const MAC_OS_VERSION_15_1 = __MAC_15_1;
pub const MAC_OS_VERSION_15_2 = __MAC_15_2;
pub const MAC_OS_VERSION_15_3 = __MAC_15_3;
pub const MAC_OS_VERSION_15_4 = __MAC_15_4;
pub const MAC_OS_VERSION_15_5 = __MAC_15_5;
pub const MAC_OS_VERSION_15_6 = __MAC_15_6;
pub const MAC_OS_VERSION_16_0 = __MAC_16_0;
pub const MAC_OS_VERSION_26_0 = __MAC_26_0;
pub const MAC_OS_VERSION_26_1 = __MAC_26_1;
pub const MAC_OS_VERSION_26_2 = __MAC_26_2;
pub const MAC_OS_VERSION_26_3 = __MAC_26_3;
pub const MAC_OS_VERSION_26_4 = __MAC_26_4;
pub const __AVAILABILITY_VERSIONS_VERSION_HASH = __helpers.promoteIntLiteral(c_uint, 93585900, .decimal);
pub const __AVAILABILITY_VERSIONS_VERSION_STRING = "Local";
pub const __AVAILABILITY_FILE = "AvailabilityVersions.h";
pub const __AVAILABILITY_INTERNAL__ = "";
pub const __MAC_OS_X_VERSION_MIN_REQUIRED = __ENVIRONMENT_OS_VERSION_MIN_REQUIRED__;
pub const __MAC_OS_X_VERSION_MAX_ALLOWED = __MAC_26_4;
pub const __IPHONE_OS_VERSION_MIN_REQUIRED = __IPHONE_17_1;
pub const __IPHONE_OS_VERSION_MAX_ALLOWED = __IPHONE_26_4;
pub const __WATCH_OS_VERSION_MIN_REQUIRED = __ENVIRONMENT_OS_VERSION_MIN_REQUIRED__;
pub const __WATCH_OS_VERSION_MAX_ALLOWED = __WATCHOS_26_4;
pub const __TV_OS_VERSION_MIN_REQUIRED = __ENVIRONMENT_OS_VERSION_MIN_REQUIRED__;
pub const __TV_OS_VERSION_MAX_ALLOWED = __TVOS_26_4;
pub const __DRIVERKIT_VERSION_MIN_REQUIRED = __ENVIRONMENT_OS_VERSION_MIN_REQUIRED__;
pub const __DRIVERKIT_VERSION_MAX_ALLOWED = __DRIVERKIT_25_4;
pub const __VISION_OS_VERSION_MIN_REQUIRED = __ENVIRONMENT_OS_VERSION_MIN_REQUIRED__;
pub const __VISION_OS_VERSION_MAX_ALLOWED = __VISIONOS_26_4;
pub const __AVAILABILITY_INTERNAL_DEPRECATED = @compileError("unable to translate macro: undefined identifier `deprecated`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:142:9
pub const __AVAILABILITY_INTERNAL_DEPRECATED_MSG = @compileError("unable to translate macro: undefined identifier `deprecated`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:145:17
pub const __AVAILABILITY_INTERNAL_UNAVAILABLE = @compileError("unable to translate macro: undefined identifier `unavailable`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:154:9
pub const __AVAILABILITY_INTERNAL_WEAK_IMPORT = @compileError("unable to translate macro: undefined identifier `weak_import`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:155:9
pub const __AVAILABILITY_INTERNAL_REGULAR = "";
pub const __API_AVAILABLE_PLATFORM_macos = @compileError("unable to translate macro: undefined identifier `macos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:160:12
pub const __API_DEPRECATED_PLATFORM_macos = @compileError("unable to translate macro: undefined identifier `macos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:161:12
pub const __API_OBSOLETED_PLATFORM_macos = @compileError("unable to translate macro: undefined identifier `macos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:162:12
pub const __API_UNAVAILABLE_PLATFORM_macos = @compileError("unable to translate macro: undefined identifier `macos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:163:12
pub const __API_AVAILABLE_PLATFORM_macosx = @compileError("unable to translate macro: undefined identifier `macos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:164:12
pub const __API_DEPRECATED_PLATFORM_macosx = @compileError("unable to translate macro: undefined identifier `macos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:165:12
pub const __API_OBSOLETED_PLATFORM_macosx = @compileError("unable to translate macro: undefined identifier `macos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:166:12
pub const __API_UNAVAILABLE_PLATFORM_macosx = @compileError("unable to translate macro: undefined identifier `macos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:167:12
pub const __API_AVAILABLE_PLATFORM_macOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `macOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:168:12
pub const __API_DEPRECATED_PLATFORM_macOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `macOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:169:12
pub const __API_OBSOLETED_PLATFORM_macOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `macOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:170:12
pub const __API_UNAVAILABLE_PLATFORM_macOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `macOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:171:12
pub const __API_AVAILABLE_PLATFORM_ios = @compileError("unable to translate macro: undefined identifier `ios`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:172:12
pub const __API_DEPRECATED_PLATFORM_ios = @compileError("unable to translate macro: undefined identifier `ios`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:173:12
pub const __API_OBSOLETED_PLATFORM_ios = @compileError("unable to translate macro: undefined identifier `ios`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:174:12
pub const __API_UNAVAILABLE_PLATFORM_ios = @compileError("unable to translate macro: undefined identifier `ios`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:175:12
pub const __API_AVAILABLE_PLATFORM_iOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `iOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:176:12
pub const __API_DEPRECATED_PLATFORM_iOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `iOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:177:12
pub const __API_OBSOLETED_PLATFORM_iOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `iOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:178:12
pub const __API_UNAVAILABLE_PLATFORM_iOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `iOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:179:12
pub const __API_AVAILABLE_PLATFORM_macCatalyst = @compileError("unable to translate macro: undefined identifier `macCatalyst`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:180:12
pub const __API_DEPRECATED_PLATFORM_macCatalyst = @compileError("unable to translate macro: undefined identifier `macCatalyst`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:181:12
pub const __API_OBSOLETED_PLATFORM_macCatalyst = @compileError("unable to translate macro: undefined identifier `macCatalyst`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:182:12
pub const __API_UNAVAILABLE_PLATFORM_macCatalyst = @compileError("unable to translate macro: undefined identifier `macCatalyst`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:183:12
pub const __API_AVAILABLE_PLATFORM_macCatalystApplicationExtension = @compileError("unable to translate macro: undefined identifier `macCatalystApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:184:12
pub const __API_DEPRECATED_PLATFORM_macCatalystApplicationExtension = @compileError("unable to translate macro: undefined identifier `macCatalystApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:185:12
pub const __API_OBSOLETED_PLATFORM_macCatalystApplicationExtension = @compileError("unable to translate macro: undefined identifier `macCatalystApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:186:12
pub const __API_UNAVAILABLE_PLATFORM_macCatalystApplicationExtension = @compileError("unable to translate macro: undefined identifier `macCatalystApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:187:12
pub const __API_AVAILABLE_PLATFORM_watchos = @compileError("unable to translate macro: undefined identifier `watchos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:188:12
pub const __API_DEPRECATED_PLATFORM_watchos = @compileError("unable to translate macro: undefined identifier `watchos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:189:12
pub const __API_OBSOLETED_PLATFORM_watchos = @compileError("unable to translate macro: undefined identifier `watchos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:190:12
pub const __API_UNAVAILABLE_PLATFORM_watchos = @compileError("unable to translate macro: undefined identifier `watchos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:191:12
pub const __API_AVAILABLE_PLATFORM_watchOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `watchOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:192:12
pub const __API_DEPRECATED_PLATFORM_watchOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `watchOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:193:12
pub const __API_OBSOLETED_PLATFORM_watchOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `watchOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:194:12
pub const __API_UNAVAILABLE_PLATFORM_watchOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `watchOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:195:12
pub const __API_AVAILABLE_PLATFORM_tvos = @compileError("unable to translate macro: undefined identifier `tvos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:196:12
pub const __API_DEPRECATED_PLATFORM_tvos = @compileError("unable to translate macro: undefined identifier `tvos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:197:12
pub const __API_OBSOLETED_PLATFORM_tvos = @compileError("unable to translate macro: undefined identifier `tvos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:198:12
pub const __API_UNAVAILABLE_PLATFORM_tvos = @compileError("unable to translate macro: undefined identifier `tvos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:199:12
pub const __API_AVAILABLE_PLATFORM_tvOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `tvOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:200:12
pub const __API_DEPRECATED_PLATFORM_tvOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `tvOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:201:12
pub const __API_OBSOLETED_PLATFORM_tvOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `tvOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:202:12
pub const __API_UNAVAILABLE_PLATFORM_tvOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `tvOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:203:12
pub const __API_AVAILABLE_PLATFORM_driverkit = @compileError("unable to translate macro: undefined identifier `driverkit`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:205:12
pub const __API_DEPRECATED_PLATFORM_driverkit = @compileError("unable to translate macro: undefined identifier `driverkit`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:206:12
pub const __API_OBSOLETED_PLATFORM_driverkit = @compileError("unable to translate macro: undefined identifier `driverkit`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:207:12
pub const __API_UNAVAILABLE_PLATFORM_driverkit = @compileError("unable to translate macro: undefined identifier `driverkit`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:208:12
pub const __API_AVAILABLE_PLATFORM_visionos = @compileError("unable to translate macro: undefined identifier `visionos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:209:12
pub const __API_DEPRECATED_PLATFORM_visionos = @compileError("unable to translate macro: undefined identifier `visionos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:210:12
pub const __API_OBSOLETED_PLATFORM_visionos = @compileError("unable to translate macro: undefined identifier `visionos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:211:12
pub const __API_UNAVAILABLE_PLATFORM_visionos = @compileError("unable to translate macro: undefined identifier `visionos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:212:12
pub const __API_AVAILABLE_PLATFORM_visionOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `visionOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:213:12
pub const __API_DEPRECATED_PLATFORM_visionOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `visionOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:214:12
pub const __API_OBSOLETED_PLATFORM_visionOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `visionOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:215:12
pub const __API_UNAVAILABLE_PLATFORM_visionOSApplicationExtension = @compileError("unable to translate macro: undefined identifier `visionOSApplicationExtension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:216:12
pub const __API_UNAVAILABLE_PLATFORM_kernelkit = @compileError("unable to translate macro: undefined identifier `kernelkit`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:218:12
pub const __API_APPLY_TO = @compileError("unable to translate macro: undefined identifier `any`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:228:11
pub inline fn __API_RANGE_STRINGIFY(x: anytype) @TypeOf(__API_RANGE_STRINGIFY2(x)) {
    _ = &x;
    return __API_RANGE_STRINGIFY2(x);
}
pub const __API_RANGE_STRINGIFY2 = @compileError("unable to translate C expr: unexpected token ''"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:230:11
pub const __API_A = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:244:13
pub inline fn __API_AVAILABLE0(arg0: anytype) @TypeOf(__API_A(arg0)) {
    _ = &arg0;
    return __API_A(arg0);
}
pub inline fn __API_AVAILABLE1(arg0: anytype, arg1: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1)) {
    _ = &arg0;
    _ = &arg1;
    return __API_A(arg0) ++ __API_A(arg1);
}
pub inline fn __API_AVAILABLE2(arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2);
}
pub inline fn __API_AVAILABLE3(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3);
}
pub inline fn __API_AVAILABLE4(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4);
}
pub inline fn __API_AVAILABLE5(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5);
}
pub inline fn __API_AVAILABLE6(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6);
}
pub inline fn __API_AVAILABLE7(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7);
}
pub inline fn __API_AVAILABLE8(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8);
}
pub inline fn __API_AVAILABLE9(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9);
}
pub inline fn __API_AVAILABLE10(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10);
}
pub inline fn __API_AVAILABLE11(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11);
}
pub inline fn __API_AVAILABLE12(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11) ++ __API_A(arg12)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11) ++ __API_A(arg12);
}
pub inline fn __API_AVAILABLE13(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11) ++ __API_A(arg12) ++ __API_A(arg13)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11) ++ __API_A(arg12) ++ __API_A(arg13);
}
pub inline fn __API_AVAILABLE14(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11) ++ __API_A(arg12) ++ __API_A(arg13) ++ __API_A(arg14)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11) ++ __API_A(arg12) ++ __API_A(arg13) ++ __API_A(arg14);
}
pub inline fn __API_AVAILABLE15(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11) ++ __API_A(arg12) ++ __API_A(arg13) ++ __API_A(arg14) ++ __API_A(arg15)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_A(arg0) ++ __API_A(arg1) ++ __API_A(arg2) ++ __API_A(arg3) ++ __API_A(arg4) ++ __API_A(arg5) ++ __API_A(arg6) ++ __API_A(arg7) ++ __API_A(arg8) ++ __API_A(arg9) ++ __API_A(arg10) ++ __API_A(arg11) ++ __API_A(arg12) ++ __API_A(arg13) ++ __API_A(arg14) ++ __API_A(arg15);
}
pub inline fn __API_AVAILABLE_GET_MACRO_93585900(_0: anytype, _1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, NAME: anytype) @TypeOf(NAME) {
    _ = &_0;
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &NAME;
    return NAME;
}
pub const __API_A_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:264:13
pub inline fn __API_AVAILABLE_BEGIN0(arg0: anytype) @TypeOf(__API_A_BEGIN(arg0)) {
    _ = &arg0;
    return __API_A_BEGIN(arg0);
}
pub inline fn __API_AVAILABLE_BEGIN1(arg0: anytype, arg1: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1)) {
    _ = &arg0;
    _ = &arg1;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1);
}
pub inline fn __API_AVAILABLE_BEGIN2(arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2);
}
pub inline fn __API_AVAILABLE_BEGIN3(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3);
}
pub inline fn __API_AVAILABLE_BEGIN4(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4);
}
pub inline fn __API_AVAILABLE_BEGIN5(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5);
}
pub inline fn __API_AVAILABLE_BEGIN6(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6);
}
pub inline fn __API_AVAILABLE_BEGIN7(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7);
}
pub inline fn __API_AVAILABLE_BEGIN8(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8);
}
pub inline fn __API_AVAILABLE_BEGIN9(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9);
}
pub inline fn __API_AVAILABLE_BEGIN10(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10);
}
pub inline fn __API_AVAILABLE_BEGIN11(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11);
}
pub inline fn __API_AVAILABLE_BEGIN12(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11) ++ __API_A_BEGIN(arg12)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11) ++ __API_A_BEGIN(arg12);
}
pub inline fn __API_AVAILABLE_BEGIN13(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11) ++ __API_A_BEGIN(arg12) ++ __API_A_BEGIN(arg13)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11) ++ __API_A_BEGIN(arg12) ++ __API_A_BEGIN(arg13);
}
pub inline fn __API_AVAILABLE_BEGIN14(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11) ++ __API_A_BEGIN(arg12) ++ __API_A_BEGIN(arg13) ++ __API_A_BEGIN(arg14)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11) ++ __API_A_BEGIN(arg12) ++ __API_A_BEGIN(arg13) ++ __API_A_BEGIN(arg14);
}
pub inline fn __API_AVAILABLE_BEGIN15(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11) ++ __API_A_BEGIN(arg12) ++ __API_A_BEGIN(arg13) ++ __API_A_BEGIN(arg14) ++ __API_A_BEGIN(arg15)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_A_BEGIN(arg0) ++ __API_A_BEGIN(arg1) ++ __API_A_BEGIN(arg2) ++ __API_A_BEGIN(arg3) ++ __API_A_BEGIN(arg4) ++ __API_A_BEGIN(arg5) ++ __API_A_BEGIN(arg6) ++ __API_A_BEGIN(arg7) ++ __API_A_BEGIN(arg8) ++ __API_A_BEGIN(arg9) ++ __API_A_BEGIN(arg10) ++ __API_A_BEGIN(arg11) ++ __API_A_BEGIN(arg12) ++ __API_A_BEGIN(arg13) ++ __API_A_BEGIN(arg14) ++ __API_A_BEGIN(arg15);
}
pub inline fn __API_AVAILABLE_BEGIN_GET_MACRO_93585900(_0: anytype, _1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, NAME: anytype) @TypeOf(NAME) {
    _ = &_0;
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &NAME;
    return NAME;
}
pub const __API_D = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:286:13
pub inline fn __API_DEPRECATED_MSG0(msg: anytype, arg0: anytype) @TypeOf(__API_D(msg, arg0)) {
    _ = &msg;
    _ = &arg0;
    return __API_D(msg, arg0);
}
pub inline fn __API_DEPRECATED_MSG1(msg: anytype, arg0: anytype, arg1: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1);
}
pub inline fn __API_DEPRECATED_MSG2(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2);
}
pub inline fn __API_DEPRECATED_MSG3(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3);
}
pub inline fn __API_DEPRECATED_MSG4(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4);
}
pub inline fn __API_DEPRECATED_MSG5(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5);
}
pub inline fn __API_DEPRECATED_MSG6(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6);
}
pub inline fn __API_DEPRECATED_MSG7(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7);
}
pub inline fn __API_DEPRECATED_MSG8(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8);
}
pub inline fn __API_DEPRECATED_MSG9(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9);
}
pub inline fn __API_DEPRECATED_MSG10(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10);
}
pub inline fn __API_DEPRECATED_MSG11(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11);
}
pub inline fn __API_DEPRECATED_MSG12(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11) ++ __API_D(msg, arg12)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11) ++ __API_D(msg, arg12);
}
pub inline fn __API_DEPRECATED_MSG13(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11) ++ __API_D(msg, arg12) ++ __API_D(msg, arg13)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11) ++ __API_D(msg, arg12) ++ __API_D(msg, arg13);
}
pub inline fn __API_DEPRECATED_MSG14(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11) ++ __API_D(msg, arg12) ++ __API_D(msg, arg13) ++ __API_D(msg, arg14)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11) ++ __API_D(msg, arg12) ++ __API_D(msg, arg13) ++ __API_D(msg, arg14);
}
pub inline fn __API_DEPRECATED_MSG15(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11) ++ __API_D(msg, arg12) ++ __API_D(msg, arg13) ++ __API_D(msg, arg14) ++ __API_D(msg, arg15)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_D(msg, arg0) ++ __API_D(msg, arg1) ++ __API_D(msg, arg2) ++ __API_D(msg, arg3) ++ __API_D(msg, arg4) ++ __API_D(msg, arg5) ++ __API_D(msg, arg6) ++ __API_D(msg, arg7) ++ __API_D(msg, arg8) ++ __API_D(msg, arg9) ++ __API_D(msg, arg10) ++ __API_D(msg, arg11) ++ __API_D(msg, arg12) ++ __API_D(msg, arg13) ++ __API_D(msg, arg14) ++ __API_D(msg, arg15);
}
pub inline fn __API_DEPRECATED_MSG_GET_MACRO_93585900(_0: anytype, _1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, NAME: anytype) @TypeOf(NAME) {
    _ = &_0;
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &NAME;
    return NAME;
}
pub const __API_D_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:306:13
pub inline fn __API_DEPRECATED_BEGIN0(msg: anytype, arg0: anytype) @TypeOf(__API_D_BEGIN(msg, arg0)) {
    _ = &msg;
    _ = &arg0;
    return __API_D_BEGIN(msg, arg0);
}
pub inline fn __API_DEPRECATED_BEGIN1(msg: anytype, arg0: anytype, arg1: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1);
}
pub inline fn __API_DEPRECATED_BEGIN2(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2);
}
pub inline fn __API_DEPRECATED_BEGIN3(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3);
}
pub inline fn __API_DEPRECATED_BEGIN4(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4);
}
pub inline fn __API_DEPRECATED_BEGIN5(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5);
}
pub inline fn __API_DEPRECATED_BEGIN6(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6);
}
pub inline fn __API_DEPRECATED_BEGIN7(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7);
}
pub inline fn __API_DEPRECATED_BEGIN8(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8);
}
pub inline fn __API_DEPRECATED_BEGIN9(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9);
}
pub inline fn __API_DEPRECATED_BEGIN10(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10);
}
pub inline fn __API_DEPRECATED_BEGIN11(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11);
}
pub inline fn __API_DEPRECATED_BEGIN12(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11) ++ __API_D_BEGIN(msg, arg12)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11) ++ __API_D_BEGIN(msg, arg12);
}
pub inline fn __API_DEPRECATED_BEGIN13(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11) ++ __API_D_BEGIN(msg, arg12) ++ __API_D_BEGIN(msg, arg13)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11) ++ __API_D_BEGIN(msg, arg12) ++ __API_D_BEGIN(msg, arg13);
}
pub inline fn __API_DEPRECATED_BEGIN14(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11) ++ __API_D_BEGIN(msg, arg12) ++ __API_D_BEGIN(msg, arg13) ++ __API_D_BEGIN(msg, arg14)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11) ++ __API_D_BEGIN(msg, arg12) ++ __API_D_BEGIN(msg, arg13) ++ __API_D_BEGIN(msg, arg14);
}
pub inline fn __API_DEPRECATED_BEGIN15(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11) ++ __API_D_BEGIN(msg, arg12) ++ __API_D_BEGIN(msg, arg13) ++ __API_D_BEGIN(msg, arg14) ++ __API_D_BEGIN(msg, arg15)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_D_BEGIN(msg, arg0) ++ __API_D_BEGIN(msg, arg1) ++ __API_D_BEGIN(msg, arg2) ++ __API_D_BEGIN(msg, arg3) ++ __API_D_BEGIN(msg, arg4) ++ __API_D_BEGIN(msg, arg5) ++ __API_D_BEGIN(msg, arg6) ++ __API_D_BEGIN(msg, arg7) ++ __API_D_BEGIN(msg, arg8) ++ __API_D_BEGIN(msg, arg9) ++ __API_D_BEGIN(msg, arg10) ++ __API_D_BEGIN(msg, arg11) ++ __API_D_BEGIN(msg, arg12) ++ __API_D_BEGIN(msg, arg13) ++ __API_D_BEGIN(msg, arg14) ++ __API_D_BEGIN(msg, arg15);
}
pub inline fn __API_DEPRECATED_BEGIN_GET_MACRO_93585900(_0: anytype, _1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, NAME: anytype) @TypeOf(NAME) {
    _ = &_0;
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &NAME;
    return NAME;
}
pub const __API_DR = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:327:17
pub inline fn __API_DEPRECATED_REP0(msg: anytype, arg0: anytype) @TypeOf(__API_DR(msg, arg0)) {
    _ = &msg;
    _ = &arg0;
    return __API_DR(msg, arg0);
}
pub inline fn __API_DEPRECATED_REP1(msg: anytype, arg0: anytype, arg1: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1);
}
pub inline fn __API_DEPRECATED_REP2(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2);
}
pub inline fn __API_DEPRECATED_REP3(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3);
}
pub inline fn __API_DEPRECATED_REP4(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4);
}
pub inline fn __API_DEPRECATED_REP5(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5);
}
pub inline fn __API_DEPRECATED_REP6(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6);
}
pub inline fn __API_DEPRECATED_REP7(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7);
}
pub inline fn __API_DEPRECATED_REP8(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8);
}
pub inline fn __API_DEPRECATED_REP9(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9);
}
pub inline fn __API_DEPRECATED_REP10(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10);
}
pub inline fn __API_DEPRECATED_REP11(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11);
}
pub inline fn __API_DEPRECATED_REP12(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11) ++ __API_DR(msg, arg12)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11) ++ __API_DR(msg, arg12);
}
pub inline fn __API_DEPRECATED_REP13(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11) ++ __API_DR(msg, arg12) ++ __API_DR(msg, arg13)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11) ++ __API_DR(msg, arg12) ++ __API_DR(msg, arg13);
}
pub inline fn __API_DEPRECATED_REP14(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11) ++ __API_DR(msg, arg12) ++ __API_DR(msg, arg13) ++ __API_DR(msg, arg14)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11) ++ __API_DR(msg, arg12) ++ __API_DR(msg, arg13) ++ __API_DR(msg, arg14);
}
pub inline fn __API_DEPRECATED_REP15(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11) ++ __API_DR(msg, arg12) ++ __API_DR(msg, arg13) ++ __API_DR(msg, arg14) ++ __API_DR(msg, arg15)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_DR(msg, arg0) ++ __API_DR(msg, arg1) ++ __API_DR(msg, arg2) ++ __API_DR(msg, arg3) ++ __API_DR(msg, arg4) ++ __API_DR(msg, arg5) ++ __API_DR(msg, arg6) ++ __API_DR(msg, arg7) ++ __API_DR(msg, arg8) ++ __API_DR(msg, arg9) ++ __API_DR(msg, arg10) ++ __API_DR(msg, arg11) ++ __API_DR(msg, arg12) ++ __API_DR(msg, arg13) ++ __API_DR(msg, arg14) ++ __API_DR(msg, arg15);
}
pub inline fn __API_DEPRECATED_REP_GET_MACRO_93585900(_0: anytype, _1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, NAME: anytype) @TypeOf(NAME) {
    _ = &_0;
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &NAME;
    return NAME;
}
pub const __API_DR_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:351:17
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN0(msg: anytype, arg0: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0)) {
    _ = &msg;
    _ = &arg0;
    return __API_DR_BEGIN(msg, arg0);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN1(msg: anytype, arg0: anytype, arg1: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN2(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN3(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN4(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN5(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN6(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN7(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN8(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN9(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN10(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN11(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN12(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11) ++ __API_DR_BEGIN(msg, arg12)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11) ++ __API_DR_BEGIN(msg, arg12);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN13(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11) ++ __API_DR_BEGIN(msg, arg12) ++ __API_DR_BEGIN(msg, arg13)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11) ++ __API_DR_BEGIN(msg, arg12) ++ __API_DR_BEGIN(msg, arg13);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN14(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11) ++ __API_DR_BEGIN(msg, arg12) ++ __API_DR_BEGIN(msg, arg13) ++ __API_DR_BEGIN(msg, arg14)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11) ++ __API_DR_BEGIN(msg, arg12) ++ __API_DR_BEGIN(msg, arg13) ++ __API_DR_BEGIN(msg, arg14);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN15(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11) ++ __API_DR_BEGIN(msg, arg12) ++ __API_DR_BEGIN(msg, arg13) ++ __API_DR_BEGIN(msg, arg14) ++ __API_DR_BEGIN(msg, arg15)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_DR_BEGIN(msg, arg0) ++ __API_DR_BEGIN(msg, arg1) ++ __API_DR_BEGIN(msg, arg2) ++ __API_DR_BEGIN(msg, arg3) ++ __API_DR_BEGIN(msg, arg4) ++ __API_DR_BEGIN(msg, arg5) ++ __API_DR_BEGIN(msg, arg6) ++ __API_DR_BEGIN(msg, arg7) ++ __API_DR_BEGIN(msg, arg8) ++ __API_DR_BEGIN(msg, arg9) ++ __API_DR_BEGIN(msg, arg10) ++ __API_DR_BEGIN(msg, arg11) ++ __API_DR_BEGIN(msg, arg12) ++ __API_DR_BEGIN(msg, arg13) ++ __API_DR_BEGIN(msg, arg14) ++ __API_DR_BEGIN(msg, arg15);
}
pub inline fn __API_DEPRECATED_WITH_REPLACEMENT_BEGIN_GET_MACRO_93585900(_0: anytype, _1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, NAME: anytype) @TypeOf(NAME) {
    _ = &_0;
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &NAME;
    return NAME;
}
pub const __API_O = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:376:9
pub inline fn __API_OBSOLETED_MSG0(msg: anytype, arg0: anytype) @TypeOf(__API_O(msg, arg0)) {
    _ = &msg;
    _ = &arg0;
    return __API_O(msg, arg0);
}
pub inline fn __API_OBSOLETED_MSG1(msg: anytype, arg0: anytype, arg1: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1);
}
pub inline fn __API_OBSOLETED_MSG2(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2);
}
pub inline fn __API_OBSOLETED_MSG3(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3);
}
pub inline fn __API_OBSOLETED_MSG4(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4);
}
pub inline fn __API_OBSOLETED_MSG5(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5);
}
pub inline fn __API_OBSOLETED_MSG6(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6);
}
pub inline fn __API_OBSOLETED_MSG7(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7);
}
pub inline fn __API_OBSOLETED_MSG8(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8);
}
pub inline fn __API_OBSOLETED_MSG9(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9);
}
pub inline fn __API_OBSOLETED_MSG10(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10);
}
pub inline fn __API_OBSOLETED_MSG11(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11);
}
pub inline fn __API_OBSOLETED_MSG12(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11) ++ __API_O(msg, arg12)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11) ++ __API_O(msg, arg12);
}
pub inline fn __API_OBSOLETED_MSG13(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11) ++ __API_O(msg, arg12) ++ __API_O(msg, arg13)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11) ++ __API_O(msg, arg12) ++ __API_O(msg, arg13);
}
pub inline fn __API_OBSOLETED_MSG14(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11) ++ __API_O(msg, arg12) ++ __API_O(msg, arg13) ++ __API_O(msg, arg14)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11) ++ __API_O(msg, arg12) ++ __API_O(msg, arg13) ++ __API_O(msg, arg14);
}
pub inline fn __API_OBSOLETED_MSG15(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11) ++ __API_O(msg, arg12) ++ __API_O(msg, arg13) ++ __API_O(msg, arg14) ++ __API_O(msg, arg15)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_O(msg, arg0) ++ __API_O(msg, arg1) ++ __API_O(msg, arg2) ++ __API_O(msg, arg3) ++ __API_O(msg, arg4) ++ __API_O(msg, arg5) ++ __API_O(msg, arg6) ++ __API_O(msg, arg7) ++ __API_O(msg, arg8) ++ __API_O(msg, arg9) ++ __API_O(msg, arg10) ++ __API_O(msg, arg11) ++ __API_O(msg, arg12) ++ __API_O(msg, arg13) ++ __API_O(msg, arg14) ++ __API_O(msg, arg15);
}
pub inline fn __API_OBSOLETED_MSG_GET_MACRO_93585900(_0: anytype, _1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, NAME: anytype) @TypeOf(NAME) {
    _ = &_0;
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &NAME;
    return NAME;
}
pub const __API_O_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:396:9
pub inline fn __API_OBSOLETED_BEGIN0(msg: anytype, arg0: anytype) @TypeOf(__API_O_BEGIN(msg, arg0)) {
    _ = &msg;
    _ = &arg0;
    return __API_O_BEGIN(msg, arg0);
}
pub inline fn __API_OBSOLETED_BEGIN1(msg: anytype, arg0: anytype, arg1: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1);
}
pub inline fn __API_OBSOLETED_BEGIN2(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2);
}
pub inline fn __API_OBSOLETED_BEGIN3(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3);
}
pub inline fn __API_OBSOLETED_BEGIN4(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4);
}
pub inline fn __API_OBSOLETED_BEGIN5(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5);
}
pub inline fn __API_OBSOLETED_BEGIN6(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6);
}
pub inline fn __API_OBSOLETED_BEGIN7(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7);
}
pub inline fn __API_OBSOLETED_BEGIN8(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8);
}
pub inline fn __API_OBSOLETED_BEGIN9(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9);
}
pub inline fn __API_OBSOLETED_BEGIN10(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10);
}
pub inline fn __API_OBSOLETED_BEGIN11(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11);
}
pub inline fn __API_OBSOLETED_BEGIN12(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11) ++ __API_O_BEGIN(msg, arg12)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11) ++ __API_O_BEGIN(msg, arg12);
}
pub inline fn __API_OBSOLETED_BEGIN13(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11) ++ __API_O_BEGIN(msg, arg12) ++ __API_O_BEGIN(msg, arg13)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11) ++ __API_O_BEGIN(msg, arg12) ++ __API_O_BEGIN(msg, arg13);
}
pub inline fn __API_OBSOLETED_BEGIN14(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11) ++ __API_O_BEGIN(msg, arg12) ++ __API_O_BEGIN(msg, arg13) ++ __API_O_BEGIN(msg, arg14)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11) ++ __API_O_BEGIN(msg, arg12) ++ __API_O_BEGIN(msg, arg13) ++ __API_O_BEGIN(msg, arg14);
}
pub inline fn __API_OBSOLETED_BEGIN15(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11) ++ __API_O_BEGIN(msg, arg12) ++ __API_O_BEGIN(msg, arg13) ++ __API_O_BEGIN(msg, arg14) ++ __API_O_BEGIN(msg, arg15)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_O_BEGIN(msg, arg0) ++ __API_O_BEGIN(msg, arg1) ++ __API_O_BEGIN(msg, arg2) ++ __API_O_BEGIN(msg, arg3) ++ __API_O_BEGIN(msg, arg4) ++ __API_O_BEGIN(msg, arg5) ++ __API_O_BEGIN(msg, arg6) ++ __API_O_BEGIN(msg, arg7) ++ __API_O_BEGIN(msg, arg8) ++ __API_O_BEGIN(msg, arg9) ++ __API_O_BEGIN(msg, arg10) ++ __API_O_BEGIN(msg, arg11) ++ __API_O_BEGIN(msg, arg12) ++ __API_O_BEGIN(msg, arg13) ++ __API_O_BEGIN(msg, arg14) ++ __API_O_BEGIN(msg, arg15);
}
pub inline fn __API_OBSOLETED_BEGIN_GET_MACRO_93585900(_0: anytype, _1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, NAME: anytype) @TypeOf(NAME) {
    _ = &_0;
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &NAME;
    return NAME;
}
pub const __API_OR = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:417:13
pub inline fn __API_OBSOLETED_REP0(msg: anytype, arg0: anytype) @TypeOf(__API_OR(msg, arg0)) {
    _ = &msg;
    _ = &arg0;
    return __API_OR(msg, arg0);
}
pub inline fn __API_OBSOLETED_REP1(msg: anytype, arg0: anytype, arg1: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1);
}
pub inline fn __API_OBSOLETED_REP2(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2);
}
pub inline fn __API_OBSOLETED_REP3(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3);
}
pub inline fn __API_OBSOLETED_REP4(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4);
}
pub inline fn __API_OBSOLETED_REP5(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5);
}
pub inline fn __API_OBSOLETED_REP6(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6);
}
pub inline fn __API_OBSOLETED_REP7(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7);
}
pub inline fn __API_OBSOLETED_REP8(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8);
}
pub inline fn __API_OBSOLETED_REP9(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9);
}
pub inline fn __API_OBSOLETED_REP10(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10);
}
pub inline fn __API_OBSOLETED_REP11(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11);
}
pub inline fn __API_OBSOLETED_REP12(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11) ++ __API_OR(msg, arg12)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11) ++ __API_OR(msg, arg12);
}
pub inline fn __API_OBSOLETED_REP13(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11) ++ __API_OR(msg, arg12) ++ __API_OR(msg, arg13)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11) ++ __API_OR(msg, arg12) ++ __API_OR(msg, arg13);
}
pub inline fn __API_OBSOLETED_REP14(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11) ++ __API_OR(msg, arg12) ++ __API_OR(msg, arg13) ++ __API_OR(msg, arg14)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11) ++ __API_OR(msg, arg12) ++ __API_OR(msg, arg13) ++ __API_OR(msg, arg14);
}
pub inline fn __API_OBSOLETED_REP15(msg: anytype, arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11) ++ __API_OR(msg, arg12) ++ __API_OR(msg, arg13) ++ __API_OR(msg, arg14) ++ __API_OR(msg, arg15)) {
    _ = &msg;
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_OR(msg, arg0) ++ __API_OR(msg, arg1) ++ __API_OR(msg, arg2) ++ __API_OR(msg, arg3) ++ __API_OR(msg, arg4) ++ __API_OR(msg, arg5) ++ __API_OR(msg, arg6) ++ __API_OR(msg, arg7) ++ __API_OR(msg, arg8) ++ __API_OR(msg, arg9) ++ __API_OR(msg, arg10) ++ __API_OR(msg, arg11) ++ __API_OR(msg, arg12) ++ __API_OR(msg, arg13) ++ __API_OR(msg, arg14) ++ __API_OR(msg, arg15);
}
pub inline fn __API_OBSOLETED_REP_GET_MACRO_93585900(_0: anytype, _1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, NAME: anytype) @TypeOf(NAME) {
    _ = &_0;
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &NAME;
    return NAME;
}
pub const __API_OR_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:441:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN0 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:446:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN1 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:447:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN2 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:448:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN3 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:449:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN4 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:450:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN5 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:451:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN6 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:452:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN7 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:453:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN8 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:454:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN9 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:455:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN10 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:456:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN11 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:457:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN12 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:458:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN13 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:459:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN14 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:460:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN15 = @compileError("unable to translate macro: undefined identifier `__API_R_BEGIN`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:461:13
pub inline fn __API_OBSOLETED_WITH_REPLACEMENT_BEGIN_GET_MACRO_93585900(_0: anytype, _1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, NAME: anytype) @TypeOf(NAME) {
    _ = &_0;
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &NAME;
    return NAME;
}
pub const __API_U = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:473:13
pub inline fn __API_UNAVAILABLE0(arg0: anytype) @TypeOf(__API_U(arg0)) {
    _ = &arg0;
    return __API_U(arg0);
}
pub inline fn __API_UNAVAILABLE1(arg0: anytype, arg1: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1)) {
    _ = &arg0;
    _ = &arg1;
    return __API_U(arg0) ++ __API_U(arg1);
}
pub inline fn __API_UNAVAILABLE2(arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2);
}
pub inline fn __API_UNAVAILABLE3(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3);
}
pub inline fn __API_UNAVAILABLE4(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4);
}
pub inline fn __API_UNAVAILABLE5(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5);
}
pub inline fn __API_UNAVAILABLE6(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6);
}
pub inline fn __API_UNAVAILABLE7(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7);
}
pub inline fn __API_UNAVAILABLE8(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8);
}
pub inline fn __API_UNAVAILABLE9(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9);
}
pub inline fn __API_UNAVAILABLE10(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10);
}
pub inline fn __API_UNAVAILABLE11(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11);
}
pub inline fn __API_UNAVAILABLE12(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11) ++ __API_U(arg12)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11) ++ __API_U(arg12);
}
pub inline fn __API_UNAVAILABLE13(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11) ++ __API_U(arg12) ++ __API_U(arg13)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11) ++ __API_U(arg12) ++ __API_U(arg13);
}
pub inline fn __API_UNAVAILABLE14(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11) ++ __API_U(arg12) ++ __API_U(arg13) ++ __API_U(arg14)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11) ++ __API_U(arg12) ++ __API_U(arg13) ++ __API_U(arg14);
}
pub inline fn __API_UNAVAILABLE15(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11) ++ __API_U(arg12) ++ __API_U(arg13) ++ __API_U(arg14) ++ __API_U(arg15)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_U(arg0) ++ __API_U(arg1) ++ __API_U(arg2) ++ __API_U(arg3) ++ __API_U(arg4) ++ __API_U(arg5) ++ __API_U(arg6) ++ __API_U(arg7) ++ __API_U(arg8) ++ __API_U(arg9) ++ __API_U(arg10) ++ __API_U(arg11) ++ __API_U(arg12) ++ __API_U(arg13) ++ __API_U(arg14) ++ __API_U(arg15);
}
pub inline fn __API_UNAVAILABLE_GET_MACRO_93585900(_0: anytype, _1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, NAME: anytype) @TypeOf(NAME) {
    _ = &_0;
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &NAME;
    return NAME;
}
pub const __API_U_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternal.h:493:13
pub inline fn __API_UNAVAILABLE_BEGIN0(arg0: anytype) @TypeOf(__API_U_BEGIN(arg0)) {
    _ = &arg0;
    return __API_U_BEGIN(arg0);
}
pub inline fn __API_UNAVAILABLE_BEGIN1(arg0: anytype, arg1: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1)) {
    _ = &arg0;
    _ = &arg1;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1);
}
pub inline fn __API_UNAVAILABLE_BEGIN2(arg0: anytype, arg1: anytype, arg2: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2);
}
pub inline fn __API_UNAVAILABLE_BEGIN3(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3);
}
pub inline fn __API_UNAVAILABLE_BEGIN4(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4);
}
pub inline fn __API_UNAVAILABLE_BEGIN5(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5);
}
pub inline fn __API_UNAVAILABLE_BEGIN6(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6);
}
pub inline fn __API_UNAVAILABLE_BEGIN7(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7);
}
pub inline fn __API_UNAVAILABLE_BEGIN8(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8);
}
pub inline fn __API_UNAVAILABLE_BEGIN9(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9);
}
pub inline fn __API_UNAVAILABLE_BEGIN10(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10);
}
pub inline fn __API_UNAVAILABLE_BEGIN11(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11);
}
pub inline fn __API_UNAVAILABLE_BEGIN12(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11) ++ __API_U_BEGIN(arg12)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11) ++ __API_U_BEGIN(arg12);
}
pub inline fn __API_UNAVAILABLE_BEGIN13(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11) ++ __API_U_BEGIN(arg12) ++ __API_U_BEGIN(arg13)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11) ++ __API_U_BEGIN(arg12) ++ __API_U_BEGIN(arg13);
}
pub inline fn __API_UNAVAILABLE_BEGIN14(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11) ++ __API_U_BEGIN(arg12) ++ __API_U_BEGIN(arg13) ++ __API_U_BEGIN(arg14)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11) ++ __API_U_BEGIN(arg12) ++ __API_U_BEGIN(arg13) ++ __API_U_BEGIN(arg14);
}
pub inline fn __API_UNAVAILABLE_BEGIN15(arg0: anytype, arg1: anytype, arg2: anytype, arg3: anytype, arg4: anytype, arg5: anytype, arg6: anytype, arg7: anytype, arg8: anytype, arg9: anytype, arg10: anytype, arg11: anytype, arg12: anytype, arg13: anytype, arg14: anytype, arg15: anytype) @TypeOf(__API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11) ++ __API_U_BEGIN(arg12) ++ __API_U_BEGIN(arg13) ++ __API_U_BEGIN(arg14) ++ __API_U_BEGIN(arg15)) {
    _ = &arg0;
    _ = &arg1;
    _ = &arg2;
    _ = &arg3;
    _ = &arg4;
    _ = &arg5;
    _ = &arg6;
    _ = &arg7;
    _ = &arg8;
    _ = &arg9;
    _ = &arg10;
    _ = &arg11;
    _ = &arg12;
    _ = &arg13;
    _ = &arg14;
    _ = &arg15;
    return __API_U_BEGIN(arg0) ++ __API_U_BEGIN(arg1) ++ __API_U_BEGIN(arg2) ++ __API_U_BEGIN(arg3) ++ __API_U_BEGIN(arg4) ++ __API_U_BEGIN(arg5) ++ __API_U_BEGIN(arg6) ++ __API_U_BEGIN(arg7) ++ __API_U_BEGIN(arg8) ++ __API_U_BEGIN(arg9) ++ __API_U_BEGIN(arg10) ++ __API_U_BEGIN(arg11) ++ __API_U_BEGIN(arg12) ++ __API_U_BEGIN(arg13) ++ __API_U_BEGIN(arg14) ++ __API_U_BEGIN(arg15);
}
pub inline fn __API_UNAVAILABLE_BEGIN_GET_MACRO_93585900(_0: anytype, _1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, NAME: anytype) @TypeOf(NAME) {
    _ = &_0;
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &NAME;
    return NAME;
}
pub inline fn __swift_compiler_version_at_least() @TypeOf(@as(c_int, 1)) {
    return @as(c_int, 1);
}
pub const __AVAILABILITY_INTERNAL_LEGACY__ = "";
pub const __ENABLE_LEGACY_IPHONE_AVAILABILITY = @as(c_int, 1);
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:67:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:68:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:70:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:74:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:76:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:80:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:82:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:86:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:88:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_11_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:92:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_2_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:93:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_2_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:95:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_2_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:99:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_2_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:101:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_2_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:105:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_2_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:107:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_3_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:111:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_3_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:113:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_3_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:117:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_3_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:119:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_3_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:123:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_3_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:125:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_4_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:129:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_4_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:131:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_4_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:135:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_4_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:137:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_4_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:141:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_4_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:143:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_4_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:147:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_4_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:149:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_5_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:153:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_5_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:155:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_5_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:159:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_5_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:161:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_6_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:165:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_6_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:167:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_6_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:171:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_6_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:173:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_7_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:177:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_7_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:179:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_7_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:183:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_7_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:185:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:189:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_8_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:191:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:195:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:197:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:201:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:203:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:207:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:209:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:213:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:215:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:219:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:221:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:225:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:227:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:231:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:233:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:237:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:239:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:243:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_0_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:244:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:245:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:246:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:248:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:252:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:254:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:258:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:260:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:264:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:266:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_2_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:270:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_2_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:272:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_2_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:276:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_2_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:278:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_3_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:282:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_3_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:284:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_3_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:288:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_3_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:290:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_3_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:294:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_3_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:296:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_4_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:300:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_4_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:302:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_4_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:306:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_4_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:308:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_4_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:312:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_4_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:314:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_4_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:318:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_4_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:320:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_5_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:324:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_5_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:326:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_5_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:330:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_5_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:332:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_6_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:336:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_6_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:338:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_6_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:342:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_6_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:344:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_7_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:348:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_7_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:350:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_7_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:354:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_7_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:356:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:360:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_8_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:362:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:366:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:368:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:372:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:374:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:378:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:380:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:384:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:386:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:390:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:392:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:396:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:398:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:402:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:404:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:408:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:410:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:414:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_1_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:415:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:416:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:417:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:419:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:423:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:425:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:429:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:431:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:435:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:437:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_2_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:441:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_2_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:443:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_3_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:447:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_3_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:449:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_3_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:453:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_3_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:455:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_3_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:459:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_3_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:461:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_4_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:465:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_4_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:467:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_4_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:471:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_4_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:473:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_4_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:477:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_4_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:479:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_4_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:483:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_4_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:485:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_5_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:489:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_5_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:491:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_5_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:495:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_5_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:497:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_6_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:501:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_6_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:503:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_6_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:507:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_6_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:509:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_7_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:513:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_7_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:515:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_7_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:519:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_7_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:521:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:525:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_8_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:527:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:531:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:533:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:537:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:539:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:543:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:545:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:549:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:551:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:555:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:557:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:561:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:563:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:567:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:569:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:573:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:575:25
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:579:21
pub const __AVAILABILITY_INTERNAL__IPHONE_2_2_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:580:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:581:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:582:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:584:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:588:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:590:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:594:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:596:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:600:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:602:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_3_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:606:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_3_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:608:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_3_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:612:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_3_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:614:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_3_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:618:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_3_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:620:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_4_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:624:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_4_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:626:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_4_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:630:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_4_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:632:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_4_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:636:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_4_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:638:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_4_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:642:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_4_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:644:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_5_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:648:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_5_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:650:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_5_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:654:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_5_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:656:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_6_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:660:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_6_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:662:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_6_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:666:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_6_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:668:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_7_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:672:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_7_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:674:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_7_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:678:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_7_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:680:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:684:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_8_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:686:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:690:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:692:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:696:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:698:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:702:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:704:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:708:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:710:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:714:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:716:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:720:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:722:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:726:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:728:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:732:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:734:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:738:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_0_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:739:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:740:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:741:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:743:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:747:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:749:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:753:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:755:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:759:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:761:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_3_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:765:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_3_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:767:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_3_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:771:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_3_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:773:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_4_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:777:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_4_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:779:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_4_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:783:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_4_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:785:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_4_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:789:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_4_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:791:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_4_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:795:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_4_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:797:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_5_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:801:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_5_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:803:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_5_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:807:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_5_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:809:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_6_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:813:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_6_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:815:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_6_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:819:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_6_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:821:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_7_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:825:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_7_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:827:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_7_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:831:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_7_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:833:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:837:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_8_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:839:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:843:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:845:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:849:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:851:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:855:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:857:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:861:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:863:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:867:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:869:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:873:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:875:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:879:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:881:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:885:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:887:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:891:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_1_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:892:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:893:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:894:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:896:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:900:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:902:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:906:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:908:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:912:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:914:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_3_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:918:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_3_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:920:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_4_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:924:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_4_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:926:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_4_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:930:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_4_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:932:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_4_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:936:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_4_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:938:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_4_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:942:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_4_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:944:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_5_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:948:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_5_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:950:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_5_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:954:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_5_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:956:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_6_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:960:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_6_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:962:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_6_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:966:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_6_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:968:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_7_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:972:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_7_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:974:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_7_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:978:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_7_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:980:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:984:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_8_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:986:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:990:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:992:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:996:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:998:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1002:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1004:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1008:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1010:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1014:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1016:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1020:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1022:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1026:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1028:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1032:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1034:25
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1038:21
pub const __AVAILABILITY_INTERNAL__IPHONE_3_2_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1039:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1040:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1041:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1043:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1047:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1049:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1053:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1055:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1059:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1061:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_12_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1066:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_4_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1070:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_4_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1072:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_4_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1076:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_4_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1078:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_4_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1082:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_4_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1084:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_4_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1088:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_4_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1090:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_5_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1094:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_5_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1096:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_5_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1100:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_5_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1102:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_6_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1106:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_6_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1108:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_6_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1112:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_6_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1114:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_7_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1118:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_7_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1120:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_7_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1124:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_7_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1126:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1130:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_8_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1132:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1136:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1138:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1142:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1144:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1148:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1150:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1154:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1156:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1160:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1162:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1166:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1168:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1172:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1174:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1178:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1180:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1184:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_0_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1185:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1186:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1187:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1189:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1193:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1195:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1199:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1201:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1205:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1207:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_4_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1211:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_4_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1213:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_4_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1217:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_4_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1219:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_4_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1223:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_4_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1225:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_5_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1229:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_5_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1231:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_5_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1235:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_5_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1237:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_6_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1241:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_6_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1243:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_6_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1247:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_6_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1249:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_7_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1253:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_7_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1255:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_7_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1259:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_7_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1261:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1265:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_8_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1267:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1271:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1273:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1277:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1279:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1283:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1285:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1289:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1291:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1295:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1297:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1301:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1303:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1307:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1309:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1313:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1315:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1319:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_1_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1320:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1321:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1322:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1324:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1328:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1330:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1334:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1336:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1340:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1342:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_4_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1346:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_4_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1348:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_4_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1352:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_4_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1354:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_5_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1358:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_5_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1360:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_5_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1364:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_5_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1366:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_6_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1370:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_6_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1372:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_6_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1376:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_6_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1378:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_7_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1382:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_7_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1384:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_7_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1388:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_7_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1390:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1394:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_8_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1396:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1400:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1402:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1406:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1408:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1412:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1414:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1418:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1420:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1424:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1426:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1430:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1432:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1436:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1438:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1442:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1444:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1448:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_2_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1449:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1450:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1451:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1453:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1457:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1459:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1463:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1465:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1469:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1471:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_4_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1475:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_4_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1477:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_5_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1481:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_5_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1483:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_5_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1487:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_5_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1489:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_6_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1493:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_6_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1495:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_6_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1499:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_6_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1501:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_7_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1505:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_7_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1507:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_7_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1511:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_7_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1513:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1517:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_8_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1519:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1523:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1525:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1529:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1531:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1535:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1537:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1541:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1543:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1547:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1549:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1553:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1555:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1559:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1561:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1565:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1567:25
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1571:21
pub const __AVAILABILITY_INTERNAL__IPHONE_4_3_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1572:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1573:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1574:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1576:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1580:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1582:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1586:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1588:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1592:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1594:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_11_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1598:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_5_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1599:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_5_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1601:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_5_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1605:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_5_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1607:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_6_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1611:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_6_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1613:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_6_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1617:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_6_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1619:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_7_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1623:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_7_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1625:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_7_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1629:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_7_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1631:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1635:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_8_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1637:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1641:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1643:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1647:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1649:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1653:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1655:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1659:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1661:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1665:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1667:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1671:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1673:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1677:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1679:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1683:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1685:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1689:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_0_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1690:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1691:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1692:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1694:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1698:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1700:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1704:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1706:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1710:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1712:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_5_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1716:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_5_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1718:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_6_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1722:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_6_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1724:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_6_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1728:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_6_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1730:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_7_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1734:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_7_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1736:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_7_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1740:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_7_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1742:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1746:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_8_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1748:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1752:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1754:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1758:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1760:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1764:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1766:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1770:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1772:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1776:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1778:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1782:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1784:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1788:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1790:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1794:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1796:25
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1800:21
pub const __AVAILABILITY_INTERNAL__IPHONE_5_1_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1801:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1802:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1803:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1805:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1809:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1811:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1815:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1817:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1821:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1823:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_6_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1827:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_6_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1829:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_6_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1833:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_6_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1835:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_7_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1839:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_7_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1841:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_7_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1845:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_7_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1847:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1851:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_8_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1853:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1857:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1859:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1863:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1865:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1869:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1871:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1875:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1877:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1881:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1883:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1887:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1889:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1893:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1895:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1899:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1901:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1905:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_0_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1906:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1907:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1908:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1910:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1914:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1916:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1920:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1922:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1926:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1928:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_6_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1932:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_6_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1934:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_7_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1938:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_7_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1940:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_7_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1944:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_7_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1946:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1950:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_8_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1952:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1956:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1958:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1962:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1964:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1968:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1970:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1974:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1976:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1980:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1982:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1986:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1988:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1992:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1994:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:1998:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2000:25
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2004:21
pub const __AVAILABILITY_INTERNAL__IPHONE_6_1_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2005:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2006:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2007:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2009:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2013:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2015:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2019:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2021:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2025:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2027:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_11_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2031:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_11_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2032:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_12_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2034:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_7_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2038:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_7_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2040:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_7_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2044:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_7_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2046:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2050:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_8_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2052:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2056:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2058:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2062:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2064:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2068:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2070:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2074:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2076:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2080:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2082:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2086:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2088:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2092:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2094:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2098:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2100:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2104:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_0_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2105:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2106:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2107:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2109:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2113:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2115:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2119:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2121:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2125:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2127:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_7_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2131:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_7_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2133:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2137:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_8_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2139:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2143:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2145:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2149:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2151:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2155:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2157:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2161:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2163:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2167:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2169:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2173:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2175:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2179:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2181:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2185:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2187:25
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2191:21
pub const __AVAILABILITY_INTERNAL__IPHONE_7_1_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2192:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2193:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2194:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2196:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2200:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2202:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2206:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2208:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2212:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2214:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_11_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2219:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_11_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2223:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_12_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2224:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_8_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2225:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_8_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2227:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2231:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2233:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2237:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2239:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2243:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2245:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2249:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2251:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2255:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2257:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2261:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2263:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2267:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2269:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2273:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2275:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2279:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_0_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2280:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2281:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2282:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2284:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2288:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2290:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2294:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2296:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2300:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2302:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_8_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2306:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_8_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2308:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2312:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2314:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2318:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2320:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2324:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2326:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2330:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2332:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2336:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2338:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2342:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2344:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2348:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2350:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2354:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_1_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2355:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2356:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2357:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2359:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2363:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2365:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2369:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2371:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2375:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2377:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_8_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2381:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_8_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2383:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2387:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2389:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2393:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2395:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2399:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2401:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2405:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2407:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2411:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2413:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2417:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2419:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2423:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_2_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2424:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2425:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2426:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2428:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2432:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2434:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2438:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2440:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2444:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2446:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_8_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2450:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_8_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2452:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2456:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2458:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2462:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2464:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2468:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2470:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2474:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2476:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2480:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2482:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2486:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_3_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2487:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2488:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2489:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2491:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2495:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2497:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2501:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2503:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2507:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2509:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_8_4 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2513:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_8_4_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2515:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2519:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2521:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2525:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2527:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2531:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2533:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2537:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2539:25
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2543:21
pub const __AVAILABILITY_INTERNAL__IPHONE_8_4_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2544:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2545:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2546:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2548:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2552:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2554:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2558:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2560:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2564:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2566:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_9_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2570:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_9_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2572:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2576:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2578:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2582:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2584:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2588:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2590:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2594:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_0_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2595:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2596:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_1_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2597:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_1_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2599:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_1_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2603:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_1_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2605:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_1_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2609:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_1_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2611:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_1_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2615:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_1_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2617:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_1_DEP__IPHONE_9_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2621:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_1_DEP__IPHONE_9_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2623:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_1_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2627:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_1_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2629:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_1_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2633:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_1_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2635:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_1_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2639:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_1_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2640:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2641:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_2_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2642:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_2_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2644:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_2_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2648:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_2_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2650:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_2_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2654:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_2_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2656:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_2_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2660:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_2_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2662:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_2_DEP__IPHONE_9_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2666:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_2_DEP__IPHONE_9_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2668:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_2_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2672:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_2_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2674:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_2_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2678:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_2_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2679:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2680:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_3_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2681:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_3_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2683:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_3_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2687:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_3_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2689:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_3_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2693:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_3_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2695:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_3_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2699:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_3_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2701:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_3_DEP__IPHONE_9_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2705:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_3_DEP__IPHONE_9_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2707:25
pub const __AVAILABILITY_INTERNAL__IPHONE_9_3_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2711:21
pub const __AVAILABILITY_INTERNAL__IPHONE_9_3_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2712:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2713:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_0_DEP__IPHONE_10_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2714:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_0_DEP__IPHONE_10_0_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2716:25
pub const __AVAILABILITY_INTERNAL__IPHONE_10_0_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2720:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_0_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2722:25
pub const __AVAILABILITY_INTERNAL__IPHONE_10_0_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2726:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_0_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2728:25
pub const __AVAILABILITY_INTERNAL__IPHONE_10_0_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2732:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_0_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2734:25
pub const __AVAILABILITY_INTERNAL__IPHONE_10_0_DEP__IPHONE_11_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2738:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_0_DEP__IPHONE_12_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2739:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_0_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2740:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_0_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2741:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2742:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_1_DEP__IPHONE_10_1 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2743:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_1_DEP__IPHONE_10_1_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2745:25
pub const __AVAILABILITY_INTERNAL__IPHONE_10_1_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2749:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_1_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2751:25
pub const __AVAILABILITY_INTERNAL__IPHONE_10_1_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2755:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_1_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2757:25
pub const __AVAILABILITY_INTERNAL__IPHONE_10_1_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2761:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_1_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2762:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2763:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_2_DEP__IPHONE_10_2 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2764:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_2_DEP__IPHONE_10_2_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2766:25
pub const __AVAILABILITY_INTERNAL__IPHONE_10_2_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2770:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_2_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2772:25
pub const __AVAILABILITY_INTERNAL__IPHONE_10_2_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2776:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_2_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2777:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2778:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_3_DEP__IPHONE_10_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2779:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_3_DEP__IPHONE_10_3_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2781:25
pub const __AVAILABILITY_INTERNAL__IPHONE_10_3_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2785:21
pub const __AVAILABILITY_INTERNAL__IPHONE_10_3_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2786:21
pub const __AVAILABILITY_INTERNAL__IPHONE_11 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2787:21
pub const __AVAILABILITY_INTERNAL__IPHONE_11_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2788:21
pub const __AVAILABILITY_INTERNAL__IPHONE_11_3 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2789:21
pub const __AVAILABILITY_INTERNAL__IPHONE_12_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2790:21
pub const __AVAILABILITY_INTERNAL__IPHONE_13_0 = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2791:21
pub const __AVAILABILITY_INTERNAL__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2793:21
pub const __AVAILABILITY_INTERNAL__IPHONE_NA__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2794:21
pub const __AVAILABILITY_INTERNAL__IPHONE_NA_DEP__IPHONE_NA = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2795:21
pub const __AVAILABILITY_INTERNAL__IPHONE_NA_DEP__IPHONE_NA_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2796:21
pub const __AVAILABILITY_INTERNAL__IPHONE_COMPAT_VERSION = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2817:25
pub const __AVAILABILITY_INTERNAL__IPHONE_COMPAT_VERSION_DEP__IPHONE_COMPAT_VERSION = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2818:25
pub const __AVAILABILITY_INTERNAL__IPHONE_COMPAT_VERSION_DEP__IPHONE_COMPAT_VERSION_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/AvailabilityInternalLegacy.h:2820:25
pub const __OSX_AVAILABLE_STARTING = @compileError("unable to translate macro: undefined identifier `__AVAILABILITY_INTERNAL`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:204:13
pub const __OSX_AVAILABLE_BUT_DEPRECATED = @compileError("unable to translate macro: undefined identifier `__AVAILABILITY_INTERNAL`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:205:13
pub const __OSX_AVAILABLE_BUT_DEPRECATED_MSG = @compileError("unable to translate macro: undefined identifier `__AVAILABILITY_INTERNAL`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:207:13
pub const __OS_AVAILABILITY = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:263:13
pub const __OS_AVAILABILITY_MSG = @compileError("unable to translate macro: undefined identifier `availability`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:264:13
pub const __OSX_EXTENSION_UNAVAILABLE = @compileError("unable to translate macro: undefined identifier `macosx_app_extension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:281:13
pub const __IOS_EXTENSION_UNAVAILABLE = @compileError("unable to translate macro: undefined identifier `ios_app_extension`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:282:13
pub inline fn __OS_EXTENSION_UNAVAILABLE(_msg: anytype) @TypeOf(__OSX_EXTENSION_UNAVAILABLE(_msg) ++ __IOS_EXTENSION_UNAVAILABLE(_msg)) {
    _ = &_msg;
    return __OSX_EXTENSION_UNAVAILABLE(_msg) ++ __IOS_EXTENSION_UNAVAILABLE(_msg);
}
pub const __OSX_UNAVAILABLE = @compileError("unable to translate macro: undefined identifier `macosx`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:299:13
pub const __OSX_AVAILABLE = @compileError("unable to translate macro: undefined identifier `macosx`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:300:13
pub const __OSX_DEPRECATED = @compileError("unable to translate macro: undefined identifier `macosx`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:301:13
pub const __IOS_UNAVAILABLE = @compileError("unable to translate macro: undefined identifier `ios`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:325:13
pub const __IOS_PROHIBITED = @compileError("unable to translate macro: undefined identifier `ios`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:327:15
pub const __IOS_AVAILABLE = @compileError("unable to translate macro: undefined identifier `ios`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:329:13
pub const __IOS_DEPRECATED = @compileError("unable to translate macro: undefined identifier `ios`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:330:13
pub const __TVOS_UNAVAILABLE = @compileError("unable to translate macro: undefined identifier `tvos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:354:13
pub const __TVOS_PROHIBITED = @compileError("unable to translate macro: undefined identifier `tvos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:356:15
pub const __TVOS_AVAILABLE = @compileError("unable to translate macro: undefined identifier `tvos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:358:13
pub const __TVOS_DEPRECATED = @compileError("unable to translate macro: undefined identifier `tvos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:359:13
pub const __WATCHOS_UNAVAILABLE = @compileError("unable to translate macro: undefined identifier `watchos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:383:13
pub const __WATCHOS_PROHIBITED = @compileError("unable to translate macro: undefined identifier `watchos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:385:15
pub const __WATCHOS_AVAILABLE = @compileError("unable to translate macro: undefined identifier `watchos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:387:13
pub const __WATCHOS_DEPRECATED = @compileError("unable to translate macro: undefined identifier `watchos`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:388:13
pub const __SWIFT_UNAVAILABLE = @compileError("unable to translate macro: undefined identifier `swift`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:411:13
pub const __SWIFT_UNAVAILABLE_MSG = @compileError("unable to translate macro: undefined identifier `swift`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:412:13
pub const __API_AVAILABLE = @compileError("unable to translate C expr: unexpected token '__VA_ARGS__'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:457:13
pub const __API_AVAILABLE_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:459:13
pub const __API_AVAILABLE_END = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:460:13
pub const __API_DEPRECATED = @compileError("unable to translate C expr: unexpected token '__VA_ARGS__'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:483:13
pub const __API_DEPRECATED_WITH_REPLACEMENT = @compileError("unable to translate C expr: unexpected token '__VA_ARGS__'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:484:13
pub const __API_DEPRECATED_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:486:13
pub const __API_DEPRECATED_END = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:487:13
pub const __API_DEPRECATED_WITH_REPLACEMENT_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:489:13
pub const __API_DEPRECATED_WITH_REPLACEMENT_END = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:490:13
pub const __API_OBSOLETED = @compileError("unable to translate C expr: unexpected token '__VA_ARGS__'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:494:13
pub const __API_OBSOLETED_WITH_REPLACEMENT = @compileError("unable to translate C expr: unexpected token '__VA_ARGS__'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:495:13
pub const __API_OBSOLETED_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:497:13
pub const __API_OBSOLETED_END = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:498:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:500:13
pub const __API_OBSOLETED_WITH_REPLACEMENT_END = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:501:13
pub const __API_UNAVAILABLE = @compileError("unable to translate C expr: unexpected token '__VA_ARGS__'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:512:13
pub const __API_UNAVAILABLE_BEGIN = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:514:13
pub const __API_UNAVAILABLE_END = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/Availability.h:515:13
pub inline fn __SPI_AVAILABLE() void {
    return;
}
pub inline fn __SPI_AVAILABLE_BEGIN() void {
    return;
}
pub const __SPI_AVAILABLE_END = "";
pub inline fn __SPI_DEPRECATED() void {
    return;
}
pub inline fn __SPI_DEPRECATED_WITH_REPLACEMENT() void {
    return;
}
pub const _CDEFS_H_ = "";
pub const __BEGIN_DECLS = "";
pub const __END_DECLS = "";
pub inline fn __has_cpp_attribute(x: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &x;
    return @as(c_int, 0);
}
pub inline fn __P(protos: anytype) @TypeOf(protos) {
    _ = &protos;
    return protos;
}
pub const __CONCAT = @compileError("unable to translate C expr: unexpected token '##'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:116:9
pub const __STRING = @compileError("unable to translate C expr: unexpected token ''"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:117:9
pub const __const = @compileError("unable to translate C expr: unexpected token 'const'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:119:9
pub const __signed = c_int;
pub const __volatile = @compileError("unable to translate C expr: unexpected token 'volatile'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:121:9
pub const __dead2 = @compileError("unable to translate macro: undefined identifier `__noreturn__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:165:9
pub const __pure2 = @compileError("unable to translate C expr: unexpected token '__attribute__'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:166:9
pub const __stateful_pure = @compileError("unable to translate macro: undefined identifier `__pure__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:167:9
pub const __unused = @compileError("unable to translate macro: undefined identifier `__unused__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:172:9
pub const __used = @compileError("unable to translate macro: undefined identifier `__used__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:177:9
pub const __cold = @compileError("unable to translate macro: undefined identifier `__cold__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:183:9
pub const __returns_nonnull = @compileError("unable to translate macro: undefined identifier `returns_nonnull`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:190:9
pub const __exported = @compileError("unable to translate macro: undefined identifier `__visibility__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:200:9
pub const __exported_push = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:201:9
pub const __exported_push_hidden = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:203:9
pub const __exported_pop = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:204:9
pub const __exported_hidden = @compileError("unable to translate macro: undefined identifier `__private_extern__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:205:9
pub const __deprecated = @compileError("unable to translate macro: undefined identifier `__deprecated__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:223:9
pub const __deprecated_msg = @compileError("unable to translate macro: undefined identifier `__deprecated__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:229:10
pub inline fn __deprecated_enum_msg(_msg: anytype) void {
    _ = &_msg;
    return;
}
pub inline fn __kpi_deprecated(_msg: anytype) void {
    _ = &_msg;
    return;
}
pub const __unavailable = @compileError("unable to translate macro: undefined identifier `__unavailable__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:244:9
pub const __kpi_unavailable = "";
pub const __kpi_deprecated_arm64_macos_unavailable = "";
pub const __dead = "";
pub const __pure = "";
pub const __restrict = @compileError("unable to translate C expr: unexpected token 'restrict'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:266:9
pub const __disable_tail_calls = "";
pub const __not_tail_called = "";
pub const __result_use_check = @compileError("unable to translate macro: undefined identifier `__warn_unused_result__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:322:9
pub const __swift_unavailable = @compileError("unable to translate macro: undefined identifier `__availability__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:332:9
pub inline fn __swift_unavailable_from_async(_msg: anytype) void {
    _ = &_msg;
    return;
}
pub const __swift_nonisolated = "";
pub const __swift_nonisolated_unsafe = "";
pub const __abortlike = __dead2 ++ __cold;
pub const __header_inline = @compileError("unable to translate C expr: unexpected token 'extern'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:383:10
pub const __header_always_inline = @compileError("unable to translate macro: undefined identifier `__always_inline__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:392:10
pub const __unreachable_ok_push = "";
pub const __unreachable_ok_pop = "";
pub const __printflike = @compileError("unable to translate macro: undefined identifier `__format__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:429:9
pub const __printf0like = @compileError("unable to translate macro: undefined identifier `__format__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:431:9
pub const __scanflike = @compileError("unable to translate macro: undefined identifier `__format__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:433:9
pub const __osloglike = @compileError("unable to translate macro: undefined identifier `__format__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:435:9
pub const __IDSTRING = @compileError("unable to translate C expr: unexpected token 'static'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:438:9
pub const __COPYRIGHT = @compileError("unable to translate macro: undefined identifier `copyright`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:441:9
pub const __RCSID = @compileError("unable to translate macro: undefined identifier `rcsid`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:445:9
pub const __SCCSID = @compileError("unable to translate macro: undefined identifier `sccsid`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:449:9
pub const __PROJECT_VERSION = @compileError("unable to translate macro: undefined identifier `project_version`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:453:9
pub inline fn __FBSDID(s: anytype) void {
    _ = &s;
    return;
}
pub const __DECONST = @compileError("unable to translate C expr: unexpected token 'const'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:462:9
pub const __DEVOLATILE = @compileError("unable to translate C expr: unexpected token 'volatile'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:466:9
pub const __DEQUALIFY = @compileError("unable to translate C expr: unexpected token 'const'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:470:9
pub const __alloc_align = @compileError("unable to translate macro: undefined identifier `alloc_align`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:479:9
pub const __alloc_size = @compileError("unable to translate macro: undefined identifier `alloc_size`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:500:9
pub const __has_safe_buffers = @as(c_int, 0);
pub const __unsafe_buffer_usage = "";
pub const __unsafe_buffer_usage_begin = "";
pub const __unsafe_buffer_usage_end = "";
pub const __DARWIN_ONLY_64_BIT_INO_T = @as(c_int, 1);
pub const __DARWIN_ONLY_UNIX_CONFORMANCE = @as(c_int, 1);
pub const __DARWIN_ONLY_VERS_1050 = @as(c_int, 1);
pub const __DARWIN_UNIX03 = @as(c_int, 1);
pub const __DARWIN_64_BIT_INO_T = @as(c_int, 1);
pub const __DARWIN_VERS_1050 = @as(c_int, 1);
pub const __DARWIN_NON_CANCELABLE = @as(c_int, 0);
pub const __DARWIN_SUF_UNIX03 = "";
pub const __DARWIN_SUF_64_BIT_INO_T = "";
pub const __DARWIN_SUF_1050 = "";
pub const __DARWIN_SUF_NON_CANCELABLE = "";
pub const __DARWIN_SUF_EXTSN = "$DARWIN_EXTSN";
pub const __DARWIN_ALIAS = @compileError("unable to translate C expr: unexpected token '__asm'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:790:9
pub const __DARWIN_ALIAS_C = @compileError("unable to translate C expr: unexpected token '__asm'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:791:9
pub const __DARWIN_ALIAS_I = @compileError("unable to translate C expr: unexpected token '__asm'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:792:9
pub const __DARWIN_NOCANCEL = @compileError("unable to translate C expr: unexpected token '__asm'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:793:9
pub const __DARWIN_INODE64 = @compileError("unable to translate C expr: unexpected token '__asm'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:794:9
pub const __DARWIN_1050 = @compileError("unable to translate C expr: unexpected token '__asm'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:796:9
pub const __DARWIN_1050ALIAS = @compileError("unable to translate C expr: unexpected token '__asm'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:797:9
pub const __DARWIN_1050ALIAS_C = @compileError("unable to translate C expr: unexpected token '__asm'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:798:9
pub const __DARWIN_1050ALIAS_I = @compileError("unable to translate C expr: unexpected token '__asm'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:799:9
pub const __DARWIN_1050INODE64 = @compileError("unable to translate C expr: unexpected token '__asm'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:800:9
pub const __DARWIN_EXTSN = @compileError("unable to translate C expr: unexpected token '__asm'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:802:9
pub const __DARWIN_EXTSN_C = @compileError("unable to translate C expr: unexpected token '__asm'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:803:9
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_2_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_2_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_2_2(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_3_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_3_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_3_2(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_4_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_4_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_4_2(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_4_3(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_5_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_5_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_6_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_6_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_7_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_7_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_8_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_8_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_8_2(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_8_3(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_8_4(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_9_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_9_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_9_2(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_9_3(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_10_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_10_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_10_2(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_10_3(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_11_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_11_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_11_2(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_11_3(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_11_4(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_12_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_12_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_12_2(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_12_3(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_12_4(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_13_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_13_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_13_2(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_13_3(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_13_4(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_13_5(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_13_6(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_13_7(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_14_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_14_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_14_2(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_14_3(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_14_5(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_14_6(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_14_7(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_14_8(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_2(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_3(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_4(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_5(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_6(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_7(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_15_8(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_16_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_16_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_16_2(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_16_3(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_16_4(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_16_5(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_16_6(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_16_7(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_17_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_17_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_17_2(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_17_3(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_17_4(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_17_5(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_17_6(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_17_7(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_18_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_18_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_18_2(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_18_3(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_18_4(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_18_5(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_18_6(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_19_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_26_0(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_26_1(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_26_2(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_26_3(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_IPHONE___IPHONE_26_4(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_0(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_1(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_2(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_3(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_4(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_5(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_6(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_7(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_8(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_9(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_10(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_10_2(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_10_3(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_11(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_11_2(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_11_3(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_11_4(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_12(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_12_1(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_12_2(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_12_4(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_13(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_13_1(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_13_2(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_13_4(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_14(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_14_1(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_14_4(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_14_5(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_14_6(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_15(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_15_1(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_15_4(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_10_16(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_11_0(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_11_1(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_11_3(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_11_4(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_11_5(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_11_6(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_12_0(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_12_1(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_12_2(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_12_3(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_12_4(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_12_5(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_12_6(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_12_7(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_13_0(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_13_1(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_13_2(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_13_3(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_13_4(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_13_5(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_13_6(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_13_7(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_14_0(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_14_1(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_14_2(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_14_3(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_14_4(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_14_5(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_14_6(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_14_7(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_15_0(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_15_1(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_15_2(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_15_3(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_15_4(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_15_5(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_15_6(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_16_0(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_26_0(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_26_1(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_26_2(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_26_3(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __DARWIN_ALIAS_STARTING_MAC___MAC_26_4(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub const __DARWIN_ALIAS_STARTING = @compileError("unable to translate macro: undefined identifier `__DARWIN_ALIAS_STARTING_MAC_`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:813:9
pub const ___POSIX_C_DEPRECATED_STARTING_198808L = "";
pub const ___POSIX_C_DEPRECATED_STARTING_199009L = "";
pub const ___POSIX_C_DEPRECATED_STARTING_199209L = "";
pub const ___POSIX_C_DEPRECATED_STARTING_199309L = "";
pub const ___POSIX_C_DEPRECATED_STARTING_199506L = "";
pub const ___POSIX_C_DEPRECATED_STARTING_200112L = "";
pub const ___POSIX_C_DEPRECATED_STARTING_200809L = "";
pub const __POSIX_C_DEPRECATED = @compileError("unable to translate macro: undefined identifier `___POSIX_C_DEPRECATED_STARTING_`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:876:9
pub const __DARWIN_C_ANSI = @as(c_long, 0o10000);
pub const __DARWIN_C_FULL = @as(c_long, 900000);
pub const __DARWIN_C_LEVEL = __DARWIN_C_FULL;
pub const __STDC_WANT_LIB_EXT1__ = @as(c_int, 1);
pub const __DARWIN_NO_LONG_LONG = @as(c_int, 0);
pub const _DARWIN_FEATURE_64_BIT_INODE = @as(c_int, 1);
pub const _DARWIN_FEATURE_ONLY_64_BIT_INODE = @as(c_int, 1);
pub const _DARWIN_FEATURE_ONLY_VERS_1050 = @as(c_int, 1);
pub const _DARWIN_FEATURE_ONLY_UNIX_CONFORMANCE = @as(c_int, 1);
pub const _DARWIN_FEATURE_UNIX_CONFORMANCE = @as(c_int, 3);
pub const __CAST_AWAY_QUALIFIER = @compileError("unable to translate macro: undefined identifier `_Pragma`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:974:9
pub const __XNU_PRIVATE_EXTERN = @compileError("unable to translate macro: undefined identifier `visibility`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:988:9
pub const __has_ptrcheck = @as(c_int, 0);
pub const __single = "";
pub const __unsafe_indexable = "";
pub inline fn __counted_by(N: anytype) void {
    _ = &N;
    return;
}
pub inline fn __counted_by_or_null(N: anytype) void {
    _ = &N;
    return;
}
pub inline fn __sized_by(N: anytype) void {
    _ = &N;
    return;
}
pub inline fn __sized_by_or_null(N: anytype) void {
    _ = &N;
    return;
}
pub inline fn __ended_by(E: anytype) void {
    _ = &E;
    return;
}
pub inline fn __terminated_by(T: anytype) void {
    _ = &T;
    return;
}
pub const __null_terminated = "";
pub inline fn __ptrcheck_abi_assume_single() void {
    return;
}
pub inline fn __ptrcheck_abi_assume_unsafe_indexable() void {
    return;
}
pub inline fn __unsafe_forge_bidi_indexable(T: anytype, P: anytype, S: anytype) @TypeOf(T(P)) {
    _ = &T;
    _ = &P;
    _ = &S;
    return T(P);
}
pub const __unsafe_forge_single = __helpers.CAST_OR_CALL;
pub inline fn __unsafe_forge_terminated_by(T: anytype, P: anytype, E: anytype) @TypeOf(T(P)) {
    _ = &T;
    _ = &P;
    _ = &E;
    return T(P);
}
pub const __unsafe_forge_null_terminated = __helpers.CAST_OR_CALL;
pub inline fn __terminated_by_to_indexable(P: anytype) @TypeOf(P) {
    _ = &P;
    return P;
}
pub inline fn __unsafe_terminated_by_to_indexable(P: anytype) @TypeOf(P) {
    _ = &P;
    return P;
}
pub inline fn __null_terminated_to_indexable(P: anytype) @TypeOf(P) {
    _ = &P;
    return P;
}
pub inline fn __unsafe_null_terminated_to_indexable(P: anytype) @TypeOf(P) {
    _ = &P;
    return P;
}
pub inline fn __unsafe_terminated_by_from_indexable(T: anytype, P: anytype) @TypeOf(P) {
    _ = &T;
    _ = &P;
    return P;
}
pub inline fn __unsafe_null_terminated_from_indexable(P: anytype) @TypeOf(P) {
    _ = &P;
    return P;
}
pub const __array_decay_dicards_count_in_parameters = "";
pub const __ptrcheck_unavailable = "";
pub inline fn __ptrcheck_unavailable_r(REPLACEMENT: anytype) void {
    _ = &REPLACEMENT;
    return;
}
pub const __ASSUME_PTR_ABI_SINGLE_BEGIN = __ptrcheck_abi_assume_single();
pub const __ASSUME_PTR_ABI_SINGLE_END = __ptrcheck_abi_assume_unsafe_indexable();
pub const __header_indexable = "";
pub const __header_bidi_indexable = "";
pub const __compiler_barrier = @compileError("unable to translate C expr: unexpected token '__asm__'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:1073:9
pub const __enum_open = "";
pub const __enum_closed = "";
pub const __enum_options = "";
pub const __enum_decl = @compileError("unable to translate C expr: unexpected token 'typedef'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:1106:9
pub const __enum_closed_decl = @compileError("unable to translate C expr: unexpected token 'typedef'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:1108:9
pub const __options_decl = @compileError("unable to translate C expr: unexpected token 'typedef'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:1110:9
pub const __options_closed_decl = @compileError("unable to translate C expr: unexpected token 'typedef'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/cdefs.h:1112:9
pub const __kernel_ptr_semantics = "";
pub const __kernel_data_semantics = "";
pub const __kernel_dual_semantics = "";
pub const __xnu_data_size = "";
pub const __xnu_returns_data_pointer = "";
pub const _LIBC_BOUNDS_H_ = "";
pub inline fn _LIBC_COUNT(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn _LIBC_COUNT_OR_NULL(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn _LIBC_SIZE(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn _LIBC_SIZE_OR_NULL(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn _LIBC_ENDED_BY(x: anytype) void {
    _ = &x;
    return;
}
pub const _LIBC_SINGLE = "";
pub const _LIBC_UNSAFE_INDEXABLE = "";
pub const _LIBC_CSTR = "";
pub const _LIBC_NULL_TERMINATED = "";
pub inline fn _LIBC_FLEX_COUNT(FIELD: anytype, INTCOUNT: anytype) @TypeOf(INTCOUNT) {
    _ = &FIELD;
    _ = &INTCOUNT;
    return INTCOUNT;
}
pub inline fn _LIBC_SINGLE_BY_DEFAULT() void {
    return;
}
pub inline fn _LIBC_PTRCHECK_REPLACED(R: anytype) void {
    _ = &R;
    return;
}
pub inline fn _LIBC_FORGE_PTR(P: anytype, S: anytype) @TypeOf(P) {
    _ = &P;
    _ = &S;
    return P;
}
pub const __TYPES_H_ = "";
pub const _SYS__TYPES_H_ = "";
pub const _BSD_MACHINE__TYPES_H_ = "";
pub const _BSD_ARM__TYPES_H_ = "";
pub const __DARWIN_NULL = __helpers.cast(?*anyopaque, @as(c_int, 0));
pub const _SYS__PTHREAD_TYPES_H_ = "";
pub const __PTHREAD_SIZE__ = @as(c_int, 8176);
pub const __PTHREAD_ATTR_SIZE__ = @as(c_int, 56);
pub const __PTHREAD_MUTEXATTR_SIZE__ = @as(c_int, 8);
pub const __PTHREAD_MUTEX_SIZE__ = @as(c_int, 56);
pub const __PTHREAD_CONDATTR_SIZE__ = @as(c_int, 8);
pub const __PTHREAD_COND_SIZE__ = @as(c_int, 40);
pub const __PTHREAD_ONCE_SIZE__ = @as(c_int, 8);
pub const __PTHREAD_RWLOCK_SIZE__ = @as(c_int, 192);
pub const __PTHREAD_RWLOCKATTR_SIZE__ = @as(c_int, 16);
pub const __offsetof = @compileError("unable to translate macro: undefined identifier `__builtin_offsetof`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/_types.h:97:9
pub const __strfmonlike = @compileError("unable to translate macro: undefined identifier `__format__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/_types.h:34:9
pub const __strftimelike = @compileError("unable to translate macro: undefined identifier `__format__`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/_types.h:36:9
pub const __DARWIN_WCHAR_MAX = __WCHAR_MAX__;
pub const __DARWIN_WCHAR_MIN = -__helpers.promoteIntLiteral(c_int, 0x7fffffff, .hex) - @as(c_int, 1);
pub const __DARWIN_WEOF = __helpers.cast(__darwin_wint_t, -@as(c_int, 1));
pub const _FORTIFY_SOURCE = @as(c_int, 2);
pub const _SYS_WAIT_H_ = "";
pub const _PID_T = "";
pub const _ID_T = "";
pub const _SYS_SIGNAL_H_ = "";
pub const __SYS_APPLEAPIOPTS_H__ = "";
pub const __APPLE_API_STANDARD = "";
pub const __APPLE_API_STABLE = "";
pub const __APPLE_API_EVOLVING = "";
pub const __APPLE_API_UNSTABLE = "";
pub const __APPLE_API_PRIVATE = "";
pub const __APPLE_API_OBSOLETE = "";
pub const __DARWIN_NSIG = @as(c_int, 32);
pub const NSIG = __DARWIN_NSIG;
pub const _BSD_MACHINE_SIGNAL_H_ = "";
pub const _ARM_SIGNAL_ = @as(c_int, 1);
pub const SIGHUP = @as(c_int, 1);
pub const SIGINT = @as(c_int, 2);
pub const SIGQUIT = @as(c_int, 3);
pub const SIGILL = @as(c_int, 4);
pub const SIGTRAP = @as(c_int, 5);
pub const SIGABRT = @as(c_int, 6);
pub const SIGIOT = SIGABRT;
pub const SIGEMT = @as(c_int, 7);
pub const SIGFPE = @as(c_int, 8);
pub const SIGKILL = @as(c_int, 9);
pub const SIGBUS = @as(c_int, 10);
pub const SIGSEGV = @as(c_int, 11);
pub const SIGSYS = @as(c_int, 12);
pub const SIGPIPE = @as(c_int, 13);
pub const SIGALRM = @as(c_int, 14);
pub const SIGTERM = @as(c_int, 15);
pub const SIGURG = @as(c_int, 16);
pub const SIGSTOP = @as(c_int, 17);
pub const SIGTSTP = @as(c_int, 18);
pub const SIGCONT = @as(c_int, 19);
pub const SIGCHLD = @as(c_int, 20);
pub const SIGTTIN = @as(c_int, 21);
pub const SIGTTOU = @as(c_int, 22);
pub const SIGIO = @as(c_int, 23);
pub const SIGXCPU = @as(c_int, 24);
pub const SIGXFSZ = @as(c_int, 25);
pub const SIGVTALRM = @as(c_int, 26);
pub const SIGPROF = @as(c_int, 27);
pub const SIGWINCH = @as(c_int, 28);
pub const SIGINFO = @as(c_int, 29);
pub const SIGUSR1 = @as(c_int, 30);
pub const SIGUSR2 = @as(c_int, 31);
pub const SIG_DFL = @compileError("unable to translate C expr: expected ')' instead got '('"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/signal.h:131:9
pub const SIG_IGN = @compileError("unable to translate C expr: expected ')' instead got '('"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/signal.h:132:9
pub const SIG_HOLD = @compileError("unable to translate C expr: expected ')' instead got '('"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/signal.h:133:9
pub const SIG_ERR = @compileError("unable to translate C expr: expected ')' instead got '('"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/signal.h:134:9
pub const _BSD_MACHINE__MCONTEXT_H_ = "";
pub const __ARM_MCONTEXT_H_ = "";
pub const _MACH_MACHINE__STRUCTS_H_ = "";
pub const _MACH_ARM__STRUCTS_H_ = "";
pub const _BSD_MACHINE_TYPES_H_ = "";
pub const _ARM_MACHTYPES_H_ = "";
pub const _MACHTYPES_H_ = "";
pub const _INT8_T = "";
pub const _INT16_T = "";
pub const _INT32_T = "";
pub const _INT64_T = "";
pub const _U_INT8_T = "";
pub const _U_INT16_T = "";
pub const _U_INT32_T = "";
pub const _U_INT64_T = "";
pub const _INTPTR_T = "";
pub const _UINTPTR_T = "";
pub const USER_ADDR_NULL = __helpers.cast(user_addr_t, @as(c_int, 0));
pub inline fn CAST_USER_ADDR_T(a_ptr: anytype) user_addr_t {
    _ = &a_ptr;
    return __helpers.cast(user_addr_t, __helpers.cast(usize, a_ptr));
}
pub const _STRUCT_ARM_EXCEPTION_STATE = struct___darwin_arm_exception_state;
pub const _STRUCT_ARM_EXCEPTION_STATE64 = struct___darwin_arm_exception_state64;
pub const _STRUCT_ARM_EXCEPTION_STATE64_V2 = struct___darwin_arm_exception_state64_v2;
pub const _STRUCT_ARM_THREAD_STATE = struct___darwin_arm_thread_state;
pub const __DARWIN_OPAQUE_ARM_THREAD_STATE64 = @as(c_int, 0);
pub const _STRUCT_ARM_THREAD_STATE64 = struct___darwin_arm_thread_state64;
pub inline fn __darwin_arm_thread_state64_get_pc(ts: anytype) @TypeOf(ts.__pc) {
    _ = &ts;
    return ts.__pc;
}
pub inline fn __darwin_arm_thread_state64_get_pc_fptr(ts: anytype) ?*anyopaque {
    _ = &ts;
    return __helpers.cast(?*anyopaque, __helpers.cast(usize, ts.__pc));
}
pub const __darwin_arm_thread_state64_set_pc_fptr = @compileError("unable to translate C expr: expected ')' instead got '='"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/mach/arm/_structs.h:437:9
pub const __darwin_arm_thread_state64_set_pc_presigned_fptr = @compileError("unable to translate C expr: expected ')' instead got '='"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/mach/arm/_structs.h:440:9
pub inline fn __darwin_arm_thread_state64_get_lr(ts: anytype) @TypeOf(ts.__lr) {
    _ = &ts;
    return ts.__lr;
}
pub inline fn __darwin_arm_thread_state64_get_lr_fptr(ts: anytype) ?*anyopaque {
    _ = &ts;
    return __helpers.cast(?*anyopaque, __helpers.cast(usize, ts.__lr));
}
pub const __darwin_arm_thread_state64_set_lr_fptr = @compileError("unable to translate C expr: expected ')' instead got '='"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/mach/arm/_structs.h:449:9
pub const __darwin_arm_thread_state64_set_lr_presigned_fptr = @compileError("unable to translate C expr: expected ')' instead got '='"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/mach/arm/_structs.h:452:9
pub inline fn __darwin_arm_thread_state64_get_sp(ts: anytype) @TypeOf(ts.__sp) {
    _ = &ts;
    return ts.__sp;
}
pub const __darwin_arm_thread_state64_set_sp = @compileError("unable to translate C expr: expected ')' instead got '='"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/mach/arm/_structs.h:458:9
pub inline fn __darwin_arm_thread_state64_get_fp(ts: anytype) @TypeOf(ts.__fp) {
    _ = &ts;
    return ts.__fp;
}
pub const __darwin_arm_thread_state64_set_fp = @compileError("unable to translate C expr: expected ')' instead got '='"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/mach/arm/_structs.h:464:9
pub const __darwin_arm_thread_state64_ptrauth_strip = __helpers.DISCARD;
pub const _STRUCT_ARM_VFP_STATE = struct___darwin_arm_vfp_state;
pub const _STRUCT_ARM_NEON_STATE64 = struct___darwin_arm_neon_state64;
pub const _STRUCT_ARM_NEON_STATE = struct___darwin_arm_neon_state;
pub const _STRUCT_ARM_PAGEIN_STATE = struct___arm_pagein_state;
pub const _STRUCT_ARM_SME_STATE = struct___darwin_arm_sme_state;
pub const _STRUCT_ARM_SVE_Z_STATE = struct___darwin_arm_sve_z_state;
pub const _STRUCT_ARM_SVE_P_STATE = struct___darwin_arm_sve_p_state;
pub const _STRUCT_ARM_SME_ZA_STATE = struct___darwin_arm_sme_za_state;
pub const _STRUCT_ARM_SME2_STATE = struct___darwin_arm_sme2_state;
pub const _STRUCT_ARM_LEGACY_DEBUG_STATE = struct___arm_legacy_debug_state;
pub const _STRUCT_ARM_DEBUG_STATE32 = struct___darwin_arm_debug_state32;
pub const _STRUCT_ARM_DEBUG_STATE64 = struct___darwin_arm_debug_state64;
pub const _STRUCT_ARM_CPMU_STATE64 = struct___darwin_arm_cpmu_state64;
pub const _STRUCT_MCONTEXT32 = struct___darwin_mcontext32;
pub const _STRUCT_MCONTEXT64 = struct___darwin_mcontext64;
pub const _MCONTEXT_T = "";
pub const _STRUCT_MCONTEXT = _STRUCT_MCONTEXT64;
pub const _PTHREAD_ATTR_T = "";
pub const _STRUCT_SIGALTSTACK = struct___darwin_sigaltstack;
pub const _STRUCT_UCONTEXT = struct___darwin_ucontext;
pub const _SIGSET_T = "";
pub const _SIZE_T = "";
pub const _UID_T = "";
pub const SIGEV_NONE = @as(c_int, 0);
pub const SIGEV_SIGNAL = @as(c_int, 1);
pub const SIGEV_THREAD = @as(c_int, 3);
pub const SIGEV_KEVENT = @as(c_int, 4);
pub const ILL_NOOP = @as(c_int, 0);
pub const ILL_ILLOPC = @as(c_int, 1);
pub const ILL_ILLTRP = @as(c_int, 2);
pub const ILL_PRVOPC = @as(c_int, 3);
pub const ILL_ILLOPN = @as(c_int, 4);
pub const ILL_ILLADR = @as(c_int, 5);
pub const ILL_PRVREG = @as(c_int, 6);
pub const ILL_COPROC = @as(c_int, 7);
pub const ILL_BADSTK = @as(c_int, 8);
pub const FPE_NOOP = @as(c_int, 0);
pub const FPE_FLTDIV = @as(c_int, 1);
pub const FPE_FLTOVF = @as(c_int, 2);
pub const FPE_FLTUND = @as(c_int, 3);
pub const FPE_FLTRES = @as(c_int, 4);
pub const FPE_FLTINV = @as(c_int, 5);
pub const FPE_FLTSUB = @as(c_int, 6);
pub const FPE_INTDIV = @as(c_int, 7);
pub const FPE_INTOVF = @as(c_int, 8);
pub const SEGV_NOOP = @as(c_int, 0);
pub const SEGV_MAPERR = @as(c_int, 1);
pub const SEGV_ACCERR = @as(c_int, 2);
pub const BUS_NOOP = @as(c_int, 0);
pub const BUS_ADRALN = @as(c_int, 1);
pub const BUS_ADRERR = @as(c_int, 2);
pub const BUS_OBJERR = @as(c_int, 3);
pub const TRAP_BRKPT = @as(c_int, 1);
pub const TRAP_TRACE = @as(c_int, 2);
pub const CLD_NOOP = @as(c_int, 0);
pub const CLD_EXITED = @as(c_int, 1);
pub const CLD_KILLED = @as(c_int, 2);
pub const CLD_DUMPED = @as(c_int, 3);
pub const CLD_TRAPPED = @as(c_int, 4);
pub const CLD_STOPPED = @as(c_int, 5);
pub const CLD_CONTINUED = @as(c_int, 6);
pub const POLL_IN = @as(c_int, 1);
pub const POLL_OUT = @as(c_int, 2);
pub const POLL_MSG = @as(c_int, 3);
pub const POLL_ERR = @as(c_int, 4);
pub const POLL_PRI = @as(c_int, 5);
pub const POLL_HUP = @as(c_int, 6);
pub const sa_handler = __sigaction_u.__sa_handler;
pub const sa_sigaction = __sigaction_u.__sa_sigaction;
pub const SA_ONSTACK = @as(c_int, 0x0001);
pub const SA_RESTART = @as(c_int, 0x0002);
pub const SA_RESETHAND = @as(c_int, 0x0004);
pub const SA_NOCLDSTOP = @as(c_int, 0x0008);
pub const SA_NODEFER = @as(c_int, 0x0010);
pub const SA_NOCLDWAIT = @as(c_int, 0x0020);
pub const SA_SIGINFO = @as(c_int, 0x0040);
pub const SA_USERTRAMP = @as(c_int, 0x0100);
pub const SA_64REGSET = @as(c_int, 0x0200);
pub const SA_USERSPACE_MASK = (((((SA_ONSTACK | SA_RESTART) | SA_RESETHAND) | SA_NOCLDSTOP) | SA_NODEFER) | SA_NOCLDWAIT) | SA_SIGINFO;
pub const SIG_BLOCK = @as(c_int, 1);
pub const SIG_UNBLOCK = @as(c_int, 2);
pub const SIG_SETMASK = @as(c_int, 3);
pub const SI_USER = __helpers.promoteIntLiteral(c_int, 0x10001, .hex);
pub const SI_QUEUE = __helpers.promoteIntLiteral(c_int, 0x10002, .hex);
pub const SI_TIMER = __helpers.promoteIntLiteral(c_int, 0x10003, .hex);
pub const SI_ASYNCIO = __helpers.promoteIntLiteral(c_int, 0x10004, .hex);
pub const SI_MESGQ = __helpers.promoteIntLiteral(c_int, 0x10005, .hex);
pub const SS_ONSTACK = @as(c_int, 0x0001);
pub const SS_DISABLE = @as(c_int, 0x0004);
pub const MINSIGSTKSZ = __helpers.promoteIntLiteral(c_int, 32768, .decimal);
pub const SIGSTKSZ = __helpers.promoteIntLiteral(c_int, 131072, .decimal);
pub const SV_ONSTACK = SA_ONSTACK;
pub const SV_INTERRUPT = SA_RESTART;
pub const SV_RESETHAND = SA_RESETHAND;
pub const SV_NODEFER = SA_NODEFER;
pub const SV_NOCLDSTOP = SA_NOCLDSTOP;
pub const SV_SIGINFO = SA_SIGINFO;
pub const sv_onstack = @compileError("unable to translate macro: undefined identifier `sv_flags`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/signal.h:362:9
pub inline fn sigmask(m: anytype) @TypeOf(@as(c_int, 1) << (m - @as(c_int, 1))) {
    _ = &m;
    return @as(c_int, 1) << (m - @as(c_int, 1));
}
pub const BADSIG = SIG_ERR;
pub const _SYS_RESOURCE_H_ = "";
pub const __CLANG_STDINT_H = "";
pub const _STDINT_H_ = "";
pub const __WORDSIZE = @as(c_int, 64);
pub const _UINT8_T = "";
pub const _UINT16_T = "";
pub const _UINT32_T = "";
pub const _UINT64_T = "";
pub const _INTMAX_T = "";
pub const _UINTMAX_T = "";
pub inline fn INT8_C(v: anytype) @TypeOf(v) {
    _ = &v;
    return v;
}
pub inline fn INT16_C(v: anytype) @TypeOf(v) {
    _ = &v;
    return v;
}
pub inline fn INT32_C(v: anytype) @TypeOf(v) {
    _ = &v;
    return v;
}
pub const INT64_C = __helpers.LL_SUFFIX;
pub inline fn UINT8_C(v: anytype) @TypeOf(v) {
    _ = &v;
    return v;
}
pub inline fn UINT16_C(v: anytype) @TypeOf(v) {
    _ = &v;
    return v;
}
pub const UINT32_C = __helpers.U_SUFFIX;
pub const UINT64_C = __helpers.ULL_SUFFIX;
pub const INTMAX_C = __helpers.L_SUFFIX;
pub const UINTMAX_C = __helpers.UL_SUFFIX;
pub const INT8_MAX = @as(c_int, 127);
pub const INT16_MAX = @as(c_int, 32767);
pub const INT32_MAX = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const INT64_MAX = @as(c_longlong, 9223372036854775807);
pub const INT8_MIN = -@as(c_int, 128);
pub const INT16_MIN = -__helpers.promoteIntLiteral(c_int, 32768, .decimal);
pub const INT32_MIN = -INT32_MAX - @as(c_int, 1);
pub const INT64_MIN = -INT64_MAX - @as(c_int, 1);
pub const UINT8_MAX = @as(c_int, 255);
pub const UINT16_MAX = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT32_MAX = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT64_MAX = @as(c_ulonglong, 18446744073709551615);
pub const INT_LEAST8_MIN = INT8_MIN;
pub const INT_LEAST16_MIN = INT16_MIN;
pub const INT_LEAST32_MIN = INT32_MIN;
pub const INT_LEAST64_MIN = INT64_MIN;
pub const INT_LEAST8_MAX = INT8_MAX;
pub const INT_LEAST16_MAX = INT16_MAX;
pub const INT_LEAST32_MAX = INT32_MAX;
pub const INT_LEAST64_MAX = INT64_MAX;
pub const UINT_LEAST8_MAX = UINT8_MAX;
pub const UINT_LEAST16_MAX = UINT16_MAX;
pub const UINT_LEAST32_MAX = UINT32_MAX;
pub const UINT_LEAST64_MAX = UINT64_MAX;
pub const INT_FAST8_MIN = INT8_MIN;
pub const INT_FAST16_MIN = INT16_MIN;
pub const INT_FAST32_MIN = INT32_MIN;
pub const INT_FAST64_MIN = INT64_MIN;
pub const INT_FAST8_MAX = INT8_MAX;
pub const INT_FAST16_MAX = INT16_MAX;
pub const INT_FAST32_MAX = INT32_MAX;
pub const INT_FAST64_MAX = INT64_MAX;
pub const UINT_FAST8_MAX = UINT8_MAX;
pub const UINT_FAST16_MAX = UINT16_MAX;
pub const UINT_FAST32_MAX = UINT32_MAX;
pub const UINT_FAST64_MAX = UINT64_MAX;
pub const INTPTR_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const INTPTR_MIN = -INTPTR_MAX - @as(c_int, 1);
pub const UINTPTR_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const INTMAX_MAX = INTMAX_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINTMAX_MAX = UINTMAX_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INTMAX_MIN = -INTMAX_MAX - @as(c_int, 1);
pub const PTRDIFF_MIN = INTMAX_MIN;
pub const PTRDIFF_MAX = INTMAX_MAX;
pub const SIZE_MAX = UINTPTR_MAX;
pub const RSIZE_MAX = SIZE_MAX >> @as(c_int, 1);
pub const WCHAR_MAX = __WCHAR_MAX__;
pub const WCHAR_MIN = -WCHAR_MAX - @as(c_int, 1);
pub const WINT_MIN = INT32_MIN;
pub const WINT_MAX = INT32_MAX;
pub const SIG_ATOMIC_MIN = INT32_MIN;
pub const SIG_ATOMIC_MAX = INT32_MAX;
pub const _STRUCT_TIMEVAL = struct_timeval;
pub const PRIO_PROCESS = @as(c_int, 0);
pub const PRIO_PGRP = @as(c_int, 1);
pub const PRIO_USER = @as(c_int, 2);
pub const PRIO_DARWIN_THREAD = @as(c_int, 3);
pub const PRIO_DARWIN_PROCESS = @as(c_int, 4);
pub const PRIO_MIN = -@as(c_int, 20);
pub const PRIO_MAX = @as(c_int, 20);
pub const PRIO_DARWIN_BG = @as(c_int, 0x1000);
pub const PRIO_DARWIN_NONUI = @as(c_int, 0x1001);
pub const RUSAGE_SELF = @as(c_int, 0);
pub const RUSAGE_CHILDREN = -@as(c_int, 1);
pub const ru_first = @compileError("unable to translate macro: undefined identifier `ru_ixrss`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/resource.h:164:9
pub const ru_last = @compileError("unable to translate macro: undefined identifier `ru_nivcsw`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/resource.h:178:9
pub const RUSAGE_INFO_V0 = @as(c_int, 0);
pub const RUSAGE_INFO_V1 = @as(c_int, 1);
pub const RUSAGE_INFO_V2 = @as(c_int, 2);
pub const RUSAGE_INFO_V3 = @as(c_int, 3);
pub const RUSAGE_INFO_V4 = @as(c_int, 4);
pub const RUSAGE_INFO_V5 = @as(c_int, 5);
pub const RUSAGE_INFO_V6 = @as(c_int, 6);
pub const RUSAGE_INFO_CURRENT = RUSAGE_INFO_V6;
pub const RU_PROC_RUNS_RESLIDE = @as(c_int, 0x00000001);
pub const RLIM_INFINITY = (__helpers.cast(__uint64_t, @as(c_int, 1)) << @as(c_int, 63)) - @as(c_int, 1);
pub const RLIM_SAVED_MAX = RLIM_INFINITY;
pub const RLIM_SAVED_CUR = RLIM_INFINITY;
pub const RLIMIT_CPU = @as(c_int, 0);
pub const RLIMIT_FSIZE = @as(c_int, 1);
pub const RLIMIT_DATA = @as(c_int, 2);
pub const RLIMIT_STACK = @as(c_int, 3);
pub const RLIMIT_CORE = @as(c_int, 4);
pub const RLIMIT_AS = @as(c_int, 5);
pub const RLIMIT_RSS = RLIMIT_AS;
pub const RLIMIT_MEMLOCK = @as(c_int, 6);
pub const RLIMIT_NPROC = @as(c_int, 7);
pub const RLIMIT_NOFILE = @as(c_int, 8);
pub const RLIM_NLIMITS = @as(c_int, 9);
pub const _RLIMIT_POSIX_FLAG = @as(c_int, 0x1000);
pub const RLIMIT_WAKEUPS_MONITOR = @as(c_int, 0x1);
pub const RLIMIT_CPU_USAGE_MONITOR = @as(c_int, 0x2);
pub const RLIMIT_THREAD_CPULIMITS = @as(c_int, 0x3);
pub const RLIMIT_FOOTPRINT_INTERVAL = @as(c_int, 0x4);
pub const WAKEMON_ENABLE = @as(c_int, 0x01);
pub const WAKEMON_DISABLE = @as(c_int, 0x02);
pub const WAKEMON_GET_PARAMS = @as(c_int, 0x04);
pub const WAKEMON_SET_DEFAULTS = @as(c_int, 0x08);
pub const WAKEMON_MAKE_FATAL = @as(c_int, 0x10);
pub const CPUMON_MAKE_FATAL = @as(c_int, 0x1000);
pub const FOOTPRINT_INTERVAL_RESET = @as(c_int, 0x1);
pub const IOPOL_TYPE_DISK = @as(c_int, 0);
pub const IOPOL_TYPE_VFS_ATIME_UPDATES = @as(c_int, 2);
pub const IOPOL_TYPE_VFS_MATERIALIZE_DATALESS_FILES = @as(c_int, 3);
pub const IOPOL_TYPE_VFS_STATFS_NO_DATA_VOLUME = @as(c_int, 4);
pub const IOPOL_TYPE_VFS_TRIGGER_RESOLVE = @as(c_int, 5);
pub const IOPOL_TYPE_VFS_IGNORE_CONTENT_PROTECTION = @as(c_int, 6);
pub const IOPOL_TYPE_VFS_IGNORE_PERMISSIONS = @as(c_int, 7);
pub const IOPOL_TYPE_VFS_SKIP_MTIME_UPDATE = @as(c_int, 8);
pub const IOPOL_TYPE_VFS_ALLOW_LOW_SPACE_WRITES = @as(c_int, 9);
pub const IOPOL_TYPE_VFS_DISALLOW_RW_FOR_O_EVTONLY = @as(c_int, 10);
pub const IOPOL_TYPE_VFS_ENTITLED_RESERVE_ACCESS = @as(c_int, 14);
pub const IOPOL_SCOPE_PROCESS = @as(c_int, 0);
pub const IOPOL_SCOPE_THREAD = @as(c_int, 1);
pub const IOPOL_SCOPE_DARWIN_BG = @as(c_int, 2);
pub const IOPOL_DEFAULT = @as(c_int, 0);
pub const IOPOL_IMPORTANT = @as(c_int, 1);
pub const IOPOL_PASSIVE = @as(c_int, 2);
pub const IOPOL_THROTTLE = @as(c_int, 3);
pub const IOPOL_UTILITY = @as(c_int, 4);
pub const IOPOL_STANDARD = @as(c_int, 5);
pub const IOPOL_APPLICATION = IOPOL_STANDARD;
pub const IOPOL_NORMAL = IOPOL_IMPORTANT;
pub const IOPOL_ATIME_UPDATES_DEFAULT = @as(c_int, 0);
pub const IOPOL_ATIME_UPDATES_OFF = @as(c_int, 1);
pub const IOPOL_MATERIALIZE_DATALESS_FILES_DEFAULT = @as(c_int, 0);
pub const IOPOL_MATERIALIZE_DATALESS_FILES_OFF = @as(c_int, 1);
pub const IOPOL_MATERIALIZE_DATALESS_FILES_ON = @as(c_int, 2);
pub const IOPOL_MATERIALIZE_DATALESS_FILES_ORIG = @as(c_int, 4);
pub const IOPOL_MATERIALIZE_DATALESS_FILES_BASIC_MASK = @as(c_int, 3);
pub const IOPOL_VFS_STATFS_NO_DATA_VOLUME_DEFAULT = @as(c_int, 0);
pub const IOPOL_VFS_STATFS_FORCE_NO_DATA_VOLUME = @as(c_int, 1);
pub const IOPOL_VFS_TRIGGER_RESOLVE_DEFAULT = @as(c_int, 0);
pub const IOPOL_VFS_TRIGGER_RESOLVE_OFF = @as(c_int, 1);
pub const IOPOL_VFS_CONTENT_PROTECTION_DEFAULT = @as(c_int, 0);
pub const IOPOL_VFS_CONTENT_PROTECTION_IGNORE = @as(c_int, 1);
pub const IOPOL_VFS_IGNORE_PERMISSIONS_OFF = @as(c_int, 0);
pub const IOPOL_VFS_IGNORE_PERMISSIONS_ON = @as(c_int, 1);
pub const IOPOL_VFS_SKIP_MTIME_UPDATE_OFF = @as(c_int, 0);
pub const IOPOL_VFS_SKIP_MTIME_UPDATE_ON = @as(c_int, 1);
pub const IOPOL_VFS_SKIP_MTIME_UPDATE_IGNORE = @as(c_int, 2);
pub const IOPOL_VFS_ALLOW_LOW_SPACE_WRITES_OFF = @as(c_int, 0);
pub const IOPOL_VFS_ALLOW_LOW_SPACE_WRITES_ON = @as(c_int, 1);
pub const IOPOL_VFS_DISALLOW_RW_FOR_O_EVTONLY_DEFAULT = @as(c_int, 0);
pub const IOPOL_VFS_DISALLOW_RW_FOR_O_EVTONLY_ON = @as(c_int, 1);
pub const IOPOL_VFS_NOCACHE_WRITE_FS_BLKSIZE_DEFAULT = @as(c_int, 0);
pub const IOPOL_VFS_NOCACHE_WRITE_FS_BLKSIZE_ON = @as(c_int, 1);
pub const IOPOL_VFS_ENTITLED_RESERVE_ACCESS_OFF = @as(c_int, 0);
pub const IOPOL_VFS_ENTITLED_RESERVE_ACCESS_ON = @as(c_int, 1);
pub const WNOHANG = @as(c_int, 0x00000001);
pub const WUNTRACED = @as(c_int, 0x00000002);
pub inline fn _W_INT(w: anytype) @TypeOf(__helpers.cast([*c]c_int, &w).*) {
    _ = &w;
    return __helpers.cast([*c]c_int, &w).*;
}
pub const WCOREFLAG = @as(c_int, 0o200);
pub inline fn _WSTATUS(x: anytype) @TypeOf(_W_INT(x) & @as(c_int, 0o177)) {
    _ = &x;
    return _W_INT(x) & @as(c_int, 0o177);
}
pub const _WSTOPPED = @as(c_int, 0o177);
pub inline fn WEXITSTATUS(x: anytype) @TypeOf((_W_INT(x) >> @as(c_int, 8)) & @as(c_int, 0x000000ff)) {
    _ = &x;
    return (_W_INT(x) >> @as(c_int, 8)) & @as(c_int, 0x000000ff);
}
pub inline fn WSTOPSIG(x: anytype) @TypeOf(_W_INT(x) >> @as(c_int, 8)) {
    _ = &x;
    return _W_INT(x) >> @as(c_int, 8);
}
pub inline fn WIFCONTINUED(x: anytype) @TypeOf((_WSTATUS(x) == _WSTOPPED) and (WSTOPSIG(x) == @as(c_int, 0x13))) {
    _ = &x;
    return (_WSTATUS(x) == _WSTOPPED) and (WSTOPSIG(x) == @as(c_int, 0x13));
}
pub inline fn WIFSTOPPED(x: anytype) @TypeOf((_WSTATUS(x) == _WSTOPPED) and (WSTOPSIG(x) != @as(c_int, 0x13))) {
    _ = &x;
    return (_WSTATUS(x) == _WSTOPPED) and (WSTOPSIG(x) != @as(c_int, 0x13));
}
pub inline fn WIFEXITED(x: anytype) @TypeOf(_WSTATUS(x) == @as(c_int, 0)) {
    _ = &x;
    return _WSTATUS(x) == @as(c_int, 0);
}
pub inline fn WIFSIGNALED(x: anytype) @TypeOf((_WSTATUS(x) != _WSTOPPED) and (_WSTATUS(x) != @as(c_int, 0))) {
    _ = &x;
    return (_WSTATUS(x) != _WSTOPPED) and (_WSTATUS(x) != @as(c_int, 0));
}
pub inline fn WTERMSIG(x: anytype) @TypeOf(_WSTATUS(x)) {
    _ = &x;
    return _WSTATUS(x);
}
pub inline fn WCOREDUMP(x: anytype) @TypeOf(_W_INT(x) & WCOREFLAG) {
    _ = &x;
    return _W_INT(x) & WCOREFLAG;
}
pub inline fn W_EXITCODE(ret: anytype, sig: anytype) @TypeOf((ret << @as(c_int, 8)) | sig) {
    _ = &ret;
    _ = &sig;
    return (ret << @as(c_int, 8)) | sig;
}
pub inline fn W_STOPCODE(sig: anytype) @TypeOf((sig << @as(c_int, 8)) | _WSTOPPED) {
    _ = &sig;
    return (sig << @as(c_int, 8)) | _WSTOPPED;
}
pub const WEXITED = @as(c_int, 0x00000004);
pub const WSTOPPED = @as(c_int, 0x00000008);
pub const WCONTINUED = @as(c_int, 0x00000010);
pub const WNOWAIT = @as(c_int, 0x00000020);
pub const WAIT_ANY = -@as(c_int, 1);
pub const WAIT_MYPGRP = @as(c_int, 0);
pub const _BSD_MACHINE_ENDIAN_H_ = "";
pub const _ARM__ENDIAN_H_ = "";
pub const _QUAD_HIGHWORD = @as(c_int, 1);
pub const _QUAD_LOWWORD = @as(c_int, 0);
pub const _SYS__ENDIAN_H_ = "";
pub const _BSD_MACHINE__ENDIAN_H_ = "";
pub const _ARM___ENDIAN_H_ = "";
pub const _SYS___ENDIAN_H_ = "";
pub const __DARWIN_LITTLE_ENDIAN = @as(c_int, 1234);
pub const __DARWIN_BIG_ENDIAN = @as(c_int, 4321);
pub const __DARWIN_PDP_ENDIAN = @as(c_int, 3412);
pub const LITTLE_ENDIAN = __DARWIN_LITTLE_ENDIAN;
pub const BIG_ENDIAN = __DARWIN_BIG_ENDIAN;
pub const PDP_ENDIAN = __DARWIN_PDP_ENDIAN;
pub const __DARWIN_BYTE_ORDER = __DARWIN_LITTLE_ENDIAN;
pub const BYTE_ORDER = __DARWIN_BYTE_ORDER;
pub const _OS__OSBYTEORDER_H = "";
pub inline fn __DARWIN_OSSwapConstInt16(x: anytype) __uint16_t {
    _ = &x;
    return __helpers.cast(__uint16_t, ((__helpers.cast(__uint16_t, x) & @as(c_uint, 0xff00)) >> @as(c_int, 8)) | ((__helpers.cast(__uint16_t, x) & @as(c_uint, 0x00ff)) << @as(c_int, 8)));
}
pub inline fn __DARWIN_OSSwapConstInt32(x: anytype) __uint32_t {
    _ = &x;
    return __helpers.cast(__uint32_t, ((((__helpers.cast(__uint32_t, x) & __helpers.promoteIntLiteral(c_uint, 0xff000000, .hex)) >> @as(c_int, 24)) | ((__helpers.cast(__uint32_t, x) & __helpers.promoteIntLiteral(c_uint, 0x00ff0000, .hex)) >> @as(c_int, 8))) | ((__helpers.cast(__uint32_t, x) & @as(c_uint, 0x0000ff00)) << @as(c_int, 8))) | ((__helpers.cast(__uint32_t, x) & @as(c_uint, 0x000000ff)) << @as(c_int, 24)));
}
pub inline fn __DARWIN_OSSwapConstInt64(x: anytype) __uint64_t {
    _ = &x;
    return __helpers.cast(__uint64_t, ((((((((__helpers.cast(__uint64_t, x) & @as(c_ulonglong, 0xff00000000000000)) >> @as(c_int, 56)) | ((__helpers.cast(__uint64_t, x) & @as(c_ulonglong, 0x00ff000000000000)) >> @as(c_int, 40))) | ((__helpers.cast(__uint64_t, x) & @as(c_ulonglong, 0x0000ff0000000000)) >> @as(c_int, 24))) | ((__helpers.cast(__uint64_t, x) & @as(c_ulonglong, 0x000000ff00000000)) >> @as(c_int, 8))) | ((__helpers.cast(__uint64_t, x) & @as(c_ulonglong, 0x00000000ff000000)) << @as(c_int, 8))) | ((__helpers.cast(__uint64_t, x) & @as(c_ulonglong, 0x0000000000ff0000)) << @as(c_int, 24))) | ((__helpers.cast(__uint64_t, x) & @as(c_ulonglong, 0x000000000000ff00)) << @as(c_int, 40))) | ((__helpers.cast(__uint64_t, x) & @as(c_ulonglong, 0x00000000000000ff)) << @as(c_int, 56)));
}
pub const _OS__OSBYTEORDERARM_H = "";
pub const __DARWIN_OS_INLINE = @compileError("unable to translate C expr: unexpected token 'static'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/libkern/arm/_OSByteOrder.h:38:17
pub inline fn __DARWIN_OSSwapInt16(x: anytype) __uint16_t {
    _ = &x;
    return __helpers.cast(__uint16_t, if (__helpers.cast(bool, __builtin.constant_p(x))) __DARWIN_OSSwapConstInt16(x) else _OSSwapInt16(x));
}
pub inline fn __DARWIN_OSSwapInt32(x: anytype) @TypeOf(if (__helpers.cast(bool, __builtin.constant_p(x))) __DARWIN_OSSwapConstInt32(x) else _OSSwapInt32(x)) {
    _ = &x;
    return if (__helpers.cast(bool, __builtin.constant_p(x))) __DARWIN_OSSwapConstInt32(x) else _OSSwapInt32(x);
}
pub inline fn __DARWIN_OSSwapInt64(x: anytype) @TypeOf(if (__helpers.cast(bool, __builtin.constant_p(x))) __DARWIN_OSSwapConstInt64(x) else _OSSwapInt64(x)) {
    _ = &x;
    return if (__helpers.cast(bool, __builtin.constant_p(x))) __DARWIN_OSSwapConstInt64(x) else _OSSwapInt64(x);
}
pub inline fn ntohs(x: anytype) @TypeOf(__DARWIN_OSSwapInt16(x)) {
    _ = &x;
    return __DARWIN_OSSwapInt16(x);
}
pub inline fn htons(x: anytype) @TypeOf(__DARWIN_OSSwapInt16(x)) {
    _ = &x;
    return __DARWIN_OSSwapInt16(x);
}
pub inline fn ntohl(x: anytype) @TypeOf(__DARWIN_OSSwapInt32(x)) {
    _ = &x;
    return __DARWIN_OSSwapInt32(x);
}
pub inline fn htonl(x: anytype) @TypeOf(__DARWIN_OSSwapInt32(x)) {
    _ = &x;
    return __DARWIN_OSSwapInt32(x);
}
pub inline fn ntohll(x: anytype) @TypeOf(__DARWIN_OSSwapInt64(x)) {
    _ = &x;
    return __DARWIN_OSSwapInt64(x);
}
pub inline fn htonll(x: anytype) @TypeOf(__DARWIN_OSSwapInt64(x)) {
    _ = &x;
    return __DARWIN_OSSwapInt64(x);
}
pub const NTOHL = @compileError("unable to translate C expr: unexpected token '='"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/_endian.h:144:9
pub const NTOHS = @compileError("unable to translate C expr: unexpected token '='"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/_endian.h:145:9
pub const NTOHLL = @compileError("unable to translate C expr: unexpected token '='"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/_endian.h:146:9
pub const HTONL = @compileError("unable to translate C expr: unexpected token '='"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/_endian.h:147:9
pub const HTONS = @compileError("unable to translate C expr: unexpected token '='"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/_endian.h:148:9
pub const HTONLL = @compileError("unable to translate C expr: unexpected token '='"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/_endian.h:149:9
pub const w_termsig = @compileError("unable to translate macro: undefined identifier `w_T`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/wait.h:229:9
pub const w_coredump = @compileError("unable to translate macro: undefined identifier `w_T`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/wait.h:230:9
pub const w_retcode = @compileError("unable to translate macro: undefined identifier `w_T`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/wait.h:231:9
pub const w_stopval = @compileError("unable to translate macro: undefined identifier `w_S`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/wait.h:232:9
pub const w_stopsig = @compileError("unable to translate macro: undefined identifier `w_S`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/sys/wait.h:233:9
pub const _ALLOCA_H_ = "";
pub const __alloca = @compileError("unable to translate macro: undefined identifier `__builtin_alloca`"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/alloca.h:43:9
pub const _CT_RUNE_T = "";
pub const _RUNE_T = "";
pub const _WCHAR_T = "";
pub const NULL = __DARWIN_NULL;
pub const EXIT_FAILURE = @as(c_int, 1);
pub const EXIT_SUCCESS = @as(c_int, 0);
pub const RAND_MAX = __helpers.promoteIntLiteral(c_int, 0x7fffffff, .hex);
// /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/libc/include/any-darwin-any/_stdlib.h:139:9: warning: macro 'MB_CUR_MAX' contains a runtime value, translated to function
pub inline fn MB_CUR_MAX() @TypeOf(__mb_cur_max) {
    return __mb_cur_max;
}
pub const _MALLOC_UNDERSCORE_MALLOC_H_ = "";
pub const _MALLOC_UNDERSCORE_MALLOC_TYPE_H_ = "";
pub const _MALLOC_UNDERSCORE_PTRCHECK_H_ = "";
pub const _MALLOC_TYPE_MALLOC_BACKDEPLOY_PUBLIC = @as(c_int, 1);
pub inline fn _MALLOC_TYPED(override: anytype, type_param_pos: anytype) void {
    _ = &override;
    _ = &type_param_pos;
    return;
}
pub const __ABORT_H_ = "";
pub const _DEV_T = "";
pub const _MODE_T = "";
pub const _LIBCPP_STDLIB_H = "";
pub const @"bool" = bool;
pub const @"true" = @as(c_int, 1);
pub const @"false" = @as(c_int, 0);
pub const __bool_true_false_are_defined = @as(c_int, 1);
pub const alignas = @compileError("unable to translate C expr: unexpected token '_Alignas'"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/compiler/aro/include/stdalign.h:6:9
pub const alignof = @compileError("unable to translate C expr: expected '(' instead got ''"); // /opt/homebrew/Cellar/zig/0.16.0_1/lib/zig/compiler/aro/include/stdalign.h:7:9
pub const __alignas_is_defined = @as(c_int, 1);
pub const __alignof_is_defined = @as(c_int, 1);
pub const FLT_RADIX = __FLT_RADIX__;
pub const FLT_MANT_DIG = __FLT_MANT_DIG__;
pub const DBL_MANT_DIG = __DBL_MANT_DIG__;
pub const LDBL_MANT_DIG = __LDBL_MANT_DIG__;
pub const FLT_EVAL_METHOD = __FLT_EVAL_METHOD__;
pub const DECIMAL_DIG = __DECIMAL_DIG__;
pub const FLT_DIG = __FLT_DIG__;
pub const DBL_DIG = __DBL_DIG__;
pub const LDBL_DIG = __LDBL_DIG__;
pub const FLT_MIN_EXP = __FLT_MIN_EXP__;
pub const DBL_MIN_EXP = __DBL_MIN_EXP__;
pub const LDBL_MIN_EXP = __LDBL_MIN_EXP__;
pub const FLT_MIN_10_EXP = __FLT_MIN_10_EXP__;
pub const DBL_MIN_10_EXP = __DBL_MIN_10_EXP__;
pub const LDBL_MIN_10_EXP = __LDBL_MIN_10_EXP__;
pub const FLT_MAX_EXP = __FLT_MAX_EXP__;
pub const DBL_MAX_EXP = __DBL_MAX_EXP__;
pub const LDBL_MAX_EXP = __LDBL_MAX_EXP__;
pub const FLT_MAX_10_EXP = __FLT_MAX_10_EXP__;
pub const DBL_MAX_10_EXP = __DBL_MAX_10_EXP__;
pub const LDBL_MAX_10_EXP = __LDBL_MAX_10_EXP__;
pub const FLT_MAX = __FLT_MAX__;
pub const DBL_MAX = __DBL_MAX__;
pub const LDBL_MAX = __LDBL_MAX__;
pub const FLT_EPSILON = __FLT_EPSILON__;
pub const DBL_EPSILON = __DBL_EPSILON__;
pub const LDBL_EPSILON = __LDBL_EPSILON__;
pub const FLT_MIN = __FLT_MIN__;
pub const DBL_MIN = __DBL_MIN__;
pub const LDBL_MIN = __LDBL_MIN__;
pub const FLT_TRUE_MIN = __FLT_DENORM_MIN__;
pub const DBL_TRUE_MIN = __DBL_DENORM_MIN__;
pub const LDBL_TRUE_MIN = __LDBL_DENORM_MIN__;
pub const FLT_DECIMAL_DIG = __FLT_DECIMAL_DIG__;
pub const DBL_DECIMAL_DIG = __DBL_DECIMAL_DIG__;
pub const LDBL_DECIMAL_DIG = __LDBL_DECIMAL_DIG__;
pub const FLT_HAS_SUBNORM = "";
pub const DBL_HAS_SUBNORM = "";
pub const LDBL_HAS_SUBNORM = "";
pub const JPC_API = "";
pub const JPC_ENABLE_ASSERTS = @as(c_int, 1);
pub const JPC_DOUBLE_PRECISION = @as(c_int, 0);
pub const JPC_RVEC_ALIGN = alignas(@as(c_int, 16));
pub const JPC_DEBUG_RENDERER = @as(c_int, 0);
pub const _JPC_REFTARGET_HEADER = @compileError("unable to translate macro: undefined identifier `__vfptr_header`"); // /Users/macos/Desktop/Rust/rustcode/bevy3Danimation/deps/zphysics/zphysics-0.2.0-dev-nZDEANvfQgD04nOPqL9KMokfgjzs_wPtHpoLscZScaOa/libs/JoltC/JoltPhysicsC.h:45:9
pub const _JPC_VTABLE_HEADER = @compileError("unable to translate macro: undefined identifier `__vtable_header`"); // /Users/macos/Desktop/Rust/rustcode/bevy3Danimation/deps/zphysics/zphysics-0.2.0-dev-nZDEANvfQgD04nOPqL9KMokfgjzs_wPtHpoLscZScaOa/libs/JoltC/JoltPhysicsC.h:53:9
pub const _JPC_REFTARGET_HEADER_ALIGN_16 = _JPC_REFTARGET_HEADER;
pub const JPC_PI = @as(f32, 3.14159265358979323846);
pub const JPC_COLLISION_GROUP_INVALID_GROUP = __helpers.promoteIntLiteral(c_int, 0xffffffff, .hex);
pub const JPC_COLLISION_GROUP_INVALID_SUB_GROUP = __helpers.promoteIntLiteral(c_int, 0xffffffff, .hex);
pub const JPC_BODY_ID_INVALID = __helpers.promoteIntLiteral(c_int, 0xffffffff, .hex);
pub const JPC_BODY_ID_INDEX_BITS = __helpers.promoteIntLiteral(c_int, 0x007fffff, .hex);
pub const JPC_BODY_ID_SEQUENCE_BITS = __helpers.promoteIntLiteral(c_int, 0x7F800000, .hex);
pub const JPC_BODY_ID_SEQUENCE_SHIFT = @as(c_int, 23);
pub const JPC_SUB_SHAPE_ID_EMPTY = __helpers.promoteIntLiteral(c_int, 0xffffffff, .hex);
pub const JPC_FLT_EPSILON = FLT_EPSILON;
pub inline fn JPC_ID_EQ(a: anytype, b: anytype) @TypeOf(a.id == b.id) {
    _ = &a;
    _ = &b;
    return a.id == b.id;
}
pub const _JPC_IS_FREED_BODY_BIT = @as(c_int, 0x1);
pub inline fn JPC_IS_VALID_BODY_POINTER(body_ptr: anytype) @TypeOf((__helpers.cast(usize, body_ptr) & _JPC_IS_FREED_BODY_BIT) == @as(c_int, 0)) {
    _ = &body_ptr;
    return (__helpers.cast(usize, body_ptr) & _JPC_IS_FREED_BODY_BIT) == @as(c_int, 0);
}
pub inline fn JPC_TRY_GET_BODY(all_body_ptrs: anytype, body_id: anytype) @TypeOf(if (__helpers.cast(bool, (JPC_IS_VALID_BODY_POINTER(all_body_ptrs[@as(usize, @intCast(body_id.id & JPC_BODY_ID_INDEX_BITS))]) != 0) and (all_body_ptrs[@as(usize, @intCast(body_id.id & JPC_BODY_ID_INDEX_BITS))].*.id.id == body_id.id))) all_body_ptrs[@as(usize, @intCast(body_id.id & JPC_BODY_ID_INDEX_BITS))] else NULL) {
    _ = &all_body_ptrs;
    _ = &body_id;
    return if (__helpers.cast(bool, (JPC_IS_VALID_BODY_POINTER(all_body_ptrs[@as(usize, @intCast(body_id.id & JPC_BODY_ID_INDEX_BITS))]) != 0) and (all_body_ptrs[@as(usize, @intCast(body_id.id & JPC_BODY_ID_INDEX_BITS))].*.id.id == body_id.id))) all_body_ptrs[@as(usize, @intCast(body_id.id & JPC_BODY_ID_INDEX_BITS))] else NULL;
}
pub const __darwin_pthread_handler_rec = struct___darwin_pthread_handler_rec;
pub const _opaque_pthread_attr_t = struct__opaque_pthread_attr_t;
pub const _opaque_pthread_cond_t = struct__opaque_pthread_cond_t;
pub const _opaque_pthread_condattr_t = struct__opaque_pthread_condattr_t;
pub const _opaque_pthread_mutex_t = struct__opaque_pthread_mutex_t;
pub const _opaque_pthread_mutexattr_t = struct__opaque_pthread_mutexattr_t;
pub const _opaque_pthread_once_t = struct__opaque_pthread_once_t;
pub const _opaque_pthread_rwlock_t = struct__opaque_pthread_rwlock_t;
pub const _opaque_pthread_rwlockattr_t = struct__opaque_pthread_rwlockattr_t;
pub const _opaque_pthread_t = struct__opaque_pthread_t;
pub const __darwin_arm_exception_state = struct___darwin_arm_exception_state;
pub const __darwin_arm_exception_state64 = struct___darwin_arm_exception_state64;
pub const __darwin_arm_exception_state64_v2 = struct___darwin_arm_exception_state64_v2;
pub const __darwin_arm_thread_state = struct___darwin_arm_thread_state;
pub const __darwin_arm_thread_state64 = struct___darwin_arm_thread_state64;
pub const __darwin_arm_vfp_state = struct___darwin_arm_vfp_state;
pub const __darwin_arm_neon_state64 = struct___darwin_arm_neon_state64;
pub const __darwin_arm_neon_state = struct___darwin_arm_neon_state;
pub const __arm_pagein_state = struct___arm_pagein_state;
pub const __darwin_arm_sme_state = struct___darwin_arm_sme_state;
pub const __darwin_arm_sve_z_state = struct___darwin_arm_sve_z_state;
pub const __darwin_arm_sve_p_state = struct___darwin_arm_sve_p_state;
pub const __darwin_arm_sme_za_state = struct___darwin_arm_sme_za_state;
pub const __darwin_arm_sme2_state = struct___darwin_arm_sme2_state;
pub const __arm_legacy_debug_state = struct___arm_legacy_debug_state;
pub const __darwin_arm_debug_state32 = struct___darwin_arm_debug_state32;
pub const __darwin_arm_debug_state64 = struct___darwin_arm_debug_state64;
pub const __darwin_arm_cpmu_state64 = struct___darwin_arm_cpmu_state64;
pub const __darwin_mcontext32 = struct___darwin_mcontext32;
pub const __darwin_mcontext64 = struct___darwin_mcontext64;
pub const __darwin_sigaltstack = struct___darwin_sigaltstack;
pub const __darwin_ucontext = struct___darwin_ucontext;
pub const sigval = union_sigval;
pub const sigevent = struct_sigevent;
pub const __siginfo = struct___siginfo;
pub const __sigaction_u = union___sigaction_u;
pub const __sigaction = struct___sigaction;
pub const sigaction = struct_sigaction;
pub const sigvec = struct_sigvec;
pub const sigstack = struct_sigstack;
pub const timeval = struct_timeval;
pub const rusage = struct_rusage;
pub const rusage_info_v0 = struct_rusage_info_v0;
pub const rusage_info_v1 = struct_rusage_info_v1;
pub const rusage_info_v2 = struct_rusage_info_v2;
pub const rusage_info_v3 = struct_rusage_info_v3;
pub const rusage_info_v4 = struct_rusage_info_v4;
pub const rusage_info_v5 = struct_rusage_info_v5;
pub const rusage_info_v6 = struct_rusage_info_v6;
pub const rlimit = struct_rlimit;
pub const proc_rlimit_control_wakeupmon = struct_proc_rlimit_control_wakeupmon;
pub const _malloc_zone_t = struct__malloc_zone_t;
pub const JPC_PhysicsStepListenerVTable = struct_JPC_PhysicsStepListenerVTable;
