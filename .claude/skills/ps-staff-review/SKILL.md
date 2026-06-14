---
name: ps-staff-review
description: >
  pstack: staff-engineer code review focused on simplicity and readability. Use when
  I type /ps-staff-review, after building and before /ps-close, or when I ask "review
  my code", "is this clean", "code review", or "can this be simpler". Reviews a diff,
  branch, or file against a minimalist, readable-first standard and recommends
  concrete simplifications. Does not rewrite silently.
---

# Staff-engineer code review (simplicity and readability first)

My standard: minimalist, clean, simple, readable. Cleverness that hurts readability is a defect, not a flourish — and the best code is often less code. Review the work against that bar.

## What to review against
1. Simplicity — is this the simplest thing that works? Flag unnecessary abstraction, premature generalization, and speculative flexibility (YAGNI). Always ask: can this be simpler, or removed entirely?
2. Readability — would a new engineer understand it in one pass? Check names, function size, and obvious control flow. Flag dense one-liners and clever tricks that hide intent.
3. Deletability — flag dead code, redundancy, and needless layers or indirection.
4. Consistency — does it match the stack and conventions declared in CLAUDE.md?
5. Correctness — note any obvious bug or unhandled edge case, lightly; the tests carry most of this.

## How to review
- Look at the diff, branch, or file I point you at (default: the current branch's diff).
- Defer formatting and lint nits to tooling — focus on design, simplicity, and readability judgment, the way a staff engineer would.
- Give prioritized findings: must-fix, worth-considering, skip-it. For each, show the concrete simplification, not vague advice.
- Confirm what's already clean. If it's good, say so and ship it — don't invent problems.
- Don't rewrite silently. Propose the changes; I approve before you apply them.
