---
name: higgsfield-product-360
description: >-
  Generates product 360° turntable, multi-angle showcase, and product reveal
  video prompts for Higgsfield. A product photo is always required (image-to-
  video). Routes to seedance_2_0 (primary) or cinematic_studio_3_0 (fallback).
  Use when the user wants a product rotation video, turntable showcase, product
  reveal, 360 view, multi-angle display, product beauty shot, hero product
  video, or unboxing reveal.
when_to_use: >-
  Use for product 360, turntable, product rotation, multi-angle, product reveal,
  product showcase, hero shot, beauty shot, product spin, unboxing, or any
  request to showcase a physical product from multiple angles. Also use when the
  user wants a product still or hero image before committing to video.
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

# Higgsfield Product-360 Skill

## What this skill does

Crafts production-ready product showcase video prompts and routes them to the best
Higgsfield model for 360° turntable and multi-angle output.

**A product photo is always required.** This is a mandatory image-to-video (I2V) skill:
every generation needs a user-supplied product image uploaded and confirmed via the media
branch before calling `higgsfield:generate_video`. The confirmed image is attached as
`start_image`.

This skill also handles product hero stills and mood-board frames via the still-image path
(see below).

---

## Model routing

### Primary and fallback video models

| | seedance_2_0 (primary) | cinematic_studio_3_0 (fallback) |
|---|---|---|
| **Rationale** | Widest I2V feature set: genre, mode, resolution controls; all aspect ratios | Dedicated cinematic pipeline; use when primary is unavailable |
| **Aspect ratios** | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` | `16:9`, `9:16`, `1:1` only |
| **Duration** | 4–15 s (continuous) | 4–15 s (continuous) |
| **Tunable params** | `resolution` {480p, 720p, 1080p}; `mode` {std, fast}; `genre` {auto, action, horror, comedy, noir, drama, epic} | **None** — pass only `aspect_ratio` and `duration` |
| **Media roles** | `image`, `start_image`, `end_image`, `video`, `audio` | `image`, `start_image`, `end_image` |

**Routing rule:** Use `seedance_2_0` by default. Fall back to `cinematic_studio_3_0` only
when (1) the primary is unavailable, or (2) the user explicitly wants the cinematic pipeline.
Note that `cinematic_studio_3_0` does not support `4:3` or `3:4` aspect ratios.

**MODEL-06 directive:** If a parameter is rejected at generation time, call
`higgsfield:models_explore` with the target model name to re-verify the live schema. Full
parameter tables: [references/model-specs.md](references/model-specs.md).

### Per-platform aspect ratio

Quick rule: `9:16` for TikTok / Reels, `16:9` for YouTube / e-commerce, `1:1` for
Instagram feed, `3:4` for portrait product packaging (seedance_2_0 only). Full table in
[references/model-specs.md](references/model-specs.md).

---

## Still-image path (MODEL-05)

For a product hero still or mood-board frame before committing to video, route to
`seedream_v4_5` (primary) or `soul_cinematic` (alternate) via `higgsfield:generate_image`.

- **seedream_v4_5:** `quality` {basic, high}; `aspect_ratio` {1:1, 4:3, 16:9, 3:2, 21:9,
  3:4, 9:16, 2:3}; supports 4K output (this image model legitimately outputs 4K — this
  does not apply to any video model).
- **soul_cinematic:** `quality` {1.5k, 2k}; optional `soul_id` for style consistency;
  same wide aspect-ratio set.

After generating a still, the output image can be passed as the `start_image` input for
the video path above. Full parameter tables: [references/model-specs.md](references/model-specs.md).

---

## Prompt-building workflow

1. **Gather intent** — Confirm: product category, target platform, aspect ratio, desired
   duration, brand mood (luxury, tech, lifestyle).

2. **Select model** — Apply the routing table above. Choose `seedance_2_0` by default.

3. **Build the prompt** — Use the craft references below:
   - Opening hook (2-second attention-capture technique): [references/hooks.md](references/hooks.md)
   - Camera angles, rotation patterns, and per-category lighting: [references/angles.md](references/angles.md)
   - Worked example prompts by product category: [references/examples.md](references/examples.md)

4. **Present for review** — Show the assembled prompt and all parameters to the user for
   review and refinement **before** any generation call.

---

## Opt-in generation

Generation costs Higgsfield credits and requires explicit user confirmation before any
generate call. This skill never auto-generates.

**Full step-by-step flow** (confirmation gate, balance/cost surface, generate → poll →
display): [`../../shared/generation-flow.md`](../../shared/generation-flow.md)

**This skill's primary model:** `seedance_2_0`

**Media upload — MANDATORY (GEN-04):**

A product photo is always required for video generation. Before calling
`higgsfield:generate_video`:

1. Ask the user to provide their product photo.
2. Upload it: run `higgsfield:media_upload` → returns a `pending_id`.
3. Confirm it: run `higgsfield:media_confirm` → returns a `confirmed_id`.
4. Attach it in `input_files` with role `start_image`:
   ```json
   [{ "id": "<confirmed_id>", "role": "start_image" }]
   ```

Never pass a `pending_id` directly to `input_files` — it will be rejected. See
[`../../shared/generation-flow.md`](../../shared/generation-flow.md) Step 2b for the full
atomic-pair detail.

**Tool signatures:** [`../../shared/mcp-tools.md`](../../shared/mcp-tools.md)

---

## Reference materials

| File | Contents |
|---|---|
| [references/model-specs.md](references/model-specs.md) | Per-model parameter tables for seedance_2_0, cinematic_studio_3_0, seedream_v4_5, soul_cinematic; per-platform recommendations; verification annotation |
| [references/angles.md](references/angles.md) | Hero angle selection by category, rotation speed and patterns, dynamic camera movements, multi-image angle strategy (3–9 photos), per-category lighting guide, material showcase techniques |
| [references/hooks.md](references/hooks.md) | 12 hook styles with prompt phrasing, category matching table, advanced hook-stacking guidance |
| [references/examples.md](references/examples.md) | Master template, 5 worked product-360 prompts (watch, sneaker, earbuds, fragrance, car seat covers), common mistakes and fixes |
