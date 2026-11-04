#!/usr/bin/env bash
# WorkBuddy 用户级技能一键安装脚本
# 用法：
#   ./install.sh              # 安装全部技能
#   ./install.sh <skill-name> # 只安装指定技能
set -euo pipefail

SKILLS_DIR="$(cd "$(dirname "$0")/skills" && pwd)"
TARGET_DIR="${HOME}/.workbuddy/skills"

# 支持通过环境变量指定目标目录（默认用户级）
if [ -n "${WORKBUDDY_SKILLS_DIR:-}" ]; then
  TARGET_DIR="${WORKBUDDY_SKILLS_DIR}"
fi

mkdir -p "${TARGET_DIR}"

install_one() {
  local name="$1"
  local src="${SKILLS_DIR}/${name}"
  local dst="${TARGET_DIR}/${name}"

  if [ ! -f "${src}/SKILL.md" ]; then
    echo "⚠️  跳过 ${name}：缺少 SKILL.md"
    return 1
  fi

  # 已存在同名技能时先备份
  if [ -d "${dst}" ]; then
    local backup="${dst}.bak.$(date +%Y%m%d%H%M%S)"
    mv "${dst}" "${backup}"
    echo "🔁 已存在 ${name}，旧版本备份到 ${backup}"
  fi

  cp -R "${src}" "${dst}"
  echo "✅ 已安装 ${name} → ${dst}"
}

if [ $# -gt 0 ]; then
  for name in "$@"; do
    install_one "${name}" || true
  done
else
  echo "📦 安装目录：${TARGET_DIR}"
  failed=0
  for src in "${SKILLS_DIR}"/*/; do
    name="$(basename "${src}")"
    install_one "${name}" || failed=1
  done
  echo ""
  echo "🎉 完成！重启 WorkBuddy（或新开会话）后技能生效。"
  echo "   可在 WorkBuddy 设置 → 技能管理 中确认已加载。"
  exit ${failed}
fi
