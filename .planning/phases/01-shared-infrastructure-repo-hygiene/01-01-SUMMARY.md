---
phase: 01-shared-infrastructure-repo-hygiene
plan: "01"
subsystem: shared-infrastructure
tags: [model-catalog, skill-template, frontmatter-standard, INFRA-01, INFRA-02, STRUCT-04]
dependency_graph:
  requires: []
  provides: [shared/model-catalog.md, shared/skill-template.md]
  affects: [Phase 2 per-skill model-specs.md, Phase 3 skill frontmatter rewrites]
tech_stack:
  added: []
  patterns: [progressive-disclosure, lean-SKILL.md, models_explore-at-runtime]
key_files:
  created:
    - shared/model-catalog.md
    - shared/skill-template.md
  modified: []
decisions:
  - "All non-seedance_2_0 model specs marked [from models_explore — re-verify] per D-02 — never fabricate"
  - "shared/ is not a skill directory (no SKILL.md added) per D-01"
  - "STRUCT-04 standard defined but no per-skill frontmatter rewritten (D-08)"
metrics:
  duration_seconds: 205
  completed_date: "2026-05-24"
  tasks_completed: 2
  tasks_total: 2
  files_created: 2
  files_modified: 0
---

# Phase 1 Plan 01: Shared Infrastructure (shared/ Directory) Summary

**One-liner:** Canonical ~38-model Higgsfield catalog with seedance_2_0 concrete specs and STRUCT-04 frontmatter standard documented in shared/.

## What Was Built

Two foundational reference files were created inside a new `shared/` directory at repo root
(sibling to `skills/`, with no SKILL.md — satisfying D-01/INFRA-01):

1. **`shared/model-catalog.md`** (574 lines) — Canonical catalog of all ~38 Higgsfield
   image and video models. Includes every model ID from PROJECT.md's captured
   `models_explore` data (2026-05-24). Concrete specs for `seedance_2_0` (4-15 s, 720p,
   with sound; input limits from repo README). All other per-model constraints marked
   `[from models_explore — re-verify]` per D-02 — no invented values.

2. **`shared/skill-template.md`** (217 lines) — STRUCT-04 frontmatter standard: `name`
   (≤64 chars, lowercase-hyphens, unique across EN+FR), `description` (≤1024 chars,
   third-person, "Use when..." clause), worked EN + FR `-fr` examples, and lean SKILL.md
   section order with 500-line cap and one-level reference depth rules.

## Requirements Satisfied

| Requirement | Status | Evidence |
|-------------|--------|---------|
| INFRA-01 | Satisfied | `shared/` exists at repo root, sibling to `skills/`, no SKILL.md |
| INFRA-02 | Satisfied | `shared/model-catalog.md` lists all ~38 models, verified annotation, re-query directive |
| STRUCT-04 | Satisfied | `shared/skill-template.md` defines the standard (per-skill application deferred to Phases 2-3 per D-08) |

## Commits

| Task | Hash | Message |
|------|------|---------|
| Task 1 | `197a375` | `feat(01-01): create shared/ and write model-catalog.md (INFRA-01, INFRA-02)` |
| Task 2 | `873078c` | `feat(01-01): write shared/skill-template.md (STRUCT-04 frontmatter standard)` |

## Deviations from Plan

None — plan executed exactly as written.

Both files were authored strictly from PROJECT.md's captured catalog (2026-05-24).
No per-model spec values were invented; all unknown fields carry the `[from models_explore — re-verify]` placeholder per D-02 and T-01-01 mitigation.

## Known Stubs

`shared/model-catalog.md` contains `[from models_explore — re-verify]` placeholders for
all models other than `seedance_2_0`. These are **intentional** — they are not stubs that
block the plan's goal. The plan's goal is a catalog with correct IDs and honest placeholders,
not a catalog with fabricated specs. The formal accuracy pass (live `models_explore`
re-verification) is scheduled for Phase 5 per D-02 / T-01-02.

## Threat Surface Scan

No new security-relevant surface introduced. This plan writes static markdown documentation
only — no network calls, no code execution, no untrusted input, no package installs (matches
threat model disposition for T-01-01 / T-01-02).

## Self-Check

**Files:**
- `shared/model-catalog.md` — FOUND (574 lines, >80 minimum)
- `shared/skill-template.md` — FOUND (217 lines, >40 minimum)
- No `shared/SKILL.md` — confirmed absent

**Model IDs verified present:** seedance_2_0, seedance_1_5, minimax_hailuo, wan2_6, wan2_7,
kling2_6, kling3_0, grok_video, veo3, veo3_1, veo3_1_lite, cinematic_studio_3_0,
cinematic_studio_video, marketing_studio_video, higgsfield_preset (video); nano_banana,
nano_banana_2, nano_banana_pro, soul_2, soul_cinematic, soul_cast, soul_location,
seedream_v4_5, seedream_v5_lite, z_image, flux_2, flux_kontext, kling_omni_image,
gpt_image, gpt_image_2, grok_image, cinematic_studio_2_5, marketing_studio_image,
ms_image, image_auto (image).

**No invented specs:** grep for `3840[x×]2160|\.webm|8K` — NOT FOUND. Check passed.

**Verification annotation:** `verified: models_explore 2026-05-24` — FOUND.

**skill-template.md checks:** "Use when" present, "64" present, "1024" present, "-fr"
present, "third person" present — ALL PASSED.

**Commits exist:**
- `197a375` — FOUND
- `873078c` — FOUND

## Self-Check: PASSED
