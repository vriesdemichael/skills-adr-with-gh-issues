---
name: read-adr
description: Read all ADR files, classify relevance, and derive a definition of done for branch and PR readiness.
license: MIT
compatibility: universal
metadata:
  domain: adr
  role: reader
---

# Goal
Provide ADR context for a task and produce an explicit Definition of Done (DoD).

# Full-scan requirement
- On every invocation, read the complete ADR set before producing any answer.
- Do not cherry-pick specific ADR files, requested filenames, or obviously related records as a shortcut.
- Query relevance classification happens only after the full ADR set has been read.
- If the caller asks about a specific area, still read all ADRs first and then filter in the output.
- A partial ADR read is an invalid execution of this skill.

# ADR discovery
- Look in `./docs/decisions/` first.
- Read `./docs/decisions/README.md` when present so ADR format, status semantics, and supersession rules are interpreted correctly.
- If missing, search for `ADR`, `Architecture Decision Record`, or `decisions`.
- If no ADR exists, immediately report that the repository has no ADR.

# Handoff conventions (portable)
- If no ADR exists and downstream work requires ADR governance, signal handoff to `create-adr-structure`.
- If ADR exists but lacks clear DoD and caller requires PR readiness gating, signal handoff to `update-adr` (or demand user-defined DoD first).
- Prefer native subagent/handoff tooling where available; otherwise return explicit next-skill recommendation in plain output.

# Execution requirements
1. Discover the full ADR corpus for the repository before analyzing relevance.
2. Read every ADR record in that corpus on every invocation; do not stop after finding a seemingly relevant subset.
3. Prefer parallel subagent/research execution where available.
4. For each ADR, determine:
   - still relevant or superseded/deprecated/rejected
   - relation to the query
   - always-relevant project constraints
   - development-workflow relevance
   - DoD constraints for branch/PR lifecycle
5. Resolve output relevance only after all ADRs have been classified.
6. If any ADR file could not be read, report the read failure explicitly instead of silently continuing with a partial set.

# Output format
Provide:
1. ADRs specifically relevant to the query
2. ADRs always relevant for the project
3. Definition of Done in this structure:

## Rules for PRs
### You may open a PR when:
- ...

### A PR is ready for human review when:
- ...

### A PR may be merged, auto-merged or auto-rebased when:
- ...

If the ADRs do not define a clear DoD, explicitly report that.
