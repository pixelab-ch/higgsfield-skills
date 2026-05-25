---
phase: 4
plan: 04-install-script
subsystem: tooling
tags: [install, skills, packaging, cli]
requirements: [PKG-01, PKG-02, PKG-03, PKG-04]
key-files:
  modified:
    - install.sh
  created:
    - .planning/phases/04-install-script/04-PLAN.md
    - .planning/phases/04-install-script/04-SUMMARY.md
decisions:
  - Both --target code and --target desktop resolve to ~/.claude/skills/ — same path, one install covers both Claude Code and Claude Desktop
  - Destination directory name is read from the `name:` frontmatter field, not derived from the source directory slug
  - shared/ installs as ~/.claude/shared/ (or ./.claude/shared/ for project) so the ../../shared/ relative links in SKILL.md resolve correctly
  - Idempotency achieved by rm -rf dest before cp -r, not rsync, to keep the script dependency-free
  - set -euo pipefail instead of just set -e for stricter error handling
metrics:
  duration: ~20m
  completed: 2026-05-25
  tasks_completed: 3
  files_changed: 1
---

# Phase 4 Plan 04: Install Script Rewrite — Summary

## One-liner

Replaced the broken install.sh (wrong Desktop-only paths) with a correct, idempotent
installer targeting `~/.claude/skills/` with frontmatter-driven destination naming and
co-located shared/ installation.

## What was built

### install.sh — full rewrite

The old script targeted `~/Library/Application Support/Claude/skills` (macOS) and
`~/.config/Claude/skills` (Linux). Neither path is read by Claude Code. The correct
unified path for both Claude Code and Claude Desktop is `~/.claude/skills/`.

**Key behaviors of the new script:**

1. **Correct install path (PKG-01):** `~/.claude/skills/` for all personal installs
   (`--target code` and `--target desktop` are identical).

2. **Shared directory install (PKG-02):** `shared/` is installed as `~/.claude/shared/`
   (or `./.claude/shared/` for project installs). Path math: a skill at
   `~/.claude/skills/higgsfield-cinematic/SKILL.md` resolves `../../shared/` to
   `~/.claude/shared/`. Both must share the same `~/.claude/` parent for the links to work.

3. **Flags and targets (PKG-03):**
   - `--all` — installs all 15 skills + shared/ non-interactively
   - `--list` — lists skills with `higgsfield-*` names and truncated descriptions
   - `--target code|desktop|project` — routes install destination
   - `-h/--help` — full usage with path documentation
   - Interactive default (no flags) — numbered menu with `all`/`cancel` support
   - Idempotent: `rm -rf <dest>` before `cp -r` on every install
   - Windows: prints manual path instructions and exits 0 (no failure)
   - `set -euo pipefail` throughout

4. **Project-scoped install (PKG-04):** `--target project` installs to `./.claude/skills/`
   and `./.claude/shared/` in the current directory. Committing `.claude/skills/` to VCS
   makes skills available to any teammate who opens the repo in Claude Code without
   running the install script.

5. **Frontmatter-driven naming:** Each skill's destination directory name is read from
   the `name:` field in its `SKILL.md` frontmatter. The parser handles both single-line
   (`name: higgsfield-cinematic`) and block-scalar (`description: >-` / `>` / `|` / `|-`)
   YAML values. This ensures e.g. `skills/01-cinematic/` installs as
   `~/.claude/skills/higgsfield-cinematic/`.

6. **English-only:** All bilingual Chinese comments and prompts from the old script
   have been removed.

## --list output (verified)

```
 1. higgsfield-cinematic               Crafts film-grade cinematic video prompts for Higgsfield and routes...
 2. higgsfield-3d-cgi                  Crafts 3D CGI and rendered video prompts for Higgsfield and routes ...
 3. higgsfield-cartoon                 Crafts cartoon and animation style video prompts for Higgsfield and...
 4. higgsfield-comic-to-video          Animates comic panels, manga pages, webtoons, illustrated storyboar...
 5. higgsfield-fight-scenes            Crafts fight scene and action sequence video prompts for Higgsfield...
 6. higgsfield-motion-design-ad        Crafts high-converting motion design advertisement video prompts fo...
 7. higgsfield-ecommerce-ad            Crafts high-converting e-commerce product advertisement prompts for
 8. higgsfield-anime-action            Generates anime-style video from a user-supplied reference frame us...
 9. higgsfield-product-360             Generates product 360° turntable, multi-angle showcase, and product...
10. higgsfield-music-video             Generates music video and beat-synced visual content prompts for Hi...
11. higgsfield-social-hook             Crafts viral social media hook video prompts for TikTok, Instagram ...
12. higgsfield-brand-story             Crafts emotionally resonant brand storytelling video prompts for Hi...
13. higgsfield-fashion-lookbook        Crafts fashion lookbook and model showcase video prompts for Higgsf...
14. higgsfield-food-beverage           Crafts production-grade food and beverage video prompts for Higgsfi...
15. higgsfield-real-estate             Crafts real estate, architecture, and interior design showcase vide...

15 skills available
```

## Requirements coverage

| Requirement | Status | Notes |
|-------------|--------|-------|
| PKG-01 | DONE | ~/.claude/skills/ for code and desktop targets |
| PKG-02 | DONE | shared/ installed as ~/.claude/shared/; path math verified |
| PKG-03 | DONE | --all, --list, --target code/desktop/project, interactive, -h/--help, idempotent, macOS+Linux, Windows note |
| PKG-04 | DONE | --target project → ./.claude/skills/ + ./.claude/shared/; documented in --help |

## Deviations from Plan

None — plan executed exactly as written.

The old script had one additional interactive pattern (asking "overwrite? y/n" per-skill)
that was removed in favor of unconditional idempotent copy. This is an improvement: the old
behavior broke `--all` if any skill was already installed and stdin was not a terminal.

## Self-Check: PASSED

- install.sh exists and is executable
- --list shows 15 skills with higgsfield-* names from frontmatter
- --all --target project into temp dir: 15 dirs named from frontmatter, shared/ adjacent
- Path math verified: ../../shared/ from a skill dir resolves to .claude/shared/
- Idempotency verified: two consecutive installs yield identical 15-skill result
- No Chinese content remains in install.sh
