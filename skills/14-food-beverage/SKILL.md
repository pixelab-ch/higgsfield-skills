---
name: higgsfield-food-beverage
description: >-
  Crafts production-grade food and beverage video prompts for Higgsfield and
  routes to the best model (seedance_2_0 primary, marketing_studio_video
  fallback). Use when the user wants food videos, recipe content, restaurant
  promos, beverage ads, cooking videos, food ASMR, menu showcases, food
  delivery ads, café content, or any food/drink video. Handles text-to-video
  (default) and optional image-to-video with full prompt assembly, model
  selection, and parameter validation.
when_to_use: >-
  Use for: food video, recipe, cooking, restaurant, beverage, food ad, food
  ASMR, menu, café, cocktail, food photography video, appetite appeal, food
  styling, mukbang, "make my food look delicious", "restaurant promo video",
  or any food/drink video request.
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

# Higgsfield Food and Beverage Skill

## What this skill does

Crafts production-grade food and beverage video prompts and routes them to the best
Higgsfield model to make dishes, drinks, and ingredients look irresistible on screen.
On request, it assembles the full parameter set, surfaces the credit cost, and —
after explicit user confirmation — generates the asset via the opt-in generation
flow. Text-to-video is the default path; image-to-video is conditional on the user
supplying a reference image.

---

## Model routing

### Primary and fallback video models

| | seedance_2_0 (primary) | marketing_studio_video (fallback) |
|---|---|---|
| **Rationale** | Genre control (e.g., `drama`, `epic`) for mood-driven food cinematography; supports video and audio references | Dedicated marketing pipeline; use for ad-optimised output |
| **Resolution** | `480p`, `720p`, `1080p` (default `720p`) | `480p`, `720p`, `1080p` |
| **Aspect ratios** | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` |
| **Duration** | 4–15 s (continuous range) | 4–15 s (continuous range) |
| **Extra params** | `mode` {`std`, `fast`}; `genre` {`auto`, `action`, `horror`, `comedy`, `noir`, `drama`, `epic`} | `generate_audio` bool; optional `folder_id`, `hook_id`, `setting_id`, `ad_reference_id` |
| **Media roles** | `image`, `start_image`, `end_image`, `video`, `audio` | `avatars`, `image`, `start_image`, `end_image` |

**Routing rule:** Use `seedance_2_0` by default — genre tags such as `drama` or
`epic` give the model a mood direction that suits fine-dining and cinematic food
content. Fall back to `marketing_studio_video` only when (1) the primary model is
unavailable, or (2) the user wants an ad-optimised output with `generate_audio` or
ad reference inputs. If falling back, inform the user of the switch. Never switch
silently.

**MODEL-06 directive:** If a parameter is rejected at generation time, call
`higgsfield:models_explore` with the target model name to re-verify the live schema.
Full parameter tables: [references/model-specs.md](references/model-specs.md).

### Per-platform aspect ratio

Quick rule: `9:16` for TikTok / Reels / Shorts; `16:9` for YouTube and restaurant
websites; `1:1` for Instagram and Pinterest. Full per-platform table:
[references/model-specs.md](references/model-specs.md).

---

## Prompt-building workflow

1. **Gather intent** — Confirm: food or beverage type, request category (restaurant
   promo, packaged product, recipe/how-to, lifestyle/ASMR), target platform, aspect
   ratio, desired duration, and mood tone (intimate, celebratory, dramatic, cozy).

2. **Select model** — Apply the routing table above. Choose `seedance_2_0` by
   default; select `marketing_studio_video` only when a routing trigger applies.

3. **Build the prompt** — Use the craft principles in the references below:
   - Opening 2-second hook from [references/hooks.md](references/hooks.md)
   - Lighting, staging, texture, money-shot techniques from
     [references/food-styling.md](references/food-styling.md)
   - Worked example prompts by food category and platform from
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

**This skill's primary model:** `seedance_2_0`

**Media upload:** Conditional — only when the user supplies a `start_image`,
`end_image`, or other reference for image-to-video. This skill is NOT a
mandatory-I2V skill; T2V is the default path. When a reference image is provided,
run the `higgsfield:media_upload` → `higgsfield:media_confirm` atomic pair first.

**Tool signatures:** [`../../shared/mcp-tools.md`](../../shared/mcp-tools.md)

---

## Reference materials

| File | Contents |
|---|---|
| [references/model-specs.md](references/model-specs.md) | Per-model parameter tables, aspect ratios, durations, routing rationale for seedance_2_0 and marketing_studio_video |
| [references/food-styling.md](references/food-styling.md) | Lighting playbook, money-shot library, colour palettes by cuisine, food styling tricks, movement and action vocabulary, sound/ASMR layering |
| [references/hooks.md](references/hooks.md) | 2-second hook framework with 12 proven food/beverage hooks and prompt phrasing |
| [references/examples.md](references/examples.md) | Master template + 5 full example prompts (fine dining, café latte art, fast-food burger, cocktail bar, croissant bakery) |
