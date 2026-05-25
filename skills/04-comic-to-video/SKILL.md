---
name: higgsfield-comic-to-video
description: >-
  Animates comic panels, manga pages, webtoons, illustrated storyboards, and sequential
  art into video using Higgsfield. Routes to wan2_6 (primary, I2V — image required) or
  seedance_2_0 (fallback). Use when the user wants to animate comics, bring illustrations
  to life, convert manga to video, animate storyboards, or create motion from static
  sequential art. Triggers on: comic to video, manga animation, panel animation, storyboard
  to video, webtoon animation, comic book motion, sequential art, graphic novel animation,
  or any illustrate-to-animate request.
when_to_use: >-
  Use for any request to animate a static comic panel, manga page, webtoon strip,
  illustrated storyboard, or sequential art. Also use when the user says "make this
  drawing move," "animate this page," or "bring this panel to life." A source image
  is always required — this skill cannot generate without one.
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

# Higgsfield Comic-to-Video Skill

## What this skill does

Animates a user-supplied comic panel, manga page, webtoon strip, or sequential art
illustration into video. The skill reads the panel, infers narrative flow, and generates
motion that respects reading order, art-style conventions, and dialogue timing.

**A source image (the comic panel or page) is always required.** This skill is a mandatory
image-to-video (I2V) skill — it cannot run without a start image. Before any generation
call can happen, the user must provide the panel file and the
`higgsfield:media_upload` → `higgsfield:media_confirm` flow must complete successfully.

---

## Model routing

### Primary and fallback video models

| | wan2_6 (primary) | seedance_2_0 (fallback) |
|---|---|---|
| **Rationale** | Dedicated I2V pipeline; image role is REQUIRED | Genre tone control, flexible duration, additional media roles |
| **Quality / resolution** | `720p`, `1080p` | `480p`, `720p`, `1080p` (default `720p`) |
| **Aspect ratios** | `16:9`, `9:16`, `1:1` | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` |
| **Duration** | `5`, `10`, `15` s — **discrete set only** | 4–15 s (continuous range) |
| **Image role** | `image` x1 **REQUIRED** | `start_image` or `image` |
| **Genre control** | No | Yes: `auto`, `action`, `horror`, `comedy`, `noir`, `drama`, `epic` |

**Routing rule:** Use `wan2_6` by default. Fall back to `seedance_2_0` when: (1) wan2_6 is
unavailable, (2) the user wants duration outside `[5, 10, 15]`, (3) the user wants genre
tone control, or (4) the user wants audio/end_image roles. Never switch silently — state
what changes.

**MODEL-06 directive:** If a parameter is rejected at generation time, call
`higgsfield:models_explore` with the target model name. Full parameter tables:
[references/model-specs.md](references/model-specs.md).

### Per-platform aspect ratio and duration

Quick rule: `9:16` for TikTok / Reels / Shorts, `16:9` for YouTube, `1:1` for Instagram
feed. Full per-platform table: [references/model-specs.md](references/model-specs.md).

---

## Prompt-building workflow

1. **Gather intent** — Confirm with the user: reading order (Western LTR / Manga RTL /
   Webtoon Vertical / etc.), source art style, target platform, aspect ratio, and duration.

2. **Select model** — Apply the routing table above. `wan2_6` by default.

3. **Build the prompt** — Use the craft principles in the references below:
   - 2-second hook technique from [references/hooks.md](references/hooks.md)
   - Reading order, art-style preservation, dialogue handling, panel-to-motion techniques
     from [references/panel-craft.md](references/panel-craft.md)
   - Worked example prompts by comic format from [references/examples.md](references/examples.md)

4. **Present for review** — Show the assembled prompt and all parameters to the user
   for review and refinement before any upload or generation call.

---

## Opt-in generation

Generation costs Higgsfield credits and requires explicit user confirmation. This skill
never auto-generates.

**Full step-by-step flow** (confirmation gate, balance/cost surface, generate → poll → display):
[`../../shared/generation-flow.md`](../../shared/generation-flow.md)

**This skill's primary model:** `wan2_6`

### Media upload — MANDATORY (not conditional)

This skill always requires a source image. The media branch is **not conditional** — it
always runs before generation. Do not skip it.

**Required sequence:**

1. Ask the user to provide the comic panel or page file (PNG, JPG, or WebP).
2. Call `higgsfield:media_upload` with the file → receives a `pending_id`.
3. Call `higgsfield:media_confirm` with the `pending_id` → receives a `confirmed_id`.
4. Attach the `confirmed_id` to the `input_files` array with role `image` before calling
   `higgsfield:generate_video`.

```json
input_files: [{ "id": "<confirmed_id>", "role": "image" }]
```

Never pass a `pending_id` directly to `input_files`. Never attempt generation without
first completing the upload pair. A missing or unconfirmed image will cause wan2_6 to
reject the request.

See [`../../shared/generation-flow.md`](../../shared/generation-flow.md) Step 2b for the
atomic-pair detail and full input_files structure.

**Tool signatures:** [`../../shared/mcp-tools.md`](../../shared/mcp-tools.md)

---

## Reference materials

| File | Contents |
|---|---|
| [references/model-specs.md](references/model-specs.md) | Verified parameter tables for wan2_6 (primary, image REQUIRED) and seedance_2_0 (fallback); routing rationale; re-verify directive |
| [references/panel-craft.md](references/panel-craft.md) | Reading-order conventions, art-style preservation keywords, dialogue handling, 15+ panel-to-motion techniques, transition guide |
| [references/hooks.md](references/hooks.md) | 2-second hook framework with 10 hook techniques and selection guide |
| [references/examples.md](references/examples.md) | Master prompt template plus 5 worked examples (Western action, manga RTL, webtoon vertical, storyboard, single illustration) |
