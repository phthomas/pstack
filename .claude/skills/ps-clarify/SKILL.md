---
name: ps-clarify
description: >
  pstack: close the open questions in the phase specs so the product is fully specced
  before building. Use when I type /ps-clarify, after /ps-bootstrap, or when I say
  "clarify the open items", "resolve the open questions", or "tighten the spec". By
  default it closes [OPEN: ...] markers across ALL phase spec files in specs/; point
  it at one phase to scope it.
---

# Clarify the open questions

Resolve the undecided items so a build — especially an unattended /ps-dormammu-magic run over the whole product — isn't guessing. Works on the spec files in specs/.

## Steps
1. Scan the spec files in specs/ for `[OPEN: ...]` markers and anything underspecified in Requirements or Acceptance criteria. By default cover every phase; if I name a phase, scope to its spec file.
2. For each open item, first reason about it briefly — the realistic options and a recommendation — then ask me to decide. Group questions; use AskUserQuestion for the multiple-choice ones. Don't bury me; batch sensibly.
3. If I pre-answer items in my invocation ("/ps-clarify use DuckDB for storage because X"), take those as decided and only ask about the rest.
4. Write the resolutions back into the right phase's spec file: turn each [OPEN:] into a concrete requirement or acceptance criterion, and remove the marker. Sharpen vague criteria into checkable ones.
5. When no spec file has open markers left, say so. Hand off to /ps-test, then /ps-dormammu-magic (whole product), /ps-dormammu-phase (one phase), or /ps-build (interactive).
