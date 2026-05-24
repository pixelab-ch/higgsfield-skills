# Higgsfield MCP Tool Reference

<!-- INFRA-04 | D-03 | verified: 2026-05-24 -->

This file is the **authoritative reference** for every Higgsfield MCP tool used by skills
in this repository. It documents the correct tool name in both syntactic contexts, each
tool's purpose, what it returns, and key parameter notes.

Do **not** duplicate this content inline in any `SKILL.md`. Skills reference this file via
`../../shared/mcp-tools.md`.

---

## Dual Naming Convention (D-03)

The same Higgsfield MCP tool has **two syntactic forms** depending on where it is referenced:

| Context | Form | Example |
|---------|------|---------|
| SKILL.md prose / workflow instructions | `higgsfield:tool_name` (colon separator) | `higgsfield:generate_video` |
| `allowed-tools` frontmatter field | `mcp__higgsfield__tool_name` (double underscore) | `mcp__higgsfield__generate_video` |

**Rule:** Always use the colon form (`higgsfield:tool_name`) when instructing Claude in skill
body text. Always use the double-underscore form (`mcp__higgsfield__tool_name`) in the
`allowed-tools` YAML frontmatter. Using the wrong form in the wrong context causes
"tool not found" or "unapproved tool" errors.

---

## Table of Contents

1. [Core Generation Tools](#core-generation-tools)
   - [generate_image](#generate_image)
   - [generate_video](#generate_video)
2. [Model Discovery](#model-discovery)
   - [models_explore](#models_explore)
3. [Job Tracking](#job-tracking)
   - [job_status](#job_status)
   - [job_display](#job_display)
4. [Media Upload (Atomic Pair)](#media-upload-atomic-pair)
   - [media_upload](#media_upload)
   - [media_confirm](#media_confirm)
5. [Presets](#presets)
   - [presets_show](#presets_show)
6. [Account Tools](#account-tools)
   - [show_plans_and_credits](#show_plans_and_credits)
   - [balance](#balance)
   - [select_workspace](#select_workspace)
7. [Credit Cost Summary](#credit-cost-summary)
8. [Copy-Paste allowed-tools Block](#copy-paste-allowed-tools-block)

---

## Core Generation Tools

These two tools submit generation jobs and **consume Higgsfield credits**. Always call
`higgsfield:models_explore` before calling either of these to get live parameter constraints
for the chosen model. Always confirm with the user before calling either of these (see
`shared/generation-flow.md` for the mandatory confirmation gate).

---

### `generate_image`

| | |
|-|-|
| **Prose form** | `higgsfield:generate_image` |
| **allowed-tools form** | `mcp__higgsfield__generate_image` |
| **Returns** | `job_id` (string) |
| **Costs credits** | Yes |

**Purpose:** Submit an image generation job to the Higgsfield platform. Returns a job ID
immediately; the image is generated asynchronously. Use `higgsfield:job_status` to poll and
`higgsfield:job_display` to display the result.

**Key parameters (all model-dependent — always call `higgsfield:models_explore` first):**

| Parameter | Required | Notes |
|-----------|----------|-------|
| `model` | Yes | Model ID string, e.g. `"nano_banana"`, `"soul_2"`, `"flux_2"`, `"gpt_image"` |
| `prompt` | Yes | Text prompt for the generation |
| `aspect_ratio` | Varies | Must be a value from the model's declared `aspect_ratios` list |
| `quality` | Varies | `"720p"` or `"1080p"` — model-dependent |
| `input_files` | Conditional | Array of confirmed media IDs (roles: `image`, `start_image`). Required when model needs reference images. Upload via `higgsfield:media_upload` → `higgsfield:media_confirm` first. |
| `enhance_prompt` | Optional | Boolean, default `true` |

**Accepted models (~20):** `nano_banana`, `nano_banana_2`, `nano_banana_pro`, `soul_2`,
`soul_cinematic`, `soul_cast`, `soul_location`, `seedream_v4_5`, `seedream_v5_lite`,
`z_image`, `flux_2`, `flux_kontext`, `kling_omni_image`, `gpt_image`, `gpt_image_2`,
`grok_image`, `cinematic_studio_2_5`, `marketing_studio_image`, `ms_image`, `image_auto`.
See `shared/model-catalog.md` for the full catalog with per-model constraints.

---

### `generate_video`

| | |
|-|-|
| **Prose form** | `higgsfield:generate_video` |
| **allowed-tools form** | `mcp__higgsfield__generate_video` |
| **Returns** | `job_id` (string) |
| **Costs credits** | Yes |

**Purpose:** Submit a video generation job to the Higgsfield platform. Returns a job ID
immediately; the video is generated asynchronously. Use `higgsfield:job_status` to poll and
`higgsfield:job_display` to display the result.

**Key parameters (all model-dependent — always call `higgsfield:models_explore` first):**

| Parameter | Required | Notes |
|-----------|----------|-------|
| `model` | Yes | Model ID string, e.g. `"seedance_2_0"`, `"veo3"`, `"kling3_0"` |
| `prompt` | Yes | Text prompt for the generation |
| `aspect_ratio` | Varies | Must be from the model's declared `aspect_ratios` list |
| `duration` | Varies | Integer within model's `duration_range` or from `durations` list |
| `input_files` | Conditional | Array of confirmed media IDs; roles vary by model (`image`, `start_image`, `end_image`, `video`, `audio`). Required for image-to-video and audio-driven models. |
| Model-specific | Varies | e.g., `genre` for `cinematic_studio_3_0`; `mode` for some models |

**Accepted models (~18):** `seedance_2_0`, `seedance_1_5`, `minimax_hailuo`, `wan2_6`,
`wan2_7`, `kling2_6`, `kling3_0`, `grok_video`, `veo3`, `veo3_1`, `veo3_1_lite`,
`cinematic_studio_3_0`, `cinematic_studio_video` (v1/v2), `marketing_studio_video`,
`higgsfield_preset`.
See `shared/model-catalog.md` for the full catalog with per-model constraints.

---

## Model Discovery

---

### `models_explore`

| | |
|-|-|
| **Prose form** | `higgsfield:models_explore` |
| **allowed-tools form** | `mcp__higgsfield__models_explore` |
| **Returns** | Live model catalog with per-model parameter schemas |
| **Costs credits** | No |

**Purpose:** Return the live Higgsfield model catalog. For each model, returns its
`parameters` (resolution, quality, mode, genre options), `aspect_ratios`,
`durations`/`duration_range`, and media `roles` (image, start_image, end_image, video,
audio).

**Usage rule:** ALWAYS call `higgsfield:models_explore` before calling `generate_image` or
`generate_video`. It is the authoritative source of truth for which parameters a given model
accepts. Never hardcode model specs from training data — Higgsfield updates models and specs
drift. Call with a specific model name to get that model's schema, or without arguments to
browse all models.

---

## Job Tracking

---

### `job_status`

| | |
|-|-|
| **Prose form** | `higgsfield:job_status` |
| **allowed-tools form** | `mcp__higgsfield__job_status` |
| **Returns** | `status` field (`"pending"`, `"running"`, `"complete"`, `"failed"`) + result URL when complete |
| **Costs credits** | No |

**Purpose:** Check the status of a single generation job by `job_id`. This is a one-shot
status check, not a long-running poller. Call repeatedly with backoff (30–60 seconds between
calls) until the job reaches `"complete"` or `"failed"` status.

**Critical rule:** NEVER re-call `higgsfield:generate_image` or `higgsfield:generate_video`
to check if a job is done — that submits a NEW generation job and charges credits again.
Use `higgsfield:job_status` exclusively for polling.

---

### `job_display`

| | |
|-|-|
| **Prose form** | `higgsfield:job_display` |
| **allowed-tools form** | `mcp__higgsfield__job_display` |
| **Returns** | Rendered job result with output URL |
| **Costs credits** | No |

**Purpose:** Show or re-display a job result with richer formatting than raw `job_status`.
Can paginate past generations. Use after a job reaches `"complete"` status to present the
output URL and any visual rendering to the user.

---

## Media Upload (Atomic Pair)

`higgsfield:media_upload` and `higgsfield:media_confirm` are an **atomic pair**: always call
both in sequence before passing media to a generation call. Never use a pending (unconfirmed)
media ID in `input_files` — it will be rejected at generation time.

---

### `media_upload`

| | |
|-|-|
| **Prose form** | `higgsfield:media_upload` |
| **allowed-tools form** | `mcp__higgsfield__media_upload` |
| **Returns** | A **pending** media ID (not yet usable in generation calls) |
| **Costs credits** | No |

**Purpose:** Upload a local image, video, or audio file to the Higgsfield platform before
passing it to `generate_image` or `generate_video`. Must be followed immediately by
`higgsfield:media_confirm` to get the usable confirmed ID.

---

### `media_confirm`

| | |
|-|-|
| **Prose form** | `higgsfield:media_confirm` |
| **allowed-tools form** | `mcp__higgsfield__media_confirm` |
| **Returns** | A **confirmed** media ID, ready for use in `input_files` |
| **Costs credits** | No |

**Purpose:** Confirm that a pending upload is complete and retrieve the usable media ID. This
ID is what goes into the `input_files` array of a generation call.

**Atomic pair pattern:**
```
higgsfield:media_upload  → returns pending_id
higgsfield:media_confirm → returns confirmed_id
use confirmed_id in input_files of generate_image / generate_video
```

---

## Presets

---

### `presets_show`

| | |
|-|-|
| **Prose form** | `higgsfield:presets_show` |
| **allowed-tools form** | `mcp__higgsfield__presets_show` |
| **Returns** | List of available generation presets |
| **Costs credits** | No |

**Purpose:** List the available generation presets for the `higgsfield_preset` video model.
Call this when the user wants to browse or use preset-based video generation workflows.

---

## Account Tools

---

### `show_plans_and_credits`

| | |
|-|-|
| **Prose form** | `higgsfield:show_plans_and_credits` |
| **allowed-tools form** | `mcp__higgsfield__show_plans_and_credits` |
| **Returns** | Available plan upgrades and one-time credit top-up options |
| **Costs credits** | No |

**Purpose:** Show the user their plan upgrade options and one-time credit top-up packages.
Use this in the **confirmation gate** before generating (together with `higgsfield:balance`)
so the user can see their credit situation and top up if needed before committing to a
generation.

---

### `balance`

| | |
|-|-|
| **Prose form** | `higgsfield:balance` |
| **allowed-tools form** | `mcp__higgsfield__balance` |
| **Returns** | Current Higgsfield credit balance |
| **Costs credits** | No |

**Purpose:** Show the user's current credit balance. Call this in the **confirmation gate**
before any generation so the user knows how many credits they have remaining before being
asked to confirm the generation.

---

### `select_workspace`

| | |
|-|-|
| **Prose form** | `higgsfield:select_workspace` |
| **allowed-tools form** | `mcp__higgsfield__select_workspace` |
| **Returns** | Confirmation of workspace switch |
| **Costs credits** | No |

**Purpose:** Switch between a private workspace and a shared workspace. Situational: most
users operate with a single workspace and will not need this tool. Use it when the user
explicitly asks to switch workspaces or when workspace context affects the generation target.

---

## Credit Cost Summary

| Tool | Costs Credits? |
|------|---------------|
| `higgsfield:generate_image` | **Yes** |
| `higgsfield:generate_video` | **Yes** |
| `higgsfield:models_explore` | No |
| `higgsfield:job_status` | No |
| `higgsfield:job_display` | No |
| `higgsfield:media_upload` | No |
| `higgsfield:media_confirm` | No |
| `higgsfield:presets_show` | No |
| `higgsfield:show_plans_and_credits` | No |
| `higgsfield:balance` | No |
| `higgsfield:select_workspace` | No |

Only `generate_image` and `generate_video` consume credits. All discovery, tracking, media,
and account tools are free to call.

---

## Copy-Paste `allowed-tools` Block

The following block pre-approves all tools that a generation-capable skill needs. Paste into
the YAML frontmatter of any SKILL.md that includes the generation workflow. Omit tools the
skill does not use (e.g., remove `mcp__higgsfield__presets_show` if the skill does not use
the `higgsfield_preset` model).

```yaml
allowed-tools: >-
  mcp__higgsfield__generate_image
  mcp__higgsfield__generate_video
  mcp__higgsfield__models_explore
  mcp__higgsfield__job_status
  mcp__higgsfield__job_display
  mcp__higgsfield__media_upload
  mcp__higgsfield__media_confirm
  mcp__higgsfield__presets_show
  mcp__higgsfield__show_plans_and_credits
  mcp__higgsfield__balance
  mcp__higgsfield__select_workspace
```

**Minimal block** (for a standard text-to-video/image skill with no preset or workspace
switching):

```yaml
allowed-tools: >-
  mcp__higgsfield__generate_image
  mcp__higgsfield__generate_video
  mcp__higgsfield__models_explore
  mcp__higgsfield__job_status
  mcp__higgsfield__job_display
  mcp__higgsfield__media_upload
  mcp__higgsfield__media_confirm
  mcp__higgsfield__balance
  mcp__higgsfield__show_plans_and_credits
```

---

*See `shared/model-catalog.md` for the full model catalog with per-model parameter constraints,
aspect ratios, durations, and media roles. See `shared/generation-flow.md` for the canonical
opt-in generation workflow that all skills follow.*
