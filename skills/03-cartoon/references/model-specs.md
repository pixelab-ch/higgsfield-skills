<!-- verified: models_explore 2026-05-25 -->
<!-- If any parameter below is rejected at generation time, call higgsfield:models_explore
     with the target model name to refresh the live schema — the live catalog is the source
     of truth over these cached specs. -->

# Cartoon Animation Model Specifications

This reference documents the per-model parameters, aspect ratios, durations, and routing
rationale for the two cartoon animation models. All values are sourced from verified
`higgsfield:models_explore` data (2026-05-25). Re-query on any parameter rejection.

---

## Table of Contents

1. [wan2_7 — Primary (video)](#wan2_7--primary-video)
   - [Parameters](#parameters)
   - [Per-platform aspect ratio and duration recommendations](#per-platform-aspect-ratio-and-duration-recommendations)
2. [seedance_2_0 — Fallback (video)](#seedance_2_0--fallback-video)
   - [Parameters](#parameters-1)
   - [Routing rationale](#routing-rationale)
3. [Source of truth note](#source-of-truth-note)

---

## wan2_7 — Primary (video)

**Routing rationale:** Default model for cartoon and animation-style video. Delivers
clean stylized output suited to 2D animation aesthetics. Minimum 2-second duration gives
flexibility for very short social clips.

### Parameters

| Parameter | Options | Notes |
|-----------|---------|-------|
| `resolution` | `720p`, `1080p` | Max output resolution is 1080p — higher resolutions are not supported |
| `aspect_ratio` | `16:9`, `9:16`, `1:1`, `4:3`, `3:4` | Full set for social platforms |
| `duration` | `2`–`15` seconds | Continuous range — any whole value between 2 and 15 is valid |
| Media roles | `start_image`, `end_image`, `audio` | No `image` or `video` roles on this model |
| Tunable genre/mode | **None** | No `genre` or `mode` params |

**Key constraint:** Max video resolution is `1080p`. Resolution params above 1080p, codec
specs, and frame-rate arguments do not exist on this model and will be rejected.

### Per-platform aspect ratio and duration recommendations

| Platform | Aspect ratio | Recommended duration | Notes |
|----------|-------------|----------------------|-------|
| TikTok | `9:16` | 4–8 s | Vertical full-screen; hook must land in first 2 s |
| Instagram Reels | `9:16` | 6–10 s | Vertical; bold cartoon style cuts through feed |
| YouTube Shorts | `9:16` or `16:9` | 8–12 s | Slightly more patient audience |
| YouTube (standard) | `16:9` | 10–15 s | Widescreen; suited for longer narrative sequences |
| LinkedIn | `16:9` | 8–12 s | Professional format; motion graphics and explainers |
| Instagram feed / Square | `1:1` | 4–8 s | Square crop; center-weighted composition |
| Portrait (classic) | `3:4` | 4–8 s | Classic portrait for character reveals |

**Duration guidance by use-case:**
- **2–4 s** — Single hook beat, reaction gag, single character action
- **6–8 s** — Hook + main action + punchline; standard social cartoon arc
- **10–15 s** — Full short narrative: setup → rising action → payoff

---

## seedance_2_0 — Fallback (video)

**Routing rationale:** Use when `wan2_7` is unavailable. Offers `genre` and `mode` params
plus `image` and `video` media roles not available on the primary, but lacks wan2_7's
2-second minimum duration.

### Parameters

| Parameter | Options | Default | Notes |
|-----------|---------|---------|-------|
| `resolution` | `480p`, `720p`, `1080p` | `720p` | Max 1080p; higher resolutions not supported |
| `mode` | `std`, `fast` | — | `fast` reduces generation time at quality cost |
| `genre` | `auto`, `action`, `horror`, `comedy`, `noir`, `drama`, `epic` | `auto` | Optional style bias |
| `aspect_ratio` | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` | — | Wider aspect set including `21:9` |
| `duration` | `4`–`15` seconds | — | Continuous range; minimum is 4 s (higher than primary's 2 s) |
| Media roles | `image`, `start_image`, `end_image`, `video`, `audio` | — | Full set including `image` and `video` |

**What you give up vs. wan2_7 when falling back to seedance_2_0:**
- Minimum duration is 4 s instead of 2 s (can't do ultra-short 2-second clips)

**What you gain vs. wan2_7 when using seedance_2_0:**
- `genre` tag for comedy / action / drama bias (useful for cartoon tone)
- `image` and `video` media roles
- `21:9` cinematic widescreen

Inform the user of these trade-offs before switching. Never switch silently.

### Routing rationale

Prefer `wan2_7` (primary) unless:
1. The primary model is unavailable at generation time.
2. The user explicitly needs a 2-second minimum clip that `seedance_2_0` cannot provide
   (in this case wan2_7 remains the only option for 2-3 s clips).
3. The user explicitly wants `genre` tagging or `video`/`image` media roles and accepts
   the 4-second minimum duration.

---

## Source of truth note

These specs are cached from a verified `higgsfield:models_explore` query on 2026-05-25.
Model APIs evolve. If any parameter is **rejected at generation time**:

1. Call `higgsfield:models_explore` with the target model name.
2. Read the returned schema for current valid values.
3. Substitute the corrected value before retrying.

Never infer or guess parameter values. The live catalog is the authoritative source.
