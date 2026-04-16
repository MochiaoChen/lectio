# Lectio (原 Video2Note)

> **Lectio** (拉丁语：阅读/学习/解读) —— 打造学术级讲义的终极工具。
> 将 PDF 幻灯片、零散笔记、YouTube/B站视频一键转化为结构化的 LaTeX 讲义与 Markdown 预览。

本项目托管了一个全能型 Codex skill `lectio`，它缝合了视频解析、幻灯片视觉解析与笔记逻辑重构的核心能力，并引入了多种先进的学习法辅助。

## 核心 Skill: `lectio`

这是一个全能型讲义生成助手，支持多种输入源的混合处理：

| 功能 | 说明 |
|------|------|
| **多源输入** | 支持 PDF 课件、.txt/.md 零散笔记、YouTube URL、B站 URL (BV号) |
| **视觉解析 (VLM)** | 利用 VLM 识别幻灯片/视频帧中的公式 (LaTeX)、图表、架构图与核心文本 |
| **笔记重构** | 将口语化的录音转写或跳跃性的思维笔记“翻译”为书面学术语言 |
| **多平台适配** | YouTube CC 字幕优先；B站字幕缺失时自动触发 Whisper 语音转写 |
| **多格式输出** | 生成 Markdown 预览、专业 LaTeX 源码及编译好的 PDF |
| **学习法增强** | **苏格拉底对话** (启发式提问)、**费曼学习法** (极致简化总结) |
| **自动化闪卡** | 自动提取核心概念生成 **Anki 闪卡 (CSV)**，支持直接导入 |

## 仓库结构

```text
.
├── LICENSE
├── README.md
├── PRD.md
└── skills/
    └── lectio/                # 统一后的全能 Skill
        ├── SKILL.md           # 核心逻辑与写作规则
        ├── agents/
        │   └── openai.yaml    # Agent 元数据
        └── assets/
            └── notes-template.tex  # 专业 LaTeX 模板
```

## Special Features 的实现逻辑

`lectio` 不仅仅是一个转换工具，它内置了以下教学法逻辑：

1.  **苏格拉底启发 (Socratic Dialogue)**：Agent 会在讲义最后自动设计挑战性问题，检验你的深度思考能力。
2.  **费曼压缩 (Feynman Method)**：在每个核心章节末尾，Agent 会用“五岁小孩都能听懂”的语言重新阐述知识点，确保逻辑闭环。
3.  **自动化闪卡 (Anki CSV)**：Agent 会调用工具直接生成 `flashcards.csv`，包含“正面、背面、标签”，方便一键同步至 Anki。

## 使用方式

将 `skills/lectio` 目录放入你的 Codex 技能路径中：

```bash
mkdir -p ~/.codex/skills
cp -R skills/lectio ~/.codex/skills/
```

然后在 Codex 中通过快捷键或指令调用。

## 鸣谢

本项目缝合并改进了以下优秀仓库的思想：
- [llm-note-generator](https://github.com/Stefan0219/llm-note-generator)
- [wdkns-skills](https://github.com/wdkns/wdkns-skills)

## License

MIT License. 详见根目录 `LICENSE`。
