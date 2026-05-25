<!-- verified: models_explore 2026-05-25 -->
<!-- If any parameter below is rejected at generation time, call higgsfield:models_explore
     with the target model name to refresh the live schema — the live catalog is the source
     of truth over these cached specs. -->

# Anime-Action Model Specifications

This reference documents the per-model parameters for the two anime-action models.
All values are sourced from verified `higgsfield:models_explore` data (2026-05-25).
Re-query on any parameter rejection.

**Both models require a confirmed image input before generation.**
See [SKILL.md](../SKILL.md) for the mandatory media_upload → media_confirm flow.

---

## Table of Contents

1. [wan2_7 — Primary (I2V, start_image)](#wan2_7--primary-i2v-start_image)
2. [wan2_6 — Fallback (I2V, image REQUIRED)](#wan2_6--fallback-i2v-image-required)
3. [Routing rationale](#routing-rationale)
4. [Source of truth note](#source-of-truth-note)

---

## wan2_7 — Primary (I2V, start_image)

**Routing rationale:** Default model for anime-action. Supports the `start_image` role
for image-to-video animation with flexible duration range and wide aspect ratio support.

### Parameters

| Parameter | Value | Notes |
|-----------|-------|-------|
| `resolution` | `720p`, `1080p` | Resolution selector |
| `aspect_ratio` | `16:9`, `9:16`, `1:1`, `4:3`, `3:4` | Five ratios supported — wider than fallback |
| `duration` | 2–15 s | Continuous range — any whole value between 2 and 15 is valid |
| Media roles | `start_image`, `end_image`, `audio` | Attach the anime frame as `start_image` |

**I2V attach point:** For this skill, attach the user-supplied anime frame as `start_image`.

```json
input_files: [{ "id": "<confirmed_id>", "role": "start_image" }]
```

**Max resolution:** 1080p. This model does not output 4K video.

### Per-platform aspect ratio and duration recommendations

| Platform | Aspect ratio | Recommended duration | Notes |
|----------|-------------|----------------------|-------|
| TikTok / Reels / Shorts | `9:16` | 5–8 s | Vertical full-screen; hook in first 2 s |
| YouTube (standard) | `16:9` | 8–15 s | Widescreen; full action arc |
| Instagram feed | `1:1` | 5–10 s | Square crop; center-weighted |
| Anime-style portrait | `3:4` | 4–10 s | Portrait manga/poster format |

---

## wan2_6 — Fallback (I2V, image REQUIRED)

**Routing rationale:** Use when wan2_7 is unavailable. The `image` role is REQUIRED for
wan2_6 — it cannot run without a confirmed image input. Duration is a discrete set.

### Parameters

| Parameter | Value | Notes |
|-----------|-------|-------|
| `quality` | `720p`, `1080p` | Resolution selector |
| `aspect_ratio` | `16:9`, `9:16`, `1:1` | Three ratios (no `4:3` or `3:4`) |
| `duration` | `5`, `10`, `15` | **Discrete set only** — not a continuous range. Only these exact values are valid. |
| Media roles | `image` x1 **REQUIRED** | Attach the anime frame as `image` (not `start_image`) |

**Critical constraint:** Duration is a **discrete set** `[5, 10, 15]` — do not pass 2, 3,
4, 6, 7, 8, 9, 11, 12, 13, or 14. wan2_6 does not accept a continuous duration range.

**I2V attach point for fallback:** When using wan2_6, attach the user's anime frame as
`image` (not `start_image`).

```json
input_files: [{ "id": "<confirmed_id>", "role": "image" }]
```

**Max resolution:** 1080p. This model does not output 4K video.

---

## Routing rationale

| Condition | Route to |
|-----------|----------|
| Default (anime frame animation) | `wan2_7` (primary) |
| wan2_7 unavailable | `wan2_6` |
| User needs duration not in [5,10,15] | `wan2_7` (supports full 2–15 s range) |
| User needs `4:3` or `3:4` aspect | `wan2_7` (only model with these ratios) |
| User needs `end_image` or `audio` role | `wan2_7` |

**Informed-consent rule for fallback:** If switching to wan2_6, tell the user what changes:
- Duration becomes discrete `[5, 10, 15]` only (no 2, 3, 4, 6, 7, 8, etc.)
- Aspect ratios limited to `16:9`, `9:16`, `1:1` (no `4:3` or `3:4`)
- Image role changes from `start_image` to `image`

Never switch models silently.

---

## Source of truth note

These specs are cached from a verified `higgsfield:models_explore` query on 2026-05-25.
Model APIs evolve. If any parameter is **rejected at generation time**:

1. Call `higgsfield:models_explore` with the target model name.
2. Read the returned schema for current valid values.
3. Substitute the corrected value before retrying.

Never infer or guess parameter values. The live catalog is the authoritative source.
