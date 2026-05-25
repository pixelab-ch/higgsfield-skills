# STRUCT-04: Higgsfield Skill Frontmatter & SKILL.md Standard

_Established: 2026-05-24. This document defines the standard that Phases 2-3 apply to
every per-skill SKILL.md. No per-skill frontmatter is rewritten in this phase._

---

## 1. Frontmatter Rules

Every `SKILL.md` file must open with a YAML frontmatter block containing at minimum
`name` and `description`. Both fields are required for reliable skill invocation.

### `name` field

| Rule | Constraint |
|------|-----------|
| Maximum length | 64 characters |
| Allowed characters | Lowercase letters (`a-z`), digits (`0-9`), hyphens (`-`) only |
| Forbidden characters | Spaces, underscores, uppercase letters, XML tags |
| Reserved words | `anthropic` and `claude` are forbidden (anywhere in the name) |
| Must match directory | The value must match the skill's directory name exactly |
| Uniqueness | Must be unique across all skills (one name per skill). This project ships **English only** — no translated skill variants. |

**Naming guidance (this project):** New skill names should use the `higgsfield-<style>`
pattern instead of the legacy `seedance-*` prefix. The `seedance-*` names are valid format
but are misleading for the multi-model rework. Actual renaming happens in Phases 2-3, not
in Phase 1.

### `description` field

| Rule | Constraint |
|------|-----------|
| Maximum length | 1024 characters |
| Style | Third person — "Generates..." not "I generate..." |
| Required content | (1) What the skill does; (2) an explicit **"Use when..."** trigger clause |
| Key triggers first | Put the primary use-case keywords in the first ~100 characters (truncation risk) |
| No XML tags | Angle-bracket content is not permitted |
| Combined cap | `description` + `when_to_use` combined are truncated to **1,536 characters** in the skill listing — put overflow trigger terms in `when_to_use` |

### Optional fields relevant to this project

| Field | Purpose |
|-------|---------|
| `when_to_use` | Additional trigger phrases appended to `description` in the listing. Counts toward the 1,536-char combined cap. Use for overflow trigger keywords that don't fit in `description`. |
| `allowed-tools` | Pre-approves MCP tools to avoid per-use prompts. Format: `mcp__higgsfield__generate_video mcp__higgsfield__generate_image` (double-underscore syntax). |
| `disable-model-invocation: true` | Prevents auto-trigger; only the user can invoke with `/name`. Use for generation-only skills, NOT for prompt-crafting skills. |
| `user-invocable: false` | Hides from the `/` menu but still auto-loads when relevant. |
| `effort: high` | Override reasoning level. Consider for the generation workflow step. |

---

## 2. Worked Examples

### Example A — English skill (compliant)

```yaml
---
name: higgsfield-cinematic
description: >-
  Crafts cinematic video prompts for Higgsfield and routes to the best model
  (seedance_2_0, cinematic_studio_3_0, or veo3_1). Use when the user wants a
  film-grade video clip with deliberate camera work, depth of field, or
  dramatic lighting. Handles image-to-video and text-to-video requests with
  full model-parameter assembly.
when_to_use: >-
  Use for feature-film look, golden-hour cinematography, dolly shots, rack
  focus, anamorphic lens style, or any request that mentions "cinematic",
  "film look", or "movie scene".
---
```

Key properties of this example:
- `name` is 20 chars, lowercase-hyphens, matches directory `higgsfield-cinematic/`
- `description` opens with the primary trigger ("Crafts cinematic video prompts")
- Explicit "Use when..." clause in `description`; more triggers in `when_to_use`
- Third person throughout
- No XML tags; no "anthropic" or "claude"

---

## 3. Lean SKILL.md Section Order

Target: **500-line hard cap** (official Claude Agent Skills recommendation). All content
beyond this limit moves to `references/` files. Reference files must be **one level deep**
from `SKILL.md` — do not chain references.

```markdown
---
name: higgsfield-<style>
description: [trigger-rich, third-person, ≤1024 chars, includes "Use when..." clause]
when_to_use: [overflow trigger terms, ≤(1536 - description_length) chars]
allowed-tools: mcp__higgsfield__generate_video mcp__higgsfield__generate_image
               mcp__higgsfield__models_explore mcp__higgsfield__job_status
               mcp__higgsfield__job_display mcp__higgsfield__media_upload
               mcp__higgsfield__media_confirm mcp__higgsfield__balance
---

# [Skill Title]

## What this skill does

[2–3 sentences. What creative style or use case it covers. What it outputs (prompt only,
or prompt + optional generation). Which Higgsfield models it routes to.]

## Model routing

[Which 2-4 models this skill recommends and the routing logic (e.g., "use
cinematic_studio_3_0 for genre-tagged requests; use seedance_2_0 for image-to-video
with audio"). Instruct Claude to call higgsfield:models_explore for live parameter
constraints before any generation call.]

## Prompt-building workflow

[Numbered steps:
1. Gather user intent (style, subject, mood, aspect ratio, duration)
2. Select model per routing table above
3. Build prompt using the craft principles in references/prompt-craft.md
4. Present prompt + assembled parameters to user for review]

## Opt-in generation

[Brief note: generation requires explicit user confirmation (credit cost). See
Generation workflow below. Point to shared/generation-flow.md for the canonical flow.]

See the full generation workflow in [../../shared/generation-flow.md](../../shared/generation-flow.md).

## Reference materials

- Prompt craft (camera, lighting, hooks, worked examples):
  [references/prompt-craft.md](references/prompt-craft.md)
- Model parameters for this skill:
  [references/model-specs.md](references/model-specs.md)

## Generation workflow (opt-in — costs Higgsfield credits)

Only proceed through these steps if the user explicitly confirms they want to generate.

**Step 1 — Verify live constraints**
Call `higgsfield:models_explore` with the target model to get current aspect ratios,
durations, and parameter options. Never use hardcoded values.

**Step 2 — Assemble parameters**
From models_explore output: pick `model`, `aspect_ratio`, `duration`, and any
model-specific params (e.g. `genre`). If user provides a local file, upload via
`higgsfield:media_upload` then confirm with `higgsfield:media_confirm`.

**Step 3 — Show cost and confirm**
Call `higgsfield:balance` to show remaining credits. Present all assembled parameters.
Ask for explicit confirmation before generating.

**Step 4 — Generate**
Call `higgsfield:generate_video` or `higgsfield:generate_image` with the assembled
parameters. Capture the returned `job_id`.

**Step 5 — Report result**
Call `higgsfield:job_display` with the `job_id`. If the job is pending, use
`higgsfield:job_status` to poll. Do NOT resubmit — poll the original job_id.
```

### Section order rules

1. **What this skill does** — always first in body (after frontmatter)
2. **Model routing** — second; determines which models this skill can activate
3. **Prompt-building workflow** — numbered steps; references heavy content in `references/`
4. **Opt-in generation** — brief pointer to the canonical flow; do not duplicate the full flow inline if the SKILL.md is already near the 500-line cap
5. **Reference materials** — list of `references/` files with relative links
6. **Generation workflow** — inline or pointer, depending on line budget

### Progressive disclosure rules

| Rule | Detail |
|------|--------|
| SKILL.md line cap | 500 lines hard cap (official recommendation) |
| Reference depth | One level deep only (`SKILL.md` → `references/file.md`). Do NOT chain. |
| Reference file ToC | Required for any reference file longer than ~100 lines |
| Reference file naming | Descriptive names: `prompt-craft.md`, `model-specs.md`, `examples.md` |
| Shared references | Point to `../../shared/model-catalog.md` and `../../shared/generation-flow.md` via relative path |

---

## 4. Common Mistakes to Avoid

| Mistake | Correct approach |
|---------|-----------------|
| `name: Higgsfield Cinematic` (uppercase/spaces) | `name: higgsfield-cinematic` |
| `name: seedance-cinematic` on a new multi-model skill | `name: higgsfield-cinematic` (drop `seedance-` prefix for new skills) |
| Duplicate `name` across two skills | Each skill has a unique `higgsfield-<style>` name |
| Per-platform reco table duplicated in both `SKILL.md` and `references/model-specs.md` | Keep the full table in `references/model-specs.md`; `SKILL.md` carries a one-line quick rule + pointer |
| Auto-switching to a fallback model without informing the user of its trade-offs | State the fallback's lost capabilities; switch only on explicit informed consent |
| First-person description: "I craft prompts..." | Third person: "Crafts prompts..." |
| Missing "Use when..." clause | Always include an explicit trigger clause in `description` or `when_to_use` |
| Hardcoded model specs in SKILL.md body | Use routing rationale only; call `higgsfield:models_explore` at generation time |
| Monolithic SKILL.md >500 lines | Move encyclopedic content to `references/*.md` |
| Chained references (`SKILL.md` → `A.md` → `B.md`) | All references one level from `SKILL.md` only |
| Unqualified tool name in prose: `models_explore` | Always qualify: `higgsfield:models_explore` |
| `mcp__higgsfield__tool_name` in prose | Use `mcp__...__` syntax ONLY in `allowed-tools` frontmatter; prose uses `higgsfield:tool_name` |
