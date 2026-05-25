---
name: higgsfield-motion-design-ad
description: >-
  Crafts high-converting motion design advertisement video prompts for software,
  SaaS, apps, and tech companies on Higgsfield, then routes to the best model
  (marketing_studio_video primary, seedance_2_0 fallback). Use when the user
  wants a software product ad, SaaS promo, app launch video, tech demo, UI
  showcase, startup video, motion graphics ad, or any software/tech promotional
  video. Handles text-to-video (default) and optional image-to-video with full
  prompt assembly, model selection, and parameter validation.
when_to_use: >-
  Use for: software ad, SaaS video, product launch, app promo, tech commercial,
  UI animation, motion design ad, startup video, product demo video, feature
  showcase, motion graphics, animated tech ad. Also triggers on "make a video
  for my app" or "promo for our platform."
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

# Higgsfield Motion Design Ad Skill

## What this skill does

Crafts production-ready motion design advertisement prompts for software and tech
companies and routes them to the best Higgsfield model for high-converting output.
On request, it assembles the full parameter set, surfaces the credit cost, and —
after explicit user confirmation — generates the asset via the opt-in generation
flow. Text-to-video is the default path; image-to-video is conditional on the user
supplying a reference image.

---

## Model routing

### Primary and fallback video models

| | marketing_studio_video (primary) | seedance_2_0 (fallback) |
|---|---|---|
| **Rationale** | Dedicated marketing pipeline; optimised for ad formats | Genre/mode control + image/video reference roles |
| **Resolution** | `480p`, `720p`, `1080p` | `480p`, `720p`, `1080p` (default `720p`) |
| **Aspect ratios** | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` |
| **Duration** | 4–15 s (continuous range) | 4–15 s (continuous range) |
| **Extra params** | `generate_audio` bool; optional `folder_id`, `width`, `height`, `hook_id`, `setting_id`, `ad_reference_id` | `mode` {`std`, `fast`}; `genre` {`auto`, `action`, `horror`, `comedy`, `noir`, `drama`, `epic`} |
| **Media roles** | `avatars`, `image`, `start_image`, `end_image` | `image`, `start_image`, `end_image`, `video`, `audio` |

**Routing rule:** Use `marketing_studio_video` by default — it is the dedicated ad
pipeline and supports audio generation via `generate_audio`. Fall back to `seedance_2_0`
only when (1) the primary model is unavailable, or (2) the user needs genre-tagged
output or a video/audio reference role not available on the primary. If falling back,
inform the user of the switch and which capabilities are different. Never switch
silently.

**MODEL-06 directive:** If a parameter is rejected at generation time, call
`higgsfield:models_explore` with the target model name to re-verify the live schema.
Full parameter tables: [references/model-specs.md](references/model-specs.md).

### Per-platform aspect ratio

Quick rule: `9:16` for TikTok / Reels / Shorts; `16:9` for YouTube and LinkedIn;
`1:1` for Instagram feed. Full per-platform table:
[references/model-specs.md](references/model-specs.md).

---

## Prompt-building workflow

1. **Gather intent** — Confirm: product category (SaaS, mobile app, dev tool, B2B
   platform), target platform, aspect ratio, desired duration, and brand tone
   (dark premium, clean minimal, neon cyber, etc.).

2. **Select model** — Apply the routing table above. Choose `marketing_studio_video`
   by default; select `seedance_2_0` only when a routing trigger applies.

3. **Build the prompt** — Use the craft principles in the references below:
   - Opening 2-second hook from [references/hooks.md](references/hooks.md)
   - Motion style, visual hierarchy, typography, transitions from
     [references/motion-craft.md](references/motion-craft.md)
   - Worked example prompts by product category and platform from
     [references/examples.md](references/examples.md)

4. **Present for review** — Show the assembled prompt and all parameters to the user
   for review and refinement **before** any generation call.

---

## Opt-in generation

Generation costs Higgsfield credits and requires explicit user confirmation before
any generate call is made. This skill never auto-generates.

**Full step-by-step flow** (confirmation gate, balance/cost surface,
generate → poll → display):
[`../../shared/generation-flow.md`](../../shared/generation-flow.md)

**This skill's primary model:** `marketing_studio_video`

**Audio:** `marketing_studio_video` supports a `generate_audio` boolean. Surface
this option to the user — enabling it may affect credit cost.

**Media upload:** Conditional — only when the user supplies a `start_image`,
`end_image`, or other reference for image-to-video. This skill is NOT a
mandatory-I2V skill; T2V is the default path. When a reference image is provided,
run the `higgsfield:media_upload` → `higgsfield:media_confirm` atomic pair first.

**Tool signatures:** [`../../shared/mcp-tools.md`](../../shared/mcp-tools.md)

---

## Reference materials

| File | Contents |
|---|---|
| [references/model-specs.md](references/model-specs.md) | Per-model parameter tables, aspect ratios, durations, routing rationale for marketing_studio_video and seedance_2_0 |
| [references/motion-craft.md](references/motion-craft.md) | Visual style library (12 styles), typography motion guide, device showcase techniques, transition library, sound design principles |
| [references/hooks.md](references/hooks.md) | 2-second hook framework with 12 proven tech-ad hooks and prompt phrasing templates |
| [references/examples.md](references/examples.md) | Master template + 5 full example prompts by product category (SaaS dashboard, mobile app, AI/data, dev tool, B2B enterprise) |
