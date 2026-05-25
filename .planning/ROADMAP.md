# Roadmap — Higgsfield Skills Multi-Model Toolkit

**Project:** Rearchitect 15 static prompt-engineering documents into model-aware Claude Agent Skills with opt-in generation via Higgsfield MCP.
**Granularity:** Standard
**Total v1 requirements:** 31
**Last updated:** 2026-05-25

---

## Phases

- [x] **Phase 1: Shared Infrastructure + Repo Hygiene** — Build the load-bearing foundation every skill depends on: shared/model-catalog.md, shared/generation-flow.md, shared/mcp-tools.md, LICENSE, and clean repo state (remove zh-CN, audit frontmatter)
- [x] **Phase 2: Pilot Skill (01-cinematic) End-to-End** — Validate the lean SKILL.md template, progressive disclosure structure, and the full opt-in generation loop on one skill before multiplying it across 14 more
- [ ] **Phase 3: Bulk Refactor — Remaining 14 Skills** — Apply the validated pilot template to all remaining skills in dependency-aware order, adding the media_upload branch for the 4 I2V skills (04, 08, 09, 10)
- [ ] **Phase 4: Install Script** — Revise install.sh to target the correct shared Claude Code + Desktop path, handle shared/ directory, add --all/--list/--target flags, idempotency
- [ ] **Phase 5: Spec Accuracy Pass + Documentation** — Re-verify every model-specs.md against live models_explore, update verification dates, and rewrite README.md (English) to reflect the real structure

---

## Phase Details

### Phase 1: Shared Infrastructure + Repo Hygiene
**Goal**: The shared foundation every skill depends on exists and is accurate — model catalog, generation flow, MCP tool signatures, LICENSE — and the repo is clean of phantom files and dead translations
**Depends on**: Nothing (first phase)
**Requirements**: INFRA-01, INFRA-02, INFRA-03, INFRA-04, INFRA-05, STRUCT-04, I18N-01
**Success Criteria** (what must be TRUE):
  1. `shared/model-catalog.md` exists with all ~38 Higgsfield models, their parameters, aspect ratios, durations, and media roles captured from a live `models_explore` call, annotated with a "last verified" date
  2. `shared/generation-flow.md` documents the complete opt-in generation workflow (resolve model → build prompt → confirm with credit cost → generate → poll job_status → display), including the conditional media_upload branch for I2V skills
  3. `shared/mcp-tools.md` documents every relevant Higgsfield MCP tool with its fully-qualified name (`higgsfield:tool_name` in prose, `mcp__higgsfield__tool_name` in allowed-tools), signatures, and credit-cost notes
  4. A real `LICENSE` file exists at repo root; README.md contains no references to `LICENSE` or `logs.md` that do not correspond to real files
  5. All zh-CN translation directories are deleted; the STRUCT-04 frontmatter standard (name ≤64 chars lowercase-hyphens unique across EN+FR, description ≤1024 chars third-person with "Use when…" triggers) is documented in shared/skill-template.md (per-skill frontmatter rewriting to this standard happens in Phases 2-3)
**Plans**: 3 plans
- [x] 01-01-PLAN.md — Create shared/ + model-catalog.md + skill-template.md (INFRA-01, INFRA-02, STRUCT-04) [wave 1]
- [x] 01-02-PLAN.md — Write shared/mcp-tools.md + generation-flow.md (INFRA-04, INFRA-03) [wave 2]
- [x] 01-03-PLAN.md — LICENSE + README/CONTRIBUTING cleanup + zh-CN removal (INFRA-05, I18N-01) [wave 1]

### Phase 2: Pilot Skill (01-cinematic) End-to-End
**Goal**: One skill — 01-cinematic — is fully rearchitected as the reference implementation that proves the SKILL.md template, progressive disclosure, and generation loop before they replicate across 14 more skills
**Depends on**: Phase 1
**Requirements**: STRUCT-01, STRUCT-02, STRUCT-03, MODEL-01, MODEL-02, MODEL-03, MODEL-04, MODEL-05, MODEL-06, GEN-01, GEN-02, GEN-03, GEN-05, SPEC-01
**Success Criteria** (what must be TRUE):
  1. `skills/01-cinematic/SKILL.md` is ≤300 lines (target) and ≤500 lines (hard cap), contains working YAML frontmatter, a model routing table (cinematic_studio_3_0 primary / veo3_1 fallback), a generation workflow pointer to `../../shared/generation-flow.md`, and links to all four reference files
  2. `skills/01-cinematic/references/` contains camera.md, hooks.md, examples.md, and model-specs.md — each populated with real content; model-specs.md is sourced only from models_explore (no invented "4K", "8K", or ".webm" claims)
  3. English only — no `fr/` variant (language scope narrowed to English on 2026-05-25; the pilot FR variant was removed)
  4. Claude can navigate the skill end-to-end: read SKILL.md → load references/model-specs.md → build a prompt → present confirmation panel (model, params, credit cost) → call `higgsfield:generate_video` only after explicit user YES → report job_id via `higgsfield:job_display`
  5. `allowed-tools` frontmatter in SKILL.md pre-approves the exact set of `mcp__higgsfield__*` tools the skill needs; no tool is invoked that is not listed in allowed-tools
**Plans**: 3 plans
- [x] 02-01-PLAN.md — Build references/ (model-specs, camera, hooks, examples) from verified specs + monolith content (STRUCT-02, MODEL-01–06, SPEC-01) [wave 1]
- [x] 02-02-PLAN.md — Rebuild lean EN SKILL.md: frontmatter, routing table, generation pointer, references links (STRUCT-01/02, MODEL-01–06, GEN-01/02/03/05, SPEC-01) [wave 2]
- [x] 02-03-PLAN.md — end-to-end navigation checkpoint + replicable-pattern SUMMARY (STRUCT-03, MODEL-01/05, GEN-01/05) [wave 3] — FR variant produced then removed when scope narrowed to English only

### Phase 3: Bulk Refactor — Remaining 14 Skills
**Goal**: All 14 remaining skills (02–15) are refactored to the validated pilot template — lean SKILL.md, references/, correct model routing, valid parameters, and the opt-in generation loop; the 4 I2V skills additionally implement the media_upload → media_confirm branch
**Depends on**: Phase 2
**Requirements**: GEN-04
**Note**: STRUCT-01/02, MODEL-01–06, GEN-01–03/05, SPEC-01 were established as a pattern on the pilot in Phase 2 and are applied at scale here. GEN-04 (media_upload for I2V skills) is the sole requirement that first appears in this phase.
**Success Criteria** (what must be TRUE):
  1. All 14 skills (02–15) have SKILL.md ≤500 lines with working model routing tables, spec-accurate parameter defaults, and generation workflow pointers — no skill retains monolithic content or invented specs
  2. The 4 I2V skills (04-comic-to-video, 08-anime-action, 09-product-360, 10-music-video) each document and trigger the `higgsfield:media_upload` → `higgsfield:media_confirm` → attach-reference flow before the generate call; `mcp__higgsfield__media_upload` and `mcp__higgsfield__media_confirm` are listed in their `allowed-tools` frontmatter
  3. All 14 skills have fully populated `references/model-specs.md` files sourced from `models_explore` data (no fabricated resolution, format, or fps claims), annotated with verification date
  4. Running any of the 14 skills delivers the same confirmation-gated generation loop as the pilot: prompt → confirm panel → explicit YES → generate → job report
**Plans**: TBD

### Phase 4: Install Script
**Goal**: The install script works correctly for both Claude Code and Claude Desktop, installs the shared/ directory so relative references resolve, and is idempotent
**Depends on**: Phase 3
**Requirements**: PKG-01, PKG-02, PKG-03, PKG-04
**Success Criteria** (what must be TRUE):
  1. `install.sh` installs skills to `~/.claude/skills/` (not the old Desktop-only path) and correctly copies `shared/` so `../../shared/` relative links resolve from installed skill directories
  2. The installer supports `--all`, `--list`, and `--target code|desktop|project` flags; running `./install.sh --all` twice in a row produces no errors and no duplicate installs (idempotent)
  3. Committing skills under `.claude/skills/` at repo root makes them available as a project-scoped skill set without running the script (PKG-04)
**Note**: I18N-02/I18N-03 (French variants) were removed from this phase on 2026-05-25 — project scope is English only.
**Plans**: TBD

### Phase 5: Spec Accuracy Pass + Documentation
**Goal**: Every per-model spec in every skill is verified against the live models_explore catalog as of this pass, and README.md (English) accurately describes the real repo structure with no phantom files or stale statistics
**Depends on**: Phase 4
**Requirements**: SPEC-02, DOC-01, DOC-02
**Success Criteria** (what must be TRUE):
  1. Every `references/model-specs.md` across all 15 skills carries an updated "last verified" date from a fresh `models_explore` call; any spec that drifted since Phase 2/3 authoring is corrected before release
  2. `README.md` (English) accurately states the skill count (15), correct install paths (`~/.claude/skills/`), real output constraints sourced from model-catalog.md, and references no files that do not exist (the other-language READMEs that remain — fr/es/de/etc. — are pre-existing translations of the old README, out of scope for this rewrite)
  3. README documents the full model routing table (all 15 skills with primary + fallback), the opt-in generation flow at a glance, and the supported Higgsfield model ecosystem (~38 models, image + video categories)
**Plans**: TBD

---

## Progress

| Phase | Plans Complete | Status | Completed |
|-------|----------------|--------|-----------|
| 1. Shared Infrastructure + Repo Hygiene | 3/3 | ✅ Complete (verified 5/5) | 2026-05-24 |
| 2. Pilot Skill (01-cinematic) End-to-End | 3/3 | ✅ Complete (verified 5/5) + refined post-review | 2026-05-25 |
| 3. Bulk Refactor — Remaining 14 Skills | 0/? | Not started | - |
| 4. Install Script | 0/? | Not started | - |
| 5. Spec Accuracy Pass + Documentation | 0/? | Not started | - |
