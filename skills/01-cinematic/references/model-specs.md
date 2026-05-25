<!-- verified: models_explore 2026-05-25 -->
<!-- If any parameter below is rejected at generation time, call higgsfield:models_explore
     with the target model name to refresh the live schema — the live catalog is the source
     of truth over these cached specs. -->

# Cinematic Model Specifications

This reference documents the per-model parameters, aspect ratios, durations, and routing
rationale for the three cinematic models. All values are sourced from verified
`higgsfield:models_explore` data (2026-05-25). Re-query on any parameter rejection.

---

## Table of Contents

1. [cinematic_studio_3_0 — Primary (video)](#cinematic_studio_3_0--primary-video)
   - [Parameters](#parameters)
   - [Per-platform aspect ratio and duration recommendations](#per-platform-aspect-ratio-and-duration-recommendations)
2. [veo3_1 — Fallback (video)](#veo3_1--fallback-video)
   - [Parameters](#parameters-1)
   - [Routing rationale](#routing-rationale)
3. [cinematic_studio_2_5 — Still-image path](#cinematic_studio_2_5--still-image-path)
   - [Parameters](#parameters-2)
4. [Source of truth note](#source-of-truth-note)

---

## cinematic_studio_3_0 — Primary (video)

**Full name:** Cinema Studio Video 3.0 (Higgsfield)
**Routing rationale (MODEL-01):** Dedicated cinematic pipeline; chosen as primary for
film-grade video output. Use this model by default for all cinematic video requests.

### Parameters

| Parameter | Value | Notes |
|-----------|-------|-------|
| Tunable parameters | **NONE** | No quality, genre, mode, or resolution knobs to set. Do not invent or pass any. |
| Aspect ratios | `16:9`, `9:16`, `1:1` | All three supported |
| Duration | `4`–`15` seconds | Continuous range — any whole value between 4 and 15 is valid |
| Media roles | `image`, `start_image`, `end_image` | Supports text-to-video (T2V) and image-to-video (I2V) |

**Key constraint:** `cinematic_studio_3_0` exposes **no tunable parameters** at the API
level. Pass only `aspect_ratio` and `duration` (and optionally a media reference for I2V).
Do not emit quality, genre, fps, or resolution arguments — they will be rejected.

### Per-platform aspect ratio and duration recommendations

| Platform | Aspect ratio | Recommended duration | Notes |
|----------|-------------|----------------------|-------|
| TikTok | `9:16` | 6–10 s | Vertical full-screen; hook must land in first 2 s |
| Instagram Reels | `9:16` | 8–12 s | Vertical; high visual polish expected |
| YouTube Shorts | `9:16` or `16:9` | 10–15 s | Slightly more patient audience; 15 s max suits full-arc storytelling |
| YouTube (standard) | `16:9` | 10–15 s | Widescreen; longer contemplative pacing works |
| LinkedIn | `16:9` | 8–12 s | Professional format; deliberate pacing |
| Instagram feed / Square | `1:1` | 4–8 s | Square crop; keep composition center-weighted |

**Duration guidance by use-case:**
- **4–6 s** — Tight hook moments, single-beat impact (black-to-burst, emotional reveal)
- **8–10 s** — Hook + context + climax; standard short-form viral arc
- **12–15 s** — Full narrative arc: hook → setup → rising action → climax → resolution

---

## veo3_1 — Fallback (video)

**Full name:** Google Veo 3.1
**Routing rationale (MODEL-01):** Use when `cinematic_studio_3_0` is unavailable, or when
the user explicitly wants photorealistic output with native audio (voiceover, dialogue,
sound effects generated alongside the video).

### Parameters

| Parameter | Options | Default | Notes |
|-----------|---------|---------|-------|
| `quality` | `basic`, `high`, `ultra` | `basic` | Higher quality = slower generation and higher credit cost |
| `model` | `veo-3-1-preview`, `veo-3-1-fast` | `veo-3-1-fast` | `veo-3-1-fast` is the default; use `veo-3-1-preview` for maximum quality |
| `aspect_ratio` | `16:9`, `9:16` | — | **No `1:1`** — square aspect ratio is NOT supported by this model |
| `duration` | `4`, `6`, `8` | — | **Discrete list, not a range.** Only these three exact values are valid. |
| Media role | `start_image` | — | Maximum 1 image reference; end_image not supported |
| Native audio | yes | — | Can generate synchronized audio natively — a primary routing reason |

**Critical constraints for veo3_1:**
- Duration is a **discrete set** `[4, 6, 8]` — do not pass 5, 7, 10, 12, or 15.
- `1:1` aspect ratio is **not supported** — use `cinematic_studio_3_0` for square output.
- Only one `start_image` reference is supported; no `end_image`.

### Routing rationale

Prefer `cinematic_studio_3_0` (primary) unless one of these applies:
1. The primary model is unavailable at generation time.
2. The user wants **native audio generation** (voiced narration, dialogue, diegetic sound)
   alongside the video clip.
3. The user explicitly requests photorealistic output and accepts the discrete duration
   constraint.

---

## cinematic_studio_2_5 — Still-image path

**Full name:** Cinema Studio Image 2.5 (Higgsfield)
**Use case (MODEL-05):** Generate a production still or mood-board frame before committing
to video generation. Use to preview composition, lighting, and color grade before a video
generation credit is spent.

### Parameters

| Parameter | Options | Default | Notes |
|-----------|---------|---------|-------|
| `resolution` | `1k`, `2k`, `4k` | `1k` | `4k` is a **legitimate enum for this image model only** — it is not an invented spec |
| `aspect_ratio` | `1:1`, `4:3`, `3:4`, `16:9`, `9:16` | — | Full five-ratio support including portrait 3:4 and standard 4:3 |

**Note on `4k`:** The `4k` resolution enum is valid only for `cinematic_studio_2_5`. It does
not apply to any video model — do not use "4K" as a video output claim anywhere in the
cinematic skill.

**Workflow note:** After generating a still with `cinematic_studio_2_5`, use the output
image as a `start_image` reference for `cinematic_studio_3_0` to continue into video,
maintaining the established composition and color grade.

---

## Source of truth note

These specs are cached from a verified `higgsfield:models_explore` query on 2026-05-25.
Model APIs evolve. If any parameter is **rejected at generation time**:

1. Call `higgsfield:models_explore` with the target model name.
2. Read the returned schema for current valid values.
3. Substitute the corrected value before retrying.

Never infer or guess parameter values. The live catalog is the authoritative source.
