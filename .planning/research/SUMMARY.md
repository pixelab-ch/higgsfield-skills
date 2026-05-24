# Project Research Summary

**Project:** Model-aware Claude Agent Skills for AI image/video generation on Higgsfield
**Domain:** Claude Agent Skills — multi-model AI generation via MCP
**Researched:** 2026-05-24
**Confidence:** HIGH

---

## Executive Summary

This project rearchitects the `higgsfield-seedance2-jineng` repo from a collection of static prompt-engineering documents into 15 model-aware Claude Agent Skills that can actually generate AI images and videos via the Higgsfield MCP server. The existing repo has excellent prompt-craft content and frontmatter, but zero tool integration, fabricated model specs, a broken install script, and monolithic SKILL.md files (741–2,344 lines) that burn context on every invocation. The rework reuses the creative content but introduces: style-to-model routing for all 15 skills across ~38 Higgsfield models, an opt-in generation loop (prompt → confirm → generate → poll → display), progressive disclosure (lean SKILL.md ≤500 lines + references/), and a corrected install targeting `~/.claude/skills/` for both Claude Code and Desktop.

The recommended approach is a strict five-phase build order with total dependency discipline: shared infrastructure first (model catalog, generation flow, MCP tool signatures, LICENSE), then a pilot skill template validated end-to-end, then bulk refactor of the remaining 14 skills, then install script and FR localization, and finally a spec-accuracy and documentation pass. All four research tracks independently converged on this order because the shared generation flow and model catalog are load-bearing for every downstream skill — writing any skill before these exist creates rework. The pilot (01-cinematic) de-risks the template before it multiplies.

The two non-negotiable constraints are: (1) `SKILL.md` must stay under 500 lines (official hard cap) with heavy content in `references/`, and (2) generation must always be gated by explicit user confirmation before any `generate_image` or `generate_video` MCP call (Higgsfield credits are real money). Four skills (04-comic-to-video, 08-anime-action, 09-product-360, 10-music-video) always require the `media_upload` → `media_confirm` two-step before generation because they are image-to-video (I2V) or audio-driven. Skipping that flow causes an API rejection with no refund.

---

## Key Findings

### Recommended Stack

The delivery vehicle is the Claude Agent Skills format — the only format that loads natively in both Claude Code (`~/.claude/skills/`) and Claude Desktop on the same install path. No web service, no custom scripts, no cross-provider API integrations. The Higgsfield MCP server is already present in the user's environment and provides all generation, job tracking, media upload, and account tools. MCP tools must be referenced with the fully-qualified `higgsfield:tool_name` syntax in SKILL.md prose and `mcp__higgsfield__tool_name` in `allowed-tools` frontmatter — these are the same tools but different syntactic contexts.

The source of truth for all model constraints is the live `higgsfield:models_explore` call. Hardcoded specs drift as Higgsfield updates models; the existing repo's "4K 3840×2160 / .webm" claims in fight-scenes are a direct example of this failure. The hybrid approach (cached specs with `<!-- verified: models_explore YYYY-MM-DD -->` annotations + a directive to re-query on failure) is the right middle ground between always-live calls and never-updated hardcodes.

**Core technologies:**
- Claude Agent Skills format (SKILL.md + references/) — delivery vehicle for all 15 skills; supports both Claude Code and Desktop natively
- `higgsfield:models_explore` — live model catalog; source of truth for aspect ratios, durations, media roles, parameter enumerations per model
- `higgsfield:generate_image` / `higgsfield:generate_video` — core generation MCP tools; always require explicit user confirmation first
- `higgsfield:media_upload` + `higgsfield:media_confirm` — two-step upload required for I2V skills (04, 08, 09, 10); must be an atomic pair
- `higgsfield:job_status` + `higgsfield:job_display` — job tracking; poll with delay, never re-submit to poll
- `shared/` directory at repo root — single source of truth for model catalog, generation flow, and MCP tool signatures referenced across all 15 skills via relative paths

### Expected Features

**Must have (table stakes — v1 launch blockers):**
- Model routing declaration in every skill (primary model + fallback with rationale) — this is the core promise of the rework; without it every skill is still Seedance-only
- Valid parameter emission (only suggest parameters the chosen model actually accepts per `models_explore`) — prevents API rejections and broken user expectations
- Prompt → confirm → generate loop for all 15 skills — credits are real money; confirmation gate is a hard constraint from PROJECT.md
- Job status reporting after every generation (`job_status` → `job_display`) — users need to see results
- `media_upload` flow for the 4 I2V-only skills (04-comic-to-video, 08-anime-action, 09-product-360, 10-music-video) — these skills are entirely broken without it
- Factual spec accuracy — remove all invented specs (no "4K", "8K", ".webm", "60fps") and source only from `models_explore`
- Progressive disclosure structure (SKILL.md ≤500 lines, encyclopedic content in references/) — required to free context budget for generation logic
- Credit/balance visibility in the confirm step (`higgsfield:balance`) — minimum cost transparency before user commits

**Should have (differentiators — v1.x after validation):**
- Style-optimized parameter defaults per skill (aspect ratio, duration, quality, genre pre-filled for the creative genre)
- Genre/quality parameter pre-selection for models that support it (cinematic_studio_3_0 → genre:"cinematic"; marketing_studio_video → genre:"ad")
- Audio-aware generation for skill 10 music-video (veo3_1 `audio` role with media_upload flow)
- `presets_show` integration for cinematic and brand-story skills (01, 12)
- `virality_predictor` call in social-hook confirm step (skill 11)
- Multi-model routing for image→video pipelines (skills 07, 09, 13)

**Defer (v2+):**
- Dynamic model routing via live `models_explore` at every invocation (adds latency; cached hybrid is sufficient)
- Variant generation with explicit multi-gen confirm ("generate 3 variants, costs 3x credits?")
- `higgsfield_preset` integration for power users
- `image_auto` routing for model-agnostic image generation

### Style → Model Routing (All 15 Skills)

All routing sourced from live `models_explore` capture (2026-05-24):

| Skill | Primary Model | Fallback | I2V / Media Required |
|-------|--------------|----------|----------------------|
| 01-cinematic | cinematic_studio_3_0 | veo3_1 | No (optional start_image) |
| 02-3d-cgi | seedance_2_0 | wan2_7 | No |
| 03-cartoon | wan2_7 | seedance_2_0 | No |
| 04-comic-to-video | wan2_6 | seedance_2_0 | YES — start_image always required |
| 05-fight-scenes | cinematic_studio_3_0 | kling3_0 | No |
| 06-motion-design-ad | marketing_studio_video | seedance_2_0 | No |
| 07-ecommerce-ad | marketing_studio_video | ms_image (stills) | No (optional) |
| 08-anime-action | wan2_7 | wan2_6 | YES — start_image for I2V path |
| 09-product-360 | seedance_2_0 | cinematic_studio_3_0 | YES — start_image always required |
| 10-music-video | veo3_1 | veo3_1_lite | YES — audio role requires media_upload |
| 11-social-hook | kling3_0 | grok_video | No (optional start_image) |
| 12-brand-story | cinematic_studio_3_0 | veo3_1 | No |
| 13-fashion-lookbook | cinematic_studio_video | seedance_2_0 | No |
| 14-food-beverage | seedance_2_0 | marketing_studio_video | No |
| 15-real-estate | cinematic_studio_3_0 | veo3_1 | No |

### Architecture Approach

The repo is restructured around three layers: (1) a `shared/` directory at repo root containing model-catalog.md, generation-flow.md, and mcp-tools.md — the DRY foundation that all 15 skills reference via relative paths; (2) 15 skill directories each with a lean SKILL.md (200–300 lines, hard cap 500) as a navigation index pointing to skill-specific `references/` files (camera.md, hooks.md, examples.md, model-specs.md); and (3) an `fr/SKILL.md` per skill for French localization with `-fr` suffix on the frontmatter `name` to avoid name collisions. No skill ever references another skill's SKILL.md — cross-skill shared content belongs exclusively in `shared/`.

**Major components:**
1. `shared/model-catalog.md` — canonical list of ~38 models with parameter sets, aspect ratios, durations, media roles; last-verified date annotation; the ground truth for all per-skill routing tables
2. `shared/generation-flow.md` — single canonical opt-in generation workflow (resolve → confirm → generate → poll → display) linked from all 15 skills; never duplicated in individual skills
3. `shared/mcp-tools.md` — fully-qualified tool names, signatures, and credit-cost notes for all Higgsfield MCP tools
4. `skills/NN-name/SKILL.md` — lean entry point (≤500 lines, target 200–300); YAML frontmatter with `name`, `description`, `when_to_use`, `allowed-tools`; model routing table; links to references/ and shared/
5. `skills/NN-name/references/model-specs.md` — per-skill parameter tables for the 2–4 relevant models; cached from models_explore with verification date; includes directive to re-query on failure
6. `skills/NN-name/fr/SKILL.md` — French translation of the entry point only; references files stay EN; `name` suffixed with `-fr` to avoid collision
7. `install.sh` — revised to target `~/.claude/skills/` for both Claude Code and Desktop; copies `shared/` to `~/.claude/shared/`; `--fr` flag; `--target code|desktop|project` flags; idempotency check

### Critical Pitfalls

1. **Zero tool integration (existing state)** — every skill must contain an explicit numbered workflow section with fully-qualified MCP tool calls (`higgsfield:generate_video`, not just prose descriptions); the skill template established in Phase 1 must make this structure mandatory before any content is authored
2. **Spec hallucination** — never write a resolution, duration, or format claim that does not appear verbatim in `models_explore` output for that specific model; annotate every spec block with `<!-- verified: models_explore YYYY-MM-DD -->`; the "4K / .webm" errors in the existing repo are the canonical failure case
3. **Unconfirmed credit expenditure** — the confirmation gate (showing model, params, estimated cost, explicit "Proceed? yes/no") must appear in the workflow template as a structural requirement, not optional content; no `generate_*` call may appear before it; retry loops must poll `job_status`, never re-call `generate_video`
4. **Missing media_upload for I2V skills** — skills 04, 08, 09, 10 call `generate_video` with `start_image` or `audio` roles; without a confirmed uploaded media ID the API rejects the call; `media_upload` → `media_confirm` is an atomic pair that must appear as a conditional branch in the workflow template
5. **Wrong install path** — the existing `install.sh` targets `~/Library/Application Support/Claude/skills` (Desktop-only), not `~/.claude/skills/` (shared path for both Claude Code and Desktop); silent install success with invisible skills is the failure symptom

---

## Implications for Roadmap

All four research files converged on the same five-phase build order. The dependency graph is strict: shared infrastructure is load-bearing for all skills; the pilot de-risks the template before it multiplies; install and i18n are independent of skill content; documentation is always last.

### Phase 1: Shared Infrastructure + Repo Hygiene

**Rationale:** `shared/model-catalog.md` is the source of truth for every skill's routing table and model-specs.md. `shared/generation-flow.md` is referenced by every skill's generation section. LICENSE must exist before any README references it (currently a phantom file). Cleaning phantom README entries (LICENSE, logs.md) and removing zh-CN files that are 99% untranslated copies is pre-work that prevents confusion in all later phases.

**Delivers:**
- `shared/model-catalog.md` — all ~38 models, parameters, aspect ratios, durations, roles, verified 2026-05-24
- `shared/generation-flow.md` — canonical opt-in workflow with confirmation gate and media_upload conditional branch
- `shared/mcp-tools.md` — fully-qualified tool names and signatures
- `LICENSE` file committed at repo root
- README cleaned of phantom references; zh-CN files removed

**Addresses:** Model routing foundation, valid parameter emission, confirmation gate design, media_upload flow pattern
**Avoids:** Spec hallucination (Pitfall 2), zero tool integration (Pitfall 1), phantom documentation (Pitfall 5), unconfirmed credit expenditure (Pitfall 4)
**Research flag:** No additional research needed — model catalog populated directly from a live `models_explore` call

### Phase 2: Pilot Skill Template (01-cinematic)

**Rationale:** The SKILL.md template and references/ structure must be proven on one skill end-to-end before multiplying across 14 more. 01-cinematic is the right pilot: smallest existing skill (1,329 lines), broad appeal for validation, uses cinematic_studio_3_0 (primary model for 5 of 15 skills), and does not require the media_upload flow — keeping the pilot simple. Once Claude navigates from SKILL.md → references/ → shared/generation-flow.md and successfully generates against cinematic_studio_3_0, the pattern is proven.

**Delivers:**
- `skills/01-cinematic/SKILL.md` (EN, ≤300 lines) with working model routing, generation workflow pointer, and links to references/
- `skills/01-cinematic/fr/SKILL.md` (FR, name: higgsfield-cinematic-fr)
- `skills/01-cinematic/references/` — camera.md, hooks.md, examples.md, model-specs.md
- Validated end-to-end: skill triggers → builds prompt → confirms → generates → reports job

**Implements:** Lean SKILL.md pattern, progressive disclosure, model routing table format, FR localization pattern
**Avoids:** Monolithic SKILL.md (Pitfall 7), description over-triggering (Pitfall 9)
**Research flag:** No additional research needed; template is fully specified in ARCHITECTURE.md

### Phase 3: Bulk Refactor — Remaining 14 Skills

**Rationale:** Apply the pilot template to skills 02–15 in dependency-aware order. Simple T2V styles first (validate the template at scale with no edge cases), commercial skills next (introduce marketing_studio_video and ms_image dual-path routing), then the 4 I2V skills as a focused group (add and validate the media_upload branch), and encyclopedic industry-specific skills last.

**Sub-order within phase:**
1. Simple T2V styles: 03-cartoon (wan2_7), 11-social-hook (kling3_0) — validate non-cinematic model routing
2. Commercial: 06-motion-design-ad, 07-ecommerce-ad — introduce marketing_studio_video + ms_image dual-path
3. **I2V skills (media_upload branch):** 04-comic-to-video (wan2_6 + start_image always), 08-anime-action (wan2_7 + optional I2V), 09-product-360 (seedance_2_0 + start_image always), 10-music-video (veo3_1 + audio role)
4. Remaining industry-specific: 02-3d-cgi, 05-fight-scenes, 12-brand-story, 13-fashion-lookbook, 14-food-beverage, 15-real-estate

**Delivers:** 14 skills refactored to lean SKILL.md + references/ with model routing, generation workflow, FR variants, and correct specs
**Avoids:** Model-parameter mismatch (Pitfall 3), I2V media upload failures, spec hallucination resurface (Pitfall 2)
**Research flag:** I2V sub-group (04, 08, 09, 10) warrants a live `models_explore` verification of wan2_6, seedance_2_0, and veo3_1 role schemas at planning time — these are the most operationally critical parameters and most likely to have drifted

### Phase 4: Install Script + i18n Polish

**Rationale:** The installer reads the skills/ directory structure, so it cannot be finalized until skills are stable. FR translation quality pass is mechanical once EN is finalized.

**Delivers:**
- Revised `install.sh` targeting `~/.claude/skills/` for Claude Code + Desktop; copies `shared/` to `~/.claude/shared/`; `--fr`, `--all`, `--list`, `--target code|desktop|project` flags; idempotency check; post-install path verification
- FR translation quality pass: all 15 `fr/SKILL.md` files verified for >50% French body lines and unique `-fr` suffixed `name:` values
- Optional: `install.ps1` stub for Windows

**Avoids:** Install script wrong path (Pitfall 8), translation drift (Pitfall 6), FR name collision
**Research flag:** No additional research needed; install path confirmed in STACK.md

### Phase 5: Spec Accuracy Pass + Documentation

**Rationale:** Documentation and spec verification always come last — they describe what was actually built. This phase runs a live `models_explore` verification against every model referenced in every model-specs.md, updates any specs that drifted, and rewrites README.md / README.fr.md to reflect the new structure.

**Delivers:**
- All `references/model-specs.md` files re-verified against live `models_explore` with new verification date
- `README.md` and `README.fr.md` rewritten: accurate skill count, correct install paths, real output specs, no phantom file references
- "Looks Done But Isn't" checklist (from PITFALLS.md) run against all 15 skills

**Avoids:** Phantom documentation (Pitfall 5), spec hallucination resurface after model updates
**Research flag:** No additional research needed; this is a verification and authoring task

### Phase Ordering Rationale

- `shared/model-catalog.md` must exist before any skill's routing table or model-specs.md can be written; `shared/generation-flow.md` must exist before any skill's generation section links to it — the dependency chain is strict
- One validated pilot (Phase 2) catches template structural errors before they replicate 14 times; the cost of fixing a structural error is 15x higher after bulk refactor
- The 4 I2V skills are grouped within Phase 3 so the media_upload branch is built and validated consistently; scattering them risks inconsistent implementations
- Install script and i18n cannot be finalized until skills/ structure is stable (Phase 4 depends on Phase 3)
- Documentation always describes what was built, never what was planned (Phase 5 depends on everything)

### Research Flags

Phases needing deeper `--research-phase` investigation during planning:
- **Phase 3 (I2V sub-group — skills 04, 08, 09, 10):** Verify current media role schemas for wan2_6, seedance_2_0, and veo3_1 via live `models_explore` before authoring their generation workflows; role requirements (start_image mandatory vs optional, audio role availability) are operationally critical and most likely to have drifted since the 2026-05-24 catalog capture

Phases with standard patterns (skip additional research):
- **Phase 1:** Execute `models_explore` directly to populate model-catalog.md; no unknowns
- **Phase 2:** Template fully specified in ARCHITECTURE.md; no research gaps
- **Phase 3 (non-I2V):** Standard application of pilot template
- **Phase 4:** Install path confirmed; script requirements fully specified
- **Phase 5:** Verification and authoring task; no research needed

---

## Confidence Assessment

| Area | Confidence | Notes |
|------|------------|-------|
| Stack | HIGH | Primary sources: official Claude Agent Skills docs (code.claude.com + platform.claude.com) verified 2026-05-24; MCP tool names confirmed from live environment |
| Features | HIGH | Based on live `models_explore` catalog captured 2026-05-24 + direct audit of all 15 existing skills; routing table is opinionated but well-grounded |
| Architecture | HIGH | Official Agent Skills architecture docs + live repo audit; all patterns have primary-source backing |
| Pitfalls | HIGH | Every pitfall verified against the actual existing repo (line counts, diff analysis, install.sh path inspection) + official constraint documentation |

**Overall confidence: HIGH**

### Gaps to Address

- **Exact role schemas for I2V models at generation time:** Routing table specifies which models require `start_image` or `audio` roles, but field names and required-vs-optional status should be re-verified via `models_explore` at Phase 3 planning time; flag for the I2V sub-group
- **`minimax_hailuo` special case:** Requires `resolution: 512` when `end_image` role is used — no current skill routes to this model, but flag if any Phase 3 skill considers it as a fallback
- **Claude Desktop skills path current status:** STACK.md rates `~/.claude/skills/` as MEDIUM confidence for Desktop due to a documented bug (GitHub issue #10927, v1.0.211); install script should verify path exists and is populated post-install
- **`allowed-tools` pre-approval for media_upload:** Skills with the media_upload flow should pre-approve `mcp__higgsfield__media_upload` and `mcp__higgsfield__media_confirm` in `allowed-tools` frontmatter; confirm this in the Phase 2 pilot before carrying into Phase 3

---

## Sources

### Primary (HIGH confidence)
- `code.claude.com/docs/en/skills` — frontmatter spec (name ≤64 chars, description ≤1024 chars), install paths, progressive disclosure 500-line cap, live reload behavior, MCP tool reference syntax
- `platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices` — description writing rules, reference depth constraints, `ServerName:tool_name` syntax, anti-patterns
- `platform.claude.com/docs/en/agents-and-tools/agent-skills/overview` — three-level progressive disclosure model, cross-surface path table
- `.planning/PROJECT.md` — live `models_explore` capture 2026-05-24; model catalog (~38 models), MCP tool list, constraints, key decisions

### Secondary (MEDIUM confidence)
- `higgsfield.ai/mcp` — Higgsfield MCP tool listing; confirms generate_image, generate_video, job_display, balance, show_plans_and_credits, select_workspace; no parameter schemas
- `github.com/anthropics/claude-code/issues/10927` — macOS Claude Desktop skills path bug (v1.0.211, 2025-10-31); confirms `~/Library/Application Support/Claude/skills` is NOT the correct path; fix resolution not explicitly documented

### Tertiary (LOW-MEDIUM confidence)
- `github.com/jfikrat/higgsfield-mcp` — community MCP implementation; tool name patterns and parameter shape; may not match official MCP exactly

---

*Research completed: 2026-05-24*
*Ready for roadmap: yes*
