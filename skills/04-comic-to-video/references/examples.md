# Comic-to-Video Prompt Examples

Worked prompts for comic-to-video generation using the mandatory image-upload flow.
All examples assume the source panel has been uploaded and confirmed via
`higgsfield:media_upload` → `higgsfield:media_confirm` before the generate call.

---

## Table of Contents

1. [Master Template](#master-template)
2. [Example 1: Western Action Page](#example-1-western-action-page)
3. [Example 2: Manga Emotional Scene (RTL)](#example-2-manga-emotional-scene-rtl)
4. [Example 3: Webtoon Vertical Sequence](#example-3-webtoon-vertical-sequence)
5. [Example 4: Storyboard-to-Video](#example-4-storyboard-to-video)
6. [Example 5: Single Illustration Brought to Life](#example-5-single-illustration-brought-to-life)
7. [Platform and Duration Quick Reference](#platform-and-duration-quick-reference)

---

## Master Template

Use this structure as the starting point for any comic-to-video conversion prompt:

```
READING ORDER: [Western LTR / Manga RTL / Webtoon Vertical / European / 4-Koma]

PANEL SEQUENCE:
Panel 1 (Setup):
- Character(s): [description and pose]
- Environment: [setting, lighting, details]
- Action: [what is happening]
- Speech/Sound: [dialogue, narration, SFX]

Panel 2 (Action/Escalation):
[repeat format]

Panel 3 (Resolution/Reaction):
[repeat format]

TWO-SECOND HOOK: [hook type from hooks.md]
[describe how the hook manifests in the first 2 seconds]

ART STYLE KEYWORDS: [ink weight, color model, technique]

ANIMATION DIRECTION:
- Character Motion: [primary character movement and emotional arc]
- Camera Work: [pan direction, zoom, rotation based on reading order]
- Environmental Motion: [background elements, effects, transitions]
- Pacing: [slow/medium/fast, justified by narrative]
- Tone: [serious, comedic, surreal, etc.]

DIALOGUE INTERPRETATION:
- Speaker 1: [emotion, delivery, animated emphasis]
- Speaker 2: [if applicable]

TRANSITION TECHNIQUE: [technique name]

PARAMETERS:
- Model: wan2_6 (primary) or seedance_2_0 (fallback)
- Duration: [5, 10, or 15 s for wan2_6; 4–15 s for seedance_2_0]
- Aspect ratio: [16:9, 9:16, or 1:1 for wan2_6]
- Quality: [720p or 1080p for wan2_6]
- input_files: [{ "id": "<confirmed_id>", "role": "image" }]

NOTES: [special considerations, style references, continuity details]
```

---

## Example 1: Western Action Page

**Source:** Superhero confrontation — three-panel sequence: setup, clash, impact.

```
READING ORDER: Western LTR

PANEL SEQUENCE:
Panel 1 (Setup):
- Character: Superman, mid-air, fists clenched, cape billowing, angled toward right
- Environment: Metropolis skyline at twilight, buildings blurred to show motion
- Action: Full-force punch launching toward the right panel edge
- Speech/Sound: "For Earth!" + KRAAAAASSHHH (impact SFX beginning)

Panel 2 (Clash):
- Character: Darkseid bracing, arms crossed, showing surprise and pain
- Environment: Same skyline, visible shockwave radiating outward
- Action: Superman's punch connects
- Speech/Sound: (no dialogue — pure action)

Panel 3 (Reaction):
- Character: Superman follow-through, Darkseid recoiling backward
- Environment: Buildings shaking, rubble and dust, light effects
- Action: Momentum still visible in both characters
- Speech/Sound: "You can't win, Superman..." (defiant but hurt)

TWO-SECOND HOOK: Dramatic Panel Crack/Shatter Reveal
First 2 s: Superman's approach in Panel 1, then at moment of impact the panel border
CRACKS and SHATTERS outward, revealing the collision. Shatter radiates from the impact
point.

ART STYLE KEYWORDS:
- Heavy black ink outlines (DC Comics style)
- CMYK halftone shading in skin and shadow areas
- High-contrast primary color palette (reds, blues, yellows)
- Manga-influenced speed lines in Panel 1
- Comic book emphasis lines around the Panel 2 impact

ANIMATION DIRECTION:
- Character Motion: Superman flows from setup into full punch. Darkseid braces, then
  recoils with visible knockback. Follow-through shows weight distribution changing.
- Camera Work: Pan left-to-right with Superman's motion (Western LTR convention).
  Slight push-in at impact, then pull-back to show aftermath.
- Environmental Motion: Buildings shake at impact. Dust and rubble animate outward.
- Pacing: Fast. Panel 1→2: 0.7 s. Panel 2→3: 0.5 s. Total: 2.5 s.
- Tone: Serious, epic, physical.

DIALOGUE INTERPRETATION:
- "For Earth!" — Determined, heroic, final declaration. Panel 1.
- "You can't win, Superman..." — Defiant despite pain. Panel 3.

TRANSITION TECHNIQUE: Crack (Panel 1→2), Dust Wipe (Panel 2→3)

PARAMETERS:
- Model: wan2_6
- Duration: 5 s
- Aspect ratio: 16:9
- Quality: 1080p
- input_files: [{ "id": "<confirmed_id>", "role": "image" }]
```

---

## Example 2: Manga Emotional Scene (RTL)

**Source:** Japanese manga, realization between two characters — emotional beat over action.

```
READING ORDER: Manga RTL (Right-to-Left)

PANEL SEQUENCE:
Panel 1 (Right side — read first):
- Character: Female protagonist, back partially turned, looking toward right (toward reader)
- Environment: Indoor, moonlight through window, soft shadows
- Action: Hesitating, building courage
- Speech/Sound: [Thought bubble] "I have to tell him... before it's too late."

Panel 2 (Center):
- Character: Male character, facing slightly left, neutral expression, unaware
- Environment: Same room, focus on his profile
- Action: Hasn't noticed her yet
- Speech/Sound: (silent, heavy with anticipation)

Panel 3 (Left side — read third):
- Character: Male character now facing female protagonist, shock and emotion visible
- Environment: Both characters in frame, moonlight on faces
- Action: Realization dawning
- Speech/Sound: "I... I didn't know you felt this way..."

TWO-SECOND HOOK: Speech Bubble Pops to Life
Thought bubble in Panel 1 trembles and expands slightly, protagonist's mouth begins to move.
Bubble seems to burst with her courage as she prepares to speak.

ART STYLE KEYWORDS:
- Clean manga line work (fine ink weight, not heavy)
- Minimal screen tone (mostly white space, selective darks for mood)
- Large, expressive eyes (shoujo manga style)
- Flowing hair movement (emotional state indicator)

ANIMATION DIRECTION:
- Character Motion: Panel 1: hand trembles at chest, breathing quickens. Panel 2: male
  remains still. Panel 3: male turns, eyebrows rise, eyes widen. Her shoulders relax.
- Camera Work: Pan right-to-left (RTL reading convention). Slow and deliberate.
- Environmental Motion: Moonlight steady. Subtle breeze moves her hair.
- Pacing: Slow. Panel 1→2: 1.5 s. Panel 2→3: 1.2 s. Total: 3.5 s.
- Tone: Tender, vulnerable, intimate.

DIALOGUE INTERPRETATION:
- Thought bubble: Internal, hesitant, near-whisper. Building resolve.
- "I... I didn't know...": Surprised, processing. Emotional depth beneath surface shock.

TRANSITION TECHNIQUE: Soft Dissolve (1→2), Morph (2→3)

PARAMETERS:
- Model: wan2_6
- Duration: 5 s
- Aspect ratio: 9:16
- Quality: 1080p
- input_files: [{ "id": "<confirmed_id>", "role": "image" }]
```

---

## Example 3: Webtoon Vertical Sequence

**Source:** Vertical webtoon, four panels building height/danger from top to bottom.

```
READING ORDER: Webtoon Vertical

PANEL SEQUENCE:
Panel 1 (Top):
- Character: Standing at cliff edge, viewed from behind/above, arms at sides
- Environment: Sunny, safe landscape behind, cliff edge in foreground
- Action: Approaching the edge
- Speech/Sound: "Just one more step... I can do this."

Panel 2 (Upper-middle):
- Character: Same character, now on very edge, feet slightly apart
- Environment: Wind visible in hair/clothing; less landscape visible
- Action: Gazing down (drop not yet visible)
- Speech/Sound: (silence)

Panel 3 (Lower-middle):
- Character: Extreme close-up on face — fear/determination conflict
- Environment: Wind visible around them; sky behind
- Action: Eyes closed, deep breath
- Speech/Sound: [Thought] "What am I doing...?"

Panel 4 (Bottom):
- Character: Full body, but now vast drop is visible
- Environment: Massive canyon below, tiny objects far down
- Action: Character leans forward — point of no return
- Speech/Sound: (silent, wind howling implied)

TWO-SECOND HOOK: Page Turn / Parallax Reveal
Opens with character safely framed in Panel 1. Vertical scroll begins, layers shift at
different speeds (parallax), creating 3D dizzying depth.

ART STYLE KEYWORDS:
- Digital flat colors (webtoon style)
- Soft, rounded character designs
- Minimal ink lines (modern digital aesthetic)
- Smooth color gradients, no screen tone

ANIMATION DIRECTION:
- Character Motion: Panel 1 casual walking. Panels 2–3 movement slows, more deliberate.
  Panel 4: leans forward, weight shifting.
- Camera Work: Vertical pan downward through all panels. Pull-back zoom to reveal full drop.
  Parallax: foreground (character, cliff) slower; background (distant landscape) faster.
- Environmental Motion: Wind increases throughout — hair, clothing flutter builds.
- Pacing: Slow build. 1→2: 1.2 s. 2→3: 1.5 s. 3→4: 1.8 s. Total: 4.5 s.
- Tone: Suspenseful, introspective, vertiginous.

TRANSITION TECHNIQUE: Vertical wipe downward (each panel into next) + Parallax shift

PARAMETERS:
- Model: wan2_6
- Duration: 5 s
- Aspect ratio: 9:16
- Quality: 1080p
- input_files: [{ "id": "<confirmed_id>", "role": "image" }]
```

---

## Example 4: Storyboard-to-Video

**Source:** Film storyboard — simple line drawings, minimal detail, clear storytelling.

```
READING ORDER: Western LTR

PANEL SEQUENCE:
Panel 1 (Establishing):
- Character: Protagonist in dark clothing approaching window; guard at opposite end
- Environment: Corporate office, high floor, nighttime
- Action: Protagonist moves stealthily along wall, avoiding guard
- Speech/Sound: [Narration] "The hard part isn't getting in. It's getting out."

Panel 2 (Detail):
- Character: Close-up of gloved hand reaching for keypad
- Environment: Electronic lock, red indicator light
- Action: Hand inputs code; light turns green
- Speech/Sound: [SFX] "BEEP" + mechanical "Click"

Panel 3 (Wide):
- Character: Protagonist entering vault, silhouetted against interior light
- Environment: Vault interior, glowing displays
- Action: Moving toward objective
- Speech/Sound: (silent triumph)

Panel 4 (Tension):
- Character: Security guard on radio, noticing opened vault door
- Environment: Guard's position, hallway from guard's perspective
- Action: Guard's expression shifts from bored to alert
- Speech/Sound: "We've got a breach on Level 47."

TWO-SECOND HOOK: Spotlight/Light Flare Focus
Darkness, then single spotlight sweeps across hallway, forcing protagonist to freeze and hide.
Sweep creates the visual rhythm driving the opening.

ART STYLE KEYWORDS:
- Simple line drawings (storyboard economy of line)
- Minimal shading (line-based value indication)
- High contrast (black lines, strategic solid blacks for shadow)
- NO decorative detail — every line serves narrative purpose

ANIMATION DIRECTION:
- Character Motion: Panel 1: careful, controlled, weight distributed for silence.
  Panel 2: precise practiced hand movement. Panel 3: confident stride. Panel 4: sudden alertness.
- Camera Work: Panel 2 push-in on hand/keypad. Panel 4 cut to guard's spatial position.
- Environmental Motion: Minimal 1–3. Panel 4: radio static, indicator lights convey urgency.
- Pacing: Controlled. 1→2: 1.0 s. 2: 0.8 s. 3: 1.0 s. 4: 1.2 s. Total: 4.0 s.
- Tone: Tense, professional, noir.

DIALOGUE INTERPRETATION:
- Narration Panel 1: Calm, experienced, knowing. Steady pace.
- Guard Panel 4: Urgent, surprised. Professional protocol with tension.

TRANSITION TECHNIQUE: Hard cut (storyboard standard), Wipe LTR (guard perspective shift)

PARAMETERS:
- Model: wan2_6
- Duration: 5 s
- Aspect ratio: 16:9
- Quality: 1080p
- input_files: [{ "id": "<confirmed_id>", "role": "image" }]
```

---

## Example 5: Single Illustration Brought to Life

**Source:** Single striking panel — phoenix-human hybrid in transformation.

```
READING ORDER: Single Panel (centerpoint focus)

PANEL:
- Character: Phoenix-human hybrid, wings spread wide, mid-transform, arms raised
- Environment: Desert ruins at twilight, orange/red sky, cracked burning ground
- Action: Transformation moment — becoming something new and powerful
- Speech/Sound: [Internal] "No more running. This ends now."

TWO-SECOND HOOK: Ink Splash Transition
Character visible but still. At 0.5 s, ink/flame effects splash outward from character's
core, temporarily obscuring them. At 1.0 s splash clears, character revealed more alive,
with wings beginning to move.

ART STYLE KEYWORDS:
- Heavy dramatic line work (thick blacks in wings and contours)
- Digital oil painting finish in environment (soft blend, luminous colors)
- Watercolor-like transparency in fire effects
- High saturation in oranges, reds, yellows (fire palette)
- Strong backlighting creates halo effect

ANIMATION DIRECTION:
- Character Motion: Wings begin to beat (slow, powerful strokes). Body trembles with
  transformative energy. Arms extend further. Posture moves from effort to triumph.
- Camera Work: Start wide (full character + environment). Camera slowly pushes in ~40%
  zoom over 5 s as transformation progresses.
- Environmental Motion: Ruins crack further. Ground fires flare. Wind kicks up dust and
  debris flowing outward from character.
- Pacing: Slow start (0.0–1.5 s). Middle fast (1.5–3.5 s: wing deployment). Final slower
  (3.5–5.0 s: settling). Total: 5.0 s.
- Tone: Powerful, transformative, triumphant despite struggle.

DIALOGUE INTERPRETATION:
- Internal monologue: Start hesitant, end resolute. Timed to peak at full transformation.

TRANSITION TECHNIQUE: N/A (single panel; Ink Splash is transformation hook, not a transition)

PARAMETERS:
- Model: wan2_6
- Duration: 5 s
- Aspect ratio: 16:9
- Quality: 1080p
- input_files: [{ "id": "<confirmed_id>", "role": "image" }]
```

---

## Platform and Duration Quick Reference

| Platform | Aspect ratio (wan2_6) | Duration (wan2_6) |
|----------|-----------------------|-------------------|
| TikTok / Reels / Shorts | `9:16` | `5` s |
| YouTube (standard) | `16:9` | `10` or `15` s |
| Instagram feed | `1:1` | `5` or `10` s |
| Twitter / X | `16:9` or `1:1` | `5` s |
| Webtoon platform | `9:16` | `10` or `15` s |

**wan2_6 duration is a discrete set: `[5, 10, 15]` — no other values are valid.**
If you need a duration outside this set, route to `seedance_2_0` (4–15 s continuous).
