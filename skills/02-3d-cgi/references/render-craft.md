# 3D CGI Render Craft Reference

Creative language for render styles, materials, lighting setups, and camera movement
for 3D CGI and computer-generated video prompts.

---

## Table of Contents

1. [Render Styles](#render-styles)
2. [Material Science and Surface Properties](#material-science-and-surface-properties)
3. [Lighting Setup Language](#lighting-setup-language)
4. [Camera Movement for CG](#camera-movement-for-cg)
5. [Style Spectrum Guide](#style-spectrum-guide)
6. [Particle and Effects Language](#particle-and-effects-language)

---

## Render Styles

Choose 1–2 primary styles per prompt.

| Style | Prompt Terms | Best For |
|-------|-------------|----------|
| **Pixar/Stylized** | "Pixar-style 3D render," "Disney animation aesthetic," "smooth cartoon shading," "warm saturated colors" | Character animation, family content, whimsical environments |
| **Photorealistic** | "Photorealistic 3D render," "physically accurate rendering," "hyper-detailed," "near-photographic realism" | Products, architecture, creatures, cinematic |
| **Low-Poly** | "Low-poly 3D model," "geometric faceted style," "minimalist polygonal form," "flat-shaded 3D" | Stylized games, minimalist art, data visualization |
| **Claymation/Plasticine** | "Claymation aesthetic," "plasticine texture," "stop-motion 3D," "handmade tactile quality" | Stop-motion inspired, playful content |
| **Isometric 3D** | "Isometric 3D view," "45-degree perspective," "isometric architectural render" | UX, games, explainers |
| **Cel-Shaded** | "Cel-shaded rendering," "comic book aesthetic," "bold outlines," "graphic novel style" | Action, comics, stylized gaming |
| **Voxel** | "Voxel-based 3D," "cubic blocky style," "8-bit inspired 3D" | Games, nostalgic content, data visualization |
| **Wireframe** | "Wireframe 3D," "neon wireframe aesthetic," "technical blueprint style" | Technology, HUDs, educational content |
| **Hybrid/Mixed Media** | "Photorealistic product in stylized environment," "mixed-media aesthetic," "hybrid 3D approach" | Product showcases, brand videos, conceptual |

---

## Material Science and Surface Properties

### Metals

**Polished Chrome/Mirror Steel**
"Perfectly polished mirror-finish stainless steel with sharp, clean specular highlights
and zero distortion. Near-perfect Fresnel reflections showing environment clearly.
Minimal orange-peel texture. Cold metallic color temperature (slight blue cast)."

**Brushed Aluminum**
"Brushed aluminum with directional micro-scratches running horizontally. Soft, diffuse
specular reflection. Warm silver tone with natural anodize variation. Barely visible
grain direction. Zero warping in reflections."

**Oxidized Copper/Patina**
"Aged copper with thick verdigris (green) patina overlay. Deep orange-red base visible
in recesses. Rough, unpolished surface with no specular highlights."

**Gold (High-Karat)**
"Precious 24k gold with warm, saturated yellow tone. Mirror-polished finish with sharp,
warm-tinted highlights. Extremely reflective, minimal diffuse component."

### Organic and Natural

**Human Skin (High-Detail)**
"Highly detailed human skin with visible pores, slight redness in cheeks and ears.
Warm peachy-pink base. Subsurface scattering visible in thin-skin areas (ears, lips,
nostrils, eye-whites). Natural variation: freckles, minor blemishes, vein visibility."

**Fresh Green Leaf**
"Chlorophyll-rich green with backlighting creating translucent glow. Strong subsurface
scattering in backlit areas: light penetrates leaf, glowing amber-green. Dewdrops
with refraction."

**Dense Fur**
"Dense fur with individual strand-level detail. Base coat with lighter guard hairs
creating sheen. Subsurface scattering deep in fur, especially at tips. Natural
directional flow from growth pattern."

### Glass and Transparency

**Crystal Clear Glass (High-Refraction)**
"Perfectly transparent, colorless glass. Sharp Fresnel reflections on edges. Strong
refraction distorting environment visible through glass. Chromatic aberration at
edges from dispersion. Interior reflections visible."

**Frosted Glass**
"Translucent frosted glass with diffuse light transmission. No clear refraction —
environment blurred behind glass. Soft specular glow rather than sharp highlight."

**Colored Glass (Emerald Green)**
"Translucent emerald-green glass with warm golden highlights. Strong Fresnel
reflections tinted green. Refraction visible but colored — environment tinted green."

### Fabrics

**Velvet (Deep Black)**
"Soft velvet nap creating near-zero specularity. Deep black with velvety texture —
light scatters diffusely. Zero harsh highlights. Subsurface scattering in thin-edge
areas creates faint glow."

**Silk (White/Ivory)**
"Lustrous silk with smooth, reflective surface. Sharp specular highlights tinted
slightly warm. Excellent specularity with soft falloff creating sheen. Natural sheen
variation following fabric direction."

### Advanced/Complex

**Water (Shallow Ocean)**
"Crystal-clear water with strong Fresnel reflections from sky above. Sandy bottom
visible through water with caustics dancing. Surface shows gentle wave animation.
Slight green tint. Realistic wave crest foam."

**Marble (White with Gray Veins)**
"Polished white marble with gray veining. Subtle subsurface scattering throughout —
light penetrates slightly, glowing warm in bright areas. Polished surface with soft
specularity. Veins follow natural fracture patterns."

**Bioluminescent Surface**
"Soft self-luminous glow (emissive property, not reflection). Glow color: violet,
cyan, or warm amber. Surface has organic texture underneath. Glow intensity varies
across surface (hotspots brighter). Glow illuminates nearby surfaces with colored light."

---

## Lighting Setup Language

### 15+ Production Lighting Configurations

**Golden Hour HDRI (Warm, Cinematic)**
Key: Warm diffuse light from 45° upper-left (3200K). Fill: Soft blue bounce from right.
Environment: HDRI photograph from sunset shoot. Result: Warm sunlit appearance with
golden tones and rich shadows. Best for: Outdoor products, nature, character portraits.

**Studio Neutral 3-Point (Professional, Controlled)**
Key: Soft diffuse main light from 45° (5600K neutral). Fill: Lower-intensity soft fill
opposite side. Back: Crisp rim light at upper-rear. Result: Professional, flattering,
balanced. Best for: Product shots, character reveals, corporate content.

**Single Dramatic Side-Light (Moody, Cinematic)**
Key: Single strong light source from extreme side (80°), creating strong side shadows.
Fill: Minimal or none. Result: Film-noir mood, high contrast, psychological. Best for:
Drama, horror, suspense, cinematic scenes.

**Volumetric God Rays (Atmospheric, Transcendent)**
Key: Strong directional light creating god rays. Atmosphere: Heavy volumetric fog or
dust scattering light into beams. Result: Dramatic light shafts, heavenly atmosphere.
Best for: Sci-fi reveals, magical moments, architectural drama.

**Caustics Underwater (Refraction, Ethereal)**
Key: Warm top-light simulating sun penetrating water. Caustics: Dynamic caustic pattern
dancing on surfaces below. Fill: Blue reflected light from water. Result: Underwater
dreamy aesthetic. Best for: Underwater scenes, mystical moments, luxury beauty shots.

**Neon Practical Lights (Cyberpunk, Color-Graded)**
Key: Bright neon light (magenta, cyan, yellow) from practical in-scene source.
Fill: Secondary neon from opposite direction. Environment: Dark cityscape HDRI.
Result: Neon-soaked, cyberpunk mood. Best for: Sci-fi, tech, high-concept advertising.

**Warm and Cool Contrast (Color Grading Drama)**
Key: Warm orange light (3000K) from left. Fill: Cool blue light (8000K) from right.
Result: High color contrast, cinematic color-grading feel. Best for: Advertising, moody
fashion, artistic shots.

**Rim-Light Dominant (Separation, Drama)**
Key: Minimal key light. Rim: Extremely bright backlight, creating luminous outline.
Result: Subject glows against background. Best for: Dramatic character introductions,
magical moments, product revealment.

**Candlelight and Practical Glow (Intimate, Warm)**
Key: Warm practical candlelight (2000K, orange) from low angle. Fill: Warm bounce
from nearby surface. Environment: Dark interior HDRI. Result: Intimate, warm, cozy.
Best for: Emotional character moments, intimate product shots, luxury goods.

---

## Camera Movement for CG

### Smooth Motion Types

| Move | Description | Prompt Phrase |
|------|-------------|---------------|
| **Slow Orbital Rotation** | 360° rotate around subject, 45°/sec | "Slow orbital rotation around subject at 45°/sec, perfectly smooth" |
| **Ascending Crane Shot** | Move upward and backward, revealing scale | "Gradual crane shot ascending, smooth parabolic arc revealing environment" |
| **Push-In / Dolly Forward** | Camera moves toward subject | "Dolly-in movement building intimacy, DOF shifts from wide to shallow" |
| **Tracking Lateral** | Camera slides left or right | "Tracking shot sliding left to right, smooth and predictable" |
| **Spiral Ascent** | Orbit while simultaneously moving upward | "Corkscrew motion, orbit and ascend simultaneously" |
| **Glide-Through** | Move through physical space (tunnel, corridor) | "Camera glides through crystalline tunnel, environment flowing past" |
| **Shallow Dolly Zoom** | Dolly forward while focal length decreases | "Dolly zoom creating dizzying perspective distortion" |
| **Static with Internal Motion** | Camera locked, animation evolves in frame | "Camera locked in place, particle transformation evolves within frame" |
| **Focus-Shift Dolly** | Position static, focus shifts foreground/background | "Rack focus from foreground particle to vast interior architecture behind" |

**Pro tip:** All motion should include easing curves. Never use linear motion unless
specifically stylized. Specify total duration so motion pacing can be calculated.

---

## Style Spectrum Guide

### Hyper-Stylized → Photorealistic

**Ultra-Stylized Cartoon 3D** — Exaggerated proportions, bright colors, toon shading,
zero photorealism. Terms: "Bright primary colors," "comic book shading," "thick bold
outlines," "rubber-hose animation style."

**Stylized with Soft Shading (Pixar-range)** — More realistic proportions but soft,
painterly shading. Terms: "Soft shading," "warm color palette," "golden-hour mood,"
"watercolor-like surface quality."

**Painterly/Illustrative 3D** — Surfaces appear hand-painted or illustrated. Terms:
"Hand-painted 3D aesthetic," "visible brush strokes," "watercolor finish."

**Stylized Realism (SFX Hybrid)** — Realistic proportions and lighting but with
exaggerated material properties or surreal environments. Terms: "Realistic proportions
with surreal colors," "photorealistic lighting on stylized forms."

**Cel-Shaded with Depth** — Comic book aesthetic but with sophisticated lighting.
Terms: "Cel-shaded with rim lighting," "graphic novel quality," "bold outlines with
specular highlights."

**Cinematic Hyperreal (High-Poly)** — Complex geometries, mega-polygon counts,
real-time ray tracing, insane detail. Terms: "Cinematic hyperrealism," "subdivision
surface detail," "real-time ray tracing quality."

**Photorealistic (Digital Photography)** — Indistinguishable from photographed reality.
Terms: "Photorealistic 3D render indistinguishable from photography," "every lens
imperfection simulated," "perfect chromatic aberration and lens artifacts."

---

## Particle and Effects Language

### 12+ Particle Systems with Exact Prompt Language

**Dust Motes in Light Shafts**
"Millions of dust particles suspended in volumetric god rays, scattering light.
Particles catch light, glowing. Slight settling motion — gravity pulling particles
downward. Vary particle size from microscopic to visible. Color: golden-orange."

**Swirling Smoke**
"Dense volumetric smoke curling and swirling. Color transition: warm gray at base,
thinning to transparent at top. Lighting: interior smoke illuminated by light source,
creating caustic patterns."

**Particle Materialization (Coalescing Swarm)**
"Thousands of small particles (cyan) swirling in tight formation, gradually coalescing
into a recognizable form. Particles maintain individual identity — avoid smooth morphing.
Glow: particles emit soft cyan light."

**Magical Sparks and Glitter**
"Small spark particles — bright, high-specularity points of light. Color: gold, white,
or rainbow-gradient. Physics: particles emit from central source, arcing outward with
gravity, settling and fading."

**Water Splashing and Droplets**
"Water splashing from impact, creating sheet of liquid mid-air. Physics accuracy: each
droplet has weight and trajectory. Transparency: water shows refraction of background.
Caustics: dynamic refraction patterns visible in water volume."

**Fire and Embers**
"Volumetric fire with realistic color gradient (blue base, yellow middle, orange-red
top). Embers: glowing orange particles separating from flame, rising with heat-buoyancy.
Flame turbulence: organic rolling motion, never repetitive looping."

**Bioluminescent Particle Trail**
"Glowing particles trailing behind moving object. Color: phosphorescent cyan, violet,
or warm amber. Particles spawn along motion path, glowing, then fading. Glow: particles
emit soft light onto environment."

**Fog/Haze Layer**
"Volumetric fog creating depth and atmosphere. Color: slightly cool (blue-gray) or warm
(amber) depending on light source. Animation: gentle undulating motion suggesting air
currents. Density increases with distance."
