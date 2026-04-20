# Lectio

> **Lectio**（拉丁语：阅读 / 学习 / 解读）—— 打造学术级讲义的终极工具。
> 把 PDF 幻灯片、零散笔记、YouTube / Bilibili 视频一键重构为**结构化 LaTeX 讲义 + Markdown 预览 + Anki 闪卡**。

Lectio 是一个面向 agent 运行时（🦞 opencode 等）的 **skill**，当前在智谱 **GLM** 系列模型上调优并测试。它缝合了视频解析、幻灯片 VLM 视觉解析、笔记逻辑重构的核心能力，并内置多种学习法增强。

## 三种一等工作流

| 模式 | 输入 | 关键动作 |
|------|------|---------|
| **slides → notes** | PDF 课件 / 讲义 | `pdftocairo` 逐页转图 → VLM 提取文字/公式/图表 → **展开**为成段解释（而非抄录关键词） |
| **video → notes**  | YouTube URL / Bilibili BV 号 | `yt-dlp` 拉字幕；无字幕时 `whisper` 转写 → 按时间线组织 → 关键帧 VLM 识别板书/公式 |
| **text → notes**   | `.txt` / `.md` 零散笔记 | 识别口语腔与思维跳跃 → 补全推理链 → 书面学术语言 |

三种输入**可以混用**：例如"视频 + 对应 slides PDF"会同时参考两种源，slides 作为结构骨架、视频作为讲解内容。

## 内置教学法

- **苏格拉底思考题**：全文末尾 3–5 个会让人卡住的开放问题（禁止送分题）。
- **费曼压缩**：每个章节末以"五岁小孩听得懂"的一句话重述本节。
- **自动闪卡**：产出 `flashcards.csv`，字段 `Front,Back,Tags`，直接导入 Anki。

## 输出约定

每次调用产出工作目录下的：

```
notes.md           # Markdown 预览
notes.tex          # LaTeX 源码（基于 assets/notes-template.tex 填充）
notes.pdf          # 编译产物（compile.sh 自动多遍编译）
flashcards.csv     # Anki 导入
assets/            # 封面、幻灯片图、视频关键帧
```

## 仓库结构

```text
.
├── LICENSE
├── README.md
├── setup.sh                          # 安装依赖（Python + 系统工具 + XeLaTeX）
└── skills/
    ├── SKILL.md                      # skill 的权威 prompt 体
    ├── openai.yaml                   # skill 元数据
    ├── assets/
    │   └── notes-template.tex        # LaTeX 模板（骨架，可按材料裁剪）
    └── scripts/
        └── compile.sh                # 多遍编译封装（latexmk / xelatex×2）
```

## 安装

```bash
git clone https://github.com/MochiaoChen/lectio.git
cd lectio
./setup.sh
```

`setup.sh` 会安装 `markitdown` / `yt-dlp` / `openai-whisper` / `pdf2image`，并检查 `ffmpeg` / `poppler` / `imagemagick` / `xelatex` / `latexmk`。缺哪个会给出提示，不会静默失败。

**把 skill 挂到你的 agent 运行时**：

```bash
# 以 opencode 为例
mkdir -p ~/.config/opencode/skills
cp -R skills ~/.config/opencode/skills/lectio

# 或者 Codex 风格
mkdir -p ~/.codex/skills && cp -R skills ~/.codex/skills/lectio
```

## 关于 LaTeX 编译

`notes.tex` 使用 `\tableofcontents` 与交叉引用，**单次 `xelatex` 不够**（TOC 会空）。一律走封装脚本：

```bash
bash skills/scripts/compile.sh notes.tex
```

脚本优先 `latexmk -xelatex` 跑到收敛，没有 latexmk 时回退到 `xelatex` 跑两遍。

## 关于模板的"弹性"

`assets/notes-template.tex` 是**骨架**不是**枷锁**。Skill 在填充时会：

- **必须保留**：`\usepackage` 区块、tcolorbox 定义、编译方式。
- **可以改**：章节结构、标题页、是否保留 TOC、是否保留来源信息框。
- **必须删干净**：用不到的元数据字段（例如纯 slides 输入没有"时长"）整行删掉，不给最终 PDF 留 `[在此填写…]` 占位。

换句话说，模板定义**底线**（包、高亮框、费曼/思考题/溯源），排版与结构按实际材料调整。

## 调优说明（GLM 系列）

`SKILL.md` 中的 prompt 针对智谱 GLM 做了几点处理：

1. 分步执行，每步先声明意图再调工具 —— 避免 GLM 在长上下文里跳步。
2. VLM 抽公式时强制"只输出 LaTeX 源码，不要解释"—— GLM-4V 在无此约束时会加自然语言前后缀。
3. 长视频 transcript 先分段摘要再合并 —— 不要一次塞 30 min 进重构 prompt。

## 鸣谢

本项目缝合并改进了以下优秀仓库的思想：
- [llm-note-generator](https://github.com/Stefan0219/llm-note-generator)
- [wdkns-skills](https://github.com/wdkns/wdkns-skills)

## License

MIT License. 详见根目录 `LICENSE`。
