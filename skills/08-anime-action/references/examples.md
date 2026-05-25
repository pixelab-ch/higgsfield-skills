# Anime-Action Prompt Examples

Worked prompts for anime-action generation using the mandatory image-upload flow.
All examples assume the source anime frame has been uploaded and confirmed via
`higgsfield:media_upload` → `higgsfield:media_confirm` before the generate call.

---

## Table of Contents

1. [Master Template](#master-template)
2. [Example 1: Shonen Fight Climax](#example-1-shonen-fight-climax)
3. [Example 2: Magical Girl Transformation](#example-2-magical-girl-transformation)
4. [Example 3: Slice-of-Life Morning Scene](#example-3-slice-of-life-morning-scene)
5. [Example 4: Mecha Battle Spectacle](#example-4-mecha-battle-spectacle)
6. [Example 5: Emotional Farewell (Romance / Drama)](#example-5-emotional-farewell-romance--drama)
7. [Platform and Duration Quick Reference](#platform-and-duration-quick-reference)

---

## Master Template

Use this structure as the baseline for all anime-style video prompts:

```
[VISUAL STYLE]
Anime genre: [shonen/seinen/magical girl/mecha/etc.]
Art style: cel-shaded 2D anime. Limited animation with key impact frames.
Color palette: [description and saturation level]

[OPENING 2 SECONDS]
Hook: [technique from hooks.md]
[describe exact visual: position, timing, colors, effects]

[MAIN SCENE — SECONDS 2–N]
Setting: [location, time of day, atmosphere]
Character action: [what is happening]
Animation style: [movement type: fast/slow, impact frames, limited animation details]
Lighting: [key light direction, mood lighting, special effects]
Color: [primary palette, accent colors, saturation %]

[SPECIAL EFFECTS]
Particle effects: [speed lines, sparks, energy, sakura, etc.]
Transitions: [cuts, fades, swipes]

[PARAMETERS]
Model: wan2_7 (primary) or wan2_6 (fallback)
Duration: [2–15 s for wan2_7; 5, 10, or 15 s for wan2_6]
Aspect ratio: [16:9, 9:16, 1:1, 4:3, or 3:4 for wan2_7; 16:9, 9:16, or 1:1 for wan2_6]
Resolution: [720p or 1080p]
input_files: [{ "id": "<confirmed_id>", "role": "start_image" }]  // wan2_7
             [{ "id": "<confirmed_id>", "role": "image" }]        // wan2_6 fallback
```

---

## Example 1: Shonen Fight Climax

**Source frame:** Male anime character in power stance with electric blue aura active.

```
[VISUAL STYLE]
Anime genre: Shonen action (climactic fight moment)
Art style: Cel-shaded 2D anime. Limited animation with key impact frames.
Color palette: Deep blues, electric cyan, black shadows, white highlights. Saturation: 140%.

[OPENING 2 SECONDS — HOOK]
Hook: Dramatic Eye Close-Up with Power-Up Aura Explosion
Extreme close-up of character's eye. Iris golden-amber with four-pointed star-shaped
highlight. As the eye fills frame, electric blue aura radiates outward from behind the head,
visible at frame edge. Aura pulses outward in two expanding rings with sparks trailing.
Speed lines (perspective lines from behind) zoom past character's face. At 0.1 s, pupil
contracts sharply. Camera pulls back revealing character's face by 1.5 s.

Art style: Cel-shaded 2D anime on slightly abstracted blue-electric background.
Lighting: Rim light from electric aura (bright blue on edges of face). Shadows dark navy.

[MAIN SCENE — SECONDS 2–8]
Setting: Open valley at golden-hour sunset. Orange sky fills 70% of frame. Rocky ground,
sparse grass. Two combatants face each other at opposite frame edges. Deep blue ground
shadows. Volumetric light rays in dust-filled air.

Character A (protagonist, left): Power stance — legs planted, fists clenched. Electric blue
aura in 1-meter radius. Static hold, only aura and hair moving with 0.3-s pulse rhythm.

Character B (opponent, right): Neutral stance watching. Partially backlit, appears as near-
silhouette.

Animation style: Limited animation at 12fps internal rate for aura pulsing (2-frame). Aura
expands and retracts on 0.3-s cycle. Hair and clothing flutter with aura pressure.

At 5 s: Character A launches forward at extreme speed — two key frames with speed lines
filling gap (smear frame effect). Character B braces — eyes widening, static hold 0.2 s.

At 6 s: Impact. White flash covers center 60% of frame. Cross-shaped highlight at fist-
contact point holds 0.2 s. Character B blown backward, speed lines trail behind.

Lighting: Golden rim on Character A from sun. Character B backlit. Impact flash bright white.

[SPECIAL EFFECTS]
- Aura: 4–5 concentric rings expanding and retracting, electric sparks drift upward
- Speed lines: Radial from launch point during movement
- Impact flash: White light covers frame center, clears at 0.3 s
- Impact cross: Bright white cross at fist contact
- Dust: Tan particles swirl around character A's feet
- Screen tone: 0.2-s diagonal pattern overlay at power moment

[PARAMETERS]
Model: wan2_7
Duration: 8 s
Aspect ratio: 16:9
Resolution: 1080p
input_files: [{ "id": "<confirmed_id>", "role": "start_image" }]
```

---

## Example 2: Magical Girl Transformation

**Source frame:** Magical girl character in school uniform, mid-transformation glow.

```
[VISUAL STYLE]
Anime genre: Magical girl (mahou shoujo)
Art style: Cel-shaded 2D. Whimsical, pastel palette with bright accents. Symmetrical.
Color palette: Pastel pink and gold dominant, bright cyan accents. Saturation: 110%.

[OPENING 2 SECONDS — HOOK]
Hook: Transformation Sequence Flash
White light flash obscures full frame at 0 s (0.3 s duration, disorienting). Flash clears
to reveal character in mid-transformation — outline of new magical outfit forming in light.
Golden sparkles cascade from transformation boundary.

[MAIN SCENE — SECONDS 2–10]
Setting: Abstract background — gradient from deep rose to pale gold. Circular geometric
patterns (magical array) glow softly beneath character's feet.

Character: Female protagonist in transformation sequence. Clothing shifts from school
uniform to magical costume. Twirl animation: character spins 360° over 1.5 s. During spin,
clothing dissolves in golden light and reforms as costume. Hair lengthens and changes color
in the light.

Animation style: Transformation twirl at 24fps (smooth for magical effect). Light effects
at 12fps internal (shimmer rhythm). Final pose locks into perfect symmetrical frame.

Lighting: Diffuse warm golden hour from above. Sparkles emit their own light (small bright
points). No harsh shadows — all shadows are soft pink-gold.

[SPECIAL EFFECTS]
- Sparkle cascade: Star-shaped golden sparkles rain down throughout transformation
- Magical array: Glowing circular rune pattern on ground, pulsing with twirl
- Light ribbons: Golden light ribbons trail behind spinning motion
- Final flash: Small white flash at transformation completion, clears in 0.2 s
- Sparkle eyes: Cross-shaped highlights in character's eyes during completion close-up

[PARAMETERS]
Model: wan2_7
Duration: 10 s
Aspect ratio: 9:16
Resolution: 1080p
input_files: [{ "id": "<confirmed_id>", "role": "start_image" }]
```

---

## Example 3: Slice-of-Life Morning Scene

**Source frame:** Female anime character lying on futon, eyes closed, morning sunlight.

```
[VISUAL STYLE]
Anime genre: Slice-of-life (nichijou / daily life)
Art style: Cel-shaded 2D, soft and warm. Minimal speed lines. Soft focus backgrounds.
Color palette: Golden sunlight dominant, warm cream interior, peachy skin tones. Saturation: 75%.

[OPENING 2 SECONDS — HOOK]
Hook: Cherry Blossom Wind Gust
Close-up of pink/white cherry blossoms drifting across frame. Semi-translucent petals on
gentle wind. Behind petals: blurred golden window frame with warm sunlight streaming through.
Petals drift left to right, then right to left (leisurely, not urgent). Camera slowly pulls
back at 0.8 s.

[MAIN SCENE — SECONDS 2–6]
Setting: Japanese-style bedroom. Futon on tatami mat. Morning sunlight through shoji screen
at right. Soft shadow grid on futon. Wooden details, paper lantern in background. Warm golden
hour dominates.

Character: Female protagonist waking on futon, lying on side, eyes closed, peaceful. Eyes
open slowly over 0.4 s (heavy, sleepy). Arm stretches lazily above head over 0.6 s.

Animation style: Minimal animation. Character static for 0.8 s, then slow eye-open, then
gentle arm stretch. Naturalistic movement, not exaggerated. 24fps smooth.

Lighting: Warm sunlight from shoji door, illuminates right side of face. Left side in soft
golden-brown shadow. Skin warm peachy tone.

[SPECIAL EFFECTS]
- Dust motes: Fine particles visible in sunlight beam, drifting slowly
- Soft shadow grid: Grid pattern from shoji projected on futon, very soft-edged
- Hair highlight: Single bright line on hair showing glossy texture
- Breathing: Subtle chest rise-and-fall visible during sleep portion

[PARAMETERS]
Model: wan2_7
Duration: 6 s
Aspect ratio: 16:9
Resolution: 720p
input_files: [{ "id": "<confirmed_id>", "role": "start_image" }]
```

---

## Example 4: Mecha Battle Spectacle

**Source frame:** Giant mecha silhouette against storm clouds, cyan power core glowing.

```
[VISUAL STYLE]
Anime genre: Mecha (giant robot combat)
Art style: Cel-shaded 2D with metallic surface details. Rigid, geometric movement.
Color palette: Deep purple-gray sky, dark building silhouettes, bright cyan neon, dark red
accents. Saturation: 110% (neon pops against dark).

[OPENING 2 SECONDS — HOOK]
Hook: Power-Up Aura Explosion
Mecha silhouette against dark storm clouds. Bright cyan power core in mecha's chest glows
and expands — energy radiates outward in concentric rings, air distorts around it. Speed
lines radiate outward at 0.3 s. Cuts to cockpit interior at 1.5 s: pilot's face lit by
cyan glow, expression determined.

Lighting: External — mecha rim-lit by its own power core (bright cyan). Storm clouds deep
purple-gray behind. Cockpit — neon cyan + warm amber dual light sources.

[MAIN SCENE — SECONDS 2–10]
Setting: Dystopian city battlefield at dusk. Cyberpunk-industrial buildings, neon signs,
rain falling. Two mecha face each other. Cracked, scorched ground. Neon reflected in wet
surfaces.

Mecha 1 (protagonist, left): Sleek, angular, black and cyan. Core pulses with 0.4-s rhythm.
Raises arm slowly over 0.8 s (realistic hydraulic speed, not instant). Rigid segmented
articulation with distinct angular movements.

Mecha 2 (antagonist, right): Bulky, industrial, dark gray and red. Combat-ready stance.

At 5 s: Mecha 1 launches. Two key frames with speed lines filling gap. Rain streaks stretch
behind mecha. Screen shake 2mm for 0.5 s during footfall.

At 7 s: Impact. White flash covers 70% of frame center. Cross-shaped highlight at impact
point. Energy explosion between mecha pushing both backward.

Lighting: Neon light from multiple angles. Core glow illuminates own surfaces. Rain catches
light as visible streaks.

[SPECIAL EFFECTS]
- Core pulsing: Cyan glow expands from core every 0.4 s
- Rain: Visible streaks in front and behind mecha, catching light
- Speed lines: Dense radial lines behind Mecha 1 during launch
- Neon reflections: Cyan and red light reflects in wet ground
- Impact flash: White covers frame center, clears at 0.3 s
- Screen shake: 2mm continuous vibration during footfall

[PARAMETERS]
Model: wan2_7
Duration: 10 s
Aspect ratio: 16:9
Resolution: 1080p
input_files: [{ "id": "<confirmed_id>", "role": "start_image" }]
```

---

## Example 5: Emotional Farewell (Romance / Drama)

**Source frame:** Two anime characters at train platform at dusk, facing each other.

```
[VISUAL STYLE]
Anime genre: Romance / drama (emotional farewell)
Art style: Cel-shaded 2D. Soft, minimal speed lines. Detailed expressions.
Color palette: Deep blue shadows, cool purple-blue tones, pink blossoms accent. Saturation: 70%.

[OPENING 2 SECONDS — HOOK]
Hook: Cherry Blossom Wind with Blue Hour Lighting
Soft focus close-up of pink cherry blossoms drifting across frame on gentle wind. Blossoms
semi-translucent, catching cool blue-hour light. Behind blossoms: blurred silhouettes of
two characters at distance, facing away from camera. Depth of field: petals sharp, characters
heavily blurred. Camera slowly pulls back at 1.5 s over 1 s.

[MAIN SCENE — SECONDS 2–12]
Setting: Empty train platform at evening/dusk. Station building in background (blurred). Over-
head lamp glows warm yellow but scene dominated by cool blue sky. Steel platform, minimal
people. Two characters 2 meters apart.

Character 1 (male, tall): Stoic expression, mouth slightly downturned, eyes slightly down.
Dark jacket. Hands at sides, posture slightly slumped.

Character 2 (female, smaller): Sad expression, large soft eyes. Long hair. Light-colored
jacket. Arms crossed, protective posture.

Animation style: Minimal animation. Both largely static. At 3 s, Character 1's hand rises
slowly to grasp his own arm (1.5 s duration). At 4 s, Character 2's gaze shifts — eyes up,
then down (2 s).

At 5 s: Character 2's tear forms at inner eye corner over 0.5 s (glossy, reflecting light),
begins falling over 0.4 s. Character 1's expression softens very subtly (eyebrows relax,
slight tilt down) over 0.8 s.

At 8 s: Both reach hands toward each other — arms extend over 1.0 s. At 9 s, both reach
peak extension. Hold 0.3 s with hands near but not touching. Both retract slowly over 0.4 s.

At 10 s: Characters separate, Character 2 turns toward arriving train. Character 1 watches.

Lighting: Cool blue hour dominant throughout. Characters rim-lit with blue. Arriving train
light adds subtle warm counterpoint at 10 s.

[SPECIAL EFFECTS]
- Cherry blossoms: Continuous drift throughout, some petals pass between characters' hands
- Platform reflection: Characters partially reflected in glossy surface (50% opacity, blurred)
- Tear: Single tear, glossy, small cyan-white highlight on cheek
- Screen tone: 0.1-s diagonal pattern flash at 8.8 s (manga-style emotional emphasis)
- Train light: Distant light grows at 10 s

[PARAMETERS]
Model: wan2_7
Duration: 12 s
Aspect ratio: 16:9
Resolution: 1080p
input_files: [{ "id": "<confirmed_id>", "role": "start_image" }]
```

---

## Platform and Duration Quick Reference

### wan2_7 (primary)

| Platform | Aspect ratio | Recommended duration |
|----------|-------------|----------------------|
| TikTok / Reels / Shorts | `9:16` | 5–8 s |
| YouTube (standard) | `16:9` | 8–15 s |
| Instagram feed | `1:1` | 5–10 s |
| Portrait / manga | `3:4` | 4–10 s |

**wan2_7 duration is a continuous range: 2–15 s.** Any whole value is valid.

### wan2_6 (fallback — informed consent required)

| Platform | Aspect ratio | Recommended duration |
|----------|-------------|----------------------|
| TikTok / Reels / Shorts | `9:16` | `5` s |
| YouTube (standard) | `16:9` | `10` or `15` s |
| Instagram feed | `1:1` | `5` or `10` s |

**wan2_6 duration is a discrete set: `[5, 10, 15]` — no other values are valid.**
When using wan2_6, attach the anime frame as role `image` (not `start_image`).
