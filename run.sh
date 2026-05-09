#!/bin/bash
# 软件闪退时将内存错误保存
cargo build --release
rust-lldb --batch -o run -o "bt all" -o quit target/release/bevy3Danimation > lldb_output.txt 2>&1
cat lldb_output.txt | grep -A 30 "stop reason = EXC_BAD_ACCESS"