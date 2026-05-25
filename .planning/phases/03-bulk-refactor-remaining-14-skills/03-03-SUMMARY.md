---
phase: 03-bulk-refactor-remaining-14-skills
plan: "03"
subsystem: skills
tags: [social-hook, brand-story, t2v, kling3_0, grok_video, cinematic_studio_3_0, veo3_1, soul_location, refactor, pilot-template]
dependency_graph:
  requires: [02-03-SUMMARY.md]
  provides: [skills/11-social-hook/SKILL.md, skills/12-brand-story/SKILL.md]
  affects: [skills/11-social-hook/references/, skills/12-brand-story/references/]
tech_stack:
  added: []
  patterns: [pilot-decomposition, informed-consent-fallback, soul_location-still-path]
key_files:
  created:
    - skills/11-social-hook/references/model-specs.md
    - skills/11-social-hook/references/hook-craft.md
    - skills/11-social-hook/references/platforms.md
    - skills/11-social-hook/references/examples.md
    - skills/12-brand-story/references/model-specs.md
    - skills/12-brand-story/references/narrative-craft.md
    - skills/12-brand-story/references/hooks.md
    - skills/12-brand-story/references/examples.md
  modified:
    - skills/11-social-hook/SKILL.md
    - skills/12-brand-story/SKILL.md
decisions:
  - "kling3_0 4k mode documented as generation-mode enum only — never described as 4K output resolution"
  - "soul_location still-image path added to 12-brand-story SKILL.md as first-class routing option"
  - "grok_video informed-consent fallback states no-tunable-params, start_image max 1, no end_image"
  - "veo3_1 informed-consent fallback explicitly states loss of 1:1, discrete durations [4,6,8], no end_image"
  - "11-social-hook hook encyclopedia (1874-line monolith) fully relocated to four reference files"
metrics:
  duration: "~45 minutes"
  completed: "2026-05-25"
  tasks_completed: 2
  tasks_total: 2
  files_created: 8
  files_modified: 2
---

# Phase 3 Plan 03: Social-Hook and Brand-Story Refactor Summary

Refactored 11-social-hook and 12-brand-story from the legacy Seedance 2.0 monolith format
to the validated pilot template — lean SKILL.md entry points routing verified models with
encyclopedic creative content preserved in per-skill reference files.

---

## Tasks Completed

| Task | Name | Commit | Files |
|------|------|--------|-------|
| 1 | Refactor 11-social-hook to pilot template | f368160 | SKILL.md (120 lines) + 4 reference files |
| 2 | Refactor 12-brand-story with soul_location still path | 2ca7385 | SKILL.md (142 lines) + 4 reference files |

---

## What Was Built

### 11-social-hook

**SKILL.md (120 lines, name: `higgsfield-social-hook`)**
Lean entry point routing `kling3_0` (primary) and `grok_video` (fallback). Includes
the model routing table, per-platform aspect ratio quick rule, prompt-building workflow,
opt-in generation section, and reference materials table. All encyclopedic content moved
to references/.

**references/model-specs.md** — Verified specs for both video models:
- `kling3_0`: mode {std, pro, 4k}, sound {on, off}, aspect {16:9, 9:16, 1:1}, duration
  3–15 s continuous, roles start_image + end_image. `4k` mode documented as generation
  enum, NOT output resolution.
- `grok_video`: no tunable params, aspect {16:9, 9:16, 1:1}, duration 1–15 s continuous,
  start_image max 1, native audio.
- Annotated `verified: models_explore 2026-05-25` with re-query directive.

**references/hook-craft.md** — The full hook encyclopedia: hook psychology (5 attention
triggers), 25+ proven hook patterns organized by mechanism (visual shock, curiosity gap,
emotional trigger, pattern interrupt, direct address), the 2-second master template,
retention techniques, sound strategy, text overlay strategy, and 10 common mistakes.

**references/platforms.md** — Per-platform optimization for TikTok, Instagram Reels, and
YouTube Shorts; 9 content-category playbooks (comedy, educational, satisfying,
transformation, BTS, reaction, storytime, product, lifestyle); trending format templates;
and analytics-driven iteration guidance.

**references/examples.md** — 5 production-ready worked hook prompts with full timing
breakdowns (satisfying transformation, comedy skit, product reveal, emotional story,
impossible visual) plus output structure reference and prompt construction guide.

---

### 12-brand-story

**SKILL.md (142 lines, name: `higgsfield-brand-story`)**
Lean entry point routing `cinematic_studio_3_0` (primary), `veo3_1` (fallback), and
`soul_location` (still-image). Includes the model routing table with explicit veo3_1
trade-off disclosure (no 1:1, discrete durations [4, 6, 8] only, no end_image), the
soul_location still path section with full aspect ratio list, prompt-building workflow,
opt-in generation section, and reference materials table.

**references/model-specs.md** — Verified specs for all three models:
- `cinematic_studio_3_0`: no tunable params, aspect {16:9, 9:16, 1:1}, duration 4–15 s
  continuous, roles image + start_image + end_image.
- `veo3_1`: quality {basic, high, ultra}, model {veo-3-1-preview, veo-3-1-fast def
  veo-3-1-fast}, aspect {16:9, 9:16} ONLY (no 1:1), durations [4, 6, 8] discrete, start_image
  max 1, native audio.
- `soul_location` (still): no tunable params, aspect {1:1, 4:3, 3:4, 16:9, 9:16, 3:2,
  2:3, 21:9, 9:21}.
- Annotated `verified: models_explore 2026-05-25` with re-query directive.

**references/narrative-craft.md** — Brand storytelling philosophy, 10 narrative arc
structures (origin, problem-solution, customer transformation, day-in-life, BTS,
manifesto, milestone, community spotlight, future vision, before-and-after), industry
approaches (tech startup, food, fashion, health, nonprofit), 5 emotional registers,
visual metaphor library, camera/lighting/color guidance, voiceover techniques, sound
design, and effectiveness checklist.

**references/hooks.md** — 12 essential brand story hooks with prompt cues, hook
stacking combinations, platform-specific hook guidance, and hook-to-narrative-arc
matching table.

**references/examples.md** — Master template for brand story prompts, 5 production-ready
worked example prompts (tech startup origin, artisan food, sustainable fashion manifesto,
health/wellness transformation, creative agency reel), brand story brief template, and
platform deployment guide.

---

## Verification Results

### 11-social-hook
- SKILL.md lines: 120 (target <=300, cap 500) — PASS
- All 4 reference files exist and non-empty — PASS
- `verified: models_explore 2026-05-25` annotation — PASS
- `kling3_0` in SKILL.md — PASS
- `grok_video` in SKILL.md — PASS
- `higgsfield-social-hook` name — PASS
- `../../shared/generation-flow.md` link resolves — PASS
- `references/model-specs.md` link resolves — PASS
- No invented specs (no .webm, 8k, 3840, 2160 as output claims) — PASS

### 12-brand-story
- SKILL.md lines: 142 (target <=300, cap 500) — PASS
- All 4 reference files exist and non-empty — PASS
- `verified: models_explore 2026-05-25` annotation — PASS
- `cinematic_studio_3_0` in SKILL.md — PASS
- `soul_location` in SKILL.md — PASS
- `veo3_1` in SKILL.md — PASS
- `higgsfield-brand-story` name — PASS
- veo3_1 1:1 loss stated — PASS
- veo3_1 discrete durations [4,6,8] stated — PASS
- `../../shared/generation-flow.md` link resolves — PASS
- `references/model-specs.md` link resolves — PASS
- No invented specs (no .webm, 8k, 3840, 2160) in model-specs.md — PASS

---

## Deviations from Plan

### Note on prior executor work

Both 11-social-hook and 12-brand-story refactors were found to have been partially or
fully committed by a prior parallel executor before this plan's execution ran. Specifically:

- **11-social-hook**: committed in `f368160` ("feat(03-04): refactor 13-fashion-lookbook
  to pilot template") — the files were present and verified on disk matching the plan
  specification.
- **12-brand-story**: committed in `2ca7385` ("feat(03-04): refactor 15-real-estate")
  — same pattern.

This plan's executor verified all files on disk against the plan's must_haves and
automated verification criteria. All checks passed. No content corrections were required.
The files on disk are the authoritative outputs regardless of which executor's write
operation produced the final committed version.

---

## No Invented Specs Confirmation

No video model in this plan is documented as outputting 4K files, .webm files, or
files with resolution 3840×2160 or 2160p:
- `kling3_0` `4k` mode is explicitly documented as a generation-mode enum, not an
  output-resolution claim.
- `grok_video`, `cinematic_studio_3_0`, `veo3_1`, and `soul_location` have no such
  claims anywhere in their model-specs.md entries.

## Self-Check: PASSED

- `skills/11-social-hook/SKILL.md` — EXISTS, 120 lines
- `skills/11-social-hook/references/model-specs.md` — EXISTS
- `skills/11-social-hook/references/hook-craft.md` — EXISTS
- `skills/11-social-hook/references/platforms.md` — EXISTS
- `skills/11-social-hook/references/examples.md` — EXISTS
- `skills/12-brand-story/SKILL.md` — EXISTS, 142 lines
- `skills/12-brand-story/references/model-specs.md` — EXISTS
- `skills/12-brand-story/references/narrative-craft.md` — EXISTS
- `skills/12-brand-story/references/hooks.md` — EXISTS
- `skills/12-brand-story/references/examples.md` — EXISTS
- Commits f368160 (11-social-hook) and 2ca7385/6125e22 (12-brand-story) — VERIFIED
