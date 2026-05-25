<!-- verified: models_explore 2026-05-25 -->
<!-- If any parameter below is rejected at generation time, call higgsfield:models_explore
     with the target model name to refresh the live schema — the live catalog is the source
     of truth over these cached specs. -->

# E-Commerce Ad — Model Specifications

All values sourced from verified `higgsfield:models_explore` data (2026-05-25).
Re-query on any parameter rejection. Video max resolution for all video models in
this skill is 1080p; no 4K video output and no webm container. The only legitimate
4k value is the `ms_image` image-model resolution enum — it does not apply to any
video model.

---

## Table of Contents

1. [marketing_studio_video — Primary (video)](#marketing_studio_video--primary-video)
   - [Parameters](#parameters)
   - [Per-platform aspect ratio and duration](#per-platform-aspect-ratio-and-duration)
2. [seedance_2_0 — Fallback (video)](#seedance_2_0--fallback-video)
   - [Parameters](#parameters-1)
   - [Routing rationale](#routing-rationale)
3. [ms_image — Still-image path (DTC Ads)](#ms_image--still-image-path-dtc-ads)
   - [Parameters](#parameters-2)
   - [Important notes on ms_image](#important-notes-on-ms_image)
4. [Source of truth note](#source-of-truth-note)

---

## marketing_studio_video — Primary (video)

**Routing rationale:** Dedicated marketing/ad pipeline. Use by default for all
e-commerce video requests. Supports audio generation and optional ad-reference
parameters that seedance_2_0 does not expose.

### Parameters

| Parameter | Options / Range | Notes |
|-----------|-----------------|-------|
| `resolution` | `480p`, `720p`, `1080p` | Max video resolution is 1080p |
| `aspect_ratio` | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` | Full platform coverage |
| `duration` | 4–15 s | Continuous range; any whole-second value in range is valid |
| `generate_audio` | `true` / `false` | Optional; enables audio generation alongside video |
| `folder_id` | string | Optional; organises output into a named folder |
| `width` | integer | Optional; custom width override |
| `height` | integer | Optional; custom height override |
| `hook_id` | string | Optional; references a saved hook configuration |
| `setting_id` | string | Optional; references a saved setting configuration |
| `ad_reference_id` | string | Optional; references a saved ad reference |
| **Media roles** | `avatars`, `image`, `start_image`, `end_image` | All four supported |

### Per-platform aspect ratio and duration

| Platform | Aspect ratio | Recommended duration | Notes |
|----------|-------------|----------------------|-------|
| TikTok Shop | `9:16` | 8–12 s | Vertical; hook at 1 s; quick cuts; trending audio |
| Instagram Reels | `9:16` | 8–15 s | Vertical; captions essential; lifestyle-focused |
| YouTube Shorts | `9:16` | 10–15 s | Slightly longer narrative budget |
| YouTube (pre-roll) | `16:9` | 8–15 s | Problem → solution → CTA structure |
| Amazon | `16:9` | 8–15 s | Multiple angles; specs callouts; social proof |
| Instagram feed / Square | `1:1` | 4–10 s | Center-weighted hero shot |
| Pinterest | `9:16` or `1:1` | 8–15 s | Educational; slower pacing |
| LinkedIn | `16:9` | 12–15 s | B2B products; professional tone |
| Twitter / X | `16:9` or `1:1` | 8–15 s | Captions critical |
| Facebook / Meta | `1:1` | 8–15 s | Captions essential; slower motion can outperform |

---

## seedance_2_0 — Fallback (video)

**Routing rationale:** Use when `marketing_studio_video` is unavailable, or when
the user needs genre-tagged output or a video/audio reference role not available on
the primary.

### Parameters

| Parameter | Options / Range | Default | Notes |
|-----------|-----------------|---------|-------|
| `resolution` | `480p`, `720p`, `1080p` | `720p` | Max video resolution is 1080p |
| `mode` | `std`, `fast` | — | `fast` for iteration; `std` for full quality |
| `genre` | `auto`, `action`, `horror`, `comedy`, `noir`, `drama`, `epic` | `auto` | Genre-tagged generation |
| `aspect_ratio` | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` | — | Full platform coverage |
| `duration` | 4–15 s | — | Continuous range |
| **Media roles** | `image`, `start_image`, `end_image`, `video`, `audio` | — | Supports video and audio reference inputs |

### Routing rationale

Prefer `marketing_studio_video` (primary) unless one of these applies:

1. The primary model is unavailable at generation time.
2. The user wants **genre-tagged** output (e.g., `drama` for luxury, `action` for
   fast-paced product reveals).
3. The user supplies a **video or audio reference** (roles not available on primary).

Always inform the user when switching to the fallback and explain which capabilities differ.

---

## ms_image — Still-image path (DTC Ads)

**Use case:** Generate a high-quality product still, hero shot, or DTC ad image when
the user wants a static output rather than video. Route to `ms_image` via
`higgsfield:generate_image`.

**CRITICAL: `style_id` is REQUIRED.** Generation will fail without it. Always ask
the user for their `style_id` before building the generate_image call.

### Parameters

| Parameter | Options / Default | Notes |
|-----------|------------------|-------|
| `style_id` | string — **REQUIRED** | Must be provided by the user; no default |
| `brand_kit_id` | string — optional | Optional brand kit reference |
| `resolution` | `1k`, `2k`, `4k` | **`4k` is a LEGITIMATE enum for ms_image only.** It does NOT apply to any video model in this skill. |
| `quality` | `low`, `medium`, `high` | Output quality level |
| `batch_size` | 1–20 | Number of images to generate in a single call |
| `aspect_ratio` | `1:1`, `4:5`, `16:9`, `9:16`, and others | Many aspect ratios supported |
| **Media roles** | `image` (max 14) | Up to 14 image references supported |

### Important notes on ms_image

- The `4k` resolution enum is **valid only for `ms_image`** (an image model, not a
  video model). Do not use "4K" as a video output claim.
- `style_id` is mandatory — surface this to the user immediately if they want a
  product still. Do not attempt generation without it.
- Output from `ms_image` can optionally be passed as a `start_image` to
  `marketing_studio_video` to extend into a video, maintaining the established
  composition.

---

## Source of truth note

These specs are cached from a verified `higgsfield:models_explore` query on 2026-05-25.
Model APIs evolve. If any parameter is **rejected at generation time**:

1. Call `higgsfield:models_explore` with the target model name.
2. Read the returned schema for current valid values.
3. Substitute the corrected value before retrying.

Never infer or guess parameter values. The live catalog is the authoritative source.
