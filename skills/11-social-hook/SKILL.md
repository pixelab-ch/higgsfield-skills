---
name: higgsfield-social-hook
description: >-
  Crafts viral social media hook video prompts for TikTok, Instagram Reels,
  and YouTube Shorts via Higgsfield. Routes to kling3_0 (primary) or
  grok_video (fallback). Use when the user wants scroll-stopping hooks,
  viral short-form video, attention-grabbing openers, TikTok content,
  Reels content, Shorts content, or any social-media-optimized video.
when_to_use: >-
  Use for social media video, TikTok, Instagram Reels, YouTube Shorts, viral
  video, hook, scroll-stopper, short-form, trending, engagement, views, or
  any request for social media video content. Use even for "make something
  that gets views" or "viral content."
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

# Higgsfield Social Hook Skill

## What this skill does

Crafts scroll-stopping hook video prompts for TikTok, Instagram Reels, and YouTube
Shorts and routes them to the best Higgsfield model. On request, it assembles the full
parameter set, surfaces the credit cost, and — after explicit user confirmation —
generates the asset via the opt-in generation flow.

---

## Model routing

### Primary and fallback video models

| | kling3_0 (primary) | grok_video (fallback) |
|---|---|---|
| **Rationale** | Wide duration range, mode tuning, supports start + end image | Fallback when primary unavailable; native audio |
| **Mode** | `std`, `pro`, `4k`* | No tunable params |
| **Sound** | `on`, `off` | Native audio (always on) |
| **Aspect ratios** | `16:9`, `9:16`, `1:1` | `16:9`, `9:16`, `1:1` |
| **Duration** | `3`–`15` s (continuous range) | `1`–`15` s (continuous range) |
| **Media roles** | `start_image`, `end_image` | `start_image` only (max 1) |

*`kling3_0` `4k` mode is a **generation-mode enum**, NOT a 4K output-resolution claim.
Do not describe it as 4K video or high-resolution output.

**Routing rule:** Use `kling3_0` by default. Only fall back to `grok_video` when
(1) the primary model is unavailable, or (2) the user wants native audio generation
**and**, after being informed of the trade-offs (no tunable params, no `end_image`,
`start_image` max 1), explicitly accepts those constraints. Never switch silently.

**MODEL-06 directive:** If a parameter is rejected at generation time, call
`higgsfield:models_explore` with the target model name to re-verify the live schema.
Full parameter tables: [references/model-specs.md](references/model-specs.md).

### Per-platform aspect ratio quick rule

Vertical `9:16` for TikTok / Reels / Shorts; `16:9` for standard YouTube and LinkedIn;
`1:1` for Instagram feed square posts (`kling3_0` and `grok_video` both support `1:1`).
Full per-platform recommendation table: [references/model-specs.md](references/model-specs.md).

---

## Prompt-building workflow

1. **Gather intent** — Confirm with the user: content category (comedy, transformation,
   product, story, etc.), platform (TikTok/Reels/Shorts), target aspect ratio, desired
   duration, and whether native audio is needed.

2. **Select model** — Apply the routing table above. Use `kling3_0` by default; select
   `grok_video` only when a routing trigger applies.

3. **Build the hook prompt** — Use the craft principles and the 25+ hook patterns from
   [references/hook-craft.md](references/hook-craft.md):
   - Identify the hook type (visual shock, curiosity gap, emotional trigger, pattern
     interrupt, or direct address) and the 2-second master template structure.
   - Apply per-platform optimization from
     [references/platforms.md](references/platforms.md).
   - Reference worked prompts by category from
     [references/examples.md](references/examples.md).

4. **Present for review** — Show the assembled prompt, hook structure, model, aspect
   ratio, and duration to the user for review and refinement before any generation call.

---

## Opt-in generation

Generation costs Higgsfield credits and requires explicit user confirmation before any
generate call is made. This skill never auto-generates.

**Full step-by-step flow** (confirmation gate, balance/cost surface,
generate → poll → display):
[`../../shared/generation-flow.md`](../../shared/generation-flow.md)

**This skill's primary model:** `kling3_0`

**Media upload:** Conditional — only when the user supplies a `start_image` or
`end_image` reference for image-to-video. This skill is NOT a mandatory-I2V skill;
T2V is the default path. When the user provides a reference image, run the
`higgsfield:media_upload` → `higgsfield:media_confirm` atomic pair before generating.

**Tool signatures:** [`../../shared/mcp-tools.md`](../../shared/mcp-tools.md)

---

## Reference materials

| File | Contents |
|---|---|
| [references/model-specs.md](references/model-specs.md) | Verified parameter tables for kling3_0 and grok_video, per-platform aspect ratio and duration recommendations, routing rationale, and re-verify directive |
| [references/hook-craft.md](references/hook-craft.md) | Hook psychology (5 attention triggers), the full 25+ proven hook pattern encyclopedia, the 2-second master template, retention techniques, sound strategy, text overlay strategy, and common mistakes |
| [references/platforms.md](references/platforms.md) | Per-platform optimization (TikTok/Reels/Shorts), content-category playbooks (comedy, educational, satisfying, transformation, BTS, reaction, storytime, product, lifestyle), trending format templates, and analytics-driven iteration guidance |
| [references/examples.md](references/examples.md) | 5 production-ready worked hook prompts (satisfying transformation, comedy skit, product reveal, emotional story, impossible visual) with full timing breakdowns and parameter settings |
