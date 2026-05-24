<!-- verified: models_explore 2026-05-24 -->
_Last verified: 2026-05-24 via models_explore. If a parameter is rejected at generation time, call `higgsfield:models_explore` to refresh this model's schema._

# Higgsfield Model Catalog

This file is the **single source of truth** for all Higgsfield image and video model IDs,
their constraint fields (parameters, aspect ratios, durations, media roles), and purpose
descriptions. Skills reference this catalog to build their per-skill routing tables in
`references/model-specs.md` (Phases 2-3). Do not duplicate this catalog inline in any
`SKILL.md`.

**How skills use this catalog:** Each skill filters this list to the 2-4 models most
relevant to its creative style, documents those in its own `references/model-specs.md`,
and calls `higgsfield:models_explore` at generation time to get live parameter constraints.
This file tracks what exists; live `models_explore` calls are the authoritative source for
exact parameter schemas at generation time.

---

## Table of Contents

1. [Video Models](#video-models)
   - [Seedance Family](#seedance-family)
   - [Wan Family](#wan-family)
   - [Kling Family](#kling-family)
   - [Google Veo Family](#google-veo-family)
   - [Other Video Models](#other-video-models)
   - [Cinematic & Marketing Studio (Video)](#cinematic--marketing-studio-video)
2. [Image Models](#image-models)
   - [Nano Banana Family](#nano-banana-family)
   - [Soul Family](#soul-family)
   - [Seedream Family](#seedream-family)
   - [Flux Family](#flux-family)
   - [GPT Image Family](#gpt-image-family)
   - [Other Image Models](#other-image-models)
   - [Studio Image Models](#studio-image-models)

---

## Video Models

> ~18 models. Always call `higgsfield:models_explore` before generating to get the live
> parameter schema for the specific model you are using.

### Seedance Family

#### `seedance_2_0`

<!-- verified: models_explore 2026-05-24 -->

**Purpose:** Higgsfield's flagship video model. Produces cinematic-quality video with
synchronized sound. Best for high-quality clips requiring audio, precise control over
motion, or image/video/audio reference inputs.

| Field | Value |
|-------|-------|
| **Output duration** | 4–15 seconds |
| **Output quality** | 720p |
| **Audio output** | Yes (with sound) |
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] (resolution, quality, mode, genre as reported) |
| **Media roles — input limits** | Image: up to 9 files (<30 MB each); Video: up to 3 files (<50 MB each, total 2–15 s); Audio: up to 3 files (<15 MB each, total ≤15 s); Combined: ≤12 files total |
| **Input roles** | `image`, `start_image`, `end_image`, `video`, `audio` |

_Source for concrete numbers: existing repo README, verified 2026-05-24. All other
per-model numbers below that are not from this verified source are marked [from models_explore — re-verify]._

---

#### `seedance_1_5`

**Purpose:** Previous-generation Seedance video model. Useful for workflows where the
newer model produces unwanted characteristics, or for cost/speed trade-offs.

| Field | Value |
|-------|-------|
| **Output duration** | [from models_explore — re-verify] |
| **Output quality** | [from models_explore — re-verify] |
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

### Wan Family

#### `wan2_6`

**Purpose:** Wan 2.6 video generation model. Part of the Wan open-weight video model
family integrated into the Higgsfield platform.

| Field | Value |
|-------|-------|
| **Output duration** | [from models_explore — re-verify] |
| **Output quality** | [from models_explore — re-verify] |
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `wan2_7`

**Purpose:** Wan 2.7 video generation model. Updated version of the Wan family with
potentially different capabilities and parameters than wan2_6.

| Field | Value |
|-------|-------|
| **Output duration** | [from models_explore — re-verify] |
| **Output quality** | [from models_explore — re-verify] |
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

### Kling Family

#### `kling2_6`

**Purpose:** Kling 2.6 video model from Kuaishou. Integrated via Higgsfield. Suited for
high-motion video with strong temporal consistency.

| Field | Value |
|-------|-------|
| **Output duration** | [from models_explore — re-verify] |
| **Output quality** | [from models_explore — re-verify] |
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `kling3_0`

**Purpose:** Kling 3.0 video model from Kuaishou. More recent than kling2_6 with
updated capabilities.

| Field | Value |
|-------|-------|
| **Output duration** | [from models_explore — re-verify] |
| **Output quality** | [from models_explore — re-verify] |
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

### Google Veo Family

#### `veo3`

**Purpose:** Google Veo 3 video generation model. High-quality video generation with
strong prompt adherence.

| Field | Value |
|-------|-------|
| **Output duration** | [from models_explore — re-verify] |
| **Output quality** | [from models_explore — re-verify] |
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `veo3_1`

**Purpose:** Google Veo 3.1 video generation model. Updated variant of veo3.

| Field | Value |
|-------|-------|
| **Output duration** | [from models_explore — re-verify] |
| **Output quality** | [from models_explore — re-verify] |
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `veo3_1_lite`

**Purpose:** Google Veo 3.1 Lite — a lighter/faster variant of veo3_1, potentially
lower cost or faster generation.

| Field | Value |
|-------|-------|
| **Output duration** | [from models_explore — re-verify] |
| **Output quality** | [from models_explore — re-verify] |
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

### Other Video Models

#### `minimax_hailuo`

**Purpose:** MiniMax Hailuo video model. Integrated via Higgsfield for additional video
generation style options.

| Field | Value |
|-------|-------|
| **Output duration** | [from models_explore — re-verify] |
| **Output quality** | [from models_explore — re-verify] |
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `grok_video`

**Purpose:** xAI Grok video generation model, integrated via Higgsfield.

| Field | Value |
|-------|-------|
| **Output duration** | [from models_explore — re-verify] |
| **Output quality** | [from models_explore — re-verify] |
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `higgsfield_preset`

**Purpose:** Preset-based video generation using Higgsfield's curated motion presets.
Use `higgsfield:presets_show` to browse available presets before selecting this model.

| Field | Value |
|-------|-------|
| **Output duration** | [from models_explore — re-verify] |
| **Output quality** | [from models_explore — re-verify] |
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | Requires a preset selection — call `higgsfield:presets_show` first |
| **Media roles** | [from models_explore — re-verify] |

---

### Cinematic & Marketing Studio (Video)

#### `cinematic_studio_3_0`

**Purpose:** Higgsfield Cinematic Studio 3.0 — specialized for cinematic, film-grade
video generation. Supports `genre` parameter for cinematic style control.

| Field | Value |
|-------|-------|
| **Output duration** | [from models_explore — re-verify] |
| **Output quality** | [from models_explore — re-verify] |
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | Includes `genre` parameter — [from models_explore — re-verify for full list] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `cinematic_studio_video` (v1 and v2)

**Purpose:** Higgsfield Cinematic Studio Video — earlier versions (v1/v2) of the
cinematic studio video model. May have different parameter sets than cinematic_studio_3_0.

| Field | Value |
|-------|-------|
| **Output duration** | [from models_explore — re-verify] |
| **Output quality** | [from models_explore — re-verify] |
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

_Note: v1 and v2 may expose different model IDs; confirm exact ID strings via `higgsfield:models_explore`._

---

#### `marketing_studio_video`

**Purpose:** Higgsfield Marketing Studio Video — optimized for commercial and marketing
video content (ads, brand videos, product showcases).

| Field | Value |
|-------|-------|
| **Output duration** | [from models_explore — re-verify] |
| **Output quality** | [from models_explore — re-verify] |
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

## Image Models

> ~20 models. Always call `higgsfield:models_explore` before generating to get the live
> parameter schema for the specific model you are using.

### Nano Banana Family

#### `nano_banana`

**Purpose:** Higgsfield Nano Banana image model — base variant. Fast, lightweight image
generation.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `nano_banana_2`

**Purpose:** Nano Banana 2 — updated second version with potentially improved quality
or capabilities.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `nano_banana_pro`

**Purpose:** Nano Banana Pro — higher-quality or professional-tier variant.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

### Soul Family

#### `soul_2`

**Purpose:** Soul 2 image model — part of Higgsfield's Soul model family.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `soul_cinematic`

**Purpose:** Soul Cinematic — variant of the Soul model optimized for cinematic-style
still image output.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `soul_cast`

**Purpose:** Soul Cast — variant of the Soul model, potentially optimized for
character or portrait generation.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `soul_location`

**Purpose:** Soul Location — variant of the Soul model, potentially specialized for
environment or location imagery.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

### Seedream Family

#### `seedream_v4_5`

**Purpose:** Seedream v4.5 image generation model.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `seedream_v5_lite`

**Purpose:** Seedream v5 Lite — lighter/faster variant of the Seedream image model
family.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

### Flux Family

#### `flux_2`

**Purpose:** Black Forest Labs Flux 2 image generation model, integrated via Higgsfield.
High-quality general-purpose image generation.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `flux_kontext`

**Purpose:** Flux Kontext — a context-aware or reference-image variant of the Flux
model family.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | `image` (reference image input) — [from models_explore — re-verify] |

---

### GPT Image Family

#### `gpt_image`

**Purpose:** GPT Image model (OpenAI-sourced) integrated via Higgsfield. Strong
instruction-following for complex compositional prompts.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `gpt_image_2`

**Purpose:** GPT Image 2 — updated version of the GPT Image model with potentially
improved capabilities.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

### Other Image Models

#### `z_image`

**Purpose:** Z Image model — additional image generation option in the Higgsfield
ecosystem.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `kling_omni_image`

**Purpose:** Kling Omni Image model from Kuaishou, integrated via Higgsfield. Suited
for versatile image generation tasks.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `grok_image`

**Purpose:** xAI Grok image generation model, integrated via Higgsfield.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `image_auto`

**Purpose:** Automatic model selection — Higgsfield selects the best image model for
the given prompt and parameters. Use when no specific model routing is required.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

### Studio Image Models

#### `cinematic_studio_2_5`

**Purpose:** Higgsfield Cinematic Studio 2.5 image model — for cinematic-quality still
frame generation.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `marketing_studio_image`

**Purpose:** Higgsfield Marketing Studio Image model — optimized for commercial and
marketing still image output (ads, product shots, brand imagery).

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

#### `ms_image`

**Purpose:** MS Image / DTC Ads — specialized image model for direct-to-consumer
advertising creatives.

| Field | Value |
|-------|-------|
| **Aspect ratios** | [from models_explore — re-verify] |
| **Parameters** | [from models_explore — re-verify] |
| **Media roles** | [from models_explore — re-verify] |

---

## Catalog Counts (as of 2026-05-24)

| Category | Count |
|----------|-------|
| Video models | ~18 |
| Image models | ~20 |
| **Total** | **~38** |

_Exact count may shift as Higgsfield adds or deprecates models. Call `higgsfield:models_explore`
to get the current live list._
