---
name: ps-close
description: >
  pstack: close out a phase, or a whole autonomous build, and make the ship
  call. Use when I type /ps-close, when work is done and tests pass, or when I
  say "ship it", "wrap up", "let's merge", "close this out", or "review my
  code" at the end of a phase. Verifies criteria against the tests, reviews the
  diff for completeness and simplicity, records missing ADRs, checkpoints
  STATE.md, then guides the merge — which is mine.
---

# Close out (phase or product)

The human-owned ship gate. Run when a phase — or a whole /ps-dormammu run — looks done.

## Steps
1. Verify: every acceptance criterion for what's being closed is ticked in its spec AND the tests actually pass — run them; don't trust the checkboxes. For a whole-product close after a dormammu run, cover every phase it built, starting from the report's flagged items. Anything outstanding: stop and tell me.
2. Review the diff before merge — ideally in fresh context or a subagent — against two bars:
   - **Complete**: the diff satisfies each phase spec — nothing missing, nothing beyond scope.
   - **Clean**: simplicity (the simplest thing that works — flag unnecessary abstraction, premature generalization, speculative flexibility), readability (a new engineer follows it in one pass — flag dense one-liners and cleverness that hides intent), deletability (no dead code, redundancy, or needless layers), consistency (matches CLAUDE.md). Cleverness that hurts readability is a defect, and the best fix is often less code.
   Report findings as must-fix / worth-considering / skip-it, each with the concrete simplification. Confirm what's already clean — don't invent problems. Apply fixes only with my OK, then re-run the tests.
3. If this work involved a significant or architectural decision that isn't recorded, run /ps-adr for each.
4. Run /ps-checkpoint to overwrite STATE.md with the handoff.
5. Guide the git steps: a clean history, then merge the branch or open the PR, and tag if it's a release. The merge is mine. Don't re-narrate the changes in prose — the diff and the commit messages are the record.
6. Confirm ROADMAP.md and the spec statuses match reality (the build skills mark phases done as they finish; fix any drift). Point me at the next phase, or say the product is done.
