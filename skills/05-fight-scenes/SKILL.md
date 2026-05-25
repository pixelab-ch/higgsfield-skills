---
name: higgsfield-fight-scenes
description: >-
  Crafts fight scene and action sequence video prompts for Higgsfield and routes
  to the best model (cinematic_studio_3_0 primary, kling3_0 fallback). Use when
  the user wants fight scenes, combat, martial arts, battles, action
  choreography, sword fights, hand-to-hand combat, chase scenes, superhero
  action, or any high-energy action video. Triggers on: fight, combat, battle,
  martial arts, action scene, choreography, duel, sword fight, kung fu, chase,
  brawl, punch, kick, weapon combat, superhero fight, or any action/fight request.
when_to_use: >-
  Use for intense action sequences, stunt choreography, fight cinematography,
  elemental magic combat, gun-fu, chase sequences evolving into brawls, samurai
  duels, gladiatorial battles, urban street fights, or superhero vs. villain
  battles. Also use for "make an intense action video" or "epic battle."
allowed-tools: >-
  mcp__higgsfield__generate_video
  mcp__higgsfield__generate_image
  mcp__higgsfield__models_explore
  mcp__higgsfield__job_status
  mcp__higgsfield__job_display
  mcp__higgsfield__media_upload
  mcp__higgsfield__media_confirm
  mcp__higgsfield__balance
  mcp__higgsfield__show_plans_and_credits
---

# Higgsfield Fight Scenes Skill

## What this skill does

Crafts production-ready fight scene and action sequence video prompts and routes them to
the best Higgsfield model for cinematic combat output. On request, it assembles the full
parameter set, surfaces the credit cost, and — after explicit user confirmation —
generates the asset via the opt-in generation flow.

This skill masters translating explosive action choreography into vivid video prompts
with cinematic precision, visceral impact, and rhythm that feels both dynamic and
purposeful. It covers unarmed combat (15+ martial arts disciplines), weapon combat,
fantasy/elemental fights, superhero battles, chase sequences, and multi-combatant
coordination.

---

## Model routing

### Primary and fallback video models

| | cinematic_studio_3_0 (primary) | kling3_0 (fallback) |
|---|---|---|
| **Rationale** | Dedicated cinematic pipeline; default for all fight scenes and action video | Use only when primary is unavailable, or user wants `mode` / `sound` control |
| **Aspect ratios** | `16:9`, `9:16`, `1:1` | `16:9`, `9:16`, `1:1` |
| **Duration** | 4–15 s (continuous range) | 3–15 s (continuous range; minimum is 3 s) |
| **Tunable params** | **None** — pass only `aspect_ratio` and `duration` | `mode` {`std`, `pro`, `4k`}; `sound` {`on`, `off`} |
| **Media roles** | `image`, `start_image`, `end_image` | `start_image`, `end_image` only |

**Important note on kling3_0 `mode: 4k`:** The `4k` option is a **mode enum** (a
generation pipeline variant), NOT a claim about 4K output-file resolution. No video model
in this skill outputs 4K files. Max resolution for fight-scene video generation is
determined by the model's internal pipeline, not by the mode value.

**Routing rule:** Use `cinematic_studio_3_0` by default. Only fall back to `kling3_0`
when (1) the primary model is unavailable, or (2) the user explicitly accepts kling3_0's
constraints after being told what they give up: no `image` media role (only
`start_image`/`end_image`), and a different cinematic pipeline aesthetic. Gains:
`mode` control (`std`/`pro`/`4k` generation variant) and `sound` option. If the user has
not been informed of these trade-offs, stay on `cinematic_studio_3_0` and let them
decide — never switch silently.

**MODEL-06 directive:** If a parameter is rejected at generation time, call
`higgsfield:models_explore` with the target model name to re-verify the live schema.
Full parameter tables: [references/model-specs.md](references/model-specs.md).

### Per-platform quick rule

Vertical `9:16` for TikTok / Reels / Shorts (hook in 2 s); `16:9` for YouTube and
LinkedIn; `1:1` for Instagram feed (keep combatants center-weighted). Full per-platform
table: [references/model-specs.md](references/model-specs.md).

---

## Prompt-building workflow

1. **Gather intent** — Confirm with the user: combat style (martial art, weapon type,
   fantasy, superhero), setting/environment, tone (gritty, stylized, anime, cinematic),
   combatant descriptions, target platform, aspect ratio, and desired duration.

2. **Select model** — Apply the routing table above. Choose `cinematic_studio_3_0` by
   default; select `kling3_0` only when a routing trigger applies.

3. **Build the prompt** — Use the craft principles in the references below:
   - Opening hook (2-second action attention-capture technique) from
     [references/hooks.md](references/hooks.md)
   - Choreography language, combat style, camera work, impact effects, environments from
     [references/choreography.md](references/choreography.md)
   - Master template and worked fight-scene prompts from
     [references/examples.md](references/examples.md)

4. **Present for review** — Show the assembled prompt and all parameters to the user for
   review and refinement **before** any generation call. The user must approve the prompt
   text, model, aspect ratio, and duration.

---

## Opt-in generation

Generation costs Higgsfield credits and requires explicit user confirmation before any
generate call is made. This skill never auto-generates.

**Full step-by-step flow** (confirmation gate, balance/cost surface,
generate → poll → display):
[`../../shared/generation-flow.md`](../../shared/generation-flow.md)

**This skill's primary model:** `cinematic_studio_3_0`

**Media upload:** Conditional — only when the user supplies a `start_image` or
`end_image` reference. This skill is NOT a mandatory-I2V skill; T2V is the default path.
When the user provides a reference image, run the `higgsfield:media_upload` →
`higgsfield:media_confirm` atomic pair before generating.

**Tool signatures:** [`../../shared/mcp-tools.md`](../../shared/mcp-tools.md)

---

## Reference materials

| File | Contents |
|---|---|
| [references/model-specs.md](references/model-specs.md) | Per-model parameter tables, aspect ratios, durations, routing rationale, re-verify directive, and `kling3_0 mode:4k` clarification for cinematic_studio_3_0 and kling3_0 |
| [references/choreography.md](references/choreography.md) | Choreography philosophy, 15+ combat style encyclopedia (unarmed, weapon, fantasy), 30+ choreography keywords, 20+ camera techniques, impact effects encyclopedia, environment and arena guide, multi-character coordination patterns |
| [references/hooks.md](references/hooks.md) | 2-second hook framework with 10+ fight-scene hook techniques, prompt integration templates, hook pairing guide by fight type, and hook escalation principle |
| [references/examples.md](references/examples.md) | Master prompt template, 5 full production-quality fight-scene prompts (martial arts rain duel, fantasy sword/magic, chase-to-street-fight, anime superhero battle, samurai sunset duel), common-mistakes fix table |
