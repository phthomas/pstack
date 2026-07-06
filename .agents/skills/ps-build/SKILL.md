---
name: ps-build
description: >
  pstack: build a phase hands-on — tests first, then implement to green, paused
  for steering. Use when I type /ps-build, or say "build it", "implement this",
  "build phase 2", "write the tests", or "start coding". Reads the phase's spec
  in specs/, resolves its open questions with me, turns its acceptance criteria
  into red tests, then implements to green incrementally. For autonomous builds
  use /ps-dormammu.
---

# Build a phase, hands-on

The interactive gear: one phase, built together, tests first, paused so I can steer. Default to the phase in progress in ROADMAP.md (or the next planned one); or the piece I point you at.

## Steps
1. Read the context: the phase's spec in specs/ (requirements, acceptance criteria, hardstop), CLAUDE.md (stack, test framework, conventions, the readability bar, the decisions-and-pushback rule), and PRODUCT.md (what matters).
2. Close this phase's open questions — here, not in a separate step. If the spec has [OPEN: ...] markers, or criteria too vague to test, ask me now: batched, each with a recommended default and its tradeoff (AskUserQuestion on Claude Code; plain text elsewhere). Take anything I pre-answered in the invocation as decided. Write the resolutions into the spec and drop the markers.
3. Tests first, from the criteria: for each checkable acceptance criterion not yet covered, write one test named so the criterion is obvious, in CLAUDE.md's framework. Cover the edge cases the criteria imply — not every theoretical one; keep the suite proportional to the phase. If the criteria changed since tests were last written (say, after /ps-spec), reconcile the tests to the spec. Run them RED, then pause and show me: the red tests are the executable definition of "done", and this is my cheapest chance to correct it — before any code exists.
4. Implement to green, incrementally: build the smallest piece that turns a red test green, run the tests, tick the criterion in the spec, move to the next. Simplest thing that works; less code over more; build only what the phase asks — no gold-plating. If I steer somewhere materially risky, push back once with the specific risk and a better option; then respect my call.
5. Pause at meaningful checkpoints to show progress and let me redirect. This is a collaboration — don't try to one-shot the phase.
6. When every criterion passes, set the phase to done in ROADMAP.md and hand off to /ps-close.
