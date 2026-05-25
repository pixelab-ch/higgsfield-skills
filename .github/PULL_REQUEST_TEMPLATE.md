<!-- Thanks for contributing to higgsfield-skills! -->

## What does this PR do?

<!-- One or two sentences. Link any related issue with "Closes #123". -->

## Type of change

- [ ] New skill
- [ ] Fix to an existing skill (model routing, specs, prompt content)
- [ ] Shared infrastructure (`shared/`), installer, or docs
- [ ] Other (describe below)

## Checklist

- [ ] `SKILL.md` body is **≤ 500 lines**; encyclopedic content lives in one-level-deep `references/*.md`
- [ ] Frontmatter follows [`shared/skill-template.md`](../shared/skill-template.md) — `name` is lowercase-hyphens and unique, `description` is third-person with a **"Use when…"** trigger clause
- [ ] Model specs come from `higgsfield:models_explore` — **no invented** resolutions/formats/fps; `references/model-specs.md` carries a `verified: models_explore <date>` annotation
- [ ] Generation stays **opt-in** — gated behind explicit user confirmation per [`shared/generation-flow.md`](../shared/generation-flow.md); the skill never auto-generates
- [ ] `allowed-tools` lists exactly the `mcp__higgsfield__*` tools the body actually uses (`higgsfield:tool` in prose, `mcp__higgsfield__tool` in frontmatter)
- [ ] All relative links resolve; the skill loads in Claude Code

## Notes for reviewers

<!-- Anything the reviewer should know: trade-offs, open questions, screenshots. -->
