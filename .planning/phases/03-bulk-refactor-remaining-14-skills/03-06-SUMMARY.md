---
phase: "03-bulk-refactor-remaining-14-skills"
plan: "06"
subsystem: "skills/09-product-360, skills/10-music-video"
tags: [skill-refactor, gen-04, mandatory-media, i2v, audio, veo3_1, seedance_2_0]
dependency_graph:
  requires: [shared/generation-flow.md, shared/mcp-tools.md]
  provides: [skills/09-product-360/SKILL.md, skills/10-music-video/SKILL.md]
  affects: []
tech_stack:
  added: []
  patterns: [pilot-section-order, mandatory-media-branch, gen-04, decomposition-to-references]
key_files:
  created:
    - skills/09-product-360/references/model-specs.md
    - skills/09-product-360/references/angles.md
    - skills/09-product-360/references/hooks.md
    - skills/09-product-360/references/examples.md
    - skills/10-music-video/references/model-specs.md
    - skills/10-music-video/references/beat-sync.md
    - skills/10-music-video/references/genres.md
    - skills/10-music-video/references/examples.md
  modified:
    - skills/09-product-360/SKILL.md
    - skills/10-music-video/SKILL.md
decisions:
  - "09-product-360 routes seedance_2_0 (primary) / cinematic_studio_3_0 (fallback) for I2V; still path routes seedream_v4_5 (primary) / soul_cinematic (alternate)"
  - "10-music-video routes veo3_1 (primary, native audio) / veo3_1_lite (fallback); GEN-04 audio role mandatory"
  - "09 craft decomposed into angles.md (rotation, camera, lighting) + hooks.md + examples.md; 10 into beat-sync.md + genres.md + examples.md"
  - "veo3_1 durations are discrete [4,6,8] — multi-segment assembly required for full songs; documented in model-specs.md"
  - "seedream_v4_5 4K capability is image-only; documented clearly scoped to still path, not video"
metrics:
  duration: "~45 min"
  completed_date: "2026-05-25"
  tasks_completed: 2
  files_created: 8
  files_modified: 2
---

# Phase 3 Plan 06: Mandatory-Media Skills 09 and 10 (GEN-04) Summary

Refactored 09-product-360 (image-to-video from product photo) and 10-music-video
(audio-synchronized video generation) to the validated pilot template with the GEN-04
mandatory media_upload→media_confirm branch, verified model specs, and decomposed
creative content into reference files. Completes the GEN-04 set (04, 08, 09, 10).

---

## Completed Tasks

| Task | Name | Commit | Files |
|------|------|--------|-------|
| 1 | Refactor 09-product-360 as mandatory-I2V skill | 45eab4a | SKILL.md (143 lines) + 4 reference files |
| 2 | Refactor 10-music-video as mandatory-audio skill | bccc5fa | SKILL.md (139 lines) + 4 reference files |

---

## What Was Built

### Task 1: 09-product-360 (GEN-04 image role: start_image)

**SKILL.md** (143 lines, pilot section order):
- Name renamed: `higgsfield-product-360`
- "What this skill does" states plainly: a product photo is always required
- Model routing table: `seedance_2_0` (primary) / `cinematic_studio_3_0` (fallback)
- Still-image path section: `seedream_v4_5` (primary, 4K image-only) / `soul_cinematic`
- "Opt-in generation" — MANDATORY (GEN-04) media branch:
  `higgsfield:media_upload` → `higgsfield:media_confirm` → attach role `start_image`
- Links to `../../shared/generation-flow.md` Step 2b
- Both `mcp__higgsfield__media_upload` and `mcp__higgsfield__media_confirm` in allowed-tools

**References (4 files):**
- `model-specs.md` (123 lines): verified specs for seedance_2_0 + cinematic_studio_3_0 + still models; annotation `verified: models_explore 2026-05-25`
- `angles.md` (200 lines): hero angle selection by category, rotation speed/patterns, 20 camera movements, multi-image strategy (3–9 photos), per-category lighting guide for 9 categories, material showcase techniques
- `hooks.md` (131 lines): 12 hook styles with phrasing, category matching table, hook-stacking guide
- `examples.md` (247 lines): master template + 5 worked product-360 prompts (watch, sneaker, earbuds, fragrance, car seat covers) + common mistakes and fixes

### Task 2: 10-music-video (GEN-04 audio role: audio)

**SKILL.md** (139 lines, pilot section order):
- Name renamed: `higgsfield-music-video`
- "What this skill does" states plainly: an audio track is always required
- Model routing table: `veo3_1` (primary, native audio, aspect 16:9/9:16 only, durations [4,6,8]) / `veo3_1_lite` (fallback)
- Documents both native-audio capability AND user audio-track attach via media branch
- Informed-consent fallback phrasing: user must accept veo3_1_lite trade-offs before switch
- "Opt-in generation" — MANDATORY (GEN-04) media branch:
  `higgsfield:media_upload` → `higgsfield:media_confirm` → attach role `audio`
- Shows how to pass both audio and start_image simultaneously in input_files
- Links to `../../shared/generation-flow.md` Step 2b
- Both `mcp__higgsfield__media_upload` and `mcp__higgsfield__media_confirm` in allowed-tools

**References (4 files):**
- `model-specs.md` (121 lines): verified specs for veo3_1 + veo3_1_lite; per-platform recommendations; multi-segment assembly note; annotation `verified: models_explore 2026-05-25`
- `beat-sync.md` (260 lines): philosophy, 12 hook styles, 7 beat-sync techniques, energy arc table, performance/narrative/abstract strategies, camera techniques, multi-segment strategy
- `genres.md` (306 lines): color-mood-genre quick reference table + 10 genre visual language entries (hip-hop, pop, rock/metal, EDM, R&B, lo-fi, classical, jazz, country, K-pop)
- `examples.md` (325 lines): master template + 5 worked prompts (hip-hop performance, pop ballad, EDM abstract, R&B narrative, K-pop choreography) + lyric video techniques

---

## GEN-04 Compliance Verification

| Check | 09-product-360 | 10-music-video |
|-------|---------------|----------------|
| SKILL.md ≤ 500 lines | 143 lines | 139 lines |
| media_upload in body (higgsfield: form) | Yes | Yes |
| media_confirm in body (higgsfield: form) | Yes | Yes |
| mcp__higgsfield__media_upload in allowed-tools | Yes | Yes |
| mcp__higgsfield__media_confirm in allowed-tools | Yes | Yes |
| Media role explicit | start_image | audio |
| Link to shared/generation-flow.md | Yes | Yes |
| Link to shared/mcp-tools.md | Yes | Yes |
| verified: models_explore 2026-05-25 in model-specs.md | Yes | Yes |
| No invented specs (.webm, 8k, 3840, 2160 absent from model-specs.md) | Yes | Yes |
| 4K scoped to image model only (seedream_v4_5, image-only) | Yes — stated "image model only" | N/A — no 4K in music-video |

---

## Threat Mitigations Applied

| Threat ID | Mitigation |
|-----------|-----------|
| T-03-16 (pending media ID passed to generate) | Both SKILL.md files mandate the atomic pair before generate; link to generation-flow Step 2b |
| T-03-17 (false 4K/.webm video claims) | No .webm/8k/3840/2160 in any model-specs.md; 4K scoped to seedream_v4_5 image-only with explicit note |
| T-03-18 (wrong media role wastes generation) | 09 explicitly states role start_image; 10 explicitly states role audio; model-specs.md reinforces both |

---

## Deviations from Plan

None — plan executed exactly as written. Both skills' files were committed during the
03-05 orchestration run (45eab4a for 09, bccc5fa for 10); this plan's executor verified
all content and checks passed.

---

## Known Stubs

None. Both skills have verified model specs, resolving links, and no placeholder content.

---

## Threat Flags

None. No new network endpoints, auth paths, file access patterns, or schema changes
introduced.

---

## Self-Check: PASSED

- skills/09-product-360/SKILL.md: EXISTS (143 lines)
- skills/09-product-360/references/model-specs.md: EXISTS
- skills/09-product-360/references/angles.md: EXISTS
- skills/09-product-360/references/hooks.md: EXISTS
- skills/09-product-360/references/examples.md: EXISTS
- skills/10-music-video/SKILL.md: EXISTS (139 lines)
- skills/10-music-video/references/model-specs.md: EXISTS
- skills/10-music-video/references/beat-sync.md: EXISTS
- skills/10-music-video/references/genres.md: EXISTS
- skills/10-music-video/references/examples.md: EXISTS
- Commits 45eab4a (09) and bccc5fa (10) verified in git log
- All automated verification checks: PASS
