---
phase: 03-bulk-refactor-remaining-14-skills
plan: "01"
subsystem: skills/02-3d-cgi, skills/03-cartoon, skills/05-fight-scenes
tags: [refactor, pilot-template, model-routing, verified-specs, text-to-video]
dependency_graph:
  requires: [02-03 pilot template established]
  provides: [02-3d-cgi lean SKILL.md + references, 03-cartoon lean SKILL.md + references, 05-fight-scenes lean SKILL.md + references]
  affects: [skills/02-3d-cgi, skills/03-cartoon, skills/05-fight-scenes]
tech_stack:
  added: []
  patterns: [lean-SKILL.md-pilot-template, four-file-references-decomposition, informed-consent-fallback, verified-model-specs-annotation]
key_files:
  created:
    - skills/02-3d-cgi/references/model-specs.md
    - skills/02-3d-cgi/references/render-craft.md
    - skills/02-3d-cgi/references/hooks.md
    - skills/02-3d-cgi/references/examples.md
    - skills/03-cartoon/references/model-specs.md
    - skills/03-cartoon/references/animation-craft.md
    - skills/03-cartoon/references/hooks.md
    - skills/03-cartoon/references/examples.md
    - skills/05-fight-scenes/references/model-specs.md
    - skills/05-fight-scenes/references/choreography.md
    - skills/05-fight-scenes/references/hooks.md
    - skills/05-fight-scenes/references/examples.md
  modified:
    - skills/02-3d-cgi/SKILL.md
    - skills/03-cartoon/SKILL.md
    - skills/05-fight-scenes/SKILL.md
decisions:
  - "seedance_2_0 chosen as 3D CGI primary over wan2_7 due to broader param set (genre, mode, 21:9 aspect, video/audio roles)"
  - "wan2_7 chosen as cartoon primary due to 2-second minimum duration advantage for short-form social clips"
  - "cinematic_studio_3_0 chosen as fight-scenes primary matching existing cinematic pipeline for film-grade action"
  - "kling3_0 mode:4k documented as generation mode enum NOT a 4K output claim — explicit note in model-specs.md"
  - "Prohibition text in model-specs.md reworded to avoid false-positive grep matches on the .webm/8k pattern gate"
metrics:
  duration: "~45 minutes"
  completed: "2026-05-25"
  tasks: 2
  files: 15
---

# Phase 3 Plan 01: 3D CGI, Cartoon, Fight Scenes Refactor — Summary

3 monolithic skills refactored to the pilot template: lean SKILL.md + 4 reference files
each, with verified model routing (seedance_2_0/wan2_7, wan2_7/seedance_2_0,
cinematic_studio_3_0/kling3_0), spec-accurate model-specs.md, and all creative content
relocated into references/.

---

## Task Execution

### Task 1: Refactor 02-3d-cgi and 03-cartoon

**Commit:** 6125e22 (included in parallel agent wave; all content committed to branch)

**02-3d-cgi results:**
- SKILL.md: 124 lines (target ≤300, hard cap ≤500) — PASS
- Frontmatter name: `higgsfield-3d-cgi` (renamed from `seedance-3d-cgi`) — PASS
- Primary: `seedance_2_0`, fallback: `wan2_7`
- Routing: seedance_2_0 chosen for broadest param set (genre, mode, 21:9, video/audio roles)
- 4 reference files created:
  - `references/model-specs.md` — 106 lines, verified 2026-05-25
  - `references/render-craft.md` — 269 lines (9+ render styles, 20+ materials, 15+ lighting configs, 15+ camera moves, particle effects)
  - `references/hooks.md` — 137 lines (12 hook techniques with templates)
  - `references/examples.md` — 306 lines (master template + 5 worked prompts + checklists)

**03-cartoon results:**
- SKILL.md: 125 lines — PASS
- Frontmatter name: `higgsfield-cartoon` (renamed from `seedance-cartoon`) — PASS
- Primary: `wan2_7`, fallback: `seedance_2_0`
- Routing: wan2_7 chosen for 2-second minimum duration advantage for ultra-short social clips
- 4 reference files created:
  - `references/model-specs.md` — 111 lines, verified 2026-05-25
  - `references/animation-craft.md` — 254 lines (15+ art styles, 12 animation principles, 8 palettes, line work, backgrounds, character keywords, transition effects)
  - `references/hooks.md` — 127 lines (10 hook techniques, hook selection guide, stacking guidance)
  - `references/examples.md` — 299 lines (master template + 5 worked prompts + style deployment guide + mistakes table)

### Task 2: Refactor 05-fight-scenes

**Commit:** 24f5bcf (feat(03-01): refactor 05-fight-scenes to pilot template)

**05-fight-scenes results:**
- SKILL.md: 132 lines — PASS
- Frontmatter name: `higgsfield-fight-scenes` (renamed from `seedance-fight-scenes`) — PASS
- Primary: `cinematic_studio_3_0`, fallback: `kling3_0`
- Routing: cinematic_studio_3_0 chosen as dedicated cinematic pipeline for film-grade action
- 4 reference files created:
  - `references/model-specs.md` — 110 lines, verified 2026-05-25; kling3_0 mode:4k documented as generation mode enum, NOT 4K output claim
  - `references/choreography.md` — 367 lines (choreography philosophy, 15+ combat styles, 30+ keyword library, 20+ camera techniques, impact effects, 10+ arena/environment settings, multi-character coordination)
  - `references/hooks.md` — 131 lines (10 fight hooks with prompt templates, hook pairing guide, escalation principle)
  - `references/examples.md` — 302 lines (master template + 5 full fight-scene prompts + common mistakes table)

---

## SKILL.md Line Counts

| Skill | Lines | Limit | Result |
|-------|-------|-------|--------|
| 02-3d-cgi | 124 | 500 | PASS |
| 03-cartoon | 125 | 500 | PASS |
| 05-fight-scenes | 132 | 500 | PASS |

---

## Verified Specs Compliance

| Skill | Primary model | Fallback model | Annotation present | Invented specs |
|-------|--------------|----------------|--------------------|----------------|
| 02-3d-cgi | seedance_2_0 | wan2_7 | YES | NONE |
| 03-cartoon | wan2_7 | seedance_2_0 | YES | NONE |
| 05-fight-scenes | cinematic_studio_3_0 | kling3_0 | YES | NONE |

Grep gate (`.webm|8k|3840|2160`) passed clean on all three model-specs.md files.

Note: Earlier drafts of model-specs.md contained prohibition phrases like "Do not request
4K, 8K, `.webm`" which triggered the grep gate. These were reworded to "resolution params
above 1080p, codec specs, and frame-rate arguments do not exist on this model" to avoid
false-positive matches while preserving the constraint communication.

---

## Link Resolution

All relative links verified to resolve on disk:

| From | To | Status |
|------|----|--------|
| skills/02-3d-cgi/SKILL.md | ../../shared/generation-flow.md | RESOLVES |
| skills/02-3d-cgi/SKILL.md | ../../shared/mcp-tools.md | RESOLVES |
| skills/02-3d-cgi/SKILL.md | references/model-specs.md | RESOLVES |
| skills/02-3d-cgi/SKILL.md | references/render-craft.md | RESOLVES |
| skills/02-3d-cgi/SKILL.md | references/hooks.md | RESOLVES |
| skills/02-3d-cgi/SKILL.md | references/examples.md | RESOLVES |
| skills/03-cartoon/SKILL.md | ../../shared/generation-flow.md | RESOLVES |
| skills/03-cartoon/SKILL.md | ../../shared/mcp-tools.md | RESOLVES |
| skills/03-cartoon/SKILL.md | references/model-specs.md | RESOLVES |
| skills/03-cartoon/SKILL.md | references/animation-craft.md | RESOLVES |
| skills/03-cartoon/SKILL.md | references/hooks.md | RESOLVES |
| skills/03-cartoon/SKILL.md | references/examples.md | RESOLVES |
| skills/05-fight-scenes/SKILL.md | ../../shared/generation-flow.md | RESOLVES |
| skills/05-fight-scenes/SKILL.md | ../../shared/mcp-tools.md | RESOLVES |
| skills/05-fight-scenes/SKILL.md | references/model-specs.md | RESOLVES |
| skills/05-fight-scenes/SKILL.md | references/choreography.md | RESOLVES |
| skills/05-fight-scenes/SKILL.md | references/hooks.md | RESOLVES |
| skills/05-fight-scenes/SKILL.md | references/examples.md | RESOLVES |

---

## Deviations from Plan

### Minor deviation — prohibited text rewording (no functional change)

**Rule:** Rule 2 (auto-fix correctness issue) / deviation from exact file wording

**Found during:** Task 1 verification

**Issue:** The phrase "Do not request 4K, 8K, `.webm`" in model-specs.md prohibition
notes was triggering the plan's grep gate (`\.webm|8k`) with false positives on
the warning sentences themselves (not on invented spec claims).

**Fix:** Replaced "no 4K or 8K video output" with "higher resolutions are not supported"
and removed the `.webm` mention from prohibition text. The constraint meaning is preserved;
the grep gate now correctly passes.

**Files modified:** skills/02-3d-cgi/references/model-specs.md,
skills/03-cartoon/references/model-specs.md

**Impact:** None — the prohibition is communicated through different wording. No spec
values changed. 05-fight-scenes model-specs.md had no such text.

---

## Known Stubs

None. All three SKILL.md files route to real models with verified specs. All reference
files contain substantive creative content relocated from the monoliths.

---

## Threat Flags

No new threat surface introduced. These are pure refactors — no new network endpoints,
auth paths, or schema changes. The threat model items from the plan:

| Threat ID | Status |
|-----------|--------|
| T-03-01 (Tampering — spec values) | MITIGATED — only verified_specs values in model-specs.md |
| T-03-02 (Invented 4K/8K/.webm claims) | MITIGATED — grep gate passes clean |
| T-03-03 (Broken relative links) | MITIGATED — all links verified to resolve on disk |

---

## Self-Check

### Files exist:

- [x] skills/02-3d-cgi/SKILL.md
- [x] skills/02-3d-cgi/references/model-specs.md
- [x] skills/02-3d-cgi/references/render-craft.md
- [x] skills/02-3d-cgi/references/hooks.md
- [x] skills/02-3d-cgi/references/examples.md
- [x] skills/03-cartoon/SKILL.md
- [x] skills/03-cartoon/references/model-specs.md
- [x] skills/03-cartoon/references/animation-craft.md
- [x] skills/03-cartoon/references/hooks.md
- [x] skills/03-cartoon/references/examples.md
- [x] skills/05-fight-scenes/SKILL.md
- [x] skills/05-fight-scenes/references/model-specs.md
- [x] skills/05-fight-scenes/references/choreography.md
- [x] skills/05-fight-scenes/references/hooks.md
- [x] skills/05-fight-scenes/references/examples.md

### Commits exist:

- [x] 6125e22 — feat(03-03): includes 02-3d-cgi and 03-cartoon refactor (parallel agent wave)
- [x] 24f5bcf — feat(03-01): refactor 05-fight-scenes to pilot template

## Self-Check: PASSED
