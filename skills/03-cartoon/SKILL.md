---
name: higgsfield-cartoon
description: >-
  Crafts cartoon and animation style video prompts for Higgsfield and routes to
  the best model (wan2_7 primary, seedance_2_0 fallback). Use when the user
  wants cartoon, 2D animation, cel-shaded, hand-drawn, illustrated, flat
  animation, or motion graphics animation style video. Triggers on: cartoon,
  animation, cel shading, hand-drawn, illustrated, flat design animation, vector
  animation, retro cartoon, rubber hose, motion graphics, or any animated style.
when_to_use: >-
  Use for Disney-style, Cartoon Network, Studio Ghibli, flat vector explainer,
  pixel art, watercolor animation, claymation, paper cutout, neon line art,
  manga/anime, silhouette puppet, or rubber hose styles. Also for vague requests
  like "make it look animated," "fun colorful style," or "cartoon character."
allowed-tools: >-
  mcp__higgsfield__generate_video
  mcp__higgsfield__generate_image
  mcp__higgsfield__models_explore
  mcp__higgsfield__job_status
  mcp__higgsfield__job_display
  mcp__higgsfield__media_upload
  mcp__higgsfield__media_confirm
  mcp__higgsfield__balance
  mcp__higgsfield__show_plans_and_credits
---

# Higgsfield Cartoon Skill

## What this skill does

Crafts production-ready cartoon and animation video prompts and routes them to the best
Higgsfield model for stylized animated output. On request, it assembles the full
parameter set, surfaces the credit cost, and — after explicit user confirmation —
generates the asset via the opt-in generation flow.

Whether crafting whimsical character animations, dynamic action sequences, or minimalist
motion graphics, this skill provides frameworks, templates, and creative guidance
drawing on 15+ animation style encyclopedias, the 12 core animation principles, hook
frameworks, and worked example prompts.

---

## Model routing

### Primary and fallback video models

| | wan2_7 (primary) | seedance_2_0 (fallback) |
|---|---|---|
| **Rationale** | Clean stylized output for cartoon and animation styles | Use only when primary is unavailable, or user needs genre tags / shorter minimum |
| **Resolution** | `720p`, `1080p` | `480p`, `720p`, `1080p` (def `720p`) |
| **Aspect ratios** | `16:9`, `9:16`, `1:1`, `4:3`, `3:4` | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` |
| **Duration** | 2–15 s (continuous range) — **minimum 2 s** | 4–15 s (continuous range) — minimum 4 s |
| **Tunable params** | None beyond resolution and aspect | `mode` {`std`,`fast`}, `genre` {`auto`,`action`,`horror`,`comedy`,`noir`,`drama`,`epic`} |
| **Media roles** | `start_image`, `end_image`, `audio` | `image`, `start_image`, `end_image`, `video`, `audio` |

**Routing rule:** Use `wan2_7` by default. Only fall back to `seedance_2_0` when (1) the
primary model is unavailable, or (2) the user explicitly accepts seedance_2_0's
constraints after being told what they give up: minimum clip duration becomes 4 s
(cannot generate 2-3 s clips). Gain: `genre` tag for comedy/drama bias, and `image`/
`video` media roles. If the user has not been informed of these trade-offs, stay on
`wan2_7` and let them decide — never switch silently.

**MODEL-06 directive:** If a parameter is rejected at generation time, call
`higgsfield:models_explore` with the target model name to re-verify the live schema.
Full parameter tables: [references/model-specs.md](references/model-specs.md).

### Per-platform quick rule

Vertical `9:16` for TikTok / Reels / Shorts; `16:9` for YouTube and LinkedIn; `1:1`
for Instagram feed. wan2_7's 2-second minimum suits ultra-short social hooks. Full
per-platform table: [references/model-specs.md](references/model-specs.md).

---

## Prompt-building workflow

1. **Gather intent** — Confirm with the user: cartoon style (Disney, Cartoon Network,
   flat vector, Ghibli, pixel art, etc.), character/subject, tone (comedic, whimsical,
   dramatic), target platform, aspect ratio, and desired duration.

2. **Select model** — Apply the routing table above. Choose `wan2_7` by default;
   select `seedance_2_0` only when a routing trigger applies.

3. **Build the prompt** — Use the craft principles in the references below:
   - Opening hook (2-second cartoon attention-capture technique) from
     [references/hooks.md](references/hooks.md)
   - Art style, animation principles, color palette, character design from
     [references/animation-craft.md](references/animation-craft.md)
   - Worked example prompts by style from
     [references/examples.md](references/examples.md)

4. **Present for review** — Show the assembled prompt and all parameters to the user for
   review and refinement **before** any generation call. The user must approve the prompt
   text, model, aspect ratio, and duration.

---

## Opt-in generation

Generation costs Higgsfield credits and requires explicit user confirmation before any
generate call is made. This skill never auto-generates.

**Full step-by-step flow** (confirmation gate, balance/cost surface,
generate → poll → display):
[`../../shared/generation-flow.md`](../../shared/generation-flow.md)

**This skill's primary model:** `wan2_7`

**Media upload:** Conditional — only when the user supplies a `start_image`, `end_image`,
or `audio` reference. This skill is NOT a mandatory-I2V skill; T2V is the default path.
When the user provides a reference file, run the `higgsfield:media_upload` →
`higgsfield:media_confirm` atomic pair before generating.

**Tool signatures:** [`../../shared/mcp-tools.md`](../../shared/mcp-tools.md)

---

## Reference materials

| File | Contents |
|---|---|
| [references/model-specs.md](references/model-specs.md) | Per-model parameter tables, aspect ratios, durations, routing rationale, and re-verify directive for wan2_7 and seedance_2_0 |
| [references/animation-craft.md](references/animation-craft.md) | 15+ art style encyclopedia, 12 animation principles in prompt language, character design principles, color palettes (8+), line-work styles, background approaches, character animation keywords, transition and effect library |
| [references/hooks.md](references/hooks.md) | 2-second hook framework with 10+ cartoon hook techniques, prompt integration phrases, hook selection guide by tone, and advanced hook-stacking guidance |
| [references/examples.md](references/examples.md) | Master prompt template, 5 full production-quality cartoon example prompts (Warner Bros. action, Ghibli peaceful, flat vector explainer, retro rubber hose, comedy skit), style deployment guide, and common-mistakes fix table |
