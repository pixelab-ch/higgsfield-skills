<!-- verified: models_explore 2026-05-25 -->
<!-- If any parameter below is rejected at generation time, call higgsfield:models_explore
     with the target model name to refresh the live schema — the live catalog is the source
     of truth over these cached specs. -->

# Product-360 Model Specifications

This reference documents per-model parameters, aspect ratios, durations, and routing
rationale for the product-360 skill. All values are sourced from verified
`higgsfield:models_explore` data (2026-05-25). Re-query on any parameter rejection.

**GEN-04 note:** All generation paths in this skill require a confirmed product image
uploaded via `higgsfield:media_upload` → `higgsfield:media_confirm` (role `start_image`)
before calling `higgsfield:generate_video`.

---

## Table of Contents

1. [seedance_2_0 — Primary (I2V video)](#seedance_2_0--primary-i2v-video)
2. [cinematic_studio_3_0 — Fallback (I2V video)](#cinematic_studio_3_0--fallback-i2v-video)
3. [seedream_v4_5 — Still-image path (primary)](#seedream_v4_5--still-image-path-primary)
4. [soul_cinematic — Still-image path (alternate)](#soul_cinematic--still-image-path-alternate)
5. [Per-platform recommendations](#per-platform-recommendations)
6. [Source of truth note](#source-of-truth-note)

---

## seedance_2_0 — Primary (I2V video)

**Routing rationale:** Primary I2V model for product-360. Supports `genre` for mood control
and `mode` for speed/quality trade-off. Widest aspect-ratio coverage including `4:3` and
`3:4` which suit product packaging.

### Parameters

| Parameter | Options | Default | Notes |
|-----------|---------|---------|-------|
| `resolution` | `480p`, `720p`, `1080p` | `720p` | Use `1080p` for hero / e-commerce |
| `mode` | `std`, `fast` | — | `std` for quality; `fast` for iteration |
| `genre` | `auto`, `action`, `horror`, `comedy`, `noir`, `drama`, `epic` | `auto` | Set `drama` or `epic` for luxury reveals |
| `aspect_ratio` | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` | — | `16:9` for e-commerce; `1:1` or `9:16` for social |
| `duration` | 4–15 s | — | Continuous range; 6–10 s suits most product reveals |
| `input_files` media roles | `image`, `start_image`, `end_image`, `video`, `audio` | — | Use `start_image` for product photo |

**Required for this skill:** provide a product photo as `start_image` via the media branch.

---

## cinematic_studio_3_0 — Fallback (I2V video)

**Routing rationale:** Use when `seedance_2_0` is unavailable or when the user wants the
dedicated cinematic pipeline. No tunable parameters beyond aspect ratio and duration.

### Parameters

| Parameter | Options | Default | Notes |
|-----------|---------|---------|-------|
| Tunable parameters | **NONE** | — | Do not pass quality, genre, mode, or resolution |
| `aspect_ratio` | `16:9`, `9:16`, `1:1` | — | Three ratios supported (no `4:3`/`3:4`) |
| `duration` | 4–15 s | — | Continuous range |
| `input_files` media roles | `image`, `start_image`, `end_image` | — | Use `start_image` for product photo |

**Key constraint:** `cinematic_studio_3_0` has no tunable parameters at the API level.
Pass only `aspect_ratio`, `duration`, and the `input_files` block.

---

## seedream_v4_5 — Still-image path (primary)

**Use case (MODEL-05):** Generate a product hero still before committing to video. A
generated still can then feed the I2V `start_image` for the video path above.

**4K note:** `seedream_v4_5` legitimately supports 4K output — this applies to this
**image model only**. No video model in this skill outputs 4K.

### Parameters

| Parameter | Options | Notes |
|-----------|---------|-------|
| `quality` | `basic`, `high` | `high` for e-commerce hero images |
| `aspect_ratio` | `1:1`, `4:3`, `16:9`, `3:2`, `21:9`, `3:4`, `9:16`, `2:3` | Full range; `4:3` or `3:4` useful for product packaging |
| 4K support | Yes (image only) | Legitimate enum for this image model — does not apply to video |

---

## soul_cinematic — Still-image path (alternate)

**Use case:** Alternate still path with optional `soul_id` for style consistency across
multiple product shots.

### Parameters

| Parameter | Options | Notes |
|-----------|---------|-------|
| `quality` | `1.5k`, `2k` | `2k` for high-resolution product stills |
| `soul_id` | optional string | Style reference for visual consistency across shots |
| `aspect_ratio` | `1:1`, `4:3`, `3:4`, `16:9`, `9:16`, `3:2`, `2:3`, `21:9` | Full range |

---

## Per-platform recommendations

| Platform | Aspect ratio | Model | Recommended duration | Notes |
|----------|-------------|-------|----------------------|-------|
| TikTok / Reels | `9:16` | `seedance_2_0` | 6–10 s | Vertical; hook in first 2 s |
| Instagram feed | `1:1` | `seedance_2_0` | 6–8 s | Square; composition centered |
| YouTube / website | `16:9` | `seedance_2_0` | 8–15 s | Full e-commerce showcase |
| Product page (portrait) | `3:4` | `seedance_2_0` | 6–10 s | Portrait packaging display |
| Amazon hero | `16:9` | `seedance_2_0` | 8–15 s | Standard e-commerce format |

---

## Source of truth note

These specs are cached from a verified `higgsfield:models_explore` query on 2026-05-25.
Model APIs evolve. If any parameter is rejected at generation time:

1. Call `higgsfield:models_explore` with the target model name.
2. Read the returned schema for current valid values.
3. Substitute the corrected value before retrying.

Never infer or guess parameter values. The live catalog is the authoritative source.
