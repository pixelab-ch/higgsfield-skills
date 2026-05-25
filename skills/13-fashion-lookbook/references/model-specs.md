<!-- verified: models_explore 2026-05-25 -->
<!-- If any parameter below is rejected at generation time, call higgsfield:models_explore
     with the target model name to refresh the live schema — the live catalog is the source
     of truth over these cached specs. -->

# Fashion Lookbook Model Specifications

This reference documents the per-model parameters, aspect ratios, durations, and routing
rationale for the three models used in the fashion-lookbook skill. All values are sourced
from a verified `higgsfield:models_explore` query (2026-05-25). Re-query on any parameter
rejection.

---

## Table of Contents

1. [cinematic_studio_video_v2 — Primary (video)](#cinematic_studio_video_v2--primary-video)
   - [Parameters](#parameters)
   - [Per-platform aspect ratio and duration recommendations](#per-platform-aspect-ratio-and-duration-recommendations)
2. [seedance_2_0 — Fallback (video)](#seedance_2_0--fallback-video)
   - [Parameters](#parameters-1)
   - [Routing rationale](#routing-rationale)
3. [soul_cinematic — Still-image path](#soul_cinematic--still-image-path)
   - [Parameters](#parameters-2)
4. [Source of truth note](#source-of-truth-note)

---

## cinematic_studio_video_v2 — Primary (video)

**Full name:** Cinematic Studio Video v2 (Higgsfield)
**Routing rationale (MODEL-01):** Dedicated fashion-grade video pipeline with genre and mode
controls. Use by default for all fashion lookbook video requests. Note: maximum duration is
**12 seconds** — shorter than the 15-second cap on other models; do not over-promise duration.

### Parameters

| Parameter | Options | Default | Notes |
|-----------|---------|---------|-------|
| `genre` | `auto`, `action`, `horror`, `comedy`, `western`, `suspense`, `intimate`, `spectacle` | `auto` | `intimate` is the recommended default for fashion; `spectacle` for editorial campaigns |
| `mode` | `pro`, `std` | `std` | `pro` gives higher fidelity at greater credit cost |
| `aspect_ratio` | `1:1`, `4:3`, `3:4`, `16:9`, `9:16` | — | Five ratios; includes portrait `3:4` and landscape `4:3` |
| `duration` | `3`–`12` seconds | — | **Continuous range 3–12 s — maximum is 12 s (not 15 s).** Do not pass values above 12. |
| Media roles | `image`, `start_image`, `end_image` | — | Supports T2V and I2V; both `start_image` and `end_image` supported |

**Key constraint:** `cinematic_studio_video_v2` caps at **12 seconds**, not 15. This is
shorter than `seedance_2_0`. Never promise a 15-second fashion clip on this model.

### Per-platform aspect ratio and duration recommendations

| Platform | Aspect ratio | Recommended duration | Notes |
|----------|-------------|----------------------|-------|
| TikTok | `9:16` | 5–8 s | Vertical full-screen; hook must land in first 2 s |
| Instagram Reels | `9:16` | 7–10 s | Vertical; high visual polish; 10 s is strong for fashion |
| YouTube Shorts | `9:16` or `16:9` | 10–12 s | Slightly more patient; 12 s max allows full lookbook arc |
| YouTube (standard) | `16:9` | 10–12 s | Widescreen; continuous pacing works for multi-look |
| Instagram feed / Square | `1:1` | 4–8 s | Square crop; keep composition center-weighted |
| Editorial / portrait print | `3:4` | 5–10 s | Portrait orientation for magazine-style format |

**Duration guidance by use-case:**
- **3–5 s** — Single-look hook, macro fabric reveal, or outfit flash
- **6–9 s** — Hook + model walk + detail close-up; standard Reels/Shorts arc
- **10–12 s** — Full lookbook arc: hook → walk → rotation → detail → pose

---

## seedance_2_0 — Fallback (video)

**Full name:** Seedance 2.0 (Higgsfield)
**Routing rationale (MODEL-01):** Use when `cinematic_studio_video_v2` is unavailable, or
when the user wants a longer duration (up to 15 s), audio, or the noir/drama/epic genre tags
not available in v2. Accepts image-to-video, audio, and video roles.

### Parameters

| Parameter | Options | Default | Notes |
|-----------|---------|---------|-------|
| `resolution` | `480p`, `720p`, `1080p` | `720p` | Higher resolution costs more credits |
| `mode` | `std`, `fast` | `std` | `fast` reduces generation time at some quality cost |
| `genre` | `auto`, `action`, `horror`, `comedy`, `noir`, `drama`, `epic` | `auto` | Noir/drama/epic are unique to this model (not in v2) |
| `aspect_ratio` | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` | `auto` | Supports `21:9` ultra-wide and `auto` (model decides) |
| `duration` | `4`–`15` seconds | — | **Continuous range 4–15 s** — longer than v2's 12 s cap |
| Media roles | `image`, `start_image`, `end_image`, `video`, `audio` | — | Adds `video` and `audio` roles beyond v2's set |

### Routing rationale

Prefer `cinematic_studio_video_v2` (primary) unless one of these applies:
1. The primary model is unavailable at generation time.
2. The user wants a duration **longer than 12 seconds** (seedance_2_0 supports up to 15 s).
3. The user wants a genre tag not available in v2: `noir`, `drama`, or `epic`.
4. The user wants to attach an audio or video reference via the `audio` / `video` roles.

Never switch silently — inform the user of the trade-off (different genre palette,
no `4:3` or `3:4` shortfall — note seedance_2_0 does support those) before switching.

---

## soul_cinematic — Still-image path

**Full name:** Soul Cinematic (Higgsfield)
**Use case (MODEL-05):** Generate a lookbook still or mood-board frame before committing to
video generation. Use via `higgsfield:generate_image`. A generated still can then serve as
a `start_image` reference for `cinematic_studio_video_v2` to carry the composition into video.

### Parameters

| Parameter | Options | Default | Notes |
|-----------|---------|---------|-------|
| `quality` | `1.5k`, `2k` | — | **Maximum quality is `2k`** — there is no `4k` enum for this model |
| `soul_id` | any valid soul ID | optional | Attach a specific Soul (character/style identity) if desired |
| `aspect_ratio` | `1:1`, `4:3`, `3:4`, `16:9`, `9:16`, `3:2`, `2:3`, `21:9` | — | Eight-ratio set including `3:2`, `2:3`, and `21:9` |

**Note on quality:** `soul_cinematic` tops out at `2k`. Do not use `4k` — that enum belongs
to `cinematic_studio_2_5` only. Never claim video output at 4K.

**Workflow note:** After generating a lookbook still with `soul_cinematic`, use the output
as a `start_image` reference for `cinematic_studio_video_v2` to extend the established
composition and styling into a video clip.

---

## Source of truth note

These specs are cached from a verified `higgsfield:models_explore` query on 2026-05-25.
Model APIs evolve. If any parameter is **rejected at generation time**:

1. Call `higgsfield:models_explore` with the target model name.
2. Read the returned schema for current valid values.
3. Substitute the corrected value before retrying.

Never infer or guess parameter values. The live catalog is the authoritative source.
