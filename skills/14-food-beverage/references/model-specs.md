<!-- verified: models_explore 2026-05-25 -->
<!-- If any parameter below is rejected at generation time, call higgsfield:models_explore
     with the target model name to refresh the live schema — the live catalog is the source
     of truth over these cached specs. -->

# Food and Beverage — Model Specifications

All values sourced from verified `higgsfield:models_explore` data (2026-05-25).
Re-query on any parameter rejection. Video max resolution for all models in this skill
is 1080p; no 4K video output and no webm container.

---

## Table of Contents

1. [seedance_2_0 — Primary](#seedance_2_0--primary)
   - [Parameters](#parameters)
   - [Per-platform aspect ratio and duration](#per-platform-aspect-ratio-and-duration)
2. [marketing_studio_video — Fallback](#marketing_studio_video--fallback)
   - [Parameters](#parameters-1)
   - [Routing rationale](#routing-rationale)
3. [Source of truth note](#source-of-truth-note)

---

## seedance_2_0 — Primary

**Routing rationale:** Genre tags (e.g., `drama`, `epic`, `noir`) give the model a
cinematic mood direction ideal for fine-dining, cocktail, and atmospheric food
content. Supports video and audio reference inputs.

### Parameters

| Parameter | Options / Range | Default | Notes |
|-----------|-----------------|---------|-------|
| `resolution` | `480p`, `720p`, `1080p` | `720p` | Max video resolution is 1080p |
| `mode` | `std`, `fast` | — | `fast` for quick iteration; `std` for full quality |
| `genre` | `auto`, `action`, `horror`, `comedy`, `noir`, `drama`, `epic` | `auto` | Use `drama` or `epic` for fine dining; `auto` for casual |
| `aspect_ratio` | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` | — | Full platform coverage |
| `duration` | 4–15 s | — | Continuous range; any whole-second value in range is valid |
| **Media roles** | `image`, `start_image`, `end_image`, `video`, `audio` | — | All five roles supported |

### Per-platform aspect ratio and duration

| Platform | Aspect ratio | Recommended duration | Notes |
|----------|-------------|----------------------|-------|
| TikTok | `9:16` | 6–12 s | Vertical; hook in first 0.5–1 s |
| Instagram Reels | `9:16` | 10–15 s | Vertical; captions for muted viewers |
| YouTube Shorts | `9:16` | 10–15 s | Slightly more patient audience |
| YouTube (standard) | `16:9` | 10–15 s | Widescreen; slower contemplative pacing |
| Restaurant website | `16:9` | 15 s | High production; multiple dishes/ambiance |
| Instagram feed / Square | `1:1` | 4–8 s | Center-weighted composition |
| Pinterest | `9:16` or `1:1` | 8–15 s | Educational / inspirational mindset |
| Facebook | `9:16` or `1:1` | 8–15 s | Captions essential; looping content performs |
| Instagram Stories | `9:16` | 4–6 s | Micro-moments; single hook action |

---

## marketing_studio_video — Fallback

**Routing rationale:** Use when `seedance_2_0` is unavailable, or when the user
wants ad-optimised output with audio generation or ad reference inputs.

### Parameters

| Parameter | Options / Range | Notes |
|-----------|-----------------|-------|
| `resolution` | `480p`, `720p`, `1080p` | Max video resolution is 1080p |
| `aspect_ratio` | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` | Full platform coverage |
| `duration` | 4–15 s | Continuous range |
| `generate_audio` | `true` / `false` | Optional; enables audio generation alongside video |
| `folder_id` | string | Optional; organises output |
| `hook_id` | string | Optional; references a saved hook configuration |
| `setting_id` | string | Optional; references a saved setting configuration |
| `ad_reference_id` | string | Optional; references a saved ad reference |
| **Media roles** | `avatars`, `image`, `start_image`, `end_image` | Four roles supported |

### Routing rationale

Prefer `seedance_2_0` (primary) unless one of these applies:

1. The primary model is unavailable at generation time.
2. The user wants `generate_audio` (voice, narration, or native sound alongside video).
3. The user supplies an `ad_reference_id` or `hook_id` configuration.

Always inform the user when switching to the fallback and explain which capabilities differ.

---

## Source of truth note

These specs are cached from a verified `higgsfield:models_explore` query on 2026-05-25.
Model APIs evolve. If any parameter is **rejected at generation time**:

1. Call `higgsfield:models_explore` with the target model name.
2. Read the returned schema for current valid values.
3. Substitute the corrected value before retrying.

Never infer or guess parameter values. The live catalog is the authoritative source.
