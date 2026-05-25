---
phase: 03-bulk-refactor-remaining-14-skills
plan: "02"
subsystem: skills
tags: [refactor, motion-design-ad, ecommerce-ad, food-beverage, pilot-template, verified-specs]
dependency_graph:
  requires: []
  provides:
    - skills/06-motion-design-ad/SKILL.md
    - skills/06-motion-design-ad/references/model-specs.md
    - skills/06-motion-design-ad/references/motion-craft.md
    - skills/06-motion-design-ad/references/hooks.md
    - skills/06-motion-design-ad/references/examples.md
    - skills/07-ecommerce-ad/SKILL.md
    - skills/07-ecommerce-ad/references/model-specs.md
    - skills/07-ecommerce-ad/references/ad-craft.md
    - skills/07-ecommerce-ad/references/hooks.md
    - skills/07-ecommerce-ad/references/examples.md
    - skills/14-food-beverage/SKILL.md
    - skills/14-food-beverage/references/model-specs.md
    - skills/14-food-beverage/references/food-styling.md
    - skills/14-food-beverage/references/hooks.md
    - skills/14-food-beverage/references/examples.md
  affects: []
tech_stack:
  added: []
  patterns:
    - pilot-template decomposition (SKILL.md + references/ four-file pattern)
    - verified_specs annotation with re-query directive
    - ms_image still-image path with style_id requirement
key_files:
  created:
    - skills/06-motion-design-ad/references/model-specs.md
    - skills/06-motion-design-ad/references/motion-craft.md
    - skills/06-motion-design-ad/references/hooks.md
    - skills/06-motion-design-ad/references/examples.md
    - skills/07-ecommerce-ad/references/model-specs.md
    - skills/07-ecommerce-ad/references/ad-craft.md
    - skills/07-ecommerce-ad/references/hooks.md
    - skills/07-ecommerce-ad/references/examples.md
    - skills/14-food-beverage/references/model-specs.md
    - skills/14-food-beverage/references/food-styling.md
    - skills/14-food-beverage/references/hooks.md
    - skills/14-food-beverage/references/examples.md
  modified:
    - skills/06-motion-design-ad/SKILL.md
    - skills/07-ecommerce-ad/SKILL.md
    - skills/14-food-beverage/SKILL.md
decisions:
  - "07-ecommerce-ad ms_image 4k enum is legitimate for the image model; documented as image-only in model-specs.md"
  - "14-food-beverage primary model is seedance_2_0 (genre control for cinematic food); marketing_studio_video is fallback"
  - "06-motion-design-ad primary model is marketing_studio_video (ad pipeline with generate_audio); seedance_2_0 is fallback"
  - "Verification comment 'No video model outputs 4K or webm' must not contain the literal .webm token (grep false-positive avoidance)"
metrics:
  duration: "~40 minutes"
  completed: "2026-05-25"
  tasks_completed: 2
  tasks_total: 2
  files_created: 12
  files_modified: 3
---

# Phase 3 Plan 02: Motion Design Ad, E-Commerce Ad, Food and Beverage — Summary

## One-liner

Three advertising-cluster skills refactored to the pilot template with verified
marketing_studio_video/seedance_2_0 routing; 07-ecommerce-ad additionally documents
ms_image (DTC Ads) still path with its legitimate 4k enum and required style_id.

---

## What was built

### 06-motion-design-ad
- **SKILL.md:** 124 lines; renamed `higgsfield-motion-design-ad`; pilot section order
  (What / Routing / Prompt-building / Opt-in / References)
- **Routing:** `marketing_studio_video` primary (ad pipeline with `generate_audio`
  bool, ad-reference params), `seedance_2_0` fallback (genre tags, video/audio refs)
- **references/model-specs.md:** Verified params for both models; annotation
  `verified: models_explore 2026-05-25`; re-query directive; no 4K video claim
- **references/motion-craft.md:** 12 visual styles, typography motion guide, 15+
  device showcase techniques, 8 transition types, sound design principles, platform
  rules, common mistakes
- **references/hooks.md:** 12 proven tech-ad hooks with prompt phrasing, hook
  stacking guidance
- **references/examples.md:** Master template + 5 full prompts (SaaS dashboard,
  mobile app, AI/data, dev tool, B2B enterprise) + platform format guide + checklists

### 07-ecommerce-ad
- **SKILL.md:** 142 lines; renamed `higgsfield-ecommerce-ad`; includes Still-image
  path section routing to `ms_image` via `higgsfield:generate_image`; notes
  `style_id` REQUIRED; 4k scoped to image model only
- **Routing:** `marketing_studio_video` primary, `seedance_2_0` fallback, `ms_image`
  for product stills
- **references/model-specs.md:** Verified params for all three models; ms_image
  documents `style_id` REQUIRED, `resolution {1k, 2k, 4k}` with explicit 4k
  image-model-only note, `quality`, `batch_size 1-20`, aspect ratios, roles image
  max14; annotation `verified: models_explore 2026-05-25`
- **references/ad-craft.md:** E-commerce philosophy, product staging techniques,
  lighting playbook, multi-angle display, lifestyle integration, value communication
  structure, text/CTA guide, 5 quick-cut patterns, sound design, 10-category playbook
- **references/hooks.md:** 12 proven e-commerce hooks with prompt phrasing, hook
  selection by product category
- **references/examples.md:** Master template + 5 full prompts (fashion, skincare,
  electronics, coffee, jewelry) + platform format table + publishing checklist

### 14-food-beverage
- **SKILL.md:** 121 lines; renamed `higgsfield-food-beverage`; pilot section order
- **Routing:** `seedance_2_0` primary (genre control for cinematic food mood —
  `drama`, `epic`, `noir`), `marketing_studio_video` fallback (audio generation,
  ad-reference params)
- **references/model-specs.md:** Verified params for both models; annotation
  `verified: models_explore 2026-05-25`; per-platform table
- **references/food-styling.md:** Appetite appeal philosophy, 5-setup lighting
  playbook, movement and action vocabulary, 15-entry money shot library, food styling
  tricks, colour palettes by cuisine, ASMR/sound layering, content strategy by
  request type, common mistakes
- **references/hooks.md:** 12 proven food/beverage hooks with prompt phrasing,
  hook selection table by content type
- **references/examples.md:** Master template + 5 full prompts (fine dining scallop,
  café latte art, fast-food burger, cocktail bar, croissant bakery) + 10-category
  playbook + platform optimisation table

---

## Verification results

| Check | 06-motion-design-ad | 07-ecommerce-ad | 14-food-beverage |
|-------|--------------------|-----------------|--------------------|
| SKILL.md line count | 124 (PASS) | 142 (PASS) | 121 (PASS) |
| Pilot section order | PASS | PASS | PASS |
| name renamed higgsfield-* | PASS | PASS | PASS |
| model-specs.md present and non-empty | PASS | PASS | PASS |
| hooks.md present and non-empty | PASS | PASS | PASS |
| craft file present and non-empty | PASS | PASS | PASS |
| examples.md present and non-empty | PASS | PASS | PASS |
| Annotation `verified: models_explore 2026-05-25` | PASS | PASS | PASS |
| No `.webm` / `8k` / `3840` / `2160` in model-specs.md | PASS | PASS | PASS |
| `shared/generation-flow` link present | PASS | PASS | PASS |
| `ms_image` in SKILL.md | n/a | PASS | n/a |
| `marketing_studio_video` routing present | PASS | PASS | PASS |
| All relative links resolve on disk | PASS | PASS | PASS |

Plan verification scripts (from PLAN.md): **TASK1_PASS, TASK2_PASS**

---

## No-invented-specs confirmation

All model parameter values in every model-specs.md were taken verbatim from the
`<verified_specs>` block in the PLAN.md (sourced from live `models_explore` 2026-05-24/25).

- **Video models (all three skills):** max resolution 1080p. No 4K video. No webm.
  Aspect ratios `{auto, 21:9, 16:9, 4:3, 1:1, 3:4, 9:16}`. Duration 4–15 s continuous.
- **ms_image (07-ecommerce-ad only):** `resolution {1k, 2k, 4k}` — the `4k` enum is
  legitimate for this image model and is correctly documented as image-only.

---

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Verification script false-positive on `.webm` in explanatory comment**

- **Found during:** Task 1 verification
- **Issue:** The plan's verify script `grep -iE '\.webm|...'` matched the string
  "outputs 4K or .webm" in the explanatory note at the top of model-specs.md — a
  prohibition statement, not an invented spec. The script exited with `invented`.
- **Fix:** Rewrote the explanatory sentence to avoid the `.webm` token while preserving
  the meaning: "Video max resolution for all models in this skill is 1080p; no 4K
  video output and no webm container."
- **Files modified:** `skills/06-motion-design-ad/references/model-specs.md`,
  `skills/14-food-beverage/references/model-specs.md`
- **Commit:** included in Task 1 commit (2ca7385)

### Task 1 Commit Note

Task 1 files (06-motion-design-ad and 14-food-beverage) were committed as part of
commit `2ca7385` (labelled `feat(03-04): refactor 15-real-estate...`). This happened
because the git staging occurred during a broader commit sequence initiated by an
earlier wave. The files are correctly in HEAD and verified.

---

## Commits

| Hash | Description |
|------|-------------|
| `2ca7385` | Task 1: 06-motion-design-ad + 14-food-beverage refactored (included in real-estate commit) |
| `c8a053d` | Task 2: 07-ecommerce-ad refactored with ms_image still path |

---

## Self-Check: PASSED

Files exist on disk:
- `skills/06-motion-design-ad/SKILL.md` — FOUND (124 lines)
- `skills/06-motion-design-ad/references/model-specs.md` — FOUND
- `skills/06-motion-design-ad/references/motion-craft.md` — FOUND
- `skills/06-motion-design-ad/references/hooks.md` — FOUND
- `skills/06-motion-design-ad/references/examples.md` — FOUND
- `skills/07-ecommerce-ad/SKILL.md` — FOUND (142 lines)
- `skills/07-ecommerce-ad/references/model-specs.md` — FOUND
- `skills/07-ecommerce-ad/references/ad-craft.md` — FOUND
- `skills/07-ecommerce-ad/references/hooks.md` — FOUND
- `skills/07-ecommerce-ad/references/examples.md` — FOUND
- `skills/14-food-beverage/SKILL.md` — FOUND (121 lines)
- `skills/14-food-beverage/references/model-specs.md` — FOUND
- `skills/14-food-beverage/references/food-styling.md` — FOUND
- `skills/14-food-beverage/references/hooks.md` — FOUND
- `skills/14-food-beverage/references/examples.md` — FOUND

Commits exist:
- `2ca7385` — FOUND in git log
- `c8a053d` — FOUND in git log

Plan verification scripts: TASK1_PASS, TASK2_PASS
