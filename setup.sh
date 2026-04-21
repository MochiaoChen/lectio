#!/bin/bash
# Lectio Pro Setup Script (Mainland China Optimized)

echo "🌱 Starting Lectio Pro environment setup..."

# 1. Check for Python
command -v python3 >/dev/null 2>&1 || { echo "❌ Python3 not found. Please install it."; exit 1; }

# 2. Install Python dependencies (Using TUNA Mirror)
echo "📦 Installing Python tools (MarkItDown, yt-dlp, Whisper, pdf2image)..."
# 使用清华镜像源加速下载
python3 -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip
python3 -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple \
    markitdown \
    yt-dlp \
    openai-whisper \
    pdf2image

# 3. Set Hugging Face Mirror (For Whisper models)
echo "🌐 Setting Hugging Face mirror for current session..."
export HF_ENDPOINT="https://hf-mirror.com"

# Suggesting permanent setup for HF mirror
if ! grep -q "HF_ENDPOINT" ~/.bashrc 2>/dev/null; then
    echo "💡 Note: To make Hugging Face mirror permanent, add 'export HF_ENDPOINT=\"https://hf-mirror.com\"' to your ~/.bashrc or ~/.zshrc"
fi

# 4. Check for System Dependencies
echo "🔍 Checking system dependencies..."

check_and_suggest() {
    if ! command -v $1 >/dev/null 2>&1; then
        echo "⚠️ $1 missing. $2"
    fi
}

check_and_suggest "ffmpeg" "Install via: sudo apt install ffmpeg (Ubuntu) or brew install ffmpeg (macOS)"
check_and_suggest "pdftocairo" "Install poppler-utils via: sudo apt install poppler-utils"
check_and_suggest "convert" "Install ImageMagick via: sudo apt install imagemagick"
check_and_suggest "xelatex" "Install TeX Live (Recommended: TUNA Mirror: https://mirrors.tuna.tsinghua.edu.cn/help/CTAN/)"
check_and_suggest "latexmk" "Usually comes with TeX Live."

echo "✅ Setup attempt finished! Please check any warnings above."
