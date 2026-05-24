# Phase 1 — Planning Context

**Phase:** 01-shared-infrastructure-repo-hygiene
**Planned:** 2026-05-24
**Requirements:** INFRA-01, INFRA-02, INFRA-03, INFRA-04, INFRA-05, STRUCT-04, I18N-01

This phase writes NO skill content. It builds the load-bearing `shared/` references,
creates a real LICENSE, cleans phantom repo references, removes dead zh-CN translations,
and documents the frontmatter STANDARD that Phases 2-3 will apply per-skill.

## Locked Decisions (from PROJECT.md + ROADMAP.md + research)

| ID | Decision | Source |
|----|----------|--------|
| D-01 | `shared/` lives at repo root (sibling to `skills/`), NOT a skill directory (no SKILL.md). Skills reference it via relative path `../../shared/`. | INFRA-01, ARCHITECTURE.md Pattern 4 |
| D-02 | Model catalog values come ONLY from PROJECT.md's captured `models_explore` data (2026-05-24). NEVER invent resolutions, durations, fps, or formats. Annotate with `<!-- verified: models_explore 2026-05-24 -->`. | INFRA-02, Pitfall 2 |
| D-03 | MCP tool naming: `higgsfield:tool_name` (colon) in prose/SKILL.md body; `mcp__higgsfield__tool_name` (double underscore) in `allowed-tools` frontmatter. Same tool, different syntactic context. | INFRA-04, STACK.md §4 |
| D-04 | Generation is opt-in only. The canonical flow has a REQUIRED confirmation gate (model + params + credit cost via `balance`/`show_plans_and_credits`) before any `generate_*` call. Poll `job_status`, never resubmit. | INFRA-03, Pitfall 3 |
| D-05 | The generation flow includes a conditional `media_upload` → `media_confirm` branch for I2V/audio skills (atomic pair). | INFRA-03, GEN-04 |
| D-06 | LICENSE = MIT. CONTRIBUTING.md already references `[MIT License](LICENSE)`, confirming intended license; PROJECT.md describes a skills/prompt collection. | INFRA-05 |
| D-07 | I18N-01 scope = remove zh-CN ONLY: all 15 `skills/*/zh-CN/` dirs + `README.zh-CN.md` + `README.zh-TW.md`. Keep EN. FR README.fr.md is retained (FR work is Phase 4). | I18N-01, phase goal |
| D-08 | STRUCT-04 in this phase establishes only the STANDARD doc (`shared/skill-template.md`): name ≤64 chars lowercase-hyphens unique across EN+FR variants; description ≤1024 chars third-person with "Use when…" triggers. Per-skill frontmatter rewriting happens in Phases 2-3. | STRUCT-04, phase goal |

## Repo facts discovered (2026-05-24)

- Repo IS a git repo (`.git` present).
- `LICENSE` MISSING. `logs.md` MISSING (both phantom in docs).
- `logs.md` referenced in `README.md:130` and `README.fr.md:120`.
- `LICENSE` referenced in `README.md:129`, `README.fr.md:119`, `CONTRIBUTING.md:98-99`, `GITHUB_SETUP.md:149`.
- 15 `skills/*/zh-CN/` directories exist (15 zh-CN SKILL.md files total).
- Root-level: `README.zh-CN.md`, `README.zh-TW.md` exist. Other non-EN/FR READMEs
  (de, es, ja, ko, pt, tr) also exist but are OUT OF SCOPE for this phase (only zh-* targeted).
- README.md is currently bilingual EN/zh-CN with a language switcher header listing 9 languages
  and a stats block claiming "30 SKILL.md (15 EN + 15 ZH)", "31,725 lines", "Languages: English + 简体中文".
- All 15 skills use `seedance-*` frontmatter names (valid format, but NOT rewritten this phase).

## Scope reduction guard

This phase delivers the STANDARD doc and the full shared references — not "v1 stubs."
`shared/model-catalog.md` covers ALL ~38 models from PROJECT.md (image + video), not a subset.
`shared/generation-flow.md` documents the COMPLETE flow including the media_upload branch.

## Out of scope (do NOT touch this phase)

- Any `skills/*/SKILL.md` content or frontmatter rewriting (Phases 2-3).
- `install.sh` (Phase 4).
- README.fr.md full rewrite / FR content (Phase 4 i18n; this phase only fixes its phantom
  `logs.md`/`LICENSE` structure references so they are accurate).
- Removal of de/es/ja/ko/pt/tr README variants (not in phase requirements; only zh-* removed).
- Live `models_explore` re-verification (Phase 5 spec accuracy pass; this phase uses the
  captured 2026-05-24 catalog from PROJECT.md as source of truth).
