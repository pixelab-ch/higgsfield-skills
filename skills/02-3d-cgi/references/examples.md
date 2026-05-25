# 3D CGI Prompt Examples

Master template plus five production-quality worked example prompts covering the
major CGI sub-genres.

---

## Table of Contents

1. [Prompt Construction Master Template](#prompt-construction-master-template)
2. [Example 1: Pixar Character Reveal](#example-1-pixar-character-reveal)
3. [Example 2: Photorealistic Luxury Product Reveal](#example-2-photorealistic-luxury-product-reveal)
4. [Example 3: Isometric Sci-Fi City Walkthrough](#example-3-isometric-sci-fi-city-walkthrough)
5. [Example 4: Surreal Creature Transformation](#example-4-surreal-creature-transformation)
6. [Example 5: Architectural Flythrough with Material Showcase](#example-5-architectural-flythrough-with-material-showcase)
7. [Common Mistakes and Fixes](#common-mistakes-and-fixes)
8. [Pre-Submission Checklists](#pre-submission-checklists)

---

## Prompt Construction Master Template

Use this structure for maximum clarity and impact:

```
[OPENING HOOK - 1–2 sentences establishing immediate visual intrigue]

Camera: [Camera movement, angle, lens type, DOF, frame rate]

Render Style: [Pixar-style / photorealistic / low-poly / cel-shaded / etc.] 3D rendering

Lighting: [Key light direction and color], [Fill light], [Backlight/rim],
          [Environment/HDRI], [Special effects like caustics or volumetric light]

Subject/Environment: [Detailed description of what's in frame — geometry, scale, arrangement]

Materials & Surfaces: [Specific material descriptions with PBR/SSS/refraction details]

Motion/Animation: [How things move — procedurally, physically, artistically; speed; duration]

Details & Refinement: [Texture detail level, imperfections, wear, dust, weathering]

Atmospheric & VFX: [Particles, fog, volumetrics, reflections, refractions, special effects]

Color Palette: [Primary colors, saturation, mood]

Duration: [Total length in seconds — use seedance_2_0's 4–15 s range]

Composition: [Rule of thirds, symmetry, depth arrangement, focus layers]
```

---

## Example 1: Pixar Character Reveal

**Hook technique used:** Object Materializing from Particles

```
OPENING HOOK: A crystalline cube slowly materializes from swirling golden particles,
rotating to reveal a character trapped inside.

Camera: Slow orbital rotation (45°/sec) around floating cube, maintaining mid-distance.
Easing motion with smooth interpolation. 24fps cinematic.

Render Style: Pixar-style 3D with warm, saturated color palette and soft shading
throughout.

Lighting: Golden-hour HDRI with warm key light from upper-left (3200K), cool blue fill
from right side creating subtle shadow gradation. Rim light from back creating luminous
character separation. Volumetric god rays through particles.

Subject: Anthropomorphic fox character, large expressive eyes, warm orange fur with
white chest markings. Standing upright, slight confident posture. Character is translucent
initially, solidifying as particles coalesce around form.

Materials: Soft fur with subsurface scattering in backlighting, especially ears. Fabric
clothing (blue vest) with natural wrinkles and textile weave. Eyes: glossy with sharp
specular highlights, warm amber iris color.

Animation: Character materializes over 2 seconds (particle coalescing), then blinks and
looks directly at camera, slight confident smile.

Particle Effects: Golden particles swirl around character, coalescing onto form. Particle
trails linger slightly before settling. Glow intensity peaks during materialization.

Color Palette: Warm golds, oranges, soft pastels. Background cool gradient (pale blue to
lavender). Character warm and saturated against cool background.

Duration: 5 seconds total.

Composition: Character centered, cube floating slightly above centerline. Depth layers:
background HDRI (mountains/sunset), mid-ground cube, close foreground particle sparkles.

Atmosphere: Joyful, welcoming, magical.
```

---

## Example 2: Photorealistic Luxury Product Reveal

**Hook technique used:** Depth Shift with Depth of Field

```
OPENING HOOK: A single water droplet suspended on a polished surface catches light and
refracts a product hidden in the background.

Camera: Push-in dolly from 2 meters away, moving toward product over 4 seconds. Shallow
depth of field begins blurred, focuses on product at 2-second mark. Chromatic aberration
subtle on edges. 24fps cinematic.

Render Style: Photorealistic 3D render, indistinguishable from professional product
photography.

Lighting: Hybrid warm+cool: warm key light (3100K) from upper-left creating golden
reflection, cool blue fill from right (7500K) reflecting off metal edge. Rim light crisp
and warm, creating halo on curved surfaces. HDRI environment lighting from professional
studio shoot. No harsh shadows — soft penumbra throughout.

Subject: Luxury wristwatch with rose-gold case and black dial. Water droplet balanced on
polished bezel. Watch rests on white frosted-glass platform.

Materials: Rose gold (18k): mirror-polished finish with warm color temperature, perfect
specular reflections of environment. Watch face: pure black with diamond-hard sapphire
crystal, sharp Fresnel reflections on crystal. Leather strap: rich cognac brown, visible
grain, soft tactile quality, subtle subsurface scattering.

Motion: Watch itself motionless. Water droplet refracts and rolls slightly across polished
surface as camera pushes in.

Details: Every surface polished to perfection. Sapphire crown shows microscopic scratches
catching light. Dial shows hour indices with warm metallic glow.

Color Palette: Warm rose-golds, cool silvers, black dial, cognac leather. Background pure
white or light gray.

Duration: 4 seconds.

Composition: Water droplet off-center initially, watch off-screen, revealed as camera
pushes in. Strong rule-of-thirds framing on final reveal.
```

---

## Example 3: Isometric Sci-Fi City Walkthrough

**Hook technique used:** Revealing Through Transparency (wireframe to full material)

```
OPENING HOOK: An isometric view of a sprawling futuristic city materializes from a
blueprint wireframe, gaining color and detail layer-by-layer.

Camera: Fixed 45-degree isometric angle. Camera motion: slow tracking downward and
forward through city, maintaining isometric perspective throughout. 30fps.

Render Style: Isometric 3D with crisp geometric forms, hyperdetailed photorealistic
textures and materials. Perfect geometric accuracy.

Lighting: Dual-sun system (cyan sun from upper-left, warm sun from upper-right). Cyan
light creates cool shadows, warm light creates warm highlights. Shadows cast at 45-degree
angle matching isometric perspective. Global illumination with color bleeding between
surfaces. Volumetric atmosphere creating depth haze.

Subject: Sprawling futuristic cityscape with: skyscrapers with curved glass facades,
flying vehicles (hovercars, drones), bridge structures, terraced gardens with vegetation,
water features (rivers, fountains), pedestrian plazas, advertisement holograms.

Materials: Glass buildings show refraction and Fresnel reflections. Metallic structural
elements (steel, aluminum) with brushed surfaces. Vegetation lush and detailed. Water
with realistic caustics and ripple dynamics. Glowing neon signs.

Animation: City initially wireframe (cyan lines on black). Color floods in, revealing
glass (transparent), metal (reflective), vegetation (green). Flying vehicles trace paths
through sky. Water features ripple gently.

Color Palette: Cyberpunk aesthetic: bright magentas, cyan blues, yellow accents.
Buildings cool teals and blues. Night-time color grading.

Duration: 6 seconds.

Composition: City fills entire frame from all angles. Foreground detail sharp, background
slightly hazed. Multiple focus points (vehicles, buildings, plazas).
```

---

## Example 4: Surreal Creature Transformation

**Hook technique used:** Revealing Through Transparency + Transformative Morph Sequence

```
OPENING HOOK: A humanoid silhouette begins to crystallize, first becoming transparent,
then shattering into geometric fragments that reassemble into an alien insectoid form.

Camera: Slow orbit around transformation, 30° per second. Camera pulls back slightly as
creature expands, maintaining creature centered. Depth of field shifts to reveal
environmental context at sequence end. 24fps.

Render Style: Photorealistic with surreal geometry. Creature hyperdetailed, impossible
forms rendered with scientific precision.

Lighting: Cool primary light from upper-left (8000K), warm fill from lower-right (3000K)
creating dramatic color contrast. Rim light: bright cyan from back. Creature's exoskeleton
emits faint bioluminescence (violet glow). HDRI environment: dark blue hour twilight.

Subject: Initial form: translucent humanoid, showing internal crystalline structure.
Midway: fractures appear, fragments begin separating. Final form: insectoid creature with
chitinous exoskeleton, faceted compound eyes (reflecting light beautifully), segmented
body, articulated limbs, translucent wings.

Materials: Initial: transparent crystal with internal fractures and refractive surfaces.
Final: chitinous exoskeleton (hard, reflective, with visible segmentation), compound eye
(faceted, iridescent, reflective), wings (translucent with chitinous veins).

Animation Sequence:
- 0–1.5s: Humanoid silhouette becomes transparent, internal crystalline structure visible
- 1.5–3.5s: Fractures spread, fragments slowly separate in zero-gravity motion
- 3.5–5.5s: Fragments reassemble into insectoid form, snapping together precisely

Color Palette: Cool cyans, violets, deep blacks (environment). Creature: dark iridescent
purple-black with violet bioluminescence.

Duration: 6 seconds.
```

---

## Example 5: Architectural Flythrough with Material Showcase

**Hook technique used:** Dramatic Camera Fly-Through

```
OPENING HOOK: Camera glides through an immense atrium where light refracts through the
glass ceiling in fractal patterns, slowly revealing a breathtaking interior architecture.

Camera: Continuous smooth tracking motion through interior architecture. Path: enters
through soaring atrium, glides past multiple surfaces, descends through spiral staircase,
emerges into open plaza. Speed: slow and meditative. Slight upward tilt at sequence end.
24fps.

Render Style: Photorealistic architectural visualization. Every material photoaccurate.

Lighting: Primary: massive skylight pouring warm golden light into atrium (3100K).
Secondary: cool reflected light from blue sky. Caustics from glass ceiling refracting
on all interior surfaces beneath. Global illumination: light bounces between surfaces.
Volumetric god rays through dust in atrium space.

Subject: Modern luxury architecture featuring: glass-roofed atrium, natural stone walls
(cream limestone), blonde oak wooden flooring (wide-plank, polished), steel structural
elements (brushed stainless), water feature (reflecting pool), organic curved walls,
terraced seating levels, extensive vegetation.

Materials:
- Glass ceiling: crystal clear, sharp Fresnel, perfect refraction showing sky/clouds
- Limestone: warm cream tone, aged surface, perfect polish
- Oak wood: visible grain patterns, warm honey color, specular sheen
- Steel: brushed finish, directional micro-scratches, cold silver tone
- Water: crystal clear with strong Fresnel reflections, caustics on pool floor

Animation: Camera motion smooth and continuous. Water surface ripples gently. Vegetation
sways imperceptibly. Light caustics animate slowly, dancing across surfaces.

Color Palette: Warm golds and creams (stone, wood, light). Cool silvers and blues
(shadows, sky reflection). Vegetation green providing natural accent.

Duration: 8 seconds.

Quality emphasis: This sequence should look indistinguishable from actual architectural
photography. Every detail professional-grade. No computational artifacts.
```

---

## Common Mistakes and Fixes

| Mistake | Fix | Why |
|---------|-----|-----|
| "Dynamic camera movement" | "Slow orbital rotation at 45°/sec, 3-second duration, ease-in/ease-out" | "Dynamic" is subjective |
| "Every atom visible" | "Hyperdetailed material showing grain, wear, natural variations down to microscopic texture level" | Atomic rendering is impossible |
| "Bright shadows" | "Deep shadows from single key light, fill light maintaining 2:1 contrast ratio" | Shadows are absence of light |
| "Black velvet with mirror reflections" | "Deep black velvet nap with diffuse light scattering (zero specularity) and subtle SSS glow in thin-edge areas" | Velvet is diffuse by definition |
| "Cool particles flowing everywhere" | "Thousands of cyan glowing particles following spline path, gradually fading over 1 second. Spacing: 5cm between particles" | Vague = unpredictable results |
| "Camera slowly orbits product" | "Camera orbits product at 45°/sec for 3 seconds, completing 135° rotation" | "Slowly" is relative |
| "Render at infinite resolution" | "Hyperdetailed textures visible at close camera distance, progressive LOD applied to distant objects" | Infinite resolution is impossible |

---

## Pre-Submission Checklists

### General Checklist
- [ ] Hook established in opening sentence?
- [ ] Camera movement specified (type, speed, distance, duration)?
- [ ] Render style chosen?
- [ ] Key light direction specified?
- [ ] Fill light described or noted as absent?
- [ ] Material descriptions use technical language (SSS, PBR, Fresnel, etc.)?
- [ ] Duration specified in seconds (within 4–15 s for seedance_2_0)?
- [ ] No contradictions (e.g., "mirror-finish matte metal")?
- [ ] Color palette described with specific colors?
- [ ] Depth of field / focus strategy described?

### Material Property Checklist
- [ ] Specularity level? (zero/diffuse, soft/satin, sharp/mirror)
- [ ] Surface finish? (smooth, textured, weathered, worn)
- [ ] Subsurface scattering needed? (skin, wax, marble, fabric)
- [ ] Refraction/transparency? (clear, frosted, colored)
- [ ] Color variation present? (uniform or varied tone)
