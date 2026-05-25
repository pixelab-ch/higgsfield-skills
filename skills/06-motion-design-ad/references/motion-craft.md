# Motion Design Ad — Motion Craft Reference

## Table of Contents

1. [Visual Style Library](#visual-style-library)
2. [Visual Hierarchy in Motion](#visual-hierarchy-in-motion)
3. [Typography as Motion Element](#typography-as-motion-element)
4. [Device Showcase Techniques](#device-showcase-techniques)
5. [Transition Library](#transition-library)
6. [Sound Design Principles](#sound-design-principles)
7. [Platform Optimisation Quick Rules](#platform-optimisation-quick-rules)
8. [Common Mistakes and Fixes](#common-mistakes-and-fixes)

---

## Visual Style Library

### 1. Dark Premium
Background deep navy or true black; text bright white or light gray; accent single
bold colour (metallic gold, electric blue, vibrant teal). Vibe: luxury SaaS,
enterprise, high-end tools. Prompt note: add subtle particle effects for depth.

### 2. Clean Minimal
Background pure white or very light gray; text charcoal or true black; accents soft
muted brand colour. Vibe: productivity apps, wellness tech, healthcare. Let
whitespace dominate; motion feels spacious.

### 3. Abstract Data
Background dark-to-medium gradient; floating numbers, graphs, network nodes, waves;
accents neon cyan, magenta, or electric green. Vibe: analytics, AI, big data,
fintech. Use particle systems and data visualisation heavily.

### 4. Isometric Tech
Perspective 3D isometric throughout; bold saturated blues, purples, oranges; clean
geometric feel. Vibe: dev tools, infrastructure, complex systems. Consistent
isometric camera angles; smooth zoom/pan only.

### 5. Gradient Brand
Background dynamic gradient between two brand colours; text white with shadow; tints
of brand colours for accents. Vibe: startups, lifestyle apps, trendy products.
Animate gradient shifts for a living feel.

### 6. Neon Cyber
Very dark or deep-purple background; glowing lines, text, or shapes in bright cyan,
pink, or green. Vibe: gaming, crypto, music, edge-forward brands. Use glow bloom;
brief glitch elements add credibility.

### 7. Glassmorphism
Soft-focus or blurred colour background; frosted glass effect on floating
cards/panels; high-contrast text over glass. Vibe: modern Apple-inspired elegant
SaaS. Layer subtle animations; soft motion feels premium.

### 8. Neumorphism
Soft single-colour background (light gray or soft blue); subtle embossed/extruded
button and panel styles; inset shadows. Vibe: accessibility-focused, gentle,
professional. Smooth subtle motion; avoid sharp transitions.

### 9. Bold Geometric
Circles, triangles, rectangles in bold arrangement; high saturation complementary
colour pairs; contrasting solid or two-colour split background. Vibe: creative
tools, design software, artistic products. Geometric elements transform/morph during
transitions.

### 10. Tech Noir
Dark background with high contrast; strong lighting and deep shadows; single bright
colour cutting through darkness. Vibe: security, cybersecurity, serious enterprise.
Use light beams and dramatic shadows.

### 11. Soft and Welcoming
Warm gradients (peachy, cream, light coral); dark charcoal or deep brown text; warm
secondary accent colours (coral, orange, warm gold). Vibe: consumer apps, social,
community. Motion feels organic and flowing.

### 12. Futuristic Minimalist
Medium gray or soft dark background; sparse clean geometric elements; bright single
accent (cyan or lime); thin elegant purposeful lines. Vibe: cutting-edge, sleek
products. Motion is precise and mathematical; no wasted movement.

---

## Visual Hierarchy in Motion

**Lead with benefit:** The first visual must communicate "what problem does this
solve?" — immediately.

**Device as hero:** Phones, laptops, tablets dominate the frame. They are familiar
anchor points.

**UI is the star:** Show actual interface features. Animate complexity beautifully
rather than hiding it.

**Clean negative space:** Tech ads need breathing room. Avoid cluttered backgrounds.

**Brand colour discipline:** Use 1–2 brand colours per 3-second segment maximum.
Accent colour guides the eye through transitions.

---

## Typography as Motion Element

| Entrance type | Duration | Easing | Best for |
|---|---|---|---|
| Fade in | 0.4–0.8 s | ease-in-out | Subtle, professional, any context |
| Slide in | 0.5–1 s | power ease-out | Headlines, CTAs, emphasis |
| Scale (growth) | 0.6–1 s | elastic or power ease-out | Key messages, excitement |
| Typewriter | 0.05 s/char | — | Code snippets, longer text |
| Rotate in | 0.7–1.2 s | power ease-out | Playful brands, secondary text |

**Styling rules:**
- Sans-serif dominance (Inter, Montserrat, Futura); serif signals less tech
- Bold headers (700–900 weight) with regular body (400–500)
- Headline: 48–72 pt; subtext: 18–24 pt; CTA animates in at final 1–2 s
- Keep text in safe margins: 15–20 px from edges (20–30 px on mobile)
- WCAG AAA minimum contrast: 4.5:1 for body, 3:1 for large text

---

## Device Showcase Techniques

**Device Float-In** — device slides from off-screen with subtle float/bob; smooth
ease-in-out, slight rotation on entry (0.8–1.2 s). Classic, effective for any UI
product.

**Screen Zoom** — start on one UI element, pull back to reveal full interface;
animated camera pull-back with sharp zoom curve (1–2 s). Best for detailed features.

**Multi-Device Carousel** — devices stack or slide past in sequence, each showing
a different feature; staggered timing (3–5 s total). Best for multi-platform products.

**Feature Highlight and Circle** — feature appears; glowing circle or arrow
highlights it; text callout animates in; circle pulses (1.5–2 s per feature).

**Before/After Split** — left shows old/broken state, right shows new/fixed state;
vertical or horizontal wipe transition (2–3 s). Best for problem-solution narratives.

**Data Flow Visualisation** — animated lines, arrows, or particles show data moving
through the system; physics-based with directional arrows (3–4 s). Best for backend
or API products.

**Hand Interaction** — animated hand taps, swipes, or gestures on floating device;
hand movement matches interface response (2–3 s). Best for mobile and touch apps.

**Isometric Device Rotation** — device in 3D isometric perspective; camera orbits
or device rotates; consistent isometric angle (2–4 s). Best for design-forward apps.

**Metric Counter Climb** — numbers animate from 0 to target with easing; sound
effect synced at peak (1.5–2 s). Best for demonstrating scale or ROI.

**Grid Layout Reveal** — multiple screens or cards on a grid; each fades or slides
in with staggered timing (3–5 s). Best for multi-feature products.

**Morphing UI Elements** — buttons transform into other UI elements; smooth bezier
morph, elements deform gradually (1.5–2.5 s per morph). Best for interaction-heavy
products.

**Particle Explosion** — interface element explodes into particles; physics-based
spread with gravity or wind (0.8–1.5 s). Best for announcements or key moments.

**Light Beam Scan** — bright animated light beam sweeps across dark interface;
linear or curved scan path; glow bloom effect (2–3 s). Best for feature discovery.

**Icon Animation Sequence** — key icons appear one-by-one with entrance animations;
staggered playful entrances with eased curves (0.5–1 s per icon). Best for feature
lists.

**Screen Slice Reveal** — new screen slides in from side; smooth eased movement
with slight parallax on overlays (1.5–2 s per slide). Best for app flows.

---

## Transition Library

| Transition | Duration | Best for |
|---|---|---|
| Morph | 0.6–1.2 s | Sequential scenes, feature-to-feature |
| Zoom in/out | 0.8–1.5 s | Focus shifts, scale changes |
| Glitch | 0.3–0.6 s | Problem-solution, tech-forward brands (max 1–2 per ad) |
| Data Dissolve | 1–1.5 s | Data/analytics products, interconnected concepts |
| Wipe | 0.5–1 s | Sequential steps, app flows |
| Fade/Cross-dissolve | 0.4–0.8 s | Thematic shifts, mood changes |
| Cut with sound | Instantaneous | Fast-paced ads, beat-driven energy peaks |
| Parallax Zoom | 1.5–2.5 s | Layered information, premium products |

---

## Sound Design Principles

**Entrance sounds** (–15 to –10 dB): chime (ascending), whoosh (0.2 s before
visual entry), chords (professional entrance). Sync within 50 ms of visual.

**UI interaction sounds** (–18 to –12 dB): click (tap/button, 0.1 s), slide
(whoosh with pitch), pop (element appears, 0.15 s), bubble (playful vibe).

**Transition sounds** (–12 to –8 dB): morph tone, glitch sound (0.1–0.2 s),
laser sweep, bass swell.

**Data and metric sounds**: counter beeps (rapid clicks during counting), ping
(data point lands), shimmer (particle emphasis), bass drop at major moment
(–6 dB for impact).

**Music tempo:** 120–140 BPM for energetic tech ads. Align cuts to beat for maximum
impact. Total mix peak: –3 dB.

**Frequency discipline:** EQ to keep CTA audio clear; support with sub-bass; never
let sounds muddy each other.

---

## Platform Optimisation Quick Rules

| Platform | Aspect | Duration | Pacing notes |
|---|---|---|---|
| TikTok | `9:16` | 15–60 s | Very fast; hook at 0.5 s; trending audio |
| Instagram Reels | `9:16` | 15–30 s | Fast hook; captions essential; brand logo early |
| YouTube pre-roll | `16:9` | 15–20 s | First 3 s critical; sound design essential |
| YouTube mid-roll | `16:9` | 30–60 s | Can go deeper into features |
| LinkedIn | `16:9` or `1:1` | 20–30 s | Slower pacing; statistics and ROI |
| Twitter / X | `16:9` or `1:1` | 15–45 s | Captions critical; text-heavy approach works |
| Facebook / Meta | `1:1` | 15–30 s | Captions essential; slower motion can outperform |

---

## Common Mistakes and Fixes

**Too much text:** Max 7–8 words per text element; max 3 lines on screen at once;
give each line 1–2 s minimum; stagger timing.

**Ignoring the 2-second hook:** Start with motion and colour that demands attention;
first visual hints at the product benefit; avoid slow fades as openers.

**Device too small:** Device should fill 40–60 % of frame; ensure UI elements are
legible; test on mobile if targeting mobile audience.

**Mismatched colour palette:** Stick to 1 primary + 1–2 accents + 1 background;
ensure 4.5:1 contrast for text; test across screens.

**Motion without purpose:** Every animation communicates something — entrance,
transition, emphasis, or interaction. Ask: "Does this help the viewer understand the
product?" If not, remove it.

**Sound absent or conflicting:** Include audio for every major motion moment; use a
consistent sound palette; keep music at –10 dB minimum when overlaying UI sounds;
always include captions.

**Pacing mismatch:** B2B: 1.5–2 s beats; B2C: 0.8–1.5 s beats; align cuts to music
tempo; change something every 1–1.5 s.

**No clear CTA:** Final 3–5 s dedicated to CTA; CTA text large and visible; use
high-contrast colours; animate CTA (pulse, glow, or scale).
