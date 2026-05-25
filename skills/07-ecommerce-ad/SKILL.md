---
name: higgsfield-ecommerce-ad
description: >-
  Crafts high-converting e-commerce product advertisement prompts for
  Higgsfield and routes to the best model (marketing_studio_video primary,
  seedance_2_0 fallback). Also routes product-still requests to ms_image via
  generate_image. Use when the user wants product ads, e-commerce videos,
  product showcases, unboxing, product demos, shopping ads, fashion ads, beauty
  ads, DTC brand ads, or any commercial product video for online selling.
  Handles text-to-video (default) and optional image-to-video.
when_to_use: >-
  Use for: product ad, e-commerce, product showcase, Amazon video, Shopify ad,
  Instagram shop, TikTok shop, product commercial, fashion video, beauty ad,
  food ad, product demo, DTC brand, dropshipping video. Also triggers on
  "make a video for my product" or "product promo."
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

# Higgsfield E-Commerce Ad Skill

## What this skill does

Crafts production-ready e-commerce and DTC advertisement prompts and routes them to
the best Higgsfield model for high-converting output. On request, it assembles the
full parameter set, surfaces the credit cost, and — after explicit user confirmation
— generates the asset via the opt-in generation flow. Text-to-video is the default
path; image-to-video is conditional on the user supplying a reference image.
Product stills route to `ms_image` via `higgsfield:generate_image`.

---

## Model routing

### Primary and fallback video models

| | marketing_studio_video (primary) | seedance_2_0 (fallback) |
|---|---|---|
| **Rationale** | Dedicated marketing/ad pipeline; optimised for conversion formats | Genre/mode control + video/audio reference roles |
| **Resolution** | `480p`, `720p`, `1080p` | `480p`, `720p`, `1080p` (default `720p`) |
| **Aspect ratios** | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` |
| **Duration** | 4–15 s (continuous range) | 4–15 s (continuous range) |
| **Extra params** | `generate_audio` bool; optional `folder_id`, `width`, `height`, `hook_id`, `setting_id`, `ad_reference_id` | `mode` {`std`, `fast`}; `genre` {`auto`, `action`, `horror`, `comedy`, `noir`, `drama`, `epic`} |
| **Media roles** | `avatars`, `image`, `start_image`, `end_image` | `image`, `start_image`, `end_image`, `video`, `audio` |

**Routing rule:** Use `marketing_studio_video` by default — it is the dedicated ad
pipeline and supports audio generation via `generate_audio`. Fall back to
`seedance_2_0` only when (1) the primary model is unavailable, or (2) the user needs
genre-tagged output or a video/audio reference role not available on the primary.
If falling back, inform the user of the switch. Never switch silently.

**MODEL-06 directive:** If a parameter is rejected at generation time, call
`higgsfield:models_explore` with the target model name to re-verify the live schema.
Full parameter tables: [references/model-specs.md](references/model-specs.md).

### Per-platform aspect ratio

Quick rule: `9:16` for TikTok Shop / Reels / Shorts; `16:9` for YouTube and Amazon;
`1:1` for Instagram feed and Pinterest. Full per-platform table:
[references/model-specs.md](references/model-specs.md).

---

## Still-image path (DTC Ads — ms_image)

For a product still, hero shot, or mood-board frame before committing to video —
or when the user wants a high-quality static DTC product image — route to `ms_image`
via `higgsfield:generate_image`.

`ms_image` requires a **`style_id`** — this field is REQUIRED and must be provided
before generation. `brand_kit_id` is optional. Resolution options: `1k`, `2k`, `4k`
(the `4k` enum is a legitimate option for this image model only — it does not apply
to any video model in this plan). See full parameter table:
[references/model-specs.md](references/model-specs.md).

After generating a still with `ms_image`, the output image can optionally be passed
as a `start_image` reference to `marketing_studio_video` to carry the composition
into video.

---

## Prompt-building workflow

1. **Gather intent** — Confirm: product category (fashion, beauty, electronics, food,
   jewelry, home, fitness…), request type (product-only, lifestyle, unboxing, DTC
   still), target platform, aspect ratio, desired duration, and visual tone.

2. **Select model** — Apply the routing table above. Choose `marketing_studio_video`
   by default; route product-still requests to `ms_image` via `generate_image`; select
   `seedance_2_0` only when a routing trigger applies.

3. **Build the prompt** — Use the craft principles in the references below:
   - Opening 2-second hook from [references/hooks.md](references/hooks.md)
   - Product staging, lighting, value communication, lifestyle context from
     [references/ad-craft.md](references/ad-craft.md)
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
mandatory-I2V skill; T2V is the default path. When a reference is provided,
run the `higgsfield:media_upload` → `higgsfield:media_confirm` atomic pair first.

**Tool signatures:** [`../../shared/mcp-tools.md`](../../shared/mcp-tools.md)

---

## Reference materials

| File | Contents |
|---|---|
| [references/model-specs.md](references/model-specs.md) | Per-model parameter tables for marketing_studio_video, seedance_2_0, and ms_image (including its legitimate 4k resolution enum and required style_id) |
| [references/ad-craft.md](references/ad-craft.md) | DTC/e-commerce ad craft: product staging, lighting, multi-angle techniques, lifestyle integration, text/CTA guide, quick-cut patterns, sound design |
| [references/hooks.md](references/hooks.md) | 2-second hook framework with 12 proven e-commerce hooks and prompt phrasing templates |
| [references/examples.md](references/examples.md) | Master template + 5 full example prompts by product category (fashion, skincare, electronics, food/beverage, jewelry) |
