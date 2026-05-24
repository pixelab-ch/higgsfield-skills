<!-- GSD:project-start source:PROJECT.md -->

## Project

**Higgsfield Skills — Multi-Model Prompt & Generation Toolkit**

A collection of Claude Agent Skills that turn Claude into an expert prompt engineer for AI image and video generation on the **Higgsfield** platform. Each skill covers a creative style or use case (cinematic, anime, fight scenes, e-commerce ads, product 360°, real estate, etc.), produces a production-ready prompt, maps it to the most appropriate Higgsfield model, and can optionally submit the generation directly through the Higgsfield MCP server. It is the rearchitecture of the existing `higgsfield-seedance2-jineng` repo, which today only targets a single model (Seedance 2.0) and only outputs static prompt text.

**Core Value:** Given a creative request, Claude produces a model-correct, spec-accurate prompt and (on explicit confirmation) generates the asset on Higgsfield — without the user needing to know which of the ~38 Higgsfield models to pick or what parameters each accepts.

### Constraints

- **Platform**: Higgsfield only — all generation goes through the Higgsfield MCP server already present in the environment
- **Compatibility**: Must follow the Claude Agent Skills format (YAML frontmatter `name` + `description`; `SKILL.md` + optional `references/`) so skills load in both Claude Code and Desktop
- **Cost**: Generation consumes Higgsfield credits → never generate without explicit user confirmation
- **Accuracy**: Per-model specs must match what `models_explore` reports, not invented numbers
- **Languages**: English + French only
- **Source of truth for model constraints**: the live `models_explore` catalogue, not hardcoded assumptions that can drift

<!-- GSD:project-end -->

<!-- GSD:stack-start source:research/STACK.md -->

## Technology Stack

## 1. SKILL.md Frontmatter Specification

### Required fields

| Field | Required | Limit | Rules |
|-------|----------|-------|-------|
| `name` | Recommended (not strictly required — defaults to directory name) | 64 chars | Lowercase letters, numbers, hyphens only. No XML tags. Reserved words "anthropic" and "claude" forbidden. Must match the directory name when set. |
| `description` | Recommended | 1024 chars | Non-empty. No XML tags. Write in third person. Include what it does AND when to use it. Put key use case first — combined `description` + `when_to_use` is truncated to 1,536 chars in the skill listing. |

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

### Name constraints applied to this project

## 2. Directory Layout (Verified)

### Per-skill layout

### Shared cross-skill reference

### Official progressive disclosure rule (HIGH confidence)

- **SKILL.md body: 500 lines hard cap** (official recommendation). Move everything over this limit to `references/`.
- References must be **one level deep from SKILL.md** — do not chain (`SKILL.md` → `advanced.md` → `details.md`). Claude may do a partial read of doubly-nested files.
- Reference files longer than ~100 lines must have a table of contents at the top.
- Use descriptive file names: `prompt-craft-camera.md` not `doc2.md`.

### What SKILL.md must contain (for this project's pattern)

# [Skill title]

## What this skill does

## Model routing

## Prompt-building workflow

## Opt-in generation (see Generation Workflow below)

## Reference materials

- Prompt craft (camera, lighting, hooks, examples): see [references/prompt-craft.md](references/prompt-craft.md)
- Model parameters for this skill: see [references/model-params.md](references/model-params.md)

## Generation workflow

## 3. Install Locations and Paths

### Claude Code (HIGH confidence)

| Scope | Path | Applies to |
|-------|------|-----------|
| Personal (user-global) | `~/.claude/skills/<skill-name>/SKILL.md` | All projects for this user |
| Project | `.claude/skills/<skill-name>/SKILL.md` | This repo only, committed to version control |

- **macOS personal:** `/Users/USERNAME/.claude/skills/`
- **Linux personal:** `/home/USERNAME/.claude/skills/`
- **Windows personal:** `C:\Users\USERNAME\.claude\skills\`

### Claude Desktop (MEDIUM confidence — path verified from multiple sources, one open bug noted)

## 4. MCP Tool Invocation from Skills

### Idiomatic pattern (HIGH confidence)

### Opt-in generation workflow pattern for SKILL.md

## Generation workflow (opt-in, costs Higgsfield credits)

- `model`: [the skill's recommended model, e.g. "seedance_2_0"]
- `aspect_ratio`: user's preference or skill default
- `duration`: within model's declared range
- `prompt`: the prompt built in the prompt-building workflow above
- `input_files` (if provided): upload via `higgsfield:media_upload` first,

### `allowed-tools` for generation skills

## 5. Higgsfield MCP Tool Surface

### Core generation tools

- Purpose: Submit an image generation job
- Returns: `job_id`
- Key parameters (model-dependent — always call `models_explore` first):
- Models: ~20 image models including nano_banana/_2/_pro, soul_2/soul_cinematic/soul_cast/soul_location, seedream_v4_5/v5_lite, z_image, flux_2/flux_kontext, kling_omni_image, gpt_image/gpt_image_2, grok_image, cinematic_studio_2_5, marketing_studio_image, ms_image, image_auto
- Purpose: Submit a video generation job
- Returns: `job_id`
- Key parameters (model-dependent — always call `models_explore` first):
- Models: ~18 video models including seedance_2_0, seedance_1_5, minimax_hailuo, wan2_6, wan2_7, kling2_6, kling3_0, grok_video, veo3, veo3_1, veo3_1_lite, cinematic_studio_3_0, cinematic_studio_video (v1/v2), marketing_studio_video, higgsfield_preset

### Model discovery tools

- Purpose: Return live model catalog with per-model parameter schemas
- Returns: For each model — its `parameters` (resolution/quality/mode/genre options), `aspect_ratios`, `durations`/`duration_range`, and media `roles` (image, start_image, end_image, video, audio)
- Usage: ALWAYS call this before generating. It is the source of truth for which parameters a given model accepts. Never hardcode model specs from training data — they drift as Higgsfield updates models.
- Call pattern: Can be called with a specific model name to get that model's schema, or without arguments to browse all models.

### Job tracking tools

- Purpose: Check status of a single job by job_id (no polling — one-shot check)
- Returns: status field ("pending", "running", "complete", "failed") + result URL when complete
- Purpose: Show/re-display job result with richer formatting; can paginate past generations
- Returns: Rendered job result with output URL, usable for display in conversation

### Media upload tools

- Purpose: Upload a local file (image, video, audio) before passing it to generate_image or generate_video
- Returns: A pending media ID
- Purpose: Confirm a pending upload is complete and get the usable media ID
- Returns: Confirmed media ID for use in `input_files`
- Usage pattern: `media_upload` → `media_confirm` → use ID in generation call

### Preset tools

- Purpose: List available generation presets (for `higgsfield_preset` video model)
- Usage: Call when user wants to use a preset-based workflow

### Account tools

- Purpose: Show available plan upgrades and one-time credit top-up options
- Purpose: Show current credit balance
- Usage: Call before generation workflow to show user their remaining credits as part of the confirmation step
- Purpose: Switch between private and shared workspaces
- Usage: Situational; most users will have one workspace

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

## 8. Alternatives Considered

| Recommended | Alternative | Why Not |
|-------------|-------------|---------|
| `~/.claude/skills/` for both surfaces | Separate paths per surface | No official separate Desktop path exists; one path works for both |
| `references/` flat directory | Deeply nested `references/models/video/seedance/` etc. | Claude partial-reads deeply nested files; loses content; also harder to reference from SKILL.md |
| Per-skill `model-params.md` in `references/` | Single monolithic model catalog embedded in every skill | Unnecessary duplication; better to have a shared file + per-skill routing rationale |
| `context: fork` for generation workflow | Inline generation in main skill | Fork loses conversation history (the confirmed prompt, model choice); inline keeps context for the confirmation/generation loop |
| Prose workflow instructions for MCP tools | Custom scripts wrapping MCP calls | MCP tools are already available to Claude natively; scripts add complexity without benefit |

## Sources

- [code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills) — PRIMARY. Verified 2026-05-24. Frontmatter spec, directory layout, install paths, progressive disclosure limits, live reload behavior, MCP tool reference syntax. HIGH confidence.
- [platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices) — PRIMARY. Verified 2026-05-24. Description writing rules, 500-line cap, reference file depth, MCP `ServerName:tool_name` syntax, anti-patterns. HIGH confidence.
- [platform.claude.com/docs/en/agents-and-tools/agent-skills/overview](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview) — PRIMARY. Verified 2026-05-24. `name` and `description` field limits (64 / 1024 chars), three-level progressive disclosure model, cross-surface path table. HIGH confidence.
- [github.com/anthropics/claude-code/issues/10927](https://github.com/anthropics/claude-code/issues/10927) — macOS skills path bug (hardcoded `/mnt/skills` in Claude Desktop, v1.0.211, 2025-10-31). Confirms that `~/Library/Application Support/Claude/skills` is NOT the right path. MEDIUM confidence on current fix status.
- [higgsfield.ai/mcp](https://higgsfield.ai/mcp) — Higgsfield MCP tool listing (generate_image, generate_video, job_display, balance, show_plans_and_credits, select_workspace, virality_predictor). MEDIUM confidence (marketing page, no parameter schemas).
- [github.com/jfikrat/higgsfield-mcp](https://github.com/jfikrat/higgsfield-mcp) — Community MCP implementation. Tool name patterns and parameter shape. LOW-MEDIUM confidence (third-party, may not match official MCP exactly).
- `.planning/PROJECT.md` — Live `models_explore` capture (2026-05-24). Model catalog, tool list, parameter types. HIGH confidence for model names and tool names; MEDIUM for exact parameter schemas (captured at a point in time, will drift).

<!-- GSD:stack-end -->

<!-- GSD:conventions-start source:CONVENTIONS.md -->

## Conventions

Conventions not yet established. Will populate as patterns emerge during development.
<!-- GSD:conventions-end -->

<!-- GSD:architecture-start source:ARCHITECTURE.md -->

## Architecture

Architecture not yet mapped. Follow existing patterns found in the codebase.
<!-- GSD:architecture-end -->

<!-- GSD:skills-start source:skills/ -->

## Project Skills

No project skills found. Add skills to any of: `.claude/skills/`, `.agents/skills/`, `.cursor/skills/`, `.github/skills/`, or `.codex/skills/` with a `SKILL.md` index file.
<!-- GSD:skills-end -->

<!-- GSD:workflow-start source:GSD defaults -->

## GSD Workflow Enforcement

Before using Edit, Write, or other file-changing tools, start work through a GSD command so planning artifacts and execution context stay in sync.

Use these entry points:

- `/gsd:quick` for small fixes, doc updates, and ad-hoc tasks
- `/gsd:debug` for investigation and bug fixing
- `/gsd:execute-phase` for planned phase work

Do not make direct repo edits outside a GSD workflow unless the user explicitly asks to bypass it.
<!-- GSD:workflow-end -->

<!-- GSD:profile-start -->

## Developer Profile

> Profile not yet configured. Run `/gsd:profile-user` to generate your developer profile.
> This section is managed by `generate-claude-profile` -- do not edit manually.
<!-- GSD:profile-end -->
