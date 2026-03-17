# Gemini Compatibility

Repository workflow is skill-based.

Canonical instructions live in:
- `.agents/skills/*/SKILL.md`

Available skills:
- `create-adr-structure`
- `read-adr`
- `update-adr`
- `github-issue-orchestrator`

Guidance:
- Prefer native planning/TODO features for multi-step tasks.
- Prefer native parallel research/subagents when available.
- Ask clarifying questions only when required to unblock execution.
- If ADR policy exists, respect ADR decisions before claiming completion.
- Follow skill-defined handoff conventions and emulate them explicitly if native handoff mechanics are unavailable.

