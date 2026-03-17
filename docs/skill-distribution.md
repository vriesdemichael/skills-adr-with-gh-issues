# Skill Distribution Guide

This repository uses **Agent Skills** as a portable standard, with `.agents/skills/*/SKILL.md` as canonical files.

## How skills are usually distributed

### 1) In-repo distribution (most common)
- Commit skills to each repository.
- Best when skills are project-specific and versioned with code.
- Path used here: `.agents/skills/<skill-name>/SKILL.md`.

### 2) Global user distribution
- Install skills in user-level directories for reuse across projects.
- Useful for personal workflows and common playbooks.
- Typical locations vary by tool (for example, user-level skills directories).

### 3) Shared baseline via template/submodule/subtree
- Keep a central skill repository and reuse it in many repos.
- Common patterns:
  - GitHub template repo
  - git submodule
  - git subtree
  - sync script in CI or bootstrap tooling

### 4) Plugin/package distribution
- Package skills as part of tool-specific plugins/extensions where supported.
- Useful for organization-wide rollout and lifecycle management.

## Recommended distribution strategy
1. Keep canonical skills in `.agents/skills`.
2. Add adapter files at repo root (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`) and Copilot instructions.
3. Reuse this repo as a template for new projects.
4. Optionally automate sync from a central skill source for org-wide consistency.

## Platform discovery notes
- **OpenCode:** discovers `.agents/skills` natively.
- **Claude Code:** skill-native format uses `SKILL.md`; adapter file `CLAUDE.md` helps route behavior.
- **GitHub Copilot:** uses `.github/copilot-instructions.md` and can also consume `AGENTS.md`/`CLAUDE.md`/`GEMINI.md` depending feature.
- **Gemini CLI:** uses `GEMINI.md`; skill-compatible layout can be referenced from there.
- **Codex CLI/Cloud:** uses `AGENTS.md` as compatibility entry point.
- **Antigravity:** treat `AGENTS.md` + `.agents/skills` as the portable baseline.

## Subskills and handoffs
- The base Skill format does not guarantee a universal, first-class handoff graph.
- Treat handoffs as a **portable workflow contract** written in each `SKILL.md`.
- Implement handoffs per platform:
  - Use native subagents/handoff APIs when available.
  - Otherwise emulate by explicitly executing the callee skill workflow and returning to caller flow.
- Keep handoff targets stable by skill name (for example: `read-adr`, `update-adr`).

## Versioning and release tips
- Version skills with semver tags if shared across repos.
- Keep breaking behavior changes in a changelog.
- Prefer additive updates to avoid disrupting existing agent workflows.
