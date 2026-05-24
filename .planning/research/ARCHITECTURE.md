# Architecture Research

**Domain:** Claude Agent Skills repo for AI image/video generation (Higgsfield multi-model)
**Researched:** 2026-05-24
**Confidence:** HIGH — primary sources are the official Claude Agent Skills docs and Claude Code skills docs, cross-checked against the live repo

---

## Standard Architecture

### System Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          REPOSITORY ROOT                                     │
│  README.md · README.fr.md · LICENSE · install.sh · assets/                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                       SHARED REFERENCES (repo-level)                         │
│  shared/                                                                     │
│  ├── model-catalog.md      ← canonical model list, routing rules            │
│  ├── generation-flow.md    ← opt-in generate → poll → display flow          │
│  └── mcp-tools.md          ← tool signatures, credit-cost notes             │
├─────────────────────────────────────────────────────────────────────────────┤
│                           SKILL LAYER (×15)                                  │
│  skills/                                                                     │
│  ├── 01-cinematic/                                                           │
│  │   ├── SKILL.md               ← lean entry (~200-300 lines)               │
│  │   ├── fr/SKILL.md            ← French mirror                             │
│  │   └── references/                                                         │
│  │       ├── camera.md          ← camera encyclopedia                       │
│  │       ├── hooks.md           ← 2-sec hook library                        │
│  │       ├── examples.md        ← worked prompts                            │
│  │       └── model-specs.md     ← per-model spec tables for this skill      │
│  ├── 02-3d-cgi/                                                              │
│  │   └── ...                                                                 │
│  └── 15-real-estate/                                                         │
│      └── ...                                                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                        RUNTIME ENVIRONMENT                                   │
│  Claude Code (~/.claude/skills/)  │  Claude Desktop (OS-specific path)      │
│  Full network + filesystem access │  Sandboxed; no network                  │
│  MCP tools available              │  MCP tools if configured                │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Component Responsibilities

| Component | Responsibility | Communicates With |
|-----------|---------------|-------------------|
| `shared/model-catalog.md` | Single source of truth for all ~38 models, their parameter sets, aspect ratios, durations, media roles. Updated when `models_explore` reveals changes. | All 15 SKILL.md files reference it; generation-flow uses model ID from it |
| `shared/generation-flow.md` | Canonical opt-in generation workflow (resolve → confirm + credit cost → generate → poll → display). Used by all skills to avoid duplicating 50+ lines of flow logic. | Each SKILL.md links to it in its "Generate" section |
| `shared/mcp-tools.md` | Fully-qualified MCP tool names (`higgsfield:generate_image`, `higgsfield:generate_video`, `higgsfield:job_status`, `higgsfield:job_display`, `higgsfield:balance`, `higgsfield:media_upload`, `higgsfield:media_confirm`, `higgsfield:models_explore`). Includes tool signatures and credit-cost reminders. | Referenced from generation-flow.md and per-skill model-specs.md |
| `skills/NN-name/SKILL.md` (EN) | Lean entry point (<= 300 lines). YAML frontmatter, overview, when-to-use, model routing summary (which models apply), generation workflow pointer, and links to references/. | Loads references/ on demand. Points to shared/ for flow and catalog. |
| `skills/NN-name/fr/SKILL.md` | French translation of the EN SKILL.md. Same structure, same references/ pointers (references/ files are EN only — see i18n section). | Same as EN SKILL.md |
| `skills/NN-name/references/camera.md` | Per-skill camera encyclopedia (15-20+ techniques with exact prompt phrasing). Not loaded until Claude needs it. | Loaded by SKILL.md on demand |
| `skills/NN-name/references/hooks.md` | Per-skill 2-second hook library. Rich examples, not loaded at startup. | Loaded by SKILL.md on demand |
| `skills/NN-name/references/examples.md` | 5+ worked example prompts (production-quality, 15-25 lines each). | Loaded by SKILL.md on demand |
| `skills/NN-name/references/model-specs.md` | Spec tables for the 2-4 models relevant to this skill (resolution, aspect ratios, durations, supported media roles). Cached from models_explore; includes a runtime-verification note. | Loaded by SKILL.md when user asks about parameters or when generating |
| `install.sh` | Interactive/--all/--list installer. Detects Claude Code vs Desktop paths, installs EN or FR skill, idempotent. | Reads skills/ directory; writes to OS-specific skills path |

---

## Recommended Project Structure

```
repo-root/
├── README.md                    # EN — accurate description of new structure
├── README.fr.md                 # FR — mirrors README.md
├── LICENSE                      # Must exist (currently missing)
├── install.sh                   # Revised installer (Code + Desktop, EN + FR)
├── assets/
│   ├── banner.svg
│   └── skill-map.svg
├── shared/                      # Shared references (not a Skill directory)
│   ├── model-catalog.md         # ~38 models, routing matrix, last-verified date
│   ├── generation-flow.md       # Opt-in generation workflow (all 15 skills use)
│   └── mcp-tools.md             # Fully-qualified tool names + signatures
└── skills/
    ├── 01-cinematic/
    │   ├── SKILL.md             # EN entry point, ~200-300 lines
    │   ├── fr/
    │   │   └── SKILL.md         # FR entry point, same length target
    │   └── references/
    │       ├── camera.md
    │       ├── hooks.md
    │       ├── examples.md
    │       └── model-specs.md
    ├── 02-3d-cgi/
    │   └── ...                  # same pattern
    ├── 03-cartoon/
    ├── 04-comic-to-video/
    ├── 05-fight-scenes/
    ├── 06-motion-design-ad/
    ├── 07-ecommerce-ad/
    ├── 08-anime-action/
    ├── 09-product-360/
    ├── 10-music-video/
    ├── 11-social-hook/
    ├── 12-brand-story/
    ├── 13-fashion-lookbook/
    ├── 14-food-beverage/
    └── 15-real-estate/
        ├── SKILL.md
        ├── fr/SKILL.md
        └── references/
            ├── camera.md        # Aerial, Steadicam, drone techniques
            ├── hooks.md         # 12+ real-estate-specific 2-sec hooks
            ├── examples.md      # Luxury, urban, commercial worked prompts
            └── model-specs.md   # seedance_2_0, cinematic_studio_3_0, etc.
```

### Structure Rationale

- **`shared/`**: Not a Skill directory (no SKILL.md). Lives at repo root to be installable alongside skills/ and referenced from any skill. Critical for avoiding duplication of model routing and generation flow logic across 15 files.
- **`references/` inside each skill**: Follows the official Agent Skills pattern exactly. Claude Code reads these only when the skill activates and needs them — no startup token cost. One level deep from SKILL.md (never references/deep/nested/) per the "avoid deeply nested references" best practice.
- **`fr/SKILL.md`**: Language-mirror approach, separate file per skill. Preferred over single-file frontmatter i18n (see i18n architecture section).
- **No `zh-CN/`**: Dropped. Existing translations were 99% untranslated copies.
- **`assets/` at root**: SVG assets stay at root, not inside skills (not part of skill content).

---

## Architectural Patterns

### Pattern 1: Lean SKILL.md with Reference Pointers

**What:** SKILL.md stays under 300 lines and serves as a navigation index. All encyclopedic content (camera techniques, hook library, worked examples) lives in `references/`. Claude reads those files only when the user needs them.

**When to use:** Every skill. This is the Agent Skills progressive disclosure model.

**Trade-offs:** Pro: 140x context efficiency at startup vs loading everything. Con: Claude must read a second file when it needs reference content — adds one bash read. This is fine; the official pattern explicitly supports it.

**Target sizes:**
- SKILL.md body: 200–300 lines (well under the 500-line official limit)
- references/camera.md: 150-250 lines
- references/hooks.md: 100-150 lines
- references/examples.md: 150-250 lines (5+ full prompts)
- references/model-specs.md: 60-100 lines

**Example SKILL.md structure:**
```markdown
---
name: higgsfield-real-estate
description: Generate real estate, architecture, and interior design video and image
  prompts on Higgsfield. Use when the user wants property tours, listing videos,
  architectural showcases, interior design content, or any real-estate video/image.
  Triggers: real estate, property, house, apartment, architecture, interior, tour,
  listing, virtual tour, renovation, home staging.
---

# Real Estate & Architecture — Higgsfield Skills

## What this skill does
[2-3 sentences]

## Model routing
| Goal | Primary model | Fallback |
|------|--------------|---------|
| Photorealistic property tour | seedance_2_0 | cinematic_studio_3_0 |
| Luxury image hero shot | soul_cinematic | nano_banana_pro |
| Fast draft / iterate | seedance_1_5 | — |

→ Full parameter specs: [references/model-specs.md](references/model-specs.md)

## Generation workflow
→ [shared/generation-flow.md](../../shared/generation-flow.md)

## Prompt engineering
→ Camera techniques: [references/camera.md](references/camera.md)
→ 2-second hook library: [references/hooks.md](references/hooks.md)
→ Worked examples: [references/examples.md](references/examples.md)

## Quick start
[3-5 step workflow directly in SKILL.md]
```

### Pattern 2: Shared Generation Flow (Single Source, Referenced)

**What:** One `shared/generation-flow.md` documents the full opt-in generation handoff. Every SKILL.md links to it. The flow itself is never duplicated.

**When to use:** Any time a skill needs to offer generation. All 15 skills.

**Trade-offs:** Pro: update generation flow in one place, all 15 skills benefit. Con: cross-directory relative links (`../../shared/generation-flow.md`) are slightly verbose. This works correctly because Claude Code resolves paths relative to the SKILL.md file location.

**The flow (documented in shared/generation-flow.md):**
```
User request
    ↓
1. Resolve model
   → Read model-specs.md for this skill
   → Match user goal to model routing table
   → If ambiguous, ask user to clarify
    ↓
2. Build prompt
   → Apply skill-specific prompt engineering
   → Validate params against model constraints (aspect ratio, duration, media roles)
    ↓
3. Confirm before generating [REQUIRED]
   → Show: model selected, prompt, key params, estimated credit cost
   → Call higgsfield:balance to show current credits if user asks
   → Wait for explicit user YES
    ↓
4. Submit generation
   → higgsfield:generate_image or higgsfield:generate_video
   → Capture job_id from response
    ↓
5. Poll job status
   → higgsfield:job_status with job_id
   → Retry up to N times with backoff (30-60s between checks)
    ↓
6. Display result
   → higgsfield:job_display when status = complete
   → Report job_id and asset URL to user
```

**Critical constraint:** Never call generate_image/generate_video without explicit user confirmation. This is the only blocking rule in the flow.

### Pattern 3: Hybrid Model Spec Strategy (Cached Reference + Runtime Verification)

**What:** `references/model-specs.md` contains pre-cached spec tables (captured from `models_explore` at authoring time, with a "last verified" date). The file also contains a directive: "If the user's parameters seem wrong or the generation fails, call `higgsfield:models_explore` to get the current spec and compare."

**When to use:** All skills. Avoids context-expensive live API calls on every invocation while protecting against spec drift.

**Trade-offs:**
- Pure hardcoded: Fast, no API call. Risk: drifts as Higgsfield updates models.
- Pure runtime `models_explore`: Always current. Cost: one extra MCP call per generation, adds latency, consumes context.
- Hybrid (recommended): Cached specs for normal flow. Runtime call only when something looks wrong or when the user explicitly asks "what are the current limits?"

**model-specs.md format:**
```markdown
# Model Specs for Real Estate Skill
_Last verified: 2026-05-24 via models_explore. If params fail, call models_explore to refresh._

## seedance_2_0
- **Resolution**: 720p
- **Aspect ratios**: 16:9, 9:16, 1:1, 4:3, 3:4
- **Duration**: 4–15s
- **Media roles**: image (start_image), video, audio
- **Input limits**: ≤9 images, ≤3 videos, ≤3 audio, ≤12 total

## cinematic_studio_3_0
- **Resolution**: [from models_explore]
- **Aspect ratios**: [from models_explore]
- ...
```

### Pattern 4: Cross-Skill Reference Decision — Shared Files, Not Cross-Skill

**What:** Shared concerns (model catalog, generation flow) live in `shared/` at repo root, not inside any skill directory. No skill ever references another skill's SKILL.md.

**Why:** Claude Code loads skills independently. A skill cannot guarantee another skill is installed or at a known path. Cross-skill references fail silently when the referenced skill is absent. The `shared/` directory solves the duplication problem without creating a dependency between skills.

**Install implication:** `install.sh` must copy the `shared/` directory alongside skill directories (or install it to a known sibling path). Skills reference shared files with relative paths (e.g., `../../shared/generation-flow.md` from `skills/01-cinematic/SKILL.md`). This works if both `skills/` and `shared/` are siblings in the install target.

**Alternative considered (rejected):** A "core" skill (e.g., `00-higgsfield-core`) that all other skills reference. Rejected because:
1. Claude Code has no mechanism for one skill to depend on another being loaded first.
2. If a user installs only skill 01, they still need core to work, but there's no guarantee it was installed.
3. The shared/ approach with relative-path references is simpler and avoids the dependency problem.

---

## Data Flow

### Generation Handoff Flow

```
User request (natural language)
    ↓
Claude reads SKILL.md (triggered by description match)
    ↓
Claude reads references/model-specs.md
  (to check which models apply and their constraints)
    ↓
Claude constructs prompt + selects model
    ↓
Claude presents to user:
  - Draft prompt text
  - Model: [name]
  - Params: [aspect ratio, duration, media refs]
  - Estimated credits: [N] (from balance if available)
  - "Shall I generate? (yes/no)"
    ↓
User confirms YES
    ↓
Claude calls higgsfield:generate_image or higgsfield:generate_video
  with validated params
    ↓
Claude captures job_id
    ↓
Claude polls higgsfield:job_status until complete
    ↓
Claude calls higgsfield:job_display
    ↓
Claude reports result + job_id to user
```

### Context Loading Flow (Progressive Disclosure)

```
Session startup
    ↓
Only SKILL.md frontmatter (name + description) loaded for all installed skills
  Token cost: ~100 tokens × N skills
    ↓
User says "real estate video"
    ↓
Claude reads skills/15-real-estate/SKILL.md (~300 lines)
  Token cost: ~1,500 tokens
    ↓
User needs camera technique details
    ↓
Claude reads skills/15-real-estate/references/camera.md (~200 lines)
  Token cost: ~1,000 tokens
    ↓
User says "generate it"
    ↓
Claude reads shared/generation-flow.md (once per session)
  Token cost: ~800 tokens
    ↓
Total: ~3,400 tokens vs ~11,000 tokens for a monolith approach
```

### Model Resolution Flow

```
User goal (e.g., "photorealistic property walkthrough")
    ↓
Read skill's model routing table (in SKILL.md)
    ↓
Primary model selected (e.g., seedance_2_0)
    ↓
Read model-specs.md: validate duration, aspect ratio, media role
    ↓
Params conflict? → Adjust to model constraints, explain to user
    ↓
Generation fails with param error?
    → Call higgsfield:models_explore to get current spec
    → Re-validate and retry once
    ↓
Params valid → proceed to confirmation step
```

---

## i18n Architecture

### Decision: Separate FR File per Skill (`fr/SKILL.md`)

**Pattern:** Each skill has `SKILL.md` (EN) and `fr/SKILL.md` (FR). The `fr/` subdirectory is inside the skill directory.

```
skills/01-cinematic/
├── SKILL.md            # EN
├── fr/
│   └── SKILL.md        # FR
└── references/
    └── *.md            # EN only (references are not translated)
```

**Why separate files, not frontmatter or single-file i18n:**
- Agent Skills have no built-in i18n mechanism. The frontmatter spec has no language field.
- Claude Code discovers skills by finding directories containing SKILL.md. It cannot select between two skills in the same directory based on user language.
- Separate directories (`fr/`) work exactly like the existing `zh-CN/` pattern (which the old repo used), but Claude automatically selects language based on conversation — it doesn't need two files loaded simultaneously.
- References are kept in EN only: encyclopedic content (camera techniques, hooks, examples) works fine in EN even for FR users; translating them adds maintenance burden for marginal value.

**How Claude selects language:** Claude detects the user's language from conversation context and selects the appropriate SKILL.md. The install script offers to install EN, FR, or both. When both are installed, Claude should prefer the user's language.

**Install path for FR:**
- Claude Code: `~/.claude/skills/01-cinematic-fr/SKILL.md` (separate skill name to avoid collision)
- Or: both EN and FR installed at same skill path if they have different `name` values in frontmatter

**Frontmatter name convention:**
```yaml
# EN
name: higgsfield-real-estate
# FR
name: higgsfield-real-estate-fr
```

This ensures both can coexist in Claude's skill registry without name collision.

---

## Install Architecture

### Current Install Script Problems

The current `install.sh` exclusively targets the Claude Desktop path (`~/Library/Application Support/Claude/skills` on macOS). Claude Code uses `~/.claude/skills/`. These are different directories.

### Revised Install Architecture

**Targets:**
1. Claude Code personal: `~/.claude/skills/<skill-name>/`
2. Claude Code project: `.claude/skills/<skill-name>/` (in current git repo)
3. Claude Desktop (macOS): `~/Library/Application Support/Claude/skills/<skill-name>/`
4. Claude Desktop (Linux): `~/.config/Claude/skills/<skill-name>/`

**Flags:**
```
./install.sh              # Interactive (default)
./install.sh --all        # Install all EN skills
./install.sh --all --fr   # Install all FR skills (alongside or instead of EN)
./install.sh --list       # List available skills with descriptions
./install.sh --target code    # Force Claude Code path
./install.sh --target desktop # Force Claude Desktop path
./install.sh --target project # Install to .claude/skills/ in current dir
```

**Idempotency:** When a skill directory already exists at the target path, the script checks if it's the same version (compare a VERSION or checksum). If same: skip. If older: prompt to overwrite or auto-overwrite with `--force`.

**Shared directory handling:** `install.sh` copies `shared/` to a sibling location of the installed skills so relative paths (`../../shared/`) resolve correctly. For `~/.claude/skills/`, shared goes to `~/.claude/shared/`.

**Windows:** The current script exits with an error on Windows. The revised script should:
- Detect PowerShell/MSYS/Cygwin
- Print the correct target path: `%APPDATA%\Claude\skills\`
- Optionally provide a `install.ps1` for native Windows support

**Bash best practice:** Use `SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"` rather than `$(dirname "$0")` which breaks if the script is called from a different directory.

---

## Anti-Patterns

### Anti-Pattern 1: Monolithic SKILL.md

**What people do:** Put every hook, camera technique, worked example, and spec table directly in SKILL.md (existing 700–2344 line files).

**Why it's wrong:** Every line in SKILL.md loads into context when the skill activates. A 2344-line skill costs ~11,700 tokens every time it runs, even if the user only wants a quick prompt without detailed camera examples.

**Do this instead:** Move encyclopedic content to `references/`. Keep SKILL.md as a navigation index. Target 200–300 lines.

### Anti-Pattern 2: Hardcoded Model Specs Without Verification Directive

**What people do:** Copy exact spec numbers from the API into markdown and never update them (existing files say "4K 3840×2160" and ".webm output" — both wrong for Seedance 2.0 which outputs 720p MP4).

**Why it's wrong:** Higgsfield updates models without notice. Wrong specs cause generation failures or incorrect prompts that the user discovers after spending credits.

**Do this instead:** Use the hybrid approach: cached specs with a "last verified" date and a directive to call `models_explore` on failure.

### Anti-Pattern 3: Cross-Skill SKILL.md References

**What people do:** Skill A says "see Skill B for camera techniques" and links to another skill's SKILL.md.

**Why it's wrong:** Skills install independently. Skill B may not be installed. The link resolves to a missing file. Claude silently loses the referenced content.

**Do this instead:** Put shared content in `shared/` at repo root, or duplicate small pieces inside each skill's `references/`.

### Anti-Pattern 4: Deeply Nested References

**What people do:** `SKILL.md` → `references/advanced.md` → `references/details/deep.md`.

**Why it's wrong:** Claude may read only the top of nested files (using `head -100` when previewing), missing the actual content that lives deeper in the chain.

**Do this instead:** All reference files link directly from SKILL.md. Maximum one hop from SKILL.md to any content.

### Anti-Pattern 5: Auto-generation Without Confirmation

**What people do:** Skill builds a prompt and immediately calls `generate_video` in the same turn.

**Why it's wrong:** Generation consumes Higgsfield credits. The user must explicitly confirm. Out of scope (defined in PROJECT.md).

**Do this instead:** Always present the prompt, model, params, and cost estimate; wait for explicit YES before calling generate_image/generate_video.

### Anti-Pattern 6: Generating Without Fully Qualified MCP Tool Names

**What people do:** Instructions say "call generate_video" without the server prefix.

**Why it's wrong:** When multiple MCP servers are configured, Claude fails to locate the tool without the server prefix.

**Do this instead:** Always use `higgsfield:generate_video`, `higgsfield:generate_image`, `higgsfield:job_status`, etc. Document these in `shared/mcp-tools.md`.

---

## Integration Points

### External Services

| Service | Integration Pattern | Notes |
|---------|---------------------|-------|
| Higgsfield MCP server | Fully-qualified tool calls (`higgsfield:*`) in generation flow | Already configured in user's environment. Claude Code has full network access. Skills reference shared/mcp-tools.md for tool signatures. |
| `higgsfield:models_explore` | Runtime verification (hybrid pattern) | Called only on param failure or explicit user request, not on every invocation |
| `higgsfield:balance` | Optional pre-generation check | Call when user asks about credits or wants to know cost before confirming |
| `higgsfield:media_upload` + `higgsfield:media_confirm` | Two-step upload before referencing local media in prompts | Required when user provides local image/video files |

### Internal Boundaries

| Boundary | Communication | Notes |
|----------|---------------|-------|
| SKILL.md ↔ references/ | Direct markdown link (`[text](references/file.md)`); Claude reads via bash | One level deep only |
| SKILL.md ↔ shared/ | Relative path link (`../../shared/generation-flow.md`); Claude reads via bash | Works if shared/ is sibling to skills/ in install location |
| EN SKILL.md ↔ FR SKILL.md | No direct link — independent files with same content structure | Both reference same references/ (EN) |
| skills/ ↔ install.sh | install.sh reads skills/ directory to discover installable skills | Name and description extracted from SKILL.md frontmatter |

---

## Suggested Build Order

Dependencies are clear: shared components must exist before per-skill files reference them, and generation flow must be documented before per-skill opt-in sections can link to it.

### Phase 1: Foundation (Shared Infrastructure)
**Build first. Everything else depends on these.**

1. `shared/model-catalog.md` — Run `models_explore`, capture all ~38 models with their parameter sets. This is the ground truth for all per-skill routing tables.
2. `shared/mcp-tools.md` — Document fully-qualified tool names, signatures, and credit-cost notes.
3. `shared/generation-flow.md` — Define the canonical opt-in flow (resolve → confirm → generate → poll → display). All 15 skills will link to this.
4. LICENSE — Must exist before any skill references it.

### Phase 2: SKILL.md Template and One Pilot Skill
**Build the pattern before multiplying it.**

5. Define the lean SKILL.md template: frontmatter fields, section order, reference link conventions, model routing table format, FR fr/ subdirectory structure.
6. Refactor one skill as the pilot (recommend `01-cinematic` — smallest at 1329 lines, broad appeal, easy to verify). This establishes the pattern for all 14 remaining.
   - Write EN SKILL.md (~250 lines)
   - Write FR fr/SKILL.md (same structure)
   - Extract references/camera.md, references/hooks.md, references/examples.md, references/model-specs.md
   - Verify links resolve and Claude navigates them correctly

### Phase 3: Remaining Skills (Bulk Refactor)
**Apply the pattern established in Phase 2.**

7. Refactor skills 02–14 using the pilot as the template. Order by complexity (simpler first to validate the pattern):
   - Simple styles first: 03-cartoon, 04-comic-to-video, 08-anime-action
   - Commercial skills next: 06-motion-design-ad, 07-ecommerce-ad, 09-product-360, 11-social-hook
   - Industry-specific last (most encyclopedic content): 05-fight-scenes, 10-music-video, 12-brand-story, 13-fashion-lookbook, 14-food-beverage, 15-real-estate, 02-3d-cgi
8. Write model-specs.md for each skill (populate from model-catalog.md, filter to 2-4 relevant models per skill).

### Phase 4: Install Script and i18n Polish

9. Revise `install.sh`:
   - Add Claude Code path detection (`~/.claude/skills/`)
   - Add `--fr` flag
   - Add `--target code|desktop|project`
   - Handle shared/ directory copy
   - Idempotency check
   - (Optional) `install.ps1` for Windows

### Phase 5: Documentation and Accuracy Pass

10. Rewrite README.md and README.fr.md to reflect the new structure (accurate skill count, correct paths, real output specs from model-catalog.md, no phantom LICENSE/logs.md references).
11. Verify all spec data in every model-specs.md against live `models_explore` output. Record "last verified" date.

### Dependency Graph

```
model-catalog.md
    ↓
    ├── generation-flow.md (uses model IDs from catalog)
    ├── mcp-tools.md (tool names reference models)
    └── per-skill model-specs.md (filtered views of catalog)
            ↓
generation-flow.md
    ↓
    └── per-skill SKILL.md generation section (links to flow)
            ↓
SKILL.md template (pilot: 01-cinematic)
    ↓
    └── all 14 remaining SKILL.md refactors

install.sh
    → reads: skills/ directory structure (needs skills/ to exist)
    → writes: shared/ + skills/ to target path

README.md
    → documents: everything (built last)
```

---

## Scaling Considerations

This is a documentation/skill repo, not a web service, so scaling means "number of skills" and "context efficiency", not users or load.

| Scale | Architecture Adjustments |
|-------|--------------------------|
| 15 skills (current target) | Current architecture is fine. shared/ keeps things DRY. |
| 30+ skills | Consider splitting model-catalog.md into video-models.md and image-models.md for faster lookup. Per-skill model-specs.md already handles this by filtering. |
| 50+ skills with many languages | Claude Code's skill budget (1% of context window by default) can overflow, causing descriptions to be truncated or dropped. Consider `skillListingBudgetFraction` setting and tighter descriptions. |

---

## Sources

- [Agent Skills overview — Anthropic Platform Docs](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview) (HIGH confidence — official)
- [Skill authoring best practices — Anthropic Platform Docs](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices) (HIGH confidence — official)
- [Use Skills in Claude Code — Claude Code Docs](https://code.claude.com/docs/en/skills) (HIGH confidence — official)
- Live repo audit: skills/15-real-estate/SKILL.md (2344 lines), skills/01-cinematic/SKILL.md (1329 lines), install.sh, README.md
- .planning/PROJECT.md (model catalog captured 2026-05-24 via models_explore)

---

*Architecture research for: Higgsfield multi-model Claude Agent Skills repo*
*Researched: 2026-05-24*
