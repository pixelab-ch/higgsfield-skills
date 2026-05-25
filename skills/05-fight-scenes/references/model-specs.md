<!-- verified: models_explore 2026-05-25 -->
<!-- If any parameter below is rejected at generation time, call higgsfield:models_explore
     with the target model name to refresh the live schema — the live catalog is the source
     of truth over these cached specs. -->

# Fight Scenes Model Specifications

This reference documents the per-model parameters, aspect ratios, durations, and routing
rationale for the two fight-scene models. All values are sourced from verified
`higgsfield:models_explore` data (2026-05-25). Re-query on any parameter rejection.

---

## Table of Contents

1. [cinematic_studio_3_0 — Primary (video)](#cinematic_studio_3_0--primary-video)
   - [Parameters](#parameters)
   - [Per-platform aspect ratio and duration recommendations](#per-platform-aspect-ratio-and-duration-recommendations)
2. [kling3_0 — Fallback (video)](#kling3_0--fallback-video)
   - [Parameters](#parameters-1)
   - [Routing rationale](#routing-rationale)
3. [Source of truth note](#source-of-truth-note)

---

## cinematic_studio_3_0 — Primary (video)

**Routing rationale:** Dedicated cinematic pipeline; chosen as primary for fight scenes
and action sequences. Delivers film-grade output with dynamic motion, multi-character
choreography, weapon clarity, and impact effects that match the cinematic combat aesthetic.

### Parameters

| Parameter | Value | Notes |
|-----------|-------|-------|
| Tunable parameters | **NONE** | No quality, genre, mode, or resolution knobs to set. Do not invent or pass any. |
| Aspect ratios | `16:9`, `9:16`, `1:1` | All three supported |
| Duration | `4`–`15` seconds | Continuous range — any whole value between 4 and 15 is valid |
| Media roles | `image`, `start_image`, `end_image` | Supports text-to-video (T2V) and image-to-video (I2V) |

**Key constraint:** `cinematic_studio_3_0` exposes **no tunable parameters** at the API
level. Pass only `aspect_ratio` and `duration` (and optionally a media reference for I2V).
Do not emit quality, mode, resolution, or fps arguments — they will be rejected.

### Per-platform aspect ratio and duration recommendations

| Platform | Aspect ratio | Recommended duration | Notes |
|----------|-------------|----------------------|-------|
| TikTok | `9:16` | 6–10 s | Vertical full-screen; hook must land in first 2 s |
| Instagram Reels | `9:16` | 8–12 s | Vertical; high-energy action cuts through feed |
| YouTube Shorts | `9:16` or `16:9` | 10–15 s | Slightly more patient audience; 15 s suits full fight arc |
| YouTube (standard) | `16:9` | 10–15 s | Widescreen cinematic; longer takes with dynamic camera work |
| LinkedIn | `16:9` | 8–12 s | Professional format; stunt / VFX showcase |
| Instagram feed / Square | `1:1` | 4–8 s | Square crop; keep combatants center-weighted |

**Duration guidance by use-case:**
- **4–6 s** — Single exchange: one-punch moment, blade flash, kick impact
- **8–10 s** — Hook + exchange + climax; standard short-form fight arc
- **12–15 s** — Full fight sequence: setup → escalation → climax → resolution

---

## kling3_0 — Fallback (video)

**Routing rationale:** Use when `cinematic_studio_3_0` is unavailable. Offers `mode` and
`sound` tunable params, but narrower aspect ratio support (no `1:1`). Note on `mode`:
the `4k` option is a **generation mode enum** (controls the generation pipeline variant),
not a claim about 4K output file resolution — do not interpret or represent it as a 4K
video output specification.

### Parameters

| Parameter | Options | Notes |
|-----------|---------|-------|
| `mode` | `std`, `pro`, `4k` | `4k` is a mode enum (generation pipeline variant) — NOT a 4K output-resolution claim. Higher modes may improve quality or fidelity. |
| `sound` | `on`, `off` | Controls whether the model attempts to generate audio alongside the video |
| `aspect_ratio` | `16:9`, `9:16`, `1:1` | Same three ratios as cinematic_studio_3_0 |
| `duration` | `3`–`15` seconds | Continuous range; minimum is 3 s (one second shorter than primary) |
| Media roles | `start_image`, `end_image` | No `image` role; no `video` or `audio` input roles |

**What you give up vs. cinematic_studio_3_0 when falling back to kling3_0:**
- No `image` media role (only `start_image` and `end_image`)
- Different cinematic pipeline — output aesthetic will differ from primary

**What you gain vs. cinematic_studio_3_0 when using kling3_0:**
- `mode` control (`std`, `pro`, `4k` generation mode) for potential quality tuning
- `sound` option (`on`/`off`) for audio generation
- Minimum duration is 3 s instead of 4 s

Inform the user of these trade-offs before switching. Never switch silently.

### Routing rationale

Prefer `cinematic_studio_3_0` (primary) unless:
1. The primary model is unavailable at generation time.
2. The user explicitly accepts kling3_0's constraints after being told the trade-offs.
3. The user specifically wants the `sound` option or `mode` control.

---

## Source of truth note

These specs are cached from a verified `higgsfield:models_explore` query on 2026-05-25.
Model APIs evolve. If any parameter is **rejected at generation time**:

1. Call `higgsfield:models_explore` with the target model name.
2. Read the returned schema for current valid values.
3. Substitute the corrected value before retrying.

Never infer or guess parameter values. The live catalog is the authoritative source.
