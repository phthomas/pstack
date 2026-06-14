---
name: ps-build
description: >
  pstack: kick off implementation of a piece of one phase. Use when I type /ps-build,
  after /ps-test, or when I say "build it", "implement this", "build phase 2", or
  "start coding this part". Reads the phase's spec file in specs/, runs the tests red,
  and implements to green incrementally. It builds one phase, interactive and paused
  for steering — for autonomous builds use /ps-dormammu-phase (one phase) or
  /ps-dormammu-magic (whole product).
---

# Build a piece of one phase

Kick off implementation against one phase. By default the phase that's in progress in ROADMAP.md (or the next planned one); or build the piece I point you at. The coding continues conversationally from there — don't try to one-shot the phase.

## Steps
1. Read the context: the phase's spec file in specs/ (its requirements, acceptance criteria, hardstop), CLAUDE.md (stack, conventions, the readability-first bar, the decisions-and-pushback rule), and PRODUCT.md (what matters). If that spec file still has `[OPEN: ...]` markers, stop and tell me to run /ps-clarify first.
2. Run the relevant tests so we can see them fail — that red is the target. (They come from /ps-test.)
3. Implement to green, incrementally:
   - Build the smallest piece of behaviour that turns a red test green, then move to the next. Run the tests after each step, and tick the criterion in the phase's spec file as it goes green.
   - Follow CLAUDE.md's conventions and the readability-first standard: the simplest thing that works, less code over more.
   - Build only what this part of the phase asks for — don't gold-plate or expand scope. If you hit a real decision the spec didn't settle, flag it (consider /ps-clarify) rather than guessing.
   - Apply the decisions-and-pushback rule: if something I asked for is risky or wrong, push back once with the specific reason; otherwise proceed.
4. Pause at meaningful checkpoints to show progress and let me steer. This is a collaboration, not an autonomous run.
5. When the phase's acceptance criteria all pass, set its status to done in ROADMAP.md, then hand off to /ps-staff-review and /ps-close.
