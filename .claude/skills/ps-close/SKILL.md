---
name: ps-close
description: >
  pstack: close out a phase, or a whole autonomous build, and make the ship
  call. Use when I type /ps-close, when work is done and tests pass, or when I
  say "ship it", "wrap up", "let's merge", "close this out", or "review my
  code" at the end of a phase. Verifies criteria against the tests, runs the
  /ps-review panel over the diff, records missing ADRs, checkpoints STATE.md,
  then guides the merge — which is mine.
---

# Close out (phase or product)

The human-owned ship gate. Run when a phase — or a whole /ps-dormammu run — looks done.

## Steps
1. Verify: every acceptance criterion for what's being closed is ticked in its spec AND the tests actually pass — run them (budgets included); don't trust the checkboxes. For a whole-product close after a dormammu run, cover every phase it built, starting from the report's flagged and parked items. Anything outstanding: stop and tell me.
2. Land order — runs land one at a time: if main has moved since this run branched (another run closed first), merge main into the run branch now, before any review. ROADMAP.md merges as a union of rows — each run is authoritative for its own phases' statuses; never delete another run's rows. STATE.md is never hand-merged: take either side, it gets regenerated in step 5. Re-run the full suite after the merge; a red suite here is integration debt this run pays before it ships.
3. Review the diff before merge: run /ps-review over everything being closed — weighted by what already ran. Phases that each passed this run's panel with zero must-fixes get ONE integrated fresh-context judge over the final tree: product intent and parsimony across the whole, correctness only where the phases meet. Unreviewed, parked, or flagged work gets the full panel. The bars are /ps-review's — complete against each phase's spec and PRODUCT.md's intent, clean, correct per surface, secure where triggered. Findings come back as must-fix / worth-considering / skip-it with the concrete fix; what's already clean gets said too. Apply fixes only with my OK, then re-run the tests.
4. If this work involved a significant or architectural decision that isn't recorded, run /ps-adr for each.
5. Run /ps-checkpoint to overwrite STATE.md with the handoff.
6. Guide the git steps: a clean history, then merge the branch or open the PR, and tag if it's a release. The merge is mine. After it lands, note which parked phases in other runs (or in this ROADMAP) just became unblocked — their dependency now lives on main. Don't re-narrate the changes in prose — the diff and the commit messages are the record.
7. Confirm ROADMAP.md and the spec statuses match reality (the build skills mark phases done as they finish; fix any drift). Point me at the next phase, or say the product is done.
