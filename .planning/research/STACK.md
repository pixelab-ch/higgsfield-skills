# Stack Research

**Domain:** Claude Agent Skills — model-aware AI image/video generation via MCP
**Researched:** 2026-05-24
**Confidence:** HIGH (frontmatter spec, directory layout, MCP syntax) / MEDIUM (Claude Desktop path — see note)

---

## 1. SKILL.md Frontmatter Specification

Source: [code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills) + [platform.claude.com best-practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices) — verified 2026-05-24.

### Required fields

| Field | Required | Limit | Rules |
|-------|----------|-------|-------|
| `name` | Recommended (not strictly required — defaults to directory name) | 64 chars | Lowercase letters, numbers, hyphens only. No XML tags. Reserved words "anthropic" and "claude" forbidden. Must match the directory name when set. |
| `description` | Recommended | 1024 chars | Non-empty. No XML tags. Write in third person. Include what it does AND when to use it. Put key use case first — combined `description` + `when_to_use` is truncated to 1,536 chars in the skill listing. |

**Practical rule:** Always supply both `name` and `description`. Omitting `name` works but breaks explicit `/skill-name` invocation reliability.

### Optional frontmatter fields relevant to this project

| Field | Purpose | Use Here |
|-------|---------|----------|
| `when_to_use` | Extra trigger phrases appended to `description` in the listing. Counts toward the 1,536-char combined cap. | Yes — put overflow trigger terms here instead of bloating `description`. |
| `disable-model-invocation: true` | Prevents Claude from auto-loading the skill. Only user can invoke with `/name`. | Use for the generation step (e.g., a dedicated `/higgsfield-generate` command) — NOT for the prompt-crafting skills themselves which should auto-activate. |
| `user-invocable: false` | Hides from the `/` menu but still auto-loads when relevant. | Potentially for a shared `model-routing` reference skill. |
| `allowed-tools` | Pre-approves tools without per-use prompts. Format: space-separated tool names. | Useful if wrapping MCP calls inside a skill: `allowed-tools: mcp__higgsfield__generate_video mcp__higgsfield__generate_image` |
| `argument-hint` | Autocomplete hint shown for `/name` invocation. | Not needed for auto-invoked skills. |
| `context: fork` | Runs skill in isolated subagent context. | Avoid for these skills — the conversation history (model routing decision, confirmed prompt) must be visible. |
| `effort` | Override reasoning level. | Optional: set `effort: high` on the generation workflow skill to get careful parameter assembly. |

### Description writing rules (HIGH confidence)

1. Always third person: "Generates cinematic prompts..." not "I generate..."
2. Pack the key trigger terms in the first 100 chars (truncation risk at 1,536 combined)
3. Include explicit "Use when..." clause so Claude knows when to auto-activate
4. Current skills already follow this well — preserve the pattern

### Name constraints applied to this project

Current names like `seedance-cinematic`, `seedance-fight-scenes` are valid format but are misleading for the rearchitected multi-model version. New names should drop the `seedance-` prefix. Confirmed valid format: `cinematic-video`, `fight-scenes`, `anime-style`, `model-routing` etc.

---

## 2. Directory Layout (Verified)

Source: [code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills) — HIGH confidence.

### Per-skill layout

```
skills/
└── NN-skill-name/
    ├── SKILL.md              # Required. Max ~500 lines. Overview + workflow + model routing decision + references links.
    └── references/
        ├── prompt-craft.md   # Heavy encyclopedic content (camera, lighting, hooks, examples)
        ├── model-params.md   # Per-model parameter tables for THIS skill's recommended model(s)
        └── examples.md       # Worked prompt examples (optional separate file)
```

### Shared cross-skill reference

```
skills/
└── _shared/
    └── SKILL.md             # Or: use a user-invocable:false skill that auto-loads
        references/
        └── higgsfield-models.md   # Canonical model catalog — single source of truth
```

The `_shared` convention is not an official standard — it is just a directory Claude can be instructed to read from inside any skill's SKILL.md with an explicit relative path reference. There is no built-in "shared skill library" concept; the pattern is to reference the file explicitly.

### Official progressive disclosure rule (HIGH confidence)

- **SKILL.md body: 500 lines hard cap** (official recommendation). Move everything over this limit to `references/`.
- References must be **one level deep from SKILL.md** — do not chain (`SKILL.md` → `advanced.md` → `details.md`). Claude may do a partial read of doubly-nested files.
- Reference files longer than ~100 lines must have a table of contents at the top.
- Use descriptive file names: `prompt-craft-camera.md` not `doc2.md`.

### What SKILL.md must contain (for this project's pattern)

```markdown
---
name: cinematic-video
description: [trigger-rich description, 3rd person, ≤1024 chars]
when_to_use: [overflow trigger terms]
---

# [Skill title]

## What this skill does
[2–3 sentence overview]

## Model routing
[Which Higgsfield model(s) this skill recommends and why. Instruct Claude to call
mcp__higgsfield__models_explore for live parameter constraints before generation.]

## Prompt-building workflow
[Numbered steps: gather intent → build prompt → show to user → optionally generate]

## Opt-in generation (see Generation Workflow below)
[Brief note pointing to the generation workflow section]

## Reference materials
- Prompt craft (camera, lighting, hooks, examples): see [references/prompt-craft.md](references/prompt-craft.md)
- Model parameters for this skill: see [references/model-params.md](references/model-params.md)

## Generation workflow
[The opt-in MCP generation steps — see Section 5]
```

---

## 3. Install Locations and Paths

### Claude Code (HIGH confidence)

Source: [code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills)

| Scope | Path | Applies to |
|-------|------|-----------|
| Personal (user-global) | `~/.claude/skills/<skill-name>/SKILL.md` | All projects for this user |
| Project | `.claude/skills/<skill-name>/SKILL.md` | This repo only, committed to version control |

- **macOS personal:** `/Users/USERNAME/.claude/skills/`
- **Linux personal:** `/home/USERNAME/.claude/skills/`
- **Windows personal:** `C:\Users\USERNAME\.claude\skills\`

Live reload: edits to skills files take effect inside the current Claude Code session without restart. Creating a brand-new top-level `~/.claude/skills/` directory requires a restart.

### Claude Desktop (MEDIUM confidence — path verified from multiple sources, one open bug noted)

Source: Multiple sources agree on `~/.claude/skills/` as the shared path. The [GitHub issue #10927](https://github.com/anthropics/claude-code/issues/10927) documents a bug where a hardcoded Linux `/mnt/skills` path was used for Claude Desktop on macOS (reported 2025-10-31, claude-code v1.0.211). The fix resolution is not explicitly documented in the issue; however, all current community documentation from 2026 consistently states Claude Desktop uses the same `~/.claude/skills/` path as Claude Code.

**Conclusion:** Install to `~/.claude/skills/` for both Claude Code AND Claude Desktop on macOS. Do NOT use `~/Library/Application Support/Claude/skills/` or `~/.config/Claude/skills/` — these paths are not confirmed in any official documentation. The existing repo's install script targeting those paths was wrong.

**Install script must do:**
1. Create `~/.claude/skills/` if it does not exist
2. Copy or symlink each `skills/NN-name/` directory to `~/.claude/skills/<skill-name>/` (strip the `NN-` prefix in the installed name to match the `name:` frontmatter)
3. Verify SKILL.md exists at the target path
4. Print a confirmation message with the installed skill name and `/skill-name` invocation syntax
5. No separate Claude Desktop path needed — one install covers both surfaces

**Project-scoped alternative:** For distribution with the repo, commit skills to `.claude/skills/` at the repo root. This makes skills available to anyone who opens the repo in Claude Code without running an install script.

---

## 4. MCP Tool Invocation from Skills

### Idiomatic pattern (HIGH confidence)

Source: [platform.claude.com best-practices, "MCP tool references" section](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)

Skills instruct Claude via natural language. When a skill mentions an MCP tool, use the **fully qualified `ServerName:tool_name` format** to prevent "tool not found" errors when multiple MCP servers are present.

For the Higgsfield MCP server, the server name in Claude's tool list is `higgsfield`. The fully qualified format is:

```
higgsfield:generate_video
higgsfield:generate_image
higgsfield:models_explore
higgsfield:job_status
higgsfield:job_display
higgsfield:media_upload
higgsfield:media_confirm
higgsfield:presets_show
higgsfield:show_plans_and_credits
higgsfield:balance
higgsfield:select_workspace
```

**Important distinction:** `ServerName:tool_name` is the format used in skill prose instructions and in `allowed-tools` frontmatter. It is NOT the MCP wire format — it is how Claude Code's skill runtime resolves tool references in skill text.

### Opt-in generation workflow pattern for SKILL.md

The generation step must always be gated by explicit user confirmation (credit cost). The idiomatic pattern:

```markdown
## Generation workflow (opt-in, costs Higgsfield credits)

Only proceed through these steps if the user explicitly confirms they want to generate.

**Step 1 — Verify model constraints (always)**
Call `higgsfield:models_explore` with the target model name to get live parameters:
aspect ratios, durations, and any media roles. Never hardcode these values.

**Step 2 — Assemble parameters**
From the models_explore response, pick:
- `model`: [the skill's recommended model, e.g. "seedance_2_0"]
- `aspect_ratio`: user's preference or skill default
- `duration`: within model's declared range
- `prompt`: the prompt built in the prompt-building workflow above
- `input_files` (if provided): upload via `higgsfield:media_upload` first,
  then confirm with `higgsfield:media_confirm`, then pass the returned ID

**Step 3 — Confirm with user**
Show the assembled parameters and credit cost. Ask: "Lancer la génération ? (oui/non)"
Do NOT proceed without an affirmative response.

**Step 4 — Generate**
Call `higgsfield:generate_video` (or `higgsfield:generate_image` for image models)
with the assembled parameters. This returns a job_id.

**Step 5 — Report job**
Call `higgsfield:job_display` with the job_id to show the job status and result URL.
If the job is still running, call `higgsfield:job_status` to poll until complete.
```

### `allowed-tools` for generation skills

If a skill includes the generation workflow, pre-approve the tools to avoid mid-workflow permission prompts:

```yaml
allowed-tools: >-
  mcp__higgsfield__generate_video
  mcp__higgsfield__generate_image
  mcp__higgsfield__models_explore
  mcp__higgsfield__job_status
  mcp__higgsfield__job_display
  mcp__higgsfield__media_upload
  mcp__higgsfield__media_confirm
  mcp__higgsfield__balance
```

Note: The `allowed-tools` field in frontmatter uses the `mcp__ServerName__tool_name` syntax (with double underscores, matching Claude Code's internal tool naming). The prose instructions use `ServerName:tool_name` (with colon). Both refer to the same tool; the syntax differs by context.

---

## 5. Higgsfield MCP Tool Surface

Source: PROJECT.md (captured from live `models_explore` call, 2026-05-24) + [higgsfield.ai/mcp](https://higgsfield.ai/mcp) + [github.com/jfikrat/higgsfield-mcp](https://github.com/jfikrat/higgsfield-mcp). Confidence: MEDIUM (descriptions from official Higgsfield page; parameter schemas from PROJECT.md live capture; some tools like `media_confirm` not explicitly listed on public docs but referenced in PROJECT.md).

### Core generation tools

**`higgsfield:generate_image`**
- Purpose: Submit an image generation job
- Returns: `job_id`
- Key parameters (model-dependent — always call `models_explore` first):
  - `model` (required): e.g. "nano_banana", "soul_2", "flux_2", "gpt_image"
  - `prompt` (required): text prompt
  - `aspect_ratio`: from model's declared `aspect_ratios` list
  - `quality`: "720p" or "1080p" (model-dependent)
  - `input_files`: array of media IDs for models that accept reference images (roles: "image", "start_image")
  - `enhance_prompt`: boolean, default true
- Models: ~20 image models including nano_banana/_2/_pro, soul_2/soul_cinematic/soul_cast/soul_location, seedream_v4_5/v5_lite, z_image, flux_2/flux_kontext, kling_omni_image, gpt_image/gpt_image_2, grok_image, cinematic_studio_2_5, marketing_studio_image, ms_image, image_auto

**`higgsfield:generate_video`**
- Purpose: Submit a video generation job
- Returns: `job_id`
- Key parameters (model-dependent — always call `models_explore` first):
  - `model` (required): e.g. "seedance_2_0", "veo3", "kling3_0"
  - `prompt` (required): text prompt
  - `aspect_ratio`: from model's declared `aspect_ratios`
  - `duration`: integer within model's `duration_range` or from `durations` list
  - `input_files`: array of media IDs; roles vary by model (image, start_image, end_image, video, audio)
  - Model-specific params: e.g., `genre` for cinematic_studio_3_0, `mode` for some models
- Models: ~18 video models including seedance_2_0, seedance_1_5, minimax_hailuo, wan2_6, wan2_7, kling2_6, kling3_0, grok_video, veo3, veo3_1, veo3_1_lite, cinematic_studio_3_0, cinematic_studio_video (v1/v2), marketing_studio_video, higgsfield_preset

### Model discovery tools

**`higgsfield:models_explore`**
- Purpose: Return live model catalog with per-model parameter schemas
- Returns: For each model — its `parameters` (resolution/quality/mode/genre options), `aspect_ratios`, `durations`/`duration_range`, and media `roles` (image, start_image, end_image, video, audio)
- Usage: ALWAYS call this before generating. It is the source of truth for which parameters a given model accepts. Never hardcode model specs from training data — they drift as Higgsfield updates models.
- Call pattern: Can be called with a specific model name to get that model's schema, or without arguments to browse all models.

### Job tracking tools

**`higgsfield:job_status`**
- Purpose: Check status of a single job by job_id (no polling — one-shot check)
- Returns: status field ("pending", "running", "complete", "failed") + result URL when complete

**`higgsfield:job_display`**
- Purpose: Show/re-display job result with richer formatting; can paginate past generations
- Returns: Rendered job result with output URL, usable for display in conversation

### Media upload tools

**`higgsfield:media_upload`**
- Purpose: Upload a local file (image, video, audio) before passing it to generate_image or generate_video
- Returns: A pending media ID

**`higgsfield:media_confirm`**
- Purpose: Confirm a pending upload is complete and get the usable media ID
- Returns: Confirmed media ID for use in `input_files`
- Usage pattern: `media_upload` → `media_confirm` → use ID in generation call

### Preset tools

**`higgsfield:presets_show`**
- Purpose: List available generation presets (for `higgsfield_preset` video model)
- Usage: Call when user wants to use a preset-based workflow

### Account tools

**`higgsfield:show_plans_and_credits`**
- Purpose: Show available plan upgrades and one-time credit top-up options

**`higgsfield:balance`**
- Purpose: Show current credit balance
- Usage: Call before generation workflow to show user their remaining credits as part of the confirmation step

**`higgsfield:select_workspace`**
- Purpose: Switch between private and shared workspaces
- Usage: Situational; most users will have one workspace

---

## 6. Recommended Stack for This Project

### Core Technologies

| Technology | Version | Purpose | Why Recommended |
|------------|---------|---------|-----------------|
| Claude Agent Skills format | Current (2026) | Delivery vehicle for all 15+ skills | The only format that loads in both Claude Code and Claude Desktop; native progressive disclosure support |
| SKILL.md + references/ layout | — | Progressive disclosure | Official recommended pattern; keeps SKILL.md under 500 lines; reference files load on-demand |
| Higgsfield MCP server | Live (mcp.higgsfield.ai) | Generation API | Already present in user's environment; provides generate_image, generate_video, models_explore and all job/media/account tools |
| `higgsfield:models_explore` | — | Source of truth for model params | Per-model parameters are dynamic; hardcoding specs causes factual errors as Higgsfield updates models |

### Supporting Libraries / Conventions

| Convention | Purpose | When to Use |
|------------|---------|-------------|
| `ServerName:tool_name` syntax | Reference MCP tools in SKILL.md prose | Every MCP tool call instruction in skill body |
| `mcp__ServerName__tool_name` syntax | `allowed-tools` frontmatter field | When pre-approving tools to avoid per-use prompts |
| `disable-model-invocation: true` | Prevent auto-trigger | Generation-only skills (e.g., a standalone `/hf-generate` command) |
| Shared `_shared/higgsfield-models.md` | Canonical model routing table | Referenced from each skill's SKILL.md to avoid duplicating model lists |

### Development Tools

| Tool | Purpose | Notes |
|------|---------|-------|
| `install.sh` (rearchitected) | Deploy to `~/.claude/skills/` | Must target `~/.claude/skills/` for both Claude Code AND Desktop; drop the old `~/Library/Application Support/Claude/skills` path |
| Claude Code live reload | Test skill changes without restart | Edit SKILL.md → changes take effect immediately in running session |

---

## 7. What NOT to Use

| Avoid | Why | Use Instead |
|-------|-----|-------------|
| Monolithic SKILL.md (700–2300 lines) | Entire file loads into context on every invocation; burns tokens on content not needed for the current request | SKILL.md ≤500 lines + `references/` files loaded on demand |
| Hardcoded model specs in skill body | Specs drift as Higgsfield updates models; creates factual errors (e.g., the existing "4K 3840×2160" claim that doesn't match actual output) | Call `higgsfield:models_explore` at generation time; document only routing rationale in the skill |
| `~/Library/Application Support/Claude/skills` install path | Not confirmed in official docs; the existing repo's `install.sh` used this incorrectly | `~/.claude/skills/` — one path for both Claude Code and Claude Desktop |
| `~/.config/Claude/skills` install path | Not confirmed in any official documentation | `~/.claude/skills/` |
| Auto-generation without user confirmation | Spends Higgsfield credits without consent; explicitly excluded in PROJECT.md | Always gate generation behind explicit "oui/non" confirmation showing assembled parameters and credit cost |
| Deeply nested references (`SKILL.md` → `A.md` → `B.md`) | Claude does partial reads of doubly-nested files; critical content may be missed | All reference files one level deep from SKILL.md |
| Unqualified MCP tool names in skill prose | "Tool not found" errors when multiple MCP servers are active | Always use `higgsfield:tool_name` fully qualified format |
| zh-CN translations | Existing translations were 99% untranslated copies (only 28/2344 lines changed in worst case); they add bulk without value | EN + FR only (per PROJECT.md decision) |

---

## 8. Alternatives Considered

| Recommended | Alternative | Why Not |
|-------------|-------------|---------|
| `~/.claude/skills/` for both surfaces | Separate paths per surface | No official separate Desktop path exists; one path works for both |
| `references/` flat directory | Deeply nested `references/models/video/seedance/` etc. | Claude partial-reads deeply nested files; loses content; also harder to reference from SKILL.md |
| Per-skill `model-params.md` in `references/` | Single monolithic model catalog embedded in every skill | Unnecessary duplication; better to have a shared file + per-skill routing rationale |
| `context: fork` for generation workflow | Inline generation in main skill | Fork loses conversation history (the confirmed prompt, model choice); inline keeps context for the confirmation/generation loop |
| Prose workflow instructions for MCP tools | Custom scripts wrapping MCP calls | MCP tools are already available to Claude natively; scripts add complexity without benefit |

---

## Sources

- [code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills) — PRIMARY. Verified 2026-05-24. Frontmatter spec, directory layout, install paths, progressive disclosure limits, live reload behavior, MCP tool reference syntax. HIGH confidence.
- [platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices) — PRIMARY. Verified 2026-05-24. Description writing rules, 500-line cap, reference file depth, MCP `ServerName:tool_name` syntax, anti-patterns. HIGH confidence.
- [platform.claude.com/docs/en/agents-and-tools/agent-skills/overview](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview) — PRIMARY. Verified 2026-05-24. `name` and `description` field limits (64 / 1024 chars), three-level progressive disclosure model, cross-surface path table. HIGH confidence.
- [github.com/anthropics/claude-code/issues/10927](https://github.com/anthropics/claude-code/issues/10927) — macOS skills path bug (hardcoded `/mnt/skills` in Claude Desktop, v1.0.211, 2025-10-31). Confirms that `~/Library/Application Support/Claude/skills` is NOT the right path. MEDIUM confidence on current fix status.
- [higgsfield.ai/mcp](https://higgsfield.ai/mcp) — Higgsfield MCP tool listing (generate_image, generate_video, job_display, balance, show_plans_and_credits, select_workspace, virality_predictor). MEDIUM confidence (marketing page, no parameter schemas).
- [github.com/jfikrat/higgsfield-mcp](https://github.com/jfikrat/higgsfield-mcp) — Community MCP implementation. Tool name patterns and parameter shape. LOW-MEDIUM confidence (third-party, may not match official MCP exactly).
- `.planning/PROJECT.md` — Live `models_explore` capture (2026-05-24). Model catalog, tool list, parameter types. HIGH confidence for model names and tool names; MEDIUM for exact parameter schemas (captured at a point in time, will drift).

---

*Stack research for: Claude Agent Skills — Higgsfield multi-model generation toolkit*
*Researched: 2026-05-24*
