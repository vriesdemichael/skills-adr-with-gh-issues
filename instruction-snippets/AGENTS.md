# Agent Entry Point

This repository uses **Agent Skills** as the source of truth.

Primary skill location:
- `.agents/skills/*/SKILL.md`

Available workflow skills:
- `create-adr-structure`
- `read-adr`
- `update-adr`
- `github-issue-orchestrator`

## Operating model
- Load and follow relevant skill instructions before implementation.
- Prefer native multi-agent/subagent research for independent explorations.
- Prefer native TODO/plan tooling for multi-step work.
- Prefer native ask-question tooling when missing information blocks progress.
- Keep progress updates concise and milestone-based.

## Handoff model
- Skills define a **portable handoff contract** in plain language.
- If platform-native handoff/subagent features exist, use them.
- If native handoffs do not exist, emulate handoff by:
  1. completing the target skill workflow,
  2. returning control to the caller skill,
  3. reporting the transition explicitly.

## ADR policy (optional)
- If your project uses ADRs, read ADR constraints first and gate completion on ADR-defined DoD.
- If ADRs are missing but required, initialize ADR structure before implementation.

## Tooling expectations by platform
- **GitHub Copilot (CLI / coding agent):** use repository instructions + agent files + native planning/tools.
- **Gemini CLI:** use `GEMINI.md` plus skill discovery from `.agents/skills` when available.
- **Codex CLI/Cloud:** use `AGENTS.md` and Agent Skills structure.
- **OpenCode:** `.agents/skills` is natively discoverable via skill tool.
- **Antigravity:** use `AGENTS.md` as primary compatibility surface; load skills from `.agents/skills` when supported.

## Notes
- Keep this file concise; put detailed behavior in skills.
