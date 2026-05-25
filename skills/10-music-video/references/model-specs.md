<!-- verified: models_explore 2026-05-25 -->
<!-- If any parameter below is rejected at generation time, call higgsfield:models_explore
     with the target model name to refresh the live schema — the live catalog is the source
     of truth over these cached specs. -->

# Music-Video Model Specifications

This reference documents per-model parameters, aspect ratios, durations, and routing
rationale for the music-video skill. All values are sourced from verified
`higgsfield:models_explore` data (2026-05-25). Re-query on any parameter rejection.

**GEN-04 note:** All video generation paths in this skill require a user-supplied audio
track uploaded via `higgsfield:media_upload` → `higgsfield:media_confirm` (role `audio`)
before calling `higgsfield:generate_video`. See `../../shared/generation-flow.md` Step 2b.

---

## Table of Contents

1. [veo3_1 — Primary (native audio video)](#veo3_1--primary-native-audio-video)
2. [veo3_1_lite — Fallback (video)](#veo3_1_lite--fallback-video)
3. [Per-platform recommendations](#per-platform-recommendations)
4. [Multi-segment assembly note](#multi-segment-assembly-note)
5. [Source of truth note](#source-of-truth-note)

---

## veo3_1 — Primary (native audio video)

**Full name:** Google Veo 3.1
**Routing rationale:** Primary model for music video. Supports **native audio generation**
(voiced narration, diegetic sound effects, ambient audio generated alongside the video).
Also accepts a user-supplied audio track attached with role `audio`.

### Parameters

| Parameter | Options | Default | Notes |
|-----------|---------|---------|-------|
| `quality` | `basic`, `high`, `ultra` | `basic` | Higher quality = slower and higher credit cost |
| `model` | `veo-3-1-preview`, `veo-3-1-fast` | `veo-3-1-fast` | Use `veo-3-1-preview` for maximum quality |
| `aspect_ratio` | `16:9`, `9:16` | — | **No `1:1`** — square aspect is NOT supported by this model |
| `duration` | `4`, `6`, `8` | — | **Discrete list, not a range.** Only these three exact values are valid. |
| `input_files` media roles | `start_image` (max 1) | — | One start_image allowed; `end_image` not supported |
| Native audio | Yes | — | Can generate synchronized audio natively — a primary routing reason |

**Critical constraints:**
- Aspect ratio is `16:9` or `9:16` ONLY — no `1:1`.
- Duration is a **discrete set** `[4, 6, 8]` — do not pass 5, 7, 10, or any other value.
- Only one `start_image` reference is supported.

**User audio track:** veo3_1 has native audio capability. When the user supplies an audio
track, it is uploaded via the media branch and attached with role `audio` in `input_files`:
```json
[{ "id": "<confirmed_id>", "role": "audio" }]
```
This is separate from the `start_image` role. Both can be passed simultaneously if a
reference image is also provided:
```json
[
  { "id": "<audio_confirmed_id>",  "role": "audio" },
  { "id": "<image_confirmed_id>",  "role": "start_image" }
]
```

---

## veo3_1_lite — Fallback (video)

**Routing rationale:** Use when `veo3_1` is unavailable. Lower credit cost. Supports
`generate_audio` parameter for basic audio generation.

### Parameters

| Parameter | Options | Default | Notes |
|-----------|---------|---------|-------|
| `resolution` | `720p`, `1080p` | — | Select based on target platform |
| `generate_audio` | `true`, `false` | `false` | Enable for basic audio generation |
| `aspect_ratio` | `16:9`, `9:16`, `auto` | — | `auto` allows model to choose; no `1:1` |
| `duration` | `4`, `6`, `8` | — | Same discrete set as veo3_1 |
| `input_files` media roles | `start_image`, `end_image` | — | Both start and end images supported |

**Informed-consent note:** When falling back to `veo3_1_lite`, inform the user that they
give up native audio quality and the `veo-3-1-preview` quality tier. The user must accept
this trade-off before switching — never switch silently.

---

## Per-platform recommendations

| Platform | Aspect ratio | Model | Recommended duration | Notes |
|----------|-------------|-------|----------------------|-------|
| TikTok / Reels | `9:16` | `veo3_1` | 4 or 6 s | Vertical; hook in first 2 s; multi-segment for full song |
| YouTube Shorts | `9:16` | `veo3_1` | 6 or 8 s | Slightly more patient audience |
| YouTube (standard) | `16:9` | `veo3_1` | 8 s | Widescreen; multi-segment for full MV |
| Instagram feed | — | — | — | Note: `1:1` not supported by either model |

---

## Multi-segment assembly note

veo3_1 durations are short discrete clips (4, 6, or 8 s). A typical music video is 2–4
minutes. To cover a full song, the user will need to generate and assemble multiple
segments. When planning a music video:

1. Identify the song's key structural moments (intro, verse, chorus, bridge, outro).
2. Map each moment to one or more clip segments (e.g., chorus = 2 × 8 s clips).
3. Generate each segment separately and assemble in a video editor.
4. Note that each segment costs credits independently.

---

## Source of truth note

These specs are cached from a verified `higgsfield:models_explore` query on 2026-05-25.
Model APIs evolve. If any parameter is rejected at generation time:

1. Call `higgsfield:models_explore` with the target model name.
2. Read the returned schema for current valid values.
3. Substitute the corrected value before retrying.

Never infer or guess parameter values. The live catalog is the authoritative source.
