<!-- verified: models_explore 2026-05-25 -->
<!-- If any parameter below is rejected at generation time, call higgsfield:models_explore
     with the target model name to refresh the live schema — the live catalog is the source
     of truth over these cached specs. -->

# Comic-to-Video Model Specifications

This reference documents the per-model parameters for the two comic-to-video models.
All values are sourced from verified `higgsfield:models_explore` data (2026-05-25).
Re-query on any parameter rejection.

**Both models require a confirmed image input before generation.**
See [SKILL.md](../SKILL.md) for the mandatory media_upload → media_confirm flow.

---

## Table of Contents

1. [wan2_6 — Primary (I2V, mandatory image)](#wan2_6--primary-i2v-mandatory-image)
2. [seedance_2_0 — Fallback](#seedance_2_0--fallback)
3. [Routing rationale](#routing-rationale)
4. [Source of truth note](#source-of-truth-note)

---

## wan2_6 — Primary (I2V, mandatory image)

**Routing rationale:** Default model for comic-to-video. Dedicated image-to-video pipeline;
the `image` role is REQUIRED — wan2_6 cannot run without a confirmed image input. This is
the structural reason this skill always takes the media upload branch.

### Parameters

| Parameter | Value | Notes |
|-----------|-------|-------|
| `quality` | `720p`, `1080p` | Resolution selector |
| `aspect_ratio` | `16:9`, `9:16`, `1:1` | Three ratios supported |
| `duration` | `5`, `10`, `15` | **Discrete set only** — not a continuous range. Only these exact values are valid. |
| Media roles | `image` x1 **REQUIRED** | The single image role is MANDATORY. Generation fails without it. Do not attempt to call wan2_6 without first completing media_upload → media_confirm. |

**Critical constraint:** Duration is a **discrete set** `[5, 10, 15]` — do not pass 4, 6, 7,
8, 9, 11, 12, 13, or 14. wan2_6 does not accept a continuous duration range.

**Max resolution:** 1080p. This model does not output 4K video.

### Per-platform aspect ratio and duration recommendations

| Platform | Aspect ratio | Recommended duration | Notes |
|----------|-------------|----------------------|-------|
| TikTok / Reels / Shorts | `9:16` | 5 s | Vertical; hook lands in first 2 s |
| YouTube (standard) | `16:9` | 10–15 s | Widescreen; full narrative arc |
| Instagram feed | `1:1` | 5–10 s | Square crop; center-weighted composition |

---

## seedance_2_0 — Fallback

**Routing rationale:** Use when wan2_6 is unavailable or when the user wants genre-specific
tone control (`genre` parameter), extended duration flexibility, or additional media roles
(end_image, audio).

### Parameters

| Parameter | Options | Default | Notes |
|-----------|---------|---------|-------|
| `resolution` | `480p`, `720p`, `1080p` | `720p` | Resolution selector |
| `mode` | `std`, `fast` | — | `fast` reduces generation time; `std` for full quality |
| `genre` | `auto`, `action`, `horror`, `comedy`, `noir`, `drama`, `epic` | `auto` | Tone control for the animation |
| `aspect_ratio` | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` | — | Wider ratio support than primary |
| `duration` | 4–15 s | — | Continuous range (any whole value 4–15 is valid) |
| Media roles | `image`, `start_image`, `end_image`, `video`, `audio` | — | Full role support; use `start_image` for the comic panel |

**Note on image role:** Unlike wan2_6, seedance_2_0 accepts the panel image as `start_image`
(or `image`) — either role works. The confirmed media ID from media_confirm must still be
obtained before generation.

---

## Routing rationale

| Condition | Route to |
|-----------|----------|
| Default (comic panel animation) | `wan2_6` (primary) |
| wan2_6 unavailable | `seedance_2_0` |
| User wants genre tone control | `seedance_2_0` (`genre` param) |
| User wants audio role | `seedance_2_0` |
| User wants duration not in [5,10,15] | `seedance_2_0` |

**Informed-consent rule:** If falling back to seedance_2_0, tell the user what changes:
different resolution options, continuous duration (4–15 s), and genre control become
available. Never switch models silently.

---

## Source of truth note

These specs are cached from a verified `higgsfield:models_explore` query on 2026-05-25.
Model APIs evolve. If any parameter is **rejected at generation time**:

1. Call `higgsfield:models_explore` with the target model name.
2. Read the returned schema for current valid values.
3. Substitute the corrected value before retrying.

Never infer or guess parameter values. The live catalog is the authoritative source.
