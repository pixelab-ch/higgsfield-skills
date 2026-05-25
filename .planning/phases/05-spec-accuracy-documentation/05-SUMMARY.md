---
phase: "05"
plan: "05"
name: "spec-accuracy-documentation"
subsystem: documentation
tags: [spec-accuracy, readme, documentation, cleanup]
requirements-satisfied: [SPEC-02, DOC-01, DOC-02]

dependency-graph:
  requires: [Phase 1 shared infrastructure, Phase 2 pilot skill, Phase 3 bulk refactor, Phase 4 install script]
  provides: [accurate README.md, confirmed spec annotations, clean repo (no stale translations)]
  affects: [README.md, .planning/REQUIREMENTS.md, .planning/ROADMAP.md]

tech-stack:
  added: []
  patterns: [confirmation sweep, documentation rewrite, dead-file cleanup]

key-files:
  created:
    - .planning/phases/05-spec-accuracy-documentation/05-PLAN.md
    - .planning/phases/05-spec-accuracy-documentation/05-SUMMARY.md
  modified:
    - README.md
  deleted:
    - README.fr.md
    - README.de.md
    - README.es.md
    - README.ja.md
    - README.ko.md
    - README.pt.md
    - README.tr.md

decisions:
  - "Dropped skill-map.svg reference from README — SVG says 'Seedance 2.0 Skills Map' with zh-CN labels, inaccurate for current multi-model repo. Kept banner.svg which has no model-specific text."
  - "SPEC-02 pass is a confirmation pass only (no MCP access) — specs were authored from live models_explore data in Phase 3 with verification annotations already in place."
  - "All 7 non-English READMEs deleted — they described the old Seedance-only single-model repo with incorrect install paths, zh-CN branding, and wrong stats. Actively misleading."
  - "README.md is now English-only, matching the PROJECT.md scope decision (EN only, zh-CN removed in Phase 1)."

metrics:
  duration: "~30 minutes"
  completed: "2026-05-25"
  tasks-completed: 3
  files-changed: 9
---

# Phase 5 Plan 05: Spec Accuracy Pass + Documentation Rewrite Summary

**One-liner:** Confirmed 15/15 model-specs.md files carry verification annotations with no invented video specs; rewrote README.md as accurate English-only multi-model documentation with routing table, opt-in flow, and ecosystem overview; deleted 7 stale translated READMEs.

---

## Tasks Completed

| Task | Description | Status |
|------|-------------|--------|
| 1 | SPEC-02: Sweep all 15 model-specs.md for verification annotations and invented specs | Complete |
| 2 | DOC-01 + DOC-02: Rewrite README.md (English) | Complete |
| 3 | Delete 7 stale translated READMEs + remove language-switcher | Complete |

---

## Task 1 — SPEC-02: Spec Sweep Results

### Verification Annotation Check

**Result: 15/15 annotated.** Every `skills/*/references/model-specs.md` file carries a `<!-- verified: models_explore 2026-05-25 -->` annotation.

| Skill | Annotation present |
|-------|--------------------|
| 01-cinematic | Yes |
| 02-3d-cgi | Yes |
| 03-cartoon | Yes |
| 04-comic-to-video | Yes |
| 05-fight-scenes | Yes |
| 06-motion-design-ad | Yes |
| 07-ecommerce-ad | Yes |
| 08-anime-action | Yes |
| 09-product-360 | Yes |
| 10-music-video | Yes |
| 11-social-hook | Yes |
| 12-brand-story | Yes |
| 13-fashion-lookbook | Yes |
| 14-food-beverage | Yes |
| 15-real-estate | Yes |

### Invented Spec Scan

Scanned for: `.webm` (output container), `3840` (4K width), `2160` (4K height), `8K` as output claim, `4K`/`4k` as video output claim.

**Result: No invented video specs found.** All hits are in prohibition/warning text or legitimate image-model enum references:

- `11-social-hook/references/model-specs.md` lines 38/46: `3840`, `2160`, `8K` appear in the prohibition sentence "Do NOT describe it as '4K output', '8K', '3840×2160', or '2160p'" — this is correct guard text, not an output claim.
- `01-cinematic`, `07-ecommerce-ad`, `09-product-360`, `13-fashion-lookbook`: `4k` references are legitimately scoped to image-model resolution enums (`cinematic_studio_2_5`, `ms_image`, `seedream_v4_5`) with explicit notes that they do not apply to video models.
- `05-fight-scenes`, `11-social-hook`: `4k` in `kling3_0`/`kling2_6` mode enum documented with explicit prohibition against interpreting as 4K output file.

**No files required fixes.**

---

## Task 2 — README.md Rewrite

### DOC-01: Accuracy

- All 15 skills listed with `higgsfield-*` names and one-line use cases
- Install instructions corrected: `./install.sh`, `--all`/`--list`/`--target code|desktop|project`, installs to `~/.claude/skills/` (both Claude Code and Desktop)
- Output constraint stated accurately: video up to 1080p; explicit note that `4k` mode enum is not a 4K output guarantee
- Repo structure section reflects actual layout: `skills/NN-name/{SKILL.md, references/}`, `shared/`, `install.sh`, `assets/`, `LICENSE`
- No references to files that do not exist
- Language-switcher banner removed; no links to deleted translation files

### DOC-02: Content

- **Model routing table:** All 15 skills with primary + fallback model (from STATE.md routing reference)
- **Opt-in generation explanation:** 4-step flow (build prompt → confirm with credit cost → generate → poll + display); explicit note that generation never happens automatically; I2V media upload path noted for skills 04/08/09/10
- **Higgsfield model ecosystem overview:** ~38 models, image (~20) + video (~18), with provider families listed (Higgsfield, Bytedance/Wan, Google/Veo, Kuaishou/Kling, xAI/Grok, Black Forest Labs/Flux, OpenAI/GPT Image, MiniMax)

### Dropped: skill-map.svg reference

`assets/skill-map.svg` was titled "Seedance 2.0 Skills Map" with zh-CN labels throughout (电影级视角, 三维渲染, etc.) — inaccurately describing the old single-model structure. The reference was dropped from the new README rather than shipping a misleading diagram. `assets/banner.svg` is retained; it has no model-specific or language-specific text.

---

## Task 3 — Stale Translation Cleanup

### Deleted files

| File | Reason |
|------|--------|
| `README.fr.md` | Described old Seedance-only repo; wrong install path; zh-CN branding |
| `README.de.md` | Described old Seedance-only repo; wrong install path; zh-CN branding |
| `README.es.md` | Described old Seedance-only repo; wrong install path; zh-CN branding |
| `README.ja.md` | Described old Seedance-only repo; wrong install path; zh-CN branding |
| `README.ko.md` | Described old Seedance-only repo; wrong install path; zh-CN branding |
| `README.pt.md` | Described old Seedance-only repo; wrong install path; zh-CN branding |
| `README.tr.md` | Described old Seedance-only repo; wrong install path; zh-CN branding |

All 7 files were at best inaccurate (wrong structure, wrong install paths) and at worst actively misleading (zh-CN branding, Seedance-only model claims). Project scope is English-only per PROJECT.md and the Phase 1 I18N-01 decision.

---

## Deviations from Plan

None — plan executed exactly as written. The only noteworthy finding was that the SPEC-02 pass was a clean confirmation (all 15 annotated, no invented specs) with no fixes required.

---

## Requirements Satisfied

| REQ-ID | Description | Status |
|--------|-------------|--------|
| SPEC-02 | Every per-model spec verified against models_explore, annotations confirmed | Complete |
| DOC-01 | README accurately describes real repo structure, correct stats, correct install path | Complete |
| DOC-02 | README documents routing table, opt-in generation flow, model ecosystem | Complete |

---

## Known Stubs

None. README content is fully sourced from verified data (model-catalog.md, STATE.md routing table, install.sh behavior, per-skill references/model-specs.md).

---

## Threat Flags

None. This phase is documentation-only — no new network endpoints, auth paths, or schema changes introduced.

---

## Self-Check: PASSED

- [x] `skills/*/references/model-specs.md` — 15 files exist, all annotated
- [x] `README.md` — rewritten, no phantom file references, no zh-CN text, no invented video specs
- [x] 7 translated README files deleted
- [x] `05-PLAN.md` created at `.planning/phases/05-spec-accuracy-documentation/`
- [x] `05-SUMMARY.md` created at `.planning/phases/05-spec-accuracy-documentation/`
