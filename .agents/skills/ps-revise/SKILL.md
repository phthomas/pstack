---
name: ps-revise
description: >
  pstack: revise the current phase spec in specs/ mid-phase when a hypothesis turns out wrong
  or the direction changes. Use when I type /ps-revise, or say "this approach isn't
  working", "let's change direction", or "the spec was wrong". This is the iterative
  escape hatch — not a failure.
---

# Revise the spec mid-phase

The spec is a hypothesis; execution is allowed to correct it. Revising is the workflow working, not failing.

## Steps
1. Capture what we learned that invalidates the current spec.
2. Update the phase spec file in specs/: revise its requirements and acceptance criteria to match the new direction. Add [OPEN: ...] markers if the change opens new questions — then close them with /ps-clarify.
3. Judge the size of the change:
   - Small course-correction -> just update the phase spec in specs/ and keep going.
   - A real architectural or directional decision -> also run /ps-adr to record why we changed, and if it shifts the product direction, propose a PRODUCT.md update.
4. Note the change in STATE.md's "In flight" so the next session knows the direction moved.
5. If acceptance criteria changed, re-run /ps-test for the new ones.
