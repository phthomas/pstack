---
name: ps-review
description: >
  pstack: step back and review the project's overall technical strategy and
  architecture. Use when I type /ps-review, at a milestone, before a big direction
  decision, or when I ask "are we on the right track", "review the architecture",
  "is this the right approach", or "sanity-check the strategy". Gives one complete
  overview of the current architecture, choices, and direction, then confirms what's
  sound and flags what's wrong with better alternatives. Technical and execution
  strategy only — not product ideation.
---

# Review the technical strategy and architecture

A periodic zoom-out audit: confirm we're on the right path, or flag what's wrong and recommend better alternatives. Scope is execution — architecture, technical choices, sequencing — not what product to build.

## Steps
1. Read the whole picture: PRODUCT.md (direction), CLAUDE.md (architecture, conventions), the docs/adr/ trail (decisions and their rationale), and survey the codebase structure (modules, boundaries, dependencies).
2. Produce ONE complete overview — the current architecture, the key technical choices, and the strategy as it stands. Concise; this is the snapshot.
3. Assess honestly. For each significant choice:
   - Confirm it if it's sound — say so plainly; don't manufacture problems to seem useful.
   - Flag it if it's risky or wrong — explain why, and recommend a concrete better alternative with its tradeoffs.
   Be a strong architect doing a real review, not a rubber stamp: willing to say "stay the course" and willing to say "this is the wrong call".
4. Prioritize the findings — what matters most, what's optional, what's fine as-is.
5. Don't apply changes yourself. Classify anything wrong by magnitude and point me to the right fix:
   - A detail or local choice -> /ps-revise (or /ps-clarify if it was never really decided).
   - A phase's goal -> /ps-spec re-open the phase (or split it via /ps-spec).
   - The product direction or architecture -> /ps-adr the why, then update PRODUCT.md / CLAUDE.md and /ps-spec the first phase of the new direction.
6. If I accept a recommendation that's a real decision, run /ps-adr to record it.
