#!/usr/bin/env bash
# 卸载本仓库安装到 ~/.workbuddy/skills/ 的技能
# 用法：
#   ./uninstall.sh              # 卸载全部本仓库包含的技能
#   ./uninstall.sh <skill-name> # 只卸载指定技能
set -euo pipefail

SKILLS_DIR="$(cd "$(dirname "$0")/skills" && pwd)"
TARGET_DIR="${HOME}/.workbuddy/skills"

if [ -n "${WORKBUDDY_SKILLS_DIR:-}" ]; then
  TARGET_DIR="${WORKBUDDY_SKILLS_DIR}"
fi

uninstall_one() {
  local name="$1"
  local dst="${TARGET_DIR}/${name}"
  if [ -d "${dst}" ]; then
    rm -rf "${dst}"
    echo "🗑️  已卸载 ${name}"
  else
    echo "ℹ️  未安装：${name}"
  fi
}

if [ $# -gt 0 ]; then
  for name in "$@"; do
    uninstall_one "${name}"
  done
else
  for src in "${SKILLS_DIR}"/*/; do
    uninstall_one "$(basename "${src}")"
  done
  echo "🎉 卸载完成！"
fi
