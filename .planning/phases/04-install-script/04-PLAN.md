---
phase: 4
plan: 04-install-script
type: implementation
autonomous: true
requirements: [PKG-01, PKG-02, PKG-03, PKG-04]
---

# Phase 4 Plan: Replace install.sh with Correct, Idempotent Installer

## Objective

Rewrite install.sh to target `~/.claude/skills/` (the correct unified path for
both Claude Code and Claude Desktop) instead of the wrong paths
(`~/Library/Application Support/Claude/skills` and `~/.config/Claude/skills`)
used by the original script.

## Context

- Research confirms: correct path is `~/.claude/skills/` for all platforms.
- Each skill's installed directory name must match its `name:` frontmatter field
  (e.g. `skills/01-cinematic/` installs as `~/.claude/skills/higgsfield-cinematic/`).
- `shared/` must be installed as `~/.claude/shared/` so that the relative path
  `../../shared/` in SKILL.md files resolves correctly.
- Old script had bilingual Chinese comments and interactive overwrite prompts that
  break `--all` non-interactively.

## Tasks

### Task 1 — Write new install.sh

Replace install.sh with a clean English-only script that:

- Targets `~/.claude/skills/` for `--target code` and `--target desktop` (identical)
- Targets `./.claude/skills/` for `--target project`
- Reads `name:` frontmatter from each `skills/NN-slug/SKILL.md` for destination dir name
- Installs `shared/` alongside skills so path math resolves
- Supports `--all`, `--list`, `--target`, `-h/--help`, interactive default
- Is idempotent (removes dest dir before copy, no duplicate accumulation)
- Uses `set -euo pipefail`
- Prints a clear note for Windows instead of failing
- Has colored output

### Task 2 — Test

Verify with:
- `--list` shows all 15 skills with `higgsfield-*` names and descriptions
- `--all --target project` into a temp dir shows 15 skill dirs named from frontmatter
- Path math: `../../shared/` from a skill dir resolves to the shared dir
- Idempotency: running twice yields the same 15 dirs

### Task 3 — Planning files and commit

Write this PLAN.md and SUMMARY.md, then commit atomically.

## Success Criteria

- [ ] install.sh targets `~/.claude/skills/`
- [ ] Directory names come from `name:` frontmatter
- [ ] `shared/` installs adjacent to `skills/`
- [ ] All four flags work: `--all`, `--list`, `--target`, `-h`
- [ ] `--target project` installs to `./.claude/`
- [ ] Script is idempotent
- [ ] No bilingual/Chinese content remains
- [ ] All 15 skills list correctly with descriptions
