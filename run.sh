#!/usr/bin/env bash
set -euo pipefail

# Build only. Running the Bevy window is intentionally a separate manual step.
exec cargo build --release --locked
