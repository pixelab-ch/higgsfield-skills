<!-- verified: models_explore 2026-05-25 -->
<!-- If any parameter below is rejected at generation time, call higgsfield:models_explore
     with the target model name to refresh the live schema — the live catalog is the source
     of truth over these cached specs. -->

# Brand-Story Model Specifications

This reference documents the per-model parameters, aspect ratios, durations, and routing
rationale for the two brand-story video models and the soul_location still-image model.
All values are sourced from a verified `higgsfield:models_explore` query (2026-05-25).
Re-query on any parameter rejection.

---

## Table of Contents

1. [cinematic_studio_3_0 — Primary (video)](#cinematic_studio_3_0--primary-video)
   - [Parameters](#parameters)
   - [Per-platform aspect ratio and duration recommendations](#per-platform-aspect-ratio-and-duration-recommendations)
2. [veo3_1 — Fallback (video)](#veo3_1--fallback-video)
   - [Parameters](#parameters-1)
   - [Routing rationale](#routing-rationale)
3. [soul_location — Still-image path](#soul_location--still-image-path)
   - [Parameters](#parameters-2)
4. [Source of truth note](#source-of-truth-note)

---

## cinematic_studio_3_0 — Primary (video)

**Full name:** Cinema Studio Video 3.0 (Higgsfield)
**Routing rationale:** Dedicated cinematic pipeline; default for all brand-story video
requests. Supports continuous duration range (4–15 s), all three aspect ratios including
`1:1`, and both start and end image references.

### Parameters

| Parameter | Value | Notes |
|-----------|-------|-------|
| Tunable parameters | **NONE** | No quality, genre, mode, or resolution knobs to set. Do not invent or pass any. |
| Aspect ratios | `16:9`, `9:16`, `1:1` | All three supported |
| Duration | `4`–`15` seconds | Continuous range — any whole value between 4 and 15 is valid |
| Media roles | `image`, `start_image`, `end_image` | Supports T2V and I2V; both start and end image supported |

**Key constraint:** `cinematic_studio_3_0` exposes **no tunable parameters** at the API
level. Pass only `aspect_ratio` and `duration` (and optionally a media reference for
I2V). Do not emit quality, genre, fps, or resolution arguments — they will be rejected.

### Per-platform aspect ratio and duration recommendations

| Platform | Aspect ratio | Recommended duration | Notes |
|----------|-------------|----------------------|-------|
| TikTok / Reels / Shorts | `9:16` | 6–12 s | Vertical; hook must land in first 2 s |
| YouTube (standard) | `16:9` | 10–15 s | Widescreen; longer contemplative pacing works |
| LinkedIn | `16:9` | 8–12 s | Professional format; deliberate pacing |
| Website hero video | `16:9` | 8–15 s | Auto-play context; clarity and emotional punch |
| Instagram feed / Square | `1:1` | 4–8 s | Square crop; keep composition center-weighted |

**Duration guidance by brand story format:**
- **4–6 s** — Single emotional beat, product establishing shot, tight hook moment
- **8–10 s** — Hook + context + climax; standard short-form brand clip
- **12–15 s** — Full narrative arc: hook → setup → rising action → climax → resolution

---

## veo3_1 — Fallback (video)

**Full name:** Google Veo 3.1
**Routing rationale:** Use when `cinematic_studio_3_0` is unavailable, or when the user
explicitly wants native audio generation (voiceover, dialogue, diegetic sound) alongside
the video clip.

### Parameters

| Parameter | Options | Default | Notes |
|-----------|---------|---------|-------|
| `quality` | `basic`, `high`, `ultra` | `basic` | Higher quality = slower generation and higher credit cost |
| `model` | `veo-3-1-preview`, `veo-3-1-fast` | `veo-3-1-fast` | `veo-3-1-fast` is the default; use `veo-3-1-preview` for maximum quality |
| `aspect_ratio` | `16:9`, `9:16` | — | **No `1:1`** — square aspect ratio is NOT supported |
| `duration` | `4`, `6`, `8` | — | **Discrete list, not a range.** Only these three exact values are valid. |
| Media role | `start_image` | — | Maximum 1 image reference; `end_image` not supported |
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
3. The user explicitly requests photorealistic output and, after being told the trade-offs,
   accepts the constraints.

**Informed-consent requirement (MODEL-06):** Before switching from `cinematic_studio_3_0`
to `veo3_1`, inform the user of the trade-offs:
- **Loses `1:1` aspect ratio** — no square output on veo3_1.
- **Loses continuous durations** — only `4`, `6`, `8` s (discrete). No 5 s, 10 s, 12 s,
  15 s, etc.
- **Loses `end_image` support** — only one `start_image` is allowed.

Never switch silently.

---

## soul_location — Still-image path

**Full name:** Soul Location (Higgsfield image model)
**Use case (MODEL-05):** Generate a brand location or establishing still — a venue,
storefront, workspace, or environmental brand moment — before committing to video
generation. Use to preview composition, lighting, and brand aesthetic. The output
image can then be passed as a `start_image` to `cinematic_studio_3_0` to carry the
established location and atmosphere into video.

**Tool:** `higgsfield:generate_image` with `model: soul_location`

### Parameters

| Parameter | Value | Notes |
|-----------|-------|-------|
| Tunable parameters | **NONE** | No quality, mode, or resolution knobs to set. Do not invent or pass any. |
| Aspect ratios | `1:1`, `4:3`, `3:4`, `16:9`, `9:16`, `3:2`, `2:3`, `21:9`, `9:21` | Full nine-ratio support |

**Workflow note:** After generating a still with `soul_location`, use the output image
as a `start_image` reference for `cinematic_studio_3_0` to continue into video,
maintaining the established composition, lighting, and location aesthetic.

---

## Source of truth note

These specs are cached from a verified `higgsfield:models_explore` query on 2026-05-25.
Model APIs evolve. If any parameter is **rejected at generation time**:

1. Call `higgsfield:models_explore` with the target model name.
2. Read the returned schema for current valid values.
3. Substitute the corrected value before retrying.

Never infer or guess parameter values. The live catalog is the authoritative source.
