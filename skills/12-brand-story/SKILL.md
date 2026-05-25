---
name: higgsfield-brand-story
description: >-
  Crafts emotionally resonant brand storytelling video prompts for Higgsfield
  and routes to the best model (cinematic_studio_3_0 primary, veo3_1 fallback).
  Also routes brand location and establishing stills to soul_location via
  generate_image. Use when the user wants a brand story video, company origin
  story, mission video, about us video, brand film, corporate narrative, founder
  story, brand anthem, company culture video, or emotional brand content.
when_to_use: >-
  Use for brand story, brand video, company story, origin story, about us,
  mission video, brand film, brand anthem, corporate video, company culture,
  founder story, brand narrative, or any request for brand/company storytelling
  video. Use even for "tell our company story" or "make a video about our
  mission."
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

# Higgsfield Brand Story Skill

## What this skill does

Crafts production-ready brand story video prompts — origin stories, manifesto films,
customer transformations, and behind-the-scenes narratives — and routes them to the best
Higgsfield model for cinematic output. On request, it assembles the full parameter set,
surfaces the credit cost, and — after explicit user confirmation — generates the asset
via the opt-in generation flow. The skill also handles brand location and establishing
stills via the `soul_location` still-image path.

---

## Model routing

### Primary and fallback video models

| | cinematic_studio_3_0 (primary) | veo3_1 (fallback) |
|---|---|---|
| **Rationale** | Dedicated cinematic pipeline; default for all brand-story video | Photorealism + native audio when the studio model is unavailable or voiced output is needed |
| **Aspect ratios** | `16:9`, `9:16`, `1:1` | `16:9`, `9:16` only — **no `1:1`** |
| **Duration** | 4–15 s (continuous range) | `4`, `6`, `8` s (discrete set only) |
| **Tunable params** | **None** — pass only `aspect_ratio` and `duration` | `quality` {`basic`, `high`, `ultra`}; `model` {`veo-3-1-preview`, `veo-3-1-fast`} |
| **Media roles** | `image`, `start_image`, `end_image` (optional) | `start_image` only (max 1) |
| **Native audio** | No | Yes |

**Routing rule:** Use `cinematic_studio_3_0` by default. Only fall back to `veo3_1`
when (1) the primary model is unavailable, or (2) the user wants native audio or
explicitly photorealistic output **and**, after being informed of the trade-offs, accepts
them: no `1:1` aspect ratio, discrete durations only (`4`/`6`/`8` s instead of the
continuous 4–15 s range), and `start_image` only (no `end_image`). Never switch silently.

**MODEL-06 directive:** If a parameter is rejected at generation time, call
`higgsfield:models_explore` with the target model name to re-verify the live schema.
The live catalog is the authoritative source. Full parameter tables:
[references/model-specs.md](references/model-specs.md).

### Per-platform aspect ratio quick rule

Vertical `9:16` for TikTok / Reels / Shorts; `16:9` for YouTube, LinkedIn, and website
hero; `1:1` for Instagram feed square posts (`cinematic_studio_3_0` only — veo3_1 has
no `1:1`). Full per-platform recommendation table:
[references/model-specs.md](references/model-specs.md).

---

## Still-image path (soul_location)

For brand location or establishing stills — a venue, storefront, workspace, or
environmental brand moment — route to `soul_location` via `higgsfield:generate_image`.

- **No tunable parameters** — pass only `aspect_ratio`.
- **Aspect ratios supported:** `1:1`, `4:3`, `3:4`, `16:9`, `9:16`, `3:2`, `2:3`,
  `21:9`, `9:21`.
- **Workflow:** After generating the still, pass the output image as a `start_image`
  reference to `cinematic_studio_3_0` to carry the established location and atmosphere
  into video.

Full parameter table: [references/model-specs.md](references/model-specs.md).

---

## Prompt-building workflow

1. **Gather intent** — Confirm with the user: brand story type (origin, manifesto,
   customer transformation, behind-the-scenes, etc.), emotional register (inspirational,
   warm/nostalgic, bold, calm/trustworthy), target platform, aspect ratio, desired
   duration, and whether native audio or a location still is needed.

2. **Select model** — Apply the routing table above. Use `cinematic_studio_3_0` by
   default. Route location/establishing stills to `soul_location`. Select `veo3_1` only
   when a routing trigger applies and the user has accepted the trade-offs.

3. **Build the prompt** — Use the craft principles and templates from the references:
   - Opening hook (2-second attention-capture) from
     [references/hooks.md](references/hooks.md)
   - Narrative arc, emotional register, camera/lighting, voiceover from
     [references/narrative-craft.md](references/narrative-craft.md)
   - Worked example prompts by brand type from
     [references/examples.md](references/examples.md)

4. **Present for review** — Show the assembled prompt and all parameters to the user for
   review and refinement before any generation call. The user must approve the prompt
   text, model, aspect ratio, and duration.

---

## Opt-in generation

Generation costs Higgsfield credits and requires explicit user confirmation before any
generate call is made. This skill never auto-generates.

**Full step-by-step flow** (confirmation gate, balance/cost surface,
generate → poll → display):
[`../../shared/generation-flow.md`](../../shared/generation-flow.md)

**This skill's primary model:** `cinematic_studio_3_0`

**Media upload:** Conditional — only when the user supplies a `start_image` or
`end_image` reference for image-to-video. This skill is NOT a mandatory-I2V skill;
T2V is the default path. When the user provides a reference image, run the
`higgsfield:media_upload` → `higgsfield:media_confirm` atomic pair before generating.

**Tool signatures:** [`../../shared/mcp-tools.md`](../../shared/mcp-tools.md)

---

## Reference materials

| File | Contents |
|---|---|
| [references/model-specs.md](references/model-specs.md) | Verified parameter tables for cinematic_studio_3_0, veo3_1, and soul_location; per-platform aspect ratio and duration recommendations; routing rationale and re-verify directive |
| [references/narrative-craft.md](references/narrative-craft.md) | Brand storytelling philosophy, 10+ narrative arc structures, industry-specific approaches, emotional register guide, visual metaphor library, camera/lighting/color guidance, voiceover techniques, sound design, and effectiveness checklist |
| [references/hooks.md](references/hooks.md) | 12 essential brand story hooks, hook-stacking techniques, platform-specific hook guidance, and hook-to-narrative-arc matching table |
| [references/examples.md](references/examples.md) | Master template for brand story prompts, 5 production-ready worked example prompts by brand type (tech startup, artisan food, fashion manifesto, health/wellness, creative agency), brand story brief template, and platform deployment guide |
