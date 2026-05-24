# Pitfalls Research

**Domain:** Model-aware Claude Agent Skills that generate AI images/videos on Higgsfield
**Researched:** 2026-05-24
**Confidence:** HIGH (all critical pitfalls verified against the actual repo + official Agent Skills docs)

---

## Critical Pitfalls

### Pitfall 1: Static Skill — Zero Tool Integration

**What goes wrong:**
Every skill file reads like a documentation page and never instructs Claude to call any MCP tool. The existing repo contains 15 skills spanning 20,000+ lines, none of which reference `generate_image`, `generate_video`, `models_explore`, `job_status`, or any Higgsfield MCP tool. Claude reads the skill, produces a beautiful prompt, and stops. The MCP server is present but unreachable from skill context.

**Why it happens:**
Skills were authored as prompt-engineering guides, not as agent workflows. The author treated SKILL.md as an end-user tutorial rather than instructions to Claude. Without an explicit "call this tool" directive in the skill body, Claude has no reason to know generation is even possible.

**How to avoid:**
Every skill that can produce a generation must contain an explicit workflow section that names the exact MCP tools to call. Use the fully-qualified form the official docs require (`higgsfield:generate_video`, `higgsfield:models_explore`) so Claude resolves the tool unambiguously. The workflow must cover: validate parameters → confirm with user → call tool → poll `job_status` → call `job_display`. Embed this as a numbered procedure, not a suggestion.

**Warning signs:**
- Skill body mentions Higgsfield or model names but contains no `tool`, `call`, or backtick-formatted tool references.
- Skill ends with "paste this prompt into Higgsfield" (implies manual, not agentic workflow).
- No mention of `job_status` or `job_display` anywhere in the skill.

**Phase to address:**
Phase 1 (skill architecture) — the workflow scaffold must be part of every skill template before any content is written. Content added later will follow whatever structure is established first.

---

### Pitfall 2: Spec Hallucination — Invented Per-Model Parameters

**What goes wrong:**
Skills assert concrete technical specs that conflict with each other and with the platform. In the existing repo: the README correctly states 720p output; fight-scenes/SKILL.md states "1080p/4K (3840×2160)" and ".webm output recommended"; 3d-cgi and cartoon skills assert "4K at 60fps"; real-estate's zh-CN variant claims "4K and 8K output ready". Users who read these specs target parameters the model will reject. The real constraint — `models_explore` returns the authoritative `aspect_ratios`, `durations`, `parameters`, and `roles` per model — is never consulted.

**Why it happens:**
Skills were authored from imagination and general AI-video knowledge rather than from the actual API catalogue. With 38 models across image and video, per-model constraints vary significantly (e.g., minimax_hailuo requires `resolution: 512` when `end_image` is used; veo3 requires `start_image`; seedance_2_0 outputs 720p at 4–15s). Without a discipline to derive specs from `models_explore`, each skill author makes their best guess.

**How to avoid:**
Before writing any model parameter section in a skill, run `higgsfield:models_explore` and record the exact output for that model: `parameters`, `aspect_ratios`, `durations`/`duration_range`, and `roles`. Store these in `references/model-specs.md` per skill and cite that file as the source of truth. Never write a number (resolution, fps, duration) that does not appear in `models_explore` output. Add a `<!-- verified: models_explore 2026-05-24 -->` comment on each spec block as a maintenance signal.

**Warning signs:**
- Any skill mentions "4K", "8K", "60fps", or ".webm" (none of these are Higgsfield outputs).
- Different skills for the same model cite different resolutions.
- Spec section was written without first running `models_explore`.

**Phase to address:**
Phase 1 (spec audit): run `models_explore` for all ~38 models, capture outputs as a reference table, and use it as the input source for all skill spec sections.

---

### Pitfall 3: Model-Parameter Mismatch at Generation Time

**What goes wrong:**
A skill recommends parameters that a specific model rejects, causing the `generate_video` / `generate_image` call to fail with an API error. Examples known from the model catalogue: `minimax_hailuo` requires `resolution: 512` when `end_image` is in the `roles` (incompatible with the skill recommending "1080p"); `veo3` and `wan2_6` require `start_image` in the roles payload; image models like `flux_kontext` accept `image` role only (no `start_image`). Without pre-call validation, Claude passes whatever parameters look reasonable and the API rejects them.

**Why it happens:**
Each model in the Higgsfield catalogue has its own combination of required/optional roles, allowed aspect ratios, and parameter enumerations. This is not discoverable from a static skill file — it requires querying `models_explore` at skill invocation time. Skills that hardcode parameters bypass this contract entirely.

**How to avoid:**
Each skill's generation workflow must include a validation step before calling `generate_video`/`generate_image`. The workflow should: (1) call `higgsfield:models_explore` for the target model to retrieve current constraints, (2) check the user's requested parameters against `aspect_ratios`, `durations`/`duration_range`, and `parameters` enumerations, (3) if roles like `start_image` or `end_image` are needed, verify the user has provided the required media and call `media_upload`/`media_confirm` first, (4) only then call the generation tool. This makes the skill resilient to Higgsfield updating model constraints without a skill update.

**Warning signs:**
- Skill generates in one step without consulting `models_explore` first.
- Skill hardcodes a resolution or aspect ratio without checking if the model accepts it.
- Skill mentions `start_image` or `end_image` usage without a media upload step.
- Generation fails with "invalid parameter" errors in testing.

**Phase to address:**
Phase 1 (skill architecture): the validation step belongs in the workflow scaffold that all skills inherit, not left to each skill author to remember.

---

### Pitfall 4: Unconfirmed Credit Expenditure

**What goes wrong:**
A skill triggers generation automatically on any matching request without asking the user whether to proceed. On a paid platform where each generation consumes Higgsfield credits, an accidental or exploratory prompt becomes a real charge. The risk compounds with retry logic: if `job_status` returns a pending state and the skill retries by calling `generate_video` again (instead of polling), it submits a second billable job.

**Why it happens:**
Workflow instructions that say "generate" rather than "ask, then generate" are easy to write and feel natural. Retry storms happen when polling logic is confused with re-submission logic — especially if the skill author does not explicitly distinguish `generate_video` (submit new job) from `job_status` (check existing job).

**How to avoid:**
Enforce a mandatory confirmation gate in every skill's workflow, before any call to `generate_image` or `generate_video`. The confirmation prompt must show: model name, parameter summary, estimated credit cost if available (via `higgsfield:show_plans_and_credits` or `higgsfield:balance`), and an explicit "Proceed? (yes/no)" question. After submitting, the skill must poll `job_status` with a delay between polls — never re-call `generate_video` in a loop. If `job_status` returns a terminal failure state, the skill must report the error without auto-retrying.

**Warning signs:**
- Skill workflow does not contain a user confirmation step before calling `generate_*`.
- Skill uses a retry loop that calls `generate_video` more than once.
- No mention of `show_plans_and_credits` or `balance` in skill docs.
- Testing shows duplicate jobs appearing in Higgsfield dashboard.

**Phase to address:**
Phase 1 (skill architecture): the confirmation gate is a non-negotiable structural requirement, not a content choice. Every skill template must make it mandatory.

---

### Pitfall 5: Phantom Documentation — README Describes Things That Don't Exist

**What goes wrong:**
The README's repo structure lists `LICENSE` and `logs.md` as present files. Neither exists. The README also lists 8+ additional language READMEs (`README.de.md`, `README.es.md`, etc.) that exist but describe a product that is being replaced. When a new contributor or user follows the README, they encounter broken references and lose trust in the whole document. The existing zh-CN README variants describe Seedance-only skills; they do not reflect the multi-model architecture being built.

**Why it happens:**
Documentation is written aspirationally (listing what will exist) and then not updated when plans change. In iterative projects, code is updated but README stays at version 1. In this repo, `logs.md` was probably planned and abandoned; `LICENSE` was referenced but never created — both are structural and legal problems.

**How to avoid:**
Never list a file in the repo structure section of a README unless it physically exists. As part of every phase's Definition of Done, run a verification pass: for each path listed in README, confirm `ls` returns that file. Add a lint step (or simple shell check) that reads the README structure block and asserts each listed file exists. Create `LICENSE` before or in the same commit as any public README reference to it.

**Warning signs:**
- `ls` of the repo root shows fewer files than the README's structure section describes.
- README mentions a file type (.md, .sh, .json) that `find . -name "filename"` returns nothing for.
- README structure was copied from a template and paths not verified.

**Phase to address:**
Phase 0 (cleanup) or Phase 1 pre-work: run the verification check as the first task, fix before writing new content.

---

### Pitfall 6: Translation Drift — i18n Files Diverge from EN Source

**What goes wrong:**
The zh-CN variant of real-estate skill (15-real-estate) has only 28 of 2,344 lines changed from the EN original — a 99% untranslated copy with a Chinese title and description but entirely English body. The zh-CN files carry the same `name:` as the EN files, which means Claude loads both as the same skill (potential name collision or one silently overrides the other). As the EN skills are updated (model routing, new specs, workflow steps), the zh-CN variants will lag and serve stale or contradictory instructions.

**Why it happens:**
Machine-translated or manually drafted translations are done once at creation time and then abandoned. The skill body is long (700–2344 lines) — maintaining translation parity is expensive. When EN is updated, the translator must update a parallel file or it drifts. With no automated diff check, drift is invisible.

**How to avoid:**
For the new EN + FR architecture: (1) store the EN skill as the canonical source; (2) the FR variant is a sibling directory (`fr/SKILL.md`) with `name:` suffixed with `-fr` to prevent name collisions (e.g., `higgsfield-cinematic-fr`); (3) keep the FR skill body as short as possible by using progressive disclosure — only translate the SKILL.md overview/workflow, not the references files (references can stay EN-only and are loaded on demand); (4) add a maintenance note at the top of each FR file listing the SHA or date of the EN version it was translated from; (5) when updating EN, grep for the changed section and update the FR counterpart in the same commit.

**Warning signs:**
- `diff skills/XX/SKILL.md skills/XX/fr/SKILL.md | wc -l` returns fewer than 20% of total lines — the file is barely translated.
- FR `name:` is identical to EN `name:` — name collision will cause one to be ignored.
- FR file was last touched in a different commit month than EN.
- FR file contains no French text in the body (only in the frontmatter).

**Phase to address:**
Phase 2 (localization): after EN skills are finalized and tested, create FR translations as thin overlays of the workflow + key terminology, not full copies.

---

### Pitfall 7: Monolithic SKILL.md Burning Context on Every Trigger

**What goes wrong:**
Skills range from 741 to 2,344 lines. The official Agent Skills architecture loads the entire SKILL.md into the context window whenever a skill is triggered. A 2,344-line file (real-estate) loaded into every real-estate request consumes thousands of tokens before Claude has done anything useful. With 15 skills potentially in scope and context windows finite, loading several monolithic skills simultaneously (e.g., if descriptions overlap and multiple skills trigger) creates token pressure that degrades response quality.

**Why it happens:**
All content was written into SKILL.md because it's the only file authors knew to use. Camera movement encyclopedias (15-20+ techniques), worked example prompts (5+ at 15-25 lines each), platform optimization tables, and sound-design guides are all valuable but not all needed simultaneously.

**How to avoid:**
The official Agent Skills pattern (documented in the platform docs) is progressive disclosure: SKILL.md acts as a table of contents (overview + workflow + model routing, ideally under 200 lines), and specialist content lives in `references/` files that Claude reads only when needed. For example: `references/camera-moves.md`, `references/model-specs.md`, `references/example-prompts.md`. The SKILL.md workflow instructs Claude to read a specific reference when the user's request requires it. This means most interactions load only SKILL.md, and detailed reference files are fetched on demand.

**Warning signs:**
- SKILL.md exceeds 300 lines.
- SKILL.md contains camera move encyclopedias, full example prompts, or platform-specific optimization tables inline.
- No `references/` directory in the skill folder.
- Skill body contains sections that are never triggered for most requests (e.g., "Advanced Lighting for 8K Output" when the model outputs 720p).

**Phase to address:**
Phase 1 (skill architecture): establish the lean SKILL.md template and `references/` pattern before writing any skill content. Content written into the wrong structure must be refactored, not just moved.

---

### Pitfall 8: Install Script Targeting Wrong Runtime Path

**What goes wrong:**
The existing `install.sh` copies skills to `~/Library/Application Support/Claude/skills` (macOS) and `~/.config/Claude/skills` (Linux) — these are Claude Desktop paths. Claude Code reads skills from `~/.claude/skills`. A user running Claude Code runs the install script, gets a "success" message, and finds zero skills loaded. The failure is silent: Claude Code simply doesn't see the skills directory the script targeted.

**Why it happens:**
The script was written assuming Claude Desktop as the runtime. Claude Code, being newer, has a separate skill discovery path that wasn't accounted for. The script correctly handles macOS vs. Linux for Desktop, but lacks any awareness that the same machine can run both Claude Desktop and Claude Code, each with different paths.

**How to avoid:**
The install script must handle three scenarios: (1) Claude Code only (`~/.claude/skills`), (2) Claude Desktop only (OS-dependent path), (3) both. Ask the user which runtime they use (or detect by checking if `~/.claude/` exists), then install to the appropriate path — or both. Add a post-install verification step that prints the resolved path and instructs the user to confirm the directory is non-empty before restarting Claude. Document both paths explicitly in the README Quick Start section.

**Warning signs:**
- Install script does not reference `~/.claude/skills` anywhere.
- Script reports success but skills are invisible in Claude Code.
- README Quick Start says "copy to Claude skills directory" without specifying which one.

**Phase to address:**
Phase 1 (infrastructure): fix the install script as part of the same phase that establishes the new skill directory structure.

---

### Pitfall 9: Description Over-Length and Over-Triggering

**What goes wrong:**
The official Agent Skills spec sets a hard limit of 1,024 characters for the `description` field. The existing skill descriptions range from 497 to 656 characters — all currently within limit. However, descriptions are already verbose keyword lists ("Triggers on: fight, combat, battle, martial arts, action scene, choreography, duel, sword fight...") that pad for discovery. As skills are updated for multi-model awareness, there is pressure to also add model names to descriptions, which pushes them over the 1,024-character limit. Over-triggering is the secondary risk: a description that lists 30+ keywords causes overlapping skills to trigger on the same request, loading multiple skills simultaneously and wasting context.

**Why it happens:**
Authors treat description as a SEO keyword field rather than a precise trigger condition. The more keywords, the more confident they feel the skill will activate. This optimizes for recall at the expense of precision.

**How to avoid:**
Target descriptions under 600 characters (providing buffer before the 1,024 hard limit). Write descriptions that define the use case precisely rather than enumerating every possible synonym. For multi-skill suites, verify that descriptions do not overlap on the same trigger keywords — a user asking "make an anime fight scene" should trigger at most one skill (anime-action or fight-scenes, not both). For model-aware skills, model names belong in the SKILL.md body and routing section, not in the description frontmatter.

**Warning signs:**
- `description:` field length exceeds 900 characters (approaching the 1,024 limit).
- Two or more skills share the same top-level trigger keyword (e.g., "action").
- Testing shows multiple skills activating on a single request.
- Description contains model names (they change; description should be use-case-stable).

**Phase to address:**
Phase 1 (skill architecture): review and trim descriptions during template creation. Check character counts programmatically as a build step.

---

## Technical Debt Patterns

| Shortcut | Immediate Benefit | Long-term Cost | When Acceptable |
|----------|-------------------|----------------|-----------------|
| Hardcoding model specs in skill body instead of querying `models_explore` | Faster to write | Specs go stale when Higgsfield updates a model; wrong parameters cause generation failures | Never — always derive from `models_explore` |
| Putting all content in SKILL.md instead of `references/` | Single file to edit | Entire content loads every trigger; context token waste multiplies across skills | Never for skills over 200 lines |
| Writing FR translation as a full copy of EN | No tool needed to maintain split | 2x maintenance burden; FR diverges silently as EN updates | Only if FR has < 100 lines total |
| Skipping user confirmation before generation | Slightly faster UX | Accidental credit expenditure; no opportunity to correct parameters | Never — generation always requires confirmation |
| Using `models_explore` output captured once and pasted inline | Fast at authoring time | Specs become stale as Higgsfield updates models; no cache invalidation signal | Only with explicit `<!-- verified: models_explore YYYY-MM-DD -->` annotation and a documented re-verification cadence |
| Adding all 38 models to a single "model routing" skill | One place to update | Massive context load; routing logic becomes unmaintainable; updating one model spec risks breaking others | Never — per-skill model routing with references is correct |

---

## Integration Gotchas

| Integration | Common Mistake | Correct Approach |
|-------------|----------------|------------------|
| `higgsfield:generate_video` | Calling it without first uploading reference media when `start_image` or `end_image` role is needed — API rejects the call | Call `higgsfield:media_upload` then `higgsfield:media_confirm` to get the media ID, then include that ID in the generation payload |
| `higgsfield:generate_video` | Using unqualified tool name `generate_video` instead of `higgsfield:generate_video` | Official docs require fully qualified names for MCP tools to avoid ambiguity when multiple MCPs are present |
| `higgsfield:job_status` | Re-calling `generate_video` on pending status (retry storm) | Only call `generate_video` once; poll `job_status` in a loop with delay until status is terminal (complete/failed), then call `job_display` |
| `higgsfield:models_explore` | Calling it once per session and caching results forever | Models can be updated by Higgsfield; call `models_explore` at skill invocation time or cache with a TTL annotation |
| `higgsfield:show_plans_and_credits` | Never querying credits before generation | Show the user their credit balance and estimated cost before the confirmation gate so they can make an informed decision |
| `higgsfield:media_upload` + `higgsfield:media_confirm` | Uploading media but not confirming — the upload is not persisted until `media_confirm` is called | Always call `media_confirm` after `media_upload`; treat the two as an atomic pair |
| Skill `name` field | Using names that collide with existing installed skills (e.g., two skills named `higgsfield-cinematic`) | Generate unique names per locale (e.g., `higgsfield-cinematic` for EN, `higgsfield-cinematic-fr` for FR); verify no collision with pre-existing skills in `~/.claude/skills` |

---

## Performance Traps

| Trap | Symptoms | Prevention | When It Breaks |
|------|----------|------------|----------------|
| Monolithic SKILL.md loaded on every trigger | Slow response time; context window fills rapidly when multiple skills trigger | Cap SKILL.md at ~200 lines; move encyclopedic content to `references/` | Any skill over 400 lines |
| Polling `job_status` too frequently | Excessive API calls to Higgsfield; rate-limit errors | Use exponential backoff starting at 5s; cap at 30s intervals | Immediately if polling every second |
| Loading all `references/` files preemptively | Context exhausted before generation starts | SKILL.md workflow must instruct Claude to load only the specific reference relevant to the current request | Any skill with 3+ reference files over 200 lines each |
| Running `models_explore` for all 38 models upfront | Slow skill initialization; token waste | Query only the model(s) relevant to the current skill; cache with date annotation in `references/model-specs.md` | With 38 models, upfront loading is always wasteful |

---

## Security Mistakes

| Mistake | Risk | Prevention |
|---------|------|------------|
| No LICENSE file despite README claiming one exists | Legal ambiguity around redistribution; contributors have no terms | Create LICENSE file before any public release; reference it in README only after it exists |
| Hardcoded API key or credential references in skill body | Credential leakage if skill is shared | Skills must never embed API keys; MCP server handles authentication; skill body should not reference auth tokens |
| Skills that generate without confirmation | Unintended credit expenditure (financial risk, not security per se, but treated as a constraint) | Mandatory confirmation gate before any `generate_*` call |

---

## UX Pitfalls

| Pitfall | User Impact | Better Approach |
|---------|-------------|-----------------|
| Skill outputs a long prompt and stops — no generation offer | User must manually copy-paste to Higgsfield web UI; defeats the purpose of MCP integration | Skill workflow always offers to generate after producing the prompt, gated on confirmation |
| Generation submitted with no feedback until job completes | User sees nothing for 10–60 seconds; assumes something went wrong | Report job ID immediately after submission ("Job submitted: job_abc123"); poll and report intermediate status |
| Error messages from API exposed raw to user | Confusing API JSON errors degrade trust | Skill intercepts API error, maps to human-readable explanation with corrective action |
| FR skill has EN body with French frontmatter | French user reads an untranslated skill | FR variant must have French body; if too long to translate fully, provide French executive summary and EN references with a note explaining the split |
| Install script succeeds silently but skills don't appear | User restarts Claude, sees no skills, assumes the tool is broken | Post-install step: print the exact path, tell user to verify it with `ls <path>`, and confirm skills appear in Claude after restart |

---

## "Looks Done But Isn't" Checklist

- [ ] **MCP integration:** Skill SKILL.md mentions Higgsfield and generation — verify it contains `higgsfield:generate_video` or `higgsfield:generate_image` in a workflow section, not just in prose description.
- [ ] **Confirmation gate:** Skill workflow references confirmation — verify the word "confirm" or "proceed?" appears before the generation tool call, not after.
- [ ] **Model specs:** Skill lists resolution or duration — verify those numbers appear in the `models_explore` output for that specific model, not in another model's output or from imagination.
- [ ] **Media roles:** Skill mentions `start_image` or `end_image` — verify the workflow includes `media_upload` + `media_confirm` before the generation call.
- [ ] **File existence:** README lists a file in repo structure — verify `ls` returns that file. LICENSE in particular must physically exist before any README reference.
- [ ] **Description length:** Skill has a description — verify `wc -c` of the description value is under 1,024 characters. Verify no two skills share the same top trigger keyword.
- [ ] **Progressive disclosure:** SKILL.md appears complete — verify it is under 200 lines and that heavy content (examples, camera encyclopedias, platform specs) lives in `references/`.
- [ ] **Install script paths:** Script reports success — verify that `~/.claude/skills/<skill-name>/SKILL.md` exists after running it on Claude Code.
- [ ] **FR translation quality:** FR variant exists — verify that more than 50% of the body lines are in French (not English copy with French frontmatter).
- [ ] **FR name collision:** FR variant has `name:` in frontmatter — verify it is different from the EN `name:` (e.g., has `-fr` suffix).

---

## Recovery Strategies

| Pitfall | Recovery Cost | Recovery Steps |
|---------|---------------|----------------|
| Zero tool integration discovered post-ship | HIGH | Rewrite workflow section of every skill; re-test all generation flows; re-install to both runtimes |
| Spec hallucination discovered after users run bad prompts | MEDIUM | Run `models_explore` for all models; update `references/model-specs.md` per skill; issue corrected skill versions; note in CHANGELOG |
| Accidental credit expenditure from missing confirmation gate | HIGH (irreversible financial loss) | Add confirmation gate immediately to all skills; add regression test; credits cannot be recovered |
| Phantom file references in README | LOW | Create or remove the referenced files; commit; update README |
| Monolithic skills causing context issues | MEDIUM | Extract `references/` files from existing SKILL.md; update SKILL.md to act as ToC with read-on-demand instructions; re-install |
| FR translation drift | MEDIUM | Diff EN vs FR; re-translate changed sections; add translation date stamp; update skills |
| Install script targeting wrong path | LOW-MEDIUM | Update script to handle both paths; re-run install; verify with `ls ~/.claude/skills` |

---

## Pitfall-to-Phase Mapping

| Pitfall | Prevention Phase | Verification |
|---------|------------------|--------------|
| Zero tool integration (Pitfall 1) | Phase 1 — Skill architecture & template | `grep -r "higgsfield:generate_" skills/` returns results for every skill |
| Spec hallucination (Pitfall 2) | Phase 1 — Spec audit from `models_explore` | Every spec in every SKILL.md has a `<!-- verified: models_explore DATE -->` annotation |
| Model-parameter mismatch (Pitfall 3) | Phase 1 — Skill architecture (validation step in workflow scaffold) | Test generation against each model with boundary parameter values; API accepts without error |
| Unconfirmed credit expenditure (Pitfall 4) | Phase 1 — Skill architecture (confirmation gate in workflow scaffold) | Code review: no `generate_*` call appears before a user-confirmation block in any skill |
| Phantom documentation (Pitfall 5) | Phase 0 (cleanup) — Immediate repo hygiene | `ls` returns every file listed in README structure section; LICENSE exists |
| Translation drift (Pitfall 6) | Phase 2 — Localization | `diff skills/XX/SKILL.md skills/XX/fr/SKILL.md` shows >50% of lines changed; FR names are unique |
| Monolithic SKILL.md (Pitfall 7) | Phase 1 — Skill architecture template | `wc -l skills/*/SKILL.md` shows all under 200 lines; `references/` dirs exist |
| Install script wrong path (Pitfall 8) | Phase 1 — Infrastructure | Run `install.sh` on clean Claude Code environment; verify `~/.claude/skills` populated |
| Description over-length / over-triggering (Pitfall 9) | Phase 1 — Skill architecture | `grep "^description:" skills/*/SKILL.md \| awk '{print length}'` all under 1,024; no duplicate top-level trigger keywords across skills |

---

## Sources

- Claude Agent Skills official documentation (via Context7 `/websites/platform_claude_en_agents-and-tools_agent-skills`, retrieved 2026-05-24): name/description field constraints, 1,024-character limit, fully-qualified MCP tool name requirement, progressive disclosure architecture, `references/` directory pattern
- Direct audit of the existing repo (`higgsfield-seedance2-jineng`, audited 2026-05-24): line counts, description lengths, spec claims, install.sh path analysis, diff of zh-CN translation vs EN
- Higgsfield MCP model catalogue via `models_explore` (captured in PROJECT.md, 2026-05-24): per-model roles, parameter constraints, resolution/duration ranges
- PROJECT.md constraints section: confirmation gate as explicit product requirement; EN + FR only decision; Claude Code + Desktop dual-runtime requirement

---
*Pitfalls research for: model-aware Claude Agent Skills invoking Higgsfield paid generation tools*
*Researched: 2026-05-24*
