---
phase: 03-bulk-refactor-remaining-14-skills
plan: "05"
subsystem: skills
tags: [i2v, gen04, media-branch, comic-to-video, anime-action, wan2_6, wan2_7, seedance_2_0]
dependency-graph:
  requires: [shared/generation-flow.md, shared/mcp-tools.md]
  provides: [skills/04-comic-to-video/SKILL.md, skills/08-anime-action/SKILL.md]
  affects: [generation-flow.md Step 2b mandatory branch, GEN-04 requirement]
tech-stack:
  added: []
  patterns: [mandatory-I2V, media_upload-media_confirm atomic pair, pilot section order, decomposed references]
key-files:
  created:
    - skills/04-comic-to-video/references/model-specs.md
    - skills/04-comic-to-video/references/panel-craft.md
    - skills/04-comic-to-video/references/hooks.md
    - skills/04-comic-to-video/references/examples.md
    - skills/08-anime-action/references/model-specs.md
    - skills/08-anime-action/references/anime-craft.md
    - skills/08-anime-action/references/hooks.md
    - skills/08-anime-action/references/examples.md
  modified:
    - skills/04-comic-to-video/SKILL.md
    - skills/08-anime-action/SKILL.md
decisions:
  - "04-comic-to-video routes wan2_6 primary (image REQUIRED, discrete durations [5,10,15]) / seedance_2_0 fallback (continuous 4-15s, genre control)"
  - "08-anime-action routes wan2_7 primary (start_image, continuous 2-15s) / wan2_6 fallback (image REQUIRED, discrete [5,10,15])"
  - "Both skills implement MANDATORY (not conditional) media branch per GEN-04 — phrased explicitly as non-conditional in SKILL.md body"
  - "Informed-consent rule applied to wan2_6 fallback for 08: user must be told about discrete durations and role change (start_image -> image)"
  - "All creative content preserved and relocated to references/ — no content discarded"
  - "No fr/ variants created — English-only scope enforced"
metrics:
  duration: "~25 minutes"
  completed: "2026-05-25"
  tasks: 2
  files: 10
---

# Phase 03 Plan 05: Comic-to-Video + Anime-Action I2V Refactor Summary

Refactored 04-comic-to-video (1811 lines) and 08-anime-action (1146 lines) into lean
mandatory-I2V skills implementing the GEN-04 media_upload → media_confirm branch.

---

## What Was Built

### 04-comic-to-video

Monolithic 1811-line skill rewritten to 135-line SKILL.md + 4 reference files (879 lines
total). Primary model changed from seedance-branded text to wan2_6 (verified I2V model
with mandatory image role). GEN-04 mandatory media branch implemented.

- **SKILL.md:** 135 lines — pilot section order, name `higgsfield-comic-to-video`,
  wan2_6/seedance_2_0 routing table, mandatory media branch, 9-tool allowed-tools block.
- **references/model-specs.md:** 104 lines — wan2_6 (image REQUIRED, discrete [5,10,15],
  720p/1080p, 3 aspect ratios) + seedance_2_0 (fallback, 480p-1080p, continuous 4-15s,
  genre control, 7 aspect ratios). Verification annotation present.
- **references/panel-craft.md:** 253 lines — reading-order guide (5 formats), art-style
  preservation keywords, dialogue handling, 15 panel-to-motion techniques, transition guide,
  multi-page sequencing, common mistakes table.
- **references/hooks.md:** 137 lines — 2-second hook framework, 10 hook techniques with
  prompt phrasing, selection guide by content type.
- **references/examples.md:** 385 lines — master template + 5 worked prompts (Western
  action, manga RTL, webtoon vertical, storyboard, single illustration) + platform table.

### 08-anime-action

Monolithic 1146-line skill rewritten to 141-line SKILL.md + 4 reference files (923 lines
total). Primary model changed to wan2_7 with wan2_6 I2V fallback. GEN-04 mandatory media
branch implemented with role differentiation (start_image vs image).

- **SKILL.md:** 141 lines — pilot section order, name `higgsfield-anime-action`,
  wan2_7/wan2_6 routing table with informed-consent fallback note, mandatory media branch
  with dual role documentation, 9-tool allowed-tools block.
- **references/model-specs.md:** 115 lines — wan2_7 (start_image, continuous 2-15s,
  720p/1080p, 5 aspect ratios) + wan2_6 (image REQUIRED, discrete [5,10,15], 720p/1080p,
  3 aspect ratios). Per-platform recommendations. Informed-consent rule. Verification
  annotation present.
- **references/anime-craft.md:** 292 lines — anime visual language (cel shading, limited
  animation, speed lines, color psychology, eye design, hair physics), action choreography
  (setup→apex→impact→aftermath, power scaling), style-transfer principles, camera techniques,
  lighting/color theory with saturation table, genre identity guide (11 genres), effects
  library (22 effects), character design keywords, common mistakes table.
- **references/hooks.md:** 161 lines — 2-second hook framework, 12 anime hook techniques
  with prompt phrasing, genre selection guide.
- **references/examples.md:** 355 lines — master template + 5 worked prompts (shonen fight,
  magical girl transformation, slice-of-life morning, mecha battle, emotional drama farewell)
  + platform/duration tables for both models.

---

## GEN-04 Compliance Verification

| Requirement | 04-comic-to-video | 08-anime-action |
|-------------|------------------|-----------------|
| `mcp__higgsfield__media_upload` in allowed-tools | PRESENT | PRESENT |
| `mcp__higgsfield__media_confirm` in allowed-tools | PRESENT | PRESENT |
| `higgsfield:media_upload` in SKILL.md body | PRESENT | PRESENT |
| `higgsfield:media_confirm` in SKILL.md body | PRESENT | PRESENT |
| Media branch described as MANDATORY | PRESENT | PRESENT |
| Link to `../../shared/generation-flow.md` Step 2b | PRESENT | PRESENT |
| Primary model routing | wan2_6 (image REQUIRED) | wan2_7 (start_image) |
| Fallback model routing | seedance_2_0 | wan2_6 (image REQUIRED) |

---

## Deviations from Plan

### Auto-fixed issues

None.

### Scope decisions

**04-comic-to-video — model name clarification:** The original skill used "Seedance 2.0 on
Higgsfield" branding throughout (referring to the product name, not specific API model IDs).
The plan specified `wan2_6` (primary) and `seedance_2_0` (fallback) as the verified model
IDs. SKILL.md uses these verified IDs. The creative content from the original monolith was
preserved and relocated verbatim into references/.

**08-anime-action — role differentiation documented:** The plan specified wan2_7 uses
`start_image` and wan2_6 fallback uses `image`. Both roles are explicitly documented in
SKILL.md body and in model-specs.md with the corresponding input_files JSON examples.
Informed-consent fallback language added as specified.

**False-positive stub scan:** The grep stub scan matched "etc." in a SKILL.md sentence
describing discrete duration values ("no 2, 3, 4, 6, 7, 8, 9 etc."). This is spec
language, not a stub pattern. No actual stubs exist.

---

## Known Stubs

None. Both skills fully wire to verified model IDs, the mandatory media branch, and
substantive reference libraries.

---

## Threat Flags

No new threat surface beyond what the plan's threat model covers. T-03-13, T-03-14, and
T-03-15 are mitigated as designed:

- **T-03-13 (pending ID to generate):** Mitigated — both SKILL.md files mandate
  media_upload → media_confirm atomic pair before generate, with explicit "Never pass
  a pending_id" language.
- **T-03-14 (missing required image):** Mitigated — both model-specs.md files call out
  the REQUIRED image role; both SKILL.md files state the source image is always needed.
- **T-03-15 (false 4K/.webm output claims):** Mitigated — verified grep gate found no
  `.webm`, `8k`, `3840`, or `2160` tokens in either model-specs.md. Max resolution is
  1080p as verified.

---

## Self-Check

**Files exist:**
- skills/04-comic-to-video/SKILL.md: FOUND
- skills/04-comic-to-video/references/model-specs.md: FOUND
- skills/04-comic-to-video/references/panel-craft.md: FOUND
- skills/04-comic-to-video/references/hooks.md: FOUND
- skills/04-comic-to-video/references/examples.md: FOUND
- skills/08-anime-action/SKILL.md: FOUND
- skills/08-anime-action/references/model-specs.md: FOUND
- skills/08-anime-action/references/anime-craft.md: FOUND
- skills/08-anime-action/references/hooks.md: FOUND
- skills/08-anime-action/references/examples.md: FOUND

**Commits exist:**
- 45eab4a: feat(03-05): refactor 04-comic-to-video as mandatory-I2V skill (GEN-04)
- 6076386: feat(03-05): refactor 08-anime-action as mandatory-I2V skill (GEN-04)

**Line counts:**
- 04-comic-to-video/SKILL.md: 135 lines (limit 500) — PASS
- 08-anime-action/SKILL.md: 141 lines (limit 500) — PASS

## Self-Check: PASSED
