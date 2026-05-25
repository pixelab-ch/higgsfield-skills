# Requirements — Higgsfield Skills Multi-Model Toolkit

Derived from PROJECT.md and `.planning/research/SUMMARY.md`. REQ-IDs map to roadmap phases in the Traceability section.

## v1 Requirements

### Shared Infrastructure (INFRA)

- [x] **INFRA-01**: A `shared/` directory exists at repo root holding cross-cutting references that every skill links to via relative path (cross-skill SKILL.md references don't work because skills load independently)
- [x] **INFRA-02**: `shared/model-catalog.md` documents the Higgsfield image + video model catalog (IDs, params, aspect ratios, durations, media roles) with a "last verified" date, sourced from `models_explore`
- [x] **INFRA-03**: `shared/generation-flow.md` documents the canonical opt-in flow (resolve model → confirm prompt+params+credit cost → generate → poll `job_status` → present `job_display`) reused by all skills
- [x] **INFRA-04**: `shared/mcp-tools.md` documents the relevant Higgsfield MCP tools and the correct naming (`higgsfield:tool` in prose, `mcp__higgsfield__tool` in `allowed-tools`)
- [x] **INFRA-05**: A real `LICENSE` file exists at repo root and is referenced accurately by README/CONTRIBUTING

### Skill Structure / Progressive Disclosure (STRUCT)

- [x] **STRUCT-01**: Every `SKILL.md` body is ≤ 500 lines (Agent Skills hard cap)
- [x] **STRUCT-02**: Each skill keeps a lean `SKILL.md` (when-to-use, model routing summary, generation workflow) and moves encyclopedic content to one-level-deep `references/*.md` files
- [x] **STRUCT-03**: A documented SKILL.md template + decomposition pattern is validated on one pilot skill (01-cinematic) before being applied to the rest
- [x] **STRUCT-04**: Frontmatter follows the format (`name` ≤64 chars lowercase-hyphens, `description` ≤1024 chars third-person with "Use when…" triggers); each skill name is unique across EN and FR variants

### Model Awareness (MODEL)

- [x] **MODEL-01**: Each of the 15 skills declares a primary model and at least one fallback (per the routing table), so the right model is chosen without user guidance
- [x] **MODEL-02**: Each skill emits only parameters the chosen model actually accepts (resolution/quality/mode/genre/sound), with sensible defaults
- [x] **MODEL-03**: Each skill states the chosen model's valid aspect ratios and recommends one per target platform (9:16 TikTok, 16:9 YouTube, 1:1 IG, etc.)
- [x] **MODEL-04**: Each skill states the model's valid duration range/list and recommends a duration by use-case
- [x] **MODEL-05**: Skills with a useful still-image path (07, 09, 13, 15, 01, 12) document the appropriate image model variant
- [x] **MODEL-06**: Skills instruct Claude to call `models_explore` to re-verify constraints when a parameter is rejected, treating the live catalog as source of truth over cached specs

### Generation Flow (GEN)

- [x] **GEN-01**: Each skill builds the prompt, presents it, and requires explicit user confirmation before any `generate_image`/`generate_video` call (generation is opt-in; never automatic)
- [x] **GEN-02**: The confirm step surfaces model choice + rationale, parameters, and credit cost/balance (via `show_plans_and_credits`/`balance`)
- [x] **GEN-03**: After submission, the skill reports the job ID, polls `job_status` (polling, not resubmitting), and presents the result via `job_display`
- [x] **GEN-04**: The 4 image-to-video skills (04 comic-to-video, 08 anime, 09 product-360, 10 music-video) drive the `media_upload` → `media_confirm` → attach-reference flow before generating; other skills offer it optionally
- [x] **GEN-05**: `allowed-tools` frontmatter pre-approves the Higgsfield generation/upload tools each skill needs

### Factual Accuracy (SPEC)

- [x] **SPEC-01**: All invented/contradictory specs are removed (no "4K 3840×2160", no ".webm output", no fabricated fps) across all skills
- [x] **SPEC-02**: Every per-model spec stated in a skill matches the live `models_explore` output, verified in a final accuracy pass

### Packaging / Install (PKG)

- [x] **PKG-01**: A single `install.sh` installs skills to `~/.claude/skills/` (correct for both Claude Code and Claude Desktop), not the old Desktop-only path
- [x] **PKG-02**: The installer also installs the `shared/` directory so relative references resolve
- [x] **PKG-03**: The installer supports interactive selection, `--all`, and `--list`, is idempotent, and works on macOS/Linux (Windows path handled or clearly noted)
- [x] **PKG-04**: Project-scoped install via committing skills under `.claude/skills/` at repo root works without running the script

### Internationalization (I18N)

- [x] **I18N-01**: All zh-CN translation files are removed ✓ (Phase 1)

> **I18N-02 / I18N-03 (French variants) — moved to Out of Scope on 2026-05-25.** After the pilot, the project narrowed to English only: a French variant across 15 skills isn't worth the maintenance for a Claude/developer audience. The pilot FR variant was removed.

### Documentation (DOC)

- [x] **DOC-01**: README (English) accurately describes the real repo structure — no phantom files, correct stats, correct install instructions
- [x] **DOC-02**: README documents the model routing table, the opt-in generation flow, and the supported model ecosystem

## v2 / Deferred

- [ ] Multi-model pipelines (image model → feed as start_image to video model) as a guided cross-skill flow
- [ ] `virality_predictor` integration in 11-social-hook and `presets_show` integration in preset-friendly skills (differentiators, after core works)
- [ ] Windows-native install support if not covered in v1

## Out of Scope

- Cross-provider abstraction (direct Runway/Sora/Midjourney/native Kling APIs) — Higgsfield MCP already aggregates these providers
- Automatic generation without confirmation — generation must always be opt-in (credit cost)
- Retaining zh-CN — removed (English only)
- Translated skill variants, incl. French (I18N-02/I18N-03) — English only; not worth N×15 maintenance for a Claude/developer audience (decided 2026-05-25 after pilot)
- A hosted web UI or service — these are skills run inside Claude Code / Desktop

## Traceability

| REQ-ID | Phase | Status |
|--------|-------|--------|
| INFRA-01 | Phase 1 | Complete ✓ |
| INFRA-02 | Phase 1 | Complete ✓ |
| INFRA-03 | Phase 1 | Complete ✓ |
| INFRA-04 | Phase 1 | Complete ✓ |
| INFRA-05 | Phase 1 | Complete ✓ |
| STRUCT-04 | Phase 1 | Complete ✓ |
| I18N-01 | Phase 1 | Complete ✓ |
| STRUCT-01 | Phase 2 | Complete ✓ |
| STRUCT-02 | Phase 2 | Complete ✓ |
| STRUCT-03 | Phase 2 | Complete ✓ |
| MODEL-01 | Phase 2 | Complete ✓ |
| MODEL-02 | Phase 2 | Complete ✓ |
| MODEL-03 | Phase 2 | Complete ✓ |
| MODEL-04 | Phase 2 | Complete ✓ |
| MODEL-05 | Phase 2 | Complete ✓ |
| MODEL-06 | Phase 2 | Complete ✓ |
| GEN-01 | Phase 2 | Complete ✓ |
| GEN-02 | Phase 2 | Complete ✓ |
| GEN-03 | Phase 2 | Complete ✓ |
| GEN-05 | Phase 2 | Complete ✓ |
| SPEC-01 | Phase 2 | Complete ✓ |
| GEN-04 | Phase 3 | Complete ✓ |
| PKG-01 | Phase 4 | Complete ✓ |
| PKG-02 | Phase 4 | Complete ✓ |
| PKG-03 | Phase 4 | Complete ✓ |
| PKG-04 | Phase 4 | Complete ✓ |
| I18N-02 | — | Out of Scope (English only) |
| I18N-03 | — | Out of Scope (English only) |
| SPEC-02 | Phase 5 | Complete ✓ |
| DOC-01 | Phase 5 | Complete ✓ |
| DOC-02 | Phase 5 | Complete ✓ |
