# Fashion Lookbook Prompt Examples

Master template and worked prompts for fashion lookbook video generation via
`cinematic_studio_video_v2` (primary) and `seedance_2_0` (fallback), plus lookbook
stills via `soul_cinematic`.

---

## Table of Contents

1. [Master Template](#master-template)
2. [Example 1: Luxury Collection Campaign (16:9, 12 s)](#example-1-luxury-collection-campaign)
3. [Example 2: Streetwear Lookbook (9:16, 10 s)](#example-2-streetwear-lookbook)
4. [Example 3: Editorial Fashion Film — Minimalist Luxury (16:9, 12 s)](#example-3-editorial-fashion-film--minimalist-luxury)
5. [Example 4: Sustainable Fashion Story (16:9, 10 s)](#example-4-sustainable-fashion-story)
6. [Example 5: Accessories Showcase — Luxury Details (16:9, 10 s)](#example-5-accessories-showcase--luxury-details)
7. [Still-Image Lookbook Example (soul_cinematic)](#still-image-lookbook-example-soul_cinematic)

---

## Master Template

Use this structure to craft every fashion video prompt:

```
MODEL: cinematic_studio_video_v2 (or seedance_2_0 if fallback applies)
ASPECT RATIO: [9:16 / 16:9 / 1:1 / 3:4]
DURATION: [3–12 s for cinematic_studio_video_v2; up to 15 s for seedance_2_0]
GENRE: [intimate / spectacle / action / auto — cinematic_studio_video_v2 only]

[2-SECOND HOOK]
Opening 0–2 s: [Specific hook type] — [What appears on screen]

[OUTFIT DESCRIPTION]
Garment: [Piece name, color, fabric, fit details]
Styling: [Accessories, shoes, hair, makeup, overall vibe]
Fit details: [Silhouette, drape, key visual features]

[MODEL DIRECTION]
Walk/Pose: [Confident strut / slow sway / playful spin / etc.]
Attitude: [Confidence / sensuality / approachability / edge / playfulness / etc.]
Expression: [Subtle smile / strong gaze / blank slate / contemplative / etc.]

[ENVIRONMENT & LIGHTING]
Location: [Studio / street / nature / interior / rooftop / etc.]
Lighting: [Golden hour / studio flash / neon / dramatic / natural / etc.]
Background: [Color, texture, relevance to outfit]

[MOTION SEQUENCE]
0–2 s: [Hook action]
2–5 s: [Primary movement — walk, sway, transition]
5–8 s: [Secondary movement — detail reveal, spin, gesture]
8–12 s: [Finale — confident pose, exit, or surprise element]

[SPECIAL EFFECTS & TRANSITIONS]
Camera movement: [Tracking / zoom / pan / static / orbital / etc.]
Transitions: [Cut / fade / spin / reveal / etc.]
Effects: [Wind / slow-motion / color shift / etc.]
```

---

## Example 1: Luxury Collection Campaign

**Model:** `cinematic_studio_video_v2`
**Aspect ratio:** `16:9`
**Duration:** `12` s
**Genre:** `spectacle`

**2-SECOND HOOK:**
Opening (0–2 s): Dramatic silhouette of model against backlit white curtain. Curtain pulls
away slowly, revealing model in full haute couture gown. Silhouette is emphasized first;
details follow as light levels rise.

**OUTFIT:**
Floor-length haute couture gown. Deep emerald silk with intricate beading across bodice and
shoulder. Asymmetrical neckline on right side. Flowing skirt with graduated silk layers
creating volume and movement. Train extends behind. Underside of sleeves: subtle gold silk.

**STYLING:** Hair in sleek low bun. Minimal jewelry — gold cuff bracelet only. Neutral
polished makeup emphasizing eyes. Nude heels elongating silhouette.

**MODEL DIRECTION:** Slow, deliberate catwalk-style walk toward camera, then slow 270° rotation
to show train and side silhouette. Final pose stationary, hands relaxed at sides, slight head
tilt toward camera. Attitude: poise, grace, understated confidence. Expression: subtle lift
at mouth, eyes engaged and direct, regal composure.

**ENVIRONMENT:** Minimalist white studio, polished white floor, infinite backdrop. Subtle
architectural columns add dimension without distraction. Studio flash: key light from left at
45°, fill light softly from right, 10% backlighting creates rim light on gown edges.

**MOTION SEQUENCE:**
- 0–2 s: Curtain reveal hook; silhouette before color.
- 2–6 s: Catwalk walk toward camera; each step deliberate; gown moves with each step; train trails.
- 6–10 s: Slow 270° clockwise rotation; train sweeps floor; beading glints at each angle.
- 10–12 s: Static final pose; camera slowly pulls back widening frame; fade to white.

**CAMERA:** Initial zoom-out from curtain. Slow orbital during rotation. Gentle tracking as
model walks toward camera. Final slow pullback.

---

## Example 2: Streetwear Lookbook

**Model:** `cinematic_studio_video_v2`
**Aspect ratio:** `9:16`
**Duration:** `10` s
**Genre:** `action`

**2-SECOND HOOK:**
Opening (0–2 s): Extreme close-up of sneaker sole hitting pavement (macro shot). Quick cut
to model's legs walking toward camera at fast pace. Model's upper body enters frame by 1.5 s.
Attitude immediately evident.

**OUTFIT 1:**
Oversized charcoal gray hoodie with white logo print, slightly cropped. Fitted black track pants
with white stripe. White low-top canvas sneakers. Baseball cap in navy. Minimal gold chain.
Small black nylon crossbody bag.

**OUTFIT 2 (transition at 5 s):**
Oversized vintage band t-shirt in cream white tucked into high-waisted baggy light-wash jeans.
Tan oversized blazer thrown over shoulders. White chunky platform sneakers. Multiple silver chains.
Oval black-frame sunglasses pushed onto head.

**MODEL DIRECTION:** Fast, confident power walk toward camera. Quick turns between looks. Swagger
evident. Hands in pockets during segments. Expression: self-assured, slight attitude, approachable.
Subtle smirk. Direct eye contact during moments.

**ENVIRONMENT:** Urban street. Brick wall background (textured, aged). Concrete sidewalk. Graffiti
hint out of focus. Bright daylight, slightly overcast — soft shadows, even exposure, colors pop.

**MOTION SEQUENCE:**
- 0–2 s: Hook — sneaker macro; quick cut to full body approach.
- 2–5 s: Power walk, side angle as model walks past camera.
- 5–6 s: Spin transition to Outfit 2 (mid-spin flash cut).
- 6–9 s: Outfit 2 walk, direct toward camera; adjusts sunglasses; bigger attitude.
- 9–10 s: Stops close to camera; confident final pose; crosses arms or points.

**CAMERA:** Handheld, slight movement emphasizing realism and energy. Quick cuts and angles.
No fades; sharp cuts match music and attitude.

---

## Example 3: Editorial Fashion Film — Minimalist Luxury

**Model:** `cinematic_studio_video_v2`
**Aspect ratio:** `16:9`
**Duration:** `12` s
**Genre:** `intimate`

**2-SECOND HOOK:**
Opening (0–2 s): Extreme macro close-up of linen fabric weave — white on white, texture fills
entire frame. Camera slowly pulls back over 2 seconds, revealing fabric is part of an oversized
shirt. By 2 s, full silhouette visible against white backdrop.

**OUTFIT:**
Oversized linen button-up shirt in natural ivory white. Textured, clearly organic. Loose, relaxed
fit. Sleeves rolled to mid-forearm. Partially unbuttoned (top 3 buttons). Shirt drops to mid-thigh.
High-waisted linen trousers in warm cream. Relaxed straight-leg fit. Bare feet or minimal white canvas.

**STYLING:** Single long pendant necklace (silver, geometric). Hair loose, unstyled, parted naturally.
Minimal makeup. No visible accessories beyond necklace. Linen shows subtle texture and wrinkles.

**MODEL DIRECTION:** Slow, deliberate movements. Contemplative pace. No forced energy; meditative
and introspective. Gazes downward or off-camera. Expression: neutral, calm, pensive. Eyes soft,
often downward or away from camera.

**ENVIRONMENT:** Minimalist white studio, soft white floor, negative space dominant. Large window
light source (implied). No harsh shadows; everything gently illuminated. Key light creates subtle
dimension without drama. 10% backlighting on edges and hair.

**MOTION SEQUENCE:**
- 0–2 s: Macro fabric pull-back; shirt and silhouette emerge.
- 2–6 s: Model stands mostly still; slight sway; gentle wind on fabric; hand adjusts neckline.
- 6–9 s: Slow 180° turn; fabric flows and catches light; beautiful silhouette as model faces away.
- 9–12 s: Slow steps toward camera; deliberate, ~1 step per 2 s; stops in profile; hand lifts to face.

**CAMERA:** Smooth zoom-back at opening. Otherwise static. Final subtle fade to white.

---

## Example 4: Sustainable Fashion Story

**Model:** `cinematic_studio_video_v2`
**Aspect ratio:** `16:9`
**Duration:** `10` s
**Genre:** `intimate`

**2-SECOND HOOK:**
Opening (0–2 s): Close-up of artisan weaver's hands working a loom, creating the fabric. Camera
pulls back to reveal weaver in natural sunlit workshop. Cut to finished garment on model in garden.
Hook tells the source-to-wearer story.

**OUTFIT:**
Hand-woven linen dress in natural cream/off-white. A-line silhouette, reaches knee. Minimal seams,
clean construction. Organic cotton slip underneath (visible at neckline). Simple sustainable leather
belt in warm tan. Canvas shoes (undyed). Wooden bracelet.

**MODEL DIRECTION:** Natural, grounded walk. Hands touch fabric or reach toward natural elements.
No performance; authenticity and genuine connection to environment. Genuine warm smile or peaceful
expression. Eyes engaged with surroundings.

**ENVIRONMENT:** Lush garden or natural landscape. Green foliage, flowers, natural plants. Opening:
artisan workshop with warm natural light, looms, traditional craftsmanship visible. Natural golden-hour
daylight. No artificial light in garden sequences.

**MOTION SEQUENCE:**
- 0–2 s: Hook — weaver's hands at loom; pull back; cut to model in garden.
- 2–5 s: Model walks slowly through garden path; fabric flows.
- 5–8 s: Model pauses at flowers; hand touches linen then flower petal.
- 8–10 s: Model turns slowly; fabric catches light; camera pulls back wide.

---

## Example 5: Accessories Showcase — Luxury Details

**Model:** `cinematic_studio_video_v2`
**Aspect ratio:** `16:9`
**Duration:** `10` s
**Genre:** `intimate`

**2-SECOND HOOK:**
Opening (0–2 s): Extreme macro of cognac leather handbag — hand-stitched details visible, light
glints off perfect finish. Over-the-shoulder shot reveals model wearing full outfit. Pull back
reveals full model and accessories ensemble.

**OUTFIT:** Simple minimalist black (turtleneck, fitted trousers, pointed-toe heels). Outfit is
neutral backdrop for accessories.
**Accessories:** Cognac leather shoulder bag; black pointed-toe luxury heels; multi-layered gold
chains; gold rings and cuff; oversized black/gold sunglasses; thin cognac leather belt; cream silk scarf.

**MODEL DIRECTION:** Slow, deliberate movement emphasizing accessories. Catwalk pace. Frequent hand
movements highlighting accessories — adjusting necklaces, gesturing with ringed hands, touching bag,
tilting sunglasses. Sophisticated, confidence through accessories. Expression: cool, slight smile,
eyes occasionally hidden behind sunglasses.

**ENVIRONMENT:** Minimalist luxury setting (gallery or luxury hotel hallway). Studio flash or bright
directional light emphasizing shine of leather, hardware, jewelry. Neutral background (white or
light gray).

**MOTION SEQUENCE:**
- 0–2 s: Hook — macro bag leather; reveal model.
- 2–4 s: Model walks toward camera, low angle; heels prominent; shoe craftsmanship visible.
- 4–6 s: Detail cut — hands with rings adjusting bag; macro-zoom on jewelry.
- 6–8 s: Model slow rotation; heels, bag, jewelry all visible from multiple angles.
- 8–10 s: Static confident pose; camera pulls in slightly; final pose; brand name appears.

---

## Still-Image Lookbook Example (soul_cinematic)

Use `higgsfield:generate_image` with `soul_cinematic` for mood-board stills before committing
to video generation. The still can then serve as `start_image` for `cinematic_studio_video_v2`.

**Prompt example — editorial fashion still:**
```
Model in floor-length emerald silk gown, backlit against pure white studio backdrop.
Fabric billows at hem with implied wind. Golden-hour sidelighting creates warm rim light
on edges. Studio flash as key light from 45° left. Model faces slightly away; over-shoulder
glance toward camera. Expression: composed, editorial.
```

**Parameters:**
```
model: soul_cinematic
quality: 2k
aspect_ratio: 3:4  (portrait — magazine-style editorial)
soul_id: [optional — attach if maintaining character identity across stills]
```

**Workflow note:** After approving the still, pass the output image as `start_image` to
`cinematic_studio_video_v2` with genre `intimate` and duration `8`–`12` s to extend the
established composition into a video clip.
