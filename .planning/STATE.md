# Project State — Higgsfield Skills Multi-Model Toolkit

_Last updated: 2026-05-25T00:00:00Z (plan 02-01 complete)_

---

## Project Reference

**Core value**: Given a creative request, Claude produces a model-correct, spec-accurate prompt and (on explicit confirmation) generates the asset on Higgsfield — without the user needing to know which of the ~38 Higgsfield models to pick or what parameters each accepts.

**Current focus**: Phase 2 — Pilot Skill (01-cinematic) End-to-End

**Milestone**: v1 — 15 model-aware Claude Agent Skills with opt-in generation

---

## Current Position

**Phase**: 2 of 5
**Plan**: 02-01 complete (02-02 and 02-03 pending)
**Status**: In progress
**Progress**: Phase 1 complete; Phase 2 plan 1/3 done; 1/5 phases complete

```
[=>        ] ~20%
Phase 1 ████░░░░░░ Phase 5
```

---

## Phase Summary

| Phase | Name | Status |
|-------|------|--------|
| 1 | Shared Infrastructure + Repo Hygiene | Complete |
| 2 | Pilot Skill (01-cinematic) End-to-End | In progress (02-01 done) |
| 3 | Bulk Refactor — Remaining 14 Skills | Not started |
| 4 | Install Script + FR i18n Polish | Not started |
| 5 | Spec Accuracy Pass + Documentation | Not started |

---

## Performance Metrics

**Requirements mapped**: 27/27 (100%)
**Phases complete**: 1/5
**Plans complete**: 4/? (01-01, 01-02, 01-03 done; 02-01 done — STRUCT-02, MODEL-01..06, SPEC-01)

---

## Accumulated Context

### Key Decisions Locked In

| Decision | Rationale |
|----------|-----------|
| `shared/` at repo root (not a skill) | Cross-skill references fail silently when one skill isn't installed; shared/ solves DRY without creating inter-skill dependencies |
| Hybrid model spec strategy (cached + runtime verify on failure) | Pure live calls add latency; pure hardcode drifts; hybrid is the middle ground |
| SKILL.md hard cap: 500 lines (target: 200–300) | Official Agent Skills constraint; monolithic files burn context on every invocation |
| Generation always requires explicit user confirmation | Higgsfield credits are real money; hard constraint in PROJECT.md |
| Languages: EN + FR only, zh-CN deleted | Existing zh-CN was 99% untranslated copies; user is French |
| FR variant lives in `fr/SKILL.md` inside each skill dir | Agent Skills have no built-in i18n; separate file with `-fr` suffixed name avoids registry collision |
| Pilot skill: 01-cinematic | Smallest existing skill (1,329 lines), broad appeal, uses cinematic_studio_3_0 (primary for 5/15 skills), no media_upload required — ideal de-risk target |
| cinematic_studio_3_0 has NO tunable parameters | Verified via models_explore 2026-05-25 — do not pass quality/genre/mode/resolution; pass only aspect_ratio and duration |
| veo3_1 duration is discrete [4,6,8], not a range | Cannot request 5s, 7s, 10s from veo3_1 — must use cinematic_studio_3_0 for other durations |
| 4k resolution is an image-model-only enum | cinematic_studio_2_5 (image) supports 4k; no video model in cinematic skill exposes a resolution param |
| I2V skills (04, 08, 09, 10) grouped together in Phase 3 | media_upload → media_confirm is an atomic pair; grouping ensures consistent implementation and validation |
| `install.sh` targets `~/.claude/skills/` | Both Claude Code and Claude Desktop use this path; old Desktop-only path was silent-fail |

### Critical Constraints

- **Never call `generate_image` or `generate_video` without explicit user confirmation** — credits are spent at call time, no refund
- **SKILL.md must stay under 500 lines** — official Agent Skills hard cap; aim 200–300
- **Skills 04, 08, 09, 10 require `media_upload` → `media_confirm` before `generate_video`** — API rejects calls without a confirmed uploaded media reference
- **All specs must be sourced from `models_explore`** — no invented resolutions, durations, or formats (the "4K/.webm" errors in the existing repo are the canonical failure case)
- **MCP tool names**: `higgsfield:tool_name` in prose, `mcp__higgsfield__tool_name` in `allowed-tools` frontmatter

### Research Flags for Planning

- **Phase 3 I2V sub-group (skills 04, 08, 09, 10)**: Run a live `models_explore` verification of wan2_6, seedance_2_0, and veo3_1 media role schemas at plan-phase time — `start_image` mandatory vs optional status and `audio` role availability are the most likely to have drifted
- **Phase 4**: Verify `~/.claude/skills/` path is active in Claude Desktop before finalizing install script path logic

### Style → Model Routing Reference

| Skill | Primary | Fallback | I2V Required? |
|-------|---------|----------|---------------|
| 01-cinematic | cinematic_studio_3_0 | veo3_1 | No (optional start_image) |
| 02-3d-cgi | seedance_2_0 | wan2_7 | No |
| 03-cartoon | wan2_7 | seedance_2_0 | No |
| 04-comic-to-video | wan2_6 | seedance_2_0 | YES — start_image always |
| 05-fight-scenes | cinematic_studio_3_0 | kling3_0 | No |
| 06-motion-design-ad | marketing_studio_video | seedance_2_0 | No |
| 07-ecommerce-ad | marketing_studio_video | ms_image | No (optional) |
| 08-anime-action | wan2_7 | wan2_6 | YES — start_image for I2V path |
| 09-product-360 | seedance_2_0 | cinematic_studio_3_0 | YES — start_image always |
| 10-music-video | veo3_1 | veo3_1_lite | YES — audio role |
| 11-social-hook | kling3_0 | grok_video | No (optional start_image) |
| 12-brand-story | cinematic_studio_3_0 | veo3_1 | No |
| 13-fashion-lookbook | cinematic_studio_video | seedance_2_0 | No |
| 14-food-beverage | seedance_2_0 | marketing_studio_video | No |
| 15-real-estate | cinematic_studio_3_0 | veo3_1 | No |

---

## Todos

- [ ] Run `higgsfield:models_explore` at Phase 1 start to populate `shared/model-catalog.md` with live data
- [ ] Verify wan2_6, seedance_2_0, veo3_1 media role schemas at Phase 3 planning time (I2V sub-group)
- [ ] Check `~/.claude/skills/` path behavior in Claude Desktop before Phase 4 install script authoring

---

## Blockers

None.

---

## Session Continuity

**Last session**: 2026-05-25T00:00:00Z — completed plan 02-01 (references/model-specs.md, camera.md, hooks.md, examples.md for 01-cinematic)

**Stopped at**: Phase 2, Plan 02-02 (next to execute — rebuild lean SKILL.md for 01-cinematic)

**Next action**: Execute plan 02-02

**Context for next session**: references/ files are now complete. Plan 02-02 builds the lean SKILL.md for 01-cinematic (target ≤300 lines) using the model-specs, camera, hooks, and examples files as progressive-disclosure targets. The rebuilt SKILL.md links to ../../shared/generation-flow.md and ../../shared/mcp-tools.md. Name must be `higgsfield-cinematic`. After 02-02 is complete, plan 02-03 authors fr/SKILL.md (`higgsfield-cinematic-fr`).
