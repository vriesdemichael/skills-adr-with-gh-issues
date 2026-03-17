# Claude Code Compatibility

Use `.agents/skills/*/SKILL.md` as the canonical workflow source.

Skills in this repository:
- `create-adr-structure`
- `read-adr`
- `update-adr`
- `github-issue-orchestrator`

Execution preferences:
- Use subagents for parallel read-only research when tasks are independent.
- Use TODO/plan tracking for non-trivial work.
- Use question prompts only when ambiguity blocks execution.
- If ADR policy exists, apply ADR constraints before completion.
- Follow skill-defined handoff conventions; use native subagents when possible, otherwise emulate handoff via explicit next-skill execution.

