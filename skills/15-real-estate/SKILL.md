---
name: higgsfield-real-estate
description: >-
  Crafts real estate, architecture, and interior design showcase video prompts for Higgsfield
  and routes to the best model (cinematic_studio_3_0 primary, veo3_1 fallback). Use when the
  user wants property tours, real estate listings, architecture showcases, interior design
  videos, home staging content, property marketing, virtual tours, construction reveals, or
  any real estate or architecture video.
when_to_use: >-
  Use for: real estate, property, house, apartment, architecture, interior design, home tour,
  listing video, property marketing, virtual tour, building, construction, renovation, home
  staging, walkthrough, open house, luxury property, commercial space, office showcase,
  vacation rental, or any real estate or architecture video request.
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

# Higgsfield Real Estate Skill

## What this skill does

Crafts production-ready real estate and architecture showcase video prompts and routes them
to the best Higgsfield model for property-grade cinematic output. On request, it assembles
the full parameter set, surfaces the credit cost, and — after explicit user confirmation —
generates the asset via the opt-in generation flow. Handles both text-to-video (default) and
optional image-to-video for properties with reference photography.

---

## Model routing

### Primary and fallback video models

| | cinematic_studio_3_0 (primary) | veo3_1 (fallback) |
|---|---|---|
| **Rationale** | Dedicated cinematic pipeline; default for all property showcase video | Photorealism + native audio when primary is unavailable or voiced narration is needed |
| **Tunable params** | **None** — pass only `aspect_ratio` and `duration` | `quality` {`basic`, `high`, `ultra`}; `model` {`veo-3-1-preview`, `veo-3-1-fast`} |
| **Aspect ratios** | `16:9`, `9:16`, `1:1` | `16:9`, `9:16` only — **no `1:1`** |
| **Duration** | `4`–`15` s (continuous range) | `4`, `6`, `8` s (discrete set only — no other values) |
| **Media roles** | `image`, `start_image`, `end_image` | `start_image` only (max 1) |
| **Native audio** | No | Yes |

**Routing rule:** Use `cinematic_studio_3_0` by default. Only fall back to `veo3_1` when
(1) the primary model is unavailable, or (2) the user wants native audio narration or
explicitly photorealistic output **and**, after being told what they give up, accepts
veo3_1's constraints: no `1:1` aspect ratio, discrete durations only (`4`/`6`/`8` s instead
of the continuous 4–15 s range), and `start_image` only (no `end_image`). If the user has
not been informed of these trade-offs, stay on `cinematic_studio_3_0` and let them decide —
never switch silently.

**MODEL-06 directive:** If a parameter is rejected at generation time, call
`higgsfield:models_explore` with the target model name to re-verify the live schema. The live
catalog is the authoritative source — never guess parameter values. Full parameter tables:
[references/model-specs.md](references/model-specs.md).

### Per-platform aspect ratio quick rule

Vertical `9:16` for TikTok / Reels / Shorts, `16:9` for YouTube and standard listings,
`1:1` only on `cinematic_studio_3_0` (veo3_1 has none). Full per-platform recommendation
table: [references/model-specs.md](references/model-specs.md).

---

## Prompt-building workflow

1. **Gather intent** — Confirm with the user: property type (luxury waterfront, urban apartment,
   commercial, vacation rental, etc.), key selling features (views, materials, architecture),
   target platform, aspect ratio, and desired duration.

2. **Select model** — Apply the routing table above. Choose `cinematic_studio_3_0` by default.
   Select `veo3_1` only when a routing trigger applies and the user accepts the trade-offs.

3. **Build the prompt** — Use the craft principles in the references below to construct the prompt:
   - Opening hook (2-second attention-capture technique) from
     [references/hooks.md](references/hooks.md)
   - Camera movement, room sequencing, lighting, and staging from
     [references/walkthrough-craft.md](references/walkthrough-craft.md)
   - Worked example prompts by property type from
     [references/examples.md](references/examples.md)

4. **Present for review** — Show the assembled prompt and all parameters to the user for
   review and refinement **before** any generation call. The user must approve the prompt
   text, model, aspect ratio, and duration.

---

## Opt-in generation

Generation costs Higgsfield credits and requires explicit user confirmation before any
generate call is made. This skill never auto-generates.

**Full step-by-step flow** (confirmation gate, balance/cost surface,
generate → poll → display):
[`../../shared/generation-flow.md`](../../shared/generation-flow.md)

**This skill's primary model:** `cinematic_studio_3_0`

**Media upload:** Conditional — only when the user supplies a `start_image` or `end_image`
reference for image-to-video. This skill is NOT a mandatory-I2V skill; T2V is the default
path. When the user provides a reference image, run the `higgsfield:media_upload` →
`higgsfield:media_confirm` atomic pair before generating.

**Tool signatures:** [`../../shared/mcp-tools.md`](../../shared/mcp-tools.md)

---

## Reference materials

| File | Contents |
|---|---|
| [references/model-specs.md](references/model-specs.md) | Per-model parameter tables, aspect ratios, durations, routing rationale, and informed-consent veo3_1 disclosure for cinematic_studio_3_0 and veo3_1 |
| [references/walkthrough-craft.md](references/walkthrough-craft.md) | Space-as-character philosophy, room sequencing strategy, camera movement library (12 techniques), lighting and time-of-day guide, architectural detail shots, property type visual approaches, and sound design principles |
| [references/hooks.md](references/hooks.md) | 2-second hook framework, 12 hook techniques with prompt phrasing templates, hook selection guide by property type, and hook stacking guidance |
| [references/examples.md](references/examples.md) | Master template, 5 worked example prompts by property type, and virtual tour vs. marketing video guide |
