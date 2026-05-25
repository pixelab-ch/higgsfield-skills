---
phase: 03-bulk-refactor-remaining-14-skills
plan: "04"
subsystem: skills/13-fashion-lookbook, skills/15-real-estate
tags: [refactor, pilot-template, fashion, real-estate, model-routing, verified-specs]
dependency_graph:
  requires: []
  provides:
    - skills/13-fashion-lookbook/SKILL.md (higgsfield-fashion-lookbook, cinematic_studio_video_v2 primary + soul_cinematic still path)
    - skills/15-real-estate/SKILL.md (higgsfield-real-estate, cinematic_studio_3_0 primary)
  affects:
    - skills/13-fashion-lookbook/references/*
    - skills/15-real-estate/references/*
tech_stack:
  added: []
  patterns:
    - pilot SKILL.md section order (What this skill does / Model routing / Prompt-building workflow / Opt-in generation / Reference materials)
    - four-file references/ decomposition (model-specs, craft, hooks, examples)
    - verified: models_explore 2026-05-25 annotation in all model-specs.md files
key_files:
  created:
    - skills/13-fashion-lookbook/references/model-specs.md
    - skills/13-fashion-lookbook/references/styling.md
    - skills/13-fashion-lookbook/references/hooks.md
    - skills/13-fashion-lookbook/references/examples.md
    - skills/15-real-estate/references/model-specs.md
    - skills/15-real-estate/references/walkthrough-craft.md
    - skills/15-real-estate/references/hooks.md
    - skills/15-real-estate/references/examples.md
  modified:
    - skills/13-fashion-lookbook/SKILL.md
    - skills/15-real-estate/SKILL.md
decisions:
  - "cinematic_studio_video_v2 max duration is 12s (not 15s) — captured accurately in model-specs.md and SKILL.md routing table"
  - "soul_cinematic quality cap is 2k (no 4k enum) — explicitly noted in model-specs.md and SKILL.md still-image path"
  - "veo3_1 informed-consent: disclose no-1:1, discrete-durations, no-end_image before switching from cinematic_studio_3_0"
  - "15-real-estate walkthrough encyclopedia split into walkthrough-craft.md (camera, sequencing, lighting, staging, property types, sound)"
metrics:
  duration: "~45 minutes"
  completed_date: "2026-05-25"
  task_count: 2
  file_count: 10
---

# Phase 03 Plan 04: Fashion Lookbook + Real Estate Refactor Summary

Refactored 13-fashion-lookbook and 15-real-estate (largest monolith, 2344 lines) to the
validated pilot template: cinematic_studio_video_v2 routing with soul_cinematic still path
for fashion; cinematic_studio_3_0 / veo3_1 routing with informed-consent fallback disclosure
for real estate. All creative content preserved and relocated into references/.

---

## Tasks Completed

| Task | Name | Commit | Files |
|------|------|--------|-------|
| 1 | Refactor 13-fashion-lookbook + soul_cinematic still path | f368160 | SKILL.md (rewritten, 134 lines), references/model-specs.md, references/styling.md, references/hooks.md, references/examples.md |
| 2 | Refactor 15-real-estate (largest monolith) | 2ca7385 | SKILL.md (rewritten, 122 lines), references/model-specs.md, references/walkthrough-craft.md, references/hooks.md, references/examples.md |

---

## Verified Specs Embedded

All model-specs.md files carry the annotation `verified: models_explore 2026-05-25`.

### 13-fashion-lookbook

| Model | Key specs | Notes |
|-------|-----------|-------|
| cinematic_studio_video_v2 | genre{auto,action,horror,comedy,western,suspense,intimate,spectacle}, mode{pro,std}; aspect{1:1,4:3,3:4,16:9,9:16}; duration 3–12 s | 12s max — shorter than 15s models |
| seedance_2_0 | resolution{480p,720p,1080p def 720p}, mode{std,fast}, genre{auto,action,horror,comedy,noir,drama,epic}; aspect{auto,21:9,16:9,4:3,1:1,3:4,9:16}; duration 4–15 s; roles include video,audio | fallback; adds noir/drama/epic genres |
| soul_cinematic | quality{1.5k,2k} max 2k; soul_id optional; aspect{1:1,4:3,3:4,16:9,9:16,3:2,2:3,21:9} | still-image path via generate_image |

### 15-real-estate

| Model | Key specs | Notes |
|-------|-----------|-------|
| cinematic_studio_3_0 | NO tunable params; aspect{16:9,9:16,1:1}; duration 4–15 s continuous; roles image,start_image,end_image | primary; full aspect set including 1:1 |
| veo3_1 | quality{basic,high,ultra def basic}, model{veo-3-1-preview,veo-3-1-fast def veo-3-1-fast}; aspect{16:9,9:16} ONLY no 1:1; durations[4,6,8] discrete; start_image max1; native audio | fallback; informed-consent required |

---

## SKILL.md Line Counts

| Skill | Before | After | Target |
|-------|--------|-------|--------|
| 13-fashion-lookbook | 1237 lines (monolith) | 134 lines | ≤500 |
| 15-real-estate | 2344 lines (monolith) | 122 lines | ≤300 target, ≤500 hard cap |

---

## Link Check

All relative links in both SKILL.md files resolve on disk:

**13-fashion-lookbook:**
- `references/model-specs.md` — PASS
- `references/styling.md` — PASS
- `references/hooks.md` — PASS
- `references/examples.md` — PASS
- `../../shared/generation-flow.md` — PASS
- `../../shared/mcp-tools.md` — PASS

**15-real-estate:**
- `references/model-specs.md` — PASS
- `references/walkthrough-craft.md` — PASS
- `references/hooks.md` — PASS
- `references/examples.md` — PASS
- `../../shared/generation-flow.md` — PASS
- `../../shared/mcp-tools.md` — PASS

---

## Deviations from Plan

None — plan executed exactly as written.

---

## Known Stubs

None — all routing tables, model specs, and creative content are fully populated with
verified values. No placeholder text or TODO markers in any file.

---

## Threat Surface Scan

No new network endpoints, auth paths, or schema changes introduced. All files are
static markdown documentation. Threat model items T-03-10, T-03-11, T-03-12 verified
mitigated:

- T-03-10: `.webm`, `8k`, `3840`, `2160` — grep confirms none present in any model-specs.md.
- T-03-11: `cinematic_studio_video_v2` duration documented as 3–12 s (not 15 s) in both
  model-specs.md and the SKILL.md routing table.
- T-03-12: All relative links verified resolving on disk (see link check above).

---

## Self-Check: PASSED

Files verified to exist:
- skills/13-fashion-lookbook/SKILL.md (134 lines)
- skills/13-fashion-lookbook/references/model-specs.md
- skills/13-fashion-lookbook/references/styling.md
- skills/13-fashion-lookbook/references/hooks.md
- skills/13-fashion-lookbook/references/examples.md
- skills/15-real-estate/SKILL.md (122 lines)
- skills/15-real-estate/references/model-specs.md
- skills/15-real-estate/references/walkthrough-craft.md
- skills/15-real-estate/references/hooks.md
- skills/15-real-estate/references/examples.md

Commits verified:
- f368160 (Task 1 — 13-fashion-lookbook)
- 2ca7385 (Task 2 — 15-real-estate)
