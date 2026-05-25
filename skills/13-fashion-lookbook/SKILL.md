---
name: higgsfield-fashion-lookbook
description: >-
  Crafts fashion lookbook and model showcase video prompts for Higgsfield and routes to the
  best model (cinematic_studio_video_v2 primary, seedance_2_0 fallback). Also routes lookbook
  stills to soul_cinematic. Use when the user wants fashion video content, lookbook videos,
  model walks, outfit showcases, style guides, fashion campaigns, runway clips, streetwear
  content, or any fashion or clothing video.
when_to_use: >-
  Use for: fashion video, lookbook, model showcase, outfit, style guide, fashion campaign,
  runway, streetwear, collection launch, fashion ad, clothing video, OOTD, fashion film,
  editorial fashion, fabric close-up, or any fashion or model video request. Also use when
  the user wants a lookbook still or mood-board frame before committing to video.
allowed-tools: >-
  mcp__higgsfield__generate_video
  mcp__higgsfield__generate_image
  mcp__higgsfield__models_explore
  mcp__higgsfield__job_status
  mcp__higgsfield__job_display
  mcp__higgsfield__media_upload
  mcp__higgsfield__media_confirm
  mcp__higgsfield__balance
  mcp__higgsfield__show_plans_and_credits
---

# Higgsfield Fashion Lookbook Skill

## What this skill does

Crafts production-ready fashion lookbook and model showcase video prompts and routes them
to the best Higgsfield model for fashion-grade output. On request, it assembles the full
parameter set, surfaces the credit cost, and — after explicit user confirmation — generates
the asset via the opt-in generation flow. The skill also handles lookbook stills and
mood-board frames via the `soul_cinematic` still-image path.

---

## Model routing

### Primary and fallback video models

| | cinematic_studio_video_v2 (primary) | seedance_2_0 (fallback) |
|---|---|---|
| **Rationale** | Dedicated cinematic pipeline with genre and mode controls; default for all fashion video | Use when primary is unavailable, duration >12 s needed, or noir/drama/epic genre required |
| **Genre params** | `auto`, `action`, `horror`, `comedy`, `western`, `suspense`, `intimate`, `spectacle` | `auto`, `action`, `horror`, `comedy`, `noir`, `drama`, `epic` |
| **Mode** | `pro`, `std` | `std`, `fast` |
| **Aspect ratios** | `1:1`, `4:3`, `3:4`, `16:9`, `9:16` | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` |
| **Duration** | `3`–`12` s (continuous) — **max 12 s** | `4`–`15` s (continuous) |
| **Media roles** | `image`, `start_image`, `end_image` | `image`, `start_image`, `end_image`, `video`, `audio` |

**Routing rule:** Use `cinematic_studio_video_v2` by default. Only fall back to `seedance_2_0`
when (1) the primary model is unavailable, (2) the user needs a duration **longer than 12 seconds**,
(3) the user needs the `noir`, `drama`, or `epic` genre tags, or (4) the user needs `audio` or
`video` media roles. If switching, inform the user of what they trade off. Never switch silently.

**MODEL-06 directive:** If a parameter is rejected at generation time, call
`higgsfield:models_explore` with the target model name to re-verify the live schema. The live
catalog is the authoritative source — never guess parameter values. Full parameter tables:
[references/model-specs.md](references/model-specs.md).

### Per-platform aspect ratio quick rule

Vertical `9:16` for TikTok / Reels / Shorts, `16:9` for YouTube and widescreen, `1:1` for
Instagram feed, `3:4` for portrait/magazine editorial. Note: `cinematic_studio_video_v2` caps
at 12 s — not 15 s. Full per-platform recommendation table:
[references/model-specs.md](references/model-specs.md).

---

## Still-image path (MODEL-05)

For a lookbook still or mood-board frame before committing to video, route to `soul_cinematic`
via `higgsfield:generate_image`. This still-image model supports quality values `1.5k` and `2k`
(maximum quality is `2k` — there is no `4k` for this model). Aspect ratios: `1:1`, `4:3`, `3:4`,
`16:9`, `9:16`, `3:2`, `2:3`, `21:9`. Optionally attach a `soul_id` to maintain character
identity across stills. After generating the still, pass it as a `start_image` reference to
`cinematic_studio_video_v2` to carry the established composition into video. Full parameter
table: [references/model-specs.md](references/model-specs.md).

---

## Prompt-building workflow

1. **Gather intent** — Confirm with the user: fashion category (luxury, streetwear, editorial,
   etc.), garment description (color, fabric, silhouette), model direction (walk type, attitude,
   expression), environment, lighting, target platform, aspect ratio, and desired duration.

2. **Select model** — Apply the routing table above. Choose `cinematic_studio_video_v2` by
   default with `genre: intimate` for editorial/luxury or `genre: spectacle` for campaign
   launches; select `seedance_2_0` only when a routing trigger applies; route still requests
   to `soul_cinematic`.

3. **Build the prompt** — Use the craft principles in the references below:
   - Opening hook (2-second attention-capture technique) from
     [references/hooks.md](references/hooks.md)
   - Fashion styling, wardrobe direction, model direction, lighting, movement language from
     [references/styling.md](references/styling.md)
   - Worked example prompts by category and platform from
     [references/examples.md](references/examples.md)

4. **Present for review** — Show the assembled prompt and all parameters to the user for
   review and refinement **before** any generation call. The user must approve the prompt
   text, model, genre, aspect ratio, and duration.

---

## Opt-in generation

Generation costs Higgsfield credits and requires explicit user confirmation before any
generate call is made. This skill never auto-generates.

**Full step-by-step flow** (confirmation gate, balance/cost surface,
generate → poll → display):
[`../../shared/generation-flow.md`](../../shared/generation-flow.md)

**This skill's primary model:** `cinematic_studio_video_v2`

**Media upload:** Conditional — only when the user supplies a `start_image` or `end_image`
reference for image-to-video. This skill is NOT a mandatory-I2V skill; T2V is the default
path. When the user provides a reference image, run the `higgsfield:media_upload` →
`higgsfield:media_confirm` atomic pair before generating.

**Tool signatures:** [`../../shared/mcp-tools.md`](../../shared/mcp-tools.md)

---

## Reference materials

| File | Contents |
|---|---|
| [references/model-specs.md](references/model-specs.md) | Per-model parameter tables, aspect ratios, durations, routing rationale, and re-verify directive for cinematic_studio_video_v2 (3–12 s max), seedance_2_0, and soul_cinematic |
| [references/styling.md](references/styling.md) | Fashion styling philosophy, model direction keywords, fabric showcase techniques, lighting library, location settings, outfit change transitions, and category guide |
| [references/hooks.md](references/hooks.md) | 2-second hook framework, 12 hook techniques with prompt phrasing templates, and hook stacking guidance |
| [references/examples.md](references/examples.md) | Master template, 5 worked example prompts by fashion category and platform, and a soul_cinematic still-image workflow example |
