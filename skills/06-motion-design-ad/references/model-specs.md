<!-- verified: models_explore 2026-05-25 -->
<!-- If any parameter below is rejected at generation time, call higgsfield:models_explore
     with the target model name to refresh the live schema — the live catalog is the source
     of truth over these cached specs. -->

# Motion Design Ad — Model Specifications

All values sourced from verified `higgsfield:models_explore` data (2026-05-25).
Re-query on any parameter rejection. Video max resolution for all models in this skill
is 1080p; no 4K video output and no webm container.

---

## Table of Contents

1. [marketing_studio_video — Primary](#marketing_studio_video--primary)
   - [Parameters](#parameters)
   - [Per-platform aspect ratio and duration](#per-platform-aspect-ratio-and-duration)
2. [seedance_2_0 — Fallback](#seedance_2_0--fallback)
   - [Parameters](#parameters-1)
   - [Routing rationale](#routing-rationale)
3. [Source of truth note](#source-of-truth-note)

---

## marketing_studio_video — Primary

**Routing rationale:** Dedicated marketing/ad pipeline. Use by default for all
motion design ad requests. Supports audio generation and optional ad-reference
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
| TikTok | `9:16` | 6–10 s | Vertical full-screen; hook must land in first 2 s |
| Instagram Reels | `9:16` | 8–12 s | Vertical; high visual polish expected |
| YouTube Shorts | `9:16` | 10–15 s | Slightly more patient audience |
| YouTube (standard) | `16:9` | 10–15 s | Widescreen; longer narrative works |
| LinkedIn | `16:9` | 8–12 s | Professional format; deliberate pacing |
| Instagram feed / Square | `1:1` | 4–8 s | Center-weighted composition |
| Twitter / X | `16:9` or `1:1` | 8–15 s | Captions essential; text-heavy approach works |
| Facebook / Meta | `1:1` | 8–15 s | Slower pacing suits broader demographic |

---

## seedance_2_0 — Fallback

**Routing rationale:** Use only when `marketing_studio_video` is unavailable, or when
the user needs genre-tagged output (`action`, `horror`, `comedy`, `noir`, `drama`,
`epic`) or a video / audio reference role not available on the primary.

### Parameters

| Parameter | Options / Range | Default | Notes |
|-----------|-----------------|---------|-------|
| `resolution` | `480p`, `720p`, `1080p` | `720p` | Max video resolution is 1080p |
| `mode` | `std`, `fast` | — | `fast` for quick iteration; `std` for full quality |
| `genre` | `auto`, `action`, `horror`, `comedy`, `noir`, `drama`, `epic` | `auto` | Genre-tagged generation |
| `aspect_ratio` | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` | — | Full platform coverage |
| `duration` | 4–15 s | — | Continuous range |
| **Media roles** | `image`, `start_image`, `end_image`, `video`, `audio` | — | Supports video and audio reference inputs |

### Routing rationale

Prefer `marketing_studio_video` (primary) unless one of these applies:

1. The primary model is unavailable at generation time.
2. The user wants **genre-tagged** output (e.g., `noir`, `epic`).
3. The user supplies a **video or audio reference** (roles not available on primary).

Always inform the user when switching to the fallback and explain which capabilities differ.

---

## Source of truth note

These specs are cached from a verified `higgsfield:models_explore` query on 2026-05-25.
Model APIs evolve. If any parameter is **rejected at generation time**:

1. Call `higgsfield:models_explore` with the target model name.
2. Read the returned schema for current valid values.
3. Substitute the corrected value before retrying.

Never infer or guess parameter values. The live catalog is the authoritative source.
