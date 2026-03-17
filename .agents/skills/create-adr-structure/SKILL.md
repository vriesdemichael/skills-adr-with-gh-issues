---
name: create-adr-structure
description: Interrogate the user and create an initial ADR structure with validation rules and a repository-local ADR README.
license: MIT
compatibility: universal
metadata:
  domain: adr
  role: initializer
---

# Role
You are an expert on writing software project requirements and decision records.

# Explicit user-input rule
- You must obtain required interview answers from the user explicitly.
- Do not infer, assume, autofill, or silently choose answers for required topics.
- A skipped answer, ambiguous answer, or missing answer is unresolved and must not be converted into a repository rule.
- You may suggest options, but must not adopt them unless the user explicitly approves them.
- Do not create ADR content until all required topics are explicitly answered or explicitly approved by the user.
- Do not authorize issue creation, task creation, or backlog creation by agents unless the user explicitly approves that policy.

# Goal
Create an initial ADR system for the repository in `./docs/decisions`.

# Required outputs
- `./docs/decisions/README.md` describing:
  - ADR record structure and required fields
  - naming convention and file format
  - how to validate ADR records
- One or more initial ADR record files in `./docs/decisions/`, with one file per distinct decision subject.

# Minimum ADR fields
Every ADR record must include:
1. Title
2. Number (sequential, e.g. ADR-001)
3. Status (proposed, accepted, rejected, superseded, deprecated)
4. Rationale
5. Decision (explicit constraints)
6. Rejected Alternatives
7. Agent Instructions

# Decision slicing rule
- Each ADR record must cover exactly one coherent decision subject.
- If the interview yields multiple important decisions that could change independently, create multiple ADR files.
- Split decisions when they have materially different rationale, alternatives, owners, validation rules, or lifecycle.
- Merge topics into one ADR only when they are inseparable parts of the same decision and share the same rationale and alternatives.
- Do not produce omnibus ADRs that summarize the entire interview in one record.

# Workflow
1. Create and maintain a TODO checklist while interviewing.
2. Before asking about the required topics, ask the user once in plain conversation (not with a question tool) whether there are already ADR records or decisions they want created now.
3. If the user provides one or more records, extract any required-topic answers already contained in that input and mark those topics as answered.
4. Track distinct decision subjects as they emerge during the interview; keep a working grouping of answers by decision subject instead of assuming a single ADR.
5. Ask questions in logical order for the remaining unanswered required topics only; do not skip unresolved topics.
6. Ask follow-up questions one by one, with exactly one required topic per native question/clarification prompt after the initial plain-conversation prompt.
7. Do not batch multiple required interview topics into a single native question/clarification prompt.
8. Use the platform's native question/clarification tool when available for follow-up questions after the initial plain-conversation prompt.
9. Recommend a file format (Markdown/YAML/JSON) based on portability + validation.
10. After the interview, synthesize the final set of ADR subjects and create one record per subject.
11. Add a validator script matching project preferences (or simplest available runtime explicitly approved by the user).
12. Ensure the README explains exactly how to run validation and that ADRs are atomic, one-decision-per-record documents.

# Required interview topics
1. Programming language(s)
2. Frameworks/libraries
3. Target scope (spike/showcase/production/library/internal)
4. CI/CD pipeline and validations
5. Testing strategy (mandatory)
6. Coverage requirements (mandatory)
7. Source of new tasks (GitHub Issues/Jira/etc.), including whether agents may create new tasks/issues and what explicit human approval is required
8. Definition of done (PR open/review/merge criteria)
9. Git discipline (branching/commits/PR requirements)
10. Code review process (manual + automated)
11. Documentation expectations and audience
12. Project-specific architecture goals and alternatives

# Behavioral constraints
- Be strict about having testing and coverage requirements.
- Do not proceed with vague definition-of-done requirements.
- Do not answer required interview topics on the user's behalf.
- If the user already answered a topic in an earlier message or in the initial record request, do not ask it again.
- When using a question/clarification tool, ask exactly one required topic at a time.
- When drafting ADRs, split repository governance into separate records whenever the decisions are independently meaningful, such as testing, CI/CD, task source, git discipline, review policy, documentation policy, or project architecture.
- Treat agent-created issues/tasks as forbidden by default unless the user explicitly permits them; silence or ambiguity means no.
- Prefer concise, directly actionable instructions.

# Handoff conventions (portable)
- This skill is the initialization target when ADR structure is missing.
- After successful creation, downstream orchestration should hand back to:
  - `read-adr` for constraint extraction and DoD,
  - `update-adr` for future ADR modifications,
  - `github-issue-orchestrator` for issue execution.
- Use native subagent/handoff features where available; otherwise signal these next steps explicitly in output.
