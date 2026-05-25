<!-- verified: models_explore 2026-05-25 -->
<!-- If any parameter below is rejected at generation time, call higgsfield:models_explore
     with the target model name to refresh the live schema — the live catalog is the source
     of truth over these cached specs. -->

# Social-Hook Model Specifications

This reference documents the per-model parameters, aspect ratios, durations, and routing
rationale for the two social-hook video models. All values are sourced from a verified
`higgsfield:models_explore` query (2026-05-25). Re-query on any parameter rejection.

---

## Table of Contents

1. [kling3_0 — Primary (video)](#kling3_0--primary-video)
   - [Parameters](#parameters)
   - [Per-platform aspect ratio and duration recommendations](#per-platform-aspect-ratio-and-duration-recommendations)
2. [grok_video — Fallback (video)](#grok_video--fallback-video)
   - [Parameters](#parameters-1)
   - [Routing rationale](#routing-rationale)
3. [Source of truth note](#source-of-truth-note)

---

## kling3_0 — Primary (video)

**Full name:** Kling 3.0 (via Higgsfield)
**Routing rationale:** Default model for all social-hook video requests. Supports a wide
duration range (3–15 s), multiple aspect ratios including 1:1, and optional start/end image
references. The `4k` mode is a **generation mode enum** — it does NOT mean the output file
is 4K resolution.

### Parameters

| Parameter | Options | Default | Notes |
|-----------|---------|---------|-------|
| `mode` | `std`, `pro`, `4k` | `std` | `4k` is a generation-mode enum, NOT an output-resolution claim. Do NOT describe it as "4K output" or "3840×2160". |
| `sound` | `on`, `off` | `off` | Controls whether audio is generated alongside the video |
| `aspect_ratio` | `16:9`, `9:16`, `1:1` | — | All three supported |
| `duration` | `3`–`15` seconds | — | Continuous range — any whole value between 3 and 15 is valid |
| Media roles | `start_image`, `end_image` | — | Supports T2V and I2V; both start and end image supported |

**Key constraint on `4k` mode:** The `4k` value in the `mode` enum does not produce a
4K-resolution output file. It is a generation pipeline setting. Never advertise or document
it as "4K output", "8K", "3840×2160", or "2160p". If the user asks about video resolution,
clarify that model output is not a guaranteed 4K file.

### Per-platform aspect ratio and duration recommendations

| Platform | Aspect ratio | Recommended duration | Notes |
|----------|-------------|----------------------|-------|
| TikTok | `9:16` | 6–10 s | Vertical full-screen; hook must land in first 2 s |
| Instagram Reels | `9:16` | 8–12 s | Vertical; high visual polish expected |
| YouTube Shorts | `9:16` | 10–15 s | Slightly more patient audience; up to 15 s |
| YouTube (standard) | `16:9` | 10–15 s | Widescreen; longer pacing works |
| Instagram feed / Square | `1:1` | 4–8 s | Square crop supported on kling3_0 (not on grok_video) |

**Duration guidance by hook type:**
- **3–5 s** — Ultra-short hook-only clips; pure attention grab
- **6–10 s** — Hook + payoff; standard viral arc
- **12–15 s** — Hook + escalation + resolution; storytime or transformation formats

---

## grok_video — Fallback (video)

**Full name:** Grok Video (via Higgsfield)
**Routing rationale:** Use when `kling3_0` is unavailable or when the user explicitly wants
native audio generation alongside the video (Grok Video generates audio natively).

### Parameters

| Parameter | Options | Default | Notes |
|-----------|---------|---------|-------|
| Tunable parameters | **NONE** | — | No quality, mode, or resolution knobs. Do not invent or pass any. |
| `aspect_ratio` | `16:9`, `9:16`, `1:1` | — | All three supported |
| `duration` | `1`–`15` seconds | — | Continuous range — any whole value between 1 and 15 is valid |
| Media role | `start_image` | — | Maximum 1 image reference; end_image not supported |
| Native audio | yes | — | Generates synchronized audio natively — a primary routing reason |

**Key constraint:** `grok_video` has **no tunable parameters**. Pass only `aspect_ratio`
and `duration` (and optionally a single `start_image`). Do not emit quality, mode, or
resolution arguments — they will be rejected.

### Routing rationale

Prefer `kling3_0` (primary) unless one of these applies:

1. `kling3_0` is unavailable at generation time.
2. The user explicitly wants **native audio generation** (voiceover, dialogue, or
   synchronized sound effects) alongside the video clip.
3. The user accepts that `grok_video` has no tunable parameters and no `end_image` support.

**Informed-consent requirement:** Before switching from `kling3_0` to `grok_video`, inform
the user of the trade-offs: no mode/sound tuning, only one image role (`start_image`),
no `end_image`. Never switch silently.

---

## Source of truth note

These specs are cached from a verified `higgsfield:models_explore` query on 2026-05-25.
Model APIs evolve. If any parameter is **rejected at generation time**:

1. Call `higgsfield:models_explore` with the target model name.
2. Read the returned schema for current valid values.
3. Substitute the corrected value before retrying.

Never infer or guess parameter values. The live catalog is the authoritative source.
