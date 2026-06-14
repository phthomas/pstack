---
name: ps-test
description: >
  pstack: write tests from a phase's acceptance criteria. Use when I type /ps-test,
  after the spec is clarified, or when I say "write the tests", "add tests for this",
  or "turn the criteria into tests". Reads the phase's spec file in specs/ and writes
  tests in the framework named in CLAUDE.md. Defaults to the current/next phase; can
  scaffold more.
---

# Generate tests from acceptance criteria

Turn the acceptance criteria in a phase's spec file into executable tests, in the framework declared in CLAUDE.md (pytest / go test / vitest / cargo test / ...).

## Steps
1. Read CLAUDE.md for the test framework and conventions, and the phase's spec file in specs/ for its acceptance criteria. Default to the phase in progress (or the next planned); if I ask, scaffold tests for later phases too — but expect /ps-build or the dormammu skills to refine them as interfaces emerge.
2. Write one test per checkable acceptance criterion — the executable form of "done". Name them so the criterion is obvious.
3. Tests should start red (the behaviour isn't built yet). That red is the build target.
4. Cover the obvious edge cases the criteria imply, not every theoretical one.
5. Don't chase coverage or test trivia. Keep the suite proportional to the phase.
6. Hand off: /ps-build (interactive), /ps-dormammu-phase (one phase, autonomous), or /ps-dormammu-magic (whole product).
