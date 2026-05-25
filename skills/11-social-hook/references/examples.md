# Examples: Master Templates and Worked Hook Prompts

Production-ready prompt templates for generating viral social-hook videos. Each
example is obsessively optimized for the first 2 seconds.

---

## Table of Contents

1. [How to Use These Examples](#how-to-use-these-examples)
2. [Example 1: Satisfying Transformation Hook](#example-1-satisfying-transformation-hook)
3. [Example 2: Comedy Skit Hook](#example-2-comedy-skit-hook)
4. [Example 3: Product Reveal Hook](#example-3-product-reveal-hook)
5. [Example 4: Emotional Story Hook](#example-4-emotional-story-hook)
6. [Example 5: Impossible Visual Hook](#example-5-impossible-visual-hook)
7. [Output Structure Reference](#output-structure-reference)
8. [Prompt Construction Guide](#prompt-construction-guide)

---

## How to Use These Examples

Each example is a complete prompt template ready to adapt. To use:

1. Choose the example that matches your content category (transformation, comedy,
   product, story, visual).
2. Replace bracketed placeholders with your specific subject, product, or character.
3. Adjust duration and platform (9:16 for TikTok/Reels/Shorts; 16:9 for standard
   YouTube; 1:1 for square feed posts).
4. Present the assembled prompt to the user for review before any generation call.
5. Route to `kling3_0` (primary) or `grok_video` (fallback). See
   [../model-specs.md](model-specs.md) for routing rules and parameters.

---

## Example 1: Satisfying Transformation Hook

**Goal:** 30-second satisfying transformation optimized for TikTok, stopping the
infinite scroll.

**Prompt:**

"Create a 30-second satisfying transformation video for TikTok with a hook that stops
the infinite scroll.

HOOK STRUCTURE (First 2 seconds):

[0.0–0.3 s] Open on extreme close-up (macro lens) of GRIMY, STAINED SURFACE. Viewer
cannot recognize what surface is. Lighting is harsh, showing every crack, dirt particle,
stain. Sound: ASMR scratching sound (fingernail on dirt) with slight tension music
underneath.

[0.3–0.8 s] Zoom out slightly, but still magnified. Reveal surface is a
previously-white shoe (heavily stained, yellowed, disgusting). Pull back further to
show person holding the shoe. On-screen text appears at 0.5 s (large, bold, white
sans-serif): 'THIS IS DISGUSTING'. Sound: dramatic music sting, person groans with
disgust.

[0.8–1.5 s] Quick cut (0.1 s transition) to person dipping shoe brush into cleaning
solution. Macro shot of bristles entering soapy water. Bright blue-white soap. Sound:
dipping sound, bristle swish. On-screen text at 1.2 s: 'WATCH WHAT HAPPENS'. Music
builds slightly.

[1.5–2.0 s] Cut to person scrubbing the shoe in fast-motion (2x speed). Paint-like
transformation: brown/yellow disappearing, white appearing. Dramatic lighting catch on
the brightening shoe. Sound: intense scrubbing sound (ASMR satisfying), music
crescendos. At 1.8 s, reveal the shoe is now BRILLIANTLY WHITE. Cut to person's
shocked/delighted reaction. Viewer's brain registers the transformation and MUST keep
watching.

FULL VIDEO (Seconds 2–30):

[2–10 s] Continue scrubbing process, show multiple angles, close-ups of the whitening.
Camera pulls back incrementally showing progress. Multiple satisfying transformations of
different stained spots.

[10–15 s] Final rinse: water running over newly-white shoe, water turning brown then
clear. Slow-motion water droplets. Peak satisfaction moment. Soft music resolution.

[15–25 s] Before/side-by-side comparison. Original dirty shoe visible on one side,
fresh white shoe on other. Person proudly holds clean shoe.

[25–30 s] Final shot: person wearing the restored shoe, walking in clean environment
(beach, mall, park). Confidence visible. Ending text: 'SAVE THIS FOR LATER' or 'COMMENT
IF YOU NEED THIS'. Music resolves satisfyingly.

TECHNICAL SPECS:
- Format: 9:16 vertical
- Audio: Original ASMR cleaning sounds + music bed
- Music: Start at 0.3 s, build through 2 s, peak at 1.5 s
- Text: Two text overlays in first 2 seconds (as described)
- Transitions: Cross-dissolve or quick cut (0.1 s black frame)
- Pacing: Slow reveal 0–1 s, accelerate 1–2 s
- Color Grade: Warm tones for dirty shoe (satisfying contrast), cool/bright for clean
  shoe (transformation reward)"

**Platform:** TikTok, 9:16
**Model:** `kling3_0`, mode `std`, sound `on`

---

## Example 2: Comedy Skit Hook

**Goal:** 15-second comedy skit with maximum laugh in first 2 seconds.

**Prompt:**

"Create a 15-second comedy skit with hook optimized for maximum laugh in first 2
seconds. TikTok/Reels format.

HOOK STRUCTURE (First 2 seconds):

[0.0–0.2 s] Open on character in normal situation, indoors (kitchen, office, bedroom).
Camera is still, character seems calm. Lighting is neutral. No music yet. Sound:
ambient room tone (very quiet).

[0.2–0.6 s] Character speaks directly to camera: 'I just realized something...' or
'You know what's crazy?' Confused/thoughtful expression. Short pause (0.2 s silence).
Sound: minimal, maybe subtle comedic underscore building.

[0.6–1.2 s] Character delivers absurd statement with complete seriousness: 'I've been
putting my pants on wrong my entire life' or 'My cat is probably a spy' or 'I think
I'm a wizard but nobody noticed.' Character's delivery is deadpan, completely serious.
No laugh track yet. Sound: comedic underscore, maybe subtle 'ding' at absurd statement.

[1.2–2.0 s] Immediate cut to visual proof or demonstration of absurdity. Character
demonstrates the 'wrong' way (exaggerated, ridiculous). OR cut to character doing
something wizard-like (wand hand gestures, levitation attempt). The visual is obviously
absurd/silly. At 1.5 s, on-screen text appears: '[ABSURD CLAIM]' or 'WAIT...'
Character's reaction shows they are serious/confused why it is not working. Sound:
laugh track at 1.5 s, comedic sound effects matching the action.

FULL VIDEO (Seconds 2–15):

[2–5 s] Escalation: character tries again, fails in even more absurd way. Self-awareness
moment (character realizes the absurdity). Physical comedy: falling, losing balance,
exaggerated movements.

[5–10 s] Character asks camera for help: 'Can someone help me? Am I crazy?' or 'This
should be ILLEGAL.' Reaction from friend/family member (shocked, laughing, equally
confused). Their reaction validates the comedy.

[10–15 s] Final punchline/resolution: character proves their absurd claim is true in
completely unexpected way (something impressive happens, but delivered through the
absurd lens). OR: character gives up and walks away with exaggerated defeat. Text
overlay at end: 'COMMENT IF YOU'VE DONE THIS TOO' or 'SAVE THIS FOR YOUR [FRIEND]'.

TECHNICAL SPECS:
- Format: 9:16 vertical
- Camera: static or slow pan (not shaky)
- Lighting: bright, even (studio or natural window light)
- Audio: minimal underscore until 1.2 s, then comedic sounds
- Laugh track: use sparingly (0.3 s laugh at 1.5 s and 2.3 s maximum)
- Text: one main text at 1.5 s (the absurd claim or reaction)
- No special effects needed (comedy relies on character, not effects)
- Pacing: slow setup 0–1.2 s, then quick payoff 1.2–2 s"

**Platform:** TikTok / Instagram Reels, 9:16
**Model:** `kling3_0`, mode `std`, sound `on`

---

## Example 3: Product Reveal Hook

**Goal:** 20-second product reveal for Instagram Reels (aesthetic focus, product
discovery, conversion).

**Prompt:**

"Create a 20-second product reveal video with hook optimized for product discovery and
conversion. Instagram Reels format (aesthetic focus).

HOOK STRUCTURE (First 2 seconds):

[0.0–0.4 s] Open on relatable PROBLEM: person struggling with something, frustrated,
inconvenienced. Example: person carrying 10 shopping bags struggling up stairs, person
squinting at tiny text, person spilling coffee while driving. Show genuine inconvenience
(not exaggerated). Lighting: warm, relatable, home environment. Sound: frustrated sigh,
subtle tension music, or problem-related sound (door closing hard, computer lag noise).

[0.4–0.9 s] Cut to close-up of person's face: frustrated, seeking solution, or hopeless
expression. Maybe speech: 'There has to be a better way' or 'I'm so tired of this.'
On-screen text appears at 0.6 s: 'WAIT UNTIL YOU SEE THIS' or '[PROBLEM] SOLVED.'
Camera pulls back slowly. Sound: hopeful music cue (minor to major shift), anticipatory.

[0.9–1.5 s] Product appears: either in person's hand, being pulled into frame, or
suddenly visible. Product is shown clearly, aesthetically lit, beautiful presentation.
Reveal should feel like a 'yes, this is it' moment. Zoom slightly into product (0.1–0.2 s
animation). Sound: satisfying product reveal sound (ding, chime, or positive
affirmation), music swells.

[1.5–2.0 s] Immediate product benefit demonstrated: person uses product, problem is
solved instantly. Person's expression changes to relief, joy, amazement. At 1.7 s,
on-screen text: 'GAME CHANGER' or product name + key benefit. Sound: satisfied tone
('ahhhh'), positive music climax.

FULL VIDEO (Seconds 2–20):

[2–8 s] Extended demonstration: show product from multiple angles, show benefit in
action, show different use cases. Close-ups showing quality/detail. Person clearly
enjoying product. B-roll of product beauty (zoom on texture, material, branding).

[8–15 s] Secondary benefits emerge: product does MORE than solve original problem.
Additional features or advantages shown. Person's amazement grows. Text overlays
highlight benefits ('LIGHTWEIGHT', 'LASTS ALL DAY', 'FITS IN ANY BAG').

[15–20 s] Final reveal: price, where to buy, or call-to-action. Text with purchase
link or 'Tap to shop'. Closing shot: person confidently using product, satisfied, happy.
Final text: 'THANK ME LATER' or 'LINK IN BIO' or 'USE CODE [DISCOUNT]'.

TECHNICAL SPECS:
- Format: 9:16 vertical
- Aesthetic: cohesive color palette, high production quality
- Lighting: professional (ring light, natural window, or studio lights)
- Camera: smooth movements (gimbal, tripod, or very steady)
- Audio: uplifting music (no heavy bass, keep energy positive)
- Transitions: smooth dissolves, not jarring cuts
- Pacing: slow problem reveal, quick solution reveal"

**Platform:** Instagram Reels, 9:16
**Model:** `kling3_0`, mode `pro`, sound `on`

---

## Example 4: Emotional Story Hook

**Goal:** 60-second emotional story with deep connection built in first 2 seconds.

**Prompt:**

"Create a 60-second emotional story with hook that builds deep connection in first 2
seconds. TikTok format (high emotional resonance).

HOOK STRUCTURE (First 2 seconds):

[0.0–0.3 s] Open on establishing shot: quiet moment, familiar space (bedroom, kitchen,
park bench). Lighting is soft, slightly warm. Camera is still or moving very slowly.
Sound: ambient (birds, quiet traffic, household sound) with gentle instrumental
underscore underneath. Visual tone should feel intimate, personal, real.

[0.3–0.8 s] Close-up on person's face: thoughtful, sad, reflective, or tender
expression. Not smiling. Real emotion visible. Maybe slight tear, hand touching face,
or deep breath. On-screen text appears at 0.5 s: '[SETUP STATEMENT]' like 'When my
dog got sick...' or 'The day I found out...' or 'A year ago, I lost...' Statement
should be emotionally vulnerable. Sound: gentle music continues, voice-over begins
(soft, genuine tone, not dramatic).

[0.8–1.5 s] Voice-over begins or person speaks: 'I thought everything was going to
change' or 'I wasn't prepared for this' or 'I didn't know what to do.' Cut to B-roll
supporting the story. Lighting shifts slightly (maybe grayer, sadder tone). Sound:
voice-over is heartfelt, not over-acted. Background music swells slightly.

[1.5–2.0 s] Flash forward or reveal moment: hint at the resolution or what this story
is building to. At 1.8 s, on-screen text: 'THEN THIS HAPPENED' or 'BUT HERE'S WHAT I
LEARNED' or '[PERSON'S] STORY.' Brief reveal of the resolution hook (enough to intrigue,
not enough to spoil). Sound: music reaches emotional peak, maybe slight shift toward
hope (major chord, resolution cue).

FULL VIDEO (Seconds 2–60):

[2–15 s] Back to beginning: show the setup moment (the problem, the struggle, the loss).
Let viewer understand the stakes. Use emotional B-roll, close-ups of person processing
emotion. Voice-over explains situation, person's feelings, the impact.

[15–30 s] Crisis/Struggle: show how difficult the situation was. Person's attempts to
cope, support from others, dark moments. Montage of struggle. Emotional intensity
increases.

[30–45 s] Turning Point: introduce the moment things changed. Show the decision or
action that shifted perspective. Music begins to shift toward hope. Emotional climax
of the struggle section.

[45–60 s] Resolution and Wisdom: show the outcome. Person recovered, healed, grew,
learned, or found peace. Voice-over delivers the lesson. Music resolves into hopeful
tone. Final text: message for viewers in similar situations.

TECHNICAL SPECS:
- Format: 9:16 vertical
- Lighting: warm, soft, intimate (not harsh)
- Camera: slow, gentle movements (not jerky or fast-paced)
- Color grade: slightly desaturated initially, gradually becomes warmer as resolution
  approaches
- Audio: emotional music bed (not trending audio; original or licensed emotional piece),
  voice-over throughout
- Pacing: intentionally slow (not rushed; emotions need time)
- No special effects (authenticity is everything)"

**Platform:** TikTok, 9:16
**Model:** `kling3_0`, mode `std`, sound `on`

---

## Example 5: Impossible Visual Hook

**Goal:** 45-second "impossible" visual that makes viewers say "HOW IS THAT POSSIBLE?"

**Prompt:**

"Create a 45-second 'impossible' visual with hook that makes viewers say 'HOW IS THAT
POSSIBLE?' at the 2-second mark. All platforms format.

HOOK STRUCTURE (First 2 seconds):

[0.0–0.2 s] Open on seemingly normal scene: person, object, or space that appears
natural at first. Camera is steady or slow-moving. Lighting is natural-looking. Sound:
ambient (quiet background noise) with subtle tension music underneath.

[0.2–0.7 s] Introduce the ANOMALY: something appears that should not exist or be
possible. It is subtle at first. Example: person standing on ceiling in normal lighting,
object floating without support, animal doing impossible thing, person duplicated in
scene. At 0.5 s, on-screen text appears: 'WAIT...' or 'HOLD ON...' or 'LOOK CLOSER.'
Sound: music builds, slightly tense.

[0.7–1.5 s] MOMENT OF REALIZATION: camera angle shifts, cut changes, or zoom reveals
the impossibility. Viewer's brain says 'that is not physically possible.' Example:
camera pulls back showing the person is on ceiling and gravity is inverted, object
hovers in midair with no support. At 1.0 s, on-screen text: 'HOW???' or 'THIS ISN'T
REAL' or '[THING] IS IMPOSSIBLE.' Sound: dramatic music sting, whoosh effect, or
ascending tone marking the moment of impossibility reveal.

[1.5–2.0 s] EXPLANATION HINT: brief hint that there is an explanation or reveal coming.
Could be: camera pans to show green screen, person looks at camera with knowing smile,
text says 'HERE'S THE TRICK', or cut to behind-the-scenes showing how it is done.
Do not reveal the full trick yet — just hint that it is explainable. Sound: music
sustains tension, maybe slight comedic undertone. Viewer thinks: 'I HAVE to keep
watching to learn how they did this.'

FULL VIDEO (Seconds 2–45):

[2–10 s] Expand the impossibility: show the impossible thing from multiple angles,
prove it is consistent, escalate the impossibility. Build belief that it is somehow
real. Music continues tension.

[10–20 s] Full exposition: reveal the behind-the-scenes. Show the camera trick,
the special effects, or the practical effect. Use quick cuts showing before/after of
the effect. Split-screen showing the trick setup and the final result. Music lightens.

[20–30 s] Re-watch the original: play the hook again (0–2 s footage again) but now
viewer knows the trick. They are amazed at how seamless it was. Maybe slow-motion
playback. Music becomes satisfying. Text: 'CLEVER RIGHT?' or 'YOU FELL FOR IT' or
'THAT'S HOW THEY DID IT.'

[30–45 s] Escalation or Second Trick: creator tries an even MORE impossible thing, or
attempts to trick viewer again. Or: blooper reel showing failed attempts. Music becomes
playful. Final text: 'SAVE THIS TO TRY IT YOURSELF' or 'WHO ELSE WANTS TO TRY?'

TECHNICAL SPECS:
- Format: 9:16 vertical
- Camera: extremely steady (gimbal, tripod, or perfectly stable)
- Lighting: professional, even, bright (impossible effects need clear light)
- Audio: tension music → explanation music → playful music (arc)
- Transitions: quick cuts when explaining, slow shots when showing impossible effect
- Pacing: SLOW during impossible reveal (let it sink in), FAST during explanation"

**Platform:** TikTok / Instagram Reels / YouTube Shorts, 9:16
**Model:** `kling3_0`, mode `pro`, sound `on`

---

## Output Structure Reference

When generating hook content, the output should follow this structure:

1. **Hook Script** (detailed, scene-by-scene timing)
   - 0.0–0.3 s: [description]
   - 0.3–1.0 s: [description]
   - etc.

2. **Full Video Script** (how the hook expands into full video)
   - Seconds 2–10: [content]
   - Seconds 10–20: [content]
   - etc.

3. **Technical Specifications**
   - Format, aspect ratio, camera specs, lighting, audio

4. **Editing Checklist**
   - What to shoot, how to shoot it, post-production steps

5. **Caption Suggestion** (platform-specific)

6. **Hashtag Strategy** (algorithm + discovery + niche)

7. **Audio Recommendation** (trending vs. original)

8. **Performance Predictions**
   - Expected completion rate %
   - Expected CTR
   - Estimated viral potential

---

## Prompt Construction Guide

When building a hook prompt for `kling3_0` or `grok_video`:

**Specify your platform:** TikTok, Instagram Reels, or YouTube Shorts (affects
optimization — see [../platforms.md](platforms.md)).

**Specify your content category:** comedy, educational, satisfying, transformation,
etc. (see [../platforms.md](platforms.md) content playbook).

**Specify your niche/audience:** Who should find this interesting?

**Specify your goal:** maximum reach, build brand, drive conversion, community
engagement.

**Provide any constraints:** length, content restrictions, brand guidelines.

**Example prompt structure:**

"Create a [GOAL] hook video for [PLATFORM] optimized for [AUDIENCE]. Content
category: [CATEGORY]. Hook type: [HOOK PATTERN] (see [../hook-craft.md](hook-craft.md)).
Length: [LENGTH].

Specific requirements:
- [CONSTRAINT 1]
- [CONSTRAINT 2]
- [CONSTRAINT 3]

Use the hook framework from the Master Template in hook-craft.md. Optimize for
[METRIC: completion rate, CTR, shares, etc.].

Output format: detailed hook script with timing, technical specs, editing checklist,
and predicted performance metrics."
