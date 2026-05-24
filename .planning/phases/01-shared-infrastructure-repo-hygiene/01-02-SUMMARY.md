---
phase: 01-shared-infrastructure-repo-hygiene
plan: 02
subsystem: shared-references
tags: [mcp-tools, generation-flow, infra, d-03, d-04, d-05]
requirements: [INFRA-03, INFRA-04]

dependency_graph:
  requires: [01-01]
  provides: [shared/mcp-tools.md, shared/generation-flow.md]
  affects: [all 15 skills in phases 2-3]

tech_stack:
  added: []
  patterns:
    - dual naming convention (higgsfield:tool_name prose / mcp__higgsfield__tool_name frontmatter)
    - canonical opt-in generation flow with mandatory confirmation gate
    - media_upload -> media_confirm atomic pair for I2V/audio skills

key_files:
  created:
    - shared/mcp-tools.md
    - shared/generation-flow.md
  modified: []

decisions:
  - "D-03 implemented: colon form in prose, double-underscore in allowed-tools, never interchanged"
  - "D-04 encoded: confirmation gate is a hard REQUIRED block, explicitly forbids any generate_* before YES"
  - "D-05 encoded: media_upload → media_confirm atomic pair documented as conditional branch with trigger conditions"
  - "Named the 4 always-I2V/audio skills (04, 08, 09, 10) in generation-flow.md so Phase 3 has a reference"

metrics:
  duration: ~10 minutes
  completed: 2026-05-24T20:07:00Z
  tasks_completed: 2
  tasks_total: 2
  files_created: 2
  files_modified: 0
---

# Phase 1 Plan 02: MCP Tool Reference and Generation Flow Summary

**One-liner:** Dual-naming MCP tool reference (all 11 tools, both syntactic forms) and canonical opt-in 6-step generation flow with mandatory confirmation gate, poll-only rule, and conditional media_upload→media_confirm branch for I2V/audio skills.

---

## Tasks Completed

| Task | Name | Commit | Files |
|------|------|--------|-------|
| 1 | Write shared/mcp-tools.md | d5c8db0 | shared/mcp-tools.md (366 lines) |
| 2 | Write shared/generation-flow.md | 41b42eb | shared/generation-flow.md (269 lines) |

---

## INFRA-03 Status: SATISFIED

`shared/generation-flow.md` documents:
- Step 1: Resolve model (models_explore for live schema)
- Step 2: Build prompt and assemble parameters
- Step 2b: Conditional media_upload → media_confirm atomic pair
- Step 3: Confirmation gate — **REQUIRED**, explicit YES before any generate call; credit info via balance + show_plans_and_credits
- Step 4: Generate — generate_image or generate_video, capture job_id
- Step 5: Poll — job_status with 30-60s backoff; hard rule against re-calling generate_*
- Step 6: Display — job_display, report job_id + asset URL
- Names 4 always-I2V/audio skills: 04-comic-to-video, 08-anime-action, 09-product-360, 10-music-video

## INFRA-04 Status: SATISFIED

`shared/mcp-tools.md` documents all 11 tools:
- Both naming forms for every tool (11/11 verified)
- Per-tool: purpose, returns, key parameters, credit cost
- Credit cost summary table
- Copy-paste allowed-tools block (full and minimal variants)
- References model-catalog.md for model lists (no duplication)

---

## Deviations from Plan

None — plan executed exactly as written.

---

## Threat Surface Scan

No new network endpoints, auth paths, file access patterns, or schema changes introduced.
Both files are markdown documentation — they cross no live trust boundary. Threat model
mitigations T-01-03, T-01-04, T-01-05 are all encoded in the documentation as instructed.

---

## Self-Check

```
shared/mcp-tools.md:     FOUND (366 lines, >60 minimum)
shared/generation-flow.md: FOUND (269 lines, >60 minimum)
commit d5c8db0:            FOUND
commit 41b42eb:            FOUND
all 11 tools, both forms:  PASS (verified by automated check)
generation-flow checks:    PASS (verified by automated check)
```

## Self-Check: PASSED
