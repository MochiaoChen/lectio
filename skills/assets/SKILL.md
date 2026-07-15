---
name: lectio
description: Universal lecture note generator. Transforms PDF slides, raw notes, and video URLs into professional Markdown and LaTeX讲义. Features VLM-based slide parsing, logical note reconstruction, and multi-format output (Markdown, LaTeX, Flashcards, Socratic Dialogue).
---

# Lectio (Universal Lecture Note Generator)

Use this skill to transform raw learning materials (PDF slides, messy text notes, or video links from YouTube/Bilibili) into high-quality, structured, and pedagogical course notes.

## Goal

Produce professional Chinese lecture notes that merge multi-modal inputs into a coherent educational deliverable.

The output must:
- **Synthesize Multi-modal Input:** Intelligently combine PDF slides, oral transcripts, and messy user notes.
- **Platform-Specific Robustness:** Handle YouTube CC subtitles and Bilibili's subtitle scarcity (via Whisper fallback).
- **Pedagogical Flow:** Read like a high-quality textbook or a well-structured lecture guide.
- **Multi-format Delivery:** Provide a preview-ready Markdown file AND a professional LaTeX/PDF deliverable.
- **Visual Accuracy:** Extract and reference key frames or slide pages with precise provenance.

## Input Processing

### 1. Source Acquisition
Accept any combination of:
- **PDF Slides:** Convert to images for visual analysis.
- **Text Notes/Transcription:** Messy, oral, or fragmented notes.
- **YouTube URLs:** Extract CC subtitles (prefer manual over auto) and high-res frames.
- **Bilibili URLs:** 
    - **Subtitle Fallback:** CC subtitles → Whisper speech-to-text → Visual-only mode.
    - **Login-gated HD:** Prompt for cookies (`--cookies-from-browser chrome`) for 1080P+.
    - **Multi-part (分P):** Detect and ask which parts to process.

### 2. Visual Parsing (VLM)
- Use VLM to "read" each slide/frame.
- Extract: Formal text, mathematical formulas (LaTeX), diagrams, charts, and table structures.
- Create a **Structured Slide Draft**: A page-indexed summary of what is visually present on each slide.

### 3. Note Reconstruction & Mapping
- **Translation:** Convert "messy notes" or "oral transcripts" into formal, academic Chinese.
- **Alignment:** Map specific note fragments to the corresponding slide page or video timestamp.
- **Cleanup:** Filter platform-specific noise (e.g., "一键三连", "关注投币", sponsorship) while preserving pedagogical value.

## Writing Rules

### 1. Pedagogical Standards
- Follow the **Motivation -> Mechanism -> Example -> Takeaway** structure for each section.
- Be explicit about logical transitions.
- Use `\section{...}` and `\subsection{...}` for structure.

### 2. Markdown Output (Preview)
- **H1/H2/H3 Layering:** Mandatory hierarchical structure.
- **Blockquotes:** Use `> ` for core definitions and important formulas.
- **Images:** Embed links to extracted slides/frames (e.g., `![Slide 5](pic/slide_05.png)`).

### 3. LaTeX Output (Professional PDF)
- **Template:** Use `assets/notes-template.tex`.
- **Boxes:** Use `importantbox`, `knowledgebox`, and `warningbox` for high-signal takeaways.
- **Math:** Use display math `$$...$$` followed by a symbol legend.
- **Figures:** Insert with `\begin{figure}[H]` and include a footnote for provenance (e.g., "Slide 12" or "Video 00:15:22").

### 4. Special Features (Prompt-Driven Implementation)
- **Socratic Dialogue:** At the end of the document, add a `\section{Socratic Dialogue}` (or Markdown equivalent) with 3-5 challenging questions to stimulate active thinking.
- **Feynman Method:** Add a `\subsection{Feynman Summary}` at the end of each major section, explaining the core concept in extremely simple language.
- **Flashcards:** Generate an Anki-compatible CSV file (Columns: Front, Back, Tag) covering the core terminology and concepts.

## Subagent Strategy

For complex lectures, use `spawn_agent` to delegate:
- **`slide-parser`**: Visual extraction from PDFs.
- **`video-processor`**: Subtitle extraction (CC/Whisper) and frame sampling.
- **`note-transformer`**: Text cleaning and formalization.
- **`integration-agent`**: Merging streams into a final draft.

## Delivery

You MUST use the appropriate file-writing tools to save the following to the workspace:
- **`notes.md`**: The structured Markdown preview.
- **`notes.tex`**: The complete LaTeX source.
- **`flashcards.csv`**: Anki-ready flashcards based on the lecture.
- **`assets/`**: All extracted images and the final rendered PDF.

## Final Checklist
- [ ] Are all formulas in LaTeX format?
- [ ] Are Bilibili/YouTube platform noises filtered?
- [ ] Is Whisper used if Bilibili subtitles are missing?
- [ ] Is every figure mapped to a slide number or timestamp?
- [ ] Are Socratic questions and Feynman summaries included?
- [ ] Is the `flashcards.csv` generated?
