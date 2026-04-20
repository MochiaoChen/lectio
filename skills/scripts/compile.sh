#!/usr/bin/env bash
# Lectio — LaTeX 编译封装
#
# 用法: compile.sh <notes.tex>
# 作用: 产出同名 PDF，自动解决 \tableofcontents / \ref / \cite 的多遍依赖。
#
# 优先使用 latexmk（一条命令跑到收敛），否则回退到「xelatex 跑两遍」。
# 两遍是 TOC/交叉引用的下限；若加入了 \cite/bibtex 请使用 latexmk。

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: compile.sh <notes.tex>" >&2
  exit 2
fi

TEX="$1"
DIR="$(dirname "$TEX")"
BASE="$(basename "$TEX" .tex)"

cd "$DIR"

if command -v latexmk >/dev/null 2>&1; then
  # -interaction=nonstopmode 保证在 agent 环境里不挂住；-halt-on-error 让错误立即冒出来
  latexmk -xelatex -interaction=nonstopmode -halt-on-error -file-line-error "$BASE.tex"
  latexmk -c "$BASE.tex" >/dev/null 2>&1 || true   # 清理 aux/log，保留 pdf
else
  echo "⚠️  latexmk 未安装，回退到 xelatex 双遍编译" >&2
  xelatex -interaction=nonstopmode -halt-on-error -file-line-error "$BASE.tex"
  xelatex -interaction=nonstopmode -halt-on-error -file-line-error "$BASE.tex"
fi

echo "✅ 已生成 $DIR/$BASE.pdf"
