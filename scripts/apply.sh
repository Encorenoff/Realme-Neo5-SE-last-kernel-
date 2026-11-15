#!/usr/bin/env bash
# Клонирует ядро OnePlus Ace 2 (OxygenOS 16, 5.10.236) и поднимает его до 5.10.246.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WORK="${1:-$PWD/oneplus_kernel}"
git clone --depth=1 -b oneplus/sm8475_b_16.0.0_ace_2 \
  https://github.com/OnePlusOSS/android_kernel_common_oneplus_sm8475 "$WORK"
cd "$WORK"
grep -E '^SUBLEVEL' Makefile        # ожидается 236
git checkout -q -b neo5se-5.10.246
git apply --whitespace=nowarn "$ROOT/patches/oneplus-ace2-5.10.236-to-5.10.246.patch"
grep -E '^SUBLEVEL' Makefile        # ожидается 246
git add -A && git commit -qm "Update to 5.10.246 (ACK android12-5.10 + stable)"
