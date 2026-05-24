# Feature Research

**Domain:** Model-aware Claude Agent Skills for AI image/video generation on Higgsfield
**Researched:** 2026-05-24
**Confidence:** HIGH (based on live PROJECT.md model catalog + direct inspection of existing skills)

---

## Context: What "Model-Aware" Means

Today all 15 skills are static prompt-text generators hardwired to Seedance 2.0. "Model-aware" means each skill must:

1. Know which Higgsfield model(s) best serve its creative style
2. Emit only parameters valid for the chosen model (from `models_explore`)
3. Handle reference media correctly (image upload before I2V, audio for music video, etc.)
4. Offer to actually generate — not just emit text — via the Higgsfield MCP

This document defines what that looks like feature by feature.

---

## Style → Model Routing Table (All 15 Skills)

The model IDs below come directly from the Higgsfield catalog captured in PROJECT.md. Every skill must declare a **primary** model and at least one **fallback**. The routing logic lives inside each skill's lean SKILL.md so Claude can select the right tool call without user guidance.

| Skill | Creative Need | Primary Model | Fallback | Rationale |
|-------|--------------|---------------|----------|-----------|
| **01-cinematic** | Film-quality drama, lens flares, anamorphic look, narrative beats | `cinematic_studio_3_0` | `veo3_1` | `cinematic_studio_3_0` is the dedicated cinematic pipeline; `veo3_1` covers photorealism when the studio model is unavailable or user wants native audio |
| **02-3d-cgi** | Rendered/Pixar look, volumetric, subsurface scattering, synthetic environments | `seedance_2_0` | `wan2_7` | Seedance excels at photorealistic synthetic renders; `wan2_7` handles creative stylization; no dedicated CGI model exists so fallback on generalist |
| **03-cartoon** | 2D animation, cel-shaded, hand-drawn, flat motion-graphics | `wan2_7` | `seedance_2_0` | `wan2_7` carries strong stylistic/illustrative capabilities; seedance is fallback for photorealistic cartoon hybrids |
| **04-comic-to-video** | Panel-to-motion: animate static art, manga, storyboards — always image-to-video | `wan2_6` | `seedance_2_0` | `wan2_6` handles image-to-video with strong motion inference; the `start_image` role is mandatory; seedance fallback for realism-heavy panels |
| **05-fight-scenes** | Fast kinetic action, choreography, impact, motion blur | `cinematic_studio_3_0` | `kling3_0` | Cinematic studio handles dramatic action well; `kling3_0` (Kling 3.0) has high motion fidelity and is the best fallback for pure action |
| **06-motion-design-ad** | SaaS/UI animations, tech promos, kinetic typography, 2D motion | `marketing_studio_video` | `seedance_2_0` | `marketing_studio_video` is purpose-built for branded/marketing motion; seedance covers more photorealistic product demos |
| **07-ecommerce-ad** | DTC ads, product lifestyle, social commerce, fast-cut hooks | `marketing_studio_video` | `ms_image` (for stills) | `marketing_studio_video` owns the DTC ad pipeline; for image-first outputs (Amazon hero shots, static ads) use `ms_image` (DTC Ads model) |
| **08-anime-action** | Japanese animation style, shonen, mecha, anime openings | `wan2_7` | `wan2_6` | `wan2_7` is the strongest stylistic/anime-adjacent model; `wan2_6` I2V fallback when animating a reference anime frame |
| **09-product-360** | Turntable rotations, multi-angle hero shots, material showcase, I2V from product photos | `seedance_2_0` | `cinematic_studio_3_0` | Seedance handles smooth rotation with reference images (start_image); cinematic studio for luxury lifestyle framing |
| **10-music-video** | Beat-synced visuals, audio-driven generation, performance visuals | `veo3_1` | `veo3_1_lite` | `veo3_1` supports native audio generation and is purpose-built for multimedia; `veo3_1_lite` for faster/cheaper iteration; audio role requires `media_upload` first |
| **11-social-hook** | Scroll-stopping 0–3s hooks, TikTok/Reels/Shorts, virality-first | `kling3_0` | `grok_video` | Kling 3.0 has exceptional short-form motion fidelity; `grok_video` (xAI) is strong for creative/experimental hooks |
| **12-brand-story** | Emotional narrative, cinematic brand film, long-form storytelling | `cinematic_studio_3_0` | `veo3_1` | Same rationale as cinematic; brand story = narrative drama; `veo3_1` for sound-inclusive brand anthems |
| **13-fashion-lookbook** | Model showcase, fabric drape, editorial lighting, runway movement | `cinematic_studio_video` | `seedance_2_0` | `cinematic_studio_video` (v1/v2) targets editorial/fashion; seedance for lifestyle product-adjacent shots |
| **14-food-beverage** | Appetite appeal, ASMR macro, pouring/sizzle, restaurant promo | `seedance_2_0` | `marketing_studio_video` | Seedance photorealism handles food macro and liquid beautifully; marketing studio for branded food ads |
| **15-real-estate** | Property walkthroughs, architectural exteriors, interior staging, drone-like moves | `cinematic_studio_3_0` | `veo3_1` | Cinematic studio handles architectural dolly/push moves; veo3_1 for narrated/voiced walkthroughs with native audio |

### Image-Output Variants

Some skills benefit from a **still image** output path (e.g., before generating video, or when the user just wants a hero frame):

| Skill | Best Image Model | Use Case |
|-------|-----------------|----------|
| 07-ecommerce-ad | `ms_image` (DTC Ads) | Amazon hero shot, product white-bg still |
| 09-product-360 | `seedream_v4_5` or `soul_cinematic` | Single hero angle before animating |
| 13-fashion-lookbook | `soul_cinematic` | Editorial still for social post |
| 15-real-estate | `cinematic_studio_2_5` | Architectural render still |
| 01-cinematic | `cinematic_studio_2_5` | Production still / mood board frame |
| 12-brand-story | `soul_location` | Location/atmosphere reference frame |

---

## Feature Landscape

### Table Stakes (Users Expect These)

Features that must exist or the skill is broken/pointless. These are the baseline for calling a skill "model-aware."

| Feature | Why Expected | Complexity | Notes |
|---------|--------------|------------|-------|
| **Model routing declaration** — each skill names its primary model and fallback with rationale | Without this, the skill is still Seedance-only; this is the core promise of the rework | LOW | Lives in SKILL.md header section; no dynamic logic needed, just documented intent + prompt instruction to Claude |
| **Valid parameter emission** — skill only suggests parameters the chosen model actually accepts | Users/Claude sending `resolution: "4K"` to a model that caps at 720p causes API errors and broken expectations | MEDIUM | Requires per-model parameter reference section in SKILL.md (pulled from `models_explore` at authoring time); must include aspect_ratios, durations, quality levels |
| **Aspect ratio guidance** — skill tells user which aspect ratios the model supports and recommends one per platform | Users target TikTok (9:16), YouTube (16:9), Amazon (16:9), Instagram (1:1); wrong ratio = wasted credit | LOW | Simple lookup table per skill; model constraints sourced from `models_explore` |
| **Duration guidance** — skill states valid duration range and recommends duration by use-case | Requesting 60s on a model with 5s max fails silently or returns truncated output | LOW | Per-model duration_range must be documented in each skill |
| **Prompt → confirm → generate loop** — skill builds prompt, presents it, asks for explicit go-ahead before calling `generate_image`/`generate_video` | Credits are real money; generating without confirmation is a hard constraint from PROJECT.md | MEDIUM | Must include a confirmation step with credit cost context before any MCP call |
| **Job status reporting** — after submission, skill calls `job_status` and surfaces the job ID and a link/display via `job_display` | User needs to know if generation succeeded, is queued, or failed | MEDIUM | Polling pattern: submit → get job_id → call `job_status` → call `job_display` when done |
| **media_upload before I2V calls** — for skills using `start_image` / `end_image` / `audio` roles, skill prompts user to supply and upload reference media first | I2V models reject calls without a valid uploaded media reference; e.g. comic-to-video always needs a panel image | MEDIUM | Must call `media_upload` → `media_confirm` before `generate_video`; skills 04, 08, 09, 10 always need this; others need it optionally |
| **Factual spec accuracy** — no invented specs (no "4K 3840×2160", no ".webm output") | Current skills contain fabricated numbers that undermine trust; users notice when output doesn't match stated specs | LOW | Authoring discipline: only state what `models_explore` confirms |
| **Credit/balance visibility** — skill can surface credit balance via `show_plans_and_credits` or `balance` before generation | User needs to know if they can afford the job before committing | LOW | One-liner call; surface result in the confirm step |

---

### Differentiators (Competitive Advantage)

Features that make this toolkit meaningfully better than a user manually browsing Higgsfield's web UI or prompting without a skill.

| Feature | Value Proposition | Complexity | Notes |
|---------|-------------------|------------|-------|
| **Style-to-model intelligence** — Claude automatically selects the right model for a creative style rather than presenting a 38-model dropdown | Raw Higgsfield UI requires the user to know which model fits their style; the skill eliminates this expertise gap | MEDIUM | Implemented as routing logic in SKILL.md; primary + fallback with human-readable rationale so Claude can explain the choice |
| **Style-optimized parameter defaults** — each skill pre-fills sensible defaults (aspect ratio, duration, quality) tuned for its creative genre | A social-hook skill should default to 9:16 / 5s / high quality; a real-estate walkthrough should default to 16:9 / 8s; raw API users must figure this out manually | MEDIUM | Per-skill default tables in SKILL.md; overridable by user on confirm |
| **Genre/quality parameter selection** — skills that use models with `genre` or `quality` parameters (e.g. `cinematic_studio_3_0` genre: "cinematic"; `marketing_studio_video` genre: "ad") pre-select the right value | Wrong genre wastes credits on off-brand output | LOW | Document genre values per skill from `models_explore`; cinematic → genre:"cinematic"; anime → genre:"animation"; etc. |
| **Reference media workflow** — for I2V skills, skill walks user through the upload → confirm → attach flow, not just dropping a raw file path | `media_upload` + `media_confirm` is a two-step MCP flow; naive users forget `media_confirm`; skill makes it seamless | MEDIUM | Skills 04 (comic), 08 (anime I2V), 09 (product-360), 10 (music-video audio), 11 (social-hook with start frame) need this; others offer it optionally |
| **Multi-model suggestion for complex requests** — some skills can route to different models per sub-task (e.g. ecommerce-ad: `ms_image` for a hero still, then `marketing_studio_video` for the animated version) | Single-model skills miss the image→video pipeline that produces the best DTC ad output | HIGH | Requires skill to ask "do you want a still, a video, or both?" and route accordingly; complex but high value for ecommerce/product/fashion |
| **Audio-aware generation for music-video and veo3 skills** — skills that target `veo3_1` surface the `audio` role and guide upload of an audio track before generation | Music-video skill today is pure text; with audio upload + veo3_1, it becomes genuinely synchronized | HIGH | Requires `media_upload` (audio file) → `media_confirm` → pass audio reference to `generate_video`; only applicable to skill 10 and optionally 05/12 |
| **`presets_show` integration for cinematic_studio** — cinematic and brand-story skills can surface available presets and let user pick one before generation | `cinematic_studio_3_0` supports presets; surfacing them reduces friction for users who want a curated starting point | LOW | One `presets_show` call; surface results in the confirm step |
| **Virality prediction for social-hook** — after prompt generation, skill can call `virality_predictor` on the proposed concept before submitting | Social-hook is explicitly about viral performance; pre-generation virality scoring is a unique signal | LOW | `virality_predictor` is already available per MCP instructions; no extra infrastructure needed |
| **Progressive disclosure architecture** — lean SKILL.md with `references/*.md` for deep-dive content | Current monoliths (700–2300 lines) burn context budget on every invocation; lean structure means faster, cheaper Claude invocations | MEDIUM | Restructuring work, not feature work; but directly enables the above features by freeing context for generation logic |
| **Bilingual (EN + FR) skill content** — all SKILL.md files in English + French | User is French; French speakers have almost no native AI generation skill resources | LOW | Translation pass; no architectural complexity |

---

### Anti-Features (Commonly Requested, Often Problematic)

| Feature | Why Requested | Why Problematic | Alternative |
|---------|---------------|-----------------|-------------|
| **Auto-generate without confirmation** | Faster workflow; "just make it" | Credits are real money; accidental triggers in skill invocation would silently drain balance; hard constraint in PROJECT.md | Always present the prompt + model + estimated cost + explicit confirm step before any `generate_*` call |
| **Cross-provider generation (Runway, Sora, Midjourney direct APIs)** | More model variety | N separate API integrations, N auth flows, N billing systems; Higgsfield already aggregates Kling, Bytedance, Google, xAI, BFL behind one MCP; adding direct APIs adds complexity with no new capability | Stay within Higgsfield; if a new provider matters, it appears in the Higgsfield catalog |
| **Automatic model selection without transparency** | Simplicity | If Claude silently picks a model, user can't learn, can't override, can't debug when output is wrong | Always name the chosen model and explain the routing decision in 1 sentence before confirm |
| **Hardcoded spec values not from models_explore** | Faster authoring; "just write 1080p" | Model specs change; hardcoded values drift and become lies; already the root cause of current skill's "4K/.webm" errors | Source all specs from the live `models_explore` at skill authoring time; document the query used |
| **Single monolithic SKILL.md with all reference content inlined** | Everything in one place | 700–2300-line context bloat on every invocation; makes adding generation logic difficult; Claude's attention degrades on very long documents | Progressive disclosure: lean SKILL.md (overview + routing + param defaults + generation loop) + `references/*.md` for encyclopedic content |
| **zh-CN translations** | Wider audience | Existing translations are 99% copy-paste (15-real-estate: 28/2344 lines actually translated); maintaining broken translations wastes time and confuses users | EN + FR only, done properly |
| **Polling job_status in a tight loop** | "Show me results immediately" | Excessive MCP calls; Higgsfield likely rate-limits polling; adds latency noise | Submit → provide job_id → tell user to check back or call `job_display` once; don't auto-poll more than 2-3 times with delay |
| **Generating multiple variants automatically** | A/B testing at scale | Each variant costs credits; user may not want 3 versions; silent multi-gen is surprising and expensive | Generate one, offer to regenerate with a specific change on explicit request |

---

## Feature Dependencies

```
[Model Routing Declaration]
    └──required by──> [Valid Parameter Emission]
                          └──required by──> [Prompt → Confirm → Generate Loop]
                                                └──required by──> [Job Status Reporting]

[media_upload + media_confirm]
    └──required by──> [I2V Skills: 04-comic, 08-anime, 09-product-360, 10-music-video]
    └──required by──> [Audio-aware generation: 10-music-video, veo3_1 skills]

[models_explore data at authoring time]
    └──required by──> [Model Routing Declaration]
    └──required by──> [Valid Parameter Emission]
    └──required by──> [Aspect Ratio Guidance]
    └──required by──> [Duration Guidance]

[Credit/Balance Visibility]
    └──enhances──> [Prompt → Confirm → Generate Loop]

[presets_show]
    └──enhances──> [01-cinematic, 12-brand-story confirm step]

[virality_predictor]
    └──enhances──> [11-social-hook prompt step]

[Progressive Disclosure Architecture]
    └──enables──> [All generation features] (by freeing context budget)

[Multi-model suggestion]
    └──requires──> [Model Routing Declaration]
    └──conflicts with──> [Auto-generate without confirmation] (complexity makes silent gen worse)
```

### Dependency Notes

- **Model routing requires models_explore data at authoring time:** The routing table in each SKILL.md must be authored with live catalog data. If the catalog changes, skills need re-auditing. Mitigate by noting the capture date in each skill.
- **I2V skills require media_upload before generate_video:** Skills 04, 08, 09, and 10 cannot function as I2V without the upload step. The confirm loop must check whether a reference media reference exists and prompt for upload if not.
- **Progressive disclosure enables generation features:** The current monolith structure leaves too little context budget for generation logic. Lean SKILL.md is a prerequisite for reliably fitting the generation loop in context.
- **virality_predictor enhances social-hook but is not blocking:** It's a value-add that can be skipped if MCP call fails; the skill degrades gracefully to pure prompt output.
- **Audio-aware generation conflicts with basic text-to-video flow:** They are the same `generate_video` call but with vs. without the `audio` role parameter. Skills must branch: "do you have an audio track to attach?" before composing the call.

---

## Per-Feature Parameter Specification

### What Each Skill Must Emit (Parameter Reference)

The following parameters are per-model; skills must only include parameters their chosen model supports.

**`cinematic_studio_3_0` (skills 01, 05, 12, 15 primary)**
- `resolution`: per catalog (likely 720p or 1080p — verify via `models_explore`)
- `aspect_ratio`: from the model's declared `aspect_ratios` list
- `duration`: from `durations` list (not `duration_range` — verify which field applies)
- `genre`: "cinematic" (hardcode for this model in cinematic/brand-story/real-estate; "action" for fight-scenes)
- `quality`: if supported
- No `audio` role unless model declares it

**`veo3_1` (skills 01/12/15 fallback, skill 10 primary)**
- `aspect_ratio`: from catalog
- `duration`: from catalog
- `audio`: role — skill 10 must surface this; skills 01/12/15 can optionally use it for voiced narration
- `quality`: if supported
- No `genre` parameter (veo3 family does not use genre)

**`marketing_studio_video` (skills 06, 07 primary)**
- `aspect_ratio`: from catalog (likely 9:16, 1:1, 16:9 for ad formats)
- `duration`: from catalog (likely short: 5–15s)
- `genre`: "ad" or equivalent — verify
- `quality`: if supported

**`ms_image` / DTC Ads image model (skill 07 image path)**
- `aspect_ratio`: from catalog
- `quality`: if supported
- No `duration` (image, not video)

**`seedance_2_0` (skills 02, 09 primary; 03, 04, 14 fallback)**
- `aspect_ratio`: 16:9, 9:16, 1:1 (confirmed in existing skill content)
- `duration`: verify range via `models_explore` (existing skills claim 5–60s but this must be confirmed)
- `mode`: if applicable (I2V vs T2V mode)
- `start_image` role: for product-360 when user provides a reference photo

**`wan2_6` / `wan2_7` (skills 03, 04, 08)**
- `aspect_ratio`: from catalog
- `duration`: from catalog
- `start_image` role (wan2_6): for comic-to-video panel animation
- Style/mode parameters: verify via `models_explore`

**`kling3_0` (skill 11 primary, skill 05 fallback)**
- `aspect_ratio`: from catalog
- `duration`: from catalog (likely 5–10s for short-form hooks)
- `mode`: if applicable

**`grok_video` (skill 11 fallback)**
- Parameters vary from other models; verify `models_explore` output

---

## Opt-In Generation UX — The Loop

This is the required interaction pattern for all 15 skills when generation is requested:

```
Step 1: CRAFT
  Claude builds prompt using skill's framework
  Claude selects primary model (or asks if user has a preference)
  Claude selects parameters (aspect_ratio, duration, quality, genre)
  Claude checks: does this skill need reference media?
    YES → go to Step 1b
    NO  → go to Step 2

Step 1b: MEDIA UPLOAD (conditional)
  Claude: "This generation needs a reference [image/audio]. Please provide the file path."
  User provides path
  Claude calls: media_upload(file_path) → get upload_id
  Claude calls: media_confirm(upload_id)
  Claude attaches upload_id as start_image/audio/etc. in the generation call

Step 2: CONFIRM
  Claude presents:
    - The full prompt text
    - Model: [model_id] (with 1-sentence rationale)
    - Parameters: aspect_ratio, duration, quality, genre (if applicable)
    - Reference media: [attached / not needed]
    - Credit cost: [call show_plans_and_credits or balance to surface available credits]
  Claude asks: "Generate this? (yes / adjust / cancel)"

Step 3: GENERATE
  User confirms
  Claude calls: generate_image(...) or generate_video(...)
  Claude receives: job_id

Step 4: REPORT
  Claude calls: job_status(job_id) — once immediately
  If status = "completed": call job_display(job_id) → surface result
  If status = "pending"/"processing": report job_id, tell user to check back
  Claude offers: "Want to regenerate with a different parameter?"
```

**Key UX rules:**
- Never skip Step 2. Never auto-run Step 3.
- The credit balance surface in Step 2 is informational; Claude does not block generation if balance is low (user decides).
- If `virality_predictor` is available (skill 11), run it between Step 1 and Step 2 and include the score in the confirm panel.
- If `presets_show` is relevant (skills 01, 12), surface preset options before Step 1 finishes.

---

## MVP Definition

### Launch With (v1) — Minimum Viable Model-Aware Skills

The goal is 15 reworked skills that can actually generate, not just output text.

- [ ] **Model routing table in each SKILL.md** — covers all 15 skills with primary + fallback; sourced from live `models_explore` — *without this nothing else works*
- [ ] **Valid parameter sections per skill** — aspect_ratio, duration, quality, genre defaults for chosen model — *prevents API errors*
- [ ] **Prompt → confirm → generate loop** — the exact Step 1-4 UX above, documented in each SKILL.md so Claude executes it — *this is the "opt-in generation" requirement*
- [ ] **Job status + display reporting** — `job_status` + `job_display` after every generation — *users need to see results*
- [ ] **media_upload flow for I2V skills** — skills 04, 08, 09, 10 must document and trigger the upload step — *these skills are broken without it*
- [ ] **Credit visibility in confirm step** — `balance` or `show_plans_and_credits` surfaced before generation — *minimum cost transparency*
- [ ] **Factual spec cleanup** — remove all invented specs (4K, .webm, etc.) from existing skill content — *trust repair*
- [ ] **Progressive disclosure structure** — lean SKILL.md + references/ — *context budget for generation logic*

### Add After Validation (v1.x)

- [ ] **Multi-model routing per skill** (image still → video pipeline for skills 07, 09, 13) — add once single-model flow is stable
- [ ] **Audio-aware generation for skill 10** — veo3_1 audio role integration; add once basic video generation is stable
- [ ] **`presets_show` integration for cinematic/brand-story** — low-effort add once generation loop is tested
- [ ] **`virality_predictor` in social-hook confirm step** — one extra MCP call; add once basic loop works

### Future Consideration (v2+)

- [ ] **Dynamic model routing** — call `models_explore` at runtime to check if a model is available before routing — defers catalog drift problem
- [ ] **Variant generation with explicit multi-gen confirm** — "generate 3 variants, costs 3x credits, confirm?" — only after v1 UX is validated
- [ ] **`higgsfield_preset` integration** — preset-based generation for power users — niche, defer
- [ ] **`image_auto` routing** — auto-model selection for image generation where user is agnostic — useful but complex

---

## Feature Prioritization Matrix

| Feature | User Value | Implementation Cost | Priority |
|---------|------------|---------------------|----------|
| Model routing declaration (all 15 skills) | HIGH | LOW | P1 |
| Prompt → confirm → generate loop | HIGH | MEDIUM | P1 |
| Valid parameter emission per model | HIGH | MEDIUM | P1 |
| media_upload flow for I2V skills (04, 08, 09, 10) | HIGH | MEDIUM | P1 |
| Job status + display reporting | HIGH | LOW | P1 |
| Factual spec cleanup | HIGH | LOW | P1 |
| Credit visibility in confirm step | MEDIUM | LOW | P1 |
| Progressive disclosure structure (lean SKILL.md) | HIGH | MEDIUM | P1 |
| Aspect ratio + duration guidance tables | MEDIUM | LOW | P1 |
| EN + FR bilingual content | MEDIUM | LOW | P2 |
| presets_show for cinematic/brand-story | LOW | LOW | P2 |
| virality_predictor for social-hook | MEDIUM | LOW | P2 |
| Audio-aware generation for music-video (veo3_1) | HIGH | HIGH | P2 |
| Multi-model routing (image→video pipelines) | MEDIUM | HIGH | P2 |
| Dynamic model routing via live models_explore | LOW | HIGH | P3 |
| Variant generation with multi-gen confirm | LOW | MEDIUM | P3 |

**Priority key:**
- P1: Must have for v1 launch
- P2: Should have, add when P1 is stable
- P3: Nice to have, future milestone

---

## Sources

- `/Users/dardan/Desktop/pixelab/Repo/Higgsfield seedance 2.0/.planning/PROJECT.md` — Higgsfield model catalog, MCP tool list, constraints (audited 2026-05-24)
- `skills/07-ecommerce-ad/SKILL.md` — current skill structure, existing spec claims (verified against PROJECT.md)
- `skills/09-product-360/SKILL.md` — current skill structure, I2V workflow claims
- All 15 skill frontmatter headers — for name, description, and scope boundaries
- Higgsfield MCP server instructions (from system context) — confirmed available tools: `generate_image`, `generate_video`, `models_explore`, `job_status`, `job_display`, `media_upload`, `media_confirm`, `presets_show`, `show_plans_and_credits`, `balance`, `select_workspace`, `virality_predictor`

---

*Feature research for: model-aware Claude Agent Skills on Higgsfield*
*Researched: 2026-05-24*
