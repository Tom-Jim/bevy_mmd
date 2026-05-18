#!/bin/bash

# 如果传入的第一个参数是 --debug
if [ "$1" == "--debug" ]; then
    echo "🐛 [Debug Mode] 正在编译并启动 LLDB 内存错误抓取..."
    # 先编译出 release 版本
    cargo build --release

    # 挂载 LLDB 运行，遇到崩溃自动打印回溯栈并退出
    rust-lldb --batch -o run -o "bt all" -o quit target/release/bevy3Danimation > lldb_output.txt 2>&1

    echo "📄 运行结束，正在检索 EXC_BAD_ACCESS 错误..."
    # 过滤并显示崩溃周围的日志
    cat lldb_output.txt | grep -A 30 "stop reason = EXC_BAD_ACCESS"
    echo "提示: 完整的 LLDB 日志已保存到 lldb_output.txt"

else
    # 默认情况，正常启动
    echo "🚀 [Normal Mode] 正常启动 Release 版本..."
    cargo run --release
fi
