# ADR with GitHub Issues — Agent Skills

A set of AI agent skills for governing software projects with [Architecture Decision Records (ADRs)](https://adr.github.io/) and automating GitHub issue delivery end-to-end.

## Install

```
npx skills add vriesdemichael/skills-adr-with-gh-issues
```

This installs all six skills in one command — they are co-located in this repo intentionally, since they depend on each other. The `skills` CLI does not support inter-skill dependency resolution, so installing them individually from separate repos would require manual coordination. Install from this repo and you get the full set.

Skills are copied into your project's agent skills directory (e.g. `.agents/skills/` for OpenCode, `.claude/skills/` for Claude Code). Works with any agent that supports the [agentskills.io](https://agentskills.io) standard.

## What it does

These skills teach your AI agent a governance-first workflow: no code gets written until architectural decisions are in place, and no issue is closed until branch, commit, and PR conventions are satisfied.

### Skills overview

```
github-issue-orchestrator        ← entry point: planning and delegation only
├── read-adr                     ← reads ADR files, derives definition of done
├── create-adr-structure         ← bootstraps ADR governance for new projects
├── update-adr                   ← edits or supersedes existing ADR records
├── [implementation agent]       ← write-access agent, receives plan only
└── validate-and-finalize        ← DoD gate and finalization coordinator
    └── git-conventions          ← leaf: branch, commit, PR operations
```

### Workflow summary

1. **ADR first** — the orchestrator reads existing ADRs and derives a Definition of Done before any planning begins. If no ADRs exist, it asks whether to create them.
2. **Plan and confirm** — the orchestrator breaks the issue into independently deliverable units, presents the plan and DoD to the user, and waits for confirmation.
3. **Delegate implementation** — each unit is handed off to a write-access implementation agent with the plan and architectural constraints only. Git and PR conventions are never passed to the implementation agent.
4. **Validate and finalize** — after each unit, `validate-and-finalize` checks branch naming, commit format, CI status, PR readiness, and all DoD criteria. It delegates the actual git/GitHub operations to `git-conventions`.
5. **Loop as needed** — the orchestrator handles replanning, user steering mid-flight, blocked implementations, and multi-PR delivery natively.

### Supported agents

All skills use `compatibility: universal` and follow the agentskills.io SKILL.md format. Compatible with Claude Code, OpenCode, GitHub Copilot, Cursor, Windsurf, Goose, and any other agent that supports SKILL.md.

## Requirements

Your project needs an ADR directory at `./docs/decisions/` with a `README.md` describing your ADR format and validation rules. If you don't have one, the `create-adr-structure` skill will set it up interactively.

## License

MIT
