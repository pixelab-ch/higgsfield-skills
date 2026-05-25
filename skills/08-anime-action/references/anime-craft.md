# Anime-Craft: Anime Motion Language and Technique Library

Guidance for generating authentic anime-style video from a reference frame using Higgsfield.
Covers anime visual language, action choreography, style-transfer principles, camera
techniques, and genre-specific visual identities.

---

## Table of Contents

1. [Anime Visual Language](#anime-visual-language)
2. [Action Choreography](#action-choreography)
3. [Style Transfer Principles](#style-transfer-principles)
4. [Camera Techniques](#camera-techniques)
5. [Lighting and Color Theory](#lighting-and-color-theory)
6. [Genre Visual Identity Guide](#genre-visual-identity-guide)
7. [Anime-Specific Visual Effects Library](#anime-specific-visual-effects-library)
8. [Character Design Keywords](#character-design-keywords)
9. [Common Mistakes and Fixes](#common-mistakes-and-fixes)

---

## Anime Visual Language

Anime is a sophisticated Japanese animation tradition with distinct visual principles —
not simply "cartoon." Mastering these principles produces authentic anime output.

### Core principles

**Limited animation with impact frames.** Key frames are placed where they matter most,
not evenly distributed. The gaps between frames are intentional. A punch travels fully in
0.2 s; static poses hold for 0.5–1 s. This creates visual rhythm impossible in full-motion
animation.

**Cel shading and flatness.** Characters are rendered on 2D planes. Shadows are solid color
blocks, not gradients. Hair and clothing have defined edges. Light reveals form without
photorealism.

**Speed lines (streaks).** Motion is shown through sharp straight lines radiating from a
vanishing point — not motion blur. Lines are clean and precise. They appear behind moving
objects or fill the screen during fast camera movement.

**Color psychology.** Every color choice is intentional:
- Warm saturated colors (reds, golds, oranges): action, passion, energy
- Cool desaturated colors (blues, purples, grays): melancholy, mystery, introspection
- High-contrast saturation: dynamic action with bold primaries
- Pastel/muted tones: slice-of-life, nostalgia, peaceful moments

**Eye design.** Eyes are disproportionately large and detailed. Multiple highlight layers
(stars, crosses, reflections). Iris color is non-realistic. Pupils contract/dilate for
emotion. This is the most expressive element — describe it explicitly.

**Hair physics.** Hair behaves impossibly — it floats, spikes, or flows with non-existent
wind. Hair strands are individually defined. During motion, hair streaks or trails.

---

## Action Choreography

Anime action follows a consistent choreography grammar:

### Setup → Apex → Impact → Aftermath

1. **Setup (0.3–0.8 s):** Character coils backward, speed lines radiate from body center.
   Static pose holds slightly longer than feels natural — building tension.

2. **Apex (0.1–0.2 s):** Smear frame or motion blur across the attack path. The character
   is briefly elongated or distorted to indicate extreme speed.

3. **Impact (0.2–0.4 s):** Frozen moment with cross-shaped or burst highlight at impact
   point. White flash covers center 50–70% of frame. Hold this frame — do not cut away
   immediately.

4. **Aftermath (0.5–2 s):** Secondary character recoils. Dust, sparks, or energy
   particles disperse. Aura or power effect dissipates.

### Power scaling vocabulary

- **Casual strike:** No setup, minimal speed lines, small impact flash, no aura
- **Serious blow:** 0.5 s setup, dense speed lines, medium white flash, short aftermath
- **Signature move:** 0.8 s setup, full-screen speed lines, extended white flash, debris,
  screen shake, aura expansion
- **Ultimate attack:** Extended charge sequence, screen-filling aura, full white-out,
  shockwave ring, 2+ s aftermath

### Key choreography prompt phrases

- Setup: "Character contracts into launch pose, speed lines radiating outward, static hold
  for [X] s"
- Motion: "Smear frame across arc, speed lines trail behind, [X]-frame internal rate"
- Impact: "White flash covers [%] of frame at impact point, cross-shaped highlight appears,
  hold [X] s"
- Aftermath: "[Effect] disperses, secondary character [reaction]"

---

## Style Transfer Principles

When animating from a user-supplied anime frame, preserve the source material's visual
style through the generation.

### Identifying and locking the source style

Before building the prompt, identify the source frame's style anchors:

1. **Line weight** — Heavy/thin/variable ink lines, or lineless digital
2. **Shading model** — Hard cel shadows, soft gradients, or flat colors
3. **Color palette** — Warm/cool dominant, saturation level, accent colors
4. **Genre aesthetic** — Shonen bold, seinen muted, magical-girl pastel, etc.
5. **Special features** — Screen tone, speed lines baked into art, halftone, sparkles

### Style-lock keywords for prompts

- `"Preserve cel-shaded 2D anime character style; shadows are solid color blocks"`
- `"Maintain thick black ink outlines throughout motion; no feathered edges"`
- `"Keep digital flat color palette; no gradient interpolation in character colors"`
- `"Preserve manga screen tone patterns in shaded areas"`
- `"Maintain exaggerated anime proportions (large eyes, defined hair spikes)"`
- `"Retain warm/cool palette contrast: [warm] characters against [cool] environment"`

### Avoid style drift

These prompt phrases prevent style contamination:
- `"Do not add photorealism; maintain cel-shaded anime aesthetic"`
- `"Character design must remain 2D anime style; no 3D rendering"`
- `"Preserve the source frame's color temperature and saturation"`

---

## Camera Techniques

### Dramatic zoom / dolly
Camera rapidly zooms in on a face or detail, stopping just before a reaction. Combine with
speed lines to enhance sensation of motion. **Prompt:** "Camera zooms in on [target] over
[X] s at [speed]. Speed lines enhance motion. Stops at [framing]."

### Rotating / spinning shot
Camera orbits around character or object 180° or 360°. Used during power-up moments or
to establish grand settings. **Prompt:** "Camera rotates [degrees] around [subject] over
[X] s. [Color] aura/effects visible throughout rotation."

### Dutch angle (tilted frame)
Frame tilted 15–30° from horizontal. Indicates psychological disturbance, danger, or
comedic confusion. **Prompt:** "Frame tilted [degrees] from horizontal. [Character/subject]
at center. Indicates [disturbance/danger/comedy]."

### Parallax pan
Camera moves across scene while background layers move at different speeds. Creates
cinematic depth. **Prompt:** "Camera pans [direction]. Foreground moves at [speed],
background at slower [speed]. Depth illusion throughout pan."

### First-person / POV attack
Camera at character's eye level simulating their perspective during an action. Immersive.
**Prompt:** "POV from [character's] perspective during [attack/motion]. Speed lines rush
forward. Impact point fills frame at peak."

### Whip pan
Rapid lateral camera movement that briefly blurs the frame, then stops on new subject.
**Prompt:** "Whip pan from [subject A] to [subject B] over [X] s. Frame blurs at midpoint.
Stops sharply on [subject B]."

---

## Lighting and Color Theory

### Dramatic rim lighting
Place key light behind or to extreme side of character. Creates bright outline, separates
character from background. **Rim color vocabulary:**
- Golden rim: heroic, warm, triumphant
- Cyan/blue rim: cold, mysterious, ominous
- Purple rim: magical, supernatural, royal
- White rim: holy, pure, transcendent

### Golden hour / warm palette
All colors shift toward warm (yellows, oranges, reds). Nostalgia, peace, romance.
Common in slice-of-life and ending sequences.

### Blue hour / cool palette
Scene lit as if in twilight (deep blue). Melancholy, mystery, introspection. Shadows are
deep blue, not black.

### High-contrast shonen lighting
Bright key light with sharp shadows. Limited fill. High color saturation. Bold graphic look.
Standard for action anime.

### Color saturation levels

| Level | Saturation | Use case |
|-------|------------|----------|
| Hyper-saturated | 120–150% | Action, magical moments, energy |
| Standard | 100% | Neutral anime scenes |
| Desaturated | 60–80% | Serious, dark, melancholic |
| Heavily desaturated | 30–50% | Horror, tragedy, despair |

---

## Genre Visual Identity Guide

### Shonen action
**Visual:** Explosive, high-energy, bold. Speed lines, power-ups, exaggerated expressions
(anger veins, shock). Dynamic camera: zoom-ins on impact, rotating shots in combat.
Saturation 130%+. Primary colors (reds, golds, blues).

### Seinen drama
**Visual:** Darker, introspective. Long static shots. Minimal speed lines. Strong rim
lighting and heavy shadows. Desaturated, cool tones. Dutch angles for psychological tension.

### Magical girl
**Visual:** Whimsical, pastel + bright accents, symmetrical framing. Transformation
animations (twirls, light flashes). Sparkle effects. Soft focus backgrounds. Warm diffuse
lighting.

### Mecha
**Visual:** Metallic, industrial, imposing. Reflections on mecha surfaces. Rigid geometric
movement. Neon accent lights (cyan, magenta). Dramatic rim on metallic surfaces. Steel grays
+ bright neons against dark backgrounds.

### Isekai / fantasy
**Visual:** Expansive, magical. Vibrant saturated palette. Magical effects (glowing runes,
spell circles). God rays and volumetric light. Wide establishing shots.

### Cyberpunk / sci-fi
**Visual:** Dark backgrounds, neon accents (cyan, magenta, yellow). Holographic effects,
digital glitches. Sleek geometric character designs. Neon reflected in wet ground surfaces.

---

## Anime-Specific Visual Effects Library

### Motion and energy

| Effect | Description | Prompt phrasing |
|--------|-------------|-----------------|
| Speed lines | Sharp lines from vanishing point indicating direction | "Speed lines radiate from [origin], [density] coverage" |
| Impact frames | Frozen moment with bright cross highlight | "Impact frame holds [X] s, cross-shaped highlight at [point]" |
| Smear frames | Extreme-speed motion as stretched/distorted image | "Smear frame during [motion], lasts [X] frames" |
| Pulsing glow | Expanding/contracting colored light | "Aura pulses with [X]-s rhythm; [color] at [intensity]" |
| Aura emission | Colored energy radiating from character | "[Color] aura expands from character in [layer count] rings" |

### Impact and emotion

| Effect | Description | Prompt phrasing |
|--------|-------------|-----------------|
| White flash | Bright overlay at impact | "White flash covers [%] of frame, clears in [X] s" |
| Screen shake | Frame vibrates during impacts | "Screen shake [magnitude]mm for [X] s during impact" |
| Cross highlight | Bright cross at impact center | "Bright cross-shaped highlight at impact, [X] s duration" |
| Dramatic shadow drop | Character silhouette darkens | "Shadows deepen dramatically, character silhouette darkens" |

### Particle and environmental

| Effect | Description | Prompt phrasing |
|--------|-------------|-----------------|
| Sakura petals | Semi-translucent petals on wind | "Sakura petals drift across frame, [color], catching [light] light" |
| Spark burst | Hot sparks from impact or mechanical object | "White/yellow sparks burst from [origin], fade in [X] s" |
| Dust cloud | Particles around motion or impact | "Tan/gray dust cloud swirls around [location], rises and disperses" |
| Stylized flames | Bold anime flames (not realistic) | "Stylized anime flames in [color]; speed lines within flame" |

### Character reactions

| Effect | Indication | Prompt phrasing |
|--------|------------|-----------------|
| Chibi pop | Comedic exaggeration | "Character pops to chibi proportions with [expression] at [timestamp]" |
| Sweat drop | Nervousness / comedy | "Glossy sweat drop appears at [location], falls slowly" |
| Anger veins | Anger / frustration | "Thick anger veins appear on [location] in purple/dark red" |
| Sparkle eyes | Excitement / special emotion | "Star-shaped or cross-shaped highlights fill eyes indicating [emotion]" |

---

## Character Design Keywords

| Element | Standard anime description |
|---------|--------------------------|
| Eyes | Large (1/3 face width); multiple highlights; non-realistic iris color |
| Eye types | Tsurime (outer corner high — sharp/confident); tarame (outer corner low — innocent/kind) |
| Hair | Gravity-defying; individually defined strands; bright highlight streaks |
| Mouth | Small (1/10 face); simple line or small shape |
| Proportions | Oversized head (1/3 body height in action designs); exaggerated limb thinness |
| Clothing | Tactical gear (action), sailor uniform (school), kimono (ceremonial), harem pants (fantasy) |

---

## Common Mistakes and Fixes

| Mistake | Fix |
|---------|-----|
| "Anime = big eyes only" | Anime is holistic: also specify hair design, speed lines, color saturation, rim lighting, limited animation pacing |
| Confusing anime with cartoon | Remove "cartoon"; specify "anime style" with distinct visual grammar (cel-shading, dramatic lighting, color psychology) |
| Describing internal states | Describe visual equivalents: "shoulders slumped, single tear forming, eyebrows tilted inward" |
| Forgetting limited animation philosophy | Specify "key frames with speed lines filling gap (smear frame effect)" rather than "smooth motion" |
| Uniform saturation | Specify per-scene saturation: 140% for action, 70% for dramatic/sad, 80% for slice-of-life |
| Mixing genre aesthetics | Commit to one genre visual per scene; shonen speed lines clash with seinen static compositions |
| Weak hook in first 2 s | Use explicit hook from hooks.md; describe position, timing, colors, effects precisely |
