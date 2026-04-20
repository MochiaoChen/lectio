#!/bin/bash
# Lectio Pro Setup Script (Skill-only version)

echo "🌱 Starting Lectio Pro environment setup..."

# 1. Check for Python
command -v python3 >/dev/null 2>&1 || { echo "❌ Python3 not found. Please install it."; exit 1; }

# 2. Install Python dependencies (The "Stitched" Tools)
echo "📦 Installing Python tools (MarkItDown, yt-dlp, Whisper, pdf2image)..."
pip install markitdown yt-dlp openai-whisper pdf2image

# 3. Check for System Dependencies (Required by wdkns and llm-note-generator)
echo "🔍 Checking system dependencies..."
# FFmpeg for video/audio
command -v ffmpeg >/dev/null 2>&1 || echo "⚠️ FFmpeg missing (Required for video/audio)."
# Poppler for PDF-to-Image
command -v pdftocairo >/dev/null 2>&1 || echo "⚠️ Poppler missing (Required for PDF slides)."
# ImageMagick (Optional but recommended by wdkns)
command -v convert >/dev/null 2>&1 || echo "⚠️ ImageMagick missing (Recommended for image processing)."
# XeLaTeX + latexmk for compiling notes.tex (TOC/refs need multi-pass)
command -v xelatex >/dev/null 2>&1 || echo "⚠️ xelatex missing (install texlive-xetex / MacTeX / TeX Live)."
command -v latexmk >/dev/null 2>&1 || echo "ℹ️  latexmk not found — compile.sh will fall back to xelatex×2."

echo "✅ Setup complete! You can now use the 'lectio' skill in your CLI."
