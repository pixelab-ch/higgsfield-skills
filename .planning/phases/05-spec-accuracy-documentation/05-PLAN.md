---
phase: "05"
plan: "05"
name: "spec-accuracy-documentation"
type: autonomous
requirements: [SPEC-02, DOC-01, DOC-02]
---

# Phase 5 Plan: Spec Accuracy Pass + Documentation Rewrite

## Objective

Perform a final confirmation sweep of all 15 per-skill model-specs.md files for spec accuracy and verification annotations, rewrite README.md (English) to honestly describe the actual multi-model repo structure, and delete the 7 stale translated READMEs that still describe the old single-model Seedance-only repo.

## Context

- `shared/model-catalog.md` — authoritative model catalog (~38 models), verified 2026-05-24
- `shared/generation-flow.md` — canonical opt-in generation workflow
- `skills/*/references/model-specs.md` — per-skill specs authored in Phase 3, verified 2026-05-25
- `install.sh` — the new installer (targets `~/.claude/skills/`, supports `--all`/`--list`/`--target`)
- `.planning/REQUIREMENTS.md` — SPEC-02, DOC-01, DOC-02 are the Phase 5 requirements
- `.planning/ROADMAP.md` — Phase 5 success criteria

## Tasks

### Task 1 — SPEC-02: Confirmation sweep of all 15 model-specs.md files

**Type:** auto

Sweep all 15 `skills/*/references/model-specs.md` files and confirm:
1. Each file carries a `<!-- verified: models_explore 2026-05-25 -->` or equivalent annotation
2. No file contains invented VIDEO output specs: `.webm` as output container, `3840`/`2160` as output resolution claims, or `8K` as output claim — excluding legitimate prohibition text and image-model enum references (cinematic_studio_2_5 `4k` enum, ms_image `4k` enum, seedream_v4_5 `4k`, kling `4k` mode enum)

Fix only clear invented-spec violations if found. Do not re-query models_explore (no MCP access in this pass — specs were verified during Phase 3 authoring).

**Done criteria:** All 15 files confirmed annotated; no unresolved invented VIDEO specs remain.

### Task 2 — DOC-01 + DOC-02: Rewrite README.md

**Type:** auto

Rewrite `README.md` (English only) to accurately describe the real repo:

- **DOC-01 accuracy:** List all 15 skills with their `higgsfield-*` names and one-line use cases; correct install instructions (`./install.sh`, `--all`/`--list`/`--target code|desktop|project`, installs to `~/.claude/skills/` for both Claude Code and Claude Desktop); real output constraints (video up to 1080p, no 4K/.webm video claims); accurate repo structure (skills/NN-name/{SKILL.md, references/}, shared/, install.sh, LICENSE). Reference only files that exist.
- **DOC-02 content:** Include (a) the model routing table — all 15 skills with primary + fallback model; (b) short opt-in generation explanation (build prompt → confirm with credit cost → generate via Higgsfield MCP → poll → display; generation never automatic); (c) the supported Higgsfield model ecosystem overview (~38 models across image + video, Bytedance/Google/Kling/xAI/Black Forest Labs/Higgsfield, all behind one MCP).

**Done criteria:** README.md contains no zh-CN text, no phantom file references, no invented video specs; routing table complete; generation flow explained; ecosystem overview present.

### Task 3 — Remove stale translated READMEs

**Type:** auto

Delete all 7 stale translated README files:
- `README.fr.md`
- `README.de.md`
- `README.es.md`
- `README.ja.md`
- `README.ko.md`
- `README.pt.md`
- `README.tr.md`

Also remove the language-switcher line at the top of `README.md` that linked to them (executed as part of Task 2 rewrite).

The `assets/skill-map.svg` depicts "Seedance 2.0 Skills Map" with zh-CN labels — it is inaccurate for the current multi-model repo. Drop the reference to it in the rewritten README rather than ship a misleading diagram.

**Done criteria:** 7 translated README files deleted; `README.md` contains no links to deleted files; `assets/banner.svg` still referenced if present.

## Verification

- `ls skills/*/references/model-specs.md | wc -l` == 15
- `grep -r "verified: models_explore" skills/*/references/model-specs.md | wc -l` == 15
- `grep -rni "\.webm\|3840\|2160\|8K" skills/*/references/model-specs.md` returns only prohibition/warning text (no output claims)
- `ls README.*.md` returns empty (all 7 translations deleted)
- `grep -c "higgsfield-" README.md` >= 15 (all skill names listed)
- `grep -c "cinematic_studio_3_0\|seedance_2_0\|wan2_7\|kling3_0\|veo3_1" README.md` >= 5 (routing table present)
- `grep "4K\|4k" README.md` returns only prohibition/clarification text

## Success Criteria

1. Every `references/model-specs.md` across all 15 skills carries the verification annotation; no invented video output specs remain unaddressed
2. `README.md` accurately describes the multi-model repo with: 15 skill names, correct install path (`~/.claude/skills/`), real output constraints (up to 1080p), real repo structure, no phantom files
3. README contains the full model routing table, opt-in generation flow explanation, and Higgsfield ecosystem overview (~38 models)
4. All 7 stale translated READMEs are deleted; no broken links remain in README.md
