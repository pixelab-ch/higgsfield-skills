<!-- verified: models_explore 2026-05-25 -->
<!-- If any parameter below is rejected at generation time, call higgsfield:models_explore
     with the target model name to refresh the live schema — the live catalog is the source
     of truth over these cached specs. -->

# Real Estate Model Specifications

This reference documents the per-model parameters, aspect ratios, durations, and routing
rationale for the two models used in the real-estate skill. All values are sourced from a
verified `higgsfield:models_explore` query (2026-05-25). Re-query on any parameter rejection.

---

## Table of Contents

1. [cinematic_studio_3_0 — Primary (video)](#cinematic_studio_3_0--primary-video)
   - [Parameters](#parameters)
   - [Per-platform aspect ratio and duration recommendations](#per-platform-aspect-ratio-and-duration-recommendations)
2. [veo3_1 — Fallback (video)](#veo3_1--fallback-video)
   - [Parameters](#parameters-1)
   - [Routing rationale and informed-consent disclosure](#routing-rationale-and-informed-consent-disclosure)
3. [Source of truth note](#source-of-truth-note)

---

## cinematic_studio_3_0 — Primary (video)

**Full name:** Cinema Studio Video 3.0 (Higgsfield)
**Routing rationale (MODEL-01):** Dedicated cinematic pipeline; default for all real-estate
showcase video. Supports `1:1` square crop, continuous duration range, and both
`start_image` and `end_image` roles.

### Parameters

| Parameter | Value | Notes |
|-----------|-------|-------|
| Tunable parameters | **NONE** | No quality, genre, mode, or resolution knobs to set. Do not invent or pass any. |
| Aspect ratios | `16:9`, `9:16`, `1:1` | All three supported — including `1:1` square |
| Duration | `4`–`15` seconds | Continuous range — any whole value between 4 and 15 is valid |
| Media roles | `image`, `start_image`, `end_image` | Supports T2V and I2V; both start and end image roles supported |

**Key constraint:** `cinematic_studio_3_0` exposes **no tunable parameters** at the API
level. Pass only `aspect_ratio` and `duration` (and optionally a media reference for I2V).
Do not emit quality, genre, fps, or resolution arguments — they will be rejected.

### Per-platform aspect ratio and duration recommendations

| Platform | Aspect ratio | Recommended duration | Notes |
|----------|-------------|----------------------|-------|
| TikTok | `9:16` | 6–10 s | Vertical full-screen; hook must land in first 2 s |
| Instagram Reels | `9:16` | 8–12 s | Vertical; high visual polish expected |
| YouTube Shorts | `9:16` or `16:9` | 10–15 s | More patient audience; 15 s suits full-arc property tour |
| YouTube (standard) | `16:9` | 12–15 s | Widescreen; longer contemplative pacing works for property walkthroughs |
| LinkedIn | `16:9` | 8–12 s | Professional format; deliberate pacing; agent/agency audience |
| Instagram feed / Square | `1:1` | 4–8 s | Square crop; keep composition center-weighted; works for interior details |

**Duration guidance by use-case:**
- **4–6 s** — Single hook moment, detail reveal, or establishing shot
- **8–10 s** — Hook + room walkthrough + view reveal; standard short-form arc
- **12–15 s** — Full narrative arc: arrival → entry → primary living space → view → outro

---

## veo3_1 — Fallback (video)

**Full name:** Google Veo 3.1
**Routing rationale (MODEL-01):** Use when `cinematic_studio_3_0` is unavailable, or when
the user explicitly wants photorealistic output with native audio (voiceover narration,
ambient sound, or diegetic sound effects generated alongside the video).

### Parameters

| Parameter | Options | Default | Notes |
|-----------|---------|---------|-------|
| `quality` | `basic`, `high`, `ultra` | `basic` | Higher quality = slower generation and higher credit cost |
| `model` | `veo-3-1-preview`, `veo-3-1-fast` | `veo-3-1-fast` | `veo-3-1-fast` is the default; use `veo-3-1-preview` for maximum quality |
| `aspect_ratio` | `16:9`, `9:16` | — | **No `1:1`** — square aspect ratio is NOT supported by this model |
| `duration` | `4`, `6`, `8` | — | **Discrete list, not a range.** Only these three exact values are valid. |
| Media role | `start_image` | — | Maximum 1 image reference; `end_image` is NOT supported |
| Native audio | yes | — | Can generate synchronized audio natively — a primary routing reason |

**Critical constraints for veo3_1 — informed consent required:**
- Duration is a **discrete set** `[4, 6, 8]` — do not pass 5, 7, 9, 10, 12, or 15.
- `1:1` aspect ratio is **not supported** — use `cinematic_studio_3_0` for square output.
- Only one `start_image` reference is supported; no `end_image`.

### Routing rationale and informed-consent disclosure

Prefer `cinematic_studio_3_0` (primary) unless one of these applies:
1. The primary model is unavailable at generation time.
2. The user wants **native audio generation** (voiceover narration, ambient sound, dialogue)
   alongside the video clip.
3. The user explicitly requests photorealistic output and accepts veo3_1's constraints.

**Before switching to veo3_1, inform the user of what they give up:**
- No `1:1` aspect ratio (square crop is lost)
- Duration locks to discrete steps: `4`, `6`, or `8` seconds only — no continuous range
- No `end_image` reference (only `start_image` is supported, max 1)

Never switch silently. If the user has not been told of these trade-offs, stay on
`cinematic_studio_3_0`.

---

## Source of truth note

These specs are cached from a verified `higgsfield:models_explore` query on 2026-05-25.
Model APIs evolve. If any parameter is **rejected at generation time**:

1. Call `higgsfield:models_explore` with the target model name.
2. Read the returned schema for current valid values.
3. Substitute the corrected value before retrying.

Never infer or guess parameter values. The live catalog is the authoritative source.
