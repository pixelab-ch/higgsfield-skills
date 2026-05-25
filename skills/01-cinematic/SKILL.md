---
name: higgsfield-cinematic
description: >-
  Crafts film-grade cinematic video prompts for Higgsfield and routes to the
  best model (cinematic_studio_3_0 primary, veo3_1 fallback). Use when the
  user wants cinematic, film look, movie scene, dramatic lighting, depth of
  field, lens flare, anamorphic, letterbox, noir, epic, Steadicam, dolly,
  crane shot, or any Hollywood-style or film-quality AI video. Handles both
  text-to-video and optional image-to-video requests with full prompt
  assembly, model selection, and parameter validation. Also routes
  production-still and mood-board requests to cinematic_studio_2_5.
when_to_use: >-
  Use for feature-film look, golden-hour cinematography, rack focus, dolly
  shots, crane shots, anamorphic lens style, handheld documentary, chiaroscuro
  noir, teal-and-orange grading, or any request mentioning cinematic, film
  look, movie scene, dramatic, epic, or professional film-quality output.
  Also use when the user wants a production still or mood-board frame before
  committing to video.
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

# Higgsfield Cinematic Skill

## What this skill does

Crafts production-ready cinematic video prompts and routes them to the best
Higgsfield model for film-grade output. On request, it assembles the full
parameter set, surfaces the credit cost, and — after explicit user
confirmation — generates the asset via the opt-in generation flow. The skill
also handles mood-board stills via the `cinematic_studio_2_5` image path.

---

## Model routing

### Primary and fallback video models

| | cinematic_studio_3_0 (primary) | veo3_1 (fallback) |
|---|---|---|
| **Rationale** | Dedicated cinematic pipeline; default for all film-grade video | Photorealism + native audio when the studio model is unavailable or voiced output is needed |
| **Aspect ratios** | `16:9`, `9:16`, `1:1` | `16:9`, `9:16` only — **no `1:1`** |
| **Duration** | 4–15 s (continuous range) | `4`, `6`, `8` s (discrete set only) |
| **Tunable params** | **None** — pass only `aspect_ratio` and `duration` | `quality` {`basic`, `high`, `ultra`}; `model` {`veo-3-1-preview`, `veo-3-1-fast`} |
| **Media roles** | `image`, `start_image`, `end_image` (optional) | `start_image` only (max 1) |
| **Native audio** | No | Yes |

**Routing rule:** Use `cinematic_studio_3_0` by default. Only fall back to
`veo3_1` when (1) the primary model is unavailable, or (2) the user wants
native audio or explicitly photorealistic output **and**, after being told
what they give up, accepts veo3_1's constraints: no `1:1` aspect ratio,
discrete durations only (`4`/`6`/`8` s instead of the continuous 4–15 s
range), and `start_image` only (no `end_image`). If the user has not been
informed of these trade-offs, stay on `cinematic_studio_3_0` and let them
decide — never switch silently.

**MODEL-06 directive:** If a parameter is rejected at generation time, call
`higgsfield:models_explore` with the target model name to re-verify the live
schema. The live catalog is the authoritative source — never guess parameter
values. Full parameter tables: [references/model-specs.md](references/model-specs.md).

### Per-platform aspect ratio and duration

Quick rule: vertical `9:16` for TikTok / Reels / Shorts, `16:9` for standard
YouTube and LinkedIn, `1:1` only on `cinematic_studio_3_0` (veo3_1 has none).
Full per-platform recommendation table:
[references/model-specs.md](references/model-specs.md).

---

## Still-image path (MODEL-05)

For a production still or mood-board frame before committing to video, route
to `cinematic_studio_2_5` via `higgsfield:generate_image`. This image model
supports `resolution` values `1k`, `2k`, and `4k` (the `4k` enum is a
legitimate option for this image model only — it does not apply to any video
model). Aspect ratios: `1:1`, `4:3`, `3:4`, `16:9`, `9:16`. After generating
the still, the output image can be passed as a `start_image` reference to
`cinematic_studio_3_0` to carry the established composition into video. Full
parameter table: [references/model-specs.md](references/model-specs.md).

---

## Prompt-building workflow

1. **Gather intent** — Confirm with the user: creative style (noir, epic,
   intimate, etc.), subject, mood, target platform, aspect ratio, and
   desired duration.

2. **Select model** — Apply the routing table above. Choose
   `cinematic_studio_3_0` by default; select `veo3_1` only when a routing
   trigger applies; route still requests to `cinematic_studio_2_5`.

3. **Build the prompt** — Use the craft principles in the references below to
   construct the prompt:
   - Opening hook (2-second attention-capture technique) from
     [references/hooks.md](references/hooks.md)
   - Camera movement, lighting setup, color grade, composition from
     [references/camera.md](references/camera.md)
   - Worked example prompts by genre/platform from
     [references/examples.md](references/examples.md)

4. **Present for review** — Show the assembled prompt and all parameters to
   the user for review and refinement **before** any generation call. The user
   must approve the prompt text, model, aspect ratio, and duration.

---

## Opt-in generation

Generation costs Higgsfield credits and requires explicit user confirmation
before any generate call is made. This skill never auto-generates.

**Full step-by-step flow** (confirmation gate, balance/cost surface,
generate → poll → display):
[`../../shared/generation-flow.md`](../../shared/generation-flow.md)

**This skill's primary model:** `cinematic_studio_3_0`

**Media upload:** Conditional — only when the user supplies a `start_image`
or `end_image` reference for image-to-video. This skill is NOT a mandatory-I2V
skill; T2V is the default path. When the user provides a reference image, run
the `higgsfield:media_upload` → `higgsfield:media_confirm` atomic pair before
generating.

**Tool signatures:** [`../../shared/mcp-tools.md`](../../shared/mcp-tools.md)

---

## Reference materials

| File | Contents |
|---|---|
| [references/model-specs.md](references/model-specs.md) | Per-model parameter tables, aspect ratios, durations, routing rationale, and re-verify directive for cinematic_studio_3_0, veo3_1, and cinematic_studio_2_5 |
| [references/camera.md](references/camera.md) | Camera movement encyclopedia (20+ moves), lighting library (15+ setups), composition rules, color-grading approaches, pacing and atmosphere guidance |
| [references/hooks.md](references/hooks.md) | 2-second hook framework, 12 hook techniques with prompt phrasing templates, advanced hook-stacking guidance |
| [references/examples.md](references/examples.md) | Full production-quality example prompts by genre (noir, epic landscape, dramatic dialogue, action, abstract) with timeline segmentation guides |
