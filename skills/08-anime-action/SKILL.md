---
name: higgsfield-anime-action
description: >-
  Generates anime-style video from a user-supplied reference frame using Higgsfield.
  Routes to wan2_7 (primary, I2V via start_image) or wan2_6 (fallback, I2V via image role).
  Use whenever the user wants anime, Japanese animation style, shonen action, seinen drama,
  magical girl, mecha, isekai, slice-of-life anime, or any Japanese animation aesthetic.
  Triggers on: anime, Japanese animation, shonen, seinen, manga style video, anime fight,
  anime opening, anime ending, sakura, chibi, kawaii, mecha, isekai, or any anime-style
  request. Use even for "make it look like anime" or "Japanese cartoon style."
when_to_use: >-
  Use for any request to generate anime-style video from a reference image or to bring an
  anime-aesthetic idea to life. A source anime frame is always required — this skill
  animates from a user-supplied image and cannot generate without one.
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

# Higgsfield Anime-Action Skill

## What this skill does

Generates anime-style video from a user-supplied anime frame or illustration using Higgsfield.
The skill applies the anime visual language — cel shading, limited animation, impact frames,
speed lines, color psychology — to bring the source image into motion.

**A source anime frame is always required.** This skill is a mandatory image-to-video (I2V)
skill — it animates a user-supplied image and cannot run without one. Before any generation
call can happen, the user must provide the anime frame and the
`higgsfield:media_upload` → `higgsfield:media_confirm` flow must complete successfully.

---

## Model routing

### Primary and fallback video models

| | wan2_7 (primary) | wan2_6 (fallback) |
|---|---|---|
| **Rationale** | Flexible I2V; start_image attach point; wide aspect ratio support | When wan2_7 unavailable; discrete durations only |
| **Resolution** | `720p`, `1080p` | `720p`, `1080p` |
| **Aspect ratios** | `16:9`, `9:16`, `1:1`, `4:3`, `3:4` | `16:9`, `9:16`, `1:1` only — **no `4:3` or `3:4`** |
| **Duration** | 2–15 s (continuous range) | `5`, `10`, `15` s — **discrete set only** |
| **Image role** | `start_image` | `image` x1 **REQUIRED** |

**Routing rule:** Use `wan2_7` by default. Fall back to `wan2_6` when wan2_7 is unavailable.
If falling back, inform the user that: (1) duration becomes discrete `[5, 10, 15]` only —
no 2, 3, 4, 6, 7, 8, 9 etc., (2) `4:3` and `3:4` aspect ratios are not available, and
(3) the image role changes from `start_image` to `image`. Never switch models silently.

**MODEL-06 directive:** If a parameter is rejected at generation time, call
`higgsfield:models_explore` with the target model name. Full parameter tables:
[references/model-specs.md](references/model-specs.md).

### Per-platform aspect ratio and duration

Quick rule: `9:16` for TikTok / Reels / Shorts, `16:9` for YouTube, `1:1` for Instagram
feed, `3:4` for portrait/manga format (wan2_7 only). Full per-platform table:
[references/model-specs.md](references/model-specs.md).

---

## Prompt-building workflow

1. **Gather intent** — Confirm with the user: anime genre (shonen, seinen, magical girl,
   mecha, slice-of-life, etc.), target platform, aspect ratio, duration, and any specific
   visual effects or effects style.

2. **Select model** — Apply the routing table above. `wan2_7` by default.

3. **Build the prompt** — Use the craft principles in the references below:
   - 2-second hook technique from [references/hooks.md](references/hooks.md)
   - Anime visual language, action choreography, style transfer, camera techniques from
     [references/anime-craft.md](references/anime-craft.md)
   - Worked example prompts by anime genre from [references/examples.md](references/examples.md)

4. **Present for review** — Show the assembled prompt and all parameters to the user
   for review and refinement before any upload or generation call.

---

## Opt-in generation

Generation costs Higgsfield credits and requires explicit user confirmation. This skill
never auto-generates.

**Full step-by-step flow** (confirmation gate, balance/cost surface, generate → poll → display):
[`../../shared/generation-flow.md`](../../shared/generation-flow.md)

**This skill's primary model:** `wan2_7`

### Media upload — MANDATORY (not conditional)

This skill always requires a source anime frame. The media branch is **not conditional** —
it always runs before generation. Do not skip it.

**Required sequence:**

1. Ask the user to provide the anime frame or illustration file (PNG, JPG, or WebP).
2. Call `higgsfield:media_upload` with the file → receives a `pending_id`.
3. Call `higgsfield:media_confirm` with the `pending_id` → receives a `confirmed_id`.
4. Attach the `confirmed_id` to the `input_files` array before calling
   `higgsfield:generate_video`:
   - **wan2_7 (primary):** role = `start_image`
   - **wan2_6 (fallback):** role = `image`

```json
// wan2_7 (primary)
input_files: [{ "id": "<confirmed_id>", "role": "start_image" }]

// wan2_6 (fallback)
input_files: [{ "id": "<confirmed_id>", "role": "image" }]
```

Never pass a `pending_id` directly to `input_files`. Never attempt generation without
first completing the upload pair. wan2_6's `image` role is REQUIRED — a missing or
unconfirmed image will cause the request to be rejected.

See [`../../shared/generation-flow.md`](../../shared/generation-flow.md) Step 2b for the
atomic-pair detail and full input_files structure.

**Tool signatures:** [`../../shared/mcp-tools.md`](../../shared/mcp-tools.md)

---

## Reference materials

| File | Contents |
|---|---|
| [references/model-specs.md](references/model-specs.md) | Verified parameter tables for wan2_7 (primary) and wan2_6 (fallback, image REQUIRED); routing rationale; re-verify directive |
| [references/anime-craft.md](references/anime-craft.md) | Anime visual language, action choreography, style-transfer principles, camera techniques, lighting/color theory, genre identity guide, effects library |
| [references/hooks.md](references/hooks.md) | 2-second hook framework with 12 anime hook techniques and genre selection guide |
| [references/examples.md](references/examples.md) | Master prompt template plus 5 worked examples (shonen fight, magical girl, slice-of-life, mecha, emotional drama) |
