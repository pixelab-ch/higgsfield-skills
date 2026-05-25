# Panel-Craft: Comic-to-Video Technique Library

Guidance for animating static comic panels, manga pages, webtoons, and sequential art
into video using Higgsfield. Covers reading-order conventions, dialogue handling,
art-style preservation, and 15+ panel-to-motion techniques.

---

## Table of Contents

1. [Reading Order — Critical Foundation](#reading-order--critical-foundation)
2. [Art Style Preservation](#art-style-preservation)
3. [Dialogue and Sound Effect Handling](#dialogue-and-sound-effect-handling)
4. [Panel-to-Motion Technique Library](#panel-to-motion-technique-library)
5. [Transition Techniques](#transition-techniques)
6. [Multi-Page Sequencing](#multi-page-sequencing)
7. [Common Mistakes and Fixes](#common-mistakes-and-fixes)

---

## Reading Order — Critical Foundation

Comics are sequence-dependent. Specifying reading order tells the model which panel
is the setup and which is the payoff, controls camera pan direction, and determines
narrative momentum.

| Format | Order | Prompt annotation | Camera bias |
|--------|-------|-------------------|-------------|
| Western superhero / indie | Left-to-right, top-to-bottom | `READING ORDER: Western LTR` | Left → right |
| Japanese manga / manhwa | Right-to-left, top-to-bottom | `READING ORDER: Manga RTL` | Right → left |
| Webtoon / vertical scroll | Top-to-bottom | `READING ORDER: Webtoon Vertical` | Down |
| 4-Koma comedy strip | 2×2 grid or 1×4 vertical | `READING ORDER: 4-Koma` | Setup → punchline timing |
| European ligne claire / BD | Mixed; visual flow dominates | `READING ORDER: European` | Composition-driven |

**Failure to specify reading order** causes the model to default to Western LTR, which
will reverse narrative flow for Manga RTL content.

---

## Art Style Preservation

Use explicit style-preservation keywords to keep the original artwork's aesthetic through
motion synthesis.

### Ink and line technique

- Heavy ink: `"Preserve thick, bold black line work"`
- Thin ink: `"Maintain delicate, precise pen strokes"`
- Crosshatching: `"Retain crosshatched shading patterns during movement"`
- Flowing/organic: `"Maintain soft, flowing linework characteristic of watercolor"`

### Color model

- CMYK halftone: `"Preserve CMYK color separation and halftone dot patterns"`
- Flat digital: `"Maintain digital flat color palette without gradient interpolation"`
- Watercolor: `"Preserve soft, organic watercolor color transitions"`
- Monochrome: `"Preserve two-color or single-color ink aesthetic"`

### Tone and texture

- Screen tone: `"Retain manga screen tone pattern (preserve pattern, not just color)"`
- High contrast: `"Maintain strong black-and-white contrast, minimal gray tones"`
- Clean/polished: `"Maintain pristine, production-ready artwork finish"`

### Visual grammar

- Manga speed lines: `"Preserve action speed lines as environmental elements"`
- Shout lines: `"Preserve radiating stress lines around characters"`
- Sweat drops / stars: `"Maintain characteristic emotional marker details"`

---

## Dialogue and Sound Effect Handling

### Speech bubble types and animation cues

| Bubble type | Indication | Animation response |
|-------------|------------|-------------------|
| Standard (circular/rectangular) | Calm or neutral speech | Natural mouth movement, moderate body language |
| Cloud (wispy/organic) | Thought / internal monologue | Softer, introspective body language; unfocused eyes |
| Jagged/spiky | Yelling / intense emotion | Emphatic gestures, tense posture, sharp movements |
| Wavy | Weakness / fear / uncertainty | Trembling, hesitation, withdrawn movements |
| Small (whisper) | Quiet speech / secret | Close proximity to listener, lowered voice posture |

**Bubble tail direction:** The tail points to the speaker. Direct animation toward that
character. Multiple tails = back-and-forth dialogue in one panel. No tail = narration.

### Timing by word count

| Word count | Approximate duration |
|------------|---------------------|
| 1–3 words | 0.5–0.8 s |
| 4–7 words | 1.0–1.5 s |
| 8–12 words | 1.8–2.5 s |
| 13+ words | 2.5–4.0 s |

### Sound effects (onomatopoeia) as motion cues

- **Impact sounds** (POW, BANG, CRASH): Trigger sharp, concussive character motion
- **Motion sounds** (WHOOSH, ZOOM): Speed lines become motion, smooth directional animation
- **Emotional sounds** (THUMP, SOB, SIGH): Micro-movements, breathing, throat gestures
- **Environmental sounds** (RUMBLE, CRACKLE): Background elements animate to source the sound

---

## Panel-to-Motion Technique Library

### 1. Static-to-dynamic stance transition

Prompt structure: "Animate [character] transitioning from [initial pose] to [final pose].
Use natural weight-shift that shows [emotional state]. Preserve line of action. Duration: [X s]."

### 2. Dialogue speech pattern animation

Prompt structure: "Animate [character] speaking '[dialogue]'. Mouth follows [language]
phonetics. Add emphasis gesture [action] at emotional peak. Duration: [X s]."

### 3. Impact sequencing (setup → follow-through)

Prompt structure: "Panel 1 shows [setup]. Panel 2 shows [result]. Animate the connecting
motion. Add secondary motion [reaction / trail / disturbance]. Physics: [realistic / comic /
anime]. Duration: [X s]."

### 4. Environmental animation (background to active)

Prompt structure: "Keep character static. Animate environment: [element 1] [motion],
[element 2] [motion]. Focus on [subtle/dramatic] motion conveying [mood]. Duration: [X s]."

### 5. Camera push-in or zoom

Prompt structure: "Camera slowly [zooms in / pushes toward] [target]. Maintain [expression /
stability] as camera moves. Speed: [slow/medium/fast]. Final framing: [description]. Duration: [X s]."

### 6. Panning camera

Prompt structure: "Camera pans from [start] to [end]. Direction: [LTR / RTL / vertical /
diagonal]. Pacing: [matches / leads / trails] character movement. Duration: [X s]."

### 7. Rotate / spin motion

Prompt structure: "Animate [subject] rotating [degrees] around [axis]. Direction:
[clockwise / counter-clockwise]. Speed: [slow/rapid]. Add [trailing effects]. Duration: [X s]."

### 8. Facial expression morphing

Prompt structure: "Animate expression morphing from [initial] to [final]. Key changes:
[eyebrows / eyes / mouth / muscle tension]. Smoothness: [natural / exaggerated]. Duration: [X s]."

### 9. Hand gesture and pointing

Prompt structure: "Animate hand gesture: [shape/motion/target]. Arm motion: [location /
speed / emphasis]. Correspond to [emotion]. Body: [stays still / rotates to follow]. Duration: [X s]."

### 10. Depth shift (foreground ↔ background)

Prompt structure: "Animate [subject] moving from [foreground/background] to [opposite].
Scale change: [grows / shrinks]. Maintain [expression / pose quality]. Duration: [X s]."

### 11. Particle and effect motion

Prompt structure: "Animate effect: [type and description]. Origin: [frame location].
Dispersal: [direction / spread / dissipation]. Interaction with character/environment.
Intensity: [subtle/moderate/intense]. Duration: [X s]."

### 12. Multiple character synchronization

Prompt structure: "Coordinate [Character A]: [motion]; [Character B]: [responding motion].
Synchronization points: [aligned moments]. Eye contact / spatial relationship: [description].
Duration: [X s]."

### 13. Speed line / motion indicator activation

Prompt structure: "Convert speed lines into motion: [what they indicate]. Animate the
[character/object] performing the indicated action. Line density informs [speed / direction].
The result should make lines feel [natural / residual]. Duration: [X s]."

### 14. Microexpression / subtle shift

Prompt structure: "Animate subtle changes indicating [emotional state]: [micro-movement 1],
[micro-movement 2]. Maintain [baseline pose/expression]. This should feel [barely noticeable].
Duration: [X s]."

### 15. Major pose transition (between panels)

Prompt structure: "Transition from [Pose A] to [Pose B]. Intermediate frames: [natural path].
Weight and physics: [realistic / comic / anime]. Emphasis: [final pose / journey / snappy].
Duration: [X s]."

---

## Transition Techniques

| Technique | Feel | Best for |
|-----------|------|----------|
| Dissolve / fade | Dreamlike, contemplative | Time passage, location change, emotional moments |
| Crack / shatter | Violent, dramatic | Shocking reveals, action climaxes, reality-breaking |
| Wipe | Directional, active | Action sequences, narrative progression |
| Morph | Surreal, transformative | Magical change, dreamscapes, internal transformation |
| Page turn / flip | Tactile, bookish | Webtoons, manga, medium-aware transitions |
| Ink splash / effect | Artistic, energetic | Scene changes with stylistic emphasis |

**Selection guide:**
- Dialogue-heavy: Dissolve
- Action sequences: Wipe or Crack
- Emotional beats: Morph or Dissolve
- Webtoon / digital: Page Turn or Wipe
- Shocking moments: Crack or Ink Splash
- Time passage: Dissolve or Fade

---

## Multi-Page Sequencing

When animating multiple pages in sequence, always include:

1. **Reading order** — specified once at top level; applies to all pages
2. **Character continuity notes** — same face structure, color, proportions across pages
3. **Environment continuity** — same setting or explicit spatial relationship between settings
4. **Pacing architecture** — define emotional peak per page and how pages relate in energy level
5. **Inter-page transition** — seamless flow / brief pause / dramatic break

**Prompt structure for multi-page:**

```
READING ORDER: [format]
PAGES: [count]

PAGE 1:
[Panel-by-panel breakdown per page]

PAGE 2:
[Panel-by-panel breakdown]

OVERARCHING ARC: [Setup → Escalation → Climax → Resolution]
CHARACTER CONTINUITY: [Physical consistency notes]
ENVIRONMENT CONTINUITY: [Spatial / lighting / atmosphere notes]
```

---

## Common Mistakes and Fixes

| Mistake | Fix |
|---------|-----|
| Not specifying reading order | Add `READING ORDER: [format]` before panel descriptions |
| No art style keywords | Include ink technique, color model, tone/texture keywords in every prompt |
| Vague dialogue interpretation | Specify speaker, emotion, delivery, associated gesture, timing |
| Too short duration for complex sequences | 0.6–1.5 s per panel minimum; dialogue scenes need more |
| Inconsistent character proportions | Provide specific reference notes for face, torso/limb ratio, posture baseline |
| Missing dialogue bubble ownership | Always specify `Speaker: [name]`, `Bubble Position:`, `Bubble Tail Points:` |
| Uniform panel timing | Weight panels by emotional importance — dialogue needs more time than action |
| Over-detailed environment | Prioritize: character animation > camera > environment |
| Missing SFX timing | Write `SFX: [name] at [timestamp]` and sync to character motion explicitly |
