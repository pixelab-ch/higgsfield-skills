<!-- verified: models_explore 2026-05-25 -->
<!-- If any parameter below is rejected at generation time, call higgsfield:models_explore
     with the target model name to refresh the live schema — the live catalog is the source
     of truth over these cached specs. -->

# 3D CGI Model Specifications

This reference documents the per-model parameters, aspect ratios, durations, and routing
rationale for the two 3D CGI models. All values are sourced from verified
`higgsfield:models_explore` data (2026-05-25). Re-query on any parameter rejection.

---

## Table of Contents

1. [seedance_2_0 — Primary (video)](#seedance_2_0--primary-video)
   - [Parameters](#parameters)
   - [Per-platform aspect ratio and duration recommendations](#per-platform-aspect-ratio-and-duration-recommendations)
2. [wan2_7 — Fallback (video)](#wan2_7--fallback-video)
   - [Parameters](#parameters-1)
   - [Routing rationale](#routing-rationale)
3. [Source of truth note](#source-of-truth-note)

---

## seedance_2_0 — Primary (video)

**Routing rationale:** Default model for all 3D CGI and rendered video requests. Supports
genre tagging, multiple aspect ratios (including 21:9), and the widest media-role set
(including `video` and `audio` inputs).

### Parameters

| Parameter | Options | Default | Notes |
|-----------|---------|---------|-------|
| `resolution` | `480p`, `720p`, `1080p` | `720p` | Max output resolution is 1080p — higher resolutions are not supported |
| `mode` | `std`, `fast` | — | `fast` reduces generation time at quality cost |
| `genre` | `auto`, `action`, `horror`, `comedy`, `noir`, `drama`, `epic` | `auto` | Optional style bias; `auto` lets model decide |
| `aspect_ratio` | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` | — | `21:9` cinematic widescreen available on this model only |
| `duration` | `4`–`15` seconds | — | Continuous range — any whole value between 4 and 15 is valid |
| Media roles | `image`, `start_image`, `end_image`, `video`, `audio` | — | Full set; use `video` for video-to-video, `audio` for audio-guided generation |

**Key constraint:** Max video resolution is `1080p`. Resolution params above 1080p, codec
specs, and frame-rate arguments do not exist on this model and will be rejected.

### Per-platform aspect ratio and duration recommendations

| Platform | Aspect ratio | Recommended duration | Notes |
|----------|-------------|----------------------|-------|
| TikTok | `9:16` | 6–10 s | Vertical full-screen; hook must land in first 2 s |
| Instagram Reels | `9:16` | 8–12 s | Vertical; high visual polish expected |
| YouTube Shorts | `9:16` or `16:9` | 10–15 s | 15 s max suits full-arc 3D reveal |
| YouTube (standard) | `16:9` | 10–15 s | Widescreen; cinematic pacing works well |
| Cinematic/film | `21:9` | 8–15 s | Ultrawide; only available on seedance_2_0 |
| LinkedIn | `16:9` | 8–12 s | Professional format; product visualization |
| Instagram feed / Square | `1:1` | 4–8 s | Square crop; center-weighted composition |

**Duration guidance by use-case:**
- **4–6 s** — Single reveal or transformation: particle materialization, product turntable
- **8–10 s** — Hook + develop + climax; standard short-form CGI arc
- **12–15 s** — Full narrative: environment establish → action → resolution

---

## wan2_7 — Fallback (video)

**Routing rationale:** Use when `seedance_2_0` is unavailable. Lacks `video`/`audio` media
roles and the `genre`/`mode` params, so some 3D CGI style flexibility is lost on fallback.

### Parameters

| Parameter | Options | Notes |
|-----------|---------|-------|
| `resolution` | `720p`, `1080p` | No `480p` option on this model |
| `aspect_ratio` | `16:9`, `9:16`, `1:1`, `4:3`, `3:4` | No `21:9` or `auto` |
| `duration` | `2`–`15` seconds | Continuous range; minimum is 2 s (lower than primary) |
| Media roles | `start_image`, `end_image`, `audio` | No `image` or `video` roles |
| Tunable genre/mode | **None** | No `genre` or `mode` params |

**What you give up vs. seedance_2_0 when falling back to wan2_7:**
- No `21:9` aspect ratio (no cinematic widescreen)
- No `genre` tag (no epic / noir / drama bias)
- No `mode` control (no fast generation option)
- No `video` media role (no video-to-video input)
- No `image` role — only `start_image` and `end_image` for I2V

Inform the user of these trade-offs before switching. Never switch silently.

### Routing rationale

Prefer `seedance_2_0` (primary) unless:
1. The primary model is unavailable at generation time.
2. The user explicitly accepts wan2_7's constraints after being informed of the trade-offs.

---

## Source of truth note

These specs are cached from a verified `higgsfield:models_explore` query on 2026-05-25.
Model APIs evolve. If any parameter is **rejected at generation time**:

1. Call `higgsfield:models_explore` with the target model name.
2. Read the returned schema for current valid values.
3. Substitute the corrected value before retrying.

Never infer or guess parameter values. The live catalog is the authoritative source.
