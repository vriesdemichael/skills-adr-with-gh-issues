# Copilot Repository Instructions

This repository is organized around portable **Agent Skills**.

## Source of truth
- Use `.agents/skills/*/SKILL.md` as canonical workflow instructions.

## Available workflow skills
- `create-adr-structure`
- `read-adr`
- `update-adr`
- `github-issue-orchestrator`

## Working style
- Use planning/TODO tooling for non-trivial work.
- Use parallel subagent/research where independent work can be parallelized.
- Use question tools only for true ambiguities that block progress.
- If ADR policy exists, apply ADR constraints before completion.
- Follow skill-defined handoff conventions; if native handoffs are unavailable, emulate by executing the target skill workflow and returning to caller flow.

