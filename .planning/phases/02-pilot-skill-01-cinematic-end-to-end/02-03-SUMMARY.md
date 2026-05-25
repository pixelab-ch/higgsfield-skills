---
phase: 02-pilot-skill-01-cinematic-end-to-end
plan: "03"
subsystem: skills/01-cinematic/fr
tags: [fr-variant, i18n, skill-template, cinematic, struct-03, replicable-pattern]
requires: ["02-02"]
provides:
  - "skills/01-cinematic/fr/SKILL.md (French mirror of EN cinematic entry point)"
  - "STRUCT-03 replicable pattern (documented below) for Phase 3 replication across 14 skills"
affects:
  - "Phase 3 — all 14 remaining skill directories copy this exact decomposition"
  - "Phase 4 — bulk FR variants for skills 02–15 follow the fr/ mirror convention proven here"
tech-stack:
  added: []
  patterns:
    - "FR-variant SKILL.md mirror (fr/ subdirectory, -fr name suffix, links to EN references)"
    - "Self-verifying link check (no blocking human checkpoint — automated path resolution)"
key-files:
  created:
    - skills/01-cinematic/fr/SKILL.md
decisions:
  - "name: higgsfield-cinematic-fr — unique from EN via -fr suffix (D-09); no registry collision"
  - "References stay EN-only (D-11) — FR file links to same ../references/*.md files, no fr/references/ created"
  - "Link depth recomputed for fr/ subdir: ../references/ and ../../../shared/ (verified all resolve)"
  - "Checkpoint self-verified by automated link resolution instead of blocking on human input (per task key_reminders)"
  - "157 lines — well under 500-line hard cap and target ≤300"
  - "allowed-tools identical to EN: 9 mcp__higgsfield__* tools, MCP tool names untranslated"
metrics:
  duration: "~20 minutes"
  completed: "2026-05-25"
  tasks_completed: 1
  tasks_total: 2
  files_modified: 1
---

# Phase 2 Plan 03: French FR Variant + STRUCT-03 Replicable Pattern Summary

**One-liner:** Created `higgsfield-cinematic-fr` French SKILL.md mirror (157 lines) with
correct fr/-relative links to EN references/ and shared infrastructure, and documented the
STRUCT-03 replicable decomposition pattern Phase 3 copies across the other 14 skills.

---

## Tasks Completed

| Task | Name | Commit | Files |
|------|------|--------|-------|
| 1 | Author skills/01-cinematic/fr/SKILL.md mirroring EN structure | f301d2e | skills/01-cinematic/fr/SKILL.md |
| 2 (checkpoint) | End-to-end navigation self-verify (link resolution) | — | All links verified by automated check |

---

## Link Resolution Self-Verify Results

Per the key reminders, the human-verify checkpoint was replaced by an automated link
resolution check. Every relative link in both `skills/01-cinematic/SKILL.md` (EN) and
`skills/01-cinematic/fr/SKILL.md` (FR) was resolved against the filesystem.

### EN SKILL.md links (base: `skills/01-cinematic/`)

| Link | Resolves To | Status |
|---|---|---|
| `references/model-specs.md` | `skills/01-cinematic/references/model-specs.md` | OK |
| `references/hooks.md` | `skills/01-cinematic/references/hooks.md` | OK |
| `references/camera.md` | `skills/01-cinematic/references/camera.md` | OK |
| `references/examples.md` | `skills/01-cinematic/references/examples.md` | OK |
| `../../shared/generation-flow.md` | `shared/generation-flow.md` | OK |
| `../../shared/mcp-tools.md` | `shared/mcp-tools.md` | OK |

All 11 EN links (including repeated references/) resolve — **PASS**.

### FR SKILL.md links (base: `skills/01-cinematic/fr/`)

| Link | Resolves To | Status |
|---|---|---|
| `../references/model-specs.md` | `skills/01-cinematic/references/model-specs.md` | OK |
| `../references/hooks.md` | `skills/01-cinematic/references/hooks.md` | OK |
| `../references/camera.md` | `skills/01-cinematic/references/camera.md` | OK |
| `../references/examples.md` | `skills/01-cinematic/references/examples.md` | OK |
| `../../../shared/generation-flow.md` | `shared/generation-flow.md` | OK |
| `../../../shared/mcp-tools.md` | `shared/mcp-tools.md` | OK |

All 11 FR links (including repeated references/) resolve — **PASS**.

**Total link verification: 22/22 links resolve. Zero broken links.**

---

## Requirement Verification

| Requirement | Status | Evidence |
|---|---|---|
| STRUCT-03 | PASS | Replicable pattern documented in full below |
| MODEL-01 | PASS | FR routing table mirrors EN: cinematic_studio_3_0 primary / veo3_1 fallback |
| MODEL-05 | PASS | FR still-image path section documents cinematic_studio_2_5 with 1k/2k/4k resolution |
| GEN-01 | PASS | FR generation section: "La génération consomme des crédits Higgsfield et requiert une confirmation explicite" |
| GEN-05 | PASS | FR allowed-tools identical to EN — 9 mcp__higgsfield__* tools |
| ROADMAP SC#3 | PASS | fr/SKILL.md exists, name: higgsfield-cinematic-fr, French body, correct links |
| ROADMAP SC#4 | PASS | End-to-end navigation self-verified: all links from SKILL.md → model-specs.md → shared flow resolve |

---

## Replicable Pattern (STRUCT-03)

This section documents the **exact decomposition** Phase 3 copies when building skills 02–15.
No re-derivation needed — follow this pattern verbatim.

---

### A. File Layout per Skill Directory

```
skills/NN-name/
├── SKILL.md                    ← lean entry point (≤300 lines target, 500 hard cap)
├── fr/
│   └── SKILL.md               ← French mirror (same structure, -fr name suffix)
└── references/
    ├── model-specs.md         ← per-model parameter tables (verified from models_explore)
    ├── camera.md              ← camera movement + lighting + composition encyclopedia
    ├── hooks.md               ← 2-second hook framework + technique library
    └── examples.md            ← production-quality worked example prompts by genre/platform
```

`references/` files are **EN-only** (D-11). The FR SKILL.md links to the same EN files —
no `fr/references/` directory is created.

---

### B. EN SKILL.md Section Order (MANDATORY — do not reorder)

1. **Frontmatter block** — `name`, `description`, `when_to_use`, `allowed-tools`
2. **H1 title** — `# Higgsfield [Style] Skill`
3. **## What this skill does** — 2–4 sentences: creative style, output type, which models
4. **## Model routing** — routing table (primary + fallback), per-platform aspect/duration table
5. **## Still-image path (MODEL-05)** — when applicable; route to the image model
6. **## Prompt-building workflow** — numbered steps 1–4: gather → select → build → present
7. **## Opt-in generation** — brief text + link to `../../shared/generation-flow.md`
8. **## Reference materials** — table of `references/` files with relative links

The still-image path section (step 5) is included when the skill routes to an image model.
If a skill is video-only with no image model, omit it.

---

### C. Frontmatter Rules

| Field | EN value | FR value |
|---|---|---|
| `name` | `higgsfield-<style>` | `higgsfield-<style>-fr` |
| `description` | Third person, ≤1024 chars, "Use when…" clause | French third person, ≤1024 chars, "À utiliser quand…" clause |
| `when_to_use` | English overflow triggers | French overflow triggers |
| `allowed-tools` | 9 `mcp__higgsfield__*` tools (space-separated) | **Identical** — MCP tool names are NOT translated |

**Name uniqueness rule:** Every skill must have a unique `name` across EN and FR variants.
The `-fr` suffix on the FR variant prevents registry collisions (T-02-06 mitigation).

**allowed-tools — the canonical 9 tools for generation skills:**
```
mcp__higgsfield__generate_video
mcp__higgsfield__generate_image
mcp__higgsfield__models_explore
mcp__higgsfield__job_status
mcp__higgsfield__job_display
mcp__higgsfield__media_upload
mcp__higgsfield__media_confirm
mcp__higgsfield__balance
mcp__higgsfield__show_plans_and_credits
```
Exclude `presets_show` and `select_workspace` (not part of the generation flow — GEN-05).

---

### D. Relative Link Paths by File Location

| File location | To reference file | To shared infrastructure |
|---|---|---|
| `skills/NN-name/SKILL.md` | `references/model-specs.md` | `../../shared/generation-flow.md` |
| `skills/NN-name/SKILL.md` | `references/camera.md` | `../../shared/mcp-tools.md` |
| `skills/NN-name/fr/SKILL.md` | `../references/model-specs.md` | `../../../shared/generation-flow.md` |
| `skills/NN-name/fr/SKILL.md` | `../references/camera.md` | `../../../shared/mcp-tools.md` |

**Critical:** The FR SKILL.md is one directory level deeper than the EN SKILL.md. Every
relative path gains one `../` prefix compared to the EN version.

**Verify before committing:** For every relative link in both SKILL.md files, run:
```bash
python3 -c "import os,sys; print(os.path.normpath(sys.argv[1]))" \
  "skills/NN-name/fr/<link>"
```
All resolved paths must exist on disk. Zero broken links is the required gate.

---

### E. Routing Table Format

Every skill uses this exact table structure for model routing:

```markdown
| | primary_model_id | fallback_model_id |
|---|---|---|
| **Rationale** | [why primary] | [why fallback] |
| **Aspect ratios** | `16:9`, `9:16`, `1:1` | [supported ratios] |
| **Duration** | [range or discrete set] | [range or discrete set] |
| **Tunable params** | [params or "None"] | [params] |
| **Media roles** | [roles] | [roles] |
| **Native audio** | [Yes/No] | [Yes/No] |
```

Model parameter values must come ONLY from verified `higgsfield:models_explore` data.
Never invent or extrapolate. Include the verification date in `references/model-specs.md`.

---

### F. Generation-Flow Link Pattern

Every skill (EN and FR) includes the opt-in generation section with this exact pointer:

**EN SKILL.md:**
```markdown
[`../../shared/generation-flow.md`](../../shared/generation-flow.md)
```

**FR SKILL.md:**
```markdown
[`../../../shared/generation-flow.md`](../../../shared/generation-flow.md)
```

The generation flow is NEVER duplicated inline in the SKILL.md — always a pointer.

---

### G. FR Mirror Convention

1. Create `skills/NN-name/fr/SKILL.md` — never `skills/NN-name-fr/SKILL.md` (the `fr/`
   subdir lives inside the EN skill directory).
2. `name: higgsfield-<style>-fr` — exact `-fr` suffix, no other difference in the name stem.
3. Mirror the EN structure section-for-section in French. Do NOT re-architect.
4. Translate: section headings, body prose, description, when_to_use, frontmatter description.
5. Do NOT translate: `name` field (except the `-fr` suffix), `allowed-tools` tool names,
   model IDs (`cinematic_studio_3_0`, `veo3_1`, etc.), MCP tool references in prose
   (`higgsfield:generate_video` etc.), `allowed-tools` values.
6. Link paths: recalculate every relative link for the `fr/` subdir (one level deeper).
7. References: point to `../references/*.md` (EN files) — do NOT create `fr/references/`.

---

### H. NN-Prefix Directory Mapping (D-09)

The on-disk skill directory keeps the `NN-` prefix (e.g., `skills/01-cinematic/`). The
`name` field in frontmatter does NOT include the prefix (e.g., `name: higgsfield-cinematic`).

At install time (Phase 4), `install.sh` strips the `NN-` numeric prefix so the installed
directory matches the `name` value. This mapping enables natural sort order during
development while Claude uses the clean `name` for invocation.

| On-disk directory | Installed as | Name in frontmatter |
|---|---|---|
| `skills/01-cinematic/` | `higgsfield-cinematic/` | `higgsfield-cinematic` |
| `skills/01-cinematic/fr/` | `higgsfield-cinematic-fr/` | `higgsfield-cinematic-fr` |
| `skills/02-<style>/` | `higgsfield-<style>/` | `higgsfield-<style>` |
| `skills/02-<style>/fr/` | `higgsfield-<style>-fr/` | `higgsfield-<style>-fr` |

Phase 3 creates `skills/NN-name/` directories with the `NN-` prefix. Phase 4 handles the
strip-and-install step.

---

### I. Reference Files Convention

Each `references/` file serves one purpose. The four-file decomposition proven in the pilot:

| File | Purpose | Typical size |
|---|---|---|
| `model-specs.md` | Per-model parameter tables + verification date + re-query directive | 80–150 lines |
| `camera.md` | Camera movements, lighting setups, composition, color grading | 150–300 lines |
| `hooks.md` | Hook framework, technique library, prompt phrasing templates | 100–200 lines |
| `examples.md` | Worked example prompts by genre and platform | 200–400 lines |

Rules:
- One level deep from `SKILL.md` only — no chaining (`SKILL.md` → `A.md` → `B.md` is forbidden).
- Files >100 lines require a Table of Contents.
- Sourced from EN content only (D-11).
- `model-specs.md` must include verification date and the re-query directive.

---

## Deviations from Plan

### Checkpoint Self-Verification (no blocking human input)

The plan's `type="checkpoint:human-verify"` task (Task 2) was replaced by an automated
self-verification of all relative links in both EN and FR SKILL.md files. This is explicitly
permitted by the key reminders: "rather than blocking on human input, SELF-VERIFY by checking
every relative link in both EN SKILL.md and fr/SKILL.md resolves to a real file on disk."

Result: 22/22 links verified. The phase verifier runs separately as specified.

No other deviations. Task 1 executed exactly as planned.

---

## Known Stubs

None. The FR SKILL.md is fully authored with real French content. All links resolve to
existing files. No placeholder, TODO, or "coming soon" text present.

---

## Threat Flags

No new threat surface introduced beyond what was modeled in the plan:

- T-02-06 (name collision): mitigated — `higgsfield-cinematic-fr` is unique from `higgsfield-cinematic`. Verified by grep.
- T-02-07 (broken links): mitigated — all 11 FR links resolve on disk. Verified by automated check.
- T-02-08 (generation gate): mitigated — FR skill carries identical opt-in pointer to `shared/generation-flow.md`. The confirmation gate applies equally to FR invocations.

---

## Self-Check

### Files exist:
- [x] `skills/01-cinematic/fr/SKILL.md` (157 lines)
- [x] `.planning/phases/02-pilot-skill-01-cinematic-end-to-end/02-03-SUMMARY.md`

### Commits exist:
- [x] f301d2e — feat(02-03): create French FR variant skills/01-cinematic/fr/SKILL.md

### Key checks:
- [x] `name: higgsfield-cinematic-fr` — present (grep verified)
- [x] `../references/model-specs.md` — present in FR SKILL.md and resolves
- [x] `../../../shared/generation-flow.md` — present in FR SKILL.md and resolves
- [x] `cinematic_studio_3_0` — present in FR SKILL.md
- [x] `mcp__higgsfield__generate_video` — present in FR allowed-tools
- [x] No `720p`, `.webm`, `3840`, `2160` — confirmed absent
- [x] 157 lines — within 500-line hard cap

## Self-Check: PASSED
