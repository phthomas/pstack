---
name: ps-build
description: >
  pstack: build a phase hands-on — tests first, then implement to green through
  the mechanical gate, paused for steering. Use when I type /ps-build, or say
  "build it", "implement this", "build phase 2", "write the tests", or "start
  coding". Reads the phase's spec in specs/, resolves its open questions with
  me, turns its acceptance criteria (and performance budgets) into red tests,
  implements to green, gates with formatter/typecheck/tests, then offers the
  /ps-review panel. For autonomous builds use /ps-dormammu.
---

# Build a phase, hands-on

The interactive gear: one phase, built together, tests first, paused so I can steer. Default to the phase in progress in ROADMAP.md (or the next planned one); or the piece I point you at.

## Steps
1. Read the context: the phase's spec in specs/ (requirements, acceptance criteria, budgets, hardstop), CLAUDE.md (stack, test framework, conventions, the readability bar, the decisions-and-pushback rule — and `## Capabilities`: who provides review, docs, browser here, and what's absent), and PRODUCT.md (what matters).
2. Close this phase's open questions — here, not in a separate step. If the spec has [OPEN: ...] markers, or criteria too vague to test, ask me now: batched, each with a recommended default and its tradeoff (AskUserQuestion on Claude Code; plain text elsewhere). Take anything I pre-answered in the invocation as decided. Write the resolutions into the spec and drop the markers.
3. Tests first, from the criteria: for each checkable acceptance criterion not yet covered, write one test named so the criterion is obvious, in CLAUDE.md's framework. A performance budget is a criterion — write the failing benchmark. A UI criterion is a criterion — write the Playwright check. Cover the edge cases the criteria imply — not every theoretical one; keep the suite proportional to the phase. If the criteria changed since tests were last written (say, after /ps-spec), reconcile the tests to the spec. Run them RED, then pause and show me: the red tests are the executable definition of "done", and this is my cheapest chance to correct it — before any code exists.
4. Implement to green, incrementally: build the smallest piece that turns a red test green, run the tests, tick the criterion in the spec, move to the next. Simplest thing that works; less code over more; build only what the phase asks — no gold-plating (if a parsimony skill like ponytail is installed, its bar applies as you write). When a criterion leans on a fast-moving library's API, climb the docs ladder instead of trusting memory: (1) read the installed source — the package in the project's venv or node_modules is version-exact by construction; (2) official docs via websearch + webfetch, official domains preferred; a docs CLI is optional convenience, never load-bearing. Nothing reachable — then say plainly which calls are unverified. If I steer somewhere materially risky, push back once with the specific risk and a better option; then respect my call.
5. Gate with the machine before any human or panel attention: formatter, strict typecheck, the phase-scoped tests, the budgets — loop until clean. Never spend review attention on code that doesn't typecheck.
6. Pause at meaningful checkpoints to show progress and let me redirect. This is a collaboration — don't try to one-shot the phase.
7. When every criterion passes the gate, offer /ps-review on the phase diff — the panel (correctness per surface, parsimony, product, security if triggered) in fresh contexts, findings to me as must-fix / worth-considering / skip-it. Then set the phase to done in ROADMAP.md and hand off to /ps-close.
