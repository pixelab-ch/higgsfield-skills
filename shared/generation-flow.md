# Canonical Opt-In Generation Flow

<!-- INFRA-03 | D-04 | D-05 | verified: 2026-05-24 -->

This file documents the **single canonical generation workflow** used by all skills in this
repository. Every skill that offers generation links to this file from its "Generation
workflow" section. This flow is **never duplicated inline** in any `SKILL.md`.

For tool signatures and dual naming convention, see `shared/mcp-tools.md`.

---

## Hard Rule: Generation is Always Opt-In

> **REQUIRED: Never call `higgsfield:generate_image` or `higgsfield:generate_video` before
> the user gives an explicit YES at the confirmation gate (Step 3).**

Generation consumes Higgsfield credits. There is no undo. Any call to a generate tool before
explicit user confirmation violates this rule. This applies without exception to all 15 skills
in this repository.

---

## Table of Contents

1. [Overview](#overview)
2. [Step 1 — Resolve Model](#step-1--resolve-model)
3. [Step 2 — Build Prompt and Parameters](#step-2--build-prompt-and-parameters)
4. [Step 2b — Media Upload (Conditional)](#step-2b--media-upload-conditional)
5. [Step 3 — Confirm (REQUIRED)](#step-3--confirm-required)
6. [Step 4 — Generate](#step-4--generate)
7. [Step 5 — Poll Job Status](#step-5--poll-job-status)
8. [Step 6 — Display Result](#step-6--display-result)
9. [Skills That Always Take the Media Upload Branch](#skills-that-always-take-the-media-upload-branch)
10. [How Skills Link to This File](#how-skills-link-to-this-file)

---

## Overview

```
[Step 1] Resolve model
    └─> [Step 2] Build prompt + assemble parameters
            └─> [Step 2b] (conditional) media_upload → media_confirm → add to input_files
                    └─> [Step 3] Confirmation gate ← REQUIRED — wait for explicit YES
                            └─> [Step 4] generate_image / generate_video → job_id
                                    └─> [Step 5] Poll job_status (backoff 30-60s, NEVER re-generate)
                                            └─> [Step 6] job_display → present result + URL
```

---

## Step 1 — Resolve Model

**Goal:** Identify the Higgsfield model that best fits the user's creative intent.

1. Read the skill's `references/model-specs.md` to find the recommended model(s) for this
   skill's creative style.
2. Match the user's request to the routing table in that file (e.g., cinematic quality →
   `seedance_2_0`; photorealistic still → `soul_2`; marketing asset → `marketing_studio_image`).
3. If the request is ambiguous or could match more than one model, clarify with the user
   before proceeding. Do not guess when the model choice materially affects the output
   quality or parameter set.
4. Call `higgsfield:models_explore` with the chosen model name to retrieve the live parameter
   schema (aspect ratios, duration range, media roles, model-specific parameters). This is
   the source of truth — never assume values from training knowledge, which drifts as
   Higgsfield updates its models.

See `shared/model-catalog.md` for the full catalog of ~38 models across video and image.

---

## Step 2 — Build Prompt and Parameters

**Goal:** Construct the generation prompt and assemble all parameters within model constraints.

1. Apply the skill's prompt-craft guidance (from `references/prompt-craft.md`) to build a
   production-ready prompt from the user's input.
2. From the `higgsfield:models_explore` response, pick valid values for:
   - `aspect_ratio`: must be from the model's declared `aspect_ratios` list
   - `duration`: must be within `duration_range` or from the `durations` list (video only)
   - Model-specific parameters: e.g., `genre` for `cinematic_studio_3_0`, `mode` for models
     that declare it
3. Show the assembled prompt to the user and allow refinement before proceeding to
   confirmation. The user should approve the prompt text, not just the final generation.

---

## Step 2b — Media Upload (Conditional)

**Trigger:** Run this step when either of these conditions is true:
- The user provides a local image, video, or audio file as input (e.g., "use this image as
  the starting frame").
- The chosen model requires a media role (`start_image`, `end_image`, `video`, `audio`) that
  must be filled with user-supplied content.

**Do not skip this step** when either condition applies — passing an unconfirmed or absent
media ID to a generation call will cause the API to reject the request (wasted attempt, no
refund).

### Atomic Pair: media_upload → media_confirm

```
Call higgsfield:media_upload  → returns pending_id
Call higgsfield:media_confirm → returns confirmed_id
Use confirmed_id in the input_files array of generate_image / generate_video
```

These two calls are an atomic pair. Always call both before generating. Never pass a
`pending_id` directly to `input_files`.

**input_files structure:** Each entry specifies the confirmed media ID and its role:
```json
[
  { "id": "<confirmed_id>", "role": "start_image" }
]
```

Valid roles (model-dependent, verify via `higgsfield:models_explore`): `image`,
`start_image`, `end_image`, `video`, `audio`.

---

## Step 3 — Confirm (REQUIRED)

> **This step is a hard gate. Do not call any generate tool before the user provides an
> explicit affirmative response.**

Before generating, show the user a confirmation panel containing:

| Element | What to Show |
|---------|-------------|
| **Model** | Model name + brief rationale for why this model was chosen |
| **Prompt** | The full prompt text that will be submitted |
| **Key parameters** | `aspect_ratio`, `duration` (if video), any model-specific params |
| **Media inputs** | List of uploaded files and their roles (if Step 2b was run) |
| **Credit balance** | Result of `higgsfield:balance` — current credits remaining |
| **Credit cost** | Call `higgsfield:show_plans_and_credits` to surface relevant cost context |

**Call order for credit information:**
1. Call `higgsfield:balance` to show current credit balance.
2. Call `higgsfield:show_plans_and_credits` if the user may need to top up or the balance
   seems low for the intended generation.

**Confirmation prompt:** Ask the user explicitly whether to proceed. Example:
> "Proceed with this generation? (yes / no)"

**If the user says no:** Offer to adjust the prompt, parameters, or model, then return to
Step 2. Do not generate.

**If the user says yes:** Proceed immediately to Step 4.

---

## Step 4 — Generate

**Goal:** Submit the generation job and capture the job ID.

Call the appropriate tool based on the chosen model:
- Image model → `higgsfield:generate_image`
- Video model → `higgsfield:generate_video`

Pass the assembled parameters exactly as validated in Steps 2 and 2b.

```
higgsfield:generate_video({
  model: "<model_id>",
  prompt: "<prompt_text>",
  aspect_ratio: "<from_models_explore>",
  duration: <integer_within_range>,
  input_files: [{ "id": "<confirmed_id>", "role": "<role>" }]  // if Step 2b was run
})
→ returns job_id
```

Capture the `job_id` from the response immediately. Report it to the user so they have a
record of the submission.

---

## Step 5 — Poll Job Status

**Goal:** Monitor the job until it completes or fails.

Call `higgsfield:job_status` with the `job_id` at regular intervals:
- Wait **30–60 seconds** between calls (Higgsfield jobs typically take 30s–several minutes).
- Apply exponential backoff if many polls are needed.
- Continue polling until the status field is `"complete"` or `"failed"`.

**Status values:**

| Status | Meaning | Action |
|--------|---------|--------|
| `"pending"` | Job queued, not yet started | Poll again after backoff |
| `"running"` | Job actively generating | Poll again after backoff |
| `"complete"` | Generation finished | Proceed to Step 6 |
| `"failed"` | Generation failed | Report error and job_id to user; do NOT resubmit |

### Critical Rule: Never Re-Submit to Poll

> **NEVER call `higgsfield:generate_image` or `higgsfield:generate_video` again to check if
> a job is done. That submits a NEW generation job and charges credits again.**

Use only `higgsfield:job_status` for polling. If a job fails, report the failure and the
original `job_id` — do not automatically resubmit without explicit user instruction.

---

## Step 6 — Display Result

**Goal:** Present the completed generation to the user.

When `job_status` returns `"complete"`:
1. Call `higgsfield:job_display` with the `job_id` to render the result with rich formatting.
2. Report the output URL and the `job_id` (so the user can re-display with `job_display`
   later if needed).
3. Summarize what was generated: model used, prompt snippet, key parameters.

If `job_status` returns `"failed"`: Report the failure reason (if available), the original
`job_id`, and offer to attempt a new generation with adjusted parameters (which will require
going through the full confirmation gate again — Step 3).

---

## Skills That Always Take the Media Upload Branch

The following four skills **always** require Step 2b (media_upload → media_confirm) because
their models require one or more media input roles every time:

| Skill | Reason | Required Role(s) |
|-------|--------|-----------------|
| `04-comic-to-video` | Animates a static comic/image panel | `start_image` |
| `08-anime-action` | Image-to-video anime style transfer | `start_image` |
| `09-product-360` | 360° orbit from product image | `start_image` |
| `10-music-video` | Music/audio-synchronized video generation | `audio` |

For these skills, the media upload branch in Step 2b is not conditional — it is always
executed. Skills 04, 08, 09 require a user-supplied image; skill 10 requires a user-supplied
audio track. Each of these skills' `SKILL.md` files should instruct the user to provide the
relevant file before the generation workflow begins.

---

## How Skills Link to This File

Each `SKILL.md` that offers generation must include a reference to this file in its
generation workflow section, rather than duplicating the flow inline:

```markdown
## Generation workflow

This skill follows the canonical opt-in generation flow. See
[`../../shared/generation-flow.md`](../../shared/generation-flow.md) for the full step-by-step
process including the required confirmation gate and the conditional media upload branch.

**This skill's model:** [Model name] — see `references/model-specs.md` for parameter tables.
**Media upload required:** [Yes / Conditional — describe trigger] / No
```

The canonical flow is **never duplicated inline** in any `SKILL.md`. The reference path from
a skill directory (`skills/NN-name/`) to this file is `../../shared/generation-flow.md`.

For tool signatures, dual naming convention, and the copy-paste `allowed-tools` block, see
[`../../shared/mcp-tools.md`](../../shared/mcp-tools.md).

---

*This document encodes the opt-in generation guarantee (D-04) and the media upload branch
(D-05) as structural requirements. All 15 skills in Phases 2-3 are bound by this flow.*
