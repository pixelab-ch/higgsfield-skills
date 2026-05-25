# Phase 2 — Planning Context

**Phase:** 02-pilot-skill-01-cinematic-end-to-end
**Planned:** 2026-05-25
**Requirements:** STRUCT-01, STRUCT-02, STRUCT-03, MODEL-01, MODEL-02, MODEL-03, MODEL-04, MODEL-05, MODEL-06, GEN-01, GEN-02, GEN-03, GEN-05, SPEC-01

This phase rebuilds `skills/01-cinematic/` as the **reference implementation** that proves the
SKILL.md template, progressive-disclosure structure, FR variant pattern, and opt-in generation
loop before Phase 3 replicates it across the other 14 skills. The shared infrastructure
(`shared/model-catalog.md`, `shared/generation-flow.md`, `shared/mcp-tools.md`,
`shared/skill-template.md`) already exists from Phase 1 and is the standard this phase applies.

Only `skills/01-cinematic/` is in scope. No other skill is touched. `shared/` is read-only here.

---

## Locked Decisions (inherited from Phase 1 + ground-truth model specs)

| ID | Decision | Source |
|----|----------|--------|
| D-01 | `shared/` is read-only here; skills reference it via `../../shared/`. SKILL.md links to `../../shared/generation-flow.md` and `../../shared/mcp-tools.md` — never duplicates them. | INFRA-01, ARCHITECTURE Pattern 2/4 |
| D-02 | Model specs come ONLY from verified `models_explore` data — never invented. The Phase 2 ground-truth capture (2026-05-24/25, below) supersedes the `[from models_explore — re-verify]` placeholders in `shared/model-catalog.md` for the three cinematic models. | INFRA-02, SPEC-01, Pitfall 2 |
| D-03 | MCP tool naming: `higgsfield:tool_name` (colon) in SKILL.md prose; `mcp__higgsfield__tool_name` (double underscore) in `allowed-tools` frontmatter. | INFRA-04, STACK §4 |
| D-04 | Generation is opt-in. SKILL.md points to the canonical flow's REQUIRED confirmation gate (model + params + credit cost via `balance`/`show_plans_and_credits`) before any `generate_*`. Poll `job_status`, never resubmit. | INFRA-03, GEN-01/02/03 |
| D-08 | Frontmatter follows `shared/skill-template.md`: `name` ≤64 chars lowercase-hyphens, third-person `description` ≤1024 chars with "Use when…" clause, `-fr` suffix for the FR variant. | STRUCT-04 |
| D-09 | EN `name: higgsfield-cinematic`; FR `name: higgsfield-cinematic-fr` (per `shared/skill-template.md` Example A/B and ROADMAP Phase 2 SC #3). The on-disk directory stays `skills/01-cinematic/`; install.sh (Phase 4) strips the `NN-` prefix so the installed dir matches the `name`. Document this mapping in the SUMMARY. | skill-template.md, ARCHITECTURE i18n |
| D-10 | SKILL.md hard cap 500 lines, target ≤300. Encyclopedic content moves to `references/camera.md`, `references/hooks.md`, `references/examples.md`, `references/model-specs.md` (one level deep, never chained). Reference files >100 lines get a ToC. | STRUCT-01, STRUCT-02 |
| D-11 | `references/*.md` are EN-only. The FR `fr/SKILL.md` links to the same EN reference files. | I18N-02 (pattern), ARCHITECTURE i18n |
| D-12 | Preserve the genuinely good existing creative content from the 1329-line monolith — restructure into references/, do NOT discard or rewrite from scratch. Drop only invented/legacy spec claims (the bare "720p" hard claims) per SPEC-01. | phase goal, STRUCT-02 |

## Ground-Truth Model Specs (verified live via models_explore, 2026-05-24/25)

These EXACT values populate `references/model-specs.md`. Do not invent or extrapolate.

### `cinematic_studio_3_0` — PRIMARY (Cinema Studio Video 3.0, Higgsfield)
- **Tunable parameters:** NONE (no quality/genre/mode/resolution knobs to set)
- **Aspect ratios:** `16:9`, `9:16`, `1:1`
- **Duration:** range 4–15s (continuous range)
- **Media roles:** `image`, `start_image`, `end_image` — supports text-to-video AND image-to-video
- **Rationale to declare (MODEL-01):** dedicated cinematic pipeline; chosen as primary for film-grade output

### `veo3_1` — FALLBACK (Google Veo 3.1)
- **Tunable parameters:** `quality` {`basic`, `high`, `ultra`} default `basic`; `model` {`veo-3-1-preview`, `veo-3-1-fast`} default `veo-3-1-fast`
- **Aspect ratios:** `16:9`, `9:16` ONLY (no `1:1`)
- **Duration:** discrete list `[4, 6, 8]` (NOT a range)
- **Media roles:** `start_image` (max 1); native audio
- **Rationale to declare (MODEL-01):** photorealism + native audio when the studio model is unavailable or the user wants voiced/sound output

### `cinematic_studio_2_5` — STILL-IMAGE PATH (Cinema Studio Image 2.5, Higgsfield) — MODEL-05
- **Tunable parameters:** `resolution` {`1k`, `2k`, `4k`} default `1k`
- **Aspect ratios:** `1:1`, `4:3`, `3:4`, `16:9`, `9:16`
- **Use case:** production still / mood-board frame before video
- **Note:** `4k` is a LEGITIMATE option for THIS image model only — it is a real enum value, not an invented spec. Nowhere else in the cinematic content may "4K" appear as a video claim.

### SPEC-01 cleanup target (current monolith)
- The current `skills/01-cinematic/SKILL.md` states bare "720p" video hard claims in ~7 places
  (lines 20, 24, 339, 634, 715, 804, 889, 986). These are dropped as hard claims (the goal
  explicitly permits dropping 720p). The rebuilt content states only what the verified specs
  above confirm. No `4K 3840x2160` (as a video claim), `.webm`, or fabricated fps anywhere.

## FR-in-Phase-2 vs Phase-4 — DISCREPANCY (flagged, resolved in favor of ROADMAP)

- **ROADMAP Phase 2 Success Criterion #3** explicitly requires `skills/01-cinematic/fr/SKILL.md`
  (`name: higgsfield-cinematic-fr`) as a Phase 2 deliverable — the FR variant is part of the
  pilot pattern (STRUCT-03: "the documented template other skills copy" includes the FR mirror).
- **REQUIREMENTS Traceability** assigns I18N-02 and I18N-03 to Phase 4, and **I18N-03** says
  "FR variants authored only after the EN skill is finalized."
- **Resolution (per phase constraints):** The FR pilot IS planned in Phase 2 because the ROADMAP
  Phase 2 success criteria mandate it. I18N-03's intent is honored: the FR task (Plan 02-03)
  runs in Wave 3, strictly AFTER the EN SKILL.md (Plan 02-02, Wave 2) is finalized and verified.
  Phase 4's I18N-02/I18N-03 then cover the BULK FR variants for skills 02–15 plus the final
  FR quality gate across all 15. Phase 2 produces only the single pilot FR variant as the proven
  pattern. **This is surfaced to the developer in the planner return** rather than silently chosen.

## Replicable Pattern (STRUCT-03) — what Phase 3 copies

The pilot establishes this exact decomposition. The SUMMARY for this phase must record it:
- `skills/NN-name/SKILL.md` — lean (≤300 lines): frontmatter (name/description/when_to_use/allowed-tools)
  → What this skill does → Model routing table (primary/fallback + per-platform aspect/duration)
  → Prompt-building workflow → Opt-in generation pointer to `../../shared/generation-flow.md`
  → Reference materials links → still-image path note.
- `skills/NN-name/references/` — `camera.md`, `hooks.md`, `examples.md`, `model-specs.md`
  (model-specs sourced from verified models_explore data, with verification date + re-query directive).
- `skills/NN-name/fr/SKILL.md` — `-fr` suffixed name, mirrors EN structure, links to the SAME EN references/.

## Out of scope (do NOT touch this phase)

- Any skill other than `01-cinematic`.
- `shared/*` files (read-only here; corrections to the catalog placeholders happen via the
  pilot's `references/model-specs.md`, not by editing `shared/model-catalog.md`).
- `install.sh` (Phase 4) and the `NN-` prefix directory rename (Phase 4).
- README.md / README.fr.md (Phase 5 / Phase 4).
- Bulk FR variants for skills 02–15 and the final cross-skill FR quality gate (Phase 4 I18N).
- `media_upload`/`media_confirm` mandatory branch (Phase 3 GEN-04; 01-cinematic only references
  the optional start_image case — it is NOT a mandatory-I2V skill).
- Live models_explore re-verification of every model (Phase 5 SPEC-02); this phase uses the
  ground-truth capture above for the three cinematic models.
