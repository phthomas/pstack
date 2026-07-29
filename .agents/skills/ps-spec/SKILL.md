---
name: ps-spec
description: >
  pstack: change the plan — add a phase, revise or re-open one, reorder the
  phases, or correct the current phase mid-build when a hypothesis turns out
  wrong. Use when I type /ps-spec, or say "add a phase", "re-open phase 2",
  "reorganize the phases", "cut phase 3", "this approach isn't working",
  "let's change direction", or "the spec was wrong". Edits ROADMAP.md and
  specs/ together so they stay consistent. Revising is the workflow working,
  not failing.
---

# Change the plan (add / revise / re-open / reorder)

/ps-start specs the whole product; this changes that plan afterwards. The spec is a hypothesis — execution is allowed to correct it.

## Steps
1. Take my intent. Too vague to scope? Ask a few targeted questions with recommended defaults (AskUserQuestion on Claude Code; plain text elsewhere) — this skill closes its own ambiguity. If the change is bigger than a sentence or two can carry — a pile of ideas, a v2 — send me to dump.md + /ps-start instead, which extends the plan from a fresh dump.
2. Apply the mechanics, keeping ROADMAP.md and specs/ consistent:
   - **Add**: create specs/NN-name.md from specs/_TEMPLATE.md (or match the shape of the existing specs) and add its ROADMAP row (status, in-MVP, spec link), numbered in order.
   - **Revise / re-open**: update the phase's spec — requirements and acceptance criteria — and set its ROADMAP status (e.g. back to in progress). For a mid-build correction, first write down what we learned that invalidated the spec, then revise it to match reality, and note the direction change in STATE.md's "In flight".
   - **Reorder**: renumber the spec files and the ROADMAP rows together — and any `Depends on:` lines that point at renumbered phases.
   - **Drop**: park the idea in BACKLOG.md rather than deleting it.
   - **While any run is live** (`ps/*` branches or sibling worktrees): append-only. Add phases with fresh numbers; never renumber or reorder, and don't revise a phase an active run is building — that correction goes through the run's morning report and a re-run, not through this file under its feet.
3. New uncertainty is fine: leave [OPEN: ...] markers — the build skills raise them when the phase starts. If criteria changed on a phase that already has tests, the next build pass reconciles the tests first.
4. Size the change: a real architectural or directional shift also gets /ps-adr (why we changed), and — with my OK — a PRODUCT.md or CLAUDE.md update.
