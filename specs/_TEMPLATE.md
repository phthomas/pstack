# Phase <n>: <name>

> The contract for this phase. Copy this file to `specs/NN-name.md` per phase. Phase-level status (planned/in progress/blocked/done) is tracked in ROADMAP.md; this file holds what to build and how "done" is checked. (`_TEMPLATE.md` is a template, not a real phase — it isn't listed in ROADMAP's table, so the build skills skip it.)

## Goal
<!-- One or two sentences: what this phase delivers and why. -->

## Coordination
<!-- OPTIONAL — delete the whole section (or any line) you don't need; no section = depends on the previous phase,
     default review weight and model tier (v1 behavior).
     Depends on: the phases that must land first ("none" allowed). /ps-dormammu builds the waves from this.
     A dependency is satisfied only when its phase is done AND landed on main (or built earlier in the same run) —
     so depending on a phase another run is still building parks this one until that run ships.
     Surface: the files/dirs this phase owns (globs). Two phases run in parallel only when both declare surfaces and they're disjoint. -->
- Depends on: <!-- e.g. 02, 03 — or none -->
- Surface: <!-- e.g. src/ingest/**, tests/ingest/** -->
- Complexity: <!-- OPTIONAL: hard — the builder runs on the deep model tier when CLAUDE.md maps model-tiers; absent = standard. "hard" means design judgment, novel algorithms, or prose craft — not merely big. -->
- Review: <!-- OPTIONAL: full — force the split review panel on this phase; absent = /ps-review's default weight (one combined judge). -->

## Requirements
<!-- What the phase must do, specifically. Leave [OPEN: ...] markers where undecided — don't guess. -->
-

## Acceptance criteria
<!-- This phase's checklist. Each becomes a test. Mark: [ ] todo, [x] done, [!] failing. Prefer verifiable: "ingest returns 900 rows with no null symbol" beats "works well". UI-facing criteria name their Playwright check the way backend criteria name their pytest. -->
- [ ]
- [ ]

## Performance budget
<!-- OPTIONAL — delete if this phase has none. Budgets are acceptance criteria: each becomes a failing benchmark test (pytest-benchmark, hyperfine) before any code, like every other criterion. Numbers, not adjectives. -->
-

## Hardstop / kill criteria
<!-- When to stop this phase and escalate instead of pushing on: a blocker that needs me, a missing dependency, or a sign it's the wrong bet. /ps-dormammu obeys these. -->
-

## Open questions
<!-- [OPEN: ...] items for this phase. The build skills raise them when the phase starts: /ps-dormammu at pre-flight, /ps-build before coding. Empty is good.
     A question a throwaway prototype answers better than the human can — "does this state model feel right?", "which UI shape?" — gets [OPEN-SPIKE: ...] instead: the builder answers it with the prototype craft skill (no craft capability installed = treated as ordinary [OPEN: ...]). -->
-

## Out of scope
<!-- What this phase deliberately does NOT do. -->
-
