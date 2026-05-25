---
phase: 02-pilot-skill-01-cinematic-end-to-end
plan: 01
subsystem: skills/01-cinematic/references
tags: [model-specs, camera, hooks, examples, spec-accuracy, content-relocation]
completed: 2026-05-25

dependency_graph:
  requires: []
  provides:
    - skills/01-cinematic/references/model-specs.md
    - skills/01-cinematic/references/camera.md
    - skills/01-cinematic/references/hooks.md
    - skills/01-cinematic/references/examples.md
  affects:
    - skills/01-cinematic/SKILL.md (Plan 02-02 reads these files)
    - skills/01-cinematic/fr/SKILL.md (Plan 02-03 links to EN references)

tech_stack:
  added: []
  patterns:
    - Progressive disclosure via references/ directory (STRUCT-02)
    - Verified model-specs with re-query-on-failure directive (MODEL-06)
    - ToC required for reference files > 100 lines (skill-template.md rule)

key_files:
  created:
    - skills/01-cinematic/references/model-specs.md
    - skills/01-cinematic/references/camera.md
    - skills/01-cinematic/references/hooks.md
    - skills/01-cinematic/references/examples.md
  modified: []

decisions:
  - "model-specs.md sourced exclusively from verified models_explore data (2026-05-25); no invention"
  - "cinematic_studio_3_0 documented with NO tunable parameters (none exist in live schema)"
  - "veo3_1 duration is a discrete [4,6,8] list — explicitly called out as not a range"
  - "4k resolution enum documented only for cinematic_studio_2_5 (image model), not for video"
  - "All 6 bare '720p' hard claims removed from examples (SPEC-01); creative durations kept"
  - "Sound Design Guide and Platform Optimization sections from monolith NOT relocated — out of scope for this plan (they belong in SKILL.md lean body or a future reference file, decided by Plan 02-02)"

metrics:
  duration: ~35 minutes
  completed_date: 2026-05-25
  tasks_completed: 3
  tasks_total: 3
  files_created: 4
  files_modified: 0
---

# Phase 2 Plan 01: Build references/ files for 01-cinematic — Summary

**One-liner:** Four spec-accurate reference files extracted from the 1329-line monolith —
model-specs from verified models_explore data, camera/lighting/composition encyclopedia,
2-second hook framework, and 5 worked example prompts — with all bare 720p claims removed.

---

## Tasks Completed

| Task | Name | Commit | Files |
|------|------|--------|-------|
| 1 | Author model-specs.md from verified specs | `f5f5357` | `references/model-specs.md` (132 lines) |
| 2 | Extract camera.md and hooks.md from monolith | `2545a47` | `references/camera.md` (289 content lines), `references/hooks.md` (110 content lines) |
| 3 | Extract examples.md from monolith | `e3594c7` | `references/examples.md` (626 content lines) |

---

## What Was Built

### `references/model-specs.md` (132 lines)
Spec-accurate per-model reference table sourced from verified `higgsfield:models_explore`
data (2026-05-25). Documents:
- **cinematic_studio_3_0 (primary):** No tunable parameters; aspect ratios 16:9 / 9:16 / 1:1;
  duration 4–15s continuous range; media roles image, start_image, end_image (T2V + I2V).
- **veo3_1 (fallback):** quality {basic,high,ultra} default basic; model {veo-3-1-preview,
  veo-3-1-fast} default veo-3-1-fast; aspect_ratios 16:9 / 9:16 ONLY (no 1:1); durations
  discrete [4,6,8] (explicitly not a range); start_image max 1; native audio.
- **cinematic_studio_2_5 (still-image path):** resolution {1k,2k,4k} default 1k; five aspect
  ratios including portrait 3:4. Note: 4k is a legitimate enum for this image model only.
- Per-platform aspect ratio + duration recommendations table (MODEL-03/04).
- Re-query directive: call `higgsfield:models_explore` on any parameter rejection (MODEL-06).

### `references/camera.md` (289 content lines, with ToC)
Cinematic camera, lighting, and composition encyclopedia relocated from the monolith:
- 15 foundational camera techniques (establishing, push-in, pull-back, whip pan, parallax,
  handheld, tracking, crane, 360 orbit, rack focus, dutch angle, insert, OTS, bird's eye, POV)
- 22-entry camera movement encyclopedia table with exact prompt phrasing
- 10 lighting theory setups with mood targeting and prompt phrasing
- 15-entry lighting & atmosphere library table (production-ready setups)
- Composition rules (rule of thirds, leading lines, negative space, framing, symmetry)
- Pacing & rhythm principles (cut timing, velocity, silence/sound contrast)
- Atmosphere elements (fog, grain, bokeh, motion blur)
- 10+ color grading presets table with prompt phrasing

### `references/hooks.md` (110 content lines, with ToC)
2-Second Hook Framework relocated from the monolith:
- Why 2 seconds (neuroscience + platform rationale + cinematic examples)
- 12-entry hook technique table with prompt phrasing templates
- Advanced hook stacking (layering principle, 3 example stacks, timing scaffold, stack limit)
- Common hook mistakes with fixes

### `references/examples.md` (626 content lines, with ToC)
Worked example content relocated from the monolith:
- Prompt Construction Master Template (full 10-section structure)
- Timeline Segmentation Guide: 4s (Hook + Transition + Payoff), 8s (standard viral),
  10s (YouTube Short / Premium), 15s (full narrative arc) — each with beat pattern,
  pacing rhythm, audio alignment, and example prompt opening
- 5 full worked example prompts: Film Noir Detective, Epic Landscape Aerial Reveal,
  Dramatic Dialogue / Character Close-Up, High-Speed Chase, Emotional Intimate Farewell
- SPEC-01 cleanup: removed "Resolution: 720p" hard claim from all 5 OUTPUT SPECS sections
  and the "[Resolution: 720p standard]" token from the master template (6 removals total)

---

## Deviations from Plan

### Auto-fixed Issues

None.

### Scope decisions

**Sound Design Guide and Platform Optimization sections not relocated:** These two sections
from the monolith (~100 lines each) were not in the plan's stated source ranges and were
not assigned to any of the 3 task outputs. They are still present only in the original
SKILL.md monolith. Plan 02-02 will determine whether they belong in the lean SKILL.md body,
a future reference file, or are dropped.

This is not a bug — the plan explicitly listed source line ranges (31–62, 67–272, 453–528,
273–452, 581–1025) and the Sound Design (529–579) and Platform Optimization (1082–1170) and
Material Upload Strategy (1175–1252) sections were outside those ranges.

---

## Known Stubs

None. All four reference files contain real content relocated from the verified monolith or
authored from verified models_explore data. No placeholder text or hardcoded empty values.

---

## Threat Surface Scan

No new network endpoints, auth paths, file access patterns, or schema changes introduced.
This plan is pure markdown content authoring. No threat surface expansion.

---

## Self-Check

### Files exist
- `skills/01-cinematic/references/model-specs.md` — FOUND
- `skills/01-cinematic/references/camera.md` — FOUND
- `skills/01-cinematic/references/hooks.md` — FOUND
- `skills/01-cinematic/references/examples.md` — FOUND

### Commits exist
- `f5f5357` — feat(02-01): author references/model-specs.md from verified specs — FOUND
- `2545a47` — feat(02-01): extract references/camera.md and references/hooks.md — FOUND
- `e3594c7` — feat(02-01): extract references/examples.md from monolith — FOUND

### Spec accuracy
- No `.webm` in any reference file — VERIFIED
- No `3840`, `2160`, fps claims in any reference file — VERIFIED
- No `720p` in examples.md — VERIFIED
- `cinematic_studio_3_0` has no tunable parameters documented — VERIFIED
- `veo3_1` duration is `[4, 6, 8]` discrete list — VERIFIED
- `veo3_1` has no `1:1` aspect ratio — VERIFIED
- `4k` appears only in `cinematic_studio_2_5` section — VERIFIED

## Self-Check: PASSED
