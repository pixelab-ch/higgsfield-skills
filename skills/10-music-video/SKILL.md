---
name: higgsfield-music-video
description: >-
  Generates music video and beat-synced visual content prompts for Higgsfield.
  An audio track is always required. Routes to veo3_1 (primary, native audio)
  or veo3_1_lite (fallback). Use when the user wants a music video, lyric video,
  beat-synced visuals, performance video, concert visual, album art animation,
  or any music-driven visual content.
when_to_use: >-
  Use for music video, lyric video, beat sync, music visualization, performance
  video, concert visual, album visual, song video, music clip, beat drop visual,
  rhythm sync, or any music-driven video request. Use even for "make visuals for
  my song" or "video for this track."
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

# Higgsfield Music-Video Skill

## What this skill does

Crafts production-ready music video prompts and routes them to the best Higgsfield model
for beat-synced, audio-driven output. Handles performance videos, narrative videos, abstract
visualizers, lyric videos, and multi-segment assembly for full-length songs.

**An audio track is always required.** This is a mandatory-audio skill: every generation
needs a user-supplied audio file uploaded and confirmed via the media branch before calling
`higgsfield:generate_video`. The confirmed audio is attached with role `audio`.

---

## Model routing

### Primary and fallback video models

| | veo3_1 (primary) | veo3_1_lite (fallback) |
|---|---|---|
| **Rationale** | Native audio generation; best audio-visual sync | Lower cost; use when primary is unavailable |
| **Aspect ratios** | `16:9`, `9:16` only — **no `1:1`** | `16:9`, `9:16`, `auto` |
| **Duration** | `4`, `6`, `8` s — **discrete set only** | `4`, `6`, `8` s (same discrete set) |
| **Tunable params** | `quality` {basic, high, ultra}; `model` {veo-3-1-preview, veo-3-1-fast} | `resolution` {720p, 1080p}; `generate_audio` {true, false, def false} |
| **Media roles** | `start_image` (max 1) | `start_image`, `end_image` |
| **Native audio** | Yes | Basic (via `generate_audio` param) |

**Routing rule:** Use `veo3_1` by default. Fall back to `veo3_1_lite` only when the primary
is unavailable. When falling back, inform the user of what they give up: native audio
quality and the `veo-3-1-preview` quality tier. Never switch silently.

**Aspect and duration constraints:**
- Neither model supports `1:1` aspect ratio.
- Durations are the discrete set `[4, 6, 8]` — do not pass 5, 7, 10, or 15.
- A full music video requires multiple segments (see model-specs.md for planning guidance).

**MODEL-06 directive:** If a parameter is rejected at generation time, call
`higgsfield:models_explore` with the target model name to re-verify the live schema. Full
parameter tables: [references/model-specs.md](references/model-specs.md).

---

## Prompt-building workflow

1. **Gather intent** — Confirm: song genre, visual strategy (performance / narrative /
   abstract), target platform, aspect ratio, mood/aesthetic, desired clip duration.

2. **Select model** — Apply the routing table above. Use `veo3_1` by default.

3. **Build the prompt** — Use the craft references below:
   - Beat-sync techniques, energy mapping, hook framework, camera techniques:
     [references/beat-sync.md](references/beat-sync.md)
   - Genre-specific visual language, colors, lighting, trigger words:
     [references/genres.md](references/genres.md)
   - Master template and worked example prompts:
     [references/examples.md](references/examples.md)

4. **Plan segments** — Because veo3_1 clips are 4–8 s, map the song's structure to
   segments before generating. See [references/model-specs.md](references/model-specs.md)
   for multi-segment planning.

5. **Present for review** — Show the assembled prompt and all parameters to the user for
   review and refinement **before** any generation call.

---

## Opt-in generation

Generation costs Higgsfield credits and requires explicit user confirmation before any
generate call. This skill never auto-generates.

**Full step-by-step flow** (confirmation gate, balance/cost surface, generate → poll →
display): [`../../shared/generation-flow.md`](../../shared/generation-flow.md)

**This skill's primary model:** `veo3_1`

**Media upload — MANDATORY (GEN-04):**

An audio track is always required for video generation. Before calling
`higgsfield:generate_video`:

1. Ask the user to provide their audio file.
2. Upload it: run `higgsfield:media_upload` → returns a `pending_id`.
3. Confirm it: run `higgsfield:media_confirm` → returns a `confirmed_id`.
4. Attach it in `input_files` with role `audio`:
   ```json
   [{ "id": "<confirmed_id>", "role": "audio" }]
   ```

If the user also provides a reference image for the video, add it with role `start_image`
in the same `input_files` array:
   ```json
   [
     { "id": "<audio_confirmed_id>",  "role": "audio" },
     { "id": "<image_confirmed_id>",  "role": "start_image" }
   ]
   ```

Never pass a `pending_id` directly to `input_files` — it will be rejected. See
[`../../shared/generation-flow.md`](../../shared/generation-flow.md) Step 2b for the full
atomic-pair detail.

**Tool signatures:** [`../../shared/mcp-tools.md`](../../shared/mcp-tools.md)

---

## Reference materials

| File | Contents |
|---|---|
| [references/model-specs.md](references/model-specs.md) | Per-model parameter tables for veo3_1 and veo3_1_lite; per-platform recommendations; multi-segment assembly note; verification annotation |
| [references/beat-sync.md](references/beat-sync.md) | Beat-visual synchronization philosophy, 12 music-video hook styles, 7 beat-sync techniques (timing references, energy mapping, frequency-responsive effects, syncopation visuals), energy arc table, performance/narrative/abstract strategies, camera techniques, multi-segment strategy |
| [references/genres.md](references/genres.md) | Genre visual language guide for 10 genres (hip-hop, pop, rock/metal, EDM, R&B, lo-fi, classical, jazz, country, K-pop) with color palettes, lighting approaches, trigger words, visual hooks, and example prompts |
| [references/examples.md](references/examples.md) | Master template, 5 worked music-video prompts (hip-hop performance, pop ballad, EDM abstract, R&B narrative, K-pop choreography), lyric video technique table |
