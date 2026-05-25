---
name: higgsfield-3d-cgi
description: >-
  Crafts 3D CGI and rendered video prompts for Higgsfield and routes to the
  best model (seedance_2_0 primary, wan2_7 fallback). Use when the user wants
  3D rendered, CGI, Pixar-style, Unreal Engine, photorealistic 3D, computer-
  generated, or digitally rendered video. Triggers on: 3D animation, CGI,
  rendered, Blender, Unreal Engine, octane render, ray tracing, volumetric,
  subsurface scattering, physically based rendering, or any 3D/CG video request.
when_to_use: >-
  Use for Pixar-style animation, photorealistic product visualization,
  architectural walkthroughs, sci-fi environments, creature animation, isometric
  3D, cel-shaded, voxel, wireframe, or any request that mentions "make it look
  3D" or describes a rendered aesthetic.
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

# Higgsfield 3D CGI Skill

## What this skill does

Crafts production-ready 3D CGI and rendered video prompts and routes them to the best
Higgsfield model for computer-generated output. On request, it assembles the full
parameter set, surfaces the credit cost, and — after explicit user confirmation —
generates the asset via the opt-in generation flow.

The difference between a generic "make it look 3D" request and a production-ready CGI
prompt lies in specificity: render engine terminology, material properties, lighting
language, camera dynamics, and the architectural "hooks" that grab attention in the
first two seconds.

---

## Model routing

### Primary and fallback video models

| | seedance_2_0 (primary) | wan2_7 (fallback) |
|---|---|---|
| **Rationale** | Broadest param set for CGI: genre tags, 21:9 aspect, full media-role support | Use only when primary is unavailable |
| **Resolution** | `480p`, `720p`, `1080p` (def `720p`) | `720p`, `1080p` |
| **Aspect ratios** | `auto`, `21:9`, `16:9`, `4:3`, `1:1`, `3:4`, `9:16` | `16:9`, `9:16`, `1:1`, `4:3`, `3:4` — **no `21:9`** |
| **Duration** | 4–15 s (continuous range) | 2–15 s (continuous range) |
| **Tunable params** | `resolution`, `mode` {`std`,`fast`}, `genre` {`auto`,`action`,`horror`,`comedy`,`noir`,`drama`,`epic`} | None beyond resolution and aspect |
| **Media roles** | `image`, `start_image`, `end_image`, `video`, `audio` | `start_image`, `end_image`, `audio` only |

**Routing rule:** Use `seedance_2_0` by default. Only fall back to `wan2_7` when (1) the
primary model is unavailable, or (2) the user explicitly accepts wan2_7's constraints
after being told what they give up: no `21:9` aspect ratio, no `genre` or `mode` params,
and no `image` or `video` media roles. If the user has not been informed of these
trade-offs, stay on `seedance_2_0` and let them decide — never switch silently.

**MODEL-06 directive:** If a parameter is rejected at generation time, call
`higgsfield:models_explore` with the target model name to re-verify the live schema.
Full parameter tables: [references/model-specs.md](references/model-specs.md).

### Per-platform quick rule

Vertical `9:16` for TikTok / Reels / Shorts; `16:9` for YouTube and LinkedIn;
`21:9` cinematic widescreen only on `seedance_2_0`. Full per-platform table:
[references/model-specs.md](references/model-specs.md).

---

## Prompt-building workflow

1. **Gather intent** — Confirm with the user: CGI style (Pixar, photorealistic, low-poly,
   cel-shaded, isometric, etc.), subject, mood, target platform, aspect ratio, desired
   duration, and any I2V reference images.

2. **Select model** — Apply the routing table above. Choose `seedance_2_0` by default;
   select `wan2_7` only when a routing trigger applies.

3. **Build the prompt** — Use the craft principles in the references below:
   - Opening hook (2-second attention-capture technique) from
     [references/hooks.md](references/hooks.md)
   - Render style, materials, lighting setup, camera movement from
     [references/render-craft.md](references/render-craft.md)
   - Worked example prompts by sub-genre from
     [references/examples.md](references/examples.md)

4. **Present for review** — Show the assembled prompt and all parameters to the user for
   review and refinement **before** any generation call. The user must approve the prompt
   text, model, aspect ratio, duration, and (if used) genre/mode.

---

## Opt-in generation

Generation costs Higgsfield credits and requires explicit user confirmation before any
generate call is made. This skill never auto-generates.

**Full step-by-step flow** (confirmation gate, balance/cost surface,
generate → poll → display):
[`../../shared/generation-flow.md`](../../shared/generation-flow.md)

**This skill's primary model:** `seedance_2_0`

**Media upload:** Conditional — only when the user supplies a `start_image`, `end_image`,
`video`, or `audio` reference. This skill is NOT a mandatory-I2V skill; T2V is the
default path. When the user provides a reference file, run the
`higgsfield:media_upload` → `higgsfield:media_confirm` atomic pair before generating.

**Tool signatures:** [`../../shared/mcp-tools.md`](../../shared/mcp-tools.md)

---

## Reference materials

| File | Contents |
|---|---|
| [references/model-specs.md](references/model-specs.md) | Per-model parameter tables, aspect ratios, durations, routing rationale, and re-verify directive for seedance_2_0 and wan2_7 |
| [references/render-craft.md](references/render-craft.md) | Render style encyclopedia (9+ styles), material science library (20+ surfaces), lighting setups (15+), camera movement guide (15+), particle and effects language |
| [references/hooks.md](references/hooks.md) | 2-second hook framework with 12+ hook techniques and prompt phrasing templates for CGI |
| [references/examples.md](references/examples.md) | Master prompt template, 5 full production-quality CGI example prompts (Pixar, photorealistic product, isometric sci-fi, creature transformation, architectural flythrough), and common-mistakes guide |
