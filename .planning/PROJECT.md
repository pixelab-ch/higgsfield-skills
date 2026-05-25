# Higgsfield Skills — Multi-Model Prompt & Generation Toolkit

## What This Is

A collection of Claude Agent Skills that turn Claude into an expert prompt engineer for AI image and video generation on the **Higgsfield** platform. Each skill covers a creative style or use case (cinematic, anime, fight scenes, e-commerce ads, product 360°, real estate, etc.), produces a production-ready prompt, maps it to the most appropriate Higgsfield model, and can optionally submit the generation directly through the Higgsfield MCP server. It is the rearchitecture of the existing `higgsfield-seedance2-jineng` repo, which today only targets a single model (Seedance 2.0) and only outputs static prompt text.

## Core Value

Given a creative request, Claude produces a model-correct, spec-accurate prompt and (on explicit confirmation) generates the asset on Higgsfield — without the user needing to know which of the ~38 Higgsfield models to pick or what parameters each accepts.

## Requirements

### Validated

<!-- Shipped and confirmed valuable. -->

The existing repo provides a starting point (not yet validated against the new goals):

- ✓ 15 style/use-case skills with rich, discovery-ready frontmatter (`name` + keyword-heavy `description`) — existing
- ✓ Substantial, genuinely varied prompt-craft content per skill (hooks, camera, lighting, sound, worked examples, common-mistakes) — existing
- ✓ Bilingual ambition (EN + zh-CN) and an interactive `install.sh` — existing (both currently flawed)

### Active

<!-- Current scope. Building toward these. -->

- [ ] Skills are **model-aware**: each maps its style to the right Higgsfield model(s) and emits parameters valid for that model (resolution, duration, aspect ratio, genre, media roles)
- [ ] Skills support the **full Higgsfield model ecosystem** for both image and video, not just Seedance 2.0
- [ ] Skills offer **opt-in generation** via the Higgsfield MCP (`generate_image` / `generate_video`): build prompt → confirm → submit → report job — generation is always an explicit choice (credit cost)
- [ ] **Factual/spec accuracy**: remove invented specs (e.g. "4K 3840×2160", ".webm output"); each spec reflects the actual model's real constraints
- [ ] **Progressive disclosure**: lean `SKILL.md` (overview + workflow + model routing) that references `references/*.md` for the heavy encyclopedic content, instead of 700–2300-line monoliths
- [ ] **Proper LICENSE** file present and referenced correctly
- [ ] **Install script** works for both Claude Code (`~/.claude/skills`) and Claude Desktop, on macOS/Linux (and ideally Windows)
- [ ] **English only**: drop the half-translated zh-CN; ship no translated skill variants (revised after the pilot — FR maintenance across 15 skills isn't justified for a Claude/developer audience)
- [ ] README and docs accurately describe the real structure (no phantom `LICENSE`/`logs.md` references, correct stats)

### Out of Scope

<!-- Explicit boundaries. Includes reasoning to prevent re-adding. -->

- Cross-provider abstraction (direct Runway / Sora / Midjourney / native Kling APIs) — decided: stay within the Higgsfield ecosystem, which already aggregates Bytedance, Google, Kling, xAI, Black Forest Labs, etc. behind one MCP
- Automatic/unattended generation that spends credits without confirmation — decided: generation is opt-in only
- Translated skill variants (FR or any other language) — decided: English only. Claude and the developer audience read English; N×15 translation maintenance isn't justified. zh-CN removed, no FR added.
- Building a separate web UI or hosted service — these are skills, the runtime is Claude Code / Desktop

## Context

**The existing repo (audited 2026-05-24):**
- 15 skills under `skills/NN-name/SKILL.md`, 31,725 total lines across EN + zh-CN
- Strengths: excellent frontmatter; varied, real prompt-engineering content; consistent pedagogy
- Weaknesses found: zero MCP/tool integration (pure static docs); factual spec inconsistencies (README says 720p, fight-scenes says "1080p/4K/.webm"); README lists `LICENSE` and `logs.md` that don't exist; zh-CN translations range from real to 99% untranslated copies (15-real-estate: 28/2344 lines changed); `install.sh` targets the Claude **Desktop** path only, not Claude Code; monolithic SKILL.md files work against the Agent Skills progressive-disclosure pattern

**Higgsfield model ecosystem (via `mcp__higgsfield__models_explore`, captured 2026-05-24):**
- **Video (~18):** seedance_2_0, seedance_1_5, minimax_hailuo, wan2_6, wan2_7, kling2_6, kling3_0, grok_video, veo3, veo3_1, veo3_1_lite, cinematic_studio_3_0, cinematic_studio_video (v1/v2), marketing_studio_video, higgsfield_preset
- **Image (~20):** nano_banana / _2 / _pro, soul_2 / soul_cinematic / soul_cast / soul_location, seedream_v4_5 / v5_lite, z_image, flux_2 / flux_kontext, kling_omni_image, gpt_image / gpt_image_2, grok_image, cinematic_studio_2_5, marketing_studio_image, ms_image (DTC Ads), image_auto
- Each model declares its own `parameters` (resolution/quality/mode/genre), `aspect_ratios`, `durations`/`duration_range`, and media `roles` (image, start_image, end_image, video, audio). These constraints are the source of truth for per-skill specs.
- Relevant MCP tools available: `generate_image`, `generate_video`, `models_explore`, `job_status`, `job_display`, `media_upload`/`media_confirm`, `presets_show`, `show_plans_and_credits`, `balance`, `select_workspace`.

**Runtime:** Claude Code (primary, `~/.claude/skills`) + Claude Desktop. User works in Claude Code on macOS. User is French.

## Constraints

- **Platform**: Higgsfield only — all generation goes through the Higgsfield MCP server already present in the environment
- **Compatibility**: Must follow the Claude Agent Skills format (YAML frontmatter `name` + `description`; `SKILL.md` + optional `references/`) so skills load in both Claude Code and Desktop
- **Cost**: Generation consumes Higgsfield credits → never generate without explicit user confirmation
- **Accuracy**: Per-model specs must match what `models_explore` reports, not invented numbers
- **Languages**: English only (no translated skill variants)
- **Source of truth for model constraints**: the live `models_explore` catalogue, not hardcoded assumptions that can drift

## Key Decisions

<!-- Decisions that constrain future work. Add throughout project lifecycle. -->

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Stay within Higgsfield ecosystem (no cross-provider) | Higgsfield already aggregates Bytedance/Google/Kling/xAI/BFL behind one MCP; avoids N API integrations | — Pending |
| Generation is opt-in, not automatic | Generation spends credits; user must confirm | — Pending |
| Target Claude Code + Desktop | Where the user runs skills; current install script is broken for Code | — Pending |
| English only (drop zh-CN, no FR) | Chinese was largely untranslated; FR variant maintenance across 15 skills not justified for a Claude/developer audience (revised after pilot review) | ✓ Good |
| Progressive disclosure (lean SKILL.md + references/) | Monolithic 700–2300-line skills waste context on load | — Pending |
| Model routing per skill | Users shouldn't need to know which of ~38 models fits their style | — Pending |

---
*Last updated: 2026-05-25 after pilot review — language scope narrowed to English only*
